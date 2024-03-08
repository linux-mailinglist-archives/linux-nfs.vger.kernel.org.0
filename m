Return-Path: <linux-nfs+bounces-2246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCD876AF6
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 19:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7354EB218B7
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B75823E;
	Fri,  8 Mar 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E93CaPDh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v2mAwukl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A44779F
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924222; cv=fail; b=nITyvVJ82BYSMDHbTYY7G/Isi33S93k1CBMfu6YsA3+UBc7iEwxhWZvcXYCHGRxfSaCAJYzBf+OXyWhjEQF35WfU9/h5KVa4QFRW/Bg9eO7d3ykLyro5AypBs1xhgVuqE8oNK5s1H4jx6133kCbI/gjT96lwJodK+f/6m+JbHn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924222; c=relaxed/simple;
	bh=rEVbt9WuD6GIeUqpW3s7jP9ZbgeaHgCkTKHe1DsUQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0/jXqZX35TmrU/mNt0F2yVWrYu9j80hbsc0NTseeJh1KIM8jDMEhDx2AF4FUAVRbmCUV6Sud5dbCgBzXEbQXScwaHbI4NzF2enKY9Gs+f2KRw6nqzE1LdlGTKg1611wgwhPPomoUMrAF42KH4FvpNuPHKOs8t9y2D0AbW5+hLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E93CaPDh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v2mAwukl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428IO1tg026969;
	Fri, 8 Mar 2024 18:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=AkRadjkuM2JrHPcKct6u/rWqfWsG1aTC2HZjBwDlp6A=;
 b=E93CaPDhjzTzCVS6ASfluAMwBCkehn9TDDVxJAAAx7kZR+Kk4JxzoBvQOtAu4C+xAo08
 VdVUt3XdWXGNYQEw/7VCelKvfm3gx3vWBo6Auz0VxxpbRR8ZpmPg6TflWkjGEiiQTooX
 97AR1eT3nroGridWZ7hYr4Pn6H1dRDl3ycLXWeF7HvspElcNs6BJLntTO+7OVa+VWTY8
 KdIuMIbkPK7lOl0+7AbonYaiLsnHz+7OglYGnQVYMY4POAWeWg3BWTgulzXy4YU/VDmg
 KXVIxGzODbixR34gnQ/znSkSv8jSrq2I6kWg0eew3ctG7Xa2kDmGtGpvZlBhkxHR7JpM uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4fgsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 18:56:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428I1rs6027553;
	Fri, 8 Mar 2024 18:56:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjds4js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 18:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe6b+RVT2gYSG9FMrBe8NfQi2YWXjtNiU5j2GDGq3f0V0l69/RFRLoIk28RaJXJ/LHtwt0kdfa6Wk0ZbvC6kK2DtKD5npej5+Y1Y1GwO99u84qUJ0+rY58HH8A/Mxy3CRNDmHb2D7RXPVR8NNCNGEAl1iB+JQI/SVT+Fkz+5jwj6JnmfHn9sfn7Z69iXpIpmbc53RLEl4c5UtaXYtSsFqfSvZUMXNLAPVXdonLzMMuq5Dy8vuR0QOjD/dUsbPsq3bpvRckjbdS7KwYvdNpzzo9I2qJKEU35F+3yWFXHTs+K2hu5osmhB/LQbBfq35OaIG7/6hiu8p0pODx0ohD4/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkRadjkuM2JrHPcKct6u/rWqfWsG1aTC2HZjBwDlp6A=;
 b=jMFqJLnwSiAEvKf2rVCObH/s3K7PO9ky24i01oALvQdAMVkdM/1ZZILS7Nv1q3ltYFTJtyU+dNSOupEzV1qcAdUr0R2SwzkHNGNZ251B1s8kvoChQbXslCJwa+YBE6pRWzVinB3NFSgV7nfoLaEOKJMh/T47dtXuSoP7b4iOg6fyvnhRRZ0EtjHVaaM0nUOaa5xKU5blMiygjquIjE8wC7lRbnaWSXV440MvjxQDidnG60WlfM0VydLEj46Ef0ckAgq05VcVVmEIzE5eR8vsRbQIlPJxhRWmPB7laf3tkAMaJ+DY75GTcadl2n9WLOL7Qxkw4M8RwclEE8WDsfNd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkRadjkuM2JrHPcKct6u/rWqfWsG1aTC2HZjBwDlp6A=;
 b=v2mAwukldAzwwfV6IYd7ahF2CAUQkJu281Y0uxXrZwdICuOQvCxZkQBhMGieCHtQB1ib6VrtdmIcOU0cv3Dj2PQ9sX7bbqU6WZ011kr5naV1R4LRkDSLdelaqN7Ej5rarfZe3mXZxPP8V+kfoh5HZOz5EduGUKgWwSgD6sbS0IQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 18:56:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 18:56:54 +0000
