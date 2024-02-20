Return-Path: <linux-nfs+bounces-2038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459F85C8D1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA521F21E99
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBC14A4D2;
	Tue, 20 Feb 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHcfw89E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Foi/u4Ss"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C1151CE5
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464359; cv=fail; b=ldhho+waXDVUigs2u9yDCXJFduwE4GEXPxvDF1DciwquOMz7GuDt4w7DygPd6ENz9raGL7iSVvKJNxrtOK9ryalipyPKgbVZ9TWT3wI6jsj1oHsRvs0eKDxvrobdDsfCZpp290A+qJyyyGpKeNNZXd/5FM431ifPm+muiArvf9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464359; c=relaxed/simple;
	bh=tM9t9/1lz3+Xp/s/U/DDYjuKBSn66GP1CqdrxtRHnQA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r9Z7etAoDGXfDyXMmAQnutVzLfTItdFDKs9sQk4SOMyEN/QfEF9jeV9c19FQm7yjAD8KwCbzmzXqDhdHk881/DzBtjbAxK1gLqWu/uu+nJ6FCODmyWidosk8UOTvdKf7ZRpvkfJEYm8CL5GL2onXqSy2l3+6oDJVb3Cuqal9MuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHcfw89E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Foi/u4Ss; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKSp7B029403;
	Tue, 20 Feb 2024 21:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EKSS/OpjW7ovy0YV9MJUrgOR5SqbJUcp7CWYdG2c9GU=;
 b=OHcfw89EMl2ZLU4DufcYOYvVbbayIL6yDSZDEFY+szGRxs5XIBuZBSNUYml+weEAU73W
 i0KL+1302fDn113QeC/7N0gpA3pabk1ufUsIBz4TzWUP0gP7ZCnv002r7P/6SONEeWOm
 a0M6MC10Mb7Cmd8xIUWIiKefO1hFDDp7oZdGNCeDLd8I4/N+WGlC4hTpqJ8evw9adCiH
 +eOKNwB3VysYdeiAPfWAdXwKM4+O42PXEQKvHZ8LwRJx7COMjLyBy5+XcHWsEr+yXaib
 7AVGc6CrbMv3wSEudmxhQ73FPotX3kCtT5rwLIXn7kgTh7zxGupQgnRvHLPZFW88hp2i UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud05u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 21:25:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLIfmc039727;
	Tue, 20 Feb 2024 21:25:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87yf2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 21:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmVd7zFzBDY2a9FE/i21mcQuTyXVw9kzwV29rfhnP1rjUOeBe7d4TLS3cU1xocm2KV/1bN4p4SlyjyVPi6t7tSJPyssDiLvoT9Me6GmljvRNT+3GjIS3E2kWEuV27YF5LmxSaW4oTGt4T1jiFuFbePDAUgHVgxmHRAMb4caNmFTDz3tOtTpndTDI5M38YAI2dPZ94vRhu2djiL8LN8hgdWbkjGX2/DLzLwclg7/+85KGCas8hT3sufDxwfvXT2eWEbWodpag0Tbhzln9qIrwDNHyHFIhGcQkm2OCQZjS4z7q50mJtSE5dfP+Tjv0FITeibHy2N7ftPcR1sWck3+uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKSS/OpjW7ovy0YV9MJUrgOR5SqbJUcp7CWYdG2c9GU=;
 b=PfcBPnl9EKRH3pnCKffWPzqboKrP0mLmPt1LsyxVyb0tNtYB7lay4rJECy9a0yVfmbPClCSu6rpQM/pDCitbT+Qsu10S1EClRCj/LVIzo2ktUGl2LkgMIcZLGkVOAmfn1JEaSsgjVBepNZ61OYAxeJAK+2ub+2g2QhA20/Elip2z0MDhOJND2brtHXGaLEWTIyU+zA4lSPk9DEpfDjuqKVugSN+wqY2//fiMnyhzxXs2C4NcSt4SeVfl9bOnQVsk4mBRsWTcRh5LnnJAdfJ+ipV48RGtPi5xu5mPYh+xMFLVknLf0Ba17Stc629Fa+EeeUF2/z3A2TDUC3IwbsMhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKSS/OpjW7ovy0YV9MJUrgOR5SqbJUcp7CWYdG2c9GU=;
 b=Foi/u4SsuZkrd+PKh2ds9Aio8PXUt7f1vlHonlQIf3md72fwCCw4uSu0tpZYd4/zmM7o0XEk76jXxXubjZVui3c2XOAawuCfF+gPMfH085u1MSZG3zZ1KSvxj56JAVyEAKED89iR2fFoztzoDTfenEPgQ/FBAB8OeXN2o9uEPfQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 21:25:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 21:25:49 +0000
