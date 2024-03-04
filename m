Return-Path: <linux-nfs+bounces-2169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9118703BD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3681F2336E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142E3F9FD;
	Mon,  4 Mar 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JNDtJr3H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O/KMxWws"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6853D9E
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561484; cv=fail; b=bO+L6y4XytucB/a7z45s8ziw/P+moTdQLrdFd9eBqgD3nz+povoNXmcMov4OseYzHsgYXpPxRn2xHqWCmQWVLURsGKcMNJvI62D5buTtbtMI6pbOHSEQIeX+aHVn07tuNER77e6C57itS0FXJLHFttwt0xdiUyF7sHrOrx+nr1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561484; c=relaxed/simple;
	bh=IY0d89vUZmHDWXC9Q9vmYq4Shey1k5reYGjHgYbGKXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ju8y25bCW5UPWa/daFPeFjqCEPLWjJ1H3h94Ygay6wxquskdQbM6mM3MPt86Gj1J2BHl5BPgr9Bd1cT5Mk8jk/eBZNGU2+6T6UbgEwR7YrvzqDBnT9/ndvjj8LipvPpGvpVjJx5wm6bfe3/a8584T3/ePoDDzR0enAdq+Z96S04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JNDtJr3H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O/KMxWws; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BT7nd030296;
	Mon, 4 Mar 2024 14:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=iSmIrDbsCeGme9Z7pIkVuitlk5L/VARAZHq/aTnIScQ=;
 b=JNDtJr3Hei0W8FGVA/xZJlACSosfoIaeVDX5n3DL0T4jcGJdFEok60x92F4YHIgUqq3d
 WhjzcFjd2UPN+7ORyuWfJJuY/ttk/F8nAuzjl63ueEtyOGht48/L4NKU0KpusI8Ft3T3
 QWyKTHQqkFcrgg9JfJ/ypXI2iahlgOCP0ACQ2xI1FmbS7W52XLOmwQ5BNoxMqBvvDfn8
 jkKrsLr05MnrvgeAwKzZ3o3/8P0Ae4w97uhF6h7QoTA+vr1os0W68dP8qo7BR06BoVYu
 IK9SaMLop4MFFuutrMU9/SvWC7Woh1I9ClL7+3yE/uIuM+MQii9D1dMh+l6/+8AnaGSJ qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvbgda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 14:11:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424DctV0033198;
	Mon, 4 Mar 2024 14:11:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj66gf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 14:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfa/N4mzUGc1zk9J3ZDgQTSb9K0zQgrA0N384hCd18KHSE3usAocTswapMPKOxhGuJlrz1KeOyNC/5HgK4ErKfyVSaFgKJB8rzmhqbH2791pCIdZprESsZHOyG3OPU9mg+bHSICftRvdyMm058V3szbEC3srPEWwF+8bXjr1UemHRpUbB53lnThjFf91h/UHxoSkDo8HsufvWvAaQwCHas7uQbjLyP8BQrupG6B1yVxc7w9bT2zMmtietBv7rDfUZod9t7bUWacDgHzRnCY2nv0cVndQP7tEmnh6lvST6W4aiL+q2YiGAUCYZgDPcUYX+UucOgyFHHdBeTH9uHjNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSmIrDbsCeGme9Z7pIkVuitlk5L/VARAZHq/aTnIScQ=;
 b=JIcT1qlWN+cc5TOtROVyrMu6WYvxUQ4kpWPQR+FW4Qs/ZT/oiCCZLZNCgMx3s989EcpamZDe/vzS+kdWvy3a6tTr/oTUwak02uolKP8HI/jFgKI4PSh0c/j7iGNgquVUo+xl6zJC2tg/8m9TUwYMwPwEgvR9QX4FLmcNC4NpyjUNeos+eTIleiORo6x/aowFth6dVmIDz7VGgP2Pp//ADOHj7z4zuCKFl6wSJb0uKp3AZH4A/HyRaRgI4+/g2PXHmtuacba3sSp1/KTmDC0nldPMwFzLSyubgUXRbl1/gfyW693q1AXgKKXH5PdByDNS3WmlNacSsr9QHsdfPBrDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSmIrDbsCeGme9Z7pIkVuitlk5L/VARAZHq/aTnIScQ=;
 b=O/KMxWwsBl9sR0SMXNVimTaxhQiWLCv+0btTQVPwsPy1TWkrUL3vJ5bYCDcBSD24HltiWNIuyOLzN8vCJuJOKoGv6eJ/fgVbTI+sVlSHY8NZfLOCdrd6dsbdJDPMWZc4cclucbNJwZTtj2RQhW07FKkWhaMX82QfNHtOY6YVKJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 14:11:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 14:11:15 +0000
Date: Mon, 4 Mar 2024 09:11:13 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: send OP_CB_RECALL_ANY to clients when
 number of delegations reaches its limit