Date: Fri, 8 Mar 2024 13:56:51 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: trondmy@gmail.com
Cc: Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
Message-ID: <Zetfc_UEkl02Gu3N@manet.1015granger.net>
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
X-ClientProxiedBy: CH2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:610:4d::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 048a9039-94eb-4c17-d213-08dc3fa185c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZebHWYubzpMGTudY6Cfsas6RG4yFxZpbmazhdS0Xh5WIrXVsM4P6nr5bxdcLfgMmoujep3czdzgnJ4JMedq3q7MR+v4a9UKmOqHQjPBaHp/Ij4d9xgfblZnsFCSNmrhDzxGSjz+dDciUKZmN3z7ORaxVuBjqPIKjHou4f2s6CjuHdQpnqdWYUIw8kpCn654Ky+7vcemQGPulC7EcItV6P022ldIrPQXAKE8NbvB6VizsFSR/vVtMJe7LMXdnfd/hIL0xh9tVlNjBgyB4rj27HZNh6hv0we46d7HbUZk4iu9EikUPpQ2v0n9fEfsGG2zb34JuXqhqQ8TFpWWEtjTIcWHhugBvh5NR6r6PzlGzd2EF8arGlGQmAuPmxEqSPwBwisebrhdYf7K3qVAnGgZR6hmRFDhlyoER+v1ws9+vh6y/OGxgYwlbl41ZLJPfIzEqJRFUxFrK4SHZbsDKSpFgJHywsnOfj7tXnnhkAkvCWk9ejcYe5esNP3t8ZA/X2C9yqyrwjI6+a4djfwL0rprKkNmEw/Ro5SCp3Gbk2HBlRCf7Qlot2ErtrC2wVcOYBpCz54Bkcbm/3QoYwsuyP/J/h5iU/GrNCQ34rAp8YFGuj2wZrMfZRRHR3dAaGBuINev/PlJ4VVpXfgeePEpFnM2gRCEWWNr3wb/PWpr1aHvzKWA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GVccIE2AMfAXw+Dn1Timdbk99Q8+rmwtIEugezgj3WQMS3U+w6xh8jLuSthG?=
 =?us-ascii?Q?EIJdJFwSqWNfyFSvaC5QxOm37qOom6ZC2czm4NiyZzSxiw2W1O06DUfjVMI8?=
 =?us-ascii?Q?wKfOsweYi8S7cuzW06WQFlWJRn5Mb2i3oXOtJes3UysjcTz0UP81534Z4pZz?=
 =?us-ascii?Q?LHrDHn5n7I6gH24DxthT0TOpYjJONNFa+BeqMJwsyVigmopZNhFtUHinMV/A?=
 =?us-ascii?Q?ns6fkyqDOfI9BISHRi/+3VSTfwIFf179vZ+22BhC2g0fH1CsaQXjVm0DG+8r?=
 =?us-ascii?Q?VWHUj58keffprocO2TSWkh5J1Z0i44G9auumRi33M7uPj40zZeXWMBI6rJzi?=
 =?us-ascii?Q?xPmiAnYpeToxKwewd5wBdbfFyfYjpstuiIlF3kyVjHR46offJmShB6mkFgId?=
 =?us-ascii?Q?wKa3QoI4R+4/1mYGzIMjN4Rx4P7o3FYJ2CRZ7kWJHzkZ5HycTCX4I1CfDePm?=
 =?us-ascii?Q?mKWh+uAEY4hQXy6tZvS33XNf68YB509PnKGa/w6q53a4Q+XHV9xXLOwUeMxu?=
 =?us-ascii?Q?MnvWlv5FAb17FG9CNnHqFxDSOgM1Iw6WTZkz8SgbEIWGHxs1wCAdA1fK22JG?=
 =?us-ascii?Q?4HZcW2tjx/SYoKEpY0zDxnZTUJ4CAxQk5tivvcI04Z2pkEqUnMkrCvYsC7wU?=
 =?us-ascii?Q?FcZ0WFRadFkitdI7E5cqsXH9Ygfk2atMe8KhudiDUjWFbQUEER63PrCfbmbE?=
 =?us-ascii?Q?snZtZjbaOPJ7ONQDhpRYCuax9K37jtvTU9jYkcv0lcJF+tKVy5sJgam+PNW3?=
 =?us-ascii?Q?jtQ/1aahoS3GKjYcAhniWo/oFz3iaTZdYdwYj0kluhU07dnIqCqhcNQTwGDn?=
 =?us-ascii?Q?3u+3aiI/3I51Nqx9RMoJgdRxbRRIpzRuUglKq0j0fR9WDw9jfW2fPN1lBWFn?=
 =?us-ascii?Q?xR7Esw9gmRw9DUYD5xA8jhfvbtlHJ6mlYOmSZ4D1mujEgXrfb8PQZklgjfC6?=
 =?us-ascii?Q?5Dfxd66AwM73XaDL79N07ehtlczNOU9pEOneNomHvCUupogYlgJEAJchaC7q?=
 =?us-ascii?Q?I12dfOrkTEvsZUnQFVn+QQC43DBZTENrBcHkDsD6WSuOr+AgYbGUjtTAwDQD?=
 =?us-ascii?Q?cHnnFzqZDLVCR2iN00C3nU2FQSt++BcLKmF3dHdVLar+P+LKk6411w0LyIXs?=
 =?us-ascii?Q?kirNf/a0JQIaydcjnMhGyM2U4VPB+eDag9L/qX0D1v35q/A1CIpUpf0KRMwi?=
 =?us-ascii?Q?oCMercg0hb7o4QC01QpHswl2UeLIocM+TfGntszdb51AyJuLgQVEQjGR6EXt?=
 =?us-ascii?Q?wb3H3RzoKzfaRN75mh8s2KaXVbAaz4a2UQq2pwVq0btM7MVCBjJJmalYRXYd?=
 =?us-ascii?Q?kTQ0XTNed859Uv4j5YQxW05ow3mIkgPIRLXonuX/1kxORR3TYEHTGQyAihaL?=
 =?us-ascii?Q?2bxdJbNnD1N6a/c1pIiAYcDz48A17fNqxLjtI27IWqxghMHicLt4Vz2n2bPx?=
 =?us-ascii?Q?uNxXM3KxIZbBQ9DYq+NZYEK2b4ZdnIzBH/CzbhrVNJYtv6oNtijLT3WD0FoG?=
 =?us-ascii?Q?rmvTcf/zvBfFrw1QmbMUPhSlHH2KxGCNNr2l9ou4MmBpM3YGEqc5XnAEfsS6?=
 =?us-ascii?Q?10hWDpgAqms2WUhI73eneDv7HOtFZioUy2rZ4Scxyxd5Iz6Yn5zyuX350gp3?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XzCZ+P8aLU/pm3nYw+JIcCpmesQlcCXIY/thgon4eC8XOhOxYqp3n5HcMjLCD9upmwFc1XpMcGIdkONhlDqX86PYDGZYc7u3quhStkRTSTiaZE2hJluKbjZX9N5bfSvD2aGpHPB8cptJYKMCBDfW5LokXav45diSFYEHGmk/pkT2dc2EtQjDvWqSbkcl89J9pnXqaGk2RkZ+hlGqX+pRVJI7600TEj63X2GMz7ikjWfc3yfpfXGzBcBtyhTIDNxGi/ovN+4th/GReP57f3rEYqDziMUvHF53eagePolG/Tj/3EmXKbnPJ5cZ9C924B0kXMZd0G/CuyhZ64YZCNaFAlB9VLPF0gE9vzgDn1rXjOa9uMvRxnAcBL4rWchSZnKtDAKUOKvDHV2/knvx85+f5+c4E5rIX0Jp9woBtG6Ov+t5URF5pxCJ4B14v+sXa2lLsQuYSWnT+CEXylTQWjwM/sYal+tzdc+EdrlhPbpUcyDkKVizz0pLVexf/4gYcpKi8SFSsHa//jlQ2HvkTigwljSyMLiHOIq7KAt09IMZlufqSWfzNsVJTwu6IezEyvmqaefaXjXx1XnTxlU0Bc8qTOCJJ4+Jh5hQg7aUmqUv1f8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048a9039-94eb-4c17-d213-08dc3fa185c3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:56:54.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLi6cTHMxnjIiT2t/E6Vc+eSFEZKDWrAz8OUbVLpAz1jGJb1VGF74Mfx9V+2w6H+QL5uYnPhzsoAT0KCVoemfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080151
