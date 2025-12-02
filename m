Return-Path: <linux-nfs+bounces-16852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA203C9C127
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA083A214E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF417BB35;
	Tue,  2 Dec 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIJoaadC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A6156CA;
	Tue,  2 Dec 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691321; cv=fail; b=icwjgirbNqM80gpQjEy8eWpKPm4a6YWLmFs7z5rF3rtYhOb49hogZN4SYp/xgYCCyjbwFV5Lqg+aLT6jbnTJMio/VepTE4Wyc0v5fRmIGcyrObMpUY5PtbRgWKtfNBx+4FykpgP7+cERI9pdG0pE5sA77m+CWoyY2Igs1gnmdj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691321; c=relaxed/simple;
	bh=EMz1Jpf/H7biQHIVHncCpnxSBNbmXiUK27dXsRIUgTw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=ky3mt6EcBR4+OZ0H9YK60pY5WI+aYnMfDIR+51jx9bkoBc3S3I/ruLoT9D70nRgwUCnxGEJ2sLur0X/oBlWwEdfPWcMcPuyaHthR1OLlH48DNO7/6RXwfhlX48U4Os46k5HsOcMtfK0cYONTsI5Q4bCejLf0fdWyuanAGnHXwKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIJoaadC; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1fVZFZkxFiR28ev1EPWfXvm4TnZY+tffW9cpJMwgGt0nPJWCPiveCNSvyOZIKDHqx7Oz83+93eG0tXo4hD6RKbhk4Pkw23l+ICHQWpW3FLeiE24w5H+sTYIWhXuuFYgWqPXs+DAQ2hnbSBxAMTFsuzJt349ObYoHCJFaOezWO8ohhGWyLuI9M22Y3il7vf5o8e90z//VS/HlFCaHOy69+k+OlO82q6nwiylmFW11V1m7CNfIBIA2FWN/HF3Qtp6tmwYizwdjjqFwd1UpDxa6yr1yQb0S9+O/KZyG+OsNfQX94i8WSW02EvkPJc1ZMPIFUJ8Cg6lbVbCDwJ87K7Edg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90EWTwY3/q29ifVNwlln00MtBxD9JahSSg9BsNqQDiU=;
 b=QlQ74s/Z/SBWCguUW0NllrNpyyfVj9gDndgouphcyAUqzBol/r39rWyuzMYHz/fq5Ro2812Lwm0bYjz2ihViDDveg8TJWmhpOqJadEldEyClvLW705lUgYJAwtugYxaU786XKtAVwoFBdI7bolOL20WA0IdFxqq09zHn8oqM3pew99QFttXGad8K28Zai5xzGUyg1LIweRhxYDvUuvHdFljQd2nsz+AqXg322jfCH7T7TPVzO3Jtqn2NChSsCLeUzqSCgNgikOqLwzWE2MfBsmzubIukr0zRQM0s6A6lYrGKuPpCGg1mLx5BkpxcSZrXHWc7gWy5BtQbbBKIKvCDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90EWTwY3/q29ifVNwlln00MtBxD9JahSSg9BsNqQDiU=;
 b=lIJoaadCrbcdHrwAILwnnD+MwnB5hGLUB/yxFkWvscFAMfxJv43KndWtpbglD3d69Kg1Vld9kZPZpmuZpcxQAP0/HXQIVAd8Hm/OU3/eOGlBH4YIdKNAQtAiyLzr7P8e8A6csdxrCj188EJRlyQ3gQuaLzqAY/Pf1vAZ/bVIRU7OHDqaKuYC858g0o7F2q0UVUNDRtafSmepyRq1/2tYH+Ng1no1005yXf5AOqxAJY+o57Tp9Mog34bf9iTqSzIkKTTN2/4odxgUxPW9vOaDGsiv032QzZ12gIXc6XeITKmGN95+dOnHZKzSLrORkRAHgpvckLJ72JNNzpwFMbR6NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 2 Dec
 2025 16:01:56 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 16:01:56 +0000
Message-ID: <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
Date: Tue, 2 Dec 2025 16:01:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] NFS: Request a directory delegation on ACCESS,
 CREATE, and UNLINK
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 trond.myklebust@hammerspace.com
References: <20251104150645.719865-1-anna@kernel.org>
 <20251104150645.719865-3-anna@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
In-Reply-To: <20251104150645.719865-3-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 251e4312-ee80-49fd-b784-08de31bc1e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTZ2a3lzRmVXN1VOakRRTXVuUmluKzlYeHVBWVk4Z0dTU2ZIN0ZaOVhaSkk5?=
 =?utf-8?B?OEZiWFdFcHlKNkNBa2xLalNOTnhzM012eHF1ckhTT3BESmhaaTc4SjhONjdO?=
 =?utf-8?B?cXFlMXhnK0JveG9Ndk5OWTJrUHlubFh4NlBwa3NpT3lNa0ZYYllCaTMvdGNi?=
 =?utf-8?B?ZGgydXBuaG0vVTljbThIOXYzeVArWUJvU0JzY04xTGVMK0pHY1JCUVlZVTBL?=
 =?utf-8?B?dGpwajY4cjVmMkgwcHNpNkVVUHRKVjBpMXJaWHk1T0VDZG1UdVhkOTcwb002?=
 =?utf-8?B?eVhzQWhzT1dVWHhOczNocHhjTTZ2emVVdGEzMnZqdFdSWjFVMU1nQUdjbVlY?=
 =?utf-8?B?Q3VrMktHWGdSY1llM2JDWS93VGNFTDhIeGtKR2p6VW0yWmdqakdZYnM4ZENn?=
 =?utf-8?B?eDNoOFlKTi8ybHpwU1AyUTY5U3RiVmZnNkhIaEpEcG9PdHZJRy9SMElSOTRL?=
 =?utf-8?B?WG8zZ2R2d0U1ZFlCRERwbkJCN0hTMkdrVFJ3R1FrS0dLa3A0QUxETlpFcjlN?=
 =?utf-8?B?ZEtFZG9BSDVVcFFyQm0xMEJ3eGhBcm9UT2RrUGhiWnBPcnZDeC9SQjhwOURD?=
 =?utf-8?B?THB2NHpmOGtqZ3dySXh5ajJpV2l2U05EZVYydTlpSThnMlNrYmFNcG5OMDE1?=
 =?utf-8?B?WXhnZm1kajRMNWx2Yk53a0NVdTBHZUZ4OWhVM2ZJWUR1T3E0MWRodWNmdEt3?=
 =?utf-8?B?VHNhbkJlRWNzWUNDYVJ2TEZiclF1NEpQek1uYkdKUWZQai9ybmQxZFZ4ZFB3?=
 =?utf-8?B?WFFDdHEvNiswMG5CNEF2VUt5TXdKdzF6RldWckQxR0VUemdZSTczUDc2WjJu?=
 =?utf-8?B?UEZiaVFFNzlzeHovd1hyN2NQdWtmZGR5cis2VXFnVDJVekttVyt4NjFlRXln?=
 =?utf-8?B?d3VnU09qVTdXQ0tjbE5QclBJTG45MHIvR0tUZ3ZVTFZNUTAxbDBPVzdDb0l2?=
 =?utf-8?B?Tk0xNUs3cnpiZEdGVG9IZjFnczVwYW5JcmhZRkhHY3RwNUp4YVlzRGc1ekkz?=
 =?utf-8?B?L01UZWNodm1NL1A1dzhTd1J3QmlEQzc5WGdFdUdhQUsvSVBiU1lTbHd1TTV2?=
 =?utf-8?B?OFIybHg4VHJKMks3ZXA0ZVdSSTNSMHF5bG8xdWFUenVhRHZsclMyeFJpQmNa?=
 =?utf-8?B?cVJ3b0JDS1lBVnBDbjlZSml3cVFPRmZhVHRwMUlab3FMYVpRd1BYRDJ1R2pm?=
 =?utf-8?B?VDFwUmxoMDdqMUN0ZVVTeGFDemZGVUpJZENVTU1NekJaTkwrNm5FbTdvL1JH?=
 =?utf-8?B?bC9uWk1SZE8rdzNHSFRzT1lrZVFDUVhhcXVGcWFBUTUwZXdxMVRkcjhUOVNw?=
 =?utf-8?B?dEhnNDY4SWpPc1ViQndZL1o1Nk0zcmZRM0hXa1NqY0tSWDFXNTBPVFVqVG5B?=
 =?utf-8?B?amt1UGgrVFFEb2haamVtTktvZTdyOWoyT05MdXBtbUFGa3hMaWw0YldFRWth?=
 =?utf-8?B?cE5GTURSS0tVdG82QjV0aTh4dUNncUVBVmh2M1lYaWUvN3d2YlEzTWtIZFFL?=
 =?utf-8?B?azdOU2NUNVI4TWJMMnc4ek9tWnRBWTh1VVdaZlpIdThuVC9ZMWJmQkZpVnFG?=
 =?utf-8?B?RERpYXNaUG1RSk5qR0JOQS8xYjFGQm5YT2hKckh3NXIwRXlhSWwzWGNydmd2?=
 =?utf-8?B?UVhZaXAxMHBtU0l3eGlqRmZSekZGL3JUQnVFajhWRllqeWJUVWZ0Q29IcUll?=
 =?utf-8?B?b1pTYXFVOWgveHJUSGczbTVVSHloV3l0MWhBSkd6TThtbWVvTVgvQzVRa09G?=
 =?utf-8?B?S3Fld0UxWFpUVGNJV1h1NmhlNlNITi9zVlJFaXdxaVpPN2NQUkh0Y1RCQmo3?=
 =?utf-8?B?V3dVWGVGTFVvSnpsZVVFTm1VWFJqM0RIVWhBVTVFOUhPWHhEMys1emV2SG1y?=
 =?utf-8?B?RUlxTDZkeTF1YTlvb0Y0WXRVZSttQzlyWWUzYW4yU2RrTWlGNXduWTB2eE5K?=
 =?utf-8?Q?jZFg5rP6aT5Y9i7ZXbeHaDhtCC7hH+Mi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2RRS1JXYkhLQ1FRbXRnS1ZlVzA5c3ppVEl0OXJJTEsycE93ZS9ZMFFXNnhJ?=
 =?utf-8?B?Rlh6dGhnOXl6cGhjTHJ2QTMwdHZUQ2QrMjJyWlN0STBtYmN3NnVUTi9oaTlJ?=
 =?utf-8?B?SC9JSFQ5N3JJUGhzUm1pR0U3cW9vR0RTZlFRUzRMdDIvZ2w3eG82MXV2SE43?=
 =?utf-8?B?TTFSNzNib0FPcDNVU1pTZ2F6eFhyenBTUUhHRXBjZ3I2UVJPcVhLSEFRZnpH?=
 =?utf-8?B?Y1J4RWFRNEdQQ215SEF2MUJUbFY3M1BpUUdqNUpVL3kvcnpsQStjQ3BTWE50?=
 =?utf-8?B?NFVwTkxudENMMFFNd3FVU0d6dFZQbWFsQU4wTFZyUm85ZktHRGNGWkNFWHhk?=
 =?utf-8?B?UVYrZy9GeTRDOVlnU1ZPWER6V05kK09OTG1pbXp5SXBLZmFmeThtU2xKSFFk?=
 =?utf-8?B?bTlWaXpDejlGME1ra0ZTYXNwUGcxSlZnYWxVUWtLTWRHd3RUTGVpWndkeWZz?=
 =?utf-8?B?TGdacnNaU1J3WHYvMTJpeWVRcHMvL1p2TXlMUEVmbTVFQnU2Vjgxc2dYbFBV?=
 =?utf-8?B?ck90dklnUFc5Z1Y4T29oMHZuZDlkU09TMHJ4T2tmbWE0N2tLT0VBMnF1bGh6?=
 =?utf-8?B?RmlqTnJTa1ZDRkZLalR5MFZUanV0Sk1EMTdRY3dLMnRJeUxRbHA1RWNaSWFx?=
 =?utf-8?B?QU9ZN09DcWdneVBIZ1YwMTFOUGNSZnQxMHhDWlQ1SzN6RjVtNFlLbjVJVzUy?=
 =?utf-8?B?VXRtMThBQXl1V3pqbCs3Wkx1akw5dXNqQjhtWndlVXpIeWxOU2lXeEhzbUZR?=
 =?utf-8?B?Sk1mdFREMVJwZzNmc3JoTysrc2x2Qis2Tks0U1luLzJ3K1BDOW1xa2xySHlM?=
 =?utf-8?B?ak9hTURxcDBRL2pBb2EyVjI5RHlsaDVIS3NoSUNTZk9weGFQcmlleEpMd0s2?=
 =?utf-8?B?SGdxMkxpQzFCbFRnSEtHbnM0L04zTFY3VzBjNUVZeGE0MHg2K09ENDFIL3ht?=
 =?utf-8?B?MkJiUmZ1TlVnZHM1a0FJcDNOUUFhYmZKd3ZPc2x5ejkxaXB5dmRjQ3J6RUhw?=
 =?utf-8?B?Slo0Wmg2UTRsTlJYUW4yLzkvS0Ixem9zR3JFbDBnU1Ywa2ZnVWpjWnBNSlpL?=
 =?utf-8?B?TnFRT202eWkzZDdjSmpSSC9uYmZwcE11RXRXYWRBMmk3WUhka2kwaHpOekZP?=
 =?utf-8?B?bzRwMFpXeXNqK2d4SEowREtBRGJQdWwzU0YwSWxaaTdsa1padWo2UFEwOWgy?=
 =?utf-8?B?L3c1emlpOHk4V2pGdWpsUG4rMW9hSkxHQk52dTNaMHpIeldrdGh5VWdHc0VN?=
 =?utf-8?B?cG5FS2dKUjRXWGtHS1pZTEN0MVZ1UGd0WVpWdXduTlJYZ2cxTUs2cDdSbDZj?=
 =?utf-8?B?UzFoOXA0MHh3c0JTR25YQm5uSFI3RmZXY3J2RktYVC9ldGdpSEdoTVlWdFlk?=
 =?utf-8?B?YXBOTjFxZ2Y0QnVucU5LTlZTZWFsUFcySjNJSVN2aFlXWWcyYUtNRjhBdmpU?=
 =?utf-8?B?RmxKd25UMlJjTzREb05XK1RaWWtINThham5BcCsvWDlkOGpidHowd0dSLzB1?=
 =?utf-8?B?ZzlJbG40YXdKTGk5THZCQWEwZDdMN1BsdmFuREl2NlpWZGR4VlpxTmptcXc2?=
 =?utf-8?B?NHd1QmRRem5uM0w1VHI4Z2l1Uks3NExLSERWRmlBL29ka2dlQ0dOQ2ZtR25i?=
 =?utf-8?B?QVZRSVQ1aFoyRUJiQTNaWTl5NFdOM2d2OVdaU3A3NHhMVUdTejlwSjZ5ZEVC?=
 =?utf-8?B?MkkrbFBQVkViSHVLeFNkTEdkbEdqWmUxVnlPdmg3bFNka3hJOGgyWjRBb3JG?=
 =?utf-8?B?R0dnOSthdlI0YkdvWWc3R0FmSVFpZXduOVBlems3QVA4Z3BmZDJyOXZ2blNt?=
 =?utf-8?B?NFR2c2xDTjFjTnJrVkxNRm85K2pkZVZ5RXNySWNlZ25sUU40QXdtMlFwRCta?=
 =?utf-8?B?WlpXempIUU5HSzlySGNuZGhWbkdBSGlSWnNXTmNXVzRVYnhSUDVBc2lBWTZm?=
 =?utf-8?B?VHpUdVF4SEdpV3pvcUpJSFN1K0Q5MGVieElqU1FlU2FEZzZoQXU0eE9kcDlI?=
 =?utf-8?B?dUtIaXhjZjd0bWRvMTNLd09BWHpYdy9CakEwU2ozMWFvNUI0U3B2V0phdjZD?=
 =?utf-8?B?SmorYXhVTVpnbFR4R1dSY0pyUzhYUEZXN0pZMURFcGZGTW9OSGFTejJpY25J?=
 =?utf-8?Q?Z73bm5XvRBYQoJAXFRyHWE/hB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251e4312-ee80-49fd-b784-08de31bc1e15
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:01:56.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFqzZ2rmXlRug7I5+LG6ykZeG61Dm7N50jcWytp0o4d+lepSUI5ZM6xOK+1S3GYwoDKd4mgRO6dZBkiNxy/rMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

Hi Anna,

On 04/11/2025 15:06, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> This patch adds a new flag: NFS_INO_REQ_DIR_DELEG to signal that a
> directory wants to request a directory delegation the next time it does
> a GETATTR. I have the client request a directory delegation when doing
> an access, create, or unlink call since these calls indicate that a user
> is working with a directory.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>


We use NFS for boot testing our boards and once this commit landed in 
-next a lot of them, but no all, started failing to boot. Bisect is 
pointing to this change.

We have a custom init script that runs to mount the rootfs and I see 
that it displays ...

[   10.238091] Run /init as init process
[   10.266026] ERROR: mounting debugfs fail...
[   10.286535] Root device found: nfs
[   10.300342] Ethernet interface: eth0
[   10.313920] IP Address: 192.168.99.2
[   10.382738] Rootfs mounted over nfs
[   10.416010] Switching from initrd to actual rootfs

Its odd it fails to mount the debugfs. There are no particular errors 
that are shown but it never boots up completely. I am unable to cleanly 
revert this due to other dependencies, but if you have any suggestions 
for me to try, please let me know.

Jon

-- 
nvpublic


