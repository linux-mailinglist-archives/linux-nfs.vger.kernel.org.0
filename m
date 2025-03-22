Return-Path: <linux-nfs+bounces-10762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F63A6CB0E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 15:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE24A39A6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37D225A23;
	Sat, 22 Mar 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="luAXZMAC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p5e9uuEt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7B221DA6
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655022; cv=fail; b=iViQpk/xBhqYP7StjUUM4KAhZw0XqE87bhV4eDugOFaxg4lLukgi2k1TeGf+U8L6obo5b2gIthYb6qZlsewMOih70tOGMfdO/sBztneYbkxt1wB+82TXdrye9j+AHE8+p4J43jKABnDFriuwyvXkzeFevJXdKIh4vBj1XbQq82k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655022; c=relaxed/simple;
	bh=e4rShZxQ3mrM3WqFqDigHfLaoKKWoxEPoiYgtYYiEjE=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gz/YwRbC/VdJGeERYFQSukLBHn59lj2XFFMPu/pSq1/6hxY4aFyyXnOoF6SrJGlLS+i8pSwzeM6gUgj6x2GXMi08nYlb3oZ3E3KMeA1WYs1EUGqdk4Kj64+p4xddhWWEpFHP7q0u6618yUV3z8Vgkcp8bEwIy+9lwbdrhDl4C6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=luAXZMAC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p5e9uuEt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5ECva019656;
	Sat, 22 Mar 2025 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BvSYxHQJ3ppKhmtZertaUux8HNgYs2XJUVGtZdB/CWs=; b=
	luAXZMACdITPdGrpT/6fLJPOoMWmkZebAE0/Ryr0V6E0Kyoidox/1E+1D3SBDgOl
	VLR2bc07z6fObTHY5ZASjGOMIVhhLrzMlP2GokCNObq6NPkLFSXj+j66QrDosjRY
	fuDu8Plovi2JBl/bYJ+uKYtvgVdqy3D4Xs5xPAi87m/uYZATVkz71uzrZXxy4QLC
	otJ6XC8JRbRTySQM2njyu1Zh+xhbTalaSwYJC1HusLwe0x5+DSMcROiGRK4SLV4P
	V+f4StF2KPPMjBJreVN7wkpaP5QB4mBHyHimWJdbpYcLQwjVEbzA/1X/zCZ69pFk
	KQiycL5TL6zdbn8+QD2LaQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8b0v38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 14:50:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52MD0Ith003297;
	Sat, 22 Mar 2025 14:50:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6m730-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 14:50:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSi48bVs4J7md0bG1yM834bVEkS+WaN4Q8tCv7igMKVFhIzn/t/P2kGJBQEtUWRvPwYu0EsSxXxRVjCKPQO24lFOhu8NG/TJgykuFPgKp8gw+GXRNUDWqyFGIsNwljCVsbyAF6+MWSKXbPe/trPW1QI5U3ajb213o0ESDlVEXZ9brFQlzhXsrmL+4gE8HyiOUfCRRdZNyBec1/hnCP1sYFmbZC6pGEF5DoaP7m7sOTpVZUHESehPtNY3Cw5WRAtFuEL45SiclrWZihpc+tSpAXNS+UBQRD8094qD6YrwchQb11yqEE8JqEaG+zpn7ffMQxzHrY1CdVIkOLJ9JfUL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvSYxHQJ3ppKhmtZertaUux8HNgYs2XJUVGtZdB/CWs=;
 b=txiPVXawWGNGpoftBAmOkHVnpTmJ0z3o/VZJdDZu4A0lRbslgV8Og7rCKhl5tnVJXZace+/6xKkx2bmQaw3NWZXpefg4uERFOaA09Gc1t7l6EWo73XL8udA51dZ7JgI9QHLQCNizCOAXRZalS7mor4arnl0KKjLvDNtkN1d+6FZtSAOizqVRZfDsu059cwIpanA8i6N+QSb0uj6EMunRWRmPtPm8jtmNl4xdYQMBbyAze2g9LxhGML/YcVVwXkeMKeVUpw6ArTiq7IpWM4UJvsqSDf6iMPElg0q0xiv+HDWfCxnxxNZABmZ3+4LiNGcIQc47iCJ/GjOBlbcphNghnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvSYxHQJ3ppKhmtZertaUux8HNgYs2XJUVGtZdB/CWs=;
 b=p5e9uuEtVq9HiWzLhcJcEv5l7gn9krHuDoi7cTai/DmQr3o9TFGVBhrAko6nNrmRXf5pcdL2RVA2c7GiwV1DFJB7nNS6NF1lzQKPKIzNLd863QKdbf1yeC4q8AEQNVgbtT2IvJ27nOtcrQoGpTRqsOIUg20p8FhLX6wMF4bVASM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 14:50:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 14:50:00 +0000
