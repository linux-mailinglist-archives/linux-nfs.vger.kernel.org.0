Return-Path: <linux-nfs+bounces-9148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7163EA0AB97
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C26E3A5BA8
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806F1BB6BC;
	Sun, 12 Jan 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BXAe8uqG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NI04h/+l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D40137775
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jan 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736708252; cv=fail; b=XxEGVKh4VBEQEb7pyRsfb8/3pZG0pa0B/eg7TK0Fi1mOojPLZjXMSQCqCxqWj5YBju+L3iRwRUEAnOgIigWsL2krtXChi9ogcRAnYsun4qaj/SU0OTYoeePxgLXtaU97aknMuvMT159pwLgueIWwBcc8QaCwBZogUowWQaU12Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736708252; c=relaxed/simple;
	bh=vSMjFfM3gsuLk7B7EWZ313j3OoRAMxQCstTfZkmPh24=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pK4lYLX8uq1WgWje5scLBJCPD+Icdq73qm+WrAlpcJKHyigMmtgW2ob0fZFaocGVyn28gPagTHoSaY1oRAWcEQd9Egrga3bE/fe4i9WyXsRZ4mm/3Z84WMBY+2WxytlPhoU55R5iLfQQgkbtJaJNDEb85hxjKUnXMZJIy6qnijc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BXAe8uqG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NI04h/+l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CI6YoQ024811;
	Sun, 12 Jan 2025 18:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WRb0KCuf5PeJ/SkiYRWc1lNyOdODtSyHJ+0noBQeuBE=; b=
	BXAe8uqGsv68/0Lb1x88pXAOpepbT9Cd9KQASq3PXrmsUHCg0pA2xiHwnfVfHYQs
	DZvVXXkYkY6oI5f3nKoGxg130nkqXHV8eIO7hH5GJWaY05qO/Z6CxsJvS+RxehpW
	Y+fcZDSqYws1N+2m39yoyQCZrUe1JOJgb1uB3vTMi2Hnsnm92KMJHELtUkRIsCr/
	GpDZxdOqdb3AGm9Yfy/V+U/PPepOpcVeT7iAe8BiuuufND8IQQZS2uTHCT9J4c3E
	XuJuMSwypuyXxzaCWW711goh9LqpnWvIpqqB2Bjb9nfG933ZpJfRof+ATFkKbtpF
	TT8R4e3RKDebQqGQjwQ8dg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcjm1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 18:57:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50CE9Obt037073;
	Sun, 12 Jan 2025 18:57:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f36s01n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 18:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYetp9CfDoQeF3NU6nGPoAWGPmdhwa+KsmEYKZ2VNz5RGnqCB0dvYuLqG0gMkCG1FMO+i3hvj6mYG0uSuqOPF7qo255F8xpv3BgWuXnDa1keqODPX0Gpmsj/rCwH2KqdoPm/F965bop/neg+ay6mcNBisn/qEW8XYd90nOHOvGbGJ1Ox151z7PbzXYMCTORxy0F8ur2Zf98z2rdv4mLtwaReTvH3q1/IMeCb1VIljuqcDi2vB+z1XPG6QTpEN5c+Ansg15ijg99zQ3DUBVMHQbKSTVUJeOkSd5FGg+E1HceyoEIQOJmXb9kyPceP/q+WXOBbEEJVIN2U968VX5GCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRb0KCuf5PeJ/SkiYRWc1lNyOdODtSyHJ+0noBQeuBE=;
 b=B0Ai8h9fTD/bOxPBc2Wf/oRinJL5a2VXVX245oOZjxpMspVaWA/yD6Eo5V4fZOqUcSjjku1si+5mwDzrubFnB/VWldAcX2l9ywx+sFddQvi5Actoh8HfS9d/cTej9f4PRjca4666ed1LFqrkcxxTnj835J4UMvCnCtig9/5oWru/cuIf8COvWErpqkbRD8sHdEHC92JvcTKoN/96y5LwGF6OgVEidLhg0CYEJzDBtlKWzo+OHEi0mtKOacBmXll/H8/SezXVqe8RjoQtkpv/GjuPrQHVzs2MczGm6HJ7knN6p54mwP34gF8QQmFyEJ3fD7TV6Xt1zAD6aCPO4bimeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRb0KCuf5PeJ/SkiYRWc1lNyOdODtSyHJ+0noBQeuBE=;
 b=NI04h/+lth//eoDqdbbRnZ2Vu/mV5oijM5Q+i14hCzsEJDcuCRBnaaHkdaBglrIx6tPYAIHFSlAAHyi44JR7sLEIRHrXCNlaMCF0K5BETWNcm9O6jpo0OjqQNbaiKbsHahhGk/RWha92Rpx21+v8huza3ja4JYqhK9MHtYX8Cb4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8176.namprd10.prod.outlook.com (2603:10b6:8:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Sun, 12 Jan
 2025 18:57:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Sun, 12 Jan 2025
 18:57:19 +0000
