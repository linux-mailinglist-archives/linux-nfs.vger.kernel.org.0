Return-Path: <linux-nfs+bounces-18284-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHfKKhT3cWmvZwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18284-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 11:08:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3665020
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24B4866BA8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84AA364EB9;
	Thu, 22 Jan 2026 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKYrSZ7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9362362129
	for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076047; cv=fail; b=RZqNFBjtRFZAsf8qOjumWhDd5oMP1mYSYOewVmrIp67v/fAB5V7KmSiTUC2rnz4nVleNNIbjasNRQ3QypIdWJMQULIAQ+KNVPEql6Mlp/qOBkVZyT0TA+1nZwtkEbApyiWL2Y34hy22ulpyZW6VFCSpGQCODaf0Ss/BbWfaMTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076047; c=relaxed/simple;
	bh=SyEB/qu5sX2x1b/+zJUh32JBxlrl/781yazXt3Cq+Dg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/zKAJYoE9w12VdJsvzzVW4pKbLmhDPjpJZ4tTfQIwQ2hwb9jKOmkD7nbzKlT+NeMZGa9KDRN9kQOECVb7mXhI68tv3+1MLKOhWcx3/IVaTiUCgHbQif9g0h3oCLwmMP4WxleePkcugfJTwdlUhlbddqsLjOi1Y7EYmFHzknJuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKYrSZ7l; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGF99zKeVhA916QzdfCSj8oA1h6ER6ZSR8tFNzeAzW9dO0kFwdzLyQws8lklYxjm+qKDbzML2GtOZtIP2AMkKjavYCbQJOzZw+4O2aPVgDzCN1x4Mgpw4Kn0j69KO/uIUmv0fyuJKwjMriAKN194IiIWG99PfcO7YWHDe0YNyHz8Eut6u9GVXqEtbwhFpH2WZkNWiVkSkManqTVImhXahCr/u2NW1STwAghHrS79i//8Ip6iYpYNYaQ7tgYPT6iBPfEJ04WIbjz5rhrk+f1yrvfatGK95qYvQbmEAotkpRlcu3R3V/JfQeBxNAGSyUauPEx4jGjGV4N05XYRKSw8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okX8VAeAlxWbpqPeGICB2pepiGtUjPMlCvq9SR5W8ks=;
 b=lu4/ZPvl6L7vo8POpuCyWG1ZnWMgkyA+gwNzPCcFdQCLrKte3aTdQnHgnvemYpZTU7j55raXnnHzRnOV0k69UgSX9+aSGgWCZw6wx5MwXKf03D1jgIcCTd6g3CEXT5QbprWYCLtQ+73DjxjpxPRVNPzuO81ytVV+AsKPeLzRaMxLoH8A9Myh4vluNrp77qzUj3/8XDiMwxve9WoiMQ4bQ7JaATfpn3dSs7JzOCxcBpZbfwt/9BRJ/XTq7MCJYnDw6D9cJUtDeq8GSzGrgl/B2DRJq72gNBJV/EU3HhKqfa9OUb9e7L4SxH3ZsMdFLxM7ARZozGMW6sQSGySbzZVO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okX8VAeAlxWbpqPeGICB2pepiGtUjPMlCvq9SR5W8ks=;
 b=RKYrSZ7lfnhHwgLrKAcRZK9Lys/9Ljr5H+C77Enk0KzV56mU9wSTbCz/i6SmKjVWQS90g8mEwB2tmvk4WOkKd7aB1mDKvR+GSZkkALOOWRB+6WOCdREnYPI5tmVTOVmAslYo4CRrYPP4m9Cqyf8mSTCUC9j+decTWIH4ZQ0erN6EWsXGhbElhb4tzcRipEufHXGu5uX5a1ls6j8yiV4mBJoDUNR7B2oBdY4Y3DNBQW98mE6NHs2NNJgryvdeA6GwK/HXaxixoP8yJBmzK89uGjp/7i0u94RYlc/bRQPzA8aihbu7Zc2ACrzUelMj7d8RjfvtQV05okAMx/SoPrjU/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:00:43 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 10:00:43 +0000