X-Proofpoint-ORIG-GUID: ptgqbMn7cBKQ-cK49iC0aJS5VTJvSxok
X-Proofpoint-GUID: ptgqbMn7cBKQ-cK49iC0aJS5VTJvSxok

On Fri, Mar 08, 2024 at 01:02:23PM -0500, trondmy@gmail.com wrote:
> When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
> we currently limit the number of backlogged connections to 64. Since
> that value was chosen in 2006, the scale at which data centres operate
> has changed significantly. Given a modern server with many thousands of
> clients, a limit of 64 connections can create bottlenecks, particularly
> at at boot time.
> Let's use the POSIX-sanctioned maximum value of SOMAXCONN.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> v2: Use SOMAXCONN instead of a value of -1.
> 
>  utils/nfsd/nfssvc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> index 46452d972407..9650cecee986 100644
> --- a/utils/nfsd/nfssvc.c
> +++ b/utils/nfsd/nfssvc.c
> @@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const char *node, const char *port)
>  			rc = errno;
>  			goto error;
>  		}
> -		if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, 64)) {
> +		if (addr->ai_protocol == IPPROTO_TCP &&
> +		    listen(sockfd, SOMAXCONN)) {
>  			xlog(L_ERROR, "unable to create listening socket: "
>  				"errno %d (%m)", errno);
>  			rc = errno;
> -- 
> 2.44.0

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

