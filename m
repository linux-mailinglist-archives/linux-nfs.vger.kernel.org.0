Return-Path: <linux-nfs+bounces-4350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AE918ECE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111C9283212
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED114D2B8;
	Wed, 26 Jun 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXYLBrNc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6cJxxIR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57505144D2D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427768; cv=fail; b=PgtoucopuHANblRpGbya8ogvqTO0XS7fRWda2th6hIpzt+7jdnsiCz8pKKKvpmEmSq/rCtowRMb5UzpmnRGFAnH0iDxQu832q6Z7hrmQr8AzkXKhaZ8KDNyeukuA+lRn0vbwmdEd2XVyJTdG6eANPqV40cPYAt1qojeAi9D/jMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427768; c=relaxed/simple;
	bh=8FmgkKzC7QDxpM9O7yfIeNeA1bqyBl6qPEyWkdQPUCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R9XRdBlMpGD6oILHLVS9vbx2JiLPuWKGmUxp//WVsb6ihfyiTMVoh4Em1FqF3ajAHRiok1C1MvIene0pfZ7Tk7uR/H/AfFb4QFy2jQVgXChyFM4APtLRkeXGMi5SARfBw+i/g1sumR4efLEqTUjFTCBrS7cHVQxofnplCuTuLfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZXYLBrNc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6cJxxIR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtUAh019623;
	Wed, 26 Jun 2024 18:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=McptOWpbBaLxhpN
	KluebqOR1wJplLSU+NUJMSyFHjks=; b=ZXYLBrNc2XPgkppFEnB6v+Y51owzwEV
	Y1/jPWIoFLCpI2JES+PBg5ONbbECyuvts6ph5cmMlro7xupc2vwd4t/0o0MF994X
	8EmNJ90nefj/jAE89izYNX/tB2D3x0uc3j4cPN+wqcBxMEiewsBFWnLvXoWhLhyH
	6VhiFAxGMmNqBwh2qKMuT9/2arBQf7nNSF546A48KSU121zwD12KO3qkJyeMVjhX
	Apn0H8fWRzLIOsgdFqyL7+rv/3FqPEcCpKSFb+fIWwwul3TibyQdVslMcKvEFFaa
	tFvFq0uw7ODQhD95gbRMA21eB2xKhItv8iE93vqloCP4qsqixaYp1ug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sm35h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 18:49:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QHWiZi023314;
	Wed, 26 Jun 2024 18:49:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fxatw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 18:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK+RzE07KaYCiEQb25keL0i3impkTV/9keYwtjIVG1hPcuffLGtKcAeS26Wk9g2jiuk+2AI20YLhG3vNw/oaVAsvnk/7oMGWYkVUs7V+dbVMUsggolWZdRtizMHHhp0dW+gsP2LiLKYL28EZisreMuPq2ZPqMKrOqF858XTk60AXnziYM/gKd15xWaLDhIT+NwqgxYArY9ehoscs9EBTrbnYR8YzWhkVx0Vaf7/1C3GSAGRUN8ArRDm8kRi4QhKg4g7kTkMcvbuwaD5+u1n9YGCiOkB3/a3h+n7s22vSZcWxvX0cNxXXWVbmYKxGRJJ15ZHBgwcTk3fvTi5uXj1iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McptOWpbBaLxhpNKluebqOR1wJplLSU+NUJMSyFHjks=;
 b=b9mt2TsxRhBEy2WQO82Li2VVdhcG6KvC1HdatKqYzZXepgzsDrfjSlU56uaNKC5snc/uknbtBnYwrHuO3yaGk901NT+3VmCruDB0EnvlYPLH+0Jpu10syWNHAAuvIiJsb9FT2FSEbgVtjJTEcCDHEv/BNq6eG2dSvOeAAsxDajLKcWyJnuxB78PitC4UFik11HfH96EZSrv3Z+n7rOKhCco9i+DGmWjfzLC3eSQpNrCYkFhK0WUvPsUyyj2k1PguGdyr2vgwLPj0m6N30GpVj9crOMnmXL5C+dZpTzVt0bIz9hsKFWdmS0bA/2rPk2a9NaWJPpjxN8hBlx6eOdFc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McptOWpbBaLxhpNKluebqOR1wJplLSU+NUJMSyFHjks=;
 b=b6cJxxIRBcyjG63qnDwRmM4qHlXgInj8OS+jVW2s3qeJmvhp+C+exZMP/jVKtF7AHdqYKT7jQLjJHN95Bw19nDTn5gASFd3GFxVmhwY0ciL2VgG7WRr+VRTaKZdHsYz6ymmfI433uRp0xPTH93jmxw6sUHWKRnZBLfMaOHVbfjE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4440.namprd10.prod.outlook.com (2603:10b6:510:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 18:49:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:49:10 +0000
Date: Wed, 26 Jun 2024 14:49:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v8 00/18] nfs/nfsd: add support for localio
Message-ID: <Znxio4K8yHfNst7O@tissot.1015granger.net>
References: <20240626182438.69539-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:610:51::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a62475-5a54-4aa3-ee46-08dc9610aa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NtPAlH2orZ9vwo9Ld4WODroyiDiiY6NSRmhE+OMhWIW7LXGD8e36n5K6JdtH?=
 =?us-ascii?Q?QfoBgWvqLIhOGm/TuMF9GnFxUONRDbC3PemL5dof33hm0eeM+3Ix0JjBzgPr?=
 =?us-ascii?Q?If9ftrXbrJiOhZUUnzWjQRky44go07K5ZMSFggTMPKP4VR1Mw6QtMhyH05wM?=
 =?us-ascii?Q?OEQbkFTNHE1HSn+L1zyEnHiqUj32XhWb1tNrHaPojZ+a1fBw16TBqovO3WJG?=
 =?us-ascii?Q?jKoSlLJcIWPQ6Yk6/wic0HjFDDO0bcpbQv6SzBQCjnveroouDk64bqJ0rX11?=
 =?us-ascii?Q?E0WcACspOzzWZKL8KQcfQEZGk+yK2QikfljjaRBtWePTI12YC2oYy7t9Wa5o?=
 =?us-ascii?Q?1+ttd00yL919lAAhwdk/HGqjUpRs1jlqZZo8DyaqQv+q+rH0vEiMb5S85FX5?=
 =?us-ascii?Q?GCcyxLbiP2TswLagUDeJ+qCumUfbLQxvPVqOA3PQFlnCQbBeqwUCntdh8eNu?=
 =?us-ascii?Q?j/dsw84+vI+XtZyzFfNEJt3pNHewxa8wwkl0X768XKb2RMCFPJ+jYm+ceYLK?=
 =?us-ascii?Q?kiKUm02PVDIYLG0XeCYWQEMEt6BlUMZ9z9WZHkgDgK4RrkPd1uXLfPR++5gk?=
 =?us-ascii?Q?PvloJ8x88qRN0SgcvCX7/kTyOTCbASbevIBZl9ZybuLovZTPgC3HIVI0anPa?=
 =?us-ascii?Q?cVQui590b0eAwUGIHaaT9SdyU6G6YWSb6PM+7BSKuJdEgPc6obQniF9HFdcE?=
 =?us-ascii?Q?4xvt6iAz79k0qTYXY6bIJxE4HJ1G4sOk2UFyP3MtWsEpjML5Nk+f15Mm1VWg?=
 =?us-ascii?Q?XECKxwVVuTZhIaOXj2Su+8n9syOZPfwo1NRLNahWny1KsQ3Ae4PtAD6N+2Jw?=
 =?us-ascii?Q?ZGdMD78H5lmGuuwxsJNLfaT2A2HPBdvQspCQVhmjPdUkZIU8Jjc+I4+LHq2I?=
 =?us-ascii?Q?b5Pvli1LD+p3KIISsrYvWW879lUaBkx2NExV+EMLG18sUMWL17fSsRZ5LzIv?=
 =?us-ascii?Q?xM9rNaGzbO8aoulw9//KdIIqqS2jy1pHAwSfTezhBaf5ECaGnAMU0fMyYFsY?=
 =?us-ascii?Q?VlacKf+8Dux3X0AC236PEk8rmmT906ByH2gU5PNfUr3dXEXeOkiP+FMqPJso?=
 =?us-ascii?Q?B644XnpO9VYICcQHS/vNmbyUGvwbtWoDkgYbgZhB5epLDHnrAPcnqDSrT0Qd?=
 =?us-ascii?Q?1hgX5aXUXLVNURDddJqam6vEG9wBWQVnf4m9YbaFtgcLCpPvyXFsf7AcJB5q?=
 =?us-ascii?Q?RAnON//fjoqcOI5dg5SlH9sMypNZB0+Xj22Xym4UPFh1W/1rvM50sPXnvOoU?=
 =?us-ascii?Q?pkX5qiydKL2Xjck3Ejcg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b4iyeHG1skQHs7imLwSysJ92LA/IfByGI6FEP/9kB+Ws+ZehrzNmj5EqMq6f?=
 =?us-ascii?Q?X8+qAT0xgOB5epyrkOdNkJJU/hhgBaenuJw3nyGlrZzSRxuxn3+v1jlLumo1?=
 =?us-ascii?Q?JT85BNuUb3YPyDNa9vuf81t35QIpZtWY1f7Bk68Qj14g3YLIzRQr5HR9HDnq?=
 =?us-ascii?Q?wCDHDL1AMfoafclcZf56Mhiy9ERliCaw1r9//eBPfiVIRgEt0lCJfDuPsbWI?=
 =?us-ascii?Q?HcXVYZJktUjmYok6qUIBy36IGkKROtlhDw7pJ2yROs+T8VOCWC6PQJXD6HaU?=
 =?us-ascii?Q?5BwspS14+q1FKHyDwBj7bsLFf5YKdptiKrR0gdS7khVz46PFPzlRXu7qDWGG?=
 =?us-ascii?Q?f+qQeFiy5FXly5/JrKqMbAgBdSwQ92ivfjyGXH3dldYhpqH4m201fLTWSEno?=
 =?us-ascii?Q?wG2vD2ePpzbCFkhTrvm3qrA2zEwkpKq3vw5IVSvxSszVC7eOMT6bZ7m/C8kh?=
 =?us-ascii?Q?PVp2gc9SWwwpgnteJ+/lHUNEhsDjef0KC2+GpK9Du+9wWyi1F9aXfM16X/nq?=
 =?us-ascii?Q?j9Uld6xQDKH/EFmphE7CiidbUf+wlaltJNdpURsvu7fMZ/ahtZnYBKY7EGX6?=
 =?us-ascii?Q?4feDXXp8na/lFG1q5MtOv44g5ha2yw4S0Ib80rFkSS4vemHQjtLwvQesZXNh?=
 =?us-ascii?Q?ilVhgv2EYQ9m6Vztc27iXHu/qesBA8G65+w7eDrbfC3zYznzB82lYQf8Ubjv?=
 =?us-ascii?Q?cf28MGPmqqnxNsCYtoGpfpH4HDIUatuDW+xwbl0ooOpAmx4wfGtY3k1ym/ET?=
 =?us-ascii?Q?1VjQq0UAbTeJChUCDpeUUozLWskH1czjPx1tQmKGNUomaDUM6Lr8Xvqzcvzg?=
 =?us-ascii?Q?FVjXjNysdaQjhSnJ3G50p1zdhWqTQrJxtyhdaehOeM5yYbwotrzCjKGC7cWv?=
 =?us-ascii?Q?qF6Dt0KJ4GezVbW2AoBYxt3Yptvzf9C9MPmwvXpuM0DjJ5fubAIl7sKpgcil?=
 =?us-ascii?Q?bHsnzDItixz1UTZt7EU836hVRCOvr1T/ExKhW0C8zd5/oBhNb6A/+0U1/tjZ?=
 =?us-ascii?Q?nsTERmDoJjDHHXT7WOxdt7QVZsrw6c4pvta7/lb0Fg64F781JfNOVmAXHrDj?=
 =?us-ascii?Q?/CiyKVfhIzndmH0sL7nfJjHlTTjaE5JfmEHwnzn5nWO8EtISzqP1dQafm7wl?=
 =?us-ascii?Q?mCCiKnOfotmOyRpROpXsE7rE0G8jM3Ic3RI9fzTVy2jC/YJxccDdDVPaPfe1?=
 =?us-ascii?Q?QXDoe/gMbxB8Mq5SulZbknxSaE4lW0Fid2CUtptKjNR9+kxU5qllDqWKyHoZ?=
 =?us-ascii?Q?CFNxOQJ1LcOh4VUsBKSrlKGx6WRWkNAZfF09ptSWZVAe7kg6E/uYA70sd2Uf?=
 =?us-ascii?Q?7VR6KpIu8OoNJx/V+zKv9DDVuDV7Kc7KDMTZJ3bzfp0FA+CmimP6O+o5EdrC?=
 =?us-ascii?Q?m7QDruLfuF+vi8QrIiNLiR2g2/bKDsJBgQWpIAqA1bP0bzPjF5GG6oio+yRC?=
 =?us-ascii?Q?I5V1yxnzYTaAnx4hWwiB0gJxLtEgKenjD7UMNS8fBQOZyqb///CRZ3dG84H7?=
 =?us-ascii?Q?YhfLZUZzshVfvGHXmXeMyprOQ3zHzY1GUIQMYCKSLFEBiM68A+mADLlCioA1?=
 =?us-ascii?Q?fHk+VbxriIqMFrKMni1oBkqQJmVFcZkZvB3TIZNR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hbE8AgDSrvBJl9WbRHsiFHf5OF73eo5Fmt9uJ6RQo+sCWPk3MFzkfTA3ow5MPOntZ5FFowfXnCFQk981r4rM8hC51SCYD+jZNFvP49X1HUScWnaS+hEkCZfnnySEJCv11AKRNobbzBJZpn95CG0WkfpE6imBXuHGybqEViH56/86PnsDGi/uS6GzINwuYVtBXm6PL1rN0e1EQ+HUJNY05mwXdOAFCwgUR4fND/ckMsbBVZyPpAAl+NWMy0EO+xD4KXNntpLO1ZjhmlPwxEEYpaee+oO2OvnXRYHHHr7CTAyswkcDYRn3UqrNP30Ed/HL66MN9/u4TzdRXdwPyCzRNvg6ynXKR5SFPxQgDlwcHlSf2L4uurRmmMj8S84dmQr97zftjkPudzO/ccGbhEy9wqwylZgJ7qi+ELvvI/PA7lLR49dYYLW0oejqB2Zr0GKdU8W9K9oUgY65z6eZW/GUl4FuGT24iomfr8qxdOxmU/+DFmShDE5rfwYn9xLKtO0zG73+3GJAPO4qt3qw5E6TsVehwAIvjIChL/BHSPD4sWQ/aehNiwu3IqwN8Z7VLUaxCuGbfUchhljYb5Nbp1bxxW/ylMHmF/93sVRPw/ADTGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a62475-5a54-4aa3-ee46-08dc9610aa66
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:49:10.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHUniY5T6teYsem9l6HPULB+sFl/1MgkuybMJNNnw+mu64tGeC6xdYeaRdM2GQ7mLhYaXb+RcLq6iOzxil3b1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260138
X-Proofpoint-GUID: hEl2FxWpyI3zBWblPCQ8F_DmgZqMbYeI
X-Proofpoint-ORIG-GUID: hEl2FxWpyI3zBWblPCQ8F_DmgZqMbYeI