Message-ID: <9871411e-8272-4f95-80f0-2b86e55231b8@nvidia.com>
Date: Thu, 22 Jan 2026 12:00:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Mark Bloch <mbloch@nvidia.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>,
 linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
 <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
 <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
Content-Language: en-US
In-Reply-To: <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: eedc4239-4216-4cd3-07fa-08de599d1ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjgxRVd6ZGxmSUtHaXlJYTVCQlRiY1JwTjhQaVg1UEk2endmdkJEaFc4ODJk?=
 =?utf-8?B?VHM1SDJJU2xqMW1Ia205SFQ2bHlSZU5nVzRSNGF5RzhIbXdkWDR1QkZqTXR6?=
 =?utf-8?B?b1dEVFlid2FoY3I0MVhlK3BsbVJzamE0TnJRU2NZOGlML2ZjQjczNzRta3Yw?=
 =?utf-8?B?UExYeElvZkZ5UEUxUFVrbXRYUWZ1T2xycjA5R0VNUzVTZ2V3SG9hZU9wWVJt?=
 =?utf-8?B?T0lrcE1qYWlCZzUvVEZKYTlZSkVTaUYyTEFGanRFcUJIOS9hZWJRNmFGSDFG?=
 =?utf-8?B?aHE4RWVnbHhBQVdYTTQzdVZjU05uendhK2p3RVoxaVp2RCtxUTd2bitjTWlC?=
 =?utf-8?B?dUl5dnJ1SngvNkVFZGVlTllzbWR3VW5WWWt4a2Ixc0hqOGFaMzY2ZEVveUg5?=
 =?utf-8?B?d1N4Mmx5MjY0QjJucEgzTStMbDFlSUw0TmViQlBKWU5lT1ovRlprUk5uQUZw?=
 =?utf-8?B?VHo2Wmg5c0YwNHlYYTFsM0wxUzRQSzlDV0VaclNWcDcrbXh2UUYxdldCSFFL?=
 =?utf-8?B?cmVLT01sZWFRNXArZDEzdzlYckJqeW9iSGhUTGZwY0lNUC9FcGVyeFVUWS84?=
 =?utf-8?B?dWJpR1J5UVFZbStXUVo4L3BnUERhbytyVmhrMDJxTzl0NmZVMW1uOTlmcld1?=
 =?utf-8?B?VW5lTWxidmxlK0NjY3ZGUGw2VVRpdGRHcGJSYTVZNnpOUjVIdDQ5bUh0Y3NC?=
 =?utf-8?B?ekRJTTFVMDk4akJoUDJKTjdseVRrM1JvdGNQVkNVU0dnNkc1RzUxOTVPVERG?=
 =?utf-8?B?a0VuWnY4M1Z4T0xPdnh2ZVdBVXNUWEJ2QzBQaDFtdkw0TVJ2bWFFNTBEVzlm?=
 =?utf-8?B?bmJQU2VDQnpxVmhsbFM1WmQ5NTVTb3p6by9BZGhLRVkxR1RHeXVJNzU4U3hu?=
 =?utf-8?B?WGFVY2JxUzdSSXVPOWlZb0FJZ0J1Q3VadGU2T0diZzU2Q3FDN3JXRmFQT1Fy?=
 =?utf-8?B?ckZBS2VHV0pOOEFOV1ovcjdNMElyeDNMRkdueUVQOW1lNDUvbHVCUzFZd3BS?=
 =?utf-8?B?b3ZPOHZiSHF6REZEOGRVRjNiRmtPdFZPR0dqVE4rT0JPRTBkNitMYWxHNmE4?=
 =?utf-8?B?VXMwOGlWWWx5aGVpdVQ5WHJMSFl0Q0VNNVdIYVpYTTJnNjNMUDBOZDNyWkVm?=
 =?utf-8?B?UXR2aytaYm9qTmhld1kzS3JPZ0N5OThCemJVaFdYbGdYRlNzVFpXL2UzbzM1?=
 =?utf-8?B?UXdDUUxUMVhnRzBvVEh0eDVVZEZmTHVrSlcydm1wVnFPQUtmMmQzT3piaHVn?=
 =?utf-8?B?UE1mV1lpS1ZuTzA2L3dSbWR4YU5Qc2lWQloyTEhzVFZHM0R4MnBnSHo1STVv?=
 =?utf-8?B?RnRjM2ZSTEVBdXBqKzRWWklCS2RNbmpKMTlzdk45cmJCRjNiRGJaekV2MWV5?=
 =?utf-8?B?bGJFRUZmNUM2QVlCbzFLUjNEd09jSG1JVmxYMzdnZ0VpR1hlelNSZVhKYWw4?=
 =?utf-8?B?ajB3a2V1VHFFU3BNYWxTZTRKRDlJcU5TSnl0WGg5bUJ6a29jMXlnRURCRFg4?=
 =?utf-8?B?cThlZ3JOVGRpZW44em9ieTQySGt3c1RiSUovQk9uREtXOHV1TytvNU41azNr?=
 =?utf-8?B?WGs0SzArVHVBMDg3UFdpc1Fua1lIV0hTRE93WmRiNWc3OVhHSnJULzdPYmZh?=
 =?utf-8?B?ZlBJUFYxcy96Uys3eDFFUFdwdGlvUm9MNzlWelNtQzFvcWdhY0FSaCtaeEE5?=
 =?utf-8?B?QjkveDFBQncwd0R6alV5WDhNdm5iQmRsaFRIaytaTlR6MUVSVlp1S0k5WGhl?=
 =?utf-8?B?MGtJdFpXSjNDbWgzbm9obFpKaGNlV3lUZzNBV2pIdmJ0blVHbEdzbEVxVHpG?=
 =?utf-8?B?czFhY1hQb1RoM0t1WjJhVkpyT0hUUUo5dDRWZkFzTmF4LzBFQkZKRmU2WjlV?=
 =?utf-8?B?M1pWZHBtOFllMU1kOU9jcXJyRk9lZ3hUQkdvTjMwY0Q5d1hZb2NNdHU2cDhH?=
 =?utf-8?B?Q1RWYTdaZFRuYnN6c2lRaFJacHR0U0YzdXV4RVltTDB5YWF0OWhYUW51OHhh?=
 =?utf-8?B?T01vUmo2TU5LbURkclpuZUI4TEwrQlFaaUdsclo1U01aNmxMV3lPZVE1VjJ1?=
 =?utf-8?B?UHRoYjJIeGI5ajFZWU5XaG1IRlhVbThDU2NWdWdBSlY3ZXFUQmd3WW9kenBH?=
 =?utf-8?Q?UNZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VStmOXRkNks1cGVQUnMybzVzUi9YcmZHaHpjU0d4UWpmZU0vM2dmTlp6RGhl?=
 =?utf-8?B?dXdHQ1RSSFR1d2IxRWxOeXlSa2R3bzVPak5SdmxMMHZWa1NhcnRmWU5OemYz?=
 =?utf-8?B?WHJjblRiTjBpWllEd0JGcEpmYlcwejRPTzhaTk02ZnZVTDJyZGZuN0FndUw1?=
 =?utf-8?B?NlFCM2NnWnVYalpORGN4Q0NRbmFsU1ZKcWFBbmczcEVMSDZyNjEzY3Y2L0Fr?=
 =?utf-8?B?aDBrMXVUbFliMkFlbUEwMDVpcGFoTWkzRVR5OUM5QlM3MFlzNUlmRTR2NENm?=
 =?utf-8?B?QmY5blk0dmIvajZWQVF0bVlSYWhHY2RTdUdXTWU4UjZkcngwZU1iYWkxcXRk?=
 =?utf-8?B?RzNiTXNWYzZoZVBtZXpWN2FRd2NSVkU3V3lJbDBjWHFHTHBWWVJOdjBsRTdh?=
 =?utf-8?B?QklPanZLNGpuZmFMd3pPL01iaHdIM1ZqdGdKTzgrZDZUT3V4eFV5aGd6WXVi?=
 =?utf-8?B?NmI2cUZSdVNzbkszMGw4Y3FSS2RNV3dBeERwTXY1bHRrRHpmdmt1SnBDazdy?=
 =?utf-8?B?ZTdEem9semZhekp3cnFRTmkrL1VDeUViV3hRUHZwL2pXVGxaYWJhK09hUTlx?=
 =?utf-8?B?cFBwQjUyazdGMVRFdlFReitiS0VrZ0krRytMVkZrVEVvREg3WUh4SUc0NmJV?=
 =?utf-8?B?blBNNGNwUWc3d3hTQVd5ZExjc2h6UmxYZ1Zkc3M1N3JqNzR5OCtWTGpicHQ1?=
 =?utf-8?B?ODZIQ0d3OGlPd1NLbmh0azBONHdYUnRkUmJ0TVZvTnN4ZWZHdDZYWTZCOEZl?=
 =?utf-8?B?ZVdiRDhMMFJFb25MOXRNVm9lVGJodmJHQ1hmalhyZFZiVVJuaE9LZ0dURmJ2?=
 =?utf-8?B?aUwxN1hZVVo3WFZKcjRkb0haMGlBTlZXVVB3SW1IL1lwbU1pdDJtcjdjZjVy?=
 =?utf-8?B?dDBxZHJOMHZ2VVR3TnNLcTA0RTFkVUR1Q00raVV3Y3lFMnRjVjNiTVpQSy80?=
 =?utf-8?B?ZHdDZEttam9rNW9qQUV2Zm91MUEyNjQvNG5NaXFFWU9acDdYc0s3Q3BXRGdi?=
 =?utf-8?B?SXBEbktjY1Y5UUY2Q2V2VjhvNUNGdWpOV1Y2NEpLdlQrNTMvUHBZOGZ3S05S?=
 =?utf-8?B?bm9RbDlBMmZsOVMwNTJtbWJBOCs2dVdmYldIVmJiK29MWWZ3TWVPVHVCSmhu?=
 =?utf-8?B?TlBVZCt6bSthbURCaVNOM2RpQTFBWG5MemZkTjRqUkhadUNPa0x5VWx0S1p3?=
 =?utf-8?B?Qy9kYWxsbVVoemx5ZGxXY25Nd2RJVkJiM3A1WC9vaVgrbEY2NGRDOVBIYnFh?=
 =?utf-8?B?SDVLcmZTWDRIUHNIWHNBWGdDblVuV0lKeC85aTEra25WbDNXWElEQklXNU1p?=
 =?utf-8?B?UnMrSHZhZ0FnVWVwK2FWU1NJRCtLY3Z2MmF6NUtSSXNvcmlSU3B4SkxTdWU0?=
 =?utf-8?B?Qzc3TVg5UUJDVnNQaHQvNmt5RDM0QzU5ZEdlWW5URzV0d2RMTzhVREdpNDV1?=
 =?utf-8?B?TnRUSnJwU0p3WUJTWVJRbkZXTUpJamxSTTEyeDdxRnpVRXcrNTFFY1lQS2M2?=
 =?utf-8?B?czhPMHIyMzRNQUt3dmZoemJsOTBWVmNlbU5KajVHZEdPbVYwanZiWEpnaHZG?=
 =?utf-8?B?Q29aOFh4MXVaZG5nV1lXM0RSQlpYUmRCU0lCWU54UGhwUlBESGhWcGwwYm9r?=
 =?utf-8?B?Ukw5Sm05dmI0aWd3cDBqSDhYaTA2YkRPdlZCSWFCcEVtWHZxN2Q5NW1KYlZS?=
 =?utf-8?B?bVBuaVltMHZBcXh5SUxMU0ZYU1J1SERzUEltbWdjQnJxZXVPem5EM0o0QTZv?=
 =?utf-8?B?Szhpd2c5V1RscmpTeVpBRGRQQ3YyL1E4MlRJWk4wcS9iMmpTNE56dEpBUHVx?=
 =?utf-8?B?MStveWxNczQ5VXYzbFc1V1ZjOXBtak1ZZ3JJbXBwQ1gzZnExSE1uRXdIclky?=
 =?utf-8?B?N0taeHRpQW54SEpUWGRZUFdxNFVUdElrVW8xelQ2ci9Ick00eENzbXFCaE8y?=
 =?utf-8?B?bmNlKysrbGdRdEtWNDRsZGNzcmtES2JGcm5qallnOUZUZTV6R2hhV285Rnp0?=
 =?utf-8?B?cFhWd0hQUkdBeGNjZVhmTmN5VzlUdGxpMk1ENitRY3NqWTNTRlIwSmZSaGNO?=
 =?utf-8?B?dEVod0pCemZPOStYN2s3cjZZRDViRXNTMncvdThQVFRCaFlnQ0dJc2NNQVYw?=
 =?utf-8?B?ODR4Uk1WckxPNnlpeDArTmJvQ2VwSmJMQUhkZW00Q010M3Z5K2YyOVdEajFk?=
 =?utf-8?B?SXlteDdFb2todmFabEpidDRQT3owUnhuOThHNFhCOWtZbTVYcG1CYzdMNnhp?=
 =?utf-8?B?ZXdmVlRCaDlQNkxVdGpNcWVvVzNXMW9iRkZEc1lJcVdFVEc2Q3dIOFh4cHVL?=
 =?utf-8?B?dDg1cTZNaklybWEyT09uWGovNVVJK3ByVk0rdkRjaXRnZC9xZlpndz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedc4239-4216-4cd3-07fa-08de599d1ac8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:00:43.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/Jllz3JluZVjp2BGqeQ0GQg09XskQM9mSGU6Q+BaZvNQ9EHbvAsj4QpkntVOLJxYlBcafXXFugL9hmAU0AWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18284-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: EDB3665020
X-Rspamd-Action: no action



On 11/01/2026 9:03, Mark Bloch wrote:
> Hi Trond,
> 
> On 11/01/2026 2:24, Trond Myklebust wrote:
>> Hi Mark,
>>
>> On Mon, 2026-01-05 at 10:20 -0500, Trond Myklebust wrote:
>>>
>>> OK so if I'm understanding correctly, this is organised as ext4
>>> partitions that are stored in qcow2 images that are again stored on a
>>> NFSv4.2 partition.
>>>
>>> Do these qcow2 images have a file size that is fixed at creation
>>> time,
>>> or is the file size dynamic?
> 
> The file size is dynamic (with a fixed maximum of 35 GB).
> 
>>> Also, does changing the "discard" option from "unmap" to "ignore"
>>> make
>>> any difference to the outcome?
> 
> The discard option is already set to "ignore" in the image.
> Do you want us to test the other options just to see if it makes
> a difference?
> 
>>
>> I've been staring at this for several days now, and the only candidate
>> for a bug in the NFS client that I can see is this one. Can you please
>> check if the following patch helps?
> 
> Thanks for the patch, I'll let the team dealing with the issue know
> and let them test the patch.
> I'll update once I know anything.

We've been testing your patch for some time now and didn't hit the issue.
Feel free to add Bar's tested by tag as she was the one
that actually tested the fix. Thanks for looking into this.