Message-ID: <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com>
Date: Sat, 22 Mar 2025 10:49:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
To: John <therealgraysky@proton.me>
References: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me>
Content-Language: en-US
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:610:60::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: b938cf8c-3f07-4829-e084-08dd6950d277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2ViNzkyTnAyQXM3NWZPQUhiNXVuK2ZxUFN3VnBtOUk4Vit3SG9XTUN1bGl1?=
 =?utf-8?B?RkpKcS9UbzkweFpLL0JmVmgyTW5ZYWE1dmtSa2l3dnBuRnN0N1Z3WUUrcVlX?=
 =?utf-8?B?VmFXeXdTaFBFclRycGNZTS95VUlONFRnS2IyTFM4VHJucEJQRkdWZldBc2tW?=
 =?utf-8?B?OC81NjZ5UllrSEoxZ2dtZUFPMkRTZnpoOVVxSURHb0lBUnZsVis1QXN4RTVQ?=
 =?utf-8?B?OStpWTRnUVdxTEg4S0hyME1TUDFMY1FkZWZSaW9LL1ZnbnY4U09ZV0tXaDAw?=
 =?utf-8?B?anB3VW5uY3AybkY2c0h6NW1JYmsvTEdNbWhseGl5WE1EcFZHdThvbG1ldjhV?=
 =?utf-8?B?LzBKTC8wUkNBWnRxMzRPNlBoUjBvRnB5TTdnZzhBYU11bnNEOStjWmtVa1BJ?=
 =?utf-8?B?cEF1ZmV6ODZlN1V3eGtKTm9FamtJQzFHS1lsYkh2YUJOajJpeUVobUlaOUhL?=
 =?utf-8?B?WnI2Z0FFVlRqcVBnMnMzaStlb0lFZ2pUcDZsYVhjdVMzZkgySThMSGlIeXJw?=
 =?utf-8?B?Ukt4Vit5MWNXRm5pL2RiT1JYTFZCdWNvazd6ano4dkRKNmM2cEV4SWg1bjlu?=
 =?utf-8?B?blBiWE5yWFgrelhxU09NWVpLNEVtS0FuTUt4NlVwUmExOVhobVg0REtKeDRl?=
 =?utf-8?B?dGRRazVMYnJUVWlyS09LM0xKNUdqcEtuZUkvQWhLM2pHVS9IZEZLK0hta2wz?=
 =?utf-8?B?ZEdsUXJoM01PUUlEUyt3emd3cXNkZGx4d2ttTlc1UXJJSTRKbldHdUQ0TU5V?=
 =?utf-8?B?UTFQTGNmVmZhdm1QVFpyUjNBTmlwaWR3NCtxdE1NWXZ1S0h0czRvOUdidm11?=
 =?utf-8?B?c0U3YWVvSk5BS1ZxanJKUnZ1dHFKbWpFODF0b0Y0cFY1b0JhYkRuWWt1a0lh?=
 =?utf-8?B?MTlXVk9tOXJWa096ZEZFeDNpTWZyd0J4YUNMcXkrNEMxL3dBcjVNU0RUU0cv?=
 =?utf-8?B?VkpzVjY1ODREOE15TTBvTEpuSkhRc2ZORkdRem9CM3c4dzZldnNUQXpQWHVS?=
 =?utf-8?B?RXpRalltNWdSRTAzZHJGd3BTQnBraTF3QlI1Tkhoc2FBTTZDeEphNDZ5NFln?=
 =?utf-8?B?Vk4vc3FUYXo4K0RXNW9FQnJzNTEvblFsQzlscWJtT3J3b0NDVks2TE1ZVjJR?=
 =?utf-8?B?Nk9Gem0rOEV4SHB5M2FmOERZVUd6WWZoVjFuVTNhUkVMTkpOd0lmbHh4RFJ0?=
 =?utf-8?B?ZG56Ym9FOEsxakx4VkpRY2plM2JuT2UwaG1Ca3U4cFphWno5em5CVlpqMDJs?=
 =?utf-8?B?aFg1NVRpTE01YkdyZGZucGgyTFNiTmVFejN1cVpPOTR4aGRhUlJjaFdnZ0lP?=
 =?utf-8?B?UksxbkF2aWJPN0hVTlArL1hmN0h4ME1tNVlBdnlYRms2RkxzKyt4Uzl0Z0oz?=
 =?utf-8?B?bE1weVJwUG9nMnhZeFJkL29ibXU3MVJUU2ZId3N4N1hwM1FCMFRxZDJETHZ5?=
 =?utf-8?B?QVFrQjZzeEF4cWVzcUh6MS9PKzVtbWFYWlZRYXhQUnVFWDJZN1MzeW54RXdS?=
 =?utf-8?B?d29sbk9MYmh5aUU0M1cyQ3E0eE51cWN3U24zUjBDQjlITHhSRFM3SkZ1NTlx?=
 =?utf-8?B?cmROZlVlM1dxU3l1WnFPOXppcTh5VFF2UnBnd05ZUFNZWldRUUg5SnNtSkhp?=
 =?utf-8?B?MFU0ZkdDakg1ZXh2K3dBY2FDdjZab2txd0tiQnpEZFBUVTd6S1Vmb2xVTnZG?=
 =?utf-8?B?dUhYZkhoOS9KLzk4a1lvcE13dE9QYytiRlkyLzZVWnRKNFl3eFhST1dsNXI3?=
 =?utf-8?B?OVp5emZFSkJWblhMUGFBaktQT0NKbWVFbmhXTXkydXNUeEpjUlZFdHZzVHhr?=
 =?utf-8?B?cXVRYXlEdjRRV1lscVFaVzBWRUs4Z0lBeG1kVWs4SnhpWWRwYXRJZWhrVzdn?=
 =?utf-8?Q?W5ahTzBZq0iiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlRSN2xoZHZoTDNDaUorbTE3VFJWcHhQWW9yOW5GRzVuR1ByZ1JON3FQSldj?=
 =?utf-8?B?enc3L1BmL0dLd0xlTHJwa0NYekxPS0hVQ1dUQ0s5WHBrSklVQWsvSWc5bXc1?=
 =?utf-8?B?Z0VIVnc3QWluOC9kSE5GUHd2WlkrcXBCekozakdiV0pTdW1WdnpWTmNJalV3?=
 =?utf-8?B?S3hXb1UreU1qT1kvbjlNVlNMWWtJU0REQS9YL1FGMDM3cFdXaDkxUm1mL1ZM?=
 =?utf-8?B?RDFOV1V2RjJ3d1hacVdpZjl4WExna2xOajV3cmpScUZyczVDVkJOWEJNa3BH?=
 =?utf-8?B?R3NVQ0ZNbjRGRC8ya002cFNFWFhzRDViYkp4TVdTbGN0UVpNU2hBQ1J2MThC?=
 =?utf-8?B?L1FXMnd5YU0wamhtRWhwN0o5STkxUlJiK2tBZ0hkYVI1c2gyYWpTcVNBeC90?=
 =?utf-8?B?eVU4RGIzMXBjb2FISGpXNHJHWndJeWcrRldtMXlBRWM0cWpWcHlzNmVyRTVF?=
 =?utf-8?B?UWtTVWtjUDBMaEkxZ1YzMEM1dzRkYUp5VlB3LzZCcy8yY2lvcUR6NUpYSmF3?=
 =?utf-8?B?NmdiOVNxUHFoUDFBODZzTFo2VWJydEdXTVMvN2xTVEYxVUEyUkczL1FpMEVD?=
 =?utf-8?B?VHcrS3FPeEtMYUtldElBeC82c1FEdklRVGZPY2U5NVBrazFSc3gzWWMzd0Fx?=
 =?utf-8?B?U25ONXVQWjVRM2FZdVhKekRORXluM3N6V0hjeG04NjdqYWhneUpDTEdIc2Jy?=
 =?utf-8?B?YlRWcmV6bDJGUnhXYU5NUWdwNTA2Mlc2UlRlZTF4SlRFelorY2xiaFZtTlo4?=
 =?utf-8?B?NnFMV2VMOTVKVGRSbFdKNWRZTU1UK2REOVY1b1FXUG44Z0dHdW9LUzh5SzIy?=
 =?utf-8?B?TVNhRFI3OHZDN0MxMkpUZjgrRG1HMjErOExJblJsRmR3OWRzWEgxSktuempU?=
 =?utf-8?B?ditDQnBrY3lTajR2eTFlUCsxeWhzbVl6b0ttbkQvOW9tazQxT3RFSHZpZmYy?=
 =?utf-8?B?bEt3TzlFL2NUTmQ4K2dZb1RZOEdBUE9HUkJsbTZkYkI2d2gxWEM2SDdBVHlv?=
 =?utf-8?B?V2VkK3NvUnV6enJGVEpTK2tlNHZscWgwQ3psYmxsSTIzdkt6bVVJOHBuY2pj?=
 =?utf-8?B?ZG11UXRrdndnbzdmNFJZUWlCNUt6MzlkK0lBemt3Nll4REtPWlB0UU5iOEI0?=
 =?utf-8?B?bTNFSm15MUtEd2JGUkUrc0lCV1Y5dC82blZkdWZncFlHVTZxZDN2VmU3ZHYy?=
 =?utf-8?B?dUl3Zk4vUVM4TEcyVFY5bGFyTzlHRDdKUjhIVzlVemtMdHg2RGlhd0F2dWdi?=
 =?utf-8?B?Z0xOWXJqQVl5SThnWjRDdStOWEVMTVByS3gxWk1kL21VN3d6M2tlZlRLczFU?=
 =?utf-8?B?Y0d3M1Nsd3RVRUFsUkpraHZEL21GU2JrNlBtK3o4RW9YTXNsS3QyQ1VER1Rp?=
 =?utf-8?B?Y292NWh3K3NxaGwxR0dWNFE3K2xpbVZrTm1JSjdlZ1ArVGwvY3VvbnNtcWkw?=
 =?utf-8?B?dHBCNGd6ZTlSbFlTSnRLOUcyM20vKy9hM2ZiazRoTVN6bUJ1Y0VxWjRsa3V5?=
 =?utf-8?B?WVVBMFNkd3RDeTNmdjh3T3ZLN0R6QXNWT0k4Q3JXL0xHYnlCWkJzV2tkKzBr?=
 =?utf-8?B?VU5GOGdYMzUxQnBtbFI5ZUsrbDk2SEszOUV1azU3VjNUbTJhdGJRVVM3V2pv?=
 =?utf-8?B?dkpLczF1am8wOGFHaGlyU2ZYTldLVjRFRTg2cHZMOHFqZTdUN3pCKzVHVzNI?=
 =?utf-8?B?VnQxbUVNd09pZTJ6eGJCVzBIbDRJSm94NlVWT0xac3BqcEFiQU1UbG96c01o?=
 =?utf-8?B?V1Q2d2NvRG4reFRYUitzS2JLYXgxbDMrMjF5OFROLzJISGJYMGRJbzN4Q0gz?=
 =?utf-8?B?WDU4V2ZocklNTjFFeEFpM0t0RXNEcVBvS3Z1a0ozVisrQlN2Z3g4OEVYSDcy?=
 =?utf-8?B?NDd5ZUYwUEl2ZWtLZEYvUnpNMHBXeUN3S2l3MGwvRG50b1VxU2R1WnlISDNC?=
 =?utf-8?B?VEpTZHhzeTJkNmFDOWZDdzdrZi8ra1dqdVJMWjhlQXU5czlYTlNGTkdHRFZv?=
 =?utf-8?B?Nyt3ZTFVaDhNT05RRHgwYWVXMHVzd1hNWlU1NFhVRkFEMmpmUGtyQjdQU3ln?=
 =?utf-8?B?TnpQVHozUEt2VUdpZEpycy9tMXFKNTJPY3FJa3IzS2U0U0pKTWo5Y0p0alpK?=
 =?utf-8?B?N1ZuOGMrenVXWElETHRmaG5Jc0lPVS9TcVQzeUlPNGVPSFJ3emY3M2ZuR0dL?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h57vRm55LbGpnsD1vB5ICZNtTL+zF1O8suKPpPVjp4W8iAKT8rThkqS4YaTXU6Nvyn7qL4aIy5i+iNG9PRDPrUzuAUYk0BFB2Wkt8me+b63mT7xCl0PyWq+aDVbOtqhMknWHo4vnTgynkZGFEk5qiubOFhuoe8W6o0yeD0ows6Yb8AbhUcB8PtHLjp7+lqN4oMYluvtmmHC/8lNO8VhWJlBeofWFzvf7iNgjPmmwyn4guZSq4NB7lxSWvtMbkyINSZTXcQGALzw/6v8DqFMAPuLb8RujiBZJFESraJnmnOKk+1eeooFMHXu1TBLi48sRA1jeE9BURfpGG9G6jlY4klAd9qGLKT4CYx2aZwyHVDxocpkqo/eUCgM1zVT88UVR06wg9k5XaT+LGTtTk4kpABg5zDlndH7v1ybRuRVjgDGdaeHY5nRThKcp10b7Jsn6fSAYjwZsJQIWQ7G11yb7ONZLGyV4pR3d53nLd8dP5Ce5lQegNkPFb4CCz78AQBDZ4HgFBlKMJy5xoY3OE3olmX7cGTu5gJyoEnPmRjBaL+KX9CUE2PvAb1oQG/mILRjdCHY+hCrhl++kl2BnqZINa2uIsc1iMPJp6B0f93J1noM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b938cf8c-3f07-4829-e084-08dd6950d277
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 14:50:00.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sTk63d8iwoZtRcVymobkpOahpowxowP3ksOU53a9IRN4dqeraQcko9e/Zai6ZPWDh5eQ7sdgJ4//vJ10q4W3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220109
X-Proofpoint-GUID: E2mM6OW3mWHM9Rx0y6JCc-TwjwBCKyvt
X-Proofpoint-ORIG-GUID: E2mM6OW3mWHM9Rx0y6JCc-TwjwBCKyvt

