Return-Path: <linux-nfs+bounces-12445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC748AD9221
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F197A199B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81BD1D61BC;
	Fri, 13 Jun 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drZsw3oL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yyq3lqKU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84018DB29;
	Fri, 13 Jun 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830269; cv=fail; b=SAFAlEeQpnVs5dUpqg040QkCbLhm2xmdc9QPsdVLlP0GY2uzvUdGL6dh5eZ5pOopOQm4UmpMskJgUQEjVwZYCm5VjleqMMefAmZN/nWXxWgATaQdMz1XnY7PWWEhCvy1fdyU5nlNNzPfVMh/woc1yDGboVLC0IScEyJDSgKaX2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830269; c=relaxed/simple;
	bh=Wf6p/IiwYwzMo5H1+PA2wDeyWmEuvH3YZ4vczbhOMm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETREGqggVMGIYDke/znA4yKgaStjAdPIZAwKGaIma8fiddO6UhBlnJ3czf8A82dT+l0rv3+kXd8a5JzvV1duu8HbYi1tVTFALt84Wb3Bzx8fiTgHXQ9V7v3JuCxvIN2iIGE7ZQPzaIcVb+/BYbQZc9BpwQ7rUr0o7Mtwhrwfee4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drZsw3oL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yyq3lqKU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtf2O001782;
	Fri, 13 Jun 2025 15:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nUdVZG/igNYZ8bPiSSpwlYG41LjEPBgi1Cm0+mCLdQQ=; b=
	drZsw3oL5yaSBr8F/EylCOloCYD/acMd/iLTqKMQm7xPXPnr9MM9MzGQ/4UaVlZj
	E8P+ySkFLO0TUEGczWmP9v7693Casvsvl2SFhqqGd7v4MWZnjN4+CPiGP659yOgn
	RWwJs701TSttK/HOaqVWEkVFodoS5LOTSKNYFTGcsphswrMm564+wC26fWCdC1pf
	RRVaf3EIGuC69KVi9GzJO/fTjaU42aMITukvmpCyrRDJYQ/z2L80f979MjuFb2tx
	RBzOm4rF7y+Wgb/CQvpIcDGupRv/wsznmK9XK/L9EGUcqLqh0EekDXTzIEwFYpQe
	/iyFCK+ZFicHOEwcZj4r1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14kuq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:57:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DF5oYs037788;
	Fri, 13 Jun 2025 15:57:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvk9ywk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 15:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs/XsxcGzgc2nDZ1p6gJp1nuCrWlwo72LgZFbEAWwBN2W4JPdWKXHRxjfjQDP4qY8hhQoPVw3mJK/tTwJWUgbaMJdCs2nkQY6YBlltHDcKNBs7CMPkVGlrOpfDhUHeLWcsW1TLqZdQ1cqLgCt+x3qke9qvfFGFiefq0Lz/ZFF8eTHmc7PWlYlUV5o26OITDbnk8UF7AjozxMa8PlShV4zm1FRyjibRtqs/45SpgGhCoFSBSH4bdYt2FpdMuiBjqe1cerRtjwd0pcibpLLuVjBnWysF9ZCvKYSGGehaFo+Yp7T+ZHHPh1NUy366KfyKSAOzmkNm4DIKWJIfRpl7bsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUdVZG/igNYZ8bPiSSpwlYG41LjEPBgi1Cm0+mCLdQQ=;
 b=Tk5bDXVoRlHNorPfovldE+4zP+HcF9YGZVhx0QZG0S2f8MEUyL95eCfBRa17Ju4qzSPYatMYzGy+udGTTz5Iv/ezpAOs8n5hiOuZD/+IUuKc2PhIcihq5SyZMzAEu/1mriYxCaXQ1PdsDUXP6qEp0GBfr2ZMn2ArCINSStGoD9OTcUfjpo0Rrdehkb5B6BLISTDuxG1aVX6S1xMTxlGi4OXSZKYsgfcDHb5QKz7IVY1KnJypdG2s2sDiZgS43UT8z4sCw/Laer80lb4GqvQkCEufb75t5jwXl7cmEHpHA4fYXIBqbgJikkiWrr9iWUR2HyqYl/qpLyChS+5Xb2NvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUdVZG/igNYZ8bPiSSpwlYG41LjEPBgi1Cm0+mCLdQQ=;
 b=Yyq3lqKUOhejWDHmZqIIO4V4TZ1NxUGbN5uzApO6XPjPq7xyrqoGxy+/o8IRMUPL0VFkT4qSuj0smiH+GtVODn+mgE3h+NQ79/AxhR3PjCbr1gyQNl90l3JGP1To95+xc60Ev1fUce8fLOvyVe4FrAQ0fZabM+HeHO1uterjs64=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 13 Jun
 2025 15:57:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 15:57:36 +0000
