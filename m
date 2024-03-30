Return-Path: <linux-nfs+bounces-2569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D5892C08
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318591C216C7
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995553A1C2;
	Sat, 30 Mar 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amzb8U3n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dCM+FAPT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D425740;
	Sat, 30 Mar 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816043; cv=fail; b=NxcaHUPeBGERxDAS1Wr3XFeXRUUVs8/HbMSBbP6TuaiuFxucw9Y2onS2IeI3rLDuzsd0wvOB8F9R12LG1eWN/2PvZsk2W4yMwkmKF35jr/k0aeXCQHQMNpOOQNnGcGE9nRkYdcRV4circyHWg+tVliAZaglB5R6p1MTtTNEiIeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816043; c=relaxed/simple;
	bh=1jJAFpsCFs0EhXQ0ovlezz1pt0je6Jd1kcv3nF28ViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJRSQGDoDcTgUKZbNNJC01fh2/F5/jYiMH9xrnb6cY9pDRTPtReqx5IAWciemz0EAkhkDb0Grq2S6BhXivJ3HeGtpDZgwv/ACBv8JdHAmNsN8cUMp4QofK6iByaCRiVu5XcaM7WRoXExNEuPOkTY27+rQ8pWURYqed3xE6j7RAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=amzb8U3n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dCM+FAPT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42UFTGjC026814;
	Sat, 30 Mar 2024 16:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=YixjwsG2WRHBrSQAUB2D8DIGD/zIwW70xMtLrMtpukk=;
 b=amzb8U3nIwnYCiW6k8ZMhx0DnPzhf++kwPu1e98ADrk6+wNHGexfNCJzkI4MYPjc6pS7
 plPxaSXRLDZcDq6z/3zRpeT7CiPU9WITNCN8mEtTk4AVXV3gd4iBvwRzDzu1Nxy3L6f7
 ZSYHV1kr3Z3phAwMa7ZHWWlG36LgEsGdloZoJ54EbVHKxdWwrxXqSThU9MkqGuwu7Gwl
 9bXgLg4YfXBMJ38/VVL8DOWkCPrs7rR2CoZlwM1FeEYQVR8X90J+/B7WbRyetY4T07tA
 U/dMoQo5Zh8V3hiCEZcuw9McCx4LDrgKUnCjrlzZy1/DqACgQL/MXJe12nImpQKLR+up uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abu8exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 16:26:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42UF5oQH040392;
	Sat, 30 Mar 2024 16:26:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6963xtk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 16:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNpOJjP09UesNRWLrYSv8/tdjhhWW1umo4Tq+F9AZ2qWV/WlUBtL471iqhmRNHwaUhDDqWOJpR1keewANVhC0q/EOtB2X7vvluPuxexWzqrdNDtIF3kvPWb7FLS7vAGvbP4pB394MG+q2ZRUgOfKPg2oHaZvifJbe92y+cVh021ge9chuG3CbYqKuIBomvo1gAnfxJ13JelZlne96yb/BLcCN50AuW5u/kIDgDIwYa4wey7aydiKAgx2VSf5BR4dciVPHaZjwsELCSDWuoVgRhRVlxxWPxLPv83328OU/Kld7qu6X5N1yBfUB/OO/GkmBrsyhyCIoKrIOsA0gr5vxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YixjwsG2WRHBrSQAUB2D8DIGD/zIwW70xMtLrMtpukk=;
 b=NWrOvbqFDpLO9kNJ83zeQqOmmot9QIImMheb24ocyol4zaUnbPnZz4cfE2qvUXD6E62/YA1yuZ3S9o669LEaCzwEo2+jKnXQFFR82UQBT/H1bE41ZDKKC7A8+pf5K4lEYAsy5V98aaqH5mREh3VRLFOU4Pxs+exhSazr04+LB/49PTfWcAiIPxpivImg+OIZnHt0fySlnlQ9JR2Ckfx5eHTqlmyIf+67Qjmt8jvttwodtXSiK9sIwbcR+sXymntOW627qQILbMyevLylY+kwvdcGParbgcuYd29fjsPdrv9LrVsuAjFjRZMnKUOnDa/eG7YfPRr+O45vV/6LFAmQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YixjwsG2WRHBrSQAUB2D8DIGD/zIwW70xMtLrMtpukk=;
 b=dCM+FAPT709Tz3S3ZfRznrSDNunj8sHKWQ/cYYwzJvx5stmTewHXIhEQOiCquDzZV8k+zOB9IbADQ8+/6+Ld0OXbMSs4f9NJTV1Tr8QGdgtvBZX3KHTH6+P1ZG0xN63uVY8OuwX1B+8rOPDwVCuQT8+wQh1C0wNXKwqRxfImCwk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sat, 30 Mar
 2024 16:26:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 16:26:38 +0000