Tested-by: Bar Friedman <bfriedman@nvidia.com>

Mark

> 
> Mark
> 
>>
>> Thanks
>>   Trond
>>
>> 8<------------------------------------------------------------------
>> From 18acd9e2652d44bcb8a48bc4643ab006787b809a Mon Sep 17 00:00:00 2001
>> Message-ID: <18acd9e2652d44bcb8a48bc4643ab006787b809a.1768091015.git.trond.myklebust@hammerspace.com>
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Date: Sat, 10 Jan 2026 18:53:34 -0500
>> Subject: [PATCH] NFSv4.2: Fix size read races in fallocate and copy offload
>>
>> If the pre-operation file size is read before locking the inode and
>> quiescing O_DIRECT writes, then nfs_truncate_last_folio() might end up
>> overwriting valid file data.
>>
>> Fixes: b1817b18ff20 ("NFS: Protect against 'eof page pollution'")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  fs/nfs/io.c        |  2 ++
>>  fs/nfs/nfs42proc.c | 29 +++++++++++++++++++----------
>>  2 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfs/io.c b/fs/nfs/io.c
>> index d275b0a250bf..8337f0ae852d 100644
>> --- a/fs/nfs/io.c
>> +++ b/fs/nfs/io.c
>> @@ -84,6 +84,7 @@ nfs_start_io_write(struct inode *inode)
>>  		nfs_file_block_o_direct(NFS_I(inode));
>>  	return err;
>>  }
>> +EXPORT_SYMBOL_GPL(nfs_start_io_write);
>>  
>>  /**
>>   * nfs_end_io_write - declare that the buffered write operation is done
>> @@ -97,6 +98,7 @@ nfs_end_io_write(struct inode *inode)
>>  {
>>  	up_write(&inode->i_rwsem);
>>  }
>> +EXPORT_SYMBOL_GPL(nfs_end_io_write);
>>  
>>  /* Call with exclusively locked inode->i_rwsem */
>>  static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index d537fb0c230e..c08520828708 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -114,7 +114,6 @@ static int nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
>>  	exception.inode = inode;
>>  	exception.state = lock->open_context->state;
>>  
>> -	nfs_file_block_o_direct(NFS_I(inode));
>>  	err = nfs_sync_inode(inode);
>>  	if (err)
>>  		goto out;
>> @@ -138,13 +137,17 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
>>  	};
>>  	struct inode *inode = file_inode(filep);
>> -	loff_t oldsize = i_size_read(inode);
>> +	loff_t oldsize;
>>  	int err;
>>  
>>  	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
>>  		return -EOPNOTSUPP;
>>  
>> -	inode_lock(inode);
>> +	err = nfs_start_io_write(inode);
>> +	if (err)
>> +		return err;
>> +
>> +	oldsize = i_size_read(inode);
>>  
>>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>>  
>> @@ -155,7 +158,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>>  		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
>>  					     NFS_CAP_ZERO_RANGE);
>>  
>> -	inode_unlock(inode);
>> +	nfs_end_io_write(inode);
>>  	return err;
>>  }
>>  
>> @@ -170,7 +173,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>>  	if (!nfs_server_capable(inode, NFS_CAP_DEALLOCATE))
>>  		return -EOPNOTSUPP;
>>  
>> -	inode_lock(inode);
>> +	err = nfs_start_io_write(inode);
>> +	if (err)
>> +		return err;
>>  
>>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>>  	if (err == 0)
>> @@ -179,7 +184,7 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>>  		NFS_SERVER(inode)->caps &= ~(NFS_CAP_DEALLOCATE |
>>  					     NFS_CAP_ZERO_RANGE);
>>  
>> -	inode_unlock(inode);
>> +	nfs_end_io_write(inode);
>>  	return err;
>>  }
>>  
>> @@ -189,14 +194,17 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
>>  	};
>>  	struct inode *inode = file_inode(filep);
>> -	loff_t oldsize = i_size_read(inode);
>> +	loff_t oldsize;
>>  	int err;
>>  
>>  	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
>>  		return -EOPNOTSUPP;
>>  
>> -	inode_lock(inode);
>> +	err = nfs_start_io_write(inode);
>> +	if (err)
>> +		return err;
>>  
>> +	oldsize = i_size_read(inode);
>>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>>  	if (err == 0) {
>>  		nfs_truncate_last_folio(inode->i_mapping, oldsize,
>> @@ -205,7 +213,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>>  	} else if (err == -EOPNOTSUPP)
>>  		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
>>  
>> -	inode_unlock(inode);
>> +	nfs_end_io_write(inode);
>>  	return err;
>>  }
>>  
>> @@ -416,7 +424,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>>  	struct nfs_server *src_server = NFS_SERVER(src_inode);
>>  	loff_t pos_src = args->src_pos;
>>  	loff_t pos_dst = args->dst_pos;
>> -	loff_t oldsize_dst = i_size_read(dst_inode);
>> +	loff_t oldsize_dst;
>>  	size_t count = args->count;
>>  	ssize_t status;
>>  
>> @@ -461,6 +469,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>>  		&src_lock->open_context->state->flags);
>>  	set_bit(NFS_CLNT_DST_SSC_COPY_STATE,
>>  		&dst_lock->open_context->state->flags);
>> +	oldsize_dst = i_size_read(dst_inode);
>>  
>>  	status = nfs4_call_sync(dst_server->client, dst_server, &msg,
>>  				&args->seq_args, &res->seq_res, 0);
> 


