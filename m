Return-Path: <linux-nfs+bounces-2495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2388E796
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644C2303237
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753F5A113;
	Wed, 27 Mar 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VIoBdalQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZzT9UGtu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C46132471;
	Wed, 27 Mar 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548691; cv=fail; b=Sy6Dv6MFnPbNiQNGH5XkWr10Irf9xUsW87gKZVSEFXA8s6NnsFLaIJ7V42zc+BQ1SKxefcWsgGJJ5eIm9SWjnJZrmFhdyeUEdCjso+Rz78xB7egbsPWZntkYkb0Bjag8C6DRs+BUfI0cM2jnW970DXjwmIDBi7jTmHNR6LeofzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548691; c=relaxed/simple;
	bh=x/XvQBhCyZZGVWn2uQ0/Jgtn8hU3KgxdxcQlaeaqcaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R6vMF7MFvl31fgedaXAkjk2P+3bw0vwTWAL0B6mqlPysKpcm6pi+KytQVlBR99aXhabY47Zm4NeMvvf2gf73mSA6xgJOiyGY3nD9227dKBywzgxI096w3/FiXVlrXRxQ8DKJUBjDwAUguBuhPhRJF2HWcqJkbcSMDMgYq/wRQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VIoBdalQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZzT9UGtu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RDht58004244;
	Wed, 27 Mar 2024 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=SJycnzFx3wxWy+nUbSLDxNyij7KjEjSGC1sB0P3pOVs=;
 b=VIoBdalQTNlf2kchnzBBK5wQqvF1xYzJbYIyAFu3HOSGTWjnjnPjE4nTcSqfgJDleN9w
 6OUmk3/XIESLLfb44irfruKPWd04+7NEkjaVV//TOh6F9qHqNdXjz6iqjz+Q6ax1Fc27
 4KPEwQYjuXvYL3MTeA5kVknkwq8J9boire6h6l/cFxqWPp0ZsJqled65GCsKlDZES0jY
 fXUjC7UmfuGRxTl4CvBWdXcgNElz5oOEngtW8nHUUfcwEWK6XMaqfch+bIqoNBfLQx9e
 UdYW0eStQhprutDygljKYKGoK4/7iIbBUzWLLHzGExLKnDpkhtRJhxx9GSh5IDBs7ei3 Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy0wgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 14:11:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RE5M3o012873;
	Wed, 27 Mar 2024 14:10:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh8hdm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 14:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcFd6mdGh4c8EMRvZPmfFB/8R6pi+faVhKf0bAGHe8Zd6zCs0dKfkOhooEtBEZ2EDP4rlSbBL5cEcNYyPIVxDzmirgj8Y87TuGqwTeAS+9K7iR3rUKt8ztd6EJpzVQEb8gY1n9PGHovdOxB8ZP/CY2Lcx8N/foz7gMt4OrHs1RxjPsTPRrRdrXAzWhSY1FvNqoxyouTmSvT6ngANlglPo03t5lDuOXEAEMm9V4Jpm8U7y4LQQ84dwYyZ43YFfGYPB0/++sAG4MFfMx7o4qRaWpF6HJu5rhQBD6TNwdSwY++eeicDkbuecKwQMyAASILTC+7pvEuItTO3GGc4njQ3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJycnzFx3wxWy+nUbSLDxNyij7KjEjSGC1sB0P3pOVs=;
 b=jgqMiBbhgr0nUXO7Bi6Ev6h6Dld5Uq7Ta0hd0S4jx+6oRX4/FOCfUsIfeQZMzdYCqNGGIjbKjifeSMgkhK+nIuGD2OpT/baee4oHpJHoSoqeCRSY28OZkGl2oVKJah3bPRYkQ0HBF6CsF45I/YuqDX/6x1AppnlEzIzSXxSUBxUlUVlaiuAiwwW1+8Gn9/OOKzBMqBP00WOpY7tV73VEXHstz99PKJ7245N3Uo4/UXCxazdhnezufX4qCRvnmFWvY2D37vs208E0cCF1RLWjNikTzTlAu0kVWiOt2M7DU6hQcQ4oc63Jo0UZuW+w8S6KubPd4XktvvbbIwuGJHuk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJycnzFx3wxWy+nUbSLDxNyij7KjEjSGC1sB0P3pOVs=;
 b=ZzT9UGtu7Q/z8XADChq9eXA1zR6FK9KNt64JHnOvwbKigZTVfIV3e0g5783bkU/LPcTkTCz3sbJAthBOls++aG7j+aTxic3CCbf5IWObURPOLi+FB+Ln6yTsYTJd4luuDPAe7bLKXQejFBlhFGA2jhGy7S5Grg06dKNmLZ/BFtc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 14:10:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 14:10:57 +0000
