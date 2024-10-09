Return-Path: <linux-nfs+bounces-6975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39293996E90
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBA1C20921
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF56199FAF;
	Wed,  9 Oct 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYHq7b7l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ldK1n452"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FF196455
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485253; cv=fail; b=t8K3v0JTmkd3u0JHq7+WDK3zBeKIHhzfZH049SIGb2dV/2H0sHRpxncnR3VW0fK8dbNgDN4DBwCCN7+MTozBa0W85lOAZMwkdP9uUedCO8/dLWwSly6XveNrs+O+S7uDBjitdQAAt4P0a1VGbk3H9erZZR/5LEaSNpBDK3sqlSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485253; c=relaxed/simple;
	bh=+bBhcGfTpeo+i897Y63edgUkVeNm3lIJ14jsP3EqLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kcpof60ksYJJJ1oOb0rA47Y8ByqD70D41QAp1EQMTxjJUbxsBqD8gVvyP1ml3fQHhUiekHH90uw8f+QRXESUBQ0q4D6bW/Sbi/dDehiF+0eNX2KzwejJgc0pmFJhJ2/bzRABsI4GCsGfzdhJXuCrrH5dQiXPPYu0MlKvr4LVPH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYHq7b7l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ldK1n452; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DfdeY030015;
	Wed, 9 Oct 2024 14:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=g1iT3j/cjKbXH5JRZV
	Dq9k5cJn6TLr/VIzTmuU5Isuc=; b=CYHq7b7lDN9f5hR/4iguo9v5c+Nd2EbtDB
	wWnpD/Jvc2jItZoMOkHrIQs/Ogmt+w5tbFoeCn0+6xnUXlZkmRT4wOVX500vYUPQ
	QqJzN2ThJY/iVSiHLUNKtlXoxHGUc5bsP8Ab8axdiZOcaXRQmi0G7F3E2ol50C0V
	6giVwtpUAM6+wBVVRaw8rqci0ahxmsA5EkUnO/VplpwIVpKaiuiQIvdSdBYP+O/Z
	jXLbH+pA9GwqSahLmnfIFQuwAHnWgfOZIZp9XU/vCaxs8nLkzc4L6tAlqF2kgg7S
	LSVm/+MfEzGBHOvXC6even1UNfFW0HuEIyn82Y9LmGGeiBJU/e7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063rejd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:47:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E1aZi019083;
	Wed, 9 Oct 2024 14:47:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwf06dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSl4o0dEK4JbxNwTz/y1Xew27bpsLWIlssB6ceSwwMLxD5JpGZU8T3U6GqpPBmkzI4huPqUtrU45iowvhly4IsK00tPo/E2LQJNvQ7sxon+0Ce0J2sp8OlHNy1IZ+oUDiBiOtuR7psvrANXiiv//rUD5GJdWJx1dIKNS3A/sbv235IJSSqONxHgxkP24oNZTYq98W2s7WX08sNPW4HjbRfrRUGqW9DZnkg5jbMPLABxGu6ClNPdyGKNBdq/0hayV16X+iv6OaYYEmxDcFESgxh4Xy6lEAVgrDEHHqw1yuFfS1UFkirFTEKWprGWDHgveDwkl+y8hZ5gzjhjk/Eu6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1iT3j/cjKbXH5JRZVDq9k5cJn6TLr/VIzTmuU5Isuc=;
 b=rMlAClBPz7pL69XLqDzvJnyVHsAetPwrWa4zgG6r08ihHUrCjdtkVDXX9RrUOtGG+VhrJhT6WVfa4gfXO4QAq9FztB5THcpuYb8eSLr21OxQYrGRTqzJj/qAS0DgvlJHqpQsLO1Ev/dVTDn59nfF6o70tUC4K85QA8fmy+h9QBuEgeJxrm6ovsrwYDkF9GCeSYTj0IxTi/vtKtmhl6DcQJFwS94FBGQw3VCdagxPpEgBPdfCupLXBWTzSy7W2VmlGcjNpd2Z1RlnUfnyXGI3nkoKLw+em3xurB4dfvPELx+OWLYkdRQ0K40ilCscS2+MxlrgQhXAI/yWmCuxRdRLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1iT3j/cjKbXH5JRZVDq9k5cJn6TLr/VIzTmuU5Isuc=;
 b=ldK1n452Ly+3ZOQAzGh596yH06W0jVEa27CS2xLU6XT+dnlZFXChd/p5Z+oSuBUmBLYXmcEPWDyrqOUj0oJDsd2By1CuBE2+QYAs5qVI9DT1EDyAJeAp7hE/IvoOGxEdilJVTshaSnbVdbgie99lY+o3J8v/WgpXNG6dEJFEvzg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:47:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:47:14 +0000
