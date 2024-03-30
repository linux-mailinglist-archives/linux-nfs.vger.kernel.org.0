Return-Path: <linux-nfs+bounces-2571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D4892C6A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092D61C20DE9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C243FB81;
	Sat, 30 Mar 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CpOejSAO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B7DBjiLa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1980200DD
	for <linux-nfs@vger.kernel.org>; Sat, 30 Mar 2024 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823328; cv=fail; b=U11wYg3uJy5o5kKx4/wHM6JfritFFynwpoLKU71ygSiODNNLoyoA2z2zci0BwJqX8dQk2+UUjhAqmdWcExLutaZs/fcuZhrpDloVKDLC2LyjUCRV+rdsp0RNkhWCC3UezV7UmF7m8PrxSAmTlCDC5DPuC5ABVQUfwscNEG1gwcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823328; c=relaxed/simple;
	bh=mJCS8aaKXc+JT7ylEeWaXHcr0x1XQyZw0dD++AfVWlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXpVBsyRHSOv0Wbnt8B0BZ1MLEt/xS1iOmKhv6Zp1dH+cDk2EEBgsCzRgoTMv2D+FJN0NvPcejQrj1KEUP4cszxlHLF0+0k6/03HLjlfm5AArJHX+MK+KHcmRNRpi1O/xd2zS4umY0HyZZntDyAVroVH9BoZWmJpxnaTHqKFJ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CpOejSAO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B7DBjiLa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42UHXLMA010237;
	Sat, 30 Mar 2024 18:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=YdrLJkPVowArMhyLaD5G4uaNIUhnSAM8SA7xlKFwTZ4=;
 b=CpOejSAOguB7JUQhmJry79GFDfXbGc1GY4DaglKAXTU+xr4eCXwrnGU/MjWdkL+aYTgi
 u969hTnkQ2cOCUezYgcEY4SvoihutZHGD2DU6QlHa7cXB+7BBx6tGW0THGkbx0VHN8FO
 4vIjgcjZujUhN2MSRGjMjA9Z779QZxfFDFR4fumHUG0aZOhM9D+3y/U4jUzW4jlHwVuz
 q8AQ9m06Nuqz45TVMqtTccFEpQxHYyEmSnOPJijyRFRWgWto4IQFd4eBnQBafP+zhK06
 y8v9k5y/GwqXvcU28ZtjATC7cRuUe0qxd5zb8HoLLbR1G19/W3pseL6U3Z5iD20Cnf8O og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6amb8gkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 18:28:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42UF7j3d040637;
	Sat, 30 Mar 2024 18:28:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x69640js4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 18:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd3e+epCKqdSsH3i1jevEs6hHfNxtJ7l4YrtRDeFIskE5e7d6Y8BU4MJtvUkzG+Dpza+n5XNO4hyKeBmhsSRIdrje9fWANPWSCxoDqAkoCeDwc0BP9IvlmA77rvY5UMiCtLFnfKklSFMI1JnHYWB2GToibFD5xvVuQY9DpWryOddOWPyn90tgRKv1IAFWEJ+mhig/Dlyr3sNzlblnwCRSVCtQH7BhIRRusa9K1DegKMQidhb4DKo3qL2ItnDD+QtCewcvQ0KHXxhQOV30xtL2wICQUntHOzv6K4iIBNn0hcF1JcEoCffwD/rr7cxm//2I4wnhczWkcD9CbfNsKMz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdrLJkPVowArMhyLaD5G4uaNIUhnSAM8SA7xlKFwTZ4=;
 b=nKRdD5ARPmCBu/F2TlVWkV1YFk3BB4Y8QSsP1vS+/UENwEk9H517Ml5okmjpN78VcWRA6+Sfa8Urn0fvtbXt4/arpsFEwCuXlsnUAT1pECKNPfgpuVfrNntZ4waanJlty4VrpQcZ93gqbBx4FA7Memkn1uucPeQimy4hjuATUCY0i1vpTC0tLhRHCW9nBYPwO4RYm6mZ6BMQI6bgx0nY/jAaRF5aM+mCRMzR1xCWVlwc0rCLFfgCaqGD8pq/q4NEW1JwjObWms+Zrj6qdGFba82bXxMva2Yj/zosIbEAKBZm2jiTewhrkXCvD3mHJ4jPcbA5b59A1BZi4RU5MgQrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdrLJkPVowArMhyLaD5G4uaNIUhnSAM8SA7xlKFwTZ4=;
 b=B7DBjiLavr9dSTlW8prp2xVmRPiIwI/PnGdShKsUu69hPwK77znYVHfwpbD5WHI+EANF8vXpapor2PMchnIzTDhx2r/PQ3gBaBZiOHpfHWV9wXxdDkSBYIVlzeaYVFuWGPlVxQY5mj5dm3o+LaXfVfghdCwT+bY73GCz9L7qAGk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sat, 30 Mar
 2024 18:28:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 18:28:32 +0000
