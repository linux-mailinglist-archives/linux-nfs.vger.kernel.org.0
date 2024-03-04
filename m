Return-Path: <linux-nfs+bounces-2168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72068703B1
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E647282CE2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E23F9F4;
	Mon,  4 Mar 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Euuk5dah";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aWEQmQ9R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA63F9EA
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561388; cv=fail; b=mH6nnIJbhB2bxRStHbBa8Bu48n7UHeSDqQ2I/I5pV3cx7xy4Bnjo7kyhMbZ7/FLa9ycotkd7obeYVjlZlQV1GY8wlboB4K7y+54iV6Taz6of4JzaGtuXKCNbGJt5+4Vta9up0nWcrxTQ/haHwBqCFkkzlnOFR6I83z0F0IwQU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561388; c=relaxed/simple;
	bh=x+H0U6O0vPMgtYHWGCqpd2U/Ukm6VEVqLFTT/PXXIsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIvBq17be4PVezqq04y52dYGy05mr1zlhtDj+F2pvWybYKaSf/aPpUo/uyzUVY2T0+cixh/IVPxlzTUS2tV9Yz0dxOntNtBOv5d+rEPf8TntII9U+QcIKugF9xq6tJ5OJyqvDkXqjmanM5ykb2c2JjhZP6iHQcHQDrSJc3DBrwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Euuk5dah; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aWEQmQ9R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTlg2006033;
	Mon, 4 Mar 2024 14:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Sr7ubHI323x4iQZ9YWpNKCHuK59CMZTvFtz2tqlefjY=;
 b=Euuk5dah0z/BJ5w+pkpn8FI0F0wncSjm4bUFaxMuOCKcyBiSf7QfxI3W2VYT987A9kfn
 EbpFVyzA6mpB3E4G40S+i8CvDUlTiPjyXptlUe6jcRO0+/5B3JSE+QbfhkYVJqab0jZn
 P/bwsI2ibDlDpS3aYoLIBsJtzawnUdXDqBpaiJCEf3bvMlFD18oAW85M/mkJxghL57jW
 8v+r+3KcF4t1jdilOWaPF1ZcEemnpOJWM+Zq74AuSd39ho2yxNjvtoHgvUeZK9EBv+AV
 AZ/U6Vp/D0wmmpeSNqBoDjCX/S75szop6e4sugr+i8lzZiZX3OQeqhLHVLp0AUGgFs1I 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cbnre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 14:09:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424DuWs8016847;
	Mon, 4 Mar 2024 14:09:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbt733-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 14:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8htAhWEgJnLZV1ordaCv0ZlghGvSwcN5U9gDaUg8c6srhCT3vJFyGAAoM4hmids/46She0lXYzXxhBewjqkJEprJflzygigfns9JcZoud20KfZTKw5bbst4GmuOhORU3MtRXq4Zjku/lsi5oSvhqzxBg+rQYoZZEovhEdYh8XZgeNvvNKIT9iMrjcs/1yy0uy3XQIx+5fxEA2MN8Kofs7aAEqS4R2hKNTUoPvUUOX3hxon4lqdJ4QtRTDmvFrBRhYUELYFFOKB8UfZj+knqyTFsr1Qr0m1DsaSXp3sYZ6NCleUPE0laDSLSQbPLlj72TmRKseDly4LK4s8kkBt+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr7ubHI323x4iQZ9YWpNKCHuK59CMZTvFtz2tqlefjY=;
 b=g3XYci4HomdiogHO/htuLhsL6mwriA88BCqhXxngyA16mtEM1mxewGU/alDf0M57PZiRjEADa2pqtGvVNFiNsnZY75kzdwnLXx2RizxmXoiHBbhItix212T8uNY7ZExVsQSv7HTpRfEkCG6oYn4BIi3ECcqw6IotwnTfGW+JsNcgXAl+Cwd+4MoP1aU163+GC1RSOBIDwLO/ecmGc4luxlsH6TsQdsZlrw+cxxSmktk6udm0y5IWpsjwTC6eLMwps6VNUguy4PlfqtfOCEoRsOgV3GhFJwbgf2CUkt1Y+p5CSzTCP7ggVTpjEtEhnoG6atpNMwErv2+RA1RYtDMaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr7ubHI323x4iQZ9YWpNKCHuK59CMZTvFtz2tqlefjY=;
 b=aWEQmQ9RgQ0uLhRYhemup8yb0ozz3XU+XYn1HFOcRCqFQO1xHDJOWjkjXru/RxZ+vPTWofTF+H+XJPFvyQBZ2z8R2FKoVP2eYQrVEB54d8CwRw5mLsgtMMZkdwiU0r1dR4ebolaYubUrDb8DreAkDQ8g/CoVaNaWIm/rtRXaUy0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 14:09:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 14:09:30 +0000