Date: Wed, 9 Oct 2024 10:47:11 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: "cel@kernel.org" <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Message-ID: <ZwaXb9JD6Eg6WOIp@tissot.1015granger.net>
References: <20241008134719.116825-11-cel@kernel.org>
 <20241008134719.116825-18-cel@kernel.org>
 <172842535375.3184596.4875014047079014162@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172842535375.3184596.4875014047079014162@noble.neil.brown.name>
X-ClientProxiedBy: CH0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7b0ed1-db78-43f9-73e7-08dce871437d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BlL7GNDNkqsiuMqQ1DggjB/+mbd4miGa/t8BKEtOziUAnqvGkYq74dHQeaem?=
 =?us-ascii?Q?JoH2b4sNfwggPahVUY5z3BXfxnyDlHy4CyD6VVTbwmuazQyZZLG5Kn4Xvjlo?=
 =?us-ascii?Q?nNBTlSSbnUiIGEXGJck5nvrmFw8znSI1HxTPZjUC/7yI4TkJCNZTVarM835I?=
 =?us-ascii?Q?d/5S8dAiRSHVt8y32HReU0koN/HbCqdSyGCdwowldFsQnodSkt+HM4dXeaqg?=
 =?us-ascii?Q?agZwpFzGT2EvrhKbdUfFqmPqMn0GBZMVXTnO4LP5mFEqiV+FijVAA/1z6pbI?=
 =?us-ascii?Q?w658TG3Srz+ASSW1ZxGpGNri5xaZx1NawUwCo2DH4jY/UTKPTn0jY4kAQa/H?=
 =?us-ascii?Q?C6JWeb/6c+cKX3DPdKDiNb2YyBieDbHKhsjL2htvo/QaecgdaLPD1DpApIdr?=
 =?us-ascii?Q?ThpLmoybX6I0znd4/IOndTZd0+DFwSA8uUlpDnpCtc+KEu7Mm0vOWN4q7ZyU?=
 =?us-ascii?Q?YsMvumZVQDfv2mc9SHSuwo2Vt+t+IRP6TkVr6hr5TVIBL9W1arWlcSAUoLg5?=
 =?us-ascii?Q?y+HjHN3M4V/wwoVOiqkAz0qaukhnZ35X3/WPzkCiKg0xpKx3UDDLBTBw0t6O?=
 =?us-ascii?Q?UsPwD+Ibq7T33+9CTp+le5uU/pCSadeucNVWu+Nf9X7sMDXu0FefnSxTATPt?=
 =?us-ascii?Q?zA3Ta2EZskyCdjqpGhO7SmzzVEuj0f0hbvMzHEhgmcEPBZZ5G0zi4iYQ7H1a?=
 =?us-ascii?Q?lszTTrU6JYmHLWFbLEkol6MnBypzOG8FSSxrQsF71i0DtSZMPMRiYXgA2Bxn?=
 =?us-ascii?Q?/wXIwz0M7HbbuaS+zQUKpF22puVfF9z2y2g/FyKZMJrkqMXgOHzUBqK0Rsqj?=
 =?us-ascii?Q?0DRzKspITYdb+37iPA60BBgVNy21N4iECeRnTt65pjj4+Lv6e4gUXX/+874o?=
 =?us-ascii?Q?LSL7e85OyNxi6wstm8XirIcDOB8pjMVKs9YvqS6d/R/yY2TmzNOwFQCksTe/?=
 =?us-ascii?Q?ao5pEG8wJMAhEiCzKb0RPOx19px/ZxpYIc3shksEvywczim9Db5G9yFr2GoU?=
 =?us-ascii?Q?HJ13tVS8gN9DJGbjz5Fvdj8F9nFZ5pDs/B/58rNKL/NbJu24oCclFLYZ3cdl?=
 =?us-ascii?Q?M028ek9vxjbgfyZvaWaCq1K+/IAD5/azFYaC1OE/bX7LQdrv15MdKfi8RZor?=
 =?us-ascii?Q?6neYwOdydDLWFAD3XA3fEyeZUPFGFoxAJtCerM/gGb2Yw9UnMUMwyRZNMbBb?=
 =?us-ascii?Q?stNdA0PSqgFDqcJqSgBn433g1n+9P+inhTeGIl68F9MMgyKnQEwiY/qpnQ4Y?=
 =?us-ascii?Q?APHUPH2iY4c929VVIvJkOFFz7HqP4YffuNvRJIRy5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMVQ6h58OuTlIncBfjLEtyRA2cH46QUt+QNEaANOF8eDpAkLNQmJ10TQ49AM?=
 =?us-ascii?Q?r52cAbFIskidPLS+sKTMmPecxbu6XbV5p5+zjoTDsPzQirEBF6gWjHqvNxt6?=
 =?us-ascii?Q?KSN+XKq5jOkGOrUGTeSzBogjzIiymR5oaDMaAke28gh9JQNBkQCukrlgR56W?=
 =?us-ascii?Q?JBxIL+RYREip8MG3A+kB7uMCvCY3ImdkyJuR557gspWagaxIPscyReRuaNVa?=
 =?us-ascii?Q?raiFWkwS1SOcVo/SjAuRR6unr0jmWca97i3KUa89rRIBraJmMdQibiBEQavN?=
 =?us-ascii?Q?8uHBUA6oS+1sSOaiT+yFBPUjFDix56TymanaWNPvHISQgmfH4mRatflaOwoH?=
 =?us-ascii?Q?4K/4HFsBDpdnWkv6ZRUf7KvbEJ6kZfAfFESLzkIyitOjAdSAnK/EFL80H6g+?=
 =?us-ascii?Q?+mOgF8Au/XCTY00mDt33ip+q6kcZi2ymgNDtPUAN6plMQ7yPLmOH5yqns62g?=
 =?us-ascii?Q?jMfs5ADgUhjOUSAMMjyuG2bt9vfTNGCFmbCIyeVw8cKOiqfOzNGM6zsfoFFl?=
 =?us-ascii?Q?k7wonYIhW+oaRMIdPHXFwPd5ZPFxDnYxxETp1RD+Ys+g8Y44xO6hwtDRpoZZ?=
 =?us-ascii?Q?O0stFK+ojGhH8JekLaSVcw5hAgb7Mc3GzZ7ZrbeOUrAyNQy2Vneo+tjjPOUU?=
 =?us-ascii?Q?dvzz19I4uvZ1U5jh7tMXxFOQh21erEXnRSSWykEkuTMyMeVst1j/TE96HsYr?=
 =?us-ascii?Q?KQlOZOLrO8fnGQ2xvgeLIDAo4NEZnsFSv0NOutbLp4DIzY+BxgcRyo9W9Z3g?=
 =?us-ascii?Q?Woc5wk/0C+eP/RVcSpwg23DvvegOFnec8p0+AufYDx9y0KanCjL7n7wiC9SU?=
 =?us-ascii?Q?R6MMT9V0COoPwAvComQTfFO7sba797QnEhWnznV9g8c2Z085RIRctXXj/PJk?=
 =?us-ascii?Q?Yw7VSivKJswO20/87UFjaeawy0545SEnWbU1bDMwFKIDyKbI9kDHJUPvunSE?=
 =?us-ascii?Q?AjzZG8WNUv+F5H124F+reHQJYJrYwn6sMhox1A9nsBpp70MzdifaeQX87z6T?=
 =?us-ascii?Q?b8ZsRjU81Z/NXAf5NgbYacghcmR/3bUQZB8x1mijlCCEzMgQyp5tnltttzVe?=
 =?us-ascii?Q?9mRHt0NAh/lB+U3D9P70w/PJth7IClgTP0Jn0N+o+qdHRabtOMy1nsVf8u7M?=
 =?us-ascii?Q?j8TKqjd4rFb4KkIZV1cmPoYO2Md13nXBbCwY0FgX+Gp7xpiMDj1oWxJAxXUT?=
 =?us-ascii?Q?sXGwvSWvt4WwLcRJXI7uRlEmzAYxCN+eaaz0942uHLrRx2oCRWAOiR2iQ4+v?=
 =?us-ascii?Q?IPpGBnKwv6dN9yCue2DzUCxfcC2sGrLxJFGKusJvcDOdFQyzm4fRXrgi/2/J?=
 =?us-ascii?Q?4IlVDLviwsgDizAmK3b2o54TlQ3EekQ7U83p3gKcz9ZvQyVMhmFK3pAHEauO?=
 =?us-ascii?Q?MCAgZBdSSUQ8VTwYgBPXw4RbVHQgpEMjrg8Ygoom4WaR/1+r5rQnP+gXUr03?=
 =?us-ascii?Q?ksXFGUK+vUAq2eAQz2+yAhqD5ujm50025ScSyq5wXLswgiUAPbr5F6EQ3C+H?=
 =?us-ascii?Q?SUKVIjJM+h4oP2RQF/8ZC0L+mSe4s9FDpDGhqyEKCz0VnOixIhpCxOYG/Bl1?=
 =?us-ascii?Q?HrlZhLouyMqmtp4Iye2iY4h37QSvXY2PbNG5yFcl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xnzf+W45LPEe8AyqNpUi8mfuGJNgPrAPO6Mv11WZuM3SABTRRNnyxUPMBaO7jqGeOAZXTxttYqnTLSXiL2pexotxH9BCqM307xtrhHlxl2iZLireqnQxlEIsyoULdeXnvDsI6SlxIlZ1Tx1GSAaJxxKD9N/6Yuqyq0XYe7OG8x49VGB2yY8W/NgrhsdyzabOTSo3Gb1KKnDLhosntaAiXgqjY2na3gDr43jlwqictXUYkWDXtarW3SYMNlrIY6uj1VBA6MuLZNe7rgkrJ3SxDRRpbrIzF6He4ElIYjWulpQyalEGrHorRGr1hYt9kDfcVVj0nhNnS9YGx1nfmuT5UP47o8tzk6DyeSOn5Qwar0nuJj99gYgI1YfpdbeU/iB1qrIYwFiI3adjBba056jH1NsPFxf/J+jXu10/QbvPXY0CakjN1LVAmp+6cFIds+pENIFlbJzJExZyyrVuFd2b42Dlkz+bRGTqQXFf7anXETmxeSTEDYwrK213zkjDWNSybhKKlBRjdfi7z+GMNrMAoTX5eVGzJYimTjYfFSGRCUbAaSJktWt9H22xfpD6DsHm1Xr+q5qQWHOjasvouvbM9L0+O1v5O4Gb4RaBDu825M4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7b0ed1-db78-43f9-73e7-08dce871437d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:47:14.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etchg5I00kTk/CZRppIoWQl4Z1GfW8j6Zq3Dt/nF0EZWE/DUa09ZetBppkJohTEk+5JixFbkiYXKqAxk9BDfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090091
