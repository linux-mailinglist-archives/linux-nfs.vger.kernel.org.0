Return-Path: <linux-nfs+bounces-14047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C61B44625
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B489716BBFE
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B121FECCD;
	Thu,  4 Sep 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJfiK+sj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CpILiXA6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C281FDE09
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012863; cv=fail; b=j732ue7WwBWZRMHF09nPHm6ICD079Wn2yPRHxX8AoGtWoDvStMZ417aCklPfNoQVbihfHN+IEVy9fVKHq8hSbVXD+d2/8BVz4ZEFbMZTADyd1fsn+iP3aHReCsdLm7BrtBc9X8d+Gs9obBpWeEcPuujJi56STecEsqddpelPUbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012863; c=relaxed/simple;
	bh=6JODw/2U62o8Py3quXl/aEdYMM8jjyF2CetN4ghk+zg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=arys89+vQI4/5ViHcwLrX6ZHSHsb6qEFH4uPapti4Kqh4jRKdDT1liXZot7+RQa4wWQEmJKC3nfM657kH1p+HO3S4MMfjJ9T5A6UqNtdWqaodGuAyt9+tXuyHb0Oe4q62S/TwSzIphpf9vUEfqnM6pc5tEjad0n466isdU6iSEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJfiK+sj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CpILiXA6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IJiVQ004937;
	Thu, 4 Sep 2025 19:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RVyzEQZUQnflrxgvanXgSkVpP9NT9OLPIVdIl/kW8rs=; b=
	EJfiK+sj4zXtOD4RuS5idimtoValHGpvp7serEZmUC9WxED3WfJN+xW9/j6pLTFB
	J4D31PkJ4U7Uy8mzTsmFwPPruzs0BmvUkTcx4uvFxaSFCO09IOW1/CTVVC+AhypP
	6SLMQrvnC1bLG3vNcI8AeQLQQa+ARno1u3p8DMEDlZAdhNtlMCD65rUtFbXwGlQn
	AsGfmY9i4JitqKeySwnV6yOmZ3c0hhGC1gJKW6zjeMfQBYd5/Vc9jtaluNNG5hRg
	tb9FbGKMY8D6WZDXVan6GksxDcGwt67Oum4zBu/1CYCoG1KVas1U3ba37xrlK2RG
	eef+TTPazuGTjNNdiebFBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yfxrr3h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 19:07:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584HPJYj031028;
	Thu, 4 Sep 2025 19:07:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrc1gxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 19:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNu6NdKUdtIXiG0K2Yc1vztOzRciJJUmVLloJT44C7vpk9X0Ym78VNak/KFTa3i0YQKc1dOlNdzraJrxsiX3YrI6N0Gf4J9s3aMeF0V3/nnUS/bBJdhgt2BsvcVsoKhK6A4RdXnw5FmDXY7wNrgPFRhVuQObMDou9SsjBGTei5/BO35ppDzLq5aitg200+nNNfAVxzMpwBHy77zpvxp/plgpXG5O9VnJmZnQX10/tNWVC/qKYWn7pwfyu7gIxyg9ZPm3RggnlSe2bvTxxiFKSj3Ug9/YH+L5zPBP/CagGp/aRYi4D9utMsbvCRSmEUg9WMvnG6RgHFJ3SoiUPO20JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVyzEQZUQnflrxgvanXgSkVpP9NT9OLPIVdIl/kW8rs=;
 b=Uer8gg5UDQuLS4IpKAO+4e4rdKj88TdiirY6K21yeQ3JwPapjbYFgNoypvXWlEl8arYksGNJHHNEN7UawexLQ7MCxb9x4aqQIsvjum1nmPMWqnz3R1vZlIJYrVb1lw1ZbaUNbi+3SDcGy+BocVaXzyspa9MYuSu9m77aBd+V7w+JrkEJaJ7KQI7hHutW/hQx7ysElpfkawEQYbranvQL/r5H+xv9dgLreJHFVGD04UwlqmnMFlUdFwe3HRVhrQr7hLAmDh0y4fv2NbDj+596n+iBuSA9M3VSPH4R+89c/DxRtgyw4AV7ocLnU2gaJRzFg0+WogwKzB0BEyozjWRRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVyzEQZUQnflrxgvanXgSkVpP9NT9OLPIVdIl/kW8rs=;
 b=CpILiXA6evmX4sOp2gCLdmZXUaMtnEdLp1yjQ86Nny8UbMS46c+i1R3UdsL1YOWCeZp5/WnIveYSNN2UjfVfIdtGbSplOSxJrMF7crXeGO8XpPL8/24NBvUWIEIfQ2FlFvseAfMcg+3sGgFQOcAjKCyZMQF/ihppW7jWvnO/7QU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 19:07:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 19:07:31 +0000