On Wed, Jun 26, 2024 at 02:24:20PM -0400, Mike Snitzer wrote:
> Hi,
> 
> Changes since v7:
> - Switched from using SRCU to percpu_ref to interlock
>   nfsd_destroy_serv() and nfsd_open_local_fh().
> - Dropped the "nfs/localio: use dedicated workqueues for filesystem
>   read and write" patch, will revisit if/when needed based on evidence
> - Changed NFSD_MAY_LOCALIO from 0x800000 to 0x2000.
> - Various renames in fs/nfsd/localio.c XDR code suggested by Chuck. 
> - Fixed localio_procedures1 and ARRAY_SIZE  suggested by Neil.
> - Fixed nfsd_uuid_is_local() to dereference nfsd_uuid within rcu
> - Removed a few dprintk in fs/{nfs,nfsd}/localio.c
> - Documentation improvements suggested by Jeff.
> 
> TODO:
> - Must fix xfstests generic/355 (clear suid bit on write)
> - Must fix localio's nfs_get_vfs_attr() to support NFS v4 same as is
>   done with nfsd4_change_attribute(). But first attempt to do so was
>   met with a crash due to the extra STATX_BTIME | STATX_CHANGE_COOKIE
>   being included in the request_mask passed to vfs_getattr().
> 
> All review and comments are welcome!
> 
> Thanks,
> Mike
> 
> My git tree is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/
> 
> This v8 is both branch nfs-localio-for-6.11 (always tracks latest)
> and nfs-localio-for-6.11.v8
> 
> Mike Snitzer (10):
>   nfs_common: add NFS LOCALIO auxiliary protocol enablement
>   nfsd: add "localio" support
>   nfsd/localio: manage netns reference in nfsd_open_local_fh
>   nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
>   nfs/nfsd: add Kconfig options to allow localio to be enabled
>   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
>   SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
>   nfs: implement client support for NFS_LOCALIO_PROGRAM
>   nfsd: implement server support for NFS_LOCALIO_PROGRAM
>   nfs: add Documentation/filesystems/nfs/localio.rst
> 
> NeilBrown (1):
>   SUNRPC: replace program list with program array
> 
> Trond Myklebust (2):
>   NFS: Enable localio for non-pNFS I/O
>   pnfs/flexfiles: Enable localio for flexfiles I/O
> 
> Weston Andros Adamson (5):
>   nfs: pass nfs_client to nfs_initiate_pgio
>   nfs: pass descriptor thru nfs_initiate_pgio path
>   nfs: pass struct file to nfs_init_pgio and nfs_init_commit
>   sunrpc: add rpcauth_map_to_svc_cred_local
>   nfs: add "localio" support
> 
>  Documentation/filesystems/nfs/localio.rst | 135 ++++
>  fs/Kconfig                                |   3 +
>  fs/nfs/Kconfig                            |  14 +
>  fs/nfs/Makefile                           |   1 +
>  fs/nfs/blocklayout/blocklayout.c          |   6 +-
>  fs/nfs/client.c                           |  15 +-
>  fs/nfs/filelayout/filelayout.c            |  16 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
>  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  fs/nfs/inode.c                            |   4 +
>  fs/nfs/internal.h                         |  60 +-
>  fs/nfs/localio.c                          | 793 ++++++++++++++++++++++
>  fs/nfs/nfs4xdr.c                          |  13 -
>  fs/nfs/nfstrace.h                         |  61 ++
>  fs/nfs/pagelist.c                         |  32 +-
>  fs/nfs/pnfs.c                             |  24 +-
>  fs/nfs/pnfs.h                             |   6 +-
>  fs/nfs/pnfs_nfs.c                         |   2 +-
>  fs/nfs/write.c                            |  13 +-
>  fs/nfs_common/Makefile                    |   3 +
>  fs/nfs_common/nfslocalio.c                |  74 ++
>  fs/nfsd/Kconfig                           |  14 +
>  fs/nfsd/Makefile                          |   1 +
>  fs/nfsd/filecache.c                       |   2 +-
>  fs/nfsd/localio.c                         | 329 +++++++++
>  fs/nfsd/netns.h                           |  12 +-
>  fs/nfsd/nfsctl.c                          |   2 +-
>  fs/nfsd/nfsd.h                            |   2 +-
>  fs/nfsd/nfssvc.c                          | 116 +++-
>  fs/nfsd/trace.h                           |   3 +-
>  fs/nfsd/vfs.h                             |   9 +
>  include/linux/nfs.h                       |   9 +
>  include/linux/nfs_fs.h                    |   2 +
>  include/linux/nfs_fs_sb.h                 |  10 +
>  include/linux/nfs_xdr.h                   |  20 +-
>  include/linux/nfslocalio.h                |  41 ++
>  include/linux/sunrpc/auth.h               |   4 +
>  include/linux/sunrpc/svc.h                |   7 +-
>  net/sunrpc/auth.c                         |  15 +
>  net/sunrpc/clnt.c                         |   1 -
>  net/sunrpc/svc.c                          |  68 +-
>  net/sunrpc/svc_xprt.c                     |   2 +-
>  net/sunrpc/svcauth_unix.c                 |   3 +-
>  44 files changed, 1951 insertions(+), 135 deletions(-)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 fs/nfsd/localio.c
>  create mode 100644 include/linux/nfslocalio.h
> 
> -- 
> 2.44.0
> 

Shall we start to think about how to merge this?

Should all of it go through one tree, or can the NFSD pieces be
taken via the NFSD tree and the NFS pieces via the NFS client tree?

Trond, Anna, opinions?

-- 
Chuck Lever

