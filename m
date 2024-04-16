Return-Path: <linux-nfs+bounces-2848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF778A7451
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17391C215B0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D241137C4D;
	Tue, 16 Apr 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aimSYcmF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RL5/yYuf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790D137C39;
	Tue, 16 Apr 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294358; cv=fail; b=jcMjBalHNcbA9CoVjv3FMz+nNLETwpbnWn2uU/TDf9TBOLoqlBMYT+8ZYumM1hYi1kmSxuXqZGyan1IV+wlxcpZ8bR8UsYWpV6qyze+4X9o8+8p1mPzk2mJH0YFP7CSWZkTeFxspP3Xk2JbrzTIceOA/5qukARlstmcKI+IzwZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294358; c=relaxed/simple;
	bh=J/cFR0jPp3K2EC4XG9yrhuevB/cgtUXcUj8OgyrC9Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iy/mwmMCsRm5SnPeWYCLkJ/u4ST1ydBqiynKcHzSJpqhdhRE/9Iv7YFG5wN1ijBWGCH3Ml9TM25hu6X4RUgJYEdsybfz7B1ZbFHuhuTeLiuom2sn/z4X+27qVMwYji9xY8cyPanR4QcQIYQZdc3PMwRQL4g1LsgCVEzvqEZan6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aimSYcmF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RL5/yYuf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHilOt006973;
	Tue, 16 Apr 2024 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=mtByFJKzRuPHb7YqfZ9zoeugYzkRm1p9mn95H5aK1fo=;
 b=aimSYcmFBbPehaeZa+2HK/bO91nD7DzDZXLgk76Mx/l5HCTwyR2wLljpF/G6pF4EmDjo
 MI0izkSAxSxlqErt002pEaNAxkrmbE0ddb8nUofzNYPaPaVPoHu27fGpwrPLuySwAZs4
 ReAy7U5oSfKR91ZPKC4GUVS6sUhqplDHW8ZT90RiOr97/oxj0SnV4dO9YimBpjOaeor7
 oRo01Lvt5sapVNj8g1EdPzWBvk3bgIcv/4gSB3Jg0ovmTjFP/ZhiF3kVOakt1PZkt4S+
 edMQLUDNB5X8sYStsMJCke5Fwjo79uGlMOJu8vYw+FLHfq05lZt+u5kOfzSEwkD/yAUj KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycp478-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 19:05:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHQea2028852;
	Tue, 16 Apr 2024 19:05:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7pm74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 19:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGKjL87jW5DEO7a64XxZrcOFlsM3o661T7ZLU899K6vVVwxH3OAUAv1S+AFDdSDEz0CGtM/gZUWUu+nSU5KYqmz8+gw6r76NI1njHn2g9YVFZrHyWYfMBCmLmTRchWnGsG6Lc+jHjZkXdnB30eMe8u8N1v7AJSK0sfOpke9hhsftqruaGTFpRksav5iReGxBn53zep6JEZtsV/e01B+4GhTmZ0jGeNjpYYUKSC0qgp+O+Gw1Ju9vpjvPWlHqnxK+KHv2KYe5wlXZ9As0PYh+I+s3CqUs+peMKrlDRcDgpSSQrvEwP3N28YOsnFeXoxH8SrcZ4fwBUs3KlGKClnokkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtByFJKzRuPHb7YqfZ9zoeugYzkRm1p9mn95H5aK1fo=;
 b=UR8XuLVc9kkOc9UxoxchVApjefaGPEwkbhpWYfkYr/nU5nw6u7cCjwhcPK0c6sEHOehObMME12HtOv3CBnPaJEpood9mbMImUoZMFLljKIoNoumxU3mXAtupGkJEAYPfTm2AREr+GGA8WkVTzz15vrrnO6IL1DX0gp14cVIMM7rD3IodKsVyM7kugC3ctCeOEsd4ShTjTeoFRY1340O6m6wn5h6NHGlKk+5WI274OexulyqId5dXYjyFj0NRDat6v2dwRu1CEkMys+aOI8UbL0WbprVZiBOMwmOxxj6K9duKS6PX9WrttBvIMt6+vhTIkZ4C36RWFVH9bQN4whb1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtByFJKzRuPHb7YqfZ9zoeugYzkRm1p9mn95H5aK1fo=;
 b=RL5/yYufr9k0iHQKVp2CUrqc/FMtgm8RjxNXjlBwvjhW54Rw/6YznDILRJmgVK7Gfmj5dmtKXYSPR1FMQ1AjwkS4lijFcXHRBzjisgvOLdc0aRUQn+X0Z2PQNLxazAjHEuO1HaOE287nGD5GRzjcQKUrwZQ40NCtL2cdDbBgLFw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6964.namprd10.prod.outlook.com (2603:10b6:a03:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:05:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:05:41 +0000
Date: Tue, 16 Apr 2024 15:05:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
        netdev@vger.kernel.org, kuba@kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v8 0/6] convert write_threads, write_version and
 write_ports to netlink commands
