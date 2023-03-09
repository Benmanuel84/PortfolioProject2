/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProject].[dbo].[Nashvillehousing]


  --Cleaning Data in SQL Queries

  Select*
  From Nashvillehousing

  --Standardize Date Format

  Select SaledateConverted, CONVERT(Date,SaleDate)
  From Nashvillehousing

  Update Nashvillehousing
  Set SaleDate = CONVERT(Date,Saledate)

  Alter Table NashvilleHousing
  Add SaledateConverted Date;

  Update Nashvillehousing
  set SaleDateConverted = Convert(Date,Saledate)

  --Populate Property Address Data

  Select *
  From Nashvillehousing
 -- Where PropertyAddress is null
 Order By ParcelID

   Select a.ParcelID, a.propertyAddress, b.parcelID, b.PropertyAddress, Isnull(a.propertyaddress,b.PropertyAddress)
  From Nashvillehousing a
  join Nashvillehousing b
  on a.ParcelID = b.ParcelID
  And a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null


  Update a
  set propertyAddress = Isnull(a.propertyaddress,b.PropertyAddress)
From Nashvillehousing a
  join Nashvillehousing b
  on a.ParcelID = b.ParcelID
  And a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null


--Breaking Out Address into Individual Columns (Address, city, State)


  Select
  Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) As Address 
  ,  Substring(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1, Len(propertyAddress)) As Address
  From Nashvillehousing


   Alter Table NashvilleHousing
  Add PropertySplitAddress Nvarchar(255);

  Update Nashvillehousing
  set PropertySplitAddress =  Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


   Alter Table NashvilleHousing
  Add PropertySplitCity NVarchar(255);

  Update Nashvillehousing
  set PropertySplitCity = Substring(PropertyAddress,  CHARINDEX(',', PropertyAddress) +1, Len(propertyAddress))

  Select*
  From Nashvillehousing

  Select OwnerAddress
  from Nashvillehousing


  Select
  PARSENAME(Replace(OwnerAddress, ',','.'), 3), 
  PARSENAME(Replace(OwnerAddress, ',','.'), 2),
  PARSENAME(Replace(OwnerAddress, ',','.'), 1)
  From Nashvillehousing



  
   Alter Table NashvilleHousing
  Add OwnerSplitaddress Nvarchar(255);

  Update Nashvillehousing
  set OwnerSplitAddress =   PARSENAME(Replace(OwnerAddress, ',','.'), 3)


   Alter Table NashvilleHousing
  Add OwnerSplitCity NVarchar(255);

  Update Nashvillehousing
  set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',','.'), 2)


  Alter Table NashvilleHousing
  Add OwnerSplitState NVarchar(255);

  Update Nashvillehousing
  set OwnerSplitState =  PARSENAME(Replace(OwnerAddress, ',','.'), 1)

  Select OwnerName
  From Nashvillehousing


  -- Changing Y and N To yes in "Sold as Vacant" Field

  Select Distinct(SoldAsVacant), Count(SoldAsVacant)
  From Nashvillehousing
  Group By SoldAsVacant
  Order by 2




  Select SoldAsVacant
  , Case when Soldasvacant ='y' then 'Yes'
         When SoldAsVacant = 'n' then 'No'
		 Else SoldAsVacant
		 End
From Nashvillehousing


Update Nashvillehousing
Set SoldAsVacant =
Case when Soldasvacant ='y' then 'Yes'
         When SoldAsVacant = 'n' then 'No'
		 Else SoldAsVacant
		 End


-- Removing Duplicates

WITH RowNumCTE As(
Select *,
Row_Number() Over(
PARTITION By ParcelID,
             PropertyAddress,
			 SalePrice,
			 Saledate,
			 LegalReference
			 order By 
			   uniqueID
			   ) Row_num

From nashvilleHousing
)
Select *
From RowNumCTE
Where Row_num > 1
Order By PropertyAddress




--Deleting Columns


Select*
From Nashvillehousing

Alter Table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table NashvilleHousing
Drop Column SaleDate