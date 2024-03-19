Return-Path: <linux-nfs+bounces-2397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0C880068
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 16:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07A71F22B51
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863D651AC;
	Tue, 19 Mar 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOxUGbX8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTg1qFxQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2A62818
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861516; cv=fail; b=Sw6/+tq8sWtECe1h2slHprypMTKtZNObJxK0+cbZ4O8ymdD+CZrA30siufuToQI6fuS/zDr+Qupb6AvuvPjSMruumaof8dbDoAFo6WtgPk5CDSNgNik7K0/huiGo5BY+03Vz5FrKnYqIYQ6h/laQqEmA/N6naESa8BNyp6n0HIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861516; c=relaxed/simple;
	bh=JXWjK6hrD/WichKanU+LyzbzL/nM7/X3X604DUQhFhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XDG1tWcqj24Jy9++v209pdazs0ybvrLw2jo0bcbz4zhO1z19qjiXISNT7daJxuqS/yPkwZJN9rYakyhYVjCGHeftA5Lxzj4fWN789Fk9iyxU5OiuazOp4vwSB+1+qtfXZnrpYC5+ZBmGgDAPt6Vp8ucXzs+gZvk/UimiItU7oAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VOxUGbX8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTg1qFxQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHJwP005091;
	Tue, 19 Mar 2024 15:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=TYseM0kxNhhG4Tjeqtkvpy9B4VTqUeAAuJ81Uh+vln0=;
 b=VOxUGbX8GjYrfhLMr+xjQIMt7+PZy066jUePMkqrn5jzVyanP7houAAf+kOoeNMHZpLK
 vu1lF14tnMhliMYNRVdl1qze/w7P+SSbgFtXB/t0hY48oM3rhuzJ2UBP/mhDYJdWdnO/
 +8oH9YHyx48jJxMiLAWwzlu9apKw+6lUlMcglMvT8Brw1DReaUEjGPJi71pkqp/s8yCf
 WtQgqKU81ILKnnMzM5i1RVyeDZ5kCiq2jixBvICru4XZ3TkktAiKsNr06u72GaJwj9PV
 YMUgJKuMHkhcewVcbvyNkebN5zrG3wbqPMUSLZTSYvAYZ+2r9u88ASrxMMhKLvoHLquf cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tnuj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 15:18:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEf3KO007389;
	Tue, 19 Mar 2024 15:18:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cyhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 15:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnsfmZD/m0x7y9Lu4kN1NKtgYP/samr4kj6/2uxGjEK2U+nuLYoeV4g6BSNZr5WlrhV5quhqDOHRDaA3HbG6d4KlYiXSg5I5YpED29d9xwFRnWb83imzMVU3h9ItQHUROt6TUXdn5jE2mhg2+roI+YJEBMwUCxk99W7HxBY+W9pQEf6/KdjfupZX40IHE8ckuIIhlYfkKRRiImfPY3cqekLkzlTdlcJ8jLKMfJaL56WApumY7EOBKa14ZRSM2pQ5HL0qV7xbUHg6jAiAkh1a1lQ279bqU7hKWRA6RWDp4AEfqlPB+vXcJ8sWayEvuOenMbsIjfqIBVt/swK+s1ED7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYseM0kxNhhG4Tjeqtkvpy9B4VTqUeAAuJ81Uh+vln0=;
 b=a4ypldg2OOBoCAgpUMw9vPZTU8Q+jLsSyt1h4s7Np2MpMaF7tgnwbHVUJmXJasANuYBW/AyRMtArSue0dnvS/nC33GY7GeQCkdc4GB94y6CdoBvKGXXdNNirw7J3bW4RhgLGxBBfWAszPfy27BDOV/7y8tFiBkwFGPWbDEpQjw84LWuvz8ScJhvMpIB6+2oPlv3Ck2tDIBoMuRno1tVGMuPICw30txq+ye3deUrMmCElLwsJWmcG0eTqsEbSDT6yC3cIUfWGOiOCnANvz1LIFfB0NLMSJrTDJpfUVf0BF0/PZKEKYQqudI58gsuG3Tc0qnNnkhRI4+mV7VOdQFtHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYseM0kxNhhG4Tjeqtkvpy9B4VTqUeAAuJ81Uh+vln0=;
 b=sTg1qFxQWkOrci8QzKiKhLVKDzBYKhXsR//yQe9LKOSyqcX5ragAG+LRVfhRpB1Eq4Um7VMBT60pIwLP8aXLXwPVNztrUazylZICwSZRKnXGfu4O0uLHZPWt1nNwVDDKkuFGwEqLPQEIkrqwC/2Pgy851ZSGBMBaTOS7faxnRmk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 15:18:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:18:18 +0000
Date: Tue, 19 Mar 2024 11:18:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: Fix error cleanup path in nfsd_rename()
Message-ID: <Zfmst9GEpKwVVTaF@manet.1015granger.net>
References: <20240318163209.26493-1-jack@suse.cz>
 <ZfigId5Anil0U3cs@manet.1015granger.net>
 <20240319135354.lyvyc7kvihp3kmt4@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319135354.lyvyc7kvihp3kmt4@quack3>
X-ClientProxiedBy: CH5PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: ed05490d-1aac-411b-7f5d-08dc4827ce06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3RH1WrMfgzwmLzfNnnrZ5lJ6Mi8NVrmGoKJWDclVCRlMyQZlwKgvR6qTY8/6d0BP1KJv2eVOHY8ttmCxBkJy/3gykoC9wdcPb3lku9xVaDAF7aPsi8FklND8s6cHhTfM+uWA/bsE6wRJEb+ohEIaOLG20EnKOLjvx3BvsY/rvbdWpPsGuV++RVNWnLDD4r34gSBbugBO/BqwRmIT8/oJ3rB5U2lekMYEQ93LyImMjZJM7i74gEPVMCzC0KbSBT1NHDoILoURpmdiKRMEjeO2UCsGnYMqKzeW04Ld+DPsbJygiPfEFbtHgo1v8MBGm8ohk8RLOXuMEv3oQS6dPJZpwF2LQBhf0rk8Ox3n8IJV/K6iWfeq+6IJMfrfIrKoufPoiXHKgjgEboINety7iq/M8/OBL/zRNWbL/M+4qeEgTDSVzUZGVsdjgF7nU+6qZz9owj8GSimnde2hUxNpSImNfpJdkXYtxie/EWU5V7SS4gDhzCRU5iIKaDKzMq7oZwyt8AySe0lege5UpUAbo/tP4GOzARz3Vz8rO8CcR5UyuMBiVroX7Kh3h5su782QZ8eNnHSPJDbgfWNpFQckeeQbCJxOqfk8nikpNlEfWdXINuobZPsw6b+P1JxoP3eFkdlVyyzqilpwkJWOVC7k9k0ncjtc1bzkVs4vKYP4jch+ViA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Suikckup1dUDJBz7RsBy8/xB4kbm5DbZqpTwVBDcAyE85pFlc9XIQHrOKqP5?=
 =?us-ascii?Q?90sFsDdf2jMfZocP4XsO9eYE4p6WQwGREu3PW+/19RKPmEJfZg4wVC+ayLQg?=
 =?us-ascii?Q?MA/Txm84z/2kHEX1lOfNtuzzbbaFDA5SF1WaxlHpURXzed2Z8J7lxkxPTvt6?=
 =?us-ascii?Q?gtC5MD0EH9FAa/5ZWUFOYBy+pxtN5bl6/xSD60PobTVERnGJIyEOfmzcbIEJ?=
 =?us-ascii?Q?/I6lAK6oncfMDPai3/ah8aLsH99V/5g9DnwqYcP1sFKcKkYL0zlAk1iZBXJh?=
 =?us-ascii?Q?CA1NGSetzqDJyAsYjyuPqWmMFpPHlHbMyB/JP/gDrEiHJowIjrJ7ExS1eCzB?=
 =?us-ascii?Q?zS5OLmIMGcl0LZRdzvoq5hDKay2qWuNmsDtEe4RGZm/4ILOG9II5mNmgnPw+?=
 =?us-ascii?Q?u1MXMx6zSb1y+T/5ZZJiy6V8x8vf/9M11mHVukOWNp9cfOyGDIdU3W1U6ndH?=
 =?us-ascii?Q?6B9RI6RdhdsroKRwukxv39njOeQZvtCGt5+iVZTmrIYuQ9Uke7mbn0nCkits?=
 =?us-ascii?Q?h5QvqFwqvz/w3vqrYnKBNFbHrJi92RJwH7/TVbpc4L7OQFBgj6rK09CNa5te?=
 =?us-ascii?Q?hsy51b4qNYPIvWuZnxET70qj7CGsIuKHxUg7HQtWfQJwIQX3dmItPv+RNgMA?=
 =?us-ascii?Q?/ZZxEv3eRO3VWAdFG4d+ed6tEF973b/G33t3ewUYxKy1o0uzuA92lFiZSwWk?=
 =?us-ascii?Q?bNp+K1tU8ALbsW1/Lg3kWGWz/eUubOdHOQcAZWWlqkham2VTkHEVAi3nQLWK?=
 =?us-ascii?Q?6eUcFgb4imdSrV3ue2x/gAEJbzwFQAEg2P2FADdU0aHriSEu7lhYPNYOEpAj?=
 =?us-ascii?Q?nUg8E8GThr8QRo0Wggyy1UBlKucTPy18Kx2LnT7oAguKpt7Qngoa6pyobbiJ?=
 =?us-ascii?Q?igZuX5E/5WabIzDUUd9krFW+y0Qe35WbSW4bWmy5WPsAlH8ARPKlOzJO+TGH?=
 =?us-ascii?Q?w2Gy54fwjyH7KGfJQkfhRFQmxFPgxfQe7ew8mInhsAD/BhkQQE1czuyckfhU?=
 =?us-ascii?Q?5enaznf16Anr/t4crCDNrWrUkz+WRvEvgJ3cqizSB7+8jubFndu0S4sEjiS9?=
 =?us-ascii?Q?ANkj/cmDAdxV91EbcKGvSstYSStnNX8nJCChNysQDQHiaszp341oQzEBbaz0?=
 =?us-ascii?Q?MRlMwWpHklVF61IHNYwQA8KPr96bBxDrK0DEG+lpAvnvlu0xxWqkq7O/+3wh?=
 =?us-ascii?Q?FkWRzEvERTdWNhKMG5yv9/tbsmeZrIKml6urGFBeIJrja0DSpOQTXdmBB38K?=
 =?us-ascii?Q?jBk0bxrT6s18r1B77Y6GP/lx16ysD7uvFvwX7ebGIunCO09D+dmfVU3liTim?=
 =?us-ascii?Q?meMUgoBM84IL3f5KRiht8D44wyDSfnMmjpKw+lHGCiNtCKqsdEVmgbUiHHHz?=
 =?us-ascii?Q?5E/q4US0XsH1dpeEnAExaUP+yiJTWZhumzDkGYuo9nHes/ZBzwjY0JqcC2uJ?=
 =?us-ascii?Q?3YyCdnwtCtdUKLdTHtV16uDX+7lp+eTK8ZImu6IY/16dDgWZ/FjREOqfFsGM?=
 =?us-ascii?Q?UJlQ4nSEopsBuUcjtIfAGvHzAhUgY7bc3MeMqYbdbcS4Y/P8ryLTItwwxzcX?=
 =?us-ascii?Q?YyKBpAkzeujC6ZGTPXn8IwLGeIEvjRRvijLX0gYaqz4Z9h39u+XAb65FUC/I?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JBmGXob+ZRKhrZnE88jefcxJcIOIljTwE/uClOvJgscZ7sUeuDCf5gfUAz1Sa46dTtrHDwBfM+cri18C56GOsvCy1Kyda9LKtrFPCL6ObQhdxxRF5diWt+I/qv7S0JVJe7poCJahzYe6fH4luxQugt9cP+vb22SGslNayDJ5s06N1rIJdpZ38khDYKyP+Vz3hi1+lpARD9qRoMVQW1nR0WMXX2Q69/AbRHHqNEg5TJtmYa4Au1uaRjSXsswc2XsmfMCbQwdv17s1yuYmvNS56guVJa2E/8V837ICqDEsd5IOkJcdLRp/fu+M6zMJ3YhV/3C3m0pIE2Zh3WSAm9Vi3LrtCb24u9RukI5TSGUcfKe8qTo6YWZWOWvPXE/Gl/eIThahWdKneKExn75g2V1UHZW2Efyb4tVcTN/bn59T9I1HigX9w1oTt682nyC5J0vvHlXi//2rbJdlXAJSHQHsKzjMGgRYfcvkF6P6akNyTIQyQzIFt2K2cezWSrvyHLgaW8zpOyCvoXbVW8HuckTesEq5q+tP+O+vPkFVlJFFyeaqYBtehNGRnY7tKJb99AnI7iEMV5n76eNoBN1W7Sj8PubsolFED4HxE6pD3kZCyw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05490d-1aac-411b-7f5d-08dc4827ce06
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:18:18.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECF77Xjc9GhaIywrRQ/+QDEgzmu3W3Z4HENP+Y7fyQAVM/psSpG55WrudZ7aZaxPACYHoCV9Hw0T8dP6+iPG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190115
X-Proofpoint-ORIG-GUID: 9H2hU54y1L5XjY0mOMU4rWC4bN0vSkNp
X-Proofpoint-GUID: 9H2hU54y1L5XjY0mOMU4rWC4bN0vSkNp