Date: Sat, 30 Mar 2024 12:26:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>
Cc: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Re: [External] : nfsd: memory leak when client does many file
 operations
Message-ID: <Zgg9OzeFZUTc4hck@tissot.1015granger.net>
References: <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
 <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
 <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
X-ClientProxiedBy: CH0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:33::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rWy4lCfUQvapfGgqewaNrmZkPFXhYR+mW3Q6PZMqML02HcNdUc6h0TWLlCt6kp8KSRuc+CIK/Wtv7I8w9nSTjz5XGsuohUlpnQEjfOoyBcMYl4+s9/edjmVc8fEEqRvJs1B7X+Y0roiHQhZc2AtqLn66k8pIZx2OxvNUeGTrwKHOGRcSCjWU8mgBfEWqDJr6uzop5YRhW7HR3+F9yl4kWNJBb1F6C/J1cBuvjzHtHAYzt1kYzq70CH0cv/a8TLp+UnnxPcxvT/0T1t23LCA8181c2Blq85FNw1Vj4T5ypH2rPDL7AeJJuLK/FlOawEkWHMBoL4WVe1CMtTBap4J/lr9dCcHkdjvECS6KIu05FNEm9s6DmMxE/LVpN7+G+JMjPTJ8qcCFGX3E9cqybniD8ro/ShUvHNyJBbnWbZD7tdORk87aKF5djM0ptn+zB0SO9KS8om9TYQkmsj6EdXvqHd5yEZ44c7kawwwomfoFxj3s+JX+WcIWkPkzsn3aQjPm1EDCdD9aWdbE3Gik2qjxP8Ii9ytKgxpElDo8P/oM71caijTFhmTipTEyxrsy1TSsiEbTK9KpMpN+5qWYmoR2jddkh8RiCJzjZV/0gF94IvAprvcFxtmR0111sgupJ42XUO0UBHeZczZxJl5hFrCYddWDTgOUkDxN/8eurs2wOJo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?06upQWKLBnDuQbOc9bgoeFn3ZtOSUP8Og9pCbaEWyvUqibPaRJQJJ5NLd8I6?=
 =?us-ascii?Q?Ekk+Mf0EDUBWk9VU+f1lJ7if/iYAg6zXmhYWKY8b6eO+oSuy6paCk4Cbogz2?=
 =?us-ascii?Q?8iPvDlSlnHlC1E48I5iKjs2SlgShl2dovU/oOOCU4nrPJY5I9ROPdidTF1Px?=
 =?us-ascii?Q?7aPJJ+o46+tu07z71jGTM3IF6uyE08h/s8ASbL88G0N7jOIhmWWA438hahIx?=
 =?us-ascii?Q?FjL5rX3pJlEpOPKVaJHu+og3z1Acl9hbENzEL88HMP4fSszdxKZC32TtJK2T?=
 =?us-ascii?Q?RbAh1bLQD38YRtMM7NBo657Ln6e6QrcG6cgE9S/qqinBUXJvLFXHRxRgC3+1?=
 =?us-ascii?Q?WpQwuhP3r+RpLhOTbDqG9fEfwgnZ10xfl4ghG4qNIby9imjN5JN2FNxAyASB?=
 =?us-ascii?Q?S8TAD9uuIVCMAaVOqa3SvTDLKp3C+CNXq1orODcVXao2XMWjg/+Ly1XlkuqM?=
 =?us-ascii?Q?7WKL4nt4XLeExgrJ8r/FXd5Rl1IjIwoiWigUPKiNgclyCb/Fgl58VjQHPi9b?=
 =?us-ascii?Q?zDGqjJaQLTMjO5XoNaNKUmu3QqEhFGR/Jrw1zyzmii/EQoaaOcjRyEwWmrSM?=
 =?us-ascii?Q?Y96Bg7opoYhi9oaap7gPJlqQs9FlHrEhpegYWzylSWyTesUoADLQ6rBjmIm8?=
 =?us-ascii?Q?dZZZX5JVFZLuV7XxezQLpKA8/n6o1h6H09DKA/Mls+5YzdSei2f0Gu3tgxox?=
 =?us-ascii?Q?jE9fCPQ3ynwfam2ElbFI6P/NRLo4zHyqLe0KCx7Mxh26g5EcFvuaszYZGqfR?=
 =?us-ascii?Q?z6MuBidu7cmO+2Xj5uRkVhixmi5ALtCW7UHL/fzVo3eP+t00tin5bPZBwD1j?=
 =?us-ascii?Q?/ya4g/L523I6kaENOkZ5zL6X2Uatl7Wr+anxl2pdvl/8jnbQLN9ws83PKRNU?=
 =?us-ascii?Q?TlLGDsYZ339HkmrKIGzZAErANxtjrFBD7Jsz3pcuZME64WztR6mAwkDPahpc?=
 =?us-ascii?Q?xBULRm9eJyAVVEyWNRLMTrUPKD/1F4CbMtImCXcOa3Z+xAyI8bTE+ZUAPnot?=
 =?us-ascii?Q?HblPYXmYvz+hlTRh+ohDc1NC4PGcxmFA6+1dXoOPfvfNVLdiCz7BOQWkTVdP?=
 =?us-ascii?Q?uN2S83d4TUvBgb7VU49vT7VH6pDA/adI9MI4GC/b+87Fy14fDnJk+v5WZreJ?=
 =?us-ascii?Q?sqorzMLAI5J5HSqwZTso5WmOWtA1E8ZyivKADJf2DrN+iQ2TpjnzrRfaVR4k?=
 =?us-ascii?Q?rU1n1YFm/Cfps3iAVxe6W8dDoqDgO+bkgx1630uAOj9jBAKNneNqV3b2kVE9?=
 =?us-ascii?Q?JWalarPcun03AqnNwd4tBhsIjk2P9BDChFvSxqk+oc/Hz6trMiv7wnnHuD5F?=
 =?us-ascii?Q?YmUxfDb75mDXU8bRqUjnxf2BC/yfpozYE26TK4CoyXoeFElujREBcvM9mpqs?=
 =?us-ascii?Q?ZHo6Dlk/dsVzrVbscIAkKEJ/RORlpKq6rFwnbsaGXm3DrBqsJ++otBbIu3qO?=
 =?us-ascii?Q?SFv47PaQt7YXeOmIZvCsNcJ1QzhY/fFKx+9YoiOLlZeRAqRMLlFhb+9D+4Bf?=
 =?us-ascii?Q?8LYG1XWtpl0DftyWQZMUx9j4+mxzMz3g0pPFASYs6Vq112emmeEcPhbEMfc/?=
 =?us-ascii?Q?+45mm55VIY9xAluizg4oCux1uBaA3GVGmwYazrvSOaDk1ddSLFjW7EaUxOmT?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7r6QwW7/bTS+SiFWaosWErb2xIYuMe1XTxRgHzppiAOzlz73dEafzCnzAg3HinKN/N9QeOzvvv34rhDfsK/HPvun2EWV2e5RkKsqKzY/39et9IrclCO8o2Ar2TBEnkkBdusAemkBJU9VOaoGg33F0QKCtN3BsutpPn4Sl2ngLxBR0PM4/AcAKlTVfGFCBDqSKfUJ/uDfam7IEuINATczZ2ivmgVhkZ2cppCtvWpIst4PiFNp9g/0BDY5shTJdZ65OZGhWJY2t2WxGK0Ieq4NzDX3q95FbCIv36dYwG197IMUeShj6n4yW94mXCCY51jkjzvfKYGw/XCemUBem1Q15NuSvQt43aTlnJ+fUgacsI+Zog8XzuvYWc48pGMMZEyjrnfyLU+R+X5O10J1upVxTDkNn108QypOrC8ldP5pjbKy0CkkRec0eI4G0T8tub+3j3BADDsorjaHtQZ9hAMunsLEjRunJZaqbKXxywL+YQsy2cL2h3b6MrJnRSo9K6llT30S2AHuFCbWIOgOi+GZDfD5+FPMeKOwn4/gBfGAOs5LGziUxbS15Km3ObfKy/pDrAoNsj0ivF0oiNS4WWELTEMZrQskhPPPfGmnby44X+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef65959-5167-457d-34e8-08dc50d62cc3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 16:26:38.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udFpAWtnjNc23OQN9DnRyK+dR/OdL/bYGo2cblkrNBautecixsCl2oO4srZDp3as4fHl/TkVzDPADQPZuY+ICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_11,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403300134
