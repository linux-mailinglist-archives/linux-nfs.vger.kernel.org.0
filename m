Return-Path: <linux-nfs+bounces-17448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E67CF400A
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B620C3000EAA
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C3330B20;
	Mon,  5 Jan 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gbmu+K9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD007330335
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621651; cv=fail; b=bRmbDKVTCjT2809S18QTMd/LIKLF1qLmGJJO6uJfugmIw/0DgjqLR+G6ZVAiOqUx0IKhQb+weOI3K+K1EpZpx2o0C7sDGIi8Y/cd1v+uHps1CjNkqLtTI1Wwh7NgCpG0QblMpchE8ZwO9ltTh9JYIXmh5SmWHUXMe2G+bmEJQ9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621651; c=relaxed/simple;
	bh=1YZ9QpqmX6W4379CCY8s+zCq/8POss7Rep+KaXxoFWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+Flm3vhJys1UpcNsGqy1bEFGLCb1QJi3FkJh/arDqjBGPRboguY1ZLFUhyx55t/RzuPkmcERtoVyjy/aTtDkB2lr6j8ststCiu6GwWiCpaZ6XBXfy9moWvigFgOQ2nkHgXG7uMvTsGch72VMSeDpZimGmL6kwBSF6+w3Nmfurw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gbmu+K9u; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU6pv8ewDsC/6G88so2y8KxYvb3OKGO7QNtZfh/3qNDmaBjyRpUIvC5ZyU61iFE6p5l6aCv8Qzirecpg9TgA6pGUmM6b7XKqft2AEBeJBR2VGa9uMiSf1PFLw1qguyvljjcZ8+huNcUtQyW6LZA429JzTii9MhJp/1zw+aGB9UC8d5kNmK0mYMEd3w0KQmzRy7K9I5VDaK3zS1RmKDqGRaz7X4+eNTzlLn7x4Di+OvoljfcBFHABjgjGaRhQU2JwDocqSjZUdVdWe9KVIp8+9WzRDQhu56Knb2yKxw+lmH6Ja4LTKbjPCAK10bwbaj/FIKOapuXlP7L61oSF0wtXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0C7fmcI08aAzOkDpP8ZQ7vDDw0GEUtR+KTmM33jJTU=;
 b=x/6QJ94VbUgE372nj17xL4zDOpYy/c0borXjY5uxvSeKnEbN1H5S80CWdZDkovXgYWxLBDemXfbJaF9Et0u+t7M2K/2wxkzfAx2zrtOU+h+G+SV+HNutNx1pGfJ5F9UVjXf7lR4wTk7bX1nZRWq/ZU4I81t4XWHYm3Efo+mnLoogri2DkQlz8eM8B/nVBOReNi0XgJ9vlWHg1Suad1nl8sXPQ0i10XDceEPfbWlb0CF+iEYOqH+CwDy0DWXf0jdqcv9IewDpd2O2Sqb3MDdoWwCvMmscB/kRvTfxTjKQ8skMCyZUKJ4vA7Vaz0KT5dCtRFYK5ot6mPyToK4/1XhhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0C7fmcI08aAzOkDpP8ZQ7vDDw0GEUtR+KTmM33jJTU=;
 b=gbmu+K9uGSVGOK/A8isNpBF2RzQI3aQz/+gomoope4Uj5KDVfSZk8JbfXKtRr1GGc8evPj7odBlKhDr+i71XBZV2BP90/tbU9XeT+6hSvuNMvfhpJgh/onlu0eNM8G8zAJwbUCIypyleijQ/wQ5z2rMJ2w1R2B0UFbSoOCmyy9sq++HIdPUUBzlpUZhOm+M2zzGYRi0AKkxbYvPjQ4yFgWWZ2qWINhVQEfFffcZci7RKwOFMp5d0/+LeTfTuHRYDyPihOtSUJi5HIlGOCv7h8mIKNXhinHdLoijLshKB3lETqrraRBT60lUxhBrl2rF18LU/hO+yVn/6F7dI9mLU8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:00:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:00:45 +0000