On 3/22/25 6:05 AM, John wrote:
> Starting nfsd with kernel 6.12.19 triggers a kernel panic. Using the 6.6.=
83 kernel is rock solid. I confirmed this on two x86/64 machines (Intel-N15=
0 based and AMD 8845H-based). Posting here seeking debug advice. It is not =
clear to me if this is something in the kernel code or in something else wi=
thin the distro.
>=20
> I get the following from dmesg:
> Kernel BUG at nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd] [verbose deb=
ug info unavailable]
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 2 UID: 0 PID: 17091 Comm: rpc.nfsd Not tainted 6.12.19 #0
> Hardware name: iKOOLCORE R2Max/R2Max, BIOS v1.1 12/17/2024
> RIP: 0010:nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
> Code: 89 de 48 c7 c7 e0 20 95 a0 e8 08 fc ff ff 41 89 c4 85 c0 0f 85 ce 2=
d 00 00 48 c7 c7 58 dd 95 a0 45 31 e4 e8 8e 7a 0b e1 eb 08 <0f> 0b 41 bc f4=
 ff ff ff 48 83 c4 08 44 89 e0 5b 41 5c 41 5d 41 5e
> RSP: 0018:ffffc9000613bc98 EFLAGS: 00010282
> RAX: 0000000000000049 RBX: ffff888105e06000 RCX: 0000000000000000
> RDX: ffff88846fb21920 RSI: ffff88846fb1d980 RDI: ffff88846fb1d980
> RBP: ffffc9000613bcc0 R08: 0000000000000000 R09: ffffffff824b56c8
> R10: ffffffff8249d688 R11: 0000000000000003 R12: ffffffff82736400
> R13: ffff888105e06000 R14: ffff888105e06000 R15: ffffc9000613bcd0
> FS:  00007f1a404e5b28(0000) GS:ffff88846fb00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1a40411000 CR3: 000000010d47a006 CR4: 0000000000370ef0
> Call Trace:
>  <TASK>
>  ? show_regs.part.0+0x1d/0x20
>  ? __die+0x52/0x91
>  ? die+0x2a/0x50
>  ? do_trap+0x103/0x110
>  ? do_error_trap+0x6c/0x90
>  ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
>  ? exc_invalid_op+0x4f/0x70
>  ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
>  ? nfsd4_probe_callback_sync+0xff6/0x25b0 [nfsd]
>  nfsd4_client_tracking_init+0x39/0x150 [nfsd]
>  nfs4_state_start_net+0x2ce/0x370 [nfsd]
>  nfsd_svc+0x1a0/0x2d0 [nfsd]
>  nfssvc_encode_voidres+0x19a1/0x1be0 [nfsd]
>  ? simple_transaction_get+0xb7/0xe0
>  ? nfssvc_encode_voidres+0x18f0/0x1be0 [nfsd]
>  nfssvc_encode_voidres+0x1a3/0x1be0 [nfsd]
>  vfs_write+0xcb/0x390
>  ? putname+0x4c/0x60
>  ksys_write+0x57/0xd0
>  __x64_sys_write+0x14/0x20
>  x64_sys_call+0x79/0x1780
>  do_syscall_64+0x7b/0x190
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f1a404c9659
> Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4=
d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 82 d8 ff=
 ff 41 54 b8 02 00 00 00 55 48 89 f5 be 00 88 08 00