X-Proofpoint-ORIG-GUID: tUeiiqUxp6-EEJZjlB3tp3t-y9DMZOii
X-Proofpoint-GUID: tUeiiqUxp6-EEJZjlB3tp3t-y9DMZOii

On Tue, Oct 08, 2024 at 06:09:13PM -0400, NeilBrown wrote:
> On Wed, 09 Oct 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Enable the Linux NFS client to observe the progress of an offloaded
> > asynchronous COPY operation. This new operation will be put to use
> > in a subsequent patch.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/nfs42proc.c        | 122 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfs4proc.c         |   3 +-
> >  include/linux/nfs_fs_sb.h |   1 +
> >  3 files changed, 125 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 869605a0a9d5..175330843558 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -21,6 +21,8 @@
> >  
> >  #define NFSDBG_FACILITY NFSDBG_PROC
> >  static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
> > +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
> > +				     u64 *copied);
> >  
> >  static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
> >  {
> > @@ -582,6 +584,126 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
> >  	return status;
> >  }
> >  
> > +static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
> > +{
> > +	struct nfs42_offload_data *data = calldata;
> > +
> > +	if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
> > +		return;
> > +
> > +	switch (task->tk_status) {
> > +	case 0:
> > +		return;
> > +	case -NFS4ERR_DELAY:
> > +		if (nfs4_async_handle_error(task, data->seq_server,
> > +					    NULL, NULL) == -EAGAIN)
> > +			rpc_restart_call_prepare(task);
> > +		else
> > +			task->tk_status = -EIO;
> > +		break;
> > +	case -NFS4ERR_GRACE:
> > +	case -NFS4ERR_ADMIN_REVOKED:
> > +	case -NFS4ERR_BAD_STATEID:
> > +	case -NFS4ERR_OLD_STATEID:
> > +		/*
> > +		 * Server does not recognize the COPY stateid. CB_OFFLOAD
> > +		 * could have purged it, or server might have rebooted.
> > +		 * Since COPY stateids don't have an associated inode,
> > +		 * avoid triggering state recovery.
> > +		 */
> > +		task->tk_status = -EBADF;
> > +		break;
> > +	case -NFS4ERR_NOTSUPP:
> > +	case -ENOTSUPP:
> > +	case -EOPNOTSUPP:
> > +		data->seq_server->caps &= ~NFS_CAP_OFFLOAD_STATUS;
> > +		task->tk_status = -EOPNOTSUPP;
> > +		break;
> > +	default:
> > +		task->tk_status = -EIO;
> > +	}
> > +}
> > +
> > +static const struct rpc_call_ops nfs42_offload_status_ops = {
> > +	.rpc_call_prepare = nfs42_offload_prepare,
> > +	.rpc_call_done = nfs42_offload_status_done,
> > +	.rpc_release = nfs42_offload_release
> > +};
> > +
> > +/**
> > + * nfs42_proc_offload_status - Poll completion status of an async copy operation
> > + * @file: handle of file being copied
> > + * @stateid: copy stateid (from async COPY result)
> > + * @copied: OUT: number of bytes copied so far
> > + *
> > + * Return values:
> > + *   %0: Server returned an NFS4_OK completion status
> > + *   %-EINPROGRESS: Server returned no completion status
> > + *   %-EREMOTEIO: Server returned an error completion status
> > + *   %-EBADF: Server did not recognize the copy stateid
> > + *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS
> 
>  * %-ERESTARTSYS: a signal was received.
> 
> I'm wondering why this request is RPC_TASK_ASYNC rather than
> rpc_call_sync().

I had a prototype that used rpc_call_sync(). It was long enough ago
that I don't recall exactly why I needed to switch to ASYNC instead.
I suspect it was because it needs to accomplish certain things via
callback_ops, and that's not possible with rpc_call_sync().


> NeilBrown
> 
> 
> > + *
> > + * Other negative errnos indicate the client could not complete the
> > + * request.
> > + */
> > +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *stateid,
> > +				     u64 *copied)
> > +{
> > +	struct nfs_open_context *ctx = nfs_file_open_context(file);
> > +	struct nfs_server *server = NFS_SERVER(file_inode(file));
> > +	struct nfs42_offload_data *data = NULL;
> > +	struct rpc_message msg = {
> > +		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_OFFLOAD_STATUS],
> > +		.rpc_cred	= ctx->cred,
> > +	};
> > +	struct rpc_task_setup task_setup_data = {
> > +		.rpc_client	= server->client,
> > +		.rpc_message	= &msg,
> > +		.callback_ops	= &nfs42_offload_status_ops,
> > +		.workqueue	= nfsiod_workqueue,
> > +		.flags		= RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,
> > +	};
> > +	struct rpc_task *task;
> > +	int status;
> > +
> > +	if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
> > +		return -EOPNOTSUPP;
> > +
> > +	data = kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
> > +	if (data == NULL)
> > +		return -ENOMEM;
> > +
> > +	data->seq_server = server;
> > +	data->args.osa_src_fh = NFS_FH(file_inode(file));
> > +	memcpy(&data->args.osa_stateid, stateid,
> > +		sizeof(data->args.osa_stateid));
> > +	msg.rpc_argp = &data->args;
> > +	msg.rpc_resp = &data->res;
> > +	task_setup_data.callback_data = data;
> > +	nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_res,
> > +			   1, 0);
> > +	task = rpc_run_task(&task_setup_data);
> > +	if (IS_ERR(task)) {
> > +		nfs42_offload_release(data);
> > +		return PTR_ERR(task);
> > +	}
> > +	status = rpc_wait_for_completion_task(task);
> > +	if (status)
> > +		goto out;
> > +
> > +	*copied = data->res.osr_count;
> > +	if (task->tk_status)
> > +		status = task->tk_status;
> > +	else if (!data->res.complete_count)
> > +		status = -EINPROGRESS;
> > +	else if (data->res.osr_complete[0] != NFS_OK)
> > +		status = -EREMOTEIO;
> > +
> > +out:
> > +	rpc_put_task(task);
> > +	return status;
> > +}
> > +
> >  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
> >  				   struct nfs42_copy_notify_args *args,
> >  				   struct nfs42_copy_notify_res *res)
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index cd2fbde2e6d7..324e38b70b9f 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -10763,7 +10763,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
> >  		| NFS_CAP_CLONE
> >  		| NFS_CAP_LAYOUTERROR
> >  		| NFS_CAP_READ_PLUS
> > -		| NFS_CAP_MOVEABLE,
> > +		| NFS_CAP_MOVEABLE
> > +		| NFS_CAP_OFFLOAD_STATUS,
> >  	.init_client = nfs41_init_client,
> >  	.shutdown_client = nfs41_shutdown_client,
> >  	.match_stateid = nfs41_match_stateid,
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index 853df3fcd4c2..05b8deadd3b1 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -289,6 +289,7 @@ struct nfs_server {
> >  #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
> >  #define NFS_CAP_CASE_PRESERVING	(1U << 7)
> >  #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
> > +#define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
> >  #define NFS_CAP_OPEN_XOR	(1U << 12)
> >  #define NFS_CAP_DELEGTIME	(1U << 13)
> >  #define NFS_CAP_POSIX_LOCK	(1U << 14)
> > -- 
> > 2.46.2
> > 
> > 
> > 
> 

-- 
Chuck Lever

