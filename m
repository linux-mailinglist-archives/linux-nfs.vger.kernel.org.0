Return-Path: <linux-nfs+bounces-1275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1A837735
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C5288117
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4E383AD;
	Mon, 22 Jan 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUEhpAYV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4DkANtW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A291D6AC;
	Mon, 22 Jan 2024 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964333; cv=fail; b=M+D6Fdi7Crlbo1MRQOiGu/KcLhp3DljtPTm3eCgpNRuOuTUif7veClsvIcdlrF/F5zsGOX5kLvYQiGZMwaBRVoFl6PVgIybkztbG9b9Vm8kI/tanidxawzKjFOEusp509wVfokoOGUyf5SkxcmyxKFE6hsBlaZJN5Hp2DTd6XdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964333; c=relaxed/simple;
	bh=jFvz5AbyVX6rSxolVEPRZ9MND/Wfgots629KzrObzvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5ijzXxr5s7ZxJuhgmUSKui6Qgi4GC9+M3p1VldNzeN7gMZ6u3qidikaJKnr3+2GkLp7uVwWHoEyiMD9w/2zis2JOlYYK1Nh7ceqoRv3atcgKFJAmwRlLsxBmboD2fk/bj8Zbdsw2JgAzvyk9rtoJHADfLmyncwizpSOBWpdDr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUEhpAYV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4DkANtW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoiJv026562;
	Mon, 22 Jan 2024 22:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=V3KI0g8IaBEJeafGO2Ex8rLnjlEUegmuRimoVMa+jZc=;
 b=MUEhpAYVc0vRE9DhmxgzE5Qy1CzENEs/9vGDwgGDASbv+7J/H+lnHPPCD1bicREmI0BK
 jNlsITtlQlzaKofe++QBd+pKWNxPxJNZHrx1HHLXYRswi+KjCGehQBxshRuACGFANg0b
 PkZ29xru8Idar4ivp4ko3dS8R5/lMeuhU82pghUOJxRjAYdzkq1m5yss6X4BNRDL0v8v
 7tzeZvUNZwBeCs78Z/SjzcCibUfM2zzdfHnLGUzprvFXBq/1yiNsisu1z33OsaNElzcm
 gsuHHE/RvVkpfJsoqvPQ4GfajLWWYxF3QbLVaG/sxmVGemDX5x+2GuKOlwOkmG6wejeW MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwcutg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:58:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMgZkq025307;
	Mon, 22 Jan 2024 22:58:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33s0fbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7UXaZ+L4gwQlb4oUV9GvtF8EVsH7MnbKI2e+992tMRAiDuJkWbpnVf5iHsuPzkws9Z3i8IvMeM01HWYPypXgVNjdTjFVZKgRHc5ReYWevoFYYHSwJ+xx5Eafnsg7Lb9Q8Sxge9doiqpjLVbEzN+XnO3LJk34hJpKcUkBaiaD71IR8JvC9UcGLmiAu0E9MtbVcv0OOu/gejuhAnV2cSEagDo9Jf5CFZeM4qFQ3x9dNfnc+5h9z2aBmFOPnZe8NlNglXppxwi0EPk2Q+jHiKxtvo0+Z8cudfZgCa8mvhN9wc1j34dh7NgCr+qpTkYtl9/K3OkR6/JnL8IMzmtY67ZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3KI0g8IaBEJeafGO2Ex8rLnjlEUegmuRimoVMa+jZc=;
 b=Jk3YRWpKHv/3kM8dOrBuM+qPyavZ9Rdo9ebSTe3mxaiBXNCOMHiReLqm5ydUHvDVXAoPPOEO0YuZLf4Gi8W0n6h5B9Up6NkzIOcxLG8WgSQJJ4qi0tgXgGIh25mQJUvtas+BLjwuxc9NkmefUv9zQadciRnARE6l8zkUTroPJTUIoJZBhg8WdQStsKEBDt6APAXtr2SzWPYAGT56hlJHvUjL8UGcUglW7jAv2s2nADtrhvRPayYJ0QoS5dGSC0SIjUpM93yIVzlVJTR8IEWDkP+hIWhFsIAGN32IwFxUXeMsEmZ5aPWkEswxPbU4rG/gRwleTW9rL8oT71j2RwXPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3KI0g8IaBEJeafGO2Ex8rLnjlEUegmuRimoVMa+jZc=;
 b=h4DkANtWG+otkNW8DR7R0N74njqapyP3D6SN5X/gfE3K9JyL6YGhJkJbfsPVxML++4Pw46xsIZUwp6pgCzKwZZEWB9hYvc6/6ELPtYw7kkxEW2cQUi9o7WYnvCLQk9fNnpcRwiAlYPZKmHM0cFkKXScls9cEbPuFXVYrLQSbjUQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 22:58:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 22:58:41 +0000
Date: Mon, 22 Jan 2024 17:58:38 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <Za7zHvPJdei/vWm4@tissot.1015granger.net>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170595930799.23031.17998490973211605470@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:610:118::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: b8759d75-be4a-429c-fc2a-08dc1b9dad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lt4XUSEOLxM5ZO0GAJ5eY810mguReJ0z0mdRjiIOgAsdlFB0wLxMe47YE0kFdUFXdAasWDlvXpsASYGd1tpMRMvS95C4uSmsRepbOdcZyWiSpHVYm6leXN5o99HWYBpxz0wvYJoPkDCjfNpEY6Ns8awatWXAiSiJK2dDnr3ZLfznzwyPKT6nVJDWL3qoAqwMaLdYVaatk0ht0htT7wGMAUkNTTsg+1ZX/Ti1YXtKO3XdCCXsYemarbs5xu2StciFC3zZPe1+zHlNtaNRa85xrwAGIHxIVXZpuPsuVlscm4btPAQJ/dsiWPJ0kxcTxGPt/k7pvBSpKbBnGze1+SIxTTIHN9qcF30uKaO1pxjS2HqqMWl4xzO8cEZjuSxIcBUBvtppXlhBlu1nZnP7TmzzBStGPKOamctoq0N2cRsmLGY4wGGTtcG5CTkpbwjBy+eVHuNcWnTpYoJgOzcuPMqi/9WfLkmnlLt46gAuhPSdPSyUsNdqyXNwyAUXQNqSj6U1A9PCVZXWZ9vCZhZDP2VTNwBRx+lEFPzOnEggU2EtYG3teuMrogmJHdXIzLFmUvza
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(6666004)(9686003)(26005)(6506007)(86362001)(38100700002)(44832011)(41300700001)(83380400001)(2906002)(478600001)(5660300002)(66476007)(66946007)(6486002)(66556008)(4326008)(8676002)(8936002)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TvNErNeT77o1TN6XK0lWkqQz0NzqmhnCFB4BZpZIsKOwxhSys0xFL7bjZBx5?=
 =?us-ascii?Q?Prqux2PuB5i+G+IJYqJ+9Vue6Bzsur3zOWO212mR54EPb4xTXvQy7c0sWqGF?=
 =?us-ascii?Q?v3H0B387z62c7g8me2aEgtyirefMh0uxDDmeK9/iTf5u0wO7khIy1hwgsC5s?=
 =?us-ascii?Q?3NxZjz+iKwAtbIG9wes+7gQjWKJkPRpJ3fQoEyqpkQf/IShP9qFRYoM48EMy?=
 =?us-ascii?Q?Nd5mUyLM+dGIXF/Zjlfk3Xk3OaFR3jBO8iRPi+aa2zI/xIYVWz3i9R+KmdIL?=
 =?us-ascii?Q?eIIY1F5l3WPbDP1MVQQL1A/0ozphVpFu7l7bQbJ7HTTrDou6KqAsqH763V5W?=
 =?us-ascii?Q?8eFCxnSUCr49EWpSRpQCSVmFbL1whDfD0eOmJZhqemfyohUKNbwsNQRhFNgm?=
 =?us-ascii?Q?iGVcGfGciY5kG8eI3sUi3t5OoAjuQmNkYztZS6DYZ5ESArpqU/S8K+EXxT1P?=
 =?us-ascii?Q?81cQCivXX5z+Mfq6xXPrGVjKcq3i+AqqErb17QchI2jvW5vOuoV7AWlBH6Si?=
 =?us-ascii?Q?WfzIuWQsbW9aUIycA5lHITIVB7XJXWM2bwzuQuBSCu40QtETdWy2rzGDAI/i?=
 =?us-ascii?Q?hoSBsNXhAS2EeNVSurXB6+58gmlHD2c0nhxx8ROkaVgz1t9bPon8EmKbcjqP?=
 =?us-ascii?Q?wX3KaIBJSTl9A84T5sybzBhi439xW0440o0jsf2f2P7EZehjUi8UNnggT2F1?=
 =?us-ascii?Q?QXwHUs12bpqbEUh+UqTWxdndWYaI4ijdTagJ1OfYNrB8E+npk7UZ4vrKjASZ?=
 =?us-ascii?Q?InpRjCDB8EtpIrXwBAp+WS7Ch7RvizlN1uty7uZNcIkwWYnkJx0h94N8Y7IT?=
 =?us-ascii?Q?osFO7ZC1skVjMfc0NbQX4o09OLbrgFxfBUP5EXv/5ADVFSiHyYuTRP8jx0MH?=
 =?us-ascii?Q?pCBthRVD4TJFlWrt6MEuy2yMGDorewFsBfC2RkOiXOZSXqKcx9xRyzdWKeVW?=
 =?us-ascii?Q?WQyK9/AZln+WOzX3Yjb0zmQERnfJKiike7vrwHDoQdczzXTkC+4wwsz2Pky0?=
 =?us-ascii?Q?cOpjHNuDx2fHOYN8/ROxTSubHspBRX7k/BLmwZgb9y5pp17MC/yR2rH7Tp4s?=
 =?us-ascii?Q?fZphW0g4o7Wp1DHo24STQwq33RaoP8SXlifDhDRcQtvcZsU4wJPpSK6qk67L?=
 =?us-ascii?Q?jiPwZfctZZ5clf7eVm37+Gs7pkgvs2pL4anOw0S82ur94Nu/Y+TQYlNdOZ0H?=
 =?us-ascii?Q?isWm6R61ctghLVJgL81KuRlTnUTIvSgtgfwLAZ0shVJ6EKVFvgg97F90R8P0?=
 =?us-ascii?Q?hRaCqzaM1Rzc6sUBZp3Yp1nkp6fokqDQHLVKun/PrEqbNztd22cFbUBNKJS2?=
 =?us-ascii?Q?w1JweAoUGZ9tbrb7jPLlrIqPOq4EAqHdnbcpiZkKdjTTGb+Z0TEfimxU2yvX?=
 =?us-ascii?Q?/WH5qYt+64ZrZfO3QV/0VEfkC8p89Nw8rNMNPo/5MeZrhwhM52FEhJVovJLF?=
 =?us-ascii?Q?zcS1OGAd4UpOIa7z3c5OTJ9th975qbhauR/myIKiRE8ySAIK0wPqBUS6GHbq?=
 =?us-ascii?Q?UBGkc+TWdRrd8tVwi75paE39dMxvszW4PJPzWRe43y7Ol/L6s7KCk/45bdVX?=
 =?us-ascii?Q?csjhQit9GE94ByrKePJFF68fCmYMKAVyIaJDMLZ9UEF8USXTwGo6ZtBP9kdX?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lx5UiI9rmNrPUCE6z/TKAQhFPV3/s/N3SvJ67RsvG+k0KaUgrgPCkEsgHzbVz3yxHn5TY4EP00raftsWoAyIZqZUTuCil+gQDcAoZVuwkXYAwk7eeZvVbi3IbAsvnAvWTQ0i27F5GGpXIKwld3MrqK/onDW2tO8Y6Bx7XwOerLmBpXC5lUmPyNp/8KmFB+TA+OXVdhFXQtPOWEEDqVZK8XzsUZ7TUkV0buu7xF90KgirwjXW6Nc6oxXnJ5RaJUvuI7SWX0wUx0EJtHH9VrsAMGbBOt5OFnw5GqDFK1SFTPNJPh889QNMLOGi9MRc18drSrf0QmhIIHqRRp1i0ksboD72/VIJB4yMaNCRkQHvhtOKvAcfgBj4KyxIDT20CqwWO+t9eX6NOWrLfu3GIF2VwUUH86aZZjzeQuEMi6xBgBsbgXLzmK0VozBWiAL1zeqtl5cLTE9sP/OmXG1sjDO7qknleDWuwGiSYE9IOFvPfp9MME9eXe4AxPrrk/ty/nwwB7Ylb4ykK+kz8oQLrt0fmlX8vdMJCZ6Xp5s/y2sMMytmj06PNJ9M6gxD7q18SQanuGPFZMc+OxdjTHsmUJakFOqeoFD5tWepw0LuSDzR9Gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8759d75-be4a-429c-fc2a-08dc1b9dad7c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:58:41.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V87qw01bmYJXz+lKVjxk08LLeiNE5dfKXgwV7h+igDd1s3s2MDwqEpGSNDYsyDrimxf1IJrE13lwvQKyVgDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220164