> RSP: 002b:00007fff99aeb2c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f1a404c9659
> RDX: 0000000000000003 RSI: 000000000040d360 RDI: 0000000000000003
> RBP: 00007f1a404e5b28 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000020000 R14: 0000000000409112 R15: 00007f1a40430dd0
>  </TASK>
> Modules linked in: xt_connlimit pppoe ppp_async nf_conncount i915 xt_stat=
e xt_helper xt_conntrack xt_connmark xt_connlabel xt_connbytes xt_CT wiregu=
ard video pppox ppp_mppe ppp_generic nft_redir nft_nat nft_masq nft_flow_of=
fload nft_fib_inet nft_ct nft_chain_nat nf_nat nf_flow_table_inet nf_flow_t=
able nf_conntrack_netlink nf_conntrack libchacha20poly1305 ipt_REJECT iavf =
i40e curve25519_x86_64 chacha_x86_64 cdc_ncm cdc_ether aqc111 zstd xt_time =
xt_tcpudp xt_tcpmss xt_statistic xt_recent xt_quota xt_pkttype xt_owner xt_=
multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_comment=
 xt_cgroup xt_addrtype xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY xt_CHECKS=
UM wmi usbnet unix_diag ts_kmp ts_fsm ts_bm slhc sch_cake poly1305_x86_64 n=
ft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_quota nft_que=
ue nft_numgen nft_log nft_limit nft_hash nft_fib_ipv6 nft_fib_ipv4 nft_fib =
nft_compat nfnetlink_queue nf_tables nf_reject_ipv4 nf_log_syslog nf_defrag=
_ipv6 nf_defrag_ipv4 macvlan lzo_rle lzo libie
>  libeth libcurve25519_generic libchacha iptable_mangle iptable_filter ipt=
_ECN ip_tables forcedeth e1000e drm_display_helper drm_buddy crc_ccitt cdc_=
acm bnx2 atlantic af_packet_diag sch_teql sch_sfq sch_multiq sch_gred sch_f=
q sch_ets sch_codel em_text em_nbyte em_meta em_cmp act_skbmod act_simple a=
ct_pedit act_csum sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_r=
oute cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact=
 configs evdev drivetemp i2c_piix4 i2c_smbus i2c_dev xt_set ip_set_list_set=
 ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_hash_=