Message-ID: <60d031c8-fd34-4093-9ffd-0e661de306df@oracle.com>
Date: Tue, 20 Feb 2024 13:25:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2)
 called with O_DIRECTORY|O_CREAT
Content-Language: en-US
From: dai.ngo@oracle.com
To: Jorge.Mora@netapp.com
Cc: linux-nfs@vger.kernel.org, brauner@kernel.org
References: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:510:23c::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 724ea45e-2124-4199-4f92-08dc325a8263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KJbo0MQE6v2Pfk8yfz0r5gOwLEEeefhgL0IrquoyIm3CVCMpYz03wc94G3FPyyVupJl7aTqO5N/Bs83H7k/bE7yiIw5W4Q8sHVZLtGDdSQiw954nazr2HLGNvHaeq9Lbp7X2VObpkLoy8VNliaDQkmsWILgh081UKWezwagEOHq1UEc7vJZ1gaI3Opx7NRfK7DCqk8ALKu8lXCyEQptHoiHsoa36AcioBk3x+73kjyAlzawXcyzA9tdo5Ehffz5eaPPQzEerEhr9B5VUWq5JdUeg+bsD01ztzxhsaZBKeNgLUUPDB8WGjq7+ZN4tXEdCxpvnU8ZwzmYw1W2fajRelcf+OFD2wkSnHTjNaOKTdtzLSBZy2yu/9KcfFaRVc9ej/Y/UlPThTOmGcoz/Tk+mfV4btcrzyeqroQgTDbzE+YzW9WtH5Hlj4QVP3zrA9fi4ujmb3ITma0p5xPwo8DCNzARLjdz39WVtCENW62DP86hruXYn8+bjgaQfdz12CzUo3MHkjxvsY6J0/RBZ409Uz5FBbd+uLUoKc4CyPhNadcc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1NjNUZ2NXY2d3prUXJqWjRpTnpqN0YrMDAzS2RmWXJxeWFvWkFBU20zR0g5?=
 =?utf-8?B?OENKNkd6TXFnZEhwUUl2WE1HYVVRdmRkREFVdjhjR1dpaXdOVVpTUkJVRE0v?=
 =?utf-8?B?TGgwODdvZFZacWt2cFJPTWFiN0czQW9HSzdPeHBpL3JXUThtWFJOZkNSMlV6?=
 =?utf-8?B?aVJhZTdYNVdBQktBdkRPZW1TVU43NDNodDc3OE9Dd1VSaDBrbUdYSVA3VUZS?=
 =?utf-8?B?UGM5Y2N4bTYzSlpXM3ZzSjU5TUVzemVsZGQwMy9HVUNvOHRGMGoxRDdpWGZD?=
 =?utf-8?B?N1ozamlCZkR2TDE4Qy90Zm1kNVoyMGF1WC83QmNEYWI3R2l2eURVYlZkQlVS?=
 =?utf-8?B?M0RxbnlJMDNWMGlGTFBGeEVoY1h0dVc3cld0SSs0WmxJYlVubHJxeVB2QVk2?=
 =?utf-8?B?ZVk2WmZlZVZ6RE8vQWNWWEwrZEdtbGxYZ0d2c3ArT3VOaExtNWtTeStEUW1i?=
 =?utf-8?B?cFBVUWRwbldaaGRGQ3NxcG4rbld6Z3RrdmJuaGNydllOeFYzaVlBMW52MStG?=
 =?utf-8?B?bktwZG5qYmdtSmRLVWdaTWY4Tkhnc2IyZUdEakxub3NYak1PaWZsRWE4VE5D?=
 =?utf-8?B?WmFFWWhPVysvdFkzQ2Ntd1FVOHdtYzNPbzdBRUN3cjNMTzZoRCsyeVorOWxU?=
 =?utf-8?B?RUc0V1NLbjBVaEZuejlMVGlzcWYxRUFWallUZlJ1OStYamdmbGVhSUZqdnRH?=
 =?utf-8?B?ZXhjUmNYaDZsbUxhc1U0SEJZVGNaZ2kyaFlkWDM5OXZZVzRSc0liV3p5Y1NW?=
 =?utf-8?B?dWoxZGU1SVFJL1o5NE5GbWhkSmhxa2l2NC9uRjdxZjhEQkVUTDJXNlRwQnF6?=
 =?utf-8?B?UFBheFlDb2tpZ2FSUmdraXZwR2pjWkM0VngrUnRPdEJhQ2RHNXlyWHFzaCtz?=
 =?utf-8?B?Rm5NK1lzN3J0NTR4MTlRS1g1dlZpeFZPRWpYeWl2ZlNjaTQvZDFzYVRWVEZo?=
 =?utf-8?B?WDJVOXo0SEczSkVScSs5bmVJNUUwN1ZFdXZJL2NVUmV5SzQ5ZkR2cUYvUUhu?=
 =?utf-8?B?WENUZHRtSmNiZ3N5M0dZdFVlZnBST3BxT3RKUW84MnUxVWZHRGpZUEtXNmQ3?=
 =?utf-8?B?QlZvbCtucUlqVGQ0OVJCZ09ORzh1MGdSVDIvQjVXeUlwZlJCcmJqcFhRWWZH?=
 =?utf-8?B?ZWN2QXFtNkNmVE4rYkowSG04N1ZRQmZUWTQ5VkNWa3RIenJkOXNBc05BWHl3?=
 =?utf-8?B?dEUzaG5QTmZpUEZNa2VwRGNNWDFXT3R5SUpuV2xkdGJJcWd2T2NlWUEwL0tE?=
 =?utf-8?B?TU9HU0h1Vmdod0haWGlPNjB4NmR6a2crYS8xTFVsazJZcVV1cVRRdDFQWEMw?=
 =?utf-8?B?SXpiRG5uVTFuMDI3MTdOQVEveFlwbXZmTGYrTHlaY2FnMkkzTXFmNUFMYWdX?=
 =?utf-8?B?b1pTMGcrUk1XdVZ2T2Jmb3lCREdlMVJkWHd0UFNFNEdLTkg2QzlaekF5eTE3?=
 =?utf-8?B?Q0lWdWYrU292ZFNuRG5USU03VG4zZm9wcFJGODV0cnkyTXM5cy8rOGIvdVR1?=
 =?utf-8?B?TGF3Q3ZoK0pvdDJuQXVqM1p2R3ZJQTFQaEp3MDRkZXd0OEQwZmV6T2hZZThv?=
 =?utf-8?B?WE5vWllyZnpSNmZTL2ZCenkyWFV6K0pMQTd5c3dIdjNLL0V0QVlkbC9qYlp4?=
 =?utf-8?B?MmNkOUpuQ1lGMEh3eEZXM3cvSDM2VlB1ZDNQR3dvdWNiSS9kZTVUVGUrNGRj?=
 =?utf-8?B?ODBmejhaQU5FWUFkZDB4VTYxUEJMenhtdDlyNEpRRm4rVXUzNERaQmVsbkNX?=
 =?utf-8?B?dGJHbjB5TGFrcWhmaFNWd2FVQkVnbTVHcDFLL1R0R0xKYXZMZmUweU5pemhL?=
 =?utf-8?B?NWIvOTVLSm5rR0c4ZEt0elZBbzFjWm9mWWFJR1Y4MVhmdWhiRHVBRWtRdHNa?=
 =?utf-8?B?VUVuNkY0bnZFVjhjQk9CV2Z4Q3FaWjdmZVIxTnpZY3pNcnFWdWRZUVZ0YXBE?=
 =?utf-8?B?aHp3cFpXV1NoRXpoVCtqbDNOZmNpVyttckpIdmFwcEJsNU9Mb1M3RVlBRVpm?=
 =?utf-8?B?amRrU3FIdEVWQXp2NkxEYkx0SUtrQVo1R0VLWXRjMElLNkhzcHJoSGtYSW1j?=
 =?utf-8?B?N2YwcXNNRTcyWDFveDl5c0pERGQ4U1E0bnBlUXhNWmlGT3JqNTdKbHhnNWJD?=
 =?utf-8?Q?VAouW6umxrsT8wKsqqH4sHZPc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uJChcZxT9B6TAUqaYX2+Fgv+KuYsu5l6Q3+cOp/AF+kfYFOpB7Gl6b45TNTcRHooQOX/gWHFRTYKqnV29NVfjBhMiVyrv9XEscz1W5aCivA548RdXRjHWUYlzLZt8St3iVcrww3ojmV/uFpY3N0jwusBI4BmQvn9jC/U+gfvKb0hPf1O3M5MEY0rq9+aoKBnVeTMoeO//w80wolbAlQXiAt1emZdIMQYDUKicnlmVcgfSkHiv7mrAPw80rYmFs2HZ3PIoUKFKk2hw1Eqy8ZBj+1C3qDgHZuDy0xxAkGJOoDd/T7uB9ndhS4v+75Tr6v6G8iJsFo+nEc41RdtMfb+V9L+xBuGLdGJXTZHVEOwCljNz50vj6MI9fmPv6XpRXUXooP4Oc2OSzUj3rVyTabKBnoyE0ONF4QA2vS0RzLgpdDIbnoVJQm4+GCicV+/7tcFKHMC5S5JnhJ1TbAwkS5XcP5lAt6+vyrYN1hhDUHAEdfy1BiE9/2ci6Tu9WVPbnIWWGBujRg+6TF/dcBNurl+gw16th6Iwrq3Kr8706Q5bRMBJYrPeiJUPjCJ+9w/cnqqbqXNoSwkChekpNKr4p/JbUvqZD193LrKXG2/cGjWw8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ea45e-2124-4199-4f92-08dc325a8263
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:25:49.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rODD7T/ECKbXRywz7wUSGQkpF1lYPrAEJ77Sowo3ewMXQlQajTrn8B+FkDsvjNmkMeIWNGomCfR/2HCp230IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200153
X-Proofpoint-GUID: RBF6Hl3-6rO94v6g_rlEYCvIFh86qiN-
X-Proofpoint-ORIG-GUID: RBF6Hl3-6rO94v6g_rlEYCvIFh86qiN-

