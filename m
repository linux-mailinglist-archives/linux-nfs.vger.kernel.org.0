Return-Path: <linux-nfs+bounces-17225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED318CCDC0B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF20F3015003
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A127B34E;
	Thu, 18 Dec 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sFNGr8bm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hS9ZIow1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9E299A90
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095474; cv=fail; b=hoso26j4RG+mcFa3z8JPT4RoEpvBMD2WRA6DPN6BTJwSDgHSkFzHI94bnNLJ/gxjucR6ope2hUoWOj+3b0pGWDDgUv8qZE+GCVO16arfLRy8KzgKKC2K38Ne2SG0ujJl+51mxjaR1TceRZ4c0nWdBm1p+Gw5F3sTu4rXdvlGgSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095474; c=relaxed/simple;
	bh=Bct2JE73Is+uyJeF+aL12uZGvApBGZvGzi/L9+ne/Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtAseCBVuGIdMkcvCIIo692QCBpg/oNlV3Svi58xVKGeKpq+P+9p8N6u4Vg3VYtMzz+Ld002VwH6PH8R88pvFtmXmsFRHXPasED8wRSh/Clyw+Pfbk6QeW6AMZKkvh+KGgxI56pOTy4gsMiO4PT/VwaUa43LWAXpT0aY89TAqzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sFNGr8bm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hS9ZIow1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjtSu2087721;
	Thu, 18 Dec 2025 22:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xhrnV/E+14YN+A5dn/grIyZOIlKdLWQ7mL04qvwikD8=; b=
	sFNGr8bmef5a0sCdEjfPkIg+3ucOuMcpoN1PCz/uKcVcfS5zAIT/X9PEDduejvNZ
	GagGEil/jNRCsEYfmq478VRK6ZaIlsL2nhVGhe7OcT3E/6Vnpx75LoTbjS4vrk2K
	iWb/mBOIxcEcY6EdAHelFmI3+741rV3VSq5vfuSj24A1VnrIDJsUPxbz7MVQQstu
	WKpRHBupoiuHjPDQJJ5NXG35AGkp3VKO0gBpYcrZBmFbwadCv1jzpAn7YOj9HqR7
	wYtQ8DReyPuyAPSEmZoq1JgjhzR3+enVcNcs2UhAbs/1lurLUiHGNh2YnYE4YNH+
	jNNAPFbTruCUZnO9JsWqbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2a8658-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 22:04:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BILU8dr035634;
	Thu, 18 Dec 2025 22:04:13 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtrw6vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 22:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezdqCYXmh3pMgXL5lturrIp02kBQbuHtlEMWkw/+YjXCECxa8+dwJGT4LcqQfquNa96QBbr1IbdqxYoZ5OeR6DfQM1kN3ijZQhIl4hjtdhrqijcUtHu5PCkItFazWbU6CWnQuVQORvk3HwT36qkgmsPJhDaY3+k7z3w4mk/fKwMLMFR/MeyFlownwswvIhfemiho4pxDPdRuj6PuvhWxUUjQE1WLgS5b8b3c85/26z6iOP20oKVclmrFYSNgLr1N2ZQ1oOE0QX419vmJLrMRGKA9YW+9OiLrMRq6pmeoFcaB6X9mtw5m79FcshBgzs6EgixyQxpgIMo4mFrUe+HRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhrnV/E+14YN+A5dn/grIyZOIlKdLWQ7mL04qvwikD8=;
 b=scMcZBvWEoSrQkyBogPHC7HxUIuT/pAqm7etaE3mEFMpb64VoZzR1/v7danE2TmaotOBNl4mifXhVb+xRKt1L/29FEROxnu4pGnknQ0rG8k91LIXZ6pZuMo/Ja5FOWEKQsRigzq3ykO3NfXZcvHuLIR81zrZlc0Cg2yt0kFHCW1r0boRP3vTkCFcDjuvhIPbS61dd6rTsZ2CkEqB0edJZyVUQo5wVs+dmbV9BqpIIa0TnjLC2F3tKl1/PuUBvCU0HRBcjyQfpIyxGnBSbdiXRGcD6g/lsPuZvgPSrI85ou7AyEmNDUwnu3ZkkUe0IIbm9UBndpJO6vizBZoJKG8ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhrnV/E+14YN+A5dn/grIyZOIlKdLWQ7mL04qvwikD8=;
 b=hS9ZIow13b1GBuUxtZnEz5H+dEgc90X5lSCdwdxNGvuYo+UwXD36Cz6E23G32e/fhEECTnaOAy+3Uiv6XlVi3WtXgVpWu03+zvupTHlzvBxHG7NE39Oj76XkruylJZo8yfml0OqBb/ziSA+dSqjzvNCzBMlQBNxSFMwlVytwe9w=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 22:04:08 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 22:04:08 +0000
