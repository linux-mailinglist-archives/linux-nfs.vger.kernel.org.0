Return-Path: <linux-nfs+bounces-5779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F495F737
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF61DB20FE7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AD450EE;
	Mon, 26 Aug 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a/OiyCMu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d2Av8P/F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C8197A7F
	for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691322; cv=fail; b=DWHTjnSdjriijYh3oAdXmPlVZ/b6lyFBBa8wZJXSxGlZSXy4koeNFS5EL7Sup/1qUieGKoSduaIMELUcAj1x9un/jjnTQaKVXQCXySYi/LP2vqygJUoaRUJo3jO9ZAyBq/reflcqWH0m5fefal1cZUA7edFdkrGuZnZZ8bOQqok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691322; c=relaxed/simple;
	bh=UV/CDuHj4zL+hJUCyNLvnsHcZwFNxmzjgu3l4q1UZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ip2vOuA0In55hmIbuFc241AzzRb5+YrXWLVvXcCH3ySw8bD5ayB17AESHnAkkfO25emk729cn0c3Ey5VvFd57rboSAwHcHtRo/Qc1vmf5hcHKTCDv0jkAGlX1GPpHAx1k7RYrAkZk2iVgLHmRUAcuIMJDSwJp19c/iMa+rYutxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a/OiyCMu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d2Av8P/F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfT83000477;
	Mon, 26 Aug 2024 16:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=NtgMSuiwxo0Kbwg
	MuK21OaO1RCZzpJCIU4Am9+a1rys=; b=a/OiyCMuFI4TFxIfAxiWSJtmjtW/Glm
	flvpa/SopL8mHQ2+0sa3wgSwezs76Z0mKyqZoNqNj1eFTxm6J5Q2UZwL4SanVoLU
	Oqzn3SSHNh7tYjfNJAVZpViQOVEeBqH/UgwGbACD5ebFpPvXirindWMszZabcw7d
	qmSLQ8jCMkbUOCyoYbmzgelRQjIeZt65kSVhs+zP6o9z/jOUlAWhTYxGznGSmJ9s
	s0QqBjk9i/jiOt/r3xzeyny6EkZ+dFKHpDzzGX23niC94rGsnMR5elgCxdQFw+v5
	NZYF8tmI4696XKI96rqhrdPzlMZCa8Vaji3ZFtm4Y9HZXEN3Jq6urXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nabmex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:55:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGN6iQ036638;
	Mon, 26 Aug 2024 16:55:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jh9wmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 16:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/G4DKcfPJ6zhsbOMDMtNi8r0W2HnL5j9e63ENNaZha9Psf5mrwGNOfHugRz75cA/tBajJKzgAQgK+pFnJM9FKZk2B/67bDHHg/fGwTyUxXG0xvyFV+f4TbHcqKJRb9l/2s0l/RpIc6lxTkShok00f3e72EsquHv3hm+G1T4vZnWubXzPfNY2Vc/t0hC5dtWn5alq4BGi4n3tRjKLkiPMsJFv18jPmhXp4kpBQ9I39NAwDS0vmwpvax6e3ylozmshRghj/aBKIKDh8ODlCfEwDiqoru5k1ucLkaUbeYRMuD6OZ9QQ3XuJ4URkKaY9HPGGPLllnXihjBb6pfi36U7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtgMSuiwxo0KbwgMuK21OaO1RCZzpJCIU4Am9+a1rys=;
 b=POxdU9LKTqUQxq8M+cMDVBszo4KShm1U5wbHGI+nF6Pb5EIwpdlv2SGTnMak7JbJCYuaS+vtdP+39+FA7DV7aS/p3mm/5ivEvbT0dvi/nRkSD7Vl++72vfh0OPqnSBoNsxgnO1VNHfckn9t6QfQSITP0CjjaFup563uGEZvKniujjPMAtMzJIsA9/gU1qe+n/Bkfen1vmJSi12Uowh4OzCnfGn6OaB3M9PuRQq6ZywOJCCZqtaDUvxc4BSJZ/yBUcRYttM3DsHLBngVBfBD19l8lOnL14EVCTgLL0XKcaH9tnzax5lmtY8yk8vpScWGH8xvBewGympxWwnFZClSwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtgMSuiwxo0KbwgMuK21OaO1RCZzpJCIU4Am9+a1rys=;
 b=d2Av8P/F1fkWrFeymNBHXTGmJIeVYM0V3xTtKzDjQClKybXX+C8ELwTys2WaZxzq9Hq5Hl+W6HCagCBnY8lBwobb0S5+DDmNzhX44VB4GUSCh0fspoIDnFOPVbgqfY2ZsMSGHw+U4pS2hVvTyX4QPNSXLPfquDhxrDfxGd1jdVM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 16:55:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 16:55:06 +0000