Date: Sat, 30 Mar 2024 14:28:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
X-ClientProxiedBy: CH5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	feYFY0vCP3J+Od1pv1MXnEaTaUhnE8HfC/G9vbzBe7Pk3MKJWK+/P7MMUTPwI9C2WL9XAY4SxFtvKFjOWzU03h5T+1Yu1iaCD6I/fdpU27websrE1vAEO/lNTbUS6K1iY+OUMKvbZfBYcBWVS2U80N/soJf0geozhlvYvTVmealcYJe0+R0p4UqzTtYgMjO+iHDO67nSKM8ZVYuhzS4+SZ2VtE6DZgcKCbjYR27azIioJvnguExLVYwnm0yqukt3edVTV7AFW7gm4ce7PT6JR5CtinVP/2tKZmOxXu93MCGSPpPmPIz/GkpriHtmH2ecl0iK5xaHnPyZGTqgZog7T9qm6ldmRWDjlxLT9AMWoIyCUMzUeYiKg1w/BDIETUFQm8WqYhSA2O5j3G6O950PFfetrfQ9Et6aB6/iE8ACtbvYq0yj/X+OE3mC6Ap4RKffatOoOIEMsLfLOZX9lHJSq3Qfr+HN4UW0XIfCwOhNE4m55mu4RFbXkwLu81oa97Nw/id0Zg2AhqhhLde6fN1Z6TgExX+1Q2N12DPJpQTGz0QzbypiyFxp1u2Trqj1VjDyeCRXqznrPrwZdWKUOTA5YC6kB4ekA07TSAP83CUM4eS+QO2LjYSNRKgHTERHDT+JC4LfFXLuK/rqSSf/bibkQ5y5kqga/ou5FqvGAK7PazU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kx+yiVCaejfZmLkGB9WnbsuEo4hAsazRO+wOwKMCBwzOW0rtTx6Do324hC9P?=
 =?us-ascii?Q?h2mxs04C31fQ4ksysG1Iz5QbRSOvELKH+jGQ2jHJ4ayE4DjfiZyh486dLd7l?=
 =?us-ascii?Q?NTkJAIekoqhh1DmiNaKcx5XPLJLY5cYUNtYQ9eueKb2vjGL6NxoOaoYdYcHe?=
 =?us-ascii?Q?khKmroe6wMKp3n6bQLDYKdzDAj7LgU48jneD7uuWp/B7yU4Gz0xQHNY00s5l?=
 =?us-ascii?Q?9yaxOId2C0U8kqpGCS0akHbFwNWBEvtllt5ncSkwJZrI/CV0gn6Pf+rh7QnV?=
 =?us-ascii?Q?BQRawkJLo7NQjCNr6QslpcZGOivYBQSz2d9fzYA4xtyAFOyF2hsI4an0ooP4?=
 =?us-ascii?Q?BtRAMyK+xuH8hgTdUPRit8G/dsjS3GN9KBmTOT0oCdd15TWMNYKmuvYhDFp7?=
 =?us-ascii?Q?TfpI9UaDBNdEX3syqBHMpcdYkbipZq8b5ENlrFhXdmISPjiuRCRWM1tSOy7H?=
 =?us-ascii?Q?HgpXck8N+K1LLV8t0J2NsJudUzJ0iUkM9Akcet9D0q0N5RHR8pR+xFb2Ys/M?=
 =?us-ascii?Q?7qGbs+uxqlfKQKmPcmjOz2lnT+3oonzBZsRXdcifZ++Rr9rCQsbxg8BNM5Rz?=
 =?us-ascii?Q?GE6KOvBbd6d40jq73oFKukxW27sEkRGKVIgqNPoHV3QXCdPxfqR6c0Mz63C1?=
 =?us-ascii?Q?v4MV3pJrVRIzxaaMYg3DYmSVQ7u+TF4Dr7W5rwxCfwzMGHXaKgxPtLoqEj7c?=
 =?us-ascii?Q?7UY6B92ZgEH/s5XhsX4Gr+Hb7n9tT2NZHlA0k/XvztfMIpsXGEEKGhxQ4K3L?=
 =?us-ascii?Q?JzvRc+cgI/nwAxpQyC2jFhtU9swsgb6bhJlwyMBOcuKrcsEP9F9eWGLEaV/m?=
 =?us-ascii?Q?QWkaj0aCv3TqiXtm0/pgu0Gl0IiReUdPf6M70TwZtTqDrvzUyaP1Wpnih3R5?=
 =?us-ascii?Q?lMNquBUGmWJtPW7eMDCvxsT1A2DE8tqYXs2DhdNmRAdQc+9TYOSxOFKY0pqH?=
 =?us-ascii?Q?j35ugIN7YtdEmqhEYbGlXSFINx1qYbaq4daoYEdFtpI4k4G+WBzpetnnNviV?=
 =?us-ascii?Q?hcWFDY64SIOFBIhU75TwOjKQ+57AU9V4XPaQVYT2qZD2YKN1ek75Hh9oBhfH?=
 =?us-ascii?Q?R17yNaSf3xZd6q9j5rrfcWFYgxNT4PgNPIBYphzGn48Kc3vxuZDJ6iJU4wB+?=
 =?us-ascii?Q?pL+4Vc8TiM/wL+ZMXPW8ILo0otk8L7ZMet2EbGvMzxDTQTu8sO+/t/suJOWa?=
 =?us-ascii?Q?JYTBpX+WrpAg2Dl8iijS7k46ABTBaBXPdyiYM2n3Zk+f9e3Dex8M1NeMnWk2?=
 =?us-ascii?Q?TkpPUtiRVUiAae4fmjyvPu8eTHGbkzSxWskghTe1/viSTdtz2uiRQxBMD+vb?=
 =?us-ascii?Q?VxSrG/F6eLCJRi4Vg3160XAbd+5Nro0u0W1P5qXvPjD1GDlptbPdtGjG64kr?=
 =?us-ascii?Q?r3Fu7DwALgDeGY2LABJEbB4bgauHwFByOUuNHGXciOxzZT2QVrsvglyyL/4f?=
 =?us-ascii?Q?O+0a4cDudTb3OgrHtP8F4/GV1G3l41yn8lC8hKb0lsUrqczYQcI2ZmfGESN0?=
 =?us-ascii?Q?wHlZ920VxMk0gkrrB8bMh09Bqek5T7/i1yOHeEvwuySQWqkCgywSUJ+FQd43?=
 =?us-ascii?Q?aFkiJ8N0uQfQbmkvkqDUpA4CjdZ+emiz+j5vNy9KkFElmSqrfaJiT2eJipXL?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1qX98VtiKSgTeVbODfoTaOpfXTBCetDOR7OdtqNdpJceomjXM/OgjtoFFVYiPAI7dGxQhnEfbc5E3xxYul4elQDKHLSjKm2iqSHhNmZaD5ao7pG3GBQ+/ChvEgyHDV0wG0qLZToD+DbpaDP4pI6EjU9goUZCSJ3QjMAl7aS3T4zzhEFbL4A+3wkBpqz0Ft1ggwdJeqyn3JU+GMnc9OV9wI+u+QNZaTw3iV9Gkqrtj2FHyRMCSNyj20A0Qf+mrn49tnwzG+zM1erem8K3dfd3Z/X0WbWgjhKwxGt/ZIJhu4osyhxEGer/aPNr5AkQ0q+wUbMn4PiHuIv6IbSTEuUqwBrJ/3v8rYSl3MXX9HPMhDHldKkb3M8JE3FVK1TFeBGyz5kmbuoHcKcMNESNbGUcARUGWP1J3N0lYqZrsQI+or0PIzrYao+pXEsJwhuPacRrzhHN8p7ef5QB4f+lvZkU2nZQKPrE3JP3CVP16jrlDTAaKd2mhdEcaDdI/cka/Mw0PoXPOUnBFcKlzdMplTa6rTPuMcFgEP0uo0Y1HlrqcUCbuf+oRn/lKBFZGMutwPcsdC0RJMkeWgYWQFCAoVwTAHivfzbFOFV2MmIpnjZiH5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ddc011-a2cd-48f0-b107-08dc50e73453
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 18:28:32.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PidbS/bULKVDoqG7BOlunbIgtuqBA1BncltqFwISiyMUbIA9Xc5eQSYvObzrRFKvnRvfKtu8ttAQ9ST4UoIzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403300151
X-Proofpoint-ORIG-GUID: T-HwVZyTvhyvHU0jxC9X9M4RYSqFSbkc
X-Proofpoint-GUID: T-HwVZyTvhyvHU0jxC9X9M4RYSqFSbkc