Message-ID: <365e7037-733b-40d7-8046-b19ef3d803a8@oracle.com>
Date: Sun, 12 Jan 2025 13:57:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:32::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 52681c30-5345-429c-2e33-08dd333af082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alc1TmVyN09CZTM1VE0xTDdVTUpGdUJuRGdpT2tkU1U2N0pzSHFxZnZHM3VI?=
 =?utf-8?B?QmZvVE16Z0VDcnJJMFNqM2JVeGc2ZUVUZ3FtVjFWN0IwdXNBL1ZpNWRubkIz?=
 =?utf-8?B?ZGRKdHFrV3BEY2Z5WklkelZiSi9lZUxyeFVrYjdtZXpsWEEyR0lBSEZHRG5z?=
 =?utf-8?B?UEc5SnVYcGVRaitjT21YaG9hZkN4dDl6YkpEWDc5aEhLanRsa3dmdUdDQUlT?=
 =?utf-8?B?OUlocEdpRUJqaHFRY3M1eXlEZ0VjNnNjbTBCK1dvc0ZOTzROZDY0R215U3JC?=
 =?utf-8?B?RzRBY3kweFlOVGNjamQ1MWN2b21vbFFtUEVrelZUMTJIOUZ6Rm1EM1l6RDdy?=
 =?utf-8?B?T042QmQ3WkpDWVJHdE1uQnI3Ny9sNWtoMmI5UTl6UUFGbDd1dEwvMnhvQ1Y2?=
 =?utf-8?B?anFGUW5PK2FyQ1EvL29pV0orNW1DYUFRdkxobnNHSjhEYUxHMzhGQVcvL1l1?=
 =?utf-8?B?N2dtSXVCVUUyd01zdWZFRFhHSURNRFpkRUt3TmVqMldaZC94UnRlNWFqbmxI?=
 =?utf-8?B?OHRWOEpmS2gwNm1LR2UyS2p4SHdPT0ZTenBmNTV2cUFlT24zZkxpek5MRHl2?=
 =?utf-8?B?MWtaZDRNQmxsRDVJTGkxSTVMYytUalFDTjlvd3ZuOVdhTHZFU1huSFlWd2R4?=
 =?utf-8?B?dGl1VDU2L3FHYVBzSFB1ZEVXWHZHbksvSlpzWWdzczVDOWZTd0NuSEFBdkxv?=
 =?utf-8?B?YWc0QUZYTVR6Ym1tME1qcUZnVS9xaWdaSEg5eGVPR3NhakQrVU1LMlZoNlpy?=
 =?utf-8?B?YUhoOGpXcU1IUHhySmVyS0dlSmNGV05LU0tiUVNQZjJMcGhmSVhWdTRDSVBS?=
 =?utf-8?B?MW5aME5xZU9GY0EvZytCTTVtVllibVVLdC9KQ2xKTVNvOW5jU3FheUlPOUxz?=
 =?utf-8?B?ZTVXNkZTczVlbWIxcUxTVmM0VURuRmd5MFZEa3dTSzVQY21nbG5DcFFqS0sz?=
 =?utf-8?B?SjEwcytnVTNYdjFkNkNOY1RYZVQ1MG9XbTJ6UE1sbnRaVXFxMlNoN2RMYWhV?=
 =?utf-8?B?eGpPUXhvNjVNSzM1WlN5TEkxaDhVQi9kamRLem16V3FWZnFjZm1WY2lDRXBl?=
 =?utf-8?B?THdyR3YwTkF2ZVIveGJ3ZmpDMCttczNJRDY3VGlxMmJFODBIRGovTG9hRU5q?=
 =?utf-8?B?NWVRWEFGTzF4bHdRWmphSmR2aytRU3g4bkxFWWt2V3BOdXYvbFQ4OFBkMXlq?=
 =?utf-8?B?VVBQQ2FGMmcrUmJTalV0Z3hKTVFpN3JteStzTnZ2Tm5EbHBmK0pJRUpSV1Ew?=
 =?utf-8?B?OVpkOGJvSTAzSU9BeG5kYWdzeWpCWDlCWGdoQUV4bXVxNFRYeFlJcUxXMkxS?=
 =?utf-8?B?S2dMSzl2TklPTWdWUnlaU0I5SXE3WExweFFJSjZzSWVpYk1udE9mRXB2UjBW?=
 =?utf-8?B?RmozVFhnNGhrL2phSCtVT01oWGRIWlc3RWxOeDB1VHdEZ0lManYxNEN3NjdV?=
 =?utf-8?B?c3VaUzFvQXdmSE1EQndKMTRHcUNNNWRqMEprUDlpcTlUU0pIMUlhbDNwdHRs?=
 =?utf-8?B?eER0WVB2eVpYNDJGRE8wb29oWEp3WFRJZFduM2MvQlJOWTNXYm9NNmtmZEsw?=
 =?utf-8?B?dXBZdUJSQUl2VDFFUmkzYnpIOHNWVXdoZTJUOWlMakRtMkZJRTg2TGNkMXRv?=
 =?utf-8?B?Z1plVXNQTDJYc3NtNkE3cDJ5S09ZK2NHQ2QvNXIvSHNYd2xRKzBGL3Z5cWdS?=
 =?utf-8?B?VnRTS3JFcklTVmMvUXJzdWFFWEZEZURqUFNuTzhodHZXc3lTUUI1bWNXR3ZQ?=
 =?utf-8?B?dzAxQ2t5S3cxVEJiYVNhWERPckpSOWFSMzNFTFBpemZZaUQyajFGRWgxV2xl?=
 =?utf-8?B?cVYxY09YQXE2MG5jNkhtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtjbUdKMFlVQkJVR0tmVFBuaFUvQjJwZkJsdEZ3UXU1RjF1Z1hLS05DTXhx?=
 =?utf-8?B?Q1ZtSFJ1VEV6YitCZndYenA2NEIxVlRucVhyYlJadU5lcXJhTFgwYk1qUmYz?=
 =?utf-8?B?WWJPZnRXNTJPa3NFQWRGczZ3L1hjZFR1aHdjZHBBSnRyUW4rRDExY1lKWk1Z?=
 =?utf-8?B?ZkdJejlzZnVIVjV6akRBQ0p2L1RTQXUxeS9ZeWRHZlcrdDNiZXpiTVR5SGZB?=
 =?utf-8?B?ZnNMbDZmdHlRcmI0aG9FTjRGLzV5cmY3aTdPNkg5RnlacGYrSWlBSzdNZVVo?=
 =?utf-8?B?aklCdFFMSEhlWXdOaFZTbndyMjFCSllNNmZFZ3p0WXE3bHVOSzZBSnlqcmZi?=
 =?utf-8?B?S002SkFXeS9JV2NUSVhHYVVUTDV2WmQxTzl4aUtvUk9FZ203TGkrcWZtbUhv?=
 =?utf-8?B?QlJUcCtici9oRC9GTkUyZXhWQUVQN1Y4dVhpRDdxT3NsdXBhTVIvOStOZERo?=
 =?utf-8?B?dXo1V1dPVXBoNlA2TnJ4bTk2N0svc1hOWDJOWVlpdm5YZlRVQ3lKcTJCazRz?=
 =?utf-8?B?d3g4NVcvYURBOHowZndpNVh0K1ZQUVNvdjhxMkIwUjZyZ2kvbXpKN3huUC85?=
 =?utf-8?B?ZjRDMlJnWHV2T2o0b0pkcU92dnh5V1RvTjB4dndrQWxUL0FlTElCVmJ6NmQz?=
 =?utf-8?B?dXo4OWp0Qk1rL3FPYVg4TDhPUUhMNlB6WGd0NGY1RkorTTFoVWZheExiek5L?=
 =?utf-8?B?SjRIcE9tSWlla0NlRnp3UnlpZWF2ZTgvalgyQXUrYXMyM3ZDVWwvMG5iUUdo?=
 =?utf-8?B?R1piOTc3cVhpZDRIMHRZYzJwUDlMRG1pV01oWG53dlVmS2oxc054TGRFQVN1?=
 =?utf-8?B?YkgyZkVKUm9vblRxS2UvVmxpbmxYRzQrQTFPalYvREZydmY1VzhBcVNucVMr?=
 =?utf-8?B?MW5rTkowb1J5MVp2NTkrUmpKUVVkS0V3L1RQamFwZllaa0djRnFib2tKK2hx?=
 =?utf-8?B?bHhtdWNqOWNTSGZaYlJWY1VkVmhIVXJ4UEl3elFWYU9iV3F1cytnRUdvdW5h?=
 =?utf-8?B?Z2Z2QVFicGZScWtsRElvVGJQUzloUmIwaVVhbmVwZFoyQkI5Z3JUZkkxbi85?=
 =?utf-8?B?NGpUbE1yejVVcmxZa2NHVVo0SS9JaGlEQjNqdm45OTZqVXhiTHM1TEs0NVdq?=
 =?utf-8?B?aXJZSWFDNFdaSVN3ZTZabXRwVUNuZkVPbFh0Tzk2a2RXZ0FYQVovMGYxeDl6?=
 =?utf-8?B?NTR2OFlYU1NlaFloSUJic1k2eHorWkFwZ3VQem16VjhsS3NIMUNmRDdOWXB6?=
 =?utf-8?B?SEVwVExWeWZ2TkIxWjFzYS80TUJOSkhraHdZYzczL1czUHBKU2IveXVqanBM?=
 =?utf-8?B?dlBRdHpEVEVpbTkzSDFkSC9UeGZQMi9jZlJad3FCWG4wNzJyWG9WVjlEUGt2?=
 =?utf-8?B?VCtoSVZWSDRxSHAzWGlkSjVTbloxOEVyZFBJTFZYUnUwbDFBbGt3T1h0VWhw?=
 =?utf-8?B?K1lON0VxWDhkcTg3NkhHa1paa2Zvbnc3QzdtclpJNUlEUUJHNXBuNnprVW9L?=
 =?utf-8?B?b0tMK3NTeTRhQlFIMVRmbG9IdHlDajhQNHE4bUp4NkU4ZHBYSmRyN3hraURC?=
 =?utf-8?B?K0kzYk4wbGJtZjBLSW05UTJwMUplbm5DQ1F5b2tVcjBleHcwNjlxTm14c1kw?=
 =?utf-8?B?SzdaMFZ1MGdrT0RSOEVFMjZrSmYxbzVGV1JQdFhSUC8xakcxMEN3WXMyMHIy?=
 =?utf-8?B?OE5sYURlOWptK0FDWEU2N2RBamRzWUhqaXRlalFUR010L01BRlJkZEM1dzRZ?=
 =?utf-8?B?UXRMU0RMOHBpWXhSUUpKOWI2MlUxNUpnVENRNmduQThzWmRsMmJCY0FKMm9B?=
 =?utf-8?B?NFoyRGM0MFNOZjR0aTl2aTBDQW13R0YvUGloeHpvdittVERjbjdyOWRSMXlu?=
 =?utf-8?B?SWx4bWVVZ1BVeEF4N0lFMGVRd2l6YzV5SG5xQkMrUmIzczRiMTVwSlE0S0F6?=
 =?utf-8?B?aFNvcUpHMm5aOW5nNThvOW1jR1RHdFZick9HNXpMSE02QmhKQUdXNm5WTW81?=
 =?utf-8?B?NzZIYzlLZDlHZ1JIMmswaGpKcjhqdm5SdkdnQ21mMDh4bDh4bmpYMXBJeWcy?=
 =?utf-8?B?WFk4eXNkY0JzN0s2Nld0czY1YXQ2MGhxUmlGUkJZK3VJemxaV01YRzBKR2R0?=
 =?utf-8?B?alQxUDhudVdRbUlBNFQyUzZNTXpCQjNSSFkvVS8xa1BEUFVJRzNiODRGUkdv?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yp0vGbSA/SH+I/CUSEmP9dfPi9MqK6XPG4J4oAY/iTD5bL56FqpJnlyHisRgx6F9UxSQ+pUWovd+Fd+LIt0AlCU/MetHpybHUfj7NV9hVOKh/OF+9Gf02FYKAumrUMd81qsW9llDDkrw8SVvAlG32aWbKPYA22meUbvqiqwOfe6hh9OL9f8hLbG22i3/WBMKpz/HxdJTjmQwQfAhI2qM0xmMIFkqrEhEcosqas4V5TmC0TAwGtDGFVSbgPY4g+q0HVIWTPeUvg95tZXD9RB4KEkFSKx9gPxNmW6DZbnA+AYSFVLNXZakULnBya/trWZ0xY0QOxZBhrZO8vqI/AgWlbUjQrCSzV0vYejpU8F58FZYzEUYM/uG8RY+gjFv/Kw1uBEYKAMVoooLkGe4VkG6pccQ2ElXdpk2v4fAHbwGpI0//En5LX1zyty9QInmVZ5OWzo7ERA8Jsx+raKzs3w3fESMpvkK3RLkyRI7H3OLR74s5GPpb2xj2nFiarHuXeSs2SJxDZdN5ASlQ9v8yeQmEegep3v4qw64Dg0UF2e6X+Kjx5SOGg/8X5wc4GUjGnlmOyT+f94bOdbEbkmLgHixg1JGdF0+/gEbSYE7rYO006o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52681c30-5345-429c-2e33-08dd333af082
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2025 18:57:19.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+aGrEFizlvkXYmBtzRBH2qxgouaMOXc0tNB5gMyNco48L6BJJstblMeoE9J6yOSUJkUfEUILZ8aa3ZdmaHonQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-12_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501120167
X-Proofpoint-GUID: 2jp6D8VXBt6hF03NRRz6oAQFkjAZ1sAe
X-Proofpoint-ORIG-GUID: 2jp6D8VXBt6hF03NRRz6oAQFkjAZ1sAe

On 1/12/25 7:42 AM, Rik Theys wrote:
> Hi,
> 
> On Fri, Jan 10, 2025 at 11:07 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/10/25 3:51 PM, Rik Theys wrote:
>>> Hi,
>>>
>>> Thanks for your prompt reply.
>>>
>>> On Fri, Jan 10, 2025 at 9:30 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/10/25 2:49 PM, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> Our Rocky 9 NFS server running the upstream 6.11.11 kernel is starting
>>>>> to log the following hung task messages:
>>>>>
>>>>> INFO: task kworker/u194:11:1677933 blocked for more than 215285 seconds.
>>>>>          Tainted: G        W   E      6.11.11-1.el9.esat.x86_64 #1
>>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>> task:kworker/u194:11 state:D stack:0     pid:1677933 tgid:1677933
>>>>> ppid:2      flags:0x00004000
>>>>> Workqueue: nfsd4 laundromat_main [nfsd]
>>>>> Call Trace:
>>>>>     <TASK>
>>>>>     __schedule+0x21c/0x5d0
>>>>>     ? preempt_count_add+0x47/0xa0
>>>>>     schedule+0x26/0xa0
>>>>>     nfsd4_shutdown_callback+0xea/0x120 [nfsd]
>>>>>     ? __pfx_var_wake_function+0x10/0x10
>>>>>     __destroy_client+0x1f0/0x290 [nfsd]
>>>>>     nfs4_process_client_reaplist+0xa1/0x110 [nfsd]
>>>>>     nfs4_laundromat+0x126/0x7a0 [nfsd]
>>>>>     ? _raw_spin_unlock_irqrestore+0x23/0x40
>>>>>     laundromat_main+0x16/0x40 [nfsd]
>>>>>     process_one_work+0x179/0x390
>>>>>     worker_thread+0x239/0x340
>>>>>     ? __pfx_worker_thread+0x10/0x10
>>>>>     kthread+0xdb/0x110
>>>>>     ? __pfx_kthread+0x10/0x10
>>>>>     ret_from_fork+0x2d/0x50
>>>>>     ? __pfx_kthread+0x10/0x10
>>>>>     ret_from_fork_asm+0x1a/0x30
>>>>>     </TASK>
>>>>>
>>>>> If I read this correctly, it seems to be blocked on a callback
>>>>> operation during shutdown of a client connection?
>>>>>
>>>>> Is this a known issue that may be fixed in the 6.12.x kernel? Could
>>>>> the following commit be relevant?
>>>>
>>>> It is a known issue that we're just beginning to work. It's not
>>>> addressed in any kernel at the moment.
>>>>
>>>>
>>>>> 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a    nfsd: fix race between
>>>>> laundromat and free_stateid
>>>>>
>>>>> If I increase the hung_task_warnings sysctl and wait a few minutes,
>>>>> the hung task message appears again, so the issue is still present on
>>>>> the system. How can I debug which client is causing this issue?
>>>>>
>>>>> Is there any other information I can provide?
>>>>
>>>> Yes. We badly need a simple reproducer for this issue so that we
>>>> can test and confirm that it is fixed before requesting that any
>>>> fix is merged.
>>>
>>> Unfortunately, we've been unable to reliably reproduce the issue on
>>> our test systems. Sometimes the server works fine for weeks, and
>>> sometimes these (or other) issues pop up within hours. Similar to the
>>> users from the mentioned thread, we let a few hundred engineers and
>>> students loose. Our clients are both EL8/9 based, and also Fedora 41,
>>> and they (auto)mount home directories from the NFS server. So clients
>>> frequently mount and unmount file systems, students uncleanly shut
>>> down systems,...
>>>
>>> We switched to the mainline kernel in the hope this would include a
>>> fix for the issue.
>>>
>>> Are there any debugging commands we can run once the issue happens
>>> that can help to determine the cause of this issue?
>>
>> Once the issue happens, the precipitating bug has already done its
>> damage, so at that point it is too late.
>>
>> If you can start a trace command on the server before clients mount
>> it, try this:
>>
>>     # trace-cmd record -e nfsd:nfsd_cb_\*
>>
>> After the issue has occurred, wait a few minutes then ^C this command
>> and send me the trace.dat.
>>
> I can create a systemd unit to start this command when the system
> boots and stop it when the issue happens.

It would help to include "-p function -l nfsd4_destroy_session" as
well on the trace-cmd command line so that DESTROY_SESSION operations
are annotated in the log as well.


> What is the expected performance impact of keeping this tracing
> running? Is there an easy way to rotate the trace.dat file as I assume
> it will grow quite large?

Callback traffic should be light. I don't expect a huge amount of data
will be generated unless the trace runs for weeks without incident, and
therefore I expect any performance impact will be unnoticeable.


>> The current theory is that deleg_reaper() is running concurrently with
>> the client's DESTROY_SESSION request, and that leaves callback RPCs
>> outstanding when the callback RPC client is destroyed. Session shutdown
>> then hangs waiting for a completion that will never fire.
> 
> Would it be possible to capture this using a bpftrace script? If so,
> which events would be interesting to capture to confirm this theory?

You can capture this information however you like. I'm familiar with
trace points, so that's the command I can give you.


> Is there an easy way to forcefully trigger the deleg_reaper to run so
> we can try running it in a loop and then reboot/unmount the client in
> an attempt to trigger the issue?

Reduce the server's lease time. deleg_reaper() is run during every pass
of the server's NFSv4 state laundromat.

It is also run via a shrinker. Forcing memory exhaustion might also
result in more calls to deleg_reaper(), but that can have some less
desirable side effects.


>> If your server runs chronically short on physical memory, that might
>> be a trigger.
> 
> Before the server was upgraded to EL9, it ran CentOS 7 for 5 years
> without any issue and we never experienced any physical memory
> shortage.  Why does the system think it's running low on memory

Different kernels have different memory requirements, different memory
watermarks, and different bugs. Sometimes what barely fits within a
server's RSS and throughput envelope with one kernel does not fit at
all with another kernel.

I'm trying not to make assumptions. Some folks like running NFS servers
with less than 4GB of RAM in virtual environments.

So what I'm asking is how much physical RAM is available on your server,
and do you see other symptoms of memory shortages?


> and
> needs to send the RECALL_ANY callbacks? It never did in the past and
> the system seemed to do fine.

CB_RECALL_ANY is a new feature in recent kernels.


> Is there a way to turn off the
> RECALL_ANY callbacks (at runtime)?

No.


>>>> An environment where we can test patches against the upstream
>>>> kernel would also be welcome.
> 
> Our current plan is to run the 6.12 kernel as this is an LTS kernel.
> If there are patches for this kernel version we can try, we may be
> able to apply them. But we can't reboot the system every few days as
> hundreds of people depend on it. It can also take quite some time to
> actually trigger it (or assume it was fixed by a patch).

Any code change has to go into the upstream kernel first before it is
backported to LTS kernels.