Message-ID: <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
Date: Mon, 5 Jan 2026 16:00:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>,
 linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad38b71-d7bf-4a55-f540-08de4c62d293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REhWYllOQTZ5UFl4bkhvWlZNNWNHTDFWeWQ2Ty94eElyVXh4V3ZzWk5TRTNX?=
 =?utf-8?B?cVU4OHFLQ3Z4WmtLMlhadkt0TkNDZkFSQk9oVEpPdmR0bWpFdUlnNlhlc201?=
 =?utf-8?B?NzZpZURCNzR5NzA0Q2NwR252ZVVFKzFRYjFwKzBuTkR5cmV5ZDh5NEE2djlq?=
 =?utf-8?B?VFZVVmdzZ0ZhMjVNa3pET1F2ZWR2WS9lclRzYldsWWdLNHowaVRXS0xSMlJy?=
 =?utf-8?B?TGZuZml1QXgwS3J4YkZ4dEdERTErUmt4aGRxSmdxT1FBdGZBeUVNOHNVQ0NI?=
 =?utf-8?B?N245M2NWZ1ZhZ05XV2lHSjNyRjIwbFZVb1dnbUVuVStoa2xFeTUvQklTYTA0?=
 =?utf-8?B?QmJSOW1rMWFEa2xBYUMzRlY3WSt1dnpobFQ2VVJNOEdXai9maDZKRHlhSVhy?=
 =?utf-8?B?dmF4Q2Z6UERUTzlqK04vWVZSNHBFcVJrditnYllHUzQvdXhTbmdBSjVybjJz?=
 =?utf-8?B?bHErbGxLTkJSaXdLN1QrdDJoWjI3dVhXUS9zcC94YWFZWmxvR3gyVjZONCtF?=
 =?utf-8?B?N2ordW9ibUFMcGxuWm5xbnYxaDQyMUJmSjh6bGs5ZFl5NlFVZzlqZkpiMW8v?=
 =?utf-8?B?TjNSZi84TjZIK0I5ZVM0b2JiWHcrbnpscUNTWUZNcHVqSnNmZ3RhdlcvTzIy?=
 =?utf-8?B?VFgvbXBRVnVrQjNyejZkYld3VnFibXR1OGFXY2NrblVqd2g4Qmo2TUo1Vktv?=
 =?utf-8?B?QVRqWDd2YWs4bWVpNjM3T2piZDJmUUdaRWFWTWtqbHltV2NocTFjbTBsV0F5?=
 =?utf-8?B?bUlXUnlJRFd2ZXJ1UDdNVUExZ09SSkR2cXpyUDFLSWNsNnluZE8vcTBqVVh6?=
 =?utf-8?B?QmV6U0FhcmZzVTJPMjU3NmpGVHlUTFpOWHJsM3Q0ZWx5WVh1K1B1WnFVa1U4?=
 =?utf-8?B?ZjFiQzU4SkdQSDBPaEUwS3ZiWStEdUtWdFoySFZtSWdYd1lHTEh4eFNwV3RN?=
 =?utf-8?B?bXVqNEIrdElKM2NUbSswQXViZ05ycXNFdUpQZytFM0xyOFhNYzVFR25CMVd5?=
 =?utf-8?B?QVNiWm9OOGJGeDdUTy9RdkswOTQzMTJvNGhSNmpLa0ZWNlNlVURvSTZieVRG?=
 =?utf-8?B?bGRNL0w0eE1lWUhrZmpNc0I2NFEzekoyRVdBdk41UnhJamp1NEhxN05HRVJD?=
 =?utf-8?B?WTBZT1Nrb3FLNit3NlE2V0JsYTJwaWs3ZUpvWWoyR2xkOEtPMW11b2hRcmx2?=
 =?utf-8?B?RkU4Q3NweitqWStaV21iWmpGYURXakU1NnZOMGRoL1pheSs2TERIVlpHNUIr?=
 =?utf-8?B?L0R5dmRud1NhYWVHSmZQaWE2Q1M3ZERnQ2kwNnIzTXBxQXhhSnQ3ZWVIN092?=
 =?utf-8?B?SWJMa3RLWlZWaHZSNVJ1dnBodjdrRjllLzh2anBUSkM2MnZSRFVlZm1Nc3JT?=
 =?utf-8?B?VkUxTTByNWpBQ3hqZnBoSXIrb1JXUHRGM2liUHl6MUFWYVN5VVAzT3ZZd1RY?=
 =?utf-8?B?SzRoeVpRTjZvZDU5OUlpSGpMdEtzTmJmQ2J2ZHpXNmZyeUNDbkNnNUE1Tno1?=
 =?utf-8?B?eTdMMUkvN0NBcmVlcEVPb1ZlVFJUd00ycmpGSEJJT0pnUEEvdzBqbHRSOWNK?=
 =?utf-8?B?NUhQU212SjA0aHRHNjVLTVdRT1ZTV0lkdkt5b21RemZkZlh6UzQ0dEVTRkU2?=
 =?utf-8?B?clRNMXFNQlBRTkNJZ0FsWGl0WE5EeFNXV0xFdTFqZkJ0bHNkZmc3ekZrTm9t?=
 =?utf-8?B?MW1KVmJ3VDRoRDQ5N2V4Y1VKUi83T3Y3c1JneURuQkNpQWpoWW9FVnBhZFpw?=
 =?utf-8?B?eDBsSUZkVjJ3b3FFSDhWNmNSVzdXTzcyUUdWK2RnVWIyMmZJMWtMbzhFTTZx?=
 =?utf-8?B?MGFUeXdhRUpPYU1rc2VmcDhxdUIwcDZnSVpaQ0ZFNFF4aXlOcVVRd0h2RUtD?=
 =?utf-8?B?RkhlZHB5dFdFTjZ6VmFoLzVZWU5RSmlhV3g4Z2lkSitTVHd0QldJalJhT24y?=
 =?utf-8?Q?1QBVWSSkxCY4uT1J6G0DBbQaJjmGEKiD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFTUHJudjQxUVJ5cENOKzhMQWNGRU5NNVVmMzJFWmNNbjBUUW10akVTVSt6?=
 =?utf-8?B?NzVhV3FsSjdPdWN3OVJtMllxZlJsTDA0dWVTNkova21ja2xrS1FxNlQ2QlRr?=
 =?utf-8?B?UkJIZDZ1ZkZEQk5SdFJjRkFGeEVBQlgvcTVUQjZxbzZEUHkvWkQvT2tCVW83?=
 =?utf-8?B?QVk1MmxVTWdsUEo2djhGdWhXejM1NnVkMkRUV0xDMnU4Q0JXRVRkZzZuTU5V?=
 =?utf-8?B?cUwzWnJPZ3VCdFRmWWlLVWpLWHgyRm0zc2xIamxjcEdSMC8xOVNOZHBMaWZ3?=
 =?utf-8?B?eHpXR2tUV0xxNU1uQlFNRnMvWmpHVFRHN0RMVkhGNi9kQkZobHB1K3dnWkN0?=
 =?utf-8?B?UGVxd3J5ZTNJcXNka0dDMk5qU1B3bnRBckdQUmNwMEFVb0ZES2lxaW0xUjkv?=
 =?utf-8?B?aVRIK0s0d3FqOEFYaS92VjFYTXlnWkI1SXRMNjEreUE4WEY3TEFFdno5Y2NY?=
 =?utf-8?B?cExuMEZXTU5nb1ZnNEg3eitQZER6Z0NpaEhmUnJKRlVTNkN3K29yTk1RUWFn?=
 =?utf-8?B?d3hwYkd2Ni96MVRHeFBlUTZFWUgyVFBqQjlWWGxDSEQ0eml5TGZXNTZMVGhW?=
 =?utf-8?B?UVY2WE1hbVdaa0taWSs2eFIxcVdxMWNKUGF4cUh3eE52bm1TUU9NT2FzNlVx?=
 =?utf-8?B?enMwZG9wYmVOUUt6dVRGVmExeVRVSFJ3U0cwTE04L0JvZlcwMXB5QU8rVXZ6?=
 =?utf-8?B?Zm9aT1dBYnV4UWNDL25GTmliaHdzVkdlZ0ROSGZvOFB6TGpramxxUW1NWlhB?=
 =?utf-8?B?eGhaNGNVb0ZHWmtLb2hmdXVTamhwRUFnQVozQ0JPN0kzYW1xNUNEc1JYYWoy?=
 =?utf-8?B?RlAwd2lOdmVlSWRMa0tIWkNkY3RvTFJUTnBGcUt6SytaN01TTTYzVVZpTVg3?=
 =?utf-8?B?WG1XL2VKWXUxT3Y4ZXBqWnBFVzB3YkJjeU8rK0tWaFh1a1RudmlMRmxObVZa?=
 =?utf-8?B?UmFzUjM2N3lMaGI4OE1hcUxpRkRPQllObm9aTkplY2krUEF6eDRiYnRTSjFY?=
 =?utf-8?B?L3V3ZFVJampWQ2xKVTZEK1ozcGlWTXppWVQwaUw3UjRhU0d0eHVmQUpUdmI4?=
 =?utf-8?B?ZmhDZDlsbTU4UlBGVmh2NW1ZNG5CNTNLL0hYRjZVZHhITlpZUllZZVpqVTgz?=
 =?utf-8?B?OWNSTklYdHVlZzIrbUY1Wm5wQWYwMm83dkNZeEFRSkhBTGlWby8yNk8wTlFJ?=
 =?utf-8?B?R01HaFpBTW9JSkE4aFlEQUhhYktMS3Y4NmloNFJDVFJUNGpWc3FXS2Fsa0Y1?=
 =?utf-8?B?Zm44QVQ4ZC9Ma09CV2pyZ1NKdENPTWFzYldyUTdVOE01bmhOUHBkTXdyKytI?=
 =?utf-8?B?YmZ3QWY5a1hMRG5SZU9LWXhCMGVDQ2hRSmY0Q3JONHg2aVEyak9HRWcxVGgy?=
 =?utf-8?B?NXZEdGszSHJpa3plN05CVWYrMldMZWFacWhCL2xpT0tGS2M4dnBORkx5c0ls?=
 =?utf-8?B?ellxVDhXL1lQY21Va1NuMUd6Zmt2MWVLTFFxYzdZczJvRS9FaVIwMDBCNEFn?=
 =?utf-8?B?bW92WTdTZjVCTkdnb3hzeVJGQ2xkZDhoU0J5S0N4ZVRNQmVreVhJZjNFWlVD?=
 =?utf-8?B?WnZVS2poMU1sMW9VNk9mV1BkcWQwSk9kQ3ZabHBJVGJJMThUNzNvVUZnM1RM?=
 =?utf-8?B?RzIzemN1SFplT0gybmwwQm9sWHlyaFRhT1UwYjFYR29UblhJWmZCUnkxSjRC?=
 =?utf-8?B?OXQzaWFGYncwQTFaMW9CaFNHUFNTKzY1YnBkbmdPN0dNVHFrcUN5UjdFUDEv?=
 =?utf-8?B?eGZ3bXBlRUZzM2x4Zks3QmlxZFFnK2U3VkE4Nm5mVWVlTkt0ZDlwa21kL1lW?=
 =?utf-8?B?NTZBQzBkVlVqbEZSU3lobTdwcnpxRG1BaTBCT21XNkVxUkh2Ukgwb3BHa3dh?=
 =?utf-8?B?aU5rUEJEaktMaFQ4WG5RejhxYUZOZmtJVUJ4QUF4bEc2Q2pIM21OR2VtRnp6?=
 =?utf-8?B?eG40Vml3UHVyM0hFVVZnalY5ZjZZT0EzSzM3dEFVdWFiSnMwVk9iSHdFUS9i?=
 =?utf-8?B?YVlackNwY1kvSW1qVXNEa1FQeDMwNE9VQU94UTQvdU5WV1BOU0MvajhCT0l4?=
 =?utf-8?B?WjJibTZnTlc4d1Z2SmxlRzRRRGYzOHBmcm52LytnRWRDeWticGJHQS9iZ2VG?=
 =?utf-8?B?YnBTQjBMVHk4R0VHczVzZzRvQm4zcUE5WnpuVTFFMS82UkwxeGtpTUtHRXNi?=
 =?utf-8?B?NTcxcFBOTHpmS1Y3UXB6cWs0S0swdDVaK0EwMXFTS20xZzFEMWtHOGZZTWx2?=
 =?utf-8?B?eGQ5WGVLbE12MzFmZW1JUGVJYit2eXdFdnFQbC80UzhnNXNabjJ3Zm9STWxR?=
 =?utf-8?B?d2ZaYThZbFdjNHpuUU44aisrTzA3Vk02OENmLzJUdDI0alRROWtlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad38b71-d7bf-4a55-f540-08de4c62d293
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:00:45.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4kc1AT1xb8BbYfeU+ASECDCWhPUdItB0QaKLvNUR4FAMlgd9lCXlS9y/BgoQCUxY907QFFjmR9X6tp82ggmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102