Date: Mon, 4 Mar 2024 09:09:28 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
Message-ID: <ZeXWGJqreYH8aayB@klimt.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>
 <20240304044304.3657-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304044304.3657-4-neilb@suse.de>
X-ClientProxiedBy: CH0PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:76::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aaac4e-4655-45ca-cbba-08dc3c54b5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qnsN37p/HPjQuAAhsO4uHuIOMMMuNjYs285XCnWGwWFLQLgv/Of9pBw3kqd+ar6Ids/D8RAqek0PaYXarL4XHgz9NuczUHLTaY59hDLYU5cXfcXLMFMsIOc3Akh4PimwqRI0nICLSHKBq1YE8LC+LARXdLJYkjNzV198Ihq2ElU4EM53UKZiQKaVNc5jSd/+dnZhh10/Dk+Xs/EyI2/HAh4jCw/xLB7PS295JQT7yszurmN2WvIHRQ824gM0h6joAORYbTVaJuOgYZYn8Yrb2idYqqKbIn6Tq21dZTV8CHTjJqWc8mgfqB98lUx4nUaPehWNlEM17TR/VPa7WCnRB6WPUMfOYXW1Z5+iBv3NaY0fh1XCGKL2QxdwW4dd8Y504DuYq6VcYj1emKFK6zW6OPeGY63BMfnm0hUbgWRvbOXHe8oyE5cDwgtyJ1zDFMp+MSAv6V2UEEPZZid3zm524pJ4wqwYa4J+634VLB0sM3Ym+K2mobd/W7xZJ2RbijwfKNIvSVdJWtdsHEXWfpPTDp7rLq9zT4gbTY4mZR/hKMACD5izwp1VpDyNaTeSO8w2KclE5cJP9IDImYDXJRtqb4orpi9AfkGz3Rvl8loflpecAcHXZo3r85qoMk4pZCUEpHC/tfnvQK1X3bYcB4oBuvPmLq/P+Tug3AVsvJDElME=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sf59J5RkwN1Vh8VWJGt8ZL3ibN+zXwHt/Rhm0CVF5JFR7SJ2J8KwTfqN7GFc?=
 =?us-ascii?Q?DZry96YRBk4coY6taFbccgEatyBqMRR+HdFkB3bZDDGvKK+ImSHrgJ8gnvJm?=
 =?us-ascii?Q?kSugabXLfbnZEyUFVM3Kw+0pUjPLu2r2mszM1Lp3KONx1DcXXmaj0G2oouLb?=
 =?us-ascii?Q?lxkOjz0Uj43Z/7LUznT4Pm0Q3nus2UGAh+Ir6P1qBRNOwywTbRwF8aI4c/hp?=
 =?us-ascii?Q?ii6uM3jOvsd0JjesEdh05uSG7dIllREoINcjZzKM1aX/Gj4M5MQhBod58ATI?=
 =?us-ascii?Q?azw1L2Fqlpip8syTN9n+wyP+zsybRJSlVRuKvf3V5be9NDbeP4j6Q261t+95?=
 =?us-ascii?Q?w2Ra3JkEFU8BuCMooJVN7CWHOZLVJpUTV4rH/cfnpCFu2iKSh3Vab0QnxBq1?=
 =?us-ascii?Q?qxpnuobKMV3mQESt2mj1+J0at6cvMal8MPWf5Jc9LE+BX+IHyvanSjaPSXhq?=
 =?us-ascii?Q?Fe5s6h+R4BcJaapcenuoLaiewwYkdqs3qG4J0EFZu36/mwbAQLbMj5J1Gndg?=
 =?us-ascii?Q?z5qXEQFvRISBVhUuHtyehMZnvO9rWOu/ivhzXrvIKDKxBYwboHOdg0IwtXLM?=
 =?us-ascii?Q?4vMKZ5+6iq+ZB9VBCoymyXR8MBEukegW+ZLfl57sUHSyrImJcbpy/eCtSg8g?=
 =?us-ascii?Q?QWB2l7do7/mRfY5bgAdORuk6xyLG3pXRuO9ndP9CQBhua/Ftm48SrQY4DL8B?=
 =?us-ascii?Q?C03BD8qmU+gnuz33Gwl+oRZbhy3wffaaxSxy4kqJTJsag/qiMY+tdGTvI0TV?=
 =?us-ascii?Q?ZjnLT8kd62A12Xx55+CnzjT7RnGKWww4ptensyc7bxylePIxu3CK+ZseLWlO?=
 =?us-ascii?Q?v2clNlHK3Xi89OFTVWECUdusTtnHDV/mzeQj9blEPHCSoP14PkA4wtmXhwi0?=
 =?us-ascii?Q?WSmtubZJrcwCsbDjx2b1thv5Q2VX8m2BRV6gKARmc1x8+DzFAj/FUVz9ZZ+z?=
 =?us-ascii?Q?7J6idPwONL7QijUYyybh236jWl+WdFoOsEfhzvDUgZZMyGsqOzpmig0KGJCb?=
 =?us-ascii?Q?bglP5/N7Ex7AVQJD6ALv3efPBH35bMT0DfUs6VqD68ayEbhhrEIz0swxbJhf?=
 =?us-ascii?Q?s196BdVwES97CF1a3C2YxWXcz6nsGx43/ehnVEKqA0qUFyG617XMo51fPHJB?=
 =?us-ascii?Q?RXjxOPorv21XxVEiylblIB7ZvdUQB7bFsXipsX7YlQjepCu5KQPJugf1USQ1?=
 =?us-ascii?Q?urmcbXRg7OOYvA+WCNUHYf3UUptdUr8SSVDtKzMzg7w2/IK0g3H9co6zJQgp?=
 =?us-ascii?Q?TKfoRAtC3J8qS4Z8o3e7SVv/Es62hDAeorpxNhhXtjyd/Bqa6UZ5xF3r3+5l?=
 =?us-ascii?Q?zUE62zW9PIwTvU+loXXhRglSX9O9vdA9QIw8KRhD4R+fC3x5saavrrmHmBRp?=
 =?us-ascii?Q?JCJZ2AQaagRcCxkaxkMMC6+nUd4UvErnD1fdqScz2WfTb1Cnp5L2rzUzN+Wz?=
 =?us-ascii?Q?NAQwJPIgyTGJTR325PhKlIcOApG3QWJDWEiFJgnuFPxsh8LUcDLqmAfk5YO2?=
 =?us-ascii?Q?PNuz2rWuIDubd45BkdsUvx7TdfmDaw3MrHEAO/cJCVCKLbR1PgilfamQheb8?=
 =?us-ascii?Q?7RGQR45ps7ohHftKTWFVF4uWyltk9YRc8pV5tsuppUoIA8z46puF1tXLAth6?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Tm4AaVEDwlF1iiQ9vvY3qb9rofTIvCNan3e9aiyX57HJAaHYefrAhGFUZEsxMIdoXvtF/KEsis/Bu9afdXEhuMRyO6Dib1hve//KYYYdvF5BFtAIo6lxgNVOfK/B9BV4vcn/4cQsyGluO8toNitAkUmNX0Ka4ZehrbQJ2b4+CwC0aldJSJejiwytPYlNWtJ3wzGEkS89v1svXxLas5alFTUn6eprtgyhJKaW1LJzfQa2zmCnMLRdpgaFFcBjOcJOweGPiRPKwCnR7LBxXlqNVlffvw7v30WqhjrDexI/bH+EtSXoEGyzO/BT7BXCffXQSZjAn1yxDbYaqIKuaw2aJGgr7Hn+Hj7+bU09qpe4jz0WUrKvkBfECvwriKf/hFzU6Xcct6YCLFHCSWdGMBj0nADhgvo9q/9/1MeqrCDOk2l//FzGNf1kVhwH/j4G6KazWDqQrV7cHQ7TovClU5UWrUKLLcw+1GjyDwgTMoCcqrK7w4fA7XIOZWi97ntE9ghMeLIed3YNMRWQWst2bzv7OwBM1TPo2HpNcMJ+A9Kw2qzJj1SKN6g7wDU+L/id7lUzefxxpPyFJ4XVlDLijLLamySPG2sBbufjd9XI/YmGMUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aaac4e-4655-45ca-cbba-08dc3c54b5fd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 14:09:30.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o1/Ftm3CTM2Jr+R+fsxHYMYOq+/HGPFi8sBPE6uAi0MHGZ7+dQDg/wvrooZh9S2NaLkv0vBlr+otGJpXT7J8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=840
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040107
X-Proofpoint-ORIG-GUID: 04qudiuc1pNhZqh07Q5q1xxqAoWcsQhj
X-Proofpoint-GUID: 04qudiuc1pNhZqh07Q5q1xxqAoWcsQhj