Message-ID: <ZeXWgYJUXeUU9lrL@klimt.1015granger.net>
References: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: b23c3257-7e16-4ce1-6394-08dc3c54f42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eh/1/0vufD0f5Ud/X3UsgSzy01jZhCGafuSPm3feVS7fqA2ukW8c59ij/iPcKD2d4YyUBchZDrPNVvG4Z8+gKGDBX38jfVpYRadrdcvUzKUrBOhNxVMuXavTr+Nb2wCTv2Rb5YIGyX0LpQ5X2UN2ciY4SRbVZnFqT4pb9dqb2IcKuNXj4kwYf3tShuMRt+UtR79bOW7DqsJ1dz3yIZCXKx02MaRr7tjYZ3tFlmtZtglk7+g7fY7R4VUOo5gJeiwt9ys1/ugIygq2f5Cdg4eYsm1YEw6gmnhloYWoXFBiitkpbWAbNtg6garzuEMjPPt2GTEoHSEoRJDMeRm32FYpRAWrkIqvX2JO160KuwY1aYqlH3wKezvofXn+Ov2glOXicdBFPrLxSGon924BvH0HUb3B125LnAY9QmbzjJFmW9W0tPmSZKIfAvzqv53jRIcKg7kkyyMGO5cWBWMXjJDI/Fo6kEBUN9taxSn5NUGy1pmJmHaGukvQCrvPB9zpoU4ZuNm1p8/Oq7IlbhoV9fwLnoO5aSmWS1JjyvHbMivZwbm3foiezU8u7D5Ne/Z7Zj822+aVrF3W3K2/CQa/DHiTVrXlHvObQK8dyfpRLicgT4QCMs9zBtlCvDtegvj4DoDyThGR8V4yJs9Liue1JSCAUELaJ/zLOqVKDn911asYwQw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sDJMhV2IMAquuaUY86lKzuqfifJu+IM7xlLEJXNz7nXsIrOoPrUhGBiV4jVC?=
 =?us-ascii?Q?IJU2iinckEcaT7SLzNlmvEEkuWXtkROad5drfxnja697EdriqB9yV9ZY52M8?=
 =?us-ascii?Q?3QZw2RMTdfY8HXsfLKPynp2AkAkgwx38S7/nqBd4YoxkGD4vfi6xlh7afUeR?=
 =?us-ascii?Q?6P8PeiL2MzM4bvh71GGtKuobrd1E6x02NyUeHysI/HZ4ovXvQSPVwRWNR1s7?=
 =?us-ascii?Q?/ZSt/m7RnUysEv4HS6WtBGNEW7arQ9lhcuKowUftj6mAAHxXHb+7QD91YUgv?=
 =?us-ascii?Q?Ps+6A4ei0vks9euyEgdmpNSB2soq6zLYxHopLFTHGFTwmfIGqExo2sguX5fO?=
 =?us-ascii?Q?/fIAdT80P/s0QYLYqxFu38DTa0SFAUAUWXJbW8X6LltNk5eDEz9ruf8RvOAI?=
 =?us-ascii?Q?m5ueIHCpwSN3emEzlmX4jXWUR+jRpLMhJ7aitDj01kBmivEEgZCQ3jzsYEmM?=
 =?us-ascii?Q?/CApQysFl2RkdiapAvi/jkQH9nx1rG8JrTNSdKVvWgmP/H8ZIQCNewb7ZSCN?=
 =?us-ascii?Q?6347TYPzPfaP61CQ0LU6eK9WgvL0Y+/HCMHeAI6lp9gfAbg4qBjO73p9/Kg3?=
 =?us-ascii?Q?Ps0bBVbsERZrFhiwMp2/uPX6kSff4CbtQM7CxwQmlY3oExFl9NEjzeOFhmYt?=
 =?us-ascii?Q?rOUO0Nwdh4wmQ7dAz+F76rGolohvQHIcdQjN6EPTnFb+Y0+wXo/A8TbLs1gm?=
 =?us-ascii?Q?LKWIH7dmAggLUNS/qVG5LUB5ZO+rHeVWKGFGLOr7bCQH/CankjCQMDDKRW83?=
 =?us-ascii?Q?jV8A87bdGVQw9zvZ/Gl6yi1Mq6XlWQTSBzYlJU6fkLPqSnjF0V9xigSDsBNo?=
 =?us-ascii?Q?gqpMf0ZlLJcmcvx0j2Yl6xaG8gqGdAtY1LiXhoaej00guIGov9XaLNLVpOVI?=
 =?us-ascii?Q?/JNg3rrrYaWY3evrgZ/KgyERjXq0KRJYV184qt+ZhhGndWQuytfbTbcYQWC2?=
 =?us-ascii?Q?InYHqX68I/jCNc+xfQje2hQXoLvmpiRG1f+aO/f8Y+lonarsnUB+u7N+l3dv?=
 =?us-ascii?Q?vlnPxVdZesXhc7JyNHkks1gcWxwSqK0Ba9JXdB2QuDRgzFaTPFq1z4URzjqY?=
 =?us-ascii?Q?D+vh1p2s9O26SwuXW0wjb0PoojNXn7u0RPVknR/+q1XMSfCmQT6PZoQzjGqD?=
 =?us-ascii?Q?Y15Ia1KX2Sj3iSGfygviYIdFhwS0pUdDyAPj47vs7HSlgeMSPrgwCSEhQzrI?=
 =?us-ascii?Q?0pJ12Jq8LcgbHsN0BWqYLnmBqk92tGUwP3S6rB1Y5S8N+u0RaMjGygT2+hWU?=
 =?us-ascii?Q?A4206voVGS/DmaEcOxLrpNwPgiyv1gSSLCd9dPJDFThDvZ8MWbOrVqns1E+4?=
 =?us-ascii?Q?ZfD/4ozomxpUwyOgEmbAkObXVNzFrNEpIbGc5fWF00M+H8PiDtQRlwUzUSUP?=
 =?us-ascii?Q?4lUI0mJj59bTd5HF0OqEKFe/2TjAOGMoVT1yXLfqQBdelYvdDbPVkTrFgVSM?=
 =?us-ascii?Q?CeZKRxwbLe1j5R6sXAows5UhzGOaIenCwZOz9JCl7i1FM7SHZgwiKLM+EAdW?=
 =?us-ascii?Q?dbElwTizk+I3XS3TbGw1wrndbM+14uWmjwOaxE/1UWHYk+x0C0/nv/yNJ6ve?=
 =?us-ascii?Q?0GIic1IPc0bU/9ymqah2Wf1pPn8RabJdj627frZ6TadaJTWeEKoUp9v2ABi2?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j5kNZ3Av6x1acmBgXEIjGqf8zH98vP1HTG0c3CSLJ3VVINnv+J8rCB8bKHQpsP3PHFXmnUugQ/ofo5SKTkYfThQ+RtSegyCfg9hYGdlSQaCO+51i5c6vSv2HXoNNHpWRDdesqOF9+iQ5J2jbG6pxoVixxSxL1/isRrqk7HUhqlioIR2E2j9Z6M8T4RnUfatoso61j5jWXpgq+KZRs9j9CU0fr6GU8eaIot4HO1eTWrV+SI4n/EhACZsgHMTvG+nYocVpB7wl0JOfjBh7SiizzqojaSkCzZCVPhlD234ROAWFz99rRHUeb8h6DAqou5zzFY0UWOeqNQJwD7GP9DOvgv8lswwKhxvW/vBbbgkrUhW3mAuV7Yqef9P5d52vJWrEdwJh0IrTYYsR1nYB5/oAJirkAK25KApVnyF3AWS3tk+JBUGd2c0EBRH3f6fEKzDt6br5ZA8KqkRra3qXXzGYSmlBgOMzFDWflQjtdInFrp/OJqiA4SAgnzEuJvp4krurUxREzmszdTQ6Smf6mhfP66lh1w6JAPSr6sYXrJi1ogbVE9BtbkNBPZ/wntQIoEzqPIlRX7FgdSY9RLnY3c4iBjWiW7kwADdiWAwA9olnMZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c3257-7e16-4ce1-6394-08dc3c54f42a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 14:11:15.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQM5oxNXk95Q9ztrRMQSbTpj1bCTe78XFCfPs7YtbldrBvHRbhX+KByvLPLho2qP20m43EeCKDHEc1P465LuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040107