X-Proofpoint-ORIG-GUID: nk0UnUne2m7iGUfGtIu1WZM9-bdUeBhX
X-Proofpoint-GUID: nk0UnUne2m7iGUfGtIu1WZM9-bdUeBhX

On Sat, Mar 30, 2024 at 04:26:09PM +0100, Jan Schunk wrote:
> Full test result:
> 
> $ git bisect start v6.6 v6.5
> Bisecting: 7882 revisions left to test after this (roughly 13 steps)
> [a1c19328a160c80251868dbd80066dce23d07995] Merge tag 'soc-arm-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> --
> $ git bisect good
> Bisecting: 3935 revisions left to test after this (roughly 12 steps)
> [e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> --
> $ git bisect bad
> Bisecting: 2014 revisions left to test after this (roughly 11 steps)
> [e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9] Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> --
> $ git bisect bad
> Bisecting: 975 revisions left to test after this (roughly 10 steps)
> [4a3b1007eeb26b2bb7ae4d734cc8577463325165] Merge tag 'pinctrl-v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> --
> $ git bisect good
> Bisecting: 476 revisions left to test after this (roughly 9 steps)
> [4debf77169ee459c46ec70e13dc503bc25efd7d2] Merge tag 'for-linus-iommufd' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd
> --
> $ git bisect good
> Bisecting: 237 revisions left to test after this (roughly 8 steps)
> [e7e9423db459423d3dcb367217553ad9ededadc9] Merge tag 'v6.6-vfs.super.fixes.2' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> --
> $ git bisect good
> Bisecting: 141 revisions left to test after this (roughly 7 steps)
> [8ae5d298ef2005da5454fc1680f983e85d3e1622] Merge tag '6.6-rc-ksmbd-fixes-part1' of git://git.samba.org/ksmbd
> --
> $ git bisect good
> Bisecting: 61 revisions left to test after this (roughly 6 steps)
> [99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f] Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
> --
> $ git bisect bad
> Bisecting: 39 revisions left to test after this (roughly 5 steps)
> [7b719e2bf342a59e88b2b6215b98ca4cf824bc58] SUNRPC: change svc_recv() to return void.
> --
> $ git bisect bad
> Bisecting: 19 revisions left to test after this (roughly 4 steps)
> [e7421ce71437ec8e4d69cc6bdf35b6853adc5050] NFSD: Rename struct svc_cacherep
> --
> $ git bisect good
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [baabf59c24145612e4a975f459a5024389f13f5d] SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
> --
> $ git bisect bad
> Bisecting: 4 revisions left to test after this (roughly 2 steps)
> [be2be5f7f4436442d8f6bffbb97a6f438df2896b] lockd: nlm_blocked list race fixes
> --
> $ git bisect good
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [d424797032c6e24b44037e6c7a2d32fd958300f0] nfsd: inherit required unset default acls from effective set
> --
> $ git bisect good
> Bisecting: 0 revisions left to test after this (roughly 1 step)
> [e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4] SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
> --
> $ git bisect bad
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [2eb2b93581813b74c7174961126f6ec38eadb5a7] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
> --
> $ git bisect good
> e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4 is the first bad commit
> commit e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4

This is a plausible bisect result for this behavior, so nice work.

David (cc'd), can you have a brief look at this? What did we miss?
I'm guessing it's a page reference count issue that might occur
only when the XDR head and tail buffers are in the same page. Or
it might occur if two entries in the XDR page array point to the
same page...?

/me stabs in the darkness


> I found the memory loss inside /proc/meminfo only on MemAvailable
>  MemTotal:         346948 kB
> On a bad test run in looks like this:
> -MemAvailable:     210820 kB
> +MemAvailable:      26608 kB
> On a good test run it looks like this:
> -MemAvailable:     215872 kB
> +MemAvailable:     221128 kB