X-Proofpoint-ORIG-GUID: srtph63fo3iU022KbjtkNspixMs8ZzQz
X-Proofpoint-GUID: srtph63fo3iU022KbjtkNspixMs8ZzQz

On Tue, Jan 23, 2024 at 08:35:07AM +1100, NeilBrown wrote:
> On Tue, 23 Jan 2024, Jeff Layton wrote:
> > On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > > Introduce write_ports netlink command. For listener-set, userspace is
> > > expected to provide a NFS listeners list it wants to enable (all the
> > > other ports will be closed).
> > > 
> > 
> > Ditto here. This is a change to a declarative interface, which I think
> > is a better way to handle this, but we should be aware of the change.
> 
> I agree it is better, and thanks for highlighting the change.
> 
> > > +	/* 2- remove stale listeners */
> > 
> > 
> > The old portlist interface was weird, in that it was only additive. You
> > couldn't use it to close a listening socket (AFAICT). We may be able to
> > support that now with this interface, but we'll need to test that case
> > carefully.
> 
> Do we ever want/need to remove listening sockets?

I think that might be an interesting use case. Disabling RDMA, for
example, should kill the RDMA listening endpoints but leave
listening sockets in place.

But for now, our socket listeners are "any". Wondering how net
namespaces play into this.


> Normal practice when making any changes is to stop and restart where
> "stop" removes all sockets, unexports all filesystems, disables all
> versions.
> I don't exactly object to supporting fine-grained changes, but I suspect
> anything that is not used by normal service start will hardly ever be
> used in practice, so will not be tested.

Well, there is that. I guess until we have test coverage for NFSD
administrative interfaces, we should leave well enough alone.


> So if it is easiest to support reverting previous configuration (as it
> probably is for version setting), then do so.  But if there is any
> complexity (as maybe there is with listening sockets), then don't
> add complexity that won't be used.
> 
> Thanks,
> NeilBrown

-- 
Chuck Lever