Message-ID: <13891f50-73a1-40ee-aaa2-373dba3886e6@oracle.com>
Date: Thu, 18 Dec 2025 17:02:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] NFS: return delegations from the end of a LRU when
 over the watermark
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251218055633.1532159-1-hch@lst.de>
 <20251218055633.1532159-24-hch@lst.de>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251218055633.1532159-24-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::20) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: a677a785-7ca9-4fed-1749-08de3e815da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElnbDcrSDh2d3p0NUFKWGxremtyMGx5ekFqcjFETHdyTk9XZjZzT2RpeDdU?=
 =?utf-8?B?Ni9IQXIwRGNUWXN1VFlxUkM4VEpleU1UcVZkMGxFbUlod1lwajJDeGdXc0x0?=
 =?utf-8?B?Z2d0Z1ZwQUl1SXNHdmlCTXdaajA2YklYZmI1UnhScTlxYStrMmU3eWxHby8v?=
 =?utf-8?B?d1JCMGpweFRybDRSMTV3NHBtaHhoQ1NOeWNMUGhodHFVcnhsbHVZbjJQOGNE?=
 =?utf-8?B?UmxVamVQZXJoNFBTSG1zMWV1dEk1MTdVMEpDeVFDRUJCWnA5TUkzbk5NUUtr?=
 =?utf-8?B?R3Arc05aK0FMenhWazNiZmh3dzQ1Ukc1S1VIKyt3bnhlSTNFKzJ0b1lXbHRY?=
 =?utf-8?B?ZnB0NFVuUFVZejBPSlJlU3djVFNJTG5ORk9ibHR1M2xOK3l2ZW9Ic0lPZjFG?=
 =?utf-8?B?RU5RWk1nYTd3cXpvSXpyeUVMb1VDZlpYYzJqQlRadTM5TVluRVFQUnR0VnQv?=
 =?utf-8?B?ZmVmRXdIMitrR1lNK2ZQa2o5dS8yR3ZMTHE5OUdSS3hBTTJoVHM0c1JVMGJj?=
 =?utf-8?B?bC8rZ2R1d0pZa0cxOVVXOWIvdU44KzNxSDJMT3FPREpLUEJHYUFaNmFueVFW?=
 =?utf-8?B?QnZXS2kvWTQzQVNoUmhHcEpPZzNYaXhURUZYSXBpU2F2SXRxQXc0aVlhYVYz?=
 =?utf-8?B?R3dRa0lJM2tyZVJvQ0lPMmtGRC9XVlhBbGlUMVlMNWl1VDhOKzljNExhYnR4?=
 =?utf-8?B?UlNTUUw5a0hDZFhCT1NCdXROTHZCbkhuL3kwSzRkN0h2a1hTTU5YZWdHa3dy?=
 =?utf-8?B?Qy9JSlZDeWpyN1g5dy83RXVUbExtZ2pYNUEzUWwyQTloR1NjR2ZORlJGNDA5?=
 =?utf-8?B?Y3lVVDNhMFNtbkEyLzB5NGF6UFE3YjhhZkU1ZjJ0Z2Jpak9WS3hHbU1NWHU4?=
 =?utf-8?B?RGpVZ0RnMWR5a0JUbXVWWjVVMXhZZDZ6VFh3NXplOWpmRjgxNEFWYXRNRWJZ?=
 =?utf-8?B?dHdVTWUrbHQzWWZFTWZGYkxsQXBLRXNjQVpCV3lVSU9ZVXQ2TzJ6UVpKTWYy?=
 =?utf-8?B?TVRUbkxjeUlaNmFrUW1ZbmlZWUZOdzVrN3hpdjdyR2dVZ3RxRGFuZWVCWUtZ?=
 =?utf-8?B?NWV5dUtFSkxGTXJSc0k5Q1ZkRDdwMm1vblVESkxrVnR1ZkNJU0FIWm1GZERU?=
 =?utf-8?B?M2hvdWpqYkRTckZMcGs2ZTJURlUzZ3M4TFQ5Mjd0bHNZaytqWUJHSnBFU2Zy?=
 =?utf-8?B?bEF1ODdlbEROdUxZb2p5QzZ1ME5GWVlmb0tzMjlVMTFOK3pSYlhkM3BzZVRL?=
 =?utf-8?B?czY4ZkgzajE4SU9VQnNiT0xBMjgrYjJwK1FYZmpUQXJNY2xFUSs1ZE41R0NS?=
 =?utf-8?B?cFQ3SG1zNEpWTjhzTzNHamgrMFl3U09rZm5qTDJmdWJnV3l5VXRxWXRIbGZU?=
 =?utf-8?B?RmN5TURGdnl0YmlRdFNyVUo4cm5GeFFRdTNncGkrbjNSam5MNk1XSWdiK0o1?=
 =?utf-8?B?RTdMUjdSR1lzN2VYVlJrb0hva0NnMEFjbHlRSDNTOGEwWG4zMm1Xd2Npc0Nk?=
 =?utf-8?B?clVaSDBQQ1g2Z2hwcW1uT1RiWTAyL3pXTEFyZjhqOW0xSitBb3N0Q21SL2ZC?=
 =?utf-8?B?UGY2T203Nm9ZbW5VM0FJelNvT29yNmFnZlpYUnoxN0I1Zy9WdU95bFptM1J3?=
 =?utf-8?B?K2tpdHd6azBiNkNsbVJLamFnd1JCSWp4TVJqQUN3QWtZajV3Qm8xSU1OUVl1?=
 =?utf-8?B?Z1Fxa3Y1Tm5OWVd1MDZlb0RwM3JiVjE4MmtCaDhndHdsc3RXVkNSTEthdUdy?=
 =?utf-8?B?cnNUVWpWTGowbGR5d0N3UllLWXVsWDVzUnRXSmswYkU1Tis4ZEJGRVFKZTRz?=
 =?utf-8?B?QXdLYiswelpFNHRzOXJtQVJVdVdwcVprMzRIb1ZadXp6V0diNlMzOW0zQjVO?=
 =?utf-8?B?SzNOZXgwQVIyeDk2T3dSbU9xRm9ObzQ1QmRNZGFIRzhuNzAydkRqRlhxRkpp?=
 =?utf-8?Q?FO5nBlxmOKqZIV267VGliuQSyb6e5GtU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TklSZW1samF4RERZWmpqZlV4RDN6Z3FteWdCeStWVDdqUGtmVG9jQTNDTGlO?=
 =?utf-8?B?SU9KRXVqSEI4aGdiWGJiNG5VTnZQY3ZzbGdhcFFJMklZc0tpK25EdXIwdmRu?=
 =?utf-8?B?cWhVdGl0K1ZyY0I0YU1qZFFYa3JleFRMYmJGMXhTc2dpekhCOHhqNTA2UjE4?=
 =?utf-8?B?eHAwdUtEVWtVR2k0OWlOL3BzbUpWaUprWjFubXRFbDBKdzZBTDlFZnNPa1Qr?=
 =?utf-8?B?VGFyc3BiQWh6STlvR3NaMXVuWlVWN29rcFhZYTFOTTNTS3p0dFlRTjAxMXFC?=
 =?utf-8?B?SlBVYmZaRU1JVHAxSHJhVWtZU1lDVklFYm41NlJoeUg1dnB2c1lZcTBTTk9E?=
 =?utf-8?B?K1VSaWZaL0M5bGFsenZzQlJZaUM3ZE81MHI2NlZyODFuK0N5aTF6QWVEUzFK?=
 =?utf-8?B?L3VteUgvSmYxM1VPVE4zdlRUcEZXYzJZZ1FjdlI4RSsxM0lvdVN0Y1p5NmQ5?=
 =?utf-8?B?VFVZN2VnMG9wRzlabytEbHhQSmx2c25zKzA0QzR2VDM5Tk1oS1daVm1ZQjhv?=
 =?utf-8?B?ZG1jSW0zbnVESEJWUG1pSG9XNDdyTVJ0MWJsS094R09QcVRqZU91Zi9LNGpi?=
 =?utf-8?B?NHVVOEh5eVV4M1I0NnZCRUl0L0FKZm9sSEZXeXpGM2FuK1hIZkppcXFDTk0r?=
 =?utf-8?B?ZTBOd2xnM3lUcjZqa09jU2U5MXltMFRUMVFMSnhpTVpYcUFyT1lPajhVd056?=
 =?utf-8?B?UklCSWFrNEk3OWlZSnRncXF1SUxIWXpkbmZ5V2FGVEo3YW9NSDVIZ3FONzBL?=
 =?utf-8?B?S050WXgxRm94YXZ5Mk1mYjEyTTBFY1haS0h0cE1odWxZaCtqVW5TNy82aG9i?=
 =?utf-8?B?cSttaFFnbEhpUktsbVExbkRBRkl2UzE4UytPTkIydkNZMHh4dzU0YjdGYTZX?=
 =?utf-8?B?S0h2dXVHTng1czF5SkxzcVVhRWxRNFlPR0lOU0VuN3lGTnlaQzVPcW91Q3Av?=
 =?utf-8?B?ZCs0WjVWZDgxZHhFakFWcFIvVkVkWjJKU3lzRnFRaVYzVWtpSG55c2JUMVJY?=
 =?utf-8?B?aGR2VWFLUzVNY2J2UzJtN0lLQ3dLTWhxdlBzM3FlbE9TYVpSWGhLVWZiZ0lP?=
 =?utf-8?B?TmlDVEMwWXhTc3VRM3ZvVk1sZVRDV1NVenVVeS9wbGE5bEl1Wk5NaWNrejc1?=
 =?utf-8?B?ckVuY2d1TVd3dHBYK3pkeUpWVzgyVjZBOWdjYUYwNFphZ1JNNWphM0tIUDF3?=
 =?utf-8?B?TEl0azRUak9aL0lVVlk3RWJ5dFJmV1BuR3BDcHNVZWMvTk4xT2J2M1Q3YkYx?=
 =?utf-8?B?Y21oUitWUUNRbDkxeUNta2dUVXhEY3hGbEs4TFUrWWdaeHl4VE9YQWlRWWQx?=
 =?utf-8?B?elpXRGp1UzJKWktCWmhoMUk4aHU3NmdvYUdzbVZiNm45bjdsMlc1NkFQMWZa?=
 =?utf-8?B?djdHYlBESGxaOE5GTWZCZnAvRHhMYWFMWWxDcEVxdkhNN3NUZ3VvQW5ZOG94?=
 =?utf-8?B?Uyt1TUFFNDM1MjBQeWhSQmNKR2pNTmRVYmk4SHArRldCOFg0bGk3Z3FKaU44?=
 =?utf-8?B?aGVJOG9GRHdibUtIaTFzOTlMSkhGcVdabldJdysraVFtZ2M3ZTBJNU5oUjRG?=
 =?utf-8?B?bVZtcTUxRkRBWUFtQm5zS01YUGdXKzhBekJiOFlldmFkcEl2eDVRMlRiSHN4?=
 =?utf-8?B?czZHT0poOVloSFpLNVQrSUg5aGN3SThKUm1UWjNvY05XYjU1MTFMd0NrZ3Ni?=
 =?utf-8?B?VUhsSGYyZTI5Z3RVbjJuRFZPMERtRHpwcmU2OVByN0Rhc0EzSnpNbHg3RDA1?=
 =?utf-8?B?cEcyS2kzSVM4cy9oUFBZL1JzejdJVGtRdXhsays2UWZRMXVKRFozanJwTk1n?=
 =?utf-8?B?ZzhNcnFzdVNzV3FTc3oyWDNCR2gySmRnYVJ6K0JUOXA3OWp5VkRWenFpNkNE?=
 =?utf-8?B?WkFsYXc3cEswcW12YmNqQ2dUN0dlTGt1b1ZCNkYzZUQ0a3lYNG9BbzFTMEFi?=
 =?utf-8?B?aStseEVRcmhFeWhjdlNucFowVHBWRkIxM1g1Q3h5QVVSbkJGZ1JIVHJSZDdh?=
 =?utf-8?B?R0taWlYwSld5bnVNaDE3SDlqSkQ2WVBhMnpoemsyVG9BQUEwN0ZCOWNnZ2hv?=
 =?utf-8?B?SVF4Z3RGR2h4UVNvLzVXTmVvSHVwTThtNFBsMHRGMjU2anVNTVhuRk45Ujc1?=
 =?utf-8?B?RHAxUy9HMmZlcU8vUko1OU1TS0xLSHlSc2hMeW9IaHV4VEZDd0QxYzNmOW4z?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ICljQJn4x8Gt8axIKUHn7V7P6OA7+3z9VTso99iH4Xu6AHCwWV6g63fuGovKV9auZ5XcOFTziHWaEKlT/Birl3hIa9wiF4FqVgnvCybKsF6eWp8BeHibEuiMai8X8J2aeWgRxi66p90FlX/9vxrw81wTQUo/qKk9FxIdYPRVCldBtSUcPTjTMrXj1gZPw9ZNk0jwasLPIsFdgQ80csmnOOzDMMU507dUZs0AVCaIZzrk5BSmnPkD4ACZU6lIJwUDffidQMMKKNrWzjRpxHctAhdzDvXQk346+roBwUFmvEoX1iWNPFLTObj5KtHbp4YuQQpQzEQztWT5ZhxpYnLAENbQ4Xue+NVpyiXfnq0/iDD5c/pnpqdeBnAvGqIOxaDkqUgZpJ5Em1L+rmkl2mpMjzXR0+IbN9ucwB1y0Iq99gJYaIWVLC9iGGkXU6ZeZMhyuD5M3ec6Ni29xsyZ1KnBpDtVrN/xJmK8CzbjA4iSUAoG1d77gTIzhZDCQT6QUUuIhn/+Cf9fMBF/f7Xey1hgCa39BNgDyxgN5moWEsQOa0mFJb2LmKwDjlp/G0kBQdh5DLQoOS8cfIBhdT5ePauBNC60LeRcm+CBynuhIbCxDuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a677a785-7ca9-4fed-1749-08de3e815da5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:04:07.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ1Owr2Q8NvQg34Hd6EM+tpZc0ieZYfqFiEovRieLwNstGlwpy1ANBPJcwKX3mCZ2cjn62cL0U5uu2Nd8LJY1mRCcoZsg9qj3OgAJuFK1To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512180183