Message-ID: <5ccae2f9-1560-4ac5-b506-b235ed4e4f4f@oracle.com>
Date: Fri, 13 Jun 2025 11:57:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Unused trace events in nfs and nfsd
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
References: <20250612215801.2c4c0ff8@batman.local.home>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250612215801.2c4c0ff8@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: e56799ca-cc7c-4a20-076d-08ddaa9303e4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MmpVNUQ4bXNaZXJINFgyWlFpS0YzNG1qalAwTlJIYnhqQzJWN25CZjBlOWlO?=
 =?utf-8?B?VDJpbjlvMjhqOWpaNU9TMjg5TkxQTzJoTkkzUStMU21NQzVhSjNFRWpGdWVx?=
 =?utf-8?B?NHRRVGE0Wkdrc1EzR1VuRWVEUVgzYjBuMGRJQlFSNzRvcWVUMjd1OEtTdG9I?=
 =?utf-8?B?QzgwL1Fod1FJMDhEd1lyV3VseUxaSXpjaWlwTlcwaVFLeThYRUtXb002bVRs?=
 =?utf-8?B?Nm9OU2hNV0h4MTd2d2c0b3hYTkxnME5TdElJeFRnOVJxelQ2bGlIQjg5TGJx?=
 =?utf-8?B?YUYxeEdEZ056V1ptTCtBS3FRZ1pxK01rdXJoTEFEZE96K2tjVUpwVUpmMXR1?=
 =?utf-8?B?SXIrLy9CV29vUXo4TDBOQXpFay9mV3FpaVpPclYzUmdkdmhsaXk5QVdEWUV3?=
 =?utf-8?B?WjBaMUJKSldGVy9SdUk2NlVYRk80V3lCTnltNk44WFNFWm50OWdtbzdwa1BJ?=
 =?utf-8?B?VkVJWUcyNDAyTkZsZHVTdFZJb3A2R1BhaWwrUExUV3oyVFZTV1BUT3drSDUr?=
 =?utf-8?B?b3Fzb3YwRE5NMjQ2cngyMnBSK29nd053VURvMHJ6ZGZwa2ZHTjdKdCthWWg5?=
 =?utf-8?B?c2RUbmk5b0lnb2JhNThTNVRtSysxZXlMQTZiTFNGS3Q2bFlrVEJ3a2x4VFI5?=
 =?utf-8?B?YnUweitMZTRUVFZoYkxTMEMzWHRsK2c1SkF1amJGai9OU1U0QjUrLzdtN3c1?=
 =?utf-8?B?Nm9vZ2tkSk1xalNTRWtvUG1LcHlFS09xdlp4dDl1aG8xVkNlWi9sTzlFRzVz?=
 =?utf-8?B?YWpoREpJQXd5dmpUS0p3T3ZBUy9xa3BVa2JydEZkWmw4MXJReGNvOWFvWS9m?=
 =?utf-8?B?OUpoRnZka3NzaldEUEpnbyt2SWJCbklRRHNRRVNOUk9XZkZOSytteDdDQ2U5?=
 =?utf-8?B?S3RWRTdyNE5iRC9xdzJRQisyWmxQM2QzMllZcXFBbnJWMzdaZHVLNWlheXNJ?=
 =?utf-8?B?STBTTlNVTHVUMGNVMTl5eFZmOWtHSWpISUMrYVVsYm5nd1ZsdzBubEdJRkZ3?=
 =?utf-8?B?UFd5TmNLbzZmTmhmVWQ5UmhtSTlhOSs3RjR1ZzVESlY2djQveTdINXZXaXd1?=
 =?utf-8?B?UUdHM0JxV0l4c3ppZFNqZ1pZWHZ4SDdCN3J0ckJCVkdGb0RNd1IxcUVyVHZX?=
 =?utf-8?B?ajg4U25LcUJuOWhrbE4wbnp4NUwzU3VGbTRtRWtkUEJTZEs2ZzBlT2VUZTlL?=
 =?utf-8?B?cmdDYnJmOElQTnZHOFFQUzdzdGlhK1prL0l0QWF6MDNXRVh0MlFYYVdDZnJk?=
 =?utf-8?B?dUoxR2l5UCtDN04xc2RDOUhoZWI0TVF0anJ6TDVEbTJKNlNXd0hPNnV3UUxm?=
 =?utf-8?B?WVFtdGg1RWMwaHVnWElpcStNNjEwUzFqQS8ySjd6c2g0ZWxQVGl3MmQvMEJi?=
 =?utf-8?B?NFNBd1VxOFQwbG9VTDBvTXNQd1ljd3dkUTNsUXJ2M3ExS2FXUWxVQjdLd1pk?=
 =?utf-8?B?Y3h5dGNBeHBqRHh0OGlzNmVKY1Z0U2lMQWpjdEdIdzZMR2FyOUNnZ2RiVFBI?=
 =?utf-8?B?VzBJVlViRUx0dW15VUkvdHIyaGFpMEZGK0wyT2JML3ZQai9oejBocjZKVWQ2?=
 =?utf-8?B?WlN1V20vRWdLWndjN2xmekc5YjlFd0ZCb2ZkZHBCbzloTGtWUVhKdU9GeXBw?=
 =?utf-8?B?ZEY5eXVWUHloSmdqb055K2tCbVJ3SjVYL3I5UzQ1R3hWajFRNDlOSEMrRzlY?=
 =?utf-8?B?K3lUU3VCU1RxRnQ1ekZML0gzbFhpTGxEellyUi9zOTlad08vT2IyWjdBTHBt?=
 =?utf-8?B?NU5vVGZBTmk2MUxLcFcxQ1BRbmlPc0c5VGlKWVVnVFFuOUtqRHI0ZGs0cmFC?=
 =?utf-8?B?R3hPbnA5VmYyNVQ3NnJkZXM0S1lPOXZVc2E2U1Nrc204bCs3WERDUExOODZG?=
 =?utf-8?B?WWhTM3FPbWs4eTl6ZlNLSWxOUlc4TksvWlVPVUc3SkZBNDJmMTBIRjJDSGFF?=
 =?utf-8?Q?Yj9tKSvLbRQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TmZybytSVVFaYzViOVY1NEZkWGtaeHhWV0JwL2xNTVVBVEZKYzRyNnkrcTFP?=
 =?utf-8?B?TktQc1lEa3l4d1BnMUVodU9HeVpMVWUrL0FvMmxwNDk2QytaeUlkbXJhSHZt?=
 =?utf-8?B?Wm00bG0zMjZkdkIvSnlwcERMRjBqcW1RS0VzQndaWFRWY1dsRVBUV1E1NHVw?=
 =?utf-8?B?cDBHZjd4Tkpkby9VekI1MGgxZk1RNFh3QnVybEoyQWthSkUvOXc5dDdjanNv?=
 =?utf-8?B?NFczWVc0b3J6N2pkanhSWGpSa1g2TTI5bGpzckRaK1JNRlZhUkZXYS9Qb3Rl?=
 =?utf-8?B?Y2VKL0NHb1BjdUVwdUovbldwZDYwNUFiWGUxVmpXYmtJbFc4OElKdjBZeWoy?=
 =?utf-8?B?U1BSOTFpM0NIa2ZzakRFdGd0OGJkdkN6MzgyRURyK0pXM2NWdzVxVnZhTEhk?=
 =?utf-8?B?ZGUwdy9MRG1SQ1d2V3llblFUWTlVaGZwVm0xL09IQ2VqQ3U2OXNTOE0ySDI0?=
 =?utf-8?B?MmpBS1l2SkY0bEExU0N2N3RDYmV6UUdlN3FoMDNCWHpvM3hsWnhQQ0x4VVNE?=
 =?utf-8?B?YmQwMTdVRVlVRldzVkVYTnoxUmZGOU9jTE8zaHd1cklVQmxSR1FIQkRua1M2?=
 =?utf-8?B?cTU4UUp3YjFjT1A1U09jMmdWcmh0cGNtNGlTc2tqYjdFZHNyNUdwUi9sV3Vj?=
 =?utf-8?B?aTJGT0p0SEZzVlRNaUtYdmFJNjhETkNiNGY4ZTd5aWltY2hTTUw2YjNLTVpK?=
 =?utf-8?B?MlBPTU9oMnQ1OWw5MjZDOTYrRU0vbUdqM0dzdmFXNG5sMTRoMFRnYlZjNjRo?=
 =?utf-8?B?cUp6aGVNbFlNOGFUaXVPMk1aUlI0NDU1eFQwTkFyVEJkeWkwME0wNGpEcGdI?=
 =?utf-8?B?MVh5V3pKQVFCQ2dpb2d4dXcrNWVldzRoK2kwOStwMis2ekV3NmhBU1NXb3JD?=
 =?utf-8?B?K3o5VjFTK1ZUQ1FuNVlPQkhjVkFuU0UxeDJUejl0UmpyZzdJb29WeTd4U2tj?=
 =?utf-8?B?LzIvdFZCd3lRTnRDOTgzN2hvNEJsZ2tabVFKdU9rLzBkRklCbkpHSUM0RCtU?=
 =?utf-8?B?WjQrZ2dScU1tUFhIY0drc0FSRXFaNXNQdDdYc01ibmZicmxPMVA1U05xVHZa?=
 =?utf-8?B?MmF0eTlsUUZlMkpVdjZwMjhlTjlLQU9yckJPbVdxQndjcmZETDhjbHc1ZGNW?=
 =?utf-8?B?SlRsL1N5V29sNjZ2WGJZanNqVHRoV3B5Q2pPeHo4Zk1aaUFxalBCOVRRZkVU?=
 =?utf-8?B?SVc1RDZpWVMrMGhqZU1BamExNkVUdE5HZnFBRG9KaDB2LzBJZ1I4aXd0VXZD?=
 =?utf-8?B?eFpERldHOSt1YTlFQnRaMDZITFJWNzBBYmJuZkVGOS9iNHNqK1prR25KNVBv?=
 =?utf-8?B?bjd4VG1XZTg2UVNud1UzMmp4bGhrLy9adXpoU3RJUTY5Q2pBNnlLSS9FT3Uz?=
 =?utf-8?B?Z3lXUFdEbUQxK0ptcDdVeWxkeStRMXJpdmVjZjRDMWRPMERuSnNtYmlJK1JC?=
 =?utf-8?B?cGVOMllkRFU4aC9OQlp0OVZaRGlEVU5hb0NkT05LM2pzSFV6YlRQS1NLRE4x?=
 =?utf-8?B?UnBkY1ZSRUVWYVJWYjNXTHFyci9ieUdGaFBGRmdISlYwMFV3VHBHMFB5OHN1?=
 =?utf-8?B?U2RleGJEZlRiOXZJa0xVeWVWdEYyaU5VWktRZi8rZWg2OGhiOXJKdjRKRzdP?=
 =?utf-8?B?dlROandkN0g5MkVlK01KeEY2cDRXUllRMmR1eUsyc2RSMWFSSWh6bVcwOUxB?=
 =?utf-8?B?Q1NwUHhiR3dpNlpMYXdxeWR4aFcveW1GSEUycGtqOUErbGxRMk1rTjd5SW12?=
 =?utf-8?B?QUJkVkdvQXlIcVV2aG5ZM0dpQ2JSM1R4cHNFSlFvL3B2TnI1TlhsL0JNV2xH?=
 =?utf-8?B?VFdrMnJURXovczNqY256cTF2UGw0b1BSNnIybHI1VitSc2g1aUdORUpoU0ty?=
 =?utf-8?B?N05sRVA3YXVaSVo4NlFNbHNBd2NxQU5DZ3NsVmtEKytuNkxsaDlxSFJ3WnNN?=
 =?utf-8?B?QXpHY2t6elRBTWRyMDlEODd4ejErTXpOM2MzQVNkMm1lZ3ZINEJhd0ZLM0Vj?=
 =?utf-8?B?N0doeTE3RndQaWdYOHdBeGRNdzN1VWVRdk5pZVY2bGZCNFNvTGZWRUo0T0hD?=
 =?utf-8?B?ZE9NQjlUN1drZ1J2b05sVkFyaHVPdk9lcVlNY0F4SjJlSW9WRmEzT0xzMUps?=
 =?utf-8?Q?Z/BBAOm9uHysa+oV05I+8fNjI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B9IEg3XgKiok1Beya9Vw2GJucsZVdnXEG3dTcmtVymLghivCsnhgUz8vg8rOQTKMM4PBEo9qkwh4+FvyGcqdRQFDIHrcXO3yQ44aqkPAtj+lrjuYZPEDrfYyxphSUoxIGbaivwABOLp+dsFPunQdSihgiTX7PG9uGN1LCKOLrHv9CzGIdDaPBmf3VcOcaN5FpgpXiqffO8RGg44Vc16fK8YfK0xD0CxISO9y8hMXf2/mNFeGTaKY1uv7D9Z9PV8v8ou4d3kTZvG4lQcQT5D8x59ed0aOx00ydmhxp+B9dJ/hghqi51D/Lq+grgNhyq/7y6AfY0ivoeJ5LtZjEAi3SA/l0AeVmYsyDow1gXJn8tF+kpitTaoVKuKq/9kBvgiFo2rlCEXP/o5aVIkpaWoYaJt+AUP7PmETjNuRZdu8J2DHsa1hFujJ9MJM/DzoejAWZv4yRp42PTJ4dQh5p3d8oRoS74D1NhOm8Fxf24cvqHyboayDMqvvu89EV1wiW9TWPMod/lokFLdUKyv4kqj8B+1CyuYloDtqCwS9dmO8oVpUKXIZb0kEg4BhBtTbjA6aFsVna1It1kqSbNthwxysk5SKrFUpg6doFsegJvVpaTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56799ca-cc7c-4a20-076d-08ddaa9303e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 15:57:36.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8k0PFmnr/cW6Izq7iiJM0ZS3uQPI3+P4No9te7SOGgCK3uwb6wdyk4GQrbi2P4SeWswvFGudtm2Z5MPA8ZWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=901
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130115
X-Proofpoint-GUID: 59izf5uP8KD0PM4EXMRWlyL3wWx2sHn6
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684c4a77 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=lLCtw7i1Pa25jaGNytkA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDExNiBTYWx0ZWRfX8Fkf8XLNjha1 fj2aJUBT4jKtY2EhAattxcKZgqebQ1CHFlyfR9ap3qrQUsYWoqQF0+dlbYJoDI7uPbny9p3Ylhi J9D8+cy57PjW0ouDrRxAAZOHV7RrXGMjqzxgTNbaJdm8Qp280pBLMfsAXxOpNiNsvrmst0V1jpK
 kN6E5aaOizCsDXgoP5n0BzmYLXy60dZNTms6gRtSZ4IqrvZx8ocBGxj1rRw1Sr/+cdZOQ1DdtA/ rfXYRf+jqeiupHn6mECK0sr1y+jOMw+bvvpcF13TFAG1YaNO3iPOr5f8XncTy7WotlEz2B8DLQo Dm+u3FfuXAouvee4DvDNH1RvHeWzx7mHtONnUS6aCIl3UJ1zEO/yK57VIBObgVHDUmu2ldLnZw9
 pkUSWDgOKb5QKzp3qkZVZoUFsZHsvxm3/NmN5Q9SSIJyzwZeuqjxcjumvcYPlWWXmeyrei6r