Message-ID: <12b7f4cf-5781-4c98-92d0-3fdd03df39da@oracle.com>
Date: Thu, 4 Sep 2025 15:07:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org> <aLdtHaqIw9jaaVM2@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLdtHaqIw9jaaVM2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:610:11b::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a4da55-b450-4afe-b963-08ddebe64c68
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WEhnR3ZGaExnNGFOU3VtYzl3S0wwRW5KcWxIeXY0WE9jWFZJM3BicmJFSUV3?=
 =?utf-8?B?ZEtabUQ3QlN4dU5nczZVNFFPZ3ZvRHFlZHovRkRGcHFKWXJNRXlFdXYrZUhF?=
 =?utf-8?B?b0wwbVg2MGxvTHA4RVU4R3hzNm1xT0VzZDd0ODM0Q3JxZ2tCdVU3dVBMdHh1?=
 =?utf-8?B?OElidTUwREllRUc4b2t5bTFHRkI1OTJBMyt2M2h5TzhSNzRFNHpWMURSd2p0?=
 =?utf-8?B?WkJyYWxJWEh2c1NCZHArQVdkeXc5WGNYR1Q0WGZZb2R1VXZBSEpETEJiWlZZ?=
 =?utf-8?B?Z21DSjlZOWhTOHgwaXJlbm5uaXZGRjJUcmdWRUFPbjJhd1FzQ2UrQkFmbmVS?=
 =?utf-8?B?WHEramhBTjc2ZVZhMDF0aGk4OExuT3ovMFJEMnhTRkUxclVmRzI2ZkxacDB1?=
 =?utf-8?B?cXFhS2V0SHZrd2huVnpkS1dFclNhNS9qWE1PM2VRSm4xMVozR1JORm1vdUpq?=
 =?utf-8?B?RzNuUVhIdG1DR3R3d0NKZDN2blh6bWlHWndxV0JwY09RMmV0NWplczJuVzVR?=
 =?utf-8?B?UTBjQm9nd1JBWjU5MTNYelkrUndUOHA1d1M5OVUyak9UUXM1dVlzNUNaMVRC?=
 =?utf-8?B?d1VRb05pUi85RGRpL3ZGN0FRbERVcTlZd1RSamM3VU8reFZsQjEyT1NVM0ov?=
 =?utf-8?B?bjV0OTF4V2dobDBLMVd2ZStxWGZ0WlcxYmJEczZVTWoyTGhNM1pxRElhS1lj?=
 =?utf-8?B?cHFaSlIxbWd3S3Q4SGRkNDlPTjdkZURaa2tGOHh6aHdQSXl2Vi9GZnAzWllk?=
 =?utf-8?B?R2JGb1ptQnlXdTNBZ0MxOWRVL2VoSXQyUTFMMWQrRlBNeURjVVlwZ2wxdUd4?=
 =?utf-8?B?aktrVWJYTjhvOHZpMDZWY1NMenlGcGd0ejVNbFAycXpUWEkzbXIzT2hvN0p0?=
 =?utf-8?B?cmdVMFRLc1d6RThSbkdITnFaK2RUY0p2MnFLVnZ0NHdCOHJsZDZqdC8xU2lS?=
 =?utf-8?B?alJ0N2toNUhhSUpVbTlsT2xWRzdoZDZvdURKQ2NGMkQ1dy9ZM1hia2JRaEZo?=
 =?utf-8?B?Z0J5VWtHZDBsczAxVCthM0JKeUVGSm5XbVp4MU0wdGh1M3d4Y25MUC9oRFpo?=
 =?utf-8?B?MkcwWXd4OWc1eUpwQ0g4eld0MzNndjVJRURRTlp6UGpxaFZFNkZjZGVLVFda?=
 =?utf-8?B?dC9VTmc3UkZKL0pnMTZ2N00rUThhdlBiNGl4S3VpSU8xZGdEYkhOQ2FDeFJG?=
 =?utf-8?B?OXo2bmxhQUlwZ1h6ajlTWWZTZjdNZW50UWNDcVljYTkxNms5bytnYUc2MlU0?=
 =?utf-8?B?RUZYd0Y4WmF3aE9uc1p6WjY3QVdxZmh3U0xLUzhLU1crYTNuWU91c0ZOVEdj?=
 =?utf-8?B?Rlpsd1o2MFhmNDArMUhSeUNJZ041bEdYM0RVREgzSC93RGpaaFcrZ1FwY1J2?=
 =?utf-8?B?dEZGakdiby81c216MmpxdHpyU0JKemV4dDlQVDJ4N0l0RmllMjR6MjJlN0Zl?=
 =?utf-8?B?RUlpeVZsUkVFSVlJYThzY1BNZWZZWHJrZ1B2SmZ0YXlMY0hsMTBZemNZWXR5?=
 =?utf-8?B?QmRMck10ekJ5R0NwSUtzby9sUVdDbkhORG5rdXBXU2lsU1dOM0JYbzFyQUFw?=
 =?utf-8?B?NnVadS9hbURDRFp4ZHBKOFVOeUNPU3FHZExHRTNLQ1l1Y1FQY0k5WXdqaHhC?=
 =?utf-8?B?bXdETy9RS0VqUGx3WExoU2QwWFBGbVJJY1lLNUw5bGEzNXlNVUFsc1lha2VY?=
 =?utf-8?B?b1N0bG4zbmtJTG9ONWlRbEFRWXFuUVNtTFpOR1YvRWNmOUNOUkpPaVdtNVRJ?=
 =?utf-8?B?ZHRObkxzVzM2Ykt3Z0Fud011NGI5cXhBTlpJZGtndGlWejA5LzNyeE9SNW8v?=
 =?utf-8?B?Q1JrVFFFclNGdmRFaks0RUFtMy9BWmJ5TCtROStKejBKbUQvWnJGblVvaXhJ?=
 =?utf-8?B?S1M2ODB6bWlWU1ozNmQzb0h4TnJIdUREV2lvVzJocXhNbUFxMUFtdnZ1dG9l?=
 =?utf-8?Q?PlB+ZIUhQSs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emRvcndjUUs2Nkhpa1l1MlY2NGUxR1dPMWtLUlk1RGY0Q2w4aXJNN3RpVTBS?=
 =?utf-8?B?M2hCUHVsY3krd1JBZm4wQUwzQllncnNwRkRWU3ZaRUNUckFHOGNVeTRNdUFz?=
 =?utf-8?B?Y1hnazB5VENpbXlqY043NG5EWVE2dm43bVN0ei9YQVdmQ1JaSGNJOXdvWE9B?=
 =?utf-8?B?bzFPdmJvYkNXMnlCUkxJd25TMlhpSW1wcWtsMHlJSmpRZlhWOWRKSU1wMFZ1?=
 =?utf-8?B?czFqeXF0U2IvQi9nZUF1RS9QdkJqS0hFV1JsZ0l3Yml4OVJ6VnV0K282aGMx?=
 =?utf-8?B?MVUybTgwVHlFREsybU5CZHE5Wng2aUZkajVpaUVrSlVtaUlOaGVBN2ZOTjVX?=
 =?utf-8?B?YWJ2bXZKZ2QzLzRQTUo2bTdoTzRqN09Zc25DZmFRcjBTb2tiNFU0eTE5MnFL?=
 =?utf-8?B?cXVtb3hjSTBCcnNsR05KT0p3NFhRd29PODAyZklEV1M5K0d1d1lVNjZvN0tI?=
 =?utf-8?B?Q2RVU2kwN0Z5WnJHbCtTcHFjaDRpRDZmYkNZNUhRU0F0QXJzNzNXNFFLYWUz?=
 =?utf-8?B?VVJNR2tRTy9WSi9Ub3EwSDJxdVhpQkJLSWdNRk5uUUUrZCtyMnpiQ1JxYUp5?=
 =?utf-8?B?aFlwWkpiQVFVWjRlcm55YitvTXZ0Wm5RZm5SR2o4d2t1Z2NKSlZ1dENNcGZ0?=
 =?utf-8?B?ZDVOdmhFd1JudHZjZXJnMVFKM1NOVlR4dmg1UkdwSDdPNFhQS2lXK1FZV2hN?=
 =?utf-8?B?aWEvQko5djFjNVN6ZVpreTJBVHkrd3Jac29oOEl2NlNzdU5KbGFkWmtCeEZK?=
 =?utf-8?B?K2tHOXBhKzhacmtiMEQ2WHpaMSs2S3VzMHp1NDkreDJkbkFKZURJWjE5bWE5?=
 =?utf-8?B?Yk5nNVVRbitYSUR5TTlDeExMYVd5MFByT1MrdzRqUXZxQ2lSN21zRjBid3dr?=
 =?utf-8?B?aWxxVGg3amIrcGQrRXlKY20rUTZFYWNQQldWNzRiczVYOFh1NHdDYlZ5Ukxa?=
 =?utf-8?B?Yis3dk1uTERPbGdFYmpkY3dVWmhyc3FXZ1dpTDhGemR1SE9nNXlIRElnYTRR?=
 =?utf-8?B?WGViM3dXUE9FdlJyS1ZhY0cyQWlpQXZUckxBQmRTU0o0ZWY5ZVVrSlNIaUcx?=
 =?utf-8?B?WEVsZXBwdnl5Q3lFeURzNzVrdCtPVVh6REdvc05pNnVTNUk3YVd6SkMrN2JP?=
 =?utf-8?B?Rkh0cTFSY3I1UlBnS3k5cTF4dktzZy9CNVhXZWxKUjlnWlRER1QzVVVodUpa?=
 =?utf-8?B?NklDc2hUSGZXb0RWUFlrbFRyTWR0ZzNqdDZ3Z2wwRmRXSDcySGN2akRzQUJx?=
 =?utf-8?B?emJGelZmVm9pbHBpVnFwYmhKRHVzQ2VtV2JjcysybDRQcm5odTNtb0RNbG9G?=
 =?utf-8?B?SUlNMWZpRzRaYU4vbm1qdi8yZ1cyM0FvOVlpRnZRb09MWlN6VHQwcWRnN05D?=
 =?utf-8?B?amJUUWNTM1lkOGpydk54bDFnckRabnBHQWVPUXNoY3hFQ1pvTHJ2cHBPVC80?=
 =?utf-8?B?QkVydm9seXFIZm9Hb3d4SXlQSVJQem05bHluN1ZINVR1REdDZnd0UjRFR25r?=
 =?utf-8?B?Y0VSS29hWVpBMi9INS8zd1N3VUw0OS9RQVNaallicnBnWlRGTER4YU9LOXk2?=
 =?utf-8?B?em5TRElxSVZDb2FEQldKbEVjbmNyQkhWbEl5RXZocFVMZ2RNdHNTV2NJbVFi?=
 =?utf-8?B?TDVDZi8zY1NDUXEvMURhbTg4L1lSdlJkcmRVZlBjUjMrcU1vSzM2aFZsTFhs?=
 =?utf-8?B?aWxkOFpKMnFxaERhU09UOFJkMWwwN0sydUVwcXhjb09sMjlqL3BRWXpzVHdu?=
 =?utf-8?B?U1RFTjhFcWFOT3Y4dFhoeENpc0diRDhabEFIM2ZBeEJvWTQraXlFbWd6WFRS?=
 =?utf-8?B?N3kxb0NQbU5rQzZOc0dKVVdNNjRnQlkxZHV6QmVYcEt2Skp3dEVoNWVRMTNY?=
 =?utf-8?B?NUk0aXQ1OXQ1dVZGYUlLSTE4THRnYWRGYUdZb1h0VU53QkQxVXpudUFNREtL?=
 =?utf-8?B?RUFDckFEVGpnMGZYMnlaWDA2elJJRFl1QjNDNmxIYVFISG5xREVXSUNwbDll?=
 =?utf-8?B?TnJVdmxuU3U1ZGtjOTV0YTZvc1l2c3VwZXdMVXJLQlpqeFhNbzNYcHNiUDRI?=
 =?utf-8?B?RmJRL1NsMW9IUnFWdDF2aGUvMEdMNzVHUlpsbGhHQU5Selk5SFZwc2h0bjI4?=
 =?utf-8?B?VXJETlZldlBJV1dYcytPaFRrQUFUeVZPVVVaNHZobFI5aW4wL3VlQVNCY3Ra?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dFxji2WawLv2SIcgL/WXnA/L0CSh5gAcsusIex4eEh7YsEA9PR29NvpZZvXKnNCac51780FDRQn/ivrCpUBWJWAxVBUFQGPQ/cOvofSumikYp7+S3EuKOj40voyC36Tc4I85VPUbkRGRXwdIqBk83uT6stimaExDPeuBVHJOwuJLnGhQLD6d5JvDCdCg3ote3/loqsNCiDrg/NQOP2RhpukqArbOzUAskz5x5xkGiflNQ9B5+imDe0EMsEUHi/2RurnM3n7VgJO4yFeIaOL/M814aTDjhzUh4C+YK60Eroorkzk6L+obYHKL41DWpFV2D34wb4mAraGjDVPdERbPEN6ua8R3b73w7MH+GvdDqunkAtg7/1mSGf9B4zdf2ij3gGuum2d44m4EtnMqDxoxO7MQXBnYSVagN5ngvOZUZWo9pgzLL0EWb8/T7xM9ykpRN7wK2JPjMgpwGRQDJn/ZhfxH0nZPOVnLgWV4S32fAHsb0OqH/BD7khY4rv7kHyd7w7CfFWQWJzgl73QCTwfOxulmaXmeK9X9VyZZGflIbEQh6/e3e8MZd0K686Kq9GyBFH1Qr8RPTqM+61jiAtHM0Q6jfbuFNhf8HQhm9imtn18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a4da55-b450-4afe-b963-08ddebe64c68
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:07:31.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LQJpi5WDF7OeZ3VqjjGcL6oLrciB5tWKW47PkGYumAfLjPmeMtV8hUwDYUGweVGFUUjqT4k6bFAwOvIW5G7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040188
X-Proofpoint-GUID: wFvAbSywOMR2swV6lDoqX2LwVIshsjTZ
X-Authority-Analysis: v=2.4 cv=OO8n3TaB c=1 sm=1 tr=0 ts=68b9e377 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Lb1rMZzfAAAA:8 a=acePEMbFu9C2sLuE82EA:9
 a=QEXdDO2ut3YA:10 a=8TJlWAxZIw_9ZYUv8NPp:22 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: wFvAbSywOMR2swV6lDoqX2LwVIshsjTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE4MSBTYWx0ZWRfX/W3qyoaKENec
 yh6eyqGLXgO+5S+d9k3FHBhfjbYsgElCDWMPwt+/Mn1dlbUIFVPHS3TWKry/4FLUxeHozPw/doA
 6IFEEprFrBJNS74sJwkGgA250Dz+RqvkbIegE9MC8iXKirsfrXwL2PJSJeIMsb0+seZ7MY1Ki03
 3Yp+UV/DrtyCgrdxW8qjp5YhxQaJB+kkZ4VpFBIYM+OOs7j6M3sGo9DWDQ0VXJgtoAXknIj0DPW
 aPnHMe/owCoEeISSQfJYztybUBAdoiSpehfTnGeo5P1HPPwUtbRu2HuSV76x1V2bHC46gq1PD9P
 kLY8VjQBtFsi+77gBjwoo1wZClUm9Rv13DosAI1GkN/ClVc0aG7n0YT1D95wGR/GsJ0oXYpBznW
 wlM3eUCt05Uc4VOJTTwyuTE+rAbDPA==