X-Proofpoint-GUID: 1BTrDT6WFzE6ULQrXN466pW8EvxGvVah
X-Authority-Analysis: v=2.4 cv=bdVmkePB c=1 sm=1 tr=0 ts=69447a5e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=gbZHxKEZqe_2Lj0Q:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=J90d88RKtMBzFCpusrkA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE4MyBTYWx0ZWRfX1ptOgTo4solg
 vbapglnfoLHkMQD0Tfzlcctt9XlLgal8LjoFpVYmbCf92pQOS8YG6WAFcerUVeinuHGu4VvT2MT
 Mj8qfGdFWmBasbmwQkKadaa9RFRVotnnADa0JMoLOHG0WCdkQwl1dgqnr1nEFVsfv0/sFnHvEFO
 Q1yeLp/DRqQO9Yvc/5/6YRs37TYJbQQIYTCa0cd4cCrcOyx51IDNdE/x7556R9FRxd9rvrfwao5
 7q4uUwndTi+y8wOgYZoONaFhdlE+pvufyNofyHfvQ7DzrzFiNWwrCOGGH4faKQ35BiXheYOnpdK
 wTym4hebc9bqHaCj2+G0fuAvO7quNaBeFfUK+RabSxDYJ8IfDHWOAfpB3q8/6yInanoem24qOoi
 kqBzI8flj7FGQmMC445n/+7Mf1pc7ws3HrUO4hWei4a8OSS7qaKUiECY6ZH+0mBUzkTLtREqq8G
 rOANpa6ejcU/xVgCq/59hmnsr3tzWf/ENMbLY4uc=