Hi Jorge,

Have you had a chance to take a look at this patch?

Thanks,
-Dai

On 1/17/24 10:01 AM, Dai Ngo wrote:
> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
>
> FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
> FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>
> These tests failed due to the commit 43b450632676 that fixes problems
> with VFS API:
>
> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT
>
> This patch fixes the problem by adding a check for EINVAL when the
> open(2) was called with O_DIRECTORY | O_CREAT.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   test/nfstest_posix | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/test/nfstest_posix b/test/nfstest_posix
> index 57db5d69b072..6d5fd0dfffee 100755
> --- a/test/nfstest_posix
> +++ b/test/nfstest_posix
> @@ -1232,7 +1232,12 @@ class PosixTest(TestUtil):
>                           fstat = posix.fstat(fd)
>   
>                       if ftype in [EXISTENT, SYMLINK]:
> -                        if posix.O_EXCL in flags and posix.O_CREAT in flags:
> +                        if posix.O_CREAT in flags and posix.O_DIRECTORY in flags:
> +                            # O_CREAT and O_DIRECTORY are set
> +                            (expr, fmsg) = self._oserror(openerr, errno.EINVAL)
> +                            msg = "open - opening %s should return EINVAL error when O_CREAT|O_DIRECTORY is used" % fmap[ftype]
> +                            self.test(expr, msg, subtest=flag_str, failmsg=fmsg)
> +                        elif posix.O_EXCL in flags and posix.O_CREAT in flags:
>                               # O_EXCL and O_CREAT are set
>                               (expr, fmsg) = self._oserror(openerr, errno.EEXIST)
>                               msg = "open - opening %s should return an error when O_EXCL|O_CREAT is used" % fmap[ftype]