netiface ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_=
ipportip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ipmac ip_set_has=
h_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set nfnetli=
nk dwmac_intel ip6t_rt ip6t_mh ip6t_ipv6header ip6t_hbh ip6t_frag ip6t_eui6=
4 ip6t_ah ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables n=
f_reject_ipv6 nfsv4 dwmac_generic
>  stmmac_platform stmmac nfsd nfs bonding ixgbe igbvf e1000 amd_xgbe ifb s=
ctp udp_tunnel ip6_udp_tunnel mdio netlink_diag udp_diag tcp_diag raw_diag =
inet_diag rpcsec_gss_krb5 auth_rpcgss oid_registry veth lockd sunrpc grace =
dns_resolver nls_utf8 pcs_xpcs macsec ena ecdh_generic ecc xxhash_generic c=
rypto_user algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_sss=
e3 sha512_generic sha1_ssse3 sha1_generic seqiv sha3_generic jitterentropy_=
rng drbg md5 kpp hmac geniv rng des_generic libdes cts chacha20poly1305 bla=
ke2b_generic authencesn authenc arc4 crypto_acompress nls_iso8859_1 nls_cp4=
37 r8169 mdio_devres xhci_plat_hcd iTCO_wdt iTCO_vendor_support fsl_mph_dr_=
of ehci_platform ehci_fsl igb igc vfat fat btrfs zstd_decompress zstd_compr=
ess zstd_common xxhash xor raid6_pq lzo_decompress lzo_compress libcrc32c d=
m_mirror dm_region_hash dm_log dm_crypt dm_mod dax tg3 realtek phylink mii =
libphy tpm cbc sha256_ssse3 sha256_generic encrypted_keys trusted
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
> Code: 89 de 48 c7 c7 e0 20 95 a0 e8 08 fc ff ff 41 89 c4 85 c0 0f 85 ce 2=
d 00 00 48 c7 c7 58 dd 95 a0 45 31 e4 e8 8e 7a 0b e1 eb 08 <0f> 0b 41 bc f4=
 ff ff ff 48 83 c4 08 44 89 e0 5b 41 5c 41 5d 41 5e