X-Proofpoint-ORIG-GUID: 1BTrDT6WFzE6ULQrXN466pW8EvxGvVah

Hi Christoph,

On 12/18/25 12:56 AM, Christoph Hellwig wrote:
> Directly returning delegations on close when over the watermark is
> rather suboptimal as these delegations are much more likely to be reused
> than those that have been unused for a long time.  Switch to returning
> unused delegations from a new LRU list when we are above the threshold and
> there are reclaimable delegations instead.
> 
> Pass over referenced delegations during the first pass to give delegations
> that aren't in active used by frequently used for stat() or similar another
> chance to not be instantly reclaimed.  This scheme works the same as the
> referenced flags in the VFS inode and dentry caches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm seeing fstests hang on generic/013 after applying this patch and running
with NFS v4.0. Other versions of NFS still seem to work just fine. Have you
seen anything like this in your testing?

Thanks,
Anna

> ---
>  fs/nfs/client.c           |  1 +
>  fs/nfs/delegation.c       | 61 +++++++++++++++++++++++++++++++++++++--
>  include/linux/nfs_fs_sb.h |  1 +
>  3 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 65b3de91b441..62aece00f810 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1062,6 +1062,7 @@ struct nfs_server *nfs_alloc_server(void)
>  	INIT_LIST_HEAD(&server->delegations);
>  	spin_lock_init(&server->delegations_lock);
>  	INIT_LIST_HEAD(&server->delegations_return);
> +	INIT_LIST_HEAD(&server->delegations_lru);
>  	INIT_LIST_HEAD(&server->layouts);
>  	INIT_LIST_HEAD(&server->state_owners_lru);
>  	INIT_LIST_HEAD(&server->ss_copies);
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 25f4bb598fd8..712cdb3381ad 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -657,6 +657,60 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
>  	return err;
>  }
>  
> +static inline bool nfs_delegations_over_limit(struct nfs_server *server)
> +{
> +	return !list_empty_careful(&server->delegations_lru) &&
> +		atomic_long_read(&server->nr_active_delegations) >
> +		nfs_delegation_watermark;
> +}
> +
> +static void nfs_delegations_return_from_lru(struct nfs_server *server)
> +{
> +	struct nfs_delegation *d, *n;
> +	unsigned int pass = 0;
> +	bool moved = false;
> +
> +retry:
> +	spin_lock(&server->delegations_lock);
> +	list_for_each_entry_safe(d, n, &server->delegations_lru, entry) {
> +		if (!nfs_delegations_over_limit(server))
> +			break;
> +		if (pass == 0 && test_bit(NFS_DELEGATION_REFERENCED, &d->flags))
> +			continue;
> +		list_move_tail(&d->entry, &server->delegations_return);
> +		moved = true;
> +	}
> +	spin_unlock(&server->delegations_lock);
> +
> +	/*
> +	 * If we are still over the limit, try to reclaim referenced delegations
> +	 * as well.
> +	 */
> +	if (pass == 0 && nfs_delegations_over_limit(server)) {
> +		pass++;
> +		goto retry;
> +	}
> +
> +	if (moved) {
> +		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
> +		nfs4_schedule_state_manager(server->nfs_client);
> +	}
> +}
> +
> +static void nfs_delegation_add_lru(struct nfs_server *server,
> +		struct nfs_delegation *delegation)
> +{
> +	spin_lock(&server->delegations_lock);
> +	if (list_empty(&delegation->entry)) {
> +		list_add_tail(&delegation->entry, &server->delegations_lru);
> +		refcount_inc(&delegation->refcount);
> +	}
> +	spin_unlock(&server->delegations_lock);
> +
> +	if (nfs_delegations_over_limit(server))
> +		nfs_delegations_return_from_lru(server);
> +}
> +
>  static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
>  {
>  	struct nfs_delegation *d;
> @@ -822,6 +876,7 @@ void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
>   */
>  void nfs4_inode_return_delegation_on_close(struct inode *inode)
>  {
> +	struct nfs_server *server = NFS_SERVER(inode);
>  	struct nfs_delegation *delegation;
>  	bool return_now = false;
>  
> @@ -829,9 +884,7 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
>  	if (!delegation)
>  		return;
>  
> -	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
> -	    atomic_long_read(&NFS_SERVER(inode)->nr_active_delegations) >=
> -	    nfs_delegation_watermark) {
> +	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
>  		spin_lock(&delegation->lock);
>  		if (delegation->inode &&
>  		    list_empty(&NFS_I(inode)->open_files) &&
> @@ -845,6 +898,8 @@ void nfs4_inode_return_delegation_on_close(struct inode *inode)
>  	if (return_now) {
>  		nfs_clear_verifier_delegated(inode);
>  		nfs_end_delegation_return(inode, delegation, 0);
> +	} else {
> +		nfs_delegation_add_lru(server, delegation);
>  	}
>  	nfs_put_delegation(delegation);
>  }
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index e377b8c7086e..bb13a294b69e 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -261,6 +261,7 @@ struct nfs_server {
>  	struct list_head	delegations;
>  	spinlock_t		delegations_lock;
>  	struct list_head	delegations_return;
> +	struct list_head	delegations_lru;
>  	atomic_long_t		nr_active_delegations;
>  	unsigned int		delegation_hash_mask;
>  	struct hlist_head	*delegation_hash_table;