On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
> 
> On 3/29/24 4:42 PM, Chuck Lever wrote:
> > On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
> > > On 3/29/24 7:55 AM, Chuck Lever wrote:
> > > > On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
> > > > > On 3/28/24 11:14 AM, Dai Ngo wrote:
> > > > > > On 3/28/24 7:08 AM, Chuck Lever wrote:
> > > > > > > On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
> > > > > > > > On 3/26/24 11:27 AM, Chuck Lever wrote:
> > > > > > > > > On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
> > > > > > > > > > Currently when a nfs4_client is destroyed we wait for
> > > > > > > > > > the cb_recall_any
> > > > > > > > > > callback to complete before proceed. This adds
> > > > > > > > > > unnecessary delay to the
> > > > > > > > > > __destroy_client call if there is problem communicating
> > > > > > > > > > with the client.
> > > > > > > > > By "unnecessary delay" do you mean only the seven-second RPC
> > > > > > > > > retransmit timeout, or is there something else?
> > > > > > > > when the client network interface is down, the RPC task takes ~9s to
> > > > > > > > send the callback, waits for the reply and gets ETIMEDOUT. This process
> > > > > > > > repeats in a loop with the same RPC task before being stopped by
> > > > > > > > rpc_shutdown_client after client lease expires.
> > > > > > > I'll have to review this code again, but rpc_shutdown_client
> > > > > > > should cause these RPCs to terminate immediately and safely. Can't
> > > > > > > we use that?
> > > > > > rpc_shutdown_client works, it terminated the RPC call to stop the loop.
> > > > > > 
> > > > > > > > It takes a total of about 1m20s before the CB_RECALL is terminated.
> > > > > > > > For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
> > > > > > > > loop since there is no delegation conflict and the client is allowed
> > > > > > > > to stay in courtesy state.
> > > > > > > > 
> > > > > > > > The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
> > > > > > > > is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
> > > > > > > > to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
> > > > > > > > When nfsd4_cb_release is called, it checks cb_need_restart bit and
> > > > > > > > re-queues the work again.
> > > > > > > Something in the sequence_done path should check if the server is
> > > > > > > tearing down this callback connection. If it doesn't, that is a bug
> > > > > > > IMO.
> > > > > TCP terminated the connection after retrying for 16 minutes and
> > > > > notified the RPC layer which deleted the nfsd4_conn.
> > > > The server should have closed this connection already.
> > > Since there is no delegation conflict, the client remains in courtesy
> > > state.
> > > 
> > > >    Is it stuck
> > > > waiting for the client to respond to a FIN or something?
> > > No, in this case since the client network interface was down server
> > > TCP did not even receive ACK for the transmit so the server TCP
> > > kept retrying.
> > It sounds like the server attempts to maintain the client's
> > transport while the client is in courtesy state?
> 
> Yes, TCP keeps retryingwhile the client is in courtesy state.

