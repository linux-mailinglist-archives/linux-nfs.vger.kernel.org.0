Return-Path: <linux-nfs+bounces-10662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26278A67E89
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 22:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29B53BB130
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD51D5AB7;
	Tue, 18 Mar 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHKKiDQJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lKMVeeL/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8F1537CB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332561; cv=fail; b=Pv5KIEMdZ+yFQy0WFvAw2nBvGCn/lDbXn+fasfcgVEJRPSXMy3LWB4gXb7s3nrEGRSpbsFga69CgBAmq+drF6FE5tVygzD2NP9LWr2BhsIXUC2B+NynlFfbybQRP0vwLUw+/C2N8k8m/k3osTRePIgwsPP4MQcUGWqve2smnB34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332561; c=relaxed/simple;
	bh=g4qQA/a3ImO81Byj5NucDfTXvMZJ+lzRTn3tY9f/RsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SjIVssUVF07iJUXpXBMcpDbZig0ijAwB8cLIk9RnSpZAU/RbqFzadwBnEZFp1ILbbmY/zw9g8KLzfPEQxDkRs3EgU96MMpSuer3FuZFJGoL7tL4Yj1US93Q9TNk6BlF48NRHI407iQb8SeazQdXS3AFe2QBBjWkp4ysnWO0ILMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHKKiDQJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lKMVeeL/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJZ29n003609;
	Tue, 18 Mar 2025 21:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MZ2w9ww3YsUJRSAHGbadZsWR5FErI9xTwMKi1kAlzUw=; b=
	LHKKiDQJinMDEY7H/AWl/oBECEZi2t1pI35JQqLMomeSYDIpLnzS+Cm21Yj4bxXn
	PYJJ8+NCXnNscHWicvnPWyzceADcxhMWX2ujEzX5lgfqdDLE2NrBZC/rbARDfONT
	d7TmR6BTWeC81JqSwKFywT6L6dN8uMzVS45s9R9ZHn93W0cJs6ZbMpceKXKPXdx9
	B/AOT5Xo6y6ZYAp7Tkmhe6/FaL21Bk7v1E5Au9qE/Ot5JKXWxQuvkbddCXI2Hr91
	3CMvjfuw56ykf5+7sPkJCZv8xUS+LPaE7ZE+diOUbSV07tbR2pj4R2TUSc1tFwts
	/kOF3bFsUZSLvmSjRRBKJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m0x513-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 21:15:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILDWPW018648;
	Tue, 18 Mar 2025 21:15:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdkp338-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 21:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cleeHJFedh2WkkA+v1zqut9wi8xiY8HV34iP099B0FiLecAR/CxO/FC2GLOZNJHDaYbItnsbrGx55XhdCDramv9H4aUuhiLOW9Xn4F/P4gAaWuZZYae/t4oMcJtoXzqYYdDcubyNiRr7OWuWzkAbL/40JJzLJBDOdaMuKa5/6nO0wtqYIQb6lTBchahz8CanquGpIbpKSypVqiZPge3aOGsjz+1fQ1/Nm2kOwmGMrEoFoc0HwnVe6WX6PRjCtwI51eVjPDqjBaFxJuWgWyr8I4/YQ2najI4CK3dECpnf7OMj3x5ZVHQ7zHB0b52vtCIumzgfWFoezqAaxCyxSh7fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ2w9ww3YsUJRSAHGbadZsWR5FErI9xTwMKi1kAlzUw=;
 b=RG8/kIfpVb4xfbxLZg1u2Xv1wFohiJmZpzRizvDBGx85QZRv3uP+NnC6UAE83heMlNeeIABBBH+qv/BDhA1N6162Yytfbcl7ye+qHFynbol09/P2dH2JChUrhkkUGdklCvdNvgUpuka0QOcmKR46rViCLcjnww4H5nm1uoEbDu6XMtrTXCeEkOgUiET6sw60bVR0RJOhAHIHjO3JrRpeaOmiLw0q2vJymDNgGZmi7nODauKGM53cfHKgtfOvPgqnz+vtp+3e4UmXJsYnZMnuI7O8N7Mw+FKQoxgjopbDVJdqH+eo+qVp2FsoKPR07fKnqYLhs0MRcC71iQrk7Oleqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ2w9ww3YsUJRSAHGbadZsWR5FErI9xTwMKi1kAlzUw=;
 b=lKMVeeL/xqmlAdPYiOhu6u1wQDxZDWCI3he84puIh4iyAf9vuTEfR9J3n3cRc+Tohpkma5cnNdf8adErMznBFyXvXlSeiWDB04lOwhrtPknnNcU8k7TQ3hQH0o01bnXgqpJB5QFUMEXlmgCze9YuOErSM54BnWwjk763gMM9zo0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4430.namprd10.prod.outlook.com (2603:10b6:a03:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:15:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:15:54 +0000
Message-ID: <37045667-d093-4dcb-ae63-5a577273e96c@oracle.com>
Date: Tue, 18 Mar 2025 17:15:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c24d17-d84c-4bcd-5eb5-08dd66621189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTU0WldSMm9XVmo1SW5RemR0LytReUVYS0MreUVyVFRTb0JlMG5kRzJrT0Jm?=
 =?utf-8?B?UzVHd3pkbW85ZmlmRVgwQ0h2MDlIMU1hdDhsUmYzS3VNdkMxTDYzanZNdU9r?=
 =?utf-8?B?am5uUjlLYlZjQkRNRmcwT1MzaHpEU09JYXlGeHdPWXIrVjNWemdoZit1RzRX?=
 =?utf-8?B?VW1HQkl3Tmt3WXhMbkxhdEc4SmtoZ0tiMXBNdUhqUHFVaTMvVjE3YzZ5T0Zi?=
 =?utf-8?B?QmNoODJ4R2g1aHJhanFLRlYwM0J0TzNOWWFFWE9JWTFubzBxVUp2TnpJcUE1?=
 =?utf-8?B?bHRiMGRWTWlYWGsrYThYdEJWY0JDSnlNV0pUM1l5ZnFEdk9xODdZN0xqZ1VT?=
 =?utf-8?B?cUgxVzgzSnJVSTlXTjlwcVlnU1RwVVk0cFpVWWxURzExaThCTCtLSkJaYjhU?=
 =?utf-8?B?cnFDcWNVZkZaTlRhUVEvR2pUbGxTSHJIV0U4cmNWaWVLSm95b2R1RkV3eWh3?=
 =?utf-8?B?alUvMW9PNHNUVXJZU2dLRHVoaGVNbjVJcnJrVGtJSTVvd1VWc0JoMGo2NS85?=
 =?utf-8?B?cDdoalZ1U3hDaTl5anU2bS8rZ1REbFhMeDRBblpQRGxQR04zRVpqWXpsWWJ3?=
 =?utf-8?B?YlBSaVdMOXRHSVg0WGN1STg1Wk5uaXB5QXAvZ1I3UHJNMzVOVjhaQnJDakly?=
 =?utf-8?B?SE0xTUVIaS9hUmlqTENvSTRPeU1NSXNBalRMY0xEbW1LMFZtVlhTaFVGek1j?=
 =?utf-8?B?VkRxdVpPWUVETDQ3UlBmaS95UzFVL2JUZkhQN0o0anVXeXo5Sncxam5ZU0lI?=
 =?utf-8?B?VHB0VC9XcWM1NDdVb3RvUE43S3AyREd5cHlnak0xTDlMQXhZdGFlNXVnck1K?=
 =?utf-8?B?VDNiUit2V1hUK1g1dHQvKzFvM1pZd2syNzBDY3UyRzNUVkxWQ0J5RmtaTUdX?=
 =?utf-8?B?TFJyUVIrUllibW55UmtwQ21YQVpQcjlJbVpKSG1PeE1KczZTUFZCdythK2Rq?=
 =?utf-8?B?Zm1kUEkraFE2Mll5ZDIyVjZQTVBPVCtRRUxZQWZBYTAzRExKcmpmMzNNYUR1?=
 =?utf-8?B?MEFaWjdOcXJxd0RRNmQxUXpLNSt4ZTJuTENBMFV4ejhYUE94Y2k5d2ljYXd0?=
 =?utf-8?B?TVBzZjVhdG1Cbk9vTEdISEdYM2xtTVpFZjVmejhLTlJhVWJKOGxJTm1WSFBo?=
 =?utf-8?B?M1VRRGFrL3ozZG5JK3NWYmN5RHd6SGUxdDJINHVUK2JndEpuY1N4QXhKNnBB?=
 =?utf-8?B?NzU5ZWxaRDcvMXdFdGxUWTdNNU52MHRyd1ZSSFVhdFdqbnFwYkw4ck1MZ0dY?=
 =?utf-8?B?OFozbnhOUGgrYm8zNG9yOWI0SjVxV2N0d0dYdVZPeU5GYmJHRHIwZFBwYVR3?=
 =?utf-8?B?MGg1eS9hancvQXRaQ2M0NWxjbU4vTDZwaW9vcmhaSGpXcFFTREY4aXN5ZG80?=
 =?utf-8?B?VHFGVVJPUy9ocFdlUTlPcVJPd0VsUHZPd1RzN2kwcW1namlyT09MVXArY0pL?=
 =?utf-8?B?WU12Vytjenc2ajJ2ZzQ1WVkwbmZXNlBJejRnK3RHemFWamVucTFkcUJXQU9y?=
 =?utf-8?B?bDBvakYwcnRhbmNPdTUxN1orbjlUQ2xPTzBJNGY1VGZ4WHZva3djbnpDOUtm?=
 =?utf-8?B?Z1hxTjNxaFRNQ1QwOUFtc1p2TnUrY09sTUE4bWNwWUJrV2J3K0JRT2V5TzBs?=
 =?utf-8?B?Y3g1L1M4Q25tYmYrMytGc2VoWDkydjBoWUcwekh2SWhLM0o0dG9iVjE5VEpP?=
 =?utf-8?B?eHRpY3ZLcVhaTFNFeDdTajE2emVsQ2FYV3ZGUS9lbmk0MUZQM0FEZ1JxUnBM?=
 =?utf-8?B?bDRxRWU2aE4wb3prMTdMcWRKRGlpMGdlZmc3R3FuWFBoVkRhM3gzTzJsMjZN?=
 =?utf-8?B?cDBramRsYnV5LzBuZGZadjZaN2xUaFkwOTlLaUhVQmtMTnFXTE10ZnNKcmJ0?=
 =?utf-8?Q?QArAfmF+bS7b4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG01ek1FMmFQYTU3Nmk4bnQ1WTlaMmxUNDk1V21hc2hsV3AvVzFOQVpGaVdG?=
 =?utf-8?B?WXhRNXltWkN1OFd5RWw5Yk13dG5TSXozY2VLY2d1SXZZaWp1Y0JJN1NuV3g2?=
 =?utf-8?B?VjJmclJGclg4Y0FNUGlMTUo2TUphTEM3UDhsU1AvdmtXUWlxUmlCbjVxME8w?=
 =?utf-8?B?dUc4cWQwNHFYMGQyOWU5TXdrQVFVbnY5WU9tcURqdXh2anRjWHVMZU5NSWdM?=
 =?utf-8?B?RDdwS09iQlpQOWtvc2hteDlNVThuV0srdFNhM0M1cG1vZVMycEkya29UZldI?=
 =?utf-8?B?dUt1cWZySmYvYzhIczZLbkZYZnhIMkZMNCszOGNnVlNhYnZvbG1XR2kwSWsw?=
 =?utf-8?B?TnE1UmF0Q1NNeHlKakEvSEdkaW5yKy92Sk1MM1greE80YUxFY2RaOGJCTUl3?=
 =?utf-8?B?eGluYzZQR05qcG12dHQycEZBQWNrZmZFT0tobnpqLzBrRDdqcE5ONnVkQ01F?=
 =?utf-8?B?YldMOXcyUVFUbGQ4dFB2enFLWkwza1NuU1MzeXNCS0w1cDEydkJxNEFYRjRh?=
 =?utf-8?B?d1BoQkVMMGRaaHJJMmN6TnAreXhZa0dQdFdrYVpPeXRaUmQyQmF5ckh5L2NY?=
 =?utf-8?B?RFcrVlpnVXdycVE2NGgrVCtFUmhPeVpFSFM4K1A5azlRcTZUWm9XYksxWXhB?=
 =?utf-8?B?TWhJVXJ1dFNCbmhWU3BrQlN5eEtvRHdnWW41YXBCaXlyNCs0VkZBeitiZ0FI?=
 =?utf-8?B?bmgrSk1MVWJ6M2hNeWswME5Db2ZPSENwc2hqRC9SbU91TnJPdjBLQ2hpclBO?=
 =?utf-8?B?UzY1eVViVGJaWFNzc0NZblhtVXFNZVFVczJoampUT0E5YlI0dmJES3F5THNC?=
 =?utf-8?B?YWoxUDhGOTYwUytGTVJmOFRaOVBFWUVDeUYwbzFINlMvcngwMHVrNDliMUNI?=
 =?utf-8?B?dU80UFp1V1BXT0ZkZlM3NU14RGhoNkR3Y1pvVkpBLzVVcUFla2pucUVXdlJw?=
 =?utf-8?B?RFhub2NoaXhjdmNaSkZWY1BIMG9CSldHVXcydmRqeFJ1N3hTbFFvLzBUaXJt?=
 =?utf-8?B?N3FicHZQVUVoNlhXSit2WWFpUmZHNFFyTnJoaXVFeGtUM043cHU5eFprZzhP?=
 =?utf-8?B?STA3cElvZnR0dWFwUFlGY0FOWnhEb3RKUVFqdUFoYnFaTlhSZ2wvZjdTaWJH?=
 =?utf-8?B?cXFYSVVSNzJQZnBJZHMyMEdLcHlLM1UzV2Q1bGwyY295NnNIcWpselhDMjRY?=
 =?utf-8?B?STlFL3dFQ2JMbHNLVUkzRE1mREcyUlhCVVBTK1F5T2Y4a0srRkZYZU1ieGxl?=
 =?utf-8?B?VmFkSzlOY1Z2VjlodDZ2VkJNUVFOQ3BoNG9mbXhjRFJzcjR6T0tvVUtiUndK?=
 =?utf-8?B?dE5WdHRPNHNMcjJjcUtONm9iZ0hHRmxKMW5oMDVwUlJ3eWtXTnJDUFpMd2RR?=
 =?utf-8?B?MnRRNzdxWXhoMUgyNVBCdU5tN1E4M0hkSkJEbmh4VUJ3OFI2Z0MrZzFzV0RH?=
 =?utf-8?B?ZUxJVnRvWTVTS0k5YzdBNEl5SCtFdjd1dkh3ZFc2T2o2VTVrMFc1NThsSWpk?=
 =?utf-8?B?OEk2bGQxelhVNGNYeWh1N3hXcFdjOGI3cy8vRW5OKzNwYk9vNTdPM0pTM2lQ?=
 =?utf-8?B?TTA5V3BYZUsrNTQxMk5SUUFnWldCQlFteUxaaDEwRGt1Wkdqd2JNNXFla0hJ?=
 =?utf-8?B?NzFVK2llbWpaMzByaVR3UXdKNFJ0Y3E0VmQ1YnZCbWF0VHVpS0lKOWVTK3pN?=
 =?utf-8?B?RWhzL0VmT2RoT0R6ZGlsNUJldFBvdi9XRnZmVVJoblNtaWlmVllGaFR2aDdQ?=
 =?utf-8?B?V2J6YlNYdnBRQWJEVmNmdjlDaFJZdDcrOFhnU3d1Zy9acFd4RUx0U0orcnUw?=
 =?utf-8?B?aW5zL2U4ZE0ydEtmRzhNdUNYdmtraDNvQUY0THZCQ1dPamRwcWFTQjBobmhn?=
 =?utf-8?B?MktpSUxOam5ZQ1hmVmwveTk1V3FiS0FnVUtRcGRpTGlCVnIxZ2hFL1F1eStE?=
 =?utf-8?B?UVQ4SUZyK1JrbEhyOWtUNDlrTzBxNUdCQlZkd2VoOWJmY0hLSmdrRFdUejcz?=
 =?utf-8?B?dk52VEl6cTlMVFlQZnRXbDZhZDk0enNrUnloeXFGNTNJamZIMkQzeTJXYlRn?=
 =?utf-8?B?d2FoN3pTL2JSSEI5OVR2YkZZSnRvSFdUSUhpU2pIeFZaV2VJQUFrMkhRd2sr?=
 =?utf-8?Q?Ng78DRMYgE9AtkfRzGif/sRTv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ctVjGFPwJMNFN4LB/0wV81lbY/CS+QKCVbmGYEdkd8ewd9qOrMpHscFoD+JWWeRxB1A/B6aGE4/vBdheqrWEepa3Q8D8mKhhl3cIjMdaZ9zSrJI6RXk0GAK5tbAZ5qHLOW/20Idjgl8aeLv0dT+Jb33trpqtvKGWb+uEh9+FgY5jZSk8kJI2x55gv1jLCInM8lTU5FUx8HKHSUB1uSaRDGmwOWgUbcMfsF0zzuKzKrKrHpN+ptRZJ4Lb9rodzB0RFYDmQeu2p9DPCyes5AWTnUP5MvX7hGphJ84scyMsV2cio7ChSlMSs3OBZgg/PqKKTyC/Rtat7oQkvKHphv98cX4n1n74tjhhlfzQstjoMABisbgGMjNyCEQYhlcleQgosBVEAi//9zoyFZd88YD2C8rKFx22aRDF21eGzJfayHZAih1KdynM2l0nRYEBiSuxAOG9lrk5kR2VYUHdqbRQ4EhOJS+TT4G2hcti0O7UC150VkGcw6uP5v4I7os2QpSjRfOfPvB3RugOMOTsMDNeyJuCaMUTTjeWDoweHXbqAB7KjKS5O3VPfWzRQKIuls7b/0UJJvj4h6N8/Jp5yVRSuRSkfSVkPiuHrEA6CGi6yYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c24d17-d84c-4bcd-5eb5-08dd66621189
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:15:54.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MHeGMDIyiTEcX1rZx9PFsbJjij41OjbUPdR6k/IkIq7RP/ga1mBmT17MeC7koC1wDhc/GFK5FAxhC8psk4IDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180153
X-Proofpoint-GUID: xZ8BBjnIx3Ww-CxPW4QEA9VZPm_M1o1e
X-Proofpoint-ORIG-GUID: xZ8BBjnIx3Ww-CxPW4QEA9VZPm_M1o1e

On 3/18/25 5:03 PM, Rick Macklem wrote:
> On Tue, Mar 18, 2025 at 9:01 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 3/18/25 11:09 AM, Anna Schumaker wrote:
>>> Hi Takeshi,
>>>
>>> On 3/18/25 11:00 AM, Takeshi Nishimura wrote:
>>>> Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.org:
>>>>> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks as
>>>>> unwritten, then issues a zero command outside of the running journal
>>>>> handle, and finally converts them to a written state.
>>>>
>>>> Picking up where the NFS4.2 WRITE_SAME discussion stalled:
>>>> FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
>>>> that for NFS is via WRITE_SAME.
>>>>
>>>> How to proceed?
>>>
>>> I've been working on patches for implementing FALLOC_FL_ZERO_RANGE support
>>> in the NFS client using WRITE_SAME. I've also been experimenting with adding
>>> an ioctl for the generic pattern writing part. I'm expecting to talk about
>>> what I have for ioctl API at LSF next week, and I'll post an initial round
>>> of patches shortly after.
>>>
>>> I do still need to think through any edge cases and write tests for
>>> pynfs and fstests before anything can be merged.
>>
>> Takeshi, it would be immensely helpful to us if you could provide some
>> detail about how exactly you intend to make use of WRITE_SAME so we can
>> focus the development, review, and testing efforts.
>>
>> So far we don't have any specific use cases, but there is some
>> skepticism (as voiced in the previous thread) about whether this
>> facility will actually be useful.
> Just fyi, there has been a similar discussion in FreeBSD land.
> The main use case in FreeBSD land sounded like writing zeros for NVME,
> if I followed it.

We were informed that NVMe devices do not support write_same at all.

But I'm more interested in why applications need to get the OS to write
patterns. What kind of performance and scalability expectations are
there? How big will the patterns be, how big will the target files be?
What is the target improvement needed over an application repeatedly
calling write(2) ?

After staring at COPY offload for some time, I can imagine that there
are some DoS footguns in here that NFS servers need to watch for. Can
WRITE_SAME return "I wrote only 16MB, please call me again to do more"?


> My impression is that the other pattern stuff isn't very useful, since only some
> (a few?) SCSI devices know how to do it.

Well that tells us that hardware offload is a ways off, unless
someone has a specific device they want to support.


> The problem I see is that WRITE_SAME isn't defined in a way where the
> NFSv4 server can only implement zero'ng and fail the rest.

Writing repeating patterns isn't difficult to fake for file systems
or devices that don't have a native write_same facility. Trond suggested
a way to do it in the previous thread.


> As such. I am thinking that a new operation for NFSv4.2 that does writing
> of zeros might be preferable to trying to (mis)use WROTE_SAME.

I don't really understand the difference, from an application's point of
view, between WRITE_SAME(zeroes) and DEALLOCATE. The storage behaves a
little differently in these two cases, but what difference does it make
to the app?


> rick
> 
>>
>> For example, do you expect to have SCSI devices that accelerate
>> WRITE_SAME? How will your applications use this? What kind (and size)
>> of patterns do you expect to need?
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