On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> move_to_close_lru() waits for sc_count to become zero while holding
> rp_mutex.  This can deadlock if another thread holds a reference and is
> waiting for rp_mutex.
> 
> By the time we get to move_to_close_lru() the openowner is unhashed and
> cannot be found any more.  So code waiting for the mutex can safely
> retry the lookup if move_to_close_lru() has started.
> 
> So change rp_mutex to an atomic_t with three states:
> 
>  RP_UNLOCK   - state is still hashed, not locked for reply
>  RP_LOCKED   - state is still hashed, is locked for reply
>  RP_UNHASHED - state is not hashed, no code can get a lock.
> 
> Use wait_var_event() to wait for either a lock, or for the owner to be
> unhashed.  In the latter case, retry the lookup.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
>  fs/nfsd/state.h     |  2 +-
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 690d0e697320..47e879d5d68a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>  	atomic_set(&nn->nfsd_courtesy_clients, 0);
>  }
>  
> +enum rp_lock {
> +	RP_UNLOCKED,
> +	RP_LOCKED,
> +	RP_UNHASHED,
> +};
> +
>  static void init_nfs4_replay(struct nfs4_replay *rp)
>  {
>  	rp->rp_status = nfserr_serverfault;
>  	rp->rp_buflen = 0;
>  	rp->rp_buf = rp->rp_ibuf;
> -	mutex_init(&rp->rp_mutex);
> +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
>  }
>  
> -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> -		struct nfs4_stateowner *so)
> +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> +				      struct nfs4_stateowner *so)
>  {
>  	if (!nfsd4_has_session(cstate)) {
> -		mutex_lock(&so->so_replay.rp_mutex);
> +		wait_var_event(&so->so_replay.rp_locked,
> +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> +					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);

What reliably prevents this from being a "wait forever" ?


> +		if (atomic_read(&so->so_replay.rp_locked) == RP_UNHASHED)
> +			return -EAGAIN;
>  		cstate->replay_owner = nfs4_get_stateowner(so);
>  	}
> +	return 0;
>  }
>  
>  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> @@ -4453,7 +4464,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
>  
>  	if (so != NULL) {
>  		cstate->replay_owner = NULL;
> -		mutex_unlock(&so->so_replay.rp_mutex);
> +		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> +		wake_up_var(&so->so_replay.rp_locked);
>  		nfs4_put_stateowner(so);
>  	}
>  }
> @@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
>  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
>  	 * there should be no danger of the refcount going back up again at
>  	 * this point.
> +	 * Some threads with a reference might be waiting for rp_locked,
> +	 * so tell them to stop waiting.
>  	 */
> +	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> +	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
>  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
>  
>  	release_all_access(s);
> @@ -5064,11 +5080,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>  	clp = cstate->clp;
>  
>  	strhashval = ownerstr_hashval(&open->op_owner);
> +retry:
>  	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
>  	open->op_openowner = oo;
>  	if (!oo)
>  		return nfserr_jukebox;
> -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) == -EAGAIN) {
> +		nfs4_put_stateowner(&oo->oo_owner);
> +		goto retry;
> +	}
>  	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
>  	if (status)
>  		return status;
> @@ -6828,11 +6848,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
>  
>  	*stpp = NULL;
> +retry:
>  	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
>  	if (status)
>  		return status;
>  	stp = openlockstateid(s);
> -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> +	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) == -EAGAIN) {
> +		nfs4_put_stateowner(stp->st_stateowner);
> +		goto retry;
> +	}
>  
>  	status = nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
>  	if (!status)

My tool chain reports that this hunk won't apply to nfsd-next.

In my copy of fs/nfsd/nfs4state.c, nfs4_preprocess_seqid_op() starts
at line 7180, so something is whack-a-doodle.


> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 41bdc913fa71..6a3becd86112 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -446,7 +446,7 @@ struct nfs4_replay {
>  	unsigned int		rp_buflen;
>  	char			*rp_buf;
>  	struct knfsd_fh		rp_openfh;
> -	struct mutex		rp_mutex;
> +	atomic_t		rp_locked;
>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
>  };
>  
> -- 
> 2.43.0
> 

-- 
Chuck Lever