So the client hasn't sent a lease-renewing operation recently, but
the connection is still there. It then makes sense for the server to
forcibly close the connection when a client transitions to the
courtesy state, since that connection instance is suspect.

The server would then recognize immediately that it shouldn't post
any new backchannel operations to that client until it gets a fresh
connection attempt from it.


> > I thought the
> > purpose of courteous server was to more gracefully handle network
> > partitions, in which case, the transport is not reliable.
> > 
> > If a courtesy client hasn't re-established a connection with a
> > backchannel by the time a conflicting open/lock request arrives,
> > the server has no choice but to expire that client's courtesy
> > state immediately. Right?
> 
> Yes, that is the case for CB_RECALL but not for CB_RECALL_ANY.

CB_RECALL_ANY is done by a shrinker, yes?

Instead of attempting to send a CB_RECALL_ANY to a courtesy client
which is likely to be unresponsive, why not just expire the oldest
courtesy client the server has? Or... if NFSD /already/ expires the
oldest courtesy client as a result of memory pressure, then just
don't ever send CB_RECALL_ANY to courtesy clients.

As soon as a courtesy client reconnects, it will send a lease-
renewing operation, transition back to an active state, and at that
point it re-qualifies for getting CB_RECALL_ANY.


> > But maybe that's a side-bar.
> > 
> > 
> > > > > But when nfsd4_run_cb_work ran again, it got into the infinite
> > > > > loop caused by:
> > > > >        /*
> > > > >         * XXX: Ideally, we could wait for the client to
> > > > >         *      reconnect, but I haven't figured out how
> > > > >         *      to do that yet.
> > > > >         */
> > > > >         nfsd4_queue_cb_delayed(cb, 25);
> > > > > 
> > > > > which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.
> > > > The whole paragraph is:
> > > > 
> > > > 1503         clnt = clp->cl_cb_client;
> > > > 1504         if (!clnt) {
> > > > 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> > > > 1506                         nfsd41_destroy_cb(cb);
> > > > 1507                 else {
> > > > 1508                         /*
> > > > 1509                          * XXX: Ideally, we could wait for the client to
> > > > 1510                          *      reconnect, but I haven't figured out how
> > > > 1511                          *      to do that yet.
> > > > 1512                          */
> > > > 1513                         nfsd4_queue_cb_delayed(cb, 25);
> > > > 1514                 }
> > > > 1515                 return;
> > > > 1516         }
> > > > 
> > > > When there's no rpc_clnt and CB_KILL is set, the callback
> > > > operation should be destroyed immediately. CB_KILL is set by
> > > > nfsd4_shutdown_callback. It's only caller is
> > > > __destroy_client().
> > > > 
> > > > Why isn't NFSD4_CLIENT_CB_KILL set?
> > > Since __destroy_client was not called, for the reason mentioned above,
> > > nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL was not
> > > set.
> > Well, then I'm missing something. You said, above:
> > 
> > > Currently when a nfs4_client is destroyed we wait for
> > And __destroy_client() invokes nfsd4_shutdown_callback(). Can you
> > explain the usage scenario(s) to me again?
> 
> __destroy_client is not called in the case of CB_RECALL_ANY since
> there is no open/lock conflict associated the the client.

