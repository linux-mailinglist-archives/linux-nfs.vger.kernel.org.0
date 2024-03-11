Return-Path: <linux-nfs+bounces-2261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B4C878151
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49FB287535
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BF3FB3E;
	Mon, 11 Mar 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pksjw3dY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cvuIoiSq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE33E46D
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166113; cv=fail; b=uLCZzF3yKugYkqc5PszR/j+3Hid6xGr/9HzpYT+gWZtBPbxaY+jrbvRqFVZ0ZHdF8/PrB9UrtaRRiEQBnoAVSBILFR6kiYBMmydPRn7oPLlhYobVlWCev9DHY6LhtBltuzFwQC0KNLRkSM3Wx+GIFTVM7cqa61VNFyGdq6U+Jt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166113; c=relaxed/simple;
	bh=J7JCIbCdSHt7bHDQUclC9m2o2MKGqGIXCXvUW0V1h/g=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=hvHbP3pfkaYjkOlCcqIVL44T3yIj2u3YO4UZ/37P27WeyJn6qeHV9xJHsdy+ms/+xeI8QhQSjGayec8WWj2e1I4GKPRiwgxB+KeWOHD1eNsZj6m0Qk8Hylw6fJDsCId+t6Ty9quDb4TYhaP04pgAtOLrPatDp+i7dapAXo1iboo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pksjw3dY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cvuIoiSq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BB4bO9027890
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 14:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=7ex/HyNLdFoMZtnekoHMarEjxpCvraB1awN1rDrKuvM=;
 b=Pksjw3dYiHnEyL4c8FWxKXRAgMTQ4ir7WYLbsw904pXHT2/74NuYTobY1Qod9mdRr2fa
 Rkla1hb6fhE+o6g3UrM10RUURYnQwZSmFIfbTkasJwCXNHGcShBF8MHgSNGc9FqaI19m
 ws9HL6CXwHZrXTsuIo4j5pC7R5LcFIlAuQVvAN4ANBsNzvS5G3zs2CLAIZLeu9+Ird+G
 wQCdKZZhFGWJXWLUhHOgf5bEwF0fDy65J9sGQ6/9qvnekrBQmIKmsL8SyuGtm2gEbPUf
 v24qPvwm3J3p+TvtkIP2/M9Niwn3v8tV7YORGP3tAI4BTbJhgu9kPnfFgdu1WDb+3S/g rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2bbys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 14:08:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDE9ZH004792
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 14:08:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75w3w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 14:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0PQNSR0XwFUy+79IpRleaXAtq59M9sjM7dazhB78GJmo0ahuf9waD38qJzik9pbS+kqHebHqZN8WDWinGgd7wRzdtP8yjs42KnG+0cnPlAh96p1MmIGsDskqYwVh6YhhrBGeoPKPu1FpVIwaKA+T0OLyLVjnP7/4mfSd+uGeDRHJvXF1RwSdCbrrS9ztK6gKxTfOYEPUdTqco9qoBvOldIyamqO4HahigEOU5Gvdhzcy2d4mU76CJXkV5m9Z2R+8/ArE0zdyNm2m7284/HANggTqkhT1vdlG3jMi+Lu4rJe0fKdEgtndRdmGJNcZNmX3bSj4uBe0xcl7oJIUrgMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ex/HyNLdFoMZtnekoHMarEjxpCvraB1awN1rDrKuvM=;
 b=OvUZ9EiU8eoNf2c/EoXaIHSdjp5DaaDvnUqWysC6i4GYSuCaDwCK+ujSyePATwCqfS67f9jDqEkB5kO+gniazl+KcYkJUdQ/z7k0KmrVKzU/oHSgHO5m7hZ6ht3X8YVTCV7wsOSFGIGneljnOHxAVgi7iny7n0CJVPl+O7g6Q7bY5Z00LNZACwH8Sq3Xx4sph+W8MTrZwegNUbfpyPzGZlIqt9JXA/znMGj4vYC8IsNN99/R46AGEt3EKHFTKV0H8ZHtgu4JZGqT4w19nZqJRY1a/zbCVqqE8jW9IPrnxra938mUYMOO4iyJGqWhomxpsnoWizV0OM15PAWzambDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ex/HyNLdFoMZtnekoHMarEjxpCvraB1awN1rDrKuvM=;
 b=cvuIoiSqkDSHC/GPTG8thfHd7Y8pVZ2maUVEdcGU4gLfQ6eqOiT090br0zdYIOxUSt3CycoYmGH2U0wDSy19J3rmOiUULa8VXAErmYUjIqMhBVBLOAHw+Jrluqxnw3LpsBzkPGx0PQHaiqu5sh2HJQaPUh3Fr3oOWRrSfjtrIwc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6681.namprd10.prod.outlook.com (2603:10b6:930:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:08:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:08:12 +0000
Date: Mon, 11 Mar 2024 10:08:09 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Ze8QSYe_en73ycFY@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:610:10e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fdea99-987d-4bcc-b580-08dc41d4afdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yBB4N9oQG8uBz8FaD/QBgV7LmsWvilO03WFmKOmuebthpmo9bNxv8vIb4rcVumibt/gfpW7/wA+Zv9lX71+Jx12zq29hRWKAOPsSfBfibtKXTzgTLfPGXyUWw9k59hI0slIGauXr91XVyEL9Rk36sMEyWIjKWP406/7mwiK5PmhSCpUXNDzVVpcYVyPwJwNRwzyN3sX6Wp2MRjts0ybmfeobaegtUqYW9zwhh7BxM4Yb3SxwcOCuhfNbNjMspyENzEdAGhfEtCdrp1xJkUiKNQtQDGnHJrdiXgCoCoT3LWiNs5yA3SCs1PFXtArQqu0YrW3L/pLnh4WdxkKROUuAVh5qfuvz6Ulw95wmv593S9fwl9nvBfbBZ8pW2uiqBGlgb4ySf6aaJMNiRrkAFOS6v2hsnUK19Vsruez6itAkFrU7CHqjfZmgxxFw0IROaL01rmEhfNKc9eAMTE7LAaliawMNOHwd5feShSQONAxbeiXt3MVi+K+FeppxkVkUYL0K0TzPbrm6nnATOs7FyKjAEf5ye9nJElXoGOnh2y9CWLHE3f6TvoKMpGHZqQ3N/ctOvU0ZVnyH3wd1QRdfxRFxc7dcilWo7HVyoO5WzMl1/jY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kiLHCPk3PvKy2BfyOQUIVAAs1muIYkOqNlysIGqjv7/mrks03hTHXwJsNt/I?=
 =?us-ascii?Q?zwFY4vQScw9sXsd11VcT+/TEs0QTRg8WjUC5eYtoTdRdQiVZBdwibYyCwxVD?=
 =?us-ascii?Q?xPirXRsGWmfLonAH85A1zgQoN48+388pcPwP3+5r96TRte6aFOCDbZjhjeg1?=
 =?us-ascii?Q?IAtrhJO1QXLBn1ZQ72Iu7xFUi9GJnpC3YpPlK8ouJ9BiaCbkLeERCGZlh2Ur?=
 =?us-ascii?Q?CYqkdOBOKeSczAteQs+AqUxGII5Ns3uPNBeh3Odg4c5oEUuv6LhnQsUOVngW?=
 =?us-ascii?Q?m1DnOBu8WJecA0MyOJPAl3tAH4Zc+wdrZzJRZVZtPBvGmUYRv96LlLAkk8pv?=
 =?us-ascii?Q?+CU7iLzwJUj3imP5lGwY7rFjrP9G9bI0xzdbb97xhirWBTD/yBnsZzs1U91e?=
 =?us-ascii?Q?lz4LqzAu4JW759sbXmJvpQqdtk0p0oGCJspssyUr9TrDIf1gqVeualVxn+wq?=
 =?us-ascii?Q?HHgcxfYuCn0UoXkPU4dZES+7Aeve7L76rZMhSpCex6q5SrDKcE4M2OlRu0KB?=
 =?us-ascii?Q?ZDo9gRD0q1CxRxJAokhtT7uKefr3kS31m2meTbsQJCFXuEThLy1kZtuCQMBB?=
 =?us-ascii?Q?eqCU+SK8zpp2tAv6esSXFPI9i/x5847IjflUtuaOv8+8zBVsE413BO4AWlmY?=
 =?us-ascii?Q?HtJYT1oVSsViIGaAWkh429z2Jlcc9RKOFzuW0hIOH19Oag5tsApAbcYgnm4Y?=
 =?us-ascii?Q?vJE3cD7X26nfEyXXXdSqVreol0bly9Kfqej12LQYbD0s+TgaKKsraEoSv3t3?=
 =?us-ascii?Q?es8ozq7NVCB/gU0LIIjO+jUaQ2vgVDEPdfNTMzV2J/Dc8bUpKllAww99ZvdX?=
 =?us-ascii?Q?fjA2uE2WZR1CYsGCHOw1ABOYNIzdHUTGX+ctOHkXo/xI1PFzURaBVuRxhaXb?=
 =?us-ascii?Q?o/JL0ni3D2N5eBZdi6uErQ7X9AILnoYaGJyD28ooEH2o2LdWnzKM+vipuoST?=
 =?us-ascii?Q?SySwZ4yLmvIJTMl4bbSaBlQbDjDrPXhJXYrMnBsrdQneEcBbNOtKDyqu12CT?=
 =?us-ascii?Q?J/BI+5a7iieo35ZwmrNXjzVX/sjY7e84fK/ufO70kebYTAIaJWMjkTLkHNYI?=
 =?us-ascii?Q?uc7t8a2mHIzKWjCeUq/PP7bhT+1/rdGjTkeo2Xen7RwkhF8CtGjtMR6dwdcL?=
 =?us-ascii?Q?3vUgWLWPynyTD7P+GV080RS2WIwFwa89pOaHMUPUJEov/wwY2TcsYa+L+HLo?=
 =?us-ascii?Q?XBwZVNd2ZRm7t9upRT9EGlR6MtlfAJ87Eh6bEhFtqcGjwzwTw/l929eOWNUg?=
 =?us-ascii?Q?kXsB3CYonWujdxa18RAPf3a5Is+XMhFgBvx1CM+m3etAIK9xXFRPFRJkcf82?=
 =?us-ascii?Q?sFmJyJa9U7Y17u934VdTG0Lzn8miudLiMYYRg6c9287l41ZHlkkTnOFs8TOx?=
 =?us-ascii?Q?8Yl4PCWR5VIsn9pHm6emk4LDBE+K5beXM9U5TinhDMKVnTLVFLI9J3xRUFRI?=
 =?us-ascii?Q?U6jYgRv+ueI58BRtOhxzt1RTT0n8MoKFny1x8wYBbpk5ztRPk0mYHuIgYHpk?=
 =?us-ascii?Q?T0F4V9OIlD1hovroNo4t+PNF4FWMvtx3hje1shWNdZa9/KSR47qrxJZm4f0H?=
 =?us-ascii?Q?tc7qoAeCAfbj/W+dRs2eUY+DGO+S/8PG+NjRSgB09shQi3pul+hxHKZVkD8+?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c5ugh0aLIvnsWkClZxBtR9uQRn7obkZ5OQH4aNY/R5tIu0HyRqHE/r2SsAItYhbsOey1OzBdMg/X2QVZgKESyuXUM/nusi5uwU2bLTIu9YvBOPYY+iQzFoeWHKd2OqQGYl8msjDN/ybeD7pEiHppr8LVrxpg8LOAYcYBHTuDWfJmPo4V5k+Icpioxatz7XD4koyUBXljJsdOtht/nzjk6L/qB132lva973lZZV8Sm/YYUTCmLIt1RYBF92WsHdoyfNJWYjZNg/4f86EoQaGM4X8GvT73ClcPlrXg1En5SQUhJ4NtfhV9+9f4Z6lRJcLDPLM8gvTMJvAbu4eddX5B10VvXhS3m09y7p2kQOSFohDg5jqJIOfC0miUwM7++AoVUU6b6fUtDrrc2K+wolSCmupbgNQUtnAGE4zkB5wUk7A6E6buBFQGdiC4xE5hxr2GYYAraoi6WNGEUUj1ylidjzZsKUh0H+7LcFiZ6xi2k57XI7+PV/ODZ4GH0CgRRFILSM5q65sYrlR97Zk8joLgWjMaXFXwLwhl3s5xq/uXpIStK3FfqczNGD6wZRRPVGMsVK0y6MzE+5NsEXoYShNuVfDfjm/WqIof6W7FIU25tRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fdea99-987d-4bcc-b580-08dc41d4afdb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:08:11.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6xhgCGicjYmltBjktJxtJIJ0EUq73fOLtF9rqM/Zu7QVi9P12ap5BN88gVauW7QUfy0M4i/VjNV9e+eM+OxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=861 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110107
X-Proofpoint-ORIG-GUID: s9VaQzFwenOcWoeS7tWp8s1SsuDJcqi1
X-Proofpoint-GUID: s9VaQzFwenOcWoeS7tWp8s1SsuDJcqi1

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. The backported commits are destined for the
official LTS kernel branches so that distributions can easily
integrate them into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v6.1.y

Patches that bring NFSD in linux-6.1.y up to v6.1.16 have been
merged into v6.1.81. I've identified a few additional filecache
related fixes that I will forward to Greg and Sasha soon.


LTS v5.15.y

I have updated this branch to include commits from v6.2.16 through
v5.16, all applied to v5.15.151. Testing has stopped while I work
on the v6.9 merge window.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

I have updated this branch to include commits from v6.2.16 through
v5.11, all applied to v5.10.212. Testing has stopped while I work
on the v6.9 merge window.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.

-- 
Chuck Lever