X-Proofpoint-GUID: UB2cGCZ6uXEdWIR_48t8qXxtJ3MbJ45E
X-Proofpoint-ORIG-GUID: UB2cGCZ6uXEdWIR_48t8qXxtJ3MbJ45E

On Sun, Mar 03, 2024 at 05:23:02PM -0500, Dai Ngo wrote:
> The NFS server should ask clients to voluntarily return unused
> delegations when the number of granted delegations reaches the
> max_delegations. This is so that the server can continue to
> grant delegations for new requests.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v2: move declaration of deleg_reaper() up to other forward
>     declarations in the file.
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fdc95bfbfbb6..961000261b3e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -87,6 +87,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>  void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
>  static void nfsd4_file_hash_remove(struct nfs4_file *fi);
> +static void deleg_reaper(struct nfsd_net *nn);
>  
>  /* Locking: */
>  
> @@ -6550,6 +6551,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	/* service the server-to-server copy delayed unmount list */
>  	nfsd4_ssc_expire_umount(nn);
>  #endif
> +	if (atomic_long_read(&num_delegations) >= max_delegations)
> +		deleg_reaper(nn);
>  out:
>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  }
> -- 
> 2.39.3
> 

Applied to nfsd-next. Thanks, Dai!

-- 
Chuck Lever