What I'm hearing is that you are not able to provide any testing for
an upstream patch. Fair enough.


> Regards,
> Rik
> 
>>>>
>>>>
>>>>> Could this be related to the following thread:
>>>>> https://lore.kernel.org/linux-nfs/Z2vNQ6HXfG_LqBQc@eldamar.lan/T/#u ?
>>>>
>>>> Yes.
>>>>
>>>>
>>>>> I don't know if this is relevant but I've noticed that some clients
>>>>> have multiple entries in the /proc/fs/nfsd/clients directory, so I
>>>>> assume these clients are not cleaned up correctly?
>>>
>>> You don't think this is relevant for this issue? Is this normal?
>>
>> It might be a bug, but I can't say whether it's related.
>>
>>
>>>>> For example:
>>>>>
>>>>> clientid: 0x6d077c99675df2b3
>>>>> address: "10.87.29.32:864"
>>>>> status: confirmed
>>>>> seconds from last renew: 0
>>>>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
>>>>> minor version: 2
>>>>> Implementation domain: "kernel.org"
>>>>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
>>>>> Dec 11 16:33:48 UTC 2024 x86_64"
>>>>> Implementation time: [0, 0]
>>>>> callback state: UP
>>>>> callback address: 10.87.29.32:0
>>>>> admin-revoked states: 0
>>>>> ***
>>>>> clientid: 0x6d0596d0675df2b3
>>>>> address: "10.87.29.32:864"
>>>>> status: courtesy
>>>>> seconds from last renew: 2288446
>>>>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
>>>>> minor version: 2
>>>>> Implementation domain: "kernel.org"
>>>>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
>>>>> Dec 11 16:33:48 UTC 2024 x86_64"
>>>>> Implementation time: [0, 0]
>>>>> callback state: UP
>>>>> callback address: 10.87.29.32:0
>>>>> admin-revoked states: 0
>>>>>
>>>>> The first one has status confirmed and the second one "courtesy" with
>>>>> a high "seconds from last renew". The address and port matches for
>>>>> both client entries and the callback state is both UP.
>>>>>
>>>>> For another client, there's a different output:
>>>>>
>>>>> clientid: 0x6d078a79675df2b3
>>>>> address: "10.33.130.34:864"
>>>>> status: unconfirmed
>>>>> seconds from last renew: 158910
>>>>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
>>>>> minor version: 2
>>>>> Implementation domain: "kernel.org"
>>>>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
>>>>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
>>>>> Implementation time: [0, 0]
>>>>> callback state: UNKNOWN
>>>>> callback address: (einval)
>>>>> admin-revoked states: 0
>>>>> ***
>>>>> clientid: 0x6d078a7a675df2b3
>>>>> address: "10.33.130.34:864"
>>>>> status: confirmed
>>>>> seconds from last renew: 2
>>>>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
>>>>> minor version: 2
>>>>> Implementation domain: "kernel.org"
>>>>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
>>>>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
>>>>> Implementation time: [0, 0]
>>>>> callback state: UP
>>>>> callback address: 10.33.130.34:0
>>>>> admin-revoked states: 0
>>>>>
>>>>>
>>>>> Here the first status is unconfirmed and the callback state is UNKNOWN.
>>>>>
>>>>> The clients are Rocky 8, Rocky 9 and Fedora 41 clients.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Rik
>>>>>
>>>>
>>>>
>>>> --
>>>> Chuck Lever
>>>
>>
>>
>> --
>> Chuck Lever
> 
> 
> 


-- 
Chuck Lever