Message-ID: <Zh7MA8TFNt4QrKdy@tissot.1015granger.net>
References: <cover.1713209938.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713209938.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:610:4f::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f842351-6055-48b2-71f8-08dc5e4835fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hm/XCy+8ogqQLnpktyUAzxmZCVg6r3vrmgHHKLp6a2AMQQyU4v5beBru0VIBiihlQTv9ZEvVGBIW98HMGXZ//NwDDcDmdtVatDWL38qtsVW9VPvGhitVllcl5h0r7Myp4B4RpRg6UI967D3CI0oVMF+ah//JZ1uWmIl+7LPbZUT1+lGMwyBjtQldhd3XcEuxbLu9lGC87M/f1NE9aWPy2AFAeRbj1yhxfhmllDQDyk05xIXw5ZxkcbHwqTz2edVbVmq+/Y+atdPzPswdQwqIQ6Lkh3SSmE0gZIQTPH+iv49GBZiQ15VCCM7Q5AkGcemzS9lyO+L5/+RsB+u1VwDyv/H+dUbUdVg9BB/zra2nOO5FrChDMm81DpIUqdjYQI8W/RFt7HqqsmNvt0Stt0gMCgbirZCpqC2jU3JnnL3IZ5uBMq6OfmWrmzrXrC7gGBRE7EHnV52f7azv6+rrfgpHOkE5iwBrXgcKgcS6Ikd9ms+KNRULohtedIGiIyZSlJ7as/ge/uDb0MbsGFbxmnGYmlg1XeVTmAGWriutbly8zvd3NHUpt30L5Xa4/sHjgsdKhekpCoamDPI3sGp75879nXMZAOnr/0ibrtJLev4hnuhVnpYVwxidBpFgI6QNKDzPq4Z/5AOCJ1cF3M0PUf8qk7HrGMH2GT10L75UGpPS1mE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J/0ar/QzH1mQqSW6umr9MhHvqgHIuDnnZMp0yDBD3P7SdG71LRjxbbh+DFEA?=
 =?us-ascii?Q?Y3+39Axv0W1zkLtmGhhU+YBvqRIJ8pFJGyPE2tXQhChCtamjkkwPbhNATA9E?=
 =?us-ascii?Q?l28FN7KJGCO8+BL4/qqeCvHE6sW49wu1PxSmFBtNqlxdi75c/mGZCrihjK2Y?=
 =?us-ascii?Q?AlBKq60ZwFAdfI3jTmzRNr8ywO0tDR7urpxinKTk+CuzX21DTPa1pqX/Txa4?=
 =?us-ascii?Q?JIHidEatpGHuLP2bldM918uK4eO5h+GAp/3Ihc8DkRDLIs0pIrgjmAwsz2am?=
 =?us-ascii?Q?JCU0LV4VtSYKJuDH8AZePGfyjcP6yuUGyrOo7UMajNGbh5P6haGPp31GvFzy?=
 =?us-ascii?Q?q0Ou+Ce29xfEM/7cI4MS2mN0N7c4m0ZxiCbwKoVZxLQ0Ktx3422VlC6GgtV7?=
 =?us-ascii?Q?9Xy2P22yt8qhSaYxDPDwiFG9scgJXQiHDHFIzgAu0/UC9Us2dQErmEBjk6dg?=
 =?us-ascii?Q?8Rs3BlTd1/g+E1arabt9Y0qEHgIyr8j9H3BiBJfNyuTa8kqIMA32zzG4DTka?=
 =?us-ascii?Q?iKLdRz4Aexptkq1/DhFo5IivIkOVELqFvXrD3IZrDoteIm1f+MfUfyKrDmCW?=
 =?us-ascii?Q?4h5hJcURPyAhTJePRxGvub5Ax1NAmqbvYNaBIMelHTdVKiza1J3c1TX0fNSt?=
 =?us-ascii?Q?0C9A+irqW4BeU9+UL9Dnx8fvKdkptpXK+CGrvVC1k97EQtdZqIfAEYn3Twpd?=
 =?us-ascii?Q?AZt4m952wt79gBCbyxAOQYSjfmErjdQeO9Ju8bEMfu6bOSoAWA1O9k/z28Vm?=
 =?us-ascii?Q?Seyqcvn1duj7czuNH9ZYKxqAK2+ToC9zxWKOGZqVDJJqybMxHY0ooLmUIQsx?=
 =?us-ascii?Q?MY3T0Kcbru0H3HRSdgAKIj3lMXxJxnwNbEBn6RnI6SNZDZiIE+/ws3W8tpm9?=
 =?us-ascii?Q?wSboOTrlTpm49Mc5R6zICOhFr52X5h2OsWSxkkmlhbvKAZoTHSnknOYaLo2/?=
 =?us-ascii?Q?W7pnjodFsUvmlA4xMboLGb8zJWXgo6bNlYDu9B9SgLirS2w7/KlUygAOFbEO?=
 =?us-ascii?Q?y725z7MlWDRNN+BEmnctb4UwZD9oXNwRl8rUZGhhoUfYH2g/+VZr5NvpFELx?=
 =?us-ascii?Q?1YpFZmZA8aMOMrpH07YHpnE1PLo5dsi/hyqC15T/jAPt23arI1daq5r+ARPs?=
 =?us-ascii?Q?RcA7oRlpDd4vRccm+Kz5D0VSTFCEbJPBFuaNyVNdNfssQl4s/GfIalu8cJiQ?=
 =?us-ascii?Q?2V1FruH7Z1a/moI2TL7FcB59JTvTy9+DQGuM6TcSXTRarTvhAtB8gfPVDQJi?=
 =?us-ascii?Q?RvZWzqHg3qbTj02fMNMpE6yHzPh4pqdOOTyYoPYbwRe14nYxq0tMG3HutiOK?=
 =?us-ascii?Q?ggWrmKIcwnOTXlmsylK0VanFpzm+71JmcIydTLwKUV2OgYFA4cKSpQMY2S1m?=
 =?us-ascii?Q?g2X76NGeF+ugycZYNGQAt2JYs9z2KPol7bm8Fr4g8nxzbNZR7NbtFRB9gWbi?=
 =?us-ascii?Q?cog5YbCPLQ6djcRP10NuCv76qggSZ6UzYElGi+oAo7RxJGLpWiJOY2M+kQsY?=
 =?us-ascii?Q?Jfgdo0PUDgdJw5BVfYk/csqfHv+LGNmHWRUSFuxxm1X4GExS9/DHNYDzRNcl?=
 =?us-ascii?Q?tHnZTVzR8G9xQRWD/PSeI0bPshUvNh702uh2ELk2OTYqI18pi1ekGy84yG5T?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0bBjO+2MCje+MG5MwR+7X8WcH8wKCXA5RP4TN2n7pYN45bJ2EXZATNpjbseTNTpmACm+MdHw0zjnO5Wzm3qOcnf4i3Cjcq4WBWjmTWXV/gQw69okIWkR2L8IF4lrZT/g/hh0R+GybgdgPV+eIKgmImXdIma8x7p+BEWnZNt0rHZbKXIA4IOJGH36vQTp2cbfHO9zePjArB1+3O3d+BhSLXTUGETOyJZ6UpU2RErPV3NukPk1AVPej4Ku/eU8xHzxODfK3PIoxkKnvsMyA/KRr5Q4Cfa/QozmHrzUmjp2V90CeNmRzO/E5Rpkko8ZlijavHjCIY5WX2BcD+6VhgFJFr5fEQsqSx5xKhzWgN7UpOBJ1oKxPvGuh4m1khe/W/YIBgC3NCAQYRHRnbFPDDh/fsROcFAwswWTS0SbYStmy3apgg3Ilaov7Qcb9KQEye83rzmpdWy1ZX1EAlO4tjRprcdGiOgVm7fpH/LwO9QZqTw95yl16d+n60OxZchFqXv/WcIAOLrcqxqBZ1fbg7bJVHfhZa7ov5leI4ROqvjyrBFdMm7rno6LRhvx64AonpEF6flFskEu9rqU91pOEPFgRq7+KpSKGBdm9x1T8VESudU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f842351-6055-48b2-71f8-08dc5e4835fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:05:41.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsc7O8zTmAwLZTC73pmB1fn80bbX0VPImF1KL1utSdvjU1B+5Yli6qTwmTjpHDcHtVDwTAu8xfssUeEVi6DaNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=974
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160120
X-Proofpoint-ORIG-GUID: 8GDClqlFWcZ5vYQwzKj2CAp5sK3V6OsJ
X-Proofpoint-GUID: 8GDClqlFWcZ5vYQwzKj2CAp5sK3V6OsJ