Date: Wed, 27 Mar 2024 10:10:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] sunrpc: removed redundant procp check
Message-ID: <ZgQo7TcAxYrBXQXj@tissot.1015granger.net>
References: <20240327071044.365284-1-aaprelkov@usergate.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327071044.365284-1-aaprelkov@usergate.com>
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e53c5ad-1964-47bb-756a-08dc4e67b8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+r1kMigkEXUHXhX8pwbEPUOy81x2dwaXAQpRnfxdfpLELePgknRAE9hkO4MVLMsP7g5LpwBPggSQ92bA6O0+3oAkqNqjMVsBh3qpKY0XyFqcbUTeCRoXKpBAdAxB1qoyHzVq+TEuXrjCKwCKOmg040LlHCxzmMyySgNyuqWhNenP6UhsKc+cnqWf3ggpbWiwD00qE/2yHRGHjCNZOXxeYmr5f88jndqcaiWYEDWYJ/hNKdc4WHgjUJTyUEcCjOUEbG1Wq09DuBvniDwknPcSLqvgGp2pZx/RbkJrl6rSYVQDuk+VpboMR6iYS5npvX2P9JHzp1fUjeUgPJ+Whoc8OBNCdzXpvOc2EQweqJtKo8ATBb8cOHjU//qUmQSbf0V3+bnDkWgyFhHOcr09HV4/kgdrWS7Y8OJblWG6TQQHqjmyfwakcFMRsuYEIZ/FOhHQarF0OYJ+nxAylJGw+IBDcJJuKT1lX4KCqC8FJLD867ffutHtVdmxGltRdpoaipXmMsjsMw4J9hF34DBgCp6FlyJZsvM+beDIAY0J7MX0ubT3X8ZAClWC3k3/bbjSzHzfWCAameFXVhhvzajzx1VXm800ODfpH1P7HQ/bzIU0Ae4wB6226a9oosH0T0Jx0PcY6/RorVhXfTAoxsVjfpzuX4V3puthrQ6m3ZF1lzrC0w8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E6lBmlZIlyMzeq8/35N+j7DPFScSmO2Q/4qd/TruOliIO1B5ATsJaqn6ZCMD?=
 =?us-ascii?Q?Rs5Oftcd+Gc9N9IDlVjCRiKToiUcmncJvRvVg2KByo/P+z5rsERhngbQPDbj?=
 =?us-ascii?Q?ZL/9luXPiO9vdcZU2yeCifcA/Rps46J0SwHbrOTzMQYrnzVDpOko4dtzVla9?=
 =?us-ascii?Q?FZTx/NsB/jkgsjUGzCU++N/90+RZXfjjG9TwY7nvfszwXf8NrTJjvHhmDaKw?=
 =?us-ascii?Q?xaJyfKuRl5H9arUAKHQY/Ep3pNBzrHaz6LgsrXUV/nGX8b8OEIDbmgScVV48?=
 =?us-ascii?Q?UPWFJfJeIf70yYgwiYpBrFvnKCUQUg0MLy+D1ISX5n4IMV0EWMMcJg0WR/Oe?=
 =?us-ascii?Q?yiNmpY7jD2xJ0HfWI7wbueRzvLlAdsbffJ60oBkkfqpu3PTMX61Ne5PydYLK?=
 =?us-ascii?Q?LPIhWQpiFuO1nfw1h1molhFQk1yKPsTAw6QxwhfVcGzDSCL4GITqfLFq1jI+?=
 =?us-ascii?Q?QBveHAC3MgztROkTiyRCVOXnKjg/IpFJDmJhhHQl/hNHwETunLo9FQZX0+r0?=
 =?us-ascii?Q?3JU91VraUPnm3IX3zLIX+oEoMYoxWPSahU/d+rJ2uZkr8pwgr5yc7wUpKOiI?=
 =?us-ascii?Q?79xQIq6V6NZhh/hKfVtMhRoseNwHm/0b7dxVxrR3Y8nrfcoYpl4p2LJ3TG14?=
 =?us-ascii?Q?Cl61owAGWJPI3Bkdbc3k3fbJepSUcLG4DUIA3X1RJHe2DJxRKUEngTKF2psf?=
 =?us-ascii?Q?D3Mrj30ZLYgn1Yk40wJ9IFAWSnjckAOQuBL6HvaWeFYAqz1qqN22MIQVGxEu?=
 =?us-ascii?Q?b2eAk05ag0UPYBy5Nv2d+DcxzywanP1ucB/aZn/B4XAB7u6WJTPXC8fODHWx?=
 =?us-ascii?Q?cvQOrZ0Dg8QDZDGhRAOioozyNbtEyV3knYvI+6uwiaD/GA4+o8YfejjFHRHM?=
 =?us-ascii?Q?Ur2lM+vYD/PSp5qZkusEkQ40wpA0oGP30xg4csILAUqGgw5Vb/yATy5ImtAB?=
 =?us-ascii?Q?xYXDWstsiL8yu3vqr8Mh7Rz8i3SfFpJ1Lx6lb8pSy30cUxcs7JcGUSZ0VLGP?=
 =?us-ascii?Q?o/LfgvYfSkbTG7Mn80u1jNpato7Mq70jYyL8JheoGYfivbFIdmo/93JyMF7t?=
 =?us-ascii?Q?/4v2aF+RnKezD92HLes9QCpeG2+hcqTw7Vvm5gW4ih1KMWesbLDxLPHN46bF?=
 =?us-ascii?Q?v/qs6ymvQqGJAkAIc3YU+yLWKR2ljyzol6TxjaP5H3Y6ZfYlAuivdK6i7lSv?=
 =?us-ascii?Q?IhDWK1PAWzop4oLiX6qZw4biR0J+ctppm2sNYmhskC4bjmJ+91otDQeWO9tL?=
 =?us-ascii?Q?ufFJChNKNfR2gy3CNWk53iJQip2CumcPGie+iznHBaL8jFwpCFQGjAW5DHuB?=
 =?us-ascii?Q?z2bdSpk8AIxEOTp43hDnbHJWQSOifUpmT/UviKib19K9w+sVD3c520mLEzDf?=
 =?us-ascii?Q?rs2hrL5v5VccdRfgKywaLLOXOc6m6xz1wgG4zmYvYcb82kjewuRtlIi+cVdS?=
 =?us-ascii?Q?TR37XyXWZefJh1EcK6M7i0t2kgGpTMYnD5P+Qz9E5R5orvB0VgSqK3/vz/ic?=
 =?us-ascii?Q?3TAzAWuFD2feD2vJSJs2W5JwJ9CpP1qxbHy8ZdsHWlvngayfI32VDJ9yGvOt?=
 =?us-ascii?Q?6bxTwehR7vb6ImZoWi4oT4gbsMlSFZVN2hdSvsD6wH+WaiLJRhFgfL/myDls?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OSxd4sRcS5TfJE8uLd08/XGMthst6AkDXFSs0KRv7z+Y9PVyh2+f/rdhFiX4NAP36pxI+6AefjxZ7cTqlnOIw1WWz1GeS4+i1mI6y8Qaw95dJi8Cva+oH417mVeBYdbGFtuirMQVwc+V8lwO6VeSKOI6AtliDPQI/VWhLWfDAhBHJHFGhceTMrgb4Ep3hUrMTHWTVusPvlyKLVYoqRgO8wo1/xQW6O3uTW4oMGuJd1gXdBoqQguu8s4mzz9WWX43xfPXyYtG2gNomG3B0MSVed0MQRQLwiZe476nTnTQ+NFUSiIlfPm9i/uKxh/0bxkKj3W3wy69myNM3EGdYNFWVGG7SQM+fekZtlVPZg6vT4/18cLWD9Evsf/UfFo0mo2NpzzLA7yRa53ksUADvaXb1PGCrHVdCYOuoiuk2qAWTL+gRcaXaFtxKIzknK2mO/uiA7+oenpDDIKmbozLJj7BnFfp5PIzq/wzHw0cIgwMuCNleJbxZ4r+DHGmUByYb+BaV6KiL+UpHTswzffvRUfs3kT+jgcscY8+4NST7NqYEf7DVMVoUPc1LqE3Dk+RnHc8u0ad90cIqgpdmdQ3fxr7jWHiSS57hbtk+mTuZgMRg6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e53c5ad-1964-47bb-756a-08dc4e67b8cc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:10:57.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E87eN5Be4LR0L0xi/Wn3HsSN0kziJPQtv0po46qWzfA5EJBohHa/qcllCYk03pqAOANwB5HC2/I7mVkw8bJVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_11,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=952
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270096
X-Proofpoint-ORIG-GUID: VnWtpafmeiU_RyZF6ICjE__Gw9TQ7Yw6
X-Proofpoint-GUID: VnWtpafmeiU_RyZF6ICjE__Gw9TQ7Yw6

On Wed, Mar 27, 2024 at 02:10:44PM +0700, Aleksandr Aprelkov wrote:
> since vs_proc pointer is dereferenced before getting it's address there's
> no need to check for NULL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8e5b67731d08 ("SUNRPC: Add a callback to initialise server requests")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>

Applied to nfsd-next. Thanks!


> ---
>  net/sunrpc/svc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index b33e429336fb..2b4b1276d4e8 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1265,8 +1265,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
>  	if (rqstp->rq_proc >= versp->vs_nproc)
>  		goto err_bad_proc;
>  	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
> -	if (!procp)
> -		goto err_bad_proc;
>  
>  	/* Initialize storage for argp and resp */
>  	memset(rqstp->rq_argp, 0, procp->pc_argzero);
> -- 
> 2.34.1
> 

-- 
Chuck Lever