X-Proofpoint-ORIG-GUID: 59izf5uP8KD0PM4EXMRWlyL3wWx2sHn6

On 6/12/25 9:58 PM, Steven Rostedt wrote:
> I have code that will trigger a warning if a trace event is defined but
> not used[1]. It gives a list of unused events. Here's what I have in nfs
> and nfsd:
> 
> warning: tracepoint 'nfs4_renew' is unused.
> warning: tracepoint 'nfs4_rename' is unused.
> warning: tracepoint 'nfsd_file_unhash_and_queue' is unused.
> warning: tracepoint 'nfsd_file_lru_add_disposed' is unused.
> warning: tracepoint 'nfsd_file_lru_del_disposed' is unused.
> warning: tracepoint 'nfsd_file_gc_recent' is unused.
> warning: tracepoint 'nfsd_ctl_maxconn' is unused.
> 
> nfs4_renew looks to never have been used.
> 
> trace_nfs4_rename() was removed by 33912be816d9 ("nfs: remove
> synchronous rename code") but did not remove the event.
> 
> trace_nfsd_file_unhash_and_queue() was removed by ac3a2585f01 ("nfsd:
> rework refcounting in filecache")
> 
> Events nfsd_file_lru_add_disposed and nfsd_file_lru_del_disposed were
> added by 4a0e73e635e3 ("NFSD: Leave open files out of the filecache
> LRU") but they were never used.
> 
> Event nfsd_file_gc_recent was added by 64912122a4f8 ("nfsd: filecache:
> introduce NFSD_FILE_RECENT") but never used.
> 
> trace_nfsd_ctl_maxconn() was removed by a4b853f183a1 ("sunrpc: remove
> all connection limit configuration") but did not remove the event.
> 
> -- Steve
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250612235827.011358765@goodmis.org/

Thanks for the report. I'll clean up the NFSD-related tracepoints for
the v6.17 merge window.


-- 
Chuck Lever