On Mon, Apr 15, 2024 at 09:44:33PM +0200, Lorenzo Bianconi wrote:
> Introduce write_threads, write_version and write_ports netlink
> commands similar to the ones available through the procfs.
> 
> Changes since v7:
> - add gracetime and leasetime to threads-{set,get} command
> - rely on nla_nest_start instead of nla_nest_start_noflag
> Changes since v6:
> - add the capability to pass sockaddr from userspace through listener-set
>   command
> - rebase on top of nfsd-next
> Changes since v5:
> - for write_ports and write_version commands, userspace is expected to provide
>   a NFS listeners/supported versions list it want to enable (all the other
>   ports/versions will be disabled).
> - fix comments
> - rebase on top of nfsd-next
> Changes since v4:
> - rebase on top of nfsd-next tree
> Changes since v3:
> - drop write_maxconn and write_maxblksize for the moment
> - add write_version and write_ports commands
> Changes since v2:
> - use u32 to store nthreads in nfsd_nl_threads_set_doit
> - rename server-attr in control-plane in nfsd.yaml specs
> Changes since v1:
> - remove write_v4_end_grace command
> - add write_maxblksize and write_maxconn netlink commands
> 
> This patch can be tested with user-space tool reported below:
> https://patchwork.kernel.org/project/linux-nfs/cover/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org/
> 
> Jeff Layton (2):
>   nfsd: move nfsd_mutex handling into nfsd_svc callers
>   SUNRPC: add a new svc_find_listener helper
> 
> Lorenzo Bianconi (4):
>   NFSD: convert write_threads to netlink command
>   NFSD: add write_version to netlink command
>   SUNRPC: introduce svc_xprt_create_from_sa utility routine
>   NFSD: add listener-{set,get} netlink command
> 
>  Documentation/netlink/specs/nfsd.yaml | 104 ++++++
>  fs/nfsd/netlink.c                     |  65 ++++
>  fs/nfsd/netlink.h                     |  10 +
>  fs/nfsd/netns.h                       |   1 +
>  fs/nfsd/nfsctl.c                      | 476 ++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c                      |   7 +-
>  include/linux/sunrpc/svc_xprt.h       |   5 +
>  include/uapi/linux/nfsd_netlink.h     |  46 +++
>  net/sunrpc/svc_xprt.c                 | 167 +++++----
>  9 files changed, 819 insertions(+), 62 deletions(-)
> 
> -- 
> 2.44.0
> 

I'd like to take these for v6.10, just to get something we can start
working on together in the same body of source code. I've been
waiting for a degree of consensus between you three... Hopefully
this week or early next?


-- 
Chuck Lever