Date: Mon, 26 Aug 2024 12:55:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: call cache_put if xdr_reserve_space returns NULL
Message-ID: <ZsyzZ47CKquEy9xV@tissot.1015granger.net>
References: <20240821140318.7757-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821140318.7757-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: CH2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:610:58::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 997338f7-a834-4ccc-9a75-08dcc5efd673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqNOdJb0RmSUq47VJoyhh+Z5rH8WYmFNC6haBk29UkKwGpImb095sXXrlm4O?=
 =?us-ascii?Q?IqwjFXuYjrabrFEYQ5XdSsQAANI7mr/4RmhBOncNOuRgP4AzXg0CKnB7h+1z?=
 =?us-ascii?Q?cZhvxxR6vgF+yzml3Hb1hBgsgReVINfV1VIMunMpVeGOVQvoBHSNwNxnTcTT?=
 =?us-ascii?Q?DyuqVww1dMVHLKcqzJdUBXV1OHyKO3oJ0txI0kkHouX/SUQrxG7Xtiv7+Bd5?=
 =?us-ascii?Q?uA7oG2aJJOiNVzBn9ar3dYyd64knWQWsBYSmPC5f/FFi+v8DDjbHqqGTwKpi?=
 =?us-ascii?Q?E+bIxLxtv2qAF/ErgmTx9Pu61xkpts2/EMD9zT6OhexLnPT2KGmf2eAud2Uh?=
 =?us-ascii?Q?QfVwySMBA3AU+hiOH/AzTjDUMQXgj7JdebC29mqCSePts1HjkCSIOODlt0rA?=
 =?us-ascii?Q?ZXL2JUZem9hetRhvVq4GhuxUUqR8tekGrI5Gh4kCaQAY/tr1qDJbbHgFK8zU?=
 =?us-ascii?Q?SvQ+mrGn0zvDqGOzleitBPCTnlAOIMCV8CVmDBTST4DcbGgnlwJGR5dserPZ?=
 =?us-ascii?Q?iuYUWjjZIAuCTZx0Vx0pDPMj31r4EkYKR9NwbISbd0kfIWAG7rIONFlhXfV/?=
 =?us-ascii?Q?UqH5zOgzRmgzkM2YKouzJxA4PXRMmoR8GPlAN2jKZ67BdyRiFU18rcroTafw?=
 =?us-ascii?Q?uza5Ucp6n9o6jvMF//zDbeL2s6Cxt+O33dsw8hxOHgXA+j2Y+akDZZz4DlDZ?=
 =?us-ascii?Q?Qm8pb0duYCIG5VlVc03YvGTNZ81iKwf2KkmlFn8jRLx1LPqlmiiV4cDuFlt6?=
 =?us-ascii?Q?NReuiHQdsy8KHDypw0NbradsTF4j5pb4DMGjq/J1uq42pQvEDhTtq0fuDqAk?=
 =?us-ascii?Q?2uzASKRzYCXTcl8vTkmQE88nEEHFriYDZ15d5z2V6j2auZHKyDEU75yid+L7?=
 =?us-ascii?Q?5qhm4QcyNa+fyFVEoI+/ckZAyhjp1WXJ0qzWv3IbTrBfKj4wT6f1dIKYblDf?=
 =?us-ascii?Q?uOvaXMSXa+ESwJ+mOKYjM/fnN9/9wHKTN36kvl5GuyVH2lSVfMjQFvctp3V3?=
 =?us-ascii?Q?kQ2TF7a7ftgdDeehjKdtHEoCNCFcSBVJVKZe+ybmVNrz8wveOXoXhf84eXkI?=
 =?us-ascii?Q?KCvqhDjDRIKJkk8gqIb+7bKDXDECbeToXm/BsOnHZZ6KNnpwGUYYYWsTekTF?=
 =?us-ascii?Q?JoKqCzpICWCNFVX3a2AHw3+XCebhv3Fq7wyVr5yohBoIdn+FUXtgwu+/o3tY?=
 =?us-ascii?Q?1taXgZ40P1fVqUyMi+cNtCnBaHi3wH1YhFBUspkxr7oSaAw3wPhcmNLcpWhB?=
 =?us-ascii?Q?igycEtEdUypk2O15aWhS9wJEr7QimBGjq5HzT+6ngOJ2AVFsbtU0so8e9PRz?=
 =?us-ascii?Q?ebFZ4VHl0AJlKnAGI5WCQtNghNwcj67E8dsdRzAcTMVsRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OmKVe4/SXl9Myf2WxIhgg3Si8SyFSNVYcDqV02DYvX2R+fdqDSk6QghssmD1?=
 =?us-ascii?Q?yCaHqrlPniuxGSMWCpkp8yJ6A5hFmWRj3RKaeI2CKbkM6oe9zF+BFN6KJIQh?=
 =?us-ascii?Q?vUAD+ULQdaAWQUkXUdMTkBu1ZZnsmZszVIQJWiIjZkhemq5/sHmGWtw8wrEF?=
 =?us-ascii?Q?DnWh3NbtMNQYd/xtdts0QCn2ktt7JImy462zotm5gUzy9j4b8xCSLKHDahM6?=
 =?us-ascii?Q?oTf2EWq/CJCrm79NWGldE7uw/TKZG85aoVVBgseoHEXHhlNZTwJUAmlZGLYY?=
 =?us-ascii?Q?ZdZocet5llU0hDrPkIt0lYATj0FTsAmdFIP3qHoBN+rBR9VsskwRiKWbd3Wu?=
 =?us-ascii?Q?uCBUBQzCpZx942XsIZIIac+ozSgrZFNEsQKFLfRbTvBDZnvnt+TiduoEPzcF?=
 =?us-ascii?Q?iEuJHD76Qm4o6uzxQo0lN2yYWUJ2g42Y4N5zUPMFQfmGQGontPmywVdJO0vK?=
 =?us-ascii?Q?XGcnczwxnLjvN9Z8LOvKIYP1Sv9tzijDG3uWvOvjgHeku2B6bSLxkDzO7AWN?=
 =?us-ascii?Q?JFKPK8GF5abvDr9juzAtRjxIfU3UxVTXWP5JObT1x+gwnerqFb8mI1HrK+h0?=
 =?us-ascii?Q?402iBRny53N1+waKVCM2AxM6ZIoX6wXwgUlndkuFNeoPJddlFUi1VzNIhu46?=
 =?us-ascii?Q?NNpI9UcPDQc5TB/k/7rL+z5cuTufm+wgS52UlEUvuhOYAdRUbcKtqDGnYHAq?=
 =?us-ascii?Q?Ix+BQoJ0heCx9TP9bUgI+8bM5fMdAQDTujSHR7J+/7XyhmZ8kt2nSrQ7xtu7?=
 =?us-ascii?Q?Vy8gr6RaEtmqyb2Y36E2G+aZmqeSWEIIprDVi1BFEpZV7tePPsRxvPShN4aA?=
 =?us-ascii?Q?w8yjj9Ed0D6H6klCtjR1jEQ12XhUxAANUaptumfYDfv4DdqAifN7HYh52sbR?=
 =?us-ascii?Q?FfoM90FiCUqBtpHBoQUA+es+k0KkAwJqeFtZGNU2+pRmRwHNHATETAXrKgH9?=
 =?us-ascii?Q?E+dsLGbpjlnCiOeO0BPssEIX9c50KCDV7xPDnQaf0d8EiKDom+gKAvRC/2M/?=
 =?us-ascii?Q?kBp1pzpKCnxoW57g13/FQe0Cg5Slf3po/W45hlok8ar3mw6+MJVppL79aRJF?=
 =?us-ascii?Q?gag1HRGqqhJ/RExrwtSj4G8aFE9vxnR1LLsk2KFGXMGCoSg5wmVSYtgf9KxA?=
 =?us-ascii?Q?BeY3Bd8c+ncdZrhHu7Qz+IxQ0nHyM+bl4se7vi3GlJZ/dYHT86vdwe7vlMiP?=
 =?us-ascii?Q?9dOooD/hejjQq119G4B1RVhgB3RtnlzjFDLpwLWxg0RuPJatd/CjHtzQ+bGz?=
 =?us-ascii?Q?r5qzgJAzYqs8yNuKVrB81VsiuR89wkyWwCMS/+C0PzsXJ/h74GRKRTNMzlVv?=
 =?us-ascii?Q?EHBMNrORsssObKzVr3y6493GNrEHuw08wE01DhFjh33p4XqolZVzmlmZprzC?=
 =?us-ascii?Q?Meyna/GK5vMwg7DS0WC3kEBZn2rygKZqFVHiqJB8TTIW7G4HebcGEF0J+E0a?=
 =?us-ascii?Q?WZxTXfsumUqLsGjFOuYKZ0pyGaNDSKB5UeMP4oNyBZZ6XjS+VeodWJ5PfKlq?=
 =?us-ascii?Q?K8JCIwUhQzsWC29//ArYKrDw3WAtBLI28sIipCk/clqO2qOKb8/QBnhU72pO?=
 =?us-ascii?Q?ZyKYi11ArIO+noQ9r4bXjBcaaFvZgvGnqCMsm8wf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvYWLuhfRk3KOnGArZjVgs5GmuTx7+fsqAdK9SI2vzM71RpL1WYxgIDFgaRZ65qMAEds+heOF+xLQf7jihsoQh+fNs7Sm5o8YftxUe7f1GKBR2UgrnyDPLqh6CE1jogNUHPM29JkEIdbK7l1qmosPa2J1HLB6GKz4sf/C8JqJGZmqWkoJuf1bAZtra7tTBxZe+0pdtmBu1W4HCgcKGsL2xOrwN6D/rIK32TFAyW6HtkrcYol5O0qX2ja1kJlCMCw06ApRM2SIqhVxY9bHW76Dn0dBH5CfiiZbLPokXnF83o9tGipiozg8SLPNSQlfbAj0N9IYbq7JeiwCbTtOSpTCtydUxy5VkdGQiyE2oHHE7HrKMmgeUadLv7Sw+KfjUxomurwEn8LBlqwUtfWN68PEtyTSr2PbpNEfqjomNXkVPU4kILknq7FgG+CldrbkD4SdJlHHuSECjF8NWFGpypoNGRbwCmkeV2JBUlOb7nvfGv26pA26DT7YzkcZfvMzC7WRvZuIjo2iwa6OGnr5QvC4Z0/gQ/GsjpFXYbKHqo0mfD/u7CIr8cBJ/fEnyykd2A/Xj/YQNbvjJEprSafXcMgsEPl64k/m/LGenWzBWEE/NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997338f7-a834-4ccc-9a75-08dcc5efd673
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:55:06.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj6GNOTRhmReqhF6mqFPeKo+wPv7fbowc83hgkUYqorf8MY55kw4DhrTaWTjK+pzlpb0LpOhc0Vb3sN3vti4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=902 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260128
X-Proofpoint-GUID: Q1m6--QNctOeO1-00_ilJU7PgS_kC3wt
X-Proofpoint-ORIG-GUID: Q1m6--QNctOeO1-00_ilJU7PgS_kC3wt

On Wed, 21 Aug 2024 22:03:18 +0800, Guoqing Jiang wrote:
> If no enough buffer space available, but idmap_lookup have triggered
> lookup_fn which calls cache_get and returns successfully. Then we
> missed to call cache_put here which pairs with cache_get.
> 
> 

I've adjusted some aspects of the patch and added a Fixes: tag.

Applied to nfsd-next for v6.12, thanks!

[1/1] nfsd: call cache_put if xdr_reserve_space returns NULL
      commit: ada7d1ab3aa1266b24d08aa4b3df93360a203924

-- 
Chuck Lever