> > > Since the nfsd callback_wq was created with alloc_ordered_workqueue,
> > > once this loop happens the nfsd callback_wq is stuck since this workqueue
> > > executes at most one work item at any given time.
> > > 
> > > This means that if a nfs client is shutdown and the server is in this
> > > state then all other clients are effected; all callbacks to other
> > > clients are stuck in the workqueue. And if a callback for a client is
> > > stuck in the workqueue then that client can not unmount its shares.
> > > 
> > > This is the symptom that was reported recently on this list. I think
> > > the nfsd callback_wq should be created as a normal workqueue that allows
> > > multiple work items to be executed at the same time so a problem with
> > > one client does not effect other clients.
> > My impression is that the callback_wq is single-threaded to avoid
> > locking complexity. I'm not yet convinced it would be safe to simply
> > change that workqueue to permit multiple concurrent work items.
> 
> Do you have any specific concern about lock complexity related to
> callback operation?

If there needs to be a fix, I'd like something for v6.9-rc, so it
needs to be a narrow change. Larger infrastructural changes have to
go via a full merge window.


> > It could be straightforward, however, to move the callback_wq into
> > struct nfs4_client so that each client can have its own workqueue.
> > Then we can take some time and design something less brittle and
> > more scalable (and maybe come up with some test infrastructure so
> > this stuff doesn't break as often).
> 
> IMHO I don't see why the callback workqueue has to be different
> from the laundry_wq or nfsd_filecache_wq used by nfsd.

You mean, you don't see why callback_wq has to be ordered, while
the others are not so constrained? Quite possibly it does not have
to be ordered.

But we might have lost the bit of history that explains why, so
let's be cautious about making broad changes here until we have a
good operational understanding of the code and some robust test
cases to check any changes we make.


-- 
Chuck Lever