On 04/01/2026 17:36, Trond Myklebust wrote:
> On Sun, 2026-01-04 at 11:16 +0200, Mark Bloch wrote:
>> Hi Trond,
>>
>> We’ve recently started seeing filesystem issues in our internal
>> regression runs, and we were able to bisect the problem down to
>> the following commit:
>>
>> commit b1817b18ff20e69f5accdccefaf78bf5454bede2
>> Author: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Date:   Thu Sep 4 18:46:16 2025 -0400
>>
>>     NFS: Protect against 'eof page pollution'
>>
>>     This commit fixes the failing xfstest 'generic/363'.
>>
>>     When the user mmaps() an area that extends beyond the end of
>> file, and
>>     proceeds to write data into the folio that straddles that eof,
>> we're
>>     required to discard that folio data if the user calls some
>> function that
>>     extends the file length.
>>
>>     Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>>
>> After this change, we intermittently see EXT4 checksum-related errors
>> during boot.
>> A representative dmesg excerpt is below:
>>
>>  [ 1908.365537] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1908.375449] EXT4-fs error (device vda2): __ext4_find_entry:1624:
>> inode #263414: comm updatedb: checksumming directory block 0
>>  [ 1908.382985] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1908.389289] EXT4-fs error (device vda2): __ext4_find_entry:1624:
>> inode #263414: comm updatedb: checksumming directory block 0
>>  [ 1909.598811] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423753: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1909.604308] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423753: comm updatedb: Directory
>> block failed checksum
>>  [ 1909.958470] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423759: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1909.963825] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423759: comm updatedb: Directory
>> block failed checksum
>>  [ 1909.985956] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #303617: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1909.991371] EXT4-fs error (device vda2): __ext4_find_entry:1624:
>> inode #303617: comm updatedb: checksumming directory block 0
>>  [ 1910.156415] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423761: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1910.161959] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423761: comm updatedb: Directory
>> block failed checksum
>>  [ 1910.171364] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423735: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1910.177292] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423735: comm updatedb: Directory
>> block failed checksum
>>  [ 1910.267721] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423744: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1910.281838] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423744: comm updatedb: Directory
>> block failed checksum
>>  [ 1910.476906] EXT4-fs warning (device vda2):
>> ext4_dirblock_csum_verify:375: inode #423751: comm updatedb: No space
>> for directory leaf checksum. Please run e2fsck -D.
>>  [ 1910.482403] EXT4-fs error (device vda2):
>> htree_dirblock_to_tree:1051: inode #423751: comm updatedb: Directory
>> block failed checksum
>>
>> The issue has so far only been observed in tests that use a nested VM
>> setup.
>> It does not reproduce deterministically, roughly half of the nested
>> VM boots trigger the problem.
>>
>> Would you mind taking a look or pointing us in the right direction?
>> Please let us know if additional information, testing,
>> or instrumentation would be helpful.
>>
>> Thanks,
>> Mark
> 
> I'm having trouble seeing how those issues can be related unless ext4
> and NFS are somehow sharing the same folios. Does reverting just 
> commit b1817b18ff20 and b2036bb65114 actually fix the ext4 problem?

Yes, after reverting those two commits we no longer can reproduce it.

> 
> What does "nested VM" mean in this situation, and what is the storage
> for the ext4 filesystem that is being corrupted?
> 

Probably should have explained better, let me do that now.
Say we have host A.
On host A we run VM B.
Inside VM B we run VM C.

Inside VM B we have a mount (nfs one)
X:/images/.libvirt on /images/.libvirt type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=Y,local_lock=none,addr=X)

which holds the .img files. We launce QEMU with something like this:

{"driver":"file","filename":"/images/.libvirt/linux-VAGRANTSLASH-upstream_Z.img","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-format","read-only":true,"driver":"qcow2","file":"libvirt-2-storage","backing":null} -blockdev {"driver":"file","filename":"/images/.libvirt/Y.img","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}

inside VM C, it's a regular ext4 mount:
/dev/vda2 on / type ext4 (rw,relatime)

Mark