On Tue, Mar 19, 2024 at 02:53:54PM +0100, Jan Kara wrote:
> On Mon 18-03-24 16:12:17, Chuck Lever wrote:
> > On Mon, Mar 18, 2024 at 05:32:09PM +0100, Jan Kara wrote:
> > > Commit a8b0026847b8 ("rename(): avoid a deadlock in the case of parents
> > > having no common ancestor") added an error bail out path. However this
> > > path does not drop the remount protection that has been acquired. Fix
> > > the cleanup path to properly drop the remount protection.
> > > 
> > > Fixes: a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having no common ancestor")
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > Al, Jan, let me know if you'd like me to take this through the
> > nfsd tree for v6.9-rc. If not:
> > 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Yeah, I guess taking this through NFS tree is the best.

I've pushed this to my nfsd-fixes branch, and will begin testing.


> 								Honza
> 
> > 
> > 
> > > ---
> > >  fs/nfsd/vfs.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 6a9464262fae..2e41eb4c3cec 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -1852,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
> > >  	trap = lock_rename(tdentry, fdentry);
> > >  	if (IS_ERR(trap)) {
> > >  		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> > > -		goto out;
> > > +		goto out_want_write;
> > >  	}
> > >  	err = fh_fill_pre_attrs(ffhp);
> > >  	if (err != nfs_ok)
> > > @@ -1922,6 +1922,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
> > >  	}
> > >  out_unlock:
> > >  	unlock_rename(tdentry, fdentry);
> > > +out_want_write:
> > >  	fh_drop_write(ffhp);
> > >  
> > >  	/*
> > > -- 
> > > 2.35.3
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Chuck Lever