> RSP: 0018:ffffc9000613bc98 EFLAGS: 00010282
> RAX: 0000000000000049 RBX: ffff888105e06000 RCX: 0000000000000000
> RDX: ffff88846fb21920 RSI: ffff88846fb1d980 RDI: ffff88846fb1d980
> RBP: ffffc9000613bcc0 R08: 0000000000000000 R09: ffffffff824b56c8
> R10: ffffffff8249d688 R11: 0000000000000003 R12: ffffffff82736400
> R13: ffff888105e06000 R14: ffff888105e06000 R15: ffffc9000613bcd0
> FS:  00007f1a404e5b28(0000) GS:ffff88846fb00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1a40411000 CR3: 000000010d47a006 CR4: 0000000000370ef0
>=20
> Here is /etc/exports:
> /mnt/data/nfs        10.9.8.0/24(ro,fsid=3Droot,no_subtree_check,insecure=
,async,all_squash,pnfs,anonuid=3D99,anongid=3D99)
> /mnt/data/nfs/misc   10.9.8.0/24(ro,no_subtree_check,insecure,async,all_s=
quash,pnfs,anonuid=3D99,anongid=3D99)
>=20
>=20

I recommend bisecting between 6.6 and 6.12.19 to locate the culprit.

When you have that information, open a bug on bugzilla.kernel.org under
Filesystems/NFSD and attach your information there.


--=20
Chuck Lever