On 9/2/25 6:18 PM, Mike Snitzer wrote:
> On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
>> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
>>> On 9/2/25 5:06 PM, Mike Snitzer wrote:
>>>> On Tue, Sep 02, 2025 at 01:59:12PM -0400, Chuck Lever wrote:
>>>>> On 9/2/25 11:56 AM, Chuck Lever wrote:
>>>>>> On 8/30/25 1:38 PM, Mike Snitzer wrote:
>>>>>
>>>>>>> dt (j:1 t:1): File System Information:
>>>>>>> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
>>>>>>> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
>>>>>>> dt (j:1 t:1):                Filesystem type: nfs4
>>>>>>> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
>>>>>>
>>>>>> I haven't been able to reproduce a similar failure in my lab with
>>>>>> NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
>>>>>> successful. Also, for shit giggles, I tried the fsx-based subtests in
>>>>>> fstests, no new failures there either. The export is xfs on an NVMe
>>>>>> add-on card; server uses direct I/O for READ and page cache for WRITE.
>>>>>>
>>>>>> Notice the mount options for your test run: "proto=tcp" and
>>>>>> "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
>>>>>> not use RDMA at all; it will use bog standard TCP/IP on your ultra
>>>>>> fast Ethernet network.
>>>>>>
>>>>>> What should I try next? I can apply 2/2 or add "nconnect" or move the
>>>>>> testing to my RoCE fabric after lunch and keep poking at it.
>>>>
>>>> Hmm, I'll have to check with the Hammerspace performance team to
>>>> understand how RDMA used if the client mount has proto=tcp.
>>>>
>>>> Certainly surprising, thanks for noticing/reporting this aspect.
>>>>
>>>> I also cannot reproduce on a normal tcp mount and testbed.  This
>>>> frankenbeast of a fast "RDMA" network that is misconfigured to use
>>>> proto=tcp is the only testbed where I've seen this dt data mismatch.
>>>>
>>>>>> Or, I could switch to TCP. Suggestions welcome.
>>>>>
>>>>> The client is not sending any READ procedures/operations to the server.
>>>>> The following is NFSv3 for clarity, but NFSv4.x results are similar:
>>>>>
>>>>>             nfsd-1669  [003]  1466.634816: svc_process:
>>>>> addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
>>>>>             nfsd-1669  [003]  1466.635389: svc_process:
>>>>> addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
>>>>>             nfsd-1669  [003]  1466.635420: svc_process:
>>>>> addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
>>>>>             nfsd-1669  [003]  1466.635451: svc_process:
>>>>> addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
>>>>>             nfsd-1669  [003]  1466.635486: svc_process:
>>>>> addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
>>>>>             nfsd-1669  [003]  1466.635558: svc_process:
>>>>> addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
>>>>>             nfsd-1669  [003]  1466.635585: svc_process:
>>>>> addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
>>>>>             nfsd-1669  [003]  1470.029208: svc_process:
>>>>> addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
>>>>>             nfsd-1669  [003]  1470.029255: svc_process:
>>>>> addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
>>>>>             nfsd-1669  [003]  1470.029296: svc_process:
>>>>> addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
>>>>>             nfsd-1669  [003]  1470.039715: svc_process:
>>>>> addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
>>>>>             nfsd-1669  [003]  1470.039758: svc_process:
>>>>> addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
>>>>>             nfsd-1669  [003]  1470.040091: svc_process:
>>>>> addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
>>>>>             nfsd-1669  [003]  1470.040469: svc_process:
>>>>> addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
>>>>>             nfsd-1669  [003]  1470.040503: svc_process:
>>>>> addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
>>>>>             nfsd-1669  [003]  1470.041867: svc_process:
>>>>> addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
>>>>>             nfsd-1669  [003]  1470.042109: svc_process:
>>>>> addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE
>>>>>
>>>>> So I'm probably missing some setting on the reproducer/client.
>>>>>
>>>>> /mnt from klimt.ib.1015granger.net:/export/fast
>>>>>  Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
>>>>>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
>>>>>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
>>>>>   local_lock=none,addr=192.168.2.55
>>>>>
>>>>> Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
>>>>>  PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux
>>>>
>>>> If you're using LOCALIO (client on server) that'd explain your not
>>>> seeing any READs coming over the wire to NFSD.
>>>>
>>>> I've made sure to disable LOCALIO on my client, with:
>>>> echo N > /sys/module/nfs/parameters/localio_enabled
>>>
>>> I am testing with a physically separate client and server, so I believe
>>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
>>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
>>> new trace point to fire quite a bit, and it is showing misaligned
>>> READ requests. So it has something to do with dt.
>>
>> OK, yeah I figured you weren't doing loopback mount, only thing that
>> came to mind for you not seeing READ like expected.  I haven't had any
>> problems with dt not driving READs to NFSD...
>>
>> You'll certainly need to see READs in order for NFSD's new misaligned
>> DIO READ handling to get tested.
>>
>>> If I understand your two patches correctly, they are still pulling a
>>> page from the end of rq_pages to do the initial pad page. That, I
>>> think, is a working implementation, not the failing one.
>>
>> Patch 1 removes the use of a separate page, instead using the very
>> first page of rq_pages for the "start_extra" (or "front_pad) page for
>> the misaligned DIO READ.  And with that my dt testing fails with data
>> mismatch like I shared. So patch 1 is failing implementation (for me
>> on the "RDMA" system I'm testing on).
>>
>> Patch 2 then switches to using a rq_pages page _after_ the memory that
>> would normally get used as the READ payload memory to service the
>> READ. So patch 2 is a working implementation.
>>
>>> EOD -- will continue tomorrow.
>>
>> Ack.
>>
> 
> The reason for proto=tcp is that I was mounting the Hammerspace
> Anvil (metadata server) via 4.2 using tcp. And it is the layout that
> the metadata server hands out that directs my 4.2 flexfiles client to
> then access the DS over v3 using RDMA. My particular DS server in the
> broader testbed has the following in /etc/nfs.conf:
> 
> [general]
> 
> [nfsrahead]
> 
> [exports]
> 
> [exportfs]
> 
> [gssd]
> use-gss-proxy = 1
> 
> [lockd]
> 
> [exportd]
> 
> [mountd]
> 
> [nfsdcld]
> 
> [nfsdcltrack]
> 
> [nfsd]
> rdma = y
> rdma-port = 20049
> threads = 576
> vers4.0 = n
> vers4.1 = n
> 
> [statd]
> 
> [sm-notify]
> 
> And if I instead mount with:
> 
>   mount -o vers=3,proto=rdma,port=20049 192.168.0.106:/mnt/hs_nvme13 /test
> 
> And then re-run dt, I don't see any data mismatch:

I'm beginning to suspect that NFSv3 isn't the interesting case. For
NFSv3 READs, nfsd_iter_read() is always called with @base == 0.

NFSv4 READs, on the other hand, set @base to whatever is the current
end of the send buffer's .pages array. The checks in
nfsd_analyze_read_dio() might reject the use of direct I/O, or it
might be that the code is setting up the alignment of the read buffer
incorrectly.


> dt (j:1 t:1): File System Information:
> dt (j:1 t:1):            Mounted from device: 192.168.0.106:/mnt/hs_nvme13
> dt (j:1 t:1):           Mounted on directory: /test
> dt (j:1 t:1):                Filesystem type: nfs
> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,sec=sys,mountaddr=192.168.0.106,mountvers=3,mountproto=tcp,local_lock=none,addr=192.168.0.106
> dt (j:1 t:1):          Filesystem block size: 1048576
> dt (j:1 t:1):          Filesystem free space: 3812019404800 (3635425.000 Mbytes, 3550.220 Gbytes, 3.467 Tbytes)
> dt (j:1 t:1):         Filesystem total space: 3838875533312 (3661037.000 Mbytes, 3575.231 Gbytes, 3.491 Tbytes)
> 
> So... I think what this means is my "patch 1" _is_ a working
> implementation.  BUT, for some reason RDMA with pnfs flexfiles is
> "unhappy".
> 
> Would seem I get to keep both pieces and need to sort out what's up
> with pNFS flexfiles on this particular RDMA testbed.
> 
> I will post v9 of the NFSD DIRECT patchset with "patch 1" folded in to
> the misaligned READ patch (5) and some other small fixes/improvements
> to the series, probably tomorrow morning.
> 
> Thanks,
> Mike


-- 
Chuck Lever

