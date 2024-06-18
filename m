Return-Path: <linux-nfs+bounces-3987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43690D682
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3EB34495
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253C18E743;
	Tue, 18 Jun 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GY48jmOl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nhlrXTLJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962A18E763
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720735; cv=fail; b=EIMp6mLdjseIwuVCLGwDM+VRtR9d34G1Lh4fa5WOO7rVoUNHTWbLaC2ITIXD1cEywSKAKxDqdPFp9DlW+K3Sssv3uMW2oTlesScOsJ8Z4BW3CEVRsnX7llMnjNTS7MD0VhoWhH9X8Sz/L++yCJwuAHHj5CmaJLZX+gvuRopxd7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720735; c=relaxed/simple;
	bh=aESXwulXMdkG7K5QBwodcFaUAnS1MD4Ji60vyyJMjxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QB70ocZgehfLlpRu/TZ1dzirn/oc2MQ7fugf/5BMTyEBdiaghSPdbb91kA7PWntL9q+fnxf+IjPeUxD048JegLwKb1DWufFxmiGSErGziaIffS0rtGJuhWZXi8m0bBp6fRwye4+098U7rWysVMtuWNZ/fURT89mKp8/P8Z4Mc8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GY48jmOl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nhlrXTLJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tTb1004302;
	Tue, 18 Jun 2024 14:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7azMlyFIBeX2t+b
	ae3aKrsOe8dFVKlgK1EDlr7fVBvk=; b=GY48jmOldZssh9iBwwliR8/5xx+Qdtp
	zB9q92bgQ0CadoikOzPODw+EIgYvO/od629k3K5AlBNgF2D8duQ1Wi/2NX6369hk
	1EY/aHmhQWR2LmlRskBFmtR1fazes4PFSB8sDNIzGHSziQuOZlyaZDAZZFcbbiLr
	NpCT2tDJjGVMHuzIs1NxtX6RnXDLAtumF0EE3erd/p8wZ72/kkper10jF+9zx8Zc
	6l+K1k7p8uZHcD5BLTu6MCKTaSdcE2Xn6wKybtw/T5vZYBUxU3VNZzzJ12+QISmk
	Cwza666Wm+WN09scK/kIu8rHFC4ry9AyWDDzJW1nM2fYITIQi8R3AeA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc50pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:25:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IECooP007029;
	Tue, 18 Jun 2024 14:25:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ytp8eg1j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epCSCIwPv21VnDeljcwG8GUJ+BnGJtqGJbLqKtjmEv52O5HEHce1W1IWFVPL+rYyBKHQsr78g9tkPOPIzU/FtUhISD6MuCNLmbWQXzrpCbBJH9aBewJeaDSqjPLuxOsW75h0GVDn2M4KzoW+zWss80D2pnRRksmHqWhoS0wJigsopLuzI+fxit7XNYinuW+BRHJQQIgAoZk2Ztu7JvYltLIrGAgHcPKOST/pXM1xmBMGPqfQYnmL+X6MhFG+H6ollbiQgfKViJJG0OM3VQjg3qKn/J3SNVgEhJpZaLHd2Ii5Wod6hNNJPgZitiVelRQb6FG2jpqbnRyscyPbbbc7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7azMlyFIBeX2t+bae3aKrsOe8dFVKlgK1EDlr7fVBvk=;
 b=U6Bx5HhvngNH5P7MO0xQb6uV/N9ZdLqHqyGIw+qG42lsifWZAW4YUP6hkLd75twc4FhhlG81OJXIU7CTDl2g+qN+ZQwSnB5iOUH2XqVZtodqN8JeKOdEfjZasprJ90fzSgaWxRaA9ujQjr2phwahc1ZbWUNs0o6pw4mPcn/qGW10QxWGwKSorwJkT/PdWIW7NpHuSLAGoE/N2Q9BXpsd7TRgleWTgwutoVDiJr27kLAezEuf8MoR0LjwU/Obm+Wsd403PFvlsFVibLcnUj6kJgznfp+MJWUk5s7OQNoXqU9YUFg8FtKlLWk0cemEtoNIjJta50xDI/I7BhTqQ6hwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7azMlyFIBeX2t+bae3aKrsOe8dFVKlgK1EDlr7fVBvk=;
 b=nhlrXTLJTzi0VjtGBW5RAd1a6XAWFxYdDq92b2OttMLDMU0f6+EihngfgkMYpzDU+PHCZnjuWLIrZw0iSyryqkl442mrj1D63jB070JaGMcuQpBmT6OmClrg8bgxTzfKRwRProJzSqTo1mf0mEfkeE2TAqGPO5KKqtd6l2xu7R8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 14:25:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 14:25:23 +0000
Date: Tue, 18 Jun 2024 10:25:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/18] nfs/nfsd: add support for localio
Message-ID: <ZnGYz8FdBrcF0CMj@tissot.1015granger.net>
References: <20240618010917.23385-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618010917.23385-1-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:610:b2::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b031d9-912b-4ec7-6cd6-08dc8fa27d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WBu0UHQFSvoFVTPsgXbUAqhoW6c+oAhOcJisz3NOt4FpIeuK9CigEpr/fgQC?=
 =?us-ascii?Q?CKC7AY2wfOArShyAjpJlzwyJPDxzWAQi5eSmIp2fof6KRfqRfVfTKf1iWjlg?=
 =?us-ascii?Q?iGqiQqenZzUnOWrRlH3abOhTt1F4ZUV6GLj+o4YFEHKGsLQG2+a4qdaL1+Qq?=
 =?us-ascii?Q?e4SuRTbFpfzhzevke+pnsXysuAtK9XGXQikbwpsuhbgctJTvhZkz9wtIm/lL?=
 =?us-ascii?Q?tPokQY1w7OW1CByyH3OLChzPDcgH7r4whoGlTlXiT2YBOrDx5xCNDvc+2GOm?=
 =?us-ascii?Q?ivr60QhgP5jaqrxGyOskII7qnFkK25DUmEfWlWZ28Jni815bb4CDO0IJuD4N?=
 =?us-ascii?Q?32weRPH1Wkj088g28jukGTzhy2oHK1/1uVp1QWt8/L4kTxnd7NasmAHAjKnj?=
 =?us-ascii?Q?Ts9CtZQnZjvIxYkiSJJrvkY+cJRx53EcvbJ1pprG2bB0PVIEdcMIpaSLDAEn?=
 =?us-ascii?Q?1K30aohcChC9v0lQQTOKgjScy21RhXsQvH0CqTgNGsOPJKvUfs3HR/3d3o51?=
 =?us-ascii?Q?6m22y5m8KsrO388D7z9YHqQMFFUvRfzEXjoUTmPPE9Hs+Uy4XZ0/IMGjv1ku?=
 =?us-ascii?Q?mPt10o+ywjyGL3V2dHf/K67igyvU9zID+gAyJ955w8vzqvDY+WDnS8YUm3EU?=
 =?us-ascii?Q?i3e2pR2O9uZLHMrdyym5Cp4aErxeZ/MaRhqr57CuvIjtzzistBA0W0YXMFYw?=
 =?us-ascii?Q?Zd9NZGicgWqOAhs3z5d8BH9e+DEB/fm/H4fQy6iw4oyoN52XBZQ7PjLlV8/3?=
 =?us-ascii?Q?ydy5je/RiZ+XcTorUYlprnVk5rGOMqlQDRPzMaegvhHGMu9pCrC4j11y5XD/?=
 =?us-ascii?Q?mzdvJWqp8Qa+2mFW2d5AMP/u+eyqAyxYuZoSusi1X/qu1RyAeAevDdfKFq4q?=
 =?us-ascii?Q?vIKoOCQhzpDmDsecaoMjSZOHwc4oJRGz0FmLESthbEEvKWgs0NW/70E44Rwh?=
 =?us-ascii?Q?RXYnz8Lc1XjCXOF9z1NHylosGwN4zjJdxaI2djMuNGOjIEm7Vjqv1aGKeLgc?=
 =?us-ascii?Q?Mf/UiHZItm8QJDChXHWLxf1yTyUYcBxQnUv8VkUcAmSy0+5sq70W4GUF851N?=
 =?us-ascii?Q?X+6cBo9MXiqlRcMeTVB1djJ068BIXh0g0toksrbYtu+gJ+ELp8Hq9NvInVtB?=
 =?us-ascii?Q?S+OUhjEtC1OPQjElprYxUH3jbgI4ZAa0jeI1igqDwklX7Nz74ELKecsmGWxu?=
 =?us-ascii?Q?BFIX2qrqsTjnXoesf5f5/kmeAt8nngfBQxArDXHoNRW9w/dJTmROuAagxw9g?=
 =?us-ascii?Q?SplCIgxN0kpq/XV0oduR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HHcY0xVvfP5FDMYTyUGn2vhil2GfZWP2yhNVu5tcbLPUOi2syFK3wsKFbLHc?=
 =?us-ascii?Q?rCh1F8MU9MG640oscrtWkvjZOeyil9Kmpbd/CkARC0QWeeeM83a6cJRzkvSM?=
 =?us-ascii?Q?QEeCp5xbBM0WmbeVCO6ZDBUGTcj/SKv084IdVZDDGyWUJZuiTvKKoJ9mybi6?=
 =?us-ascii?Q?xcv65NSdztQSKp3SYuj/49IzHRv6HGPELKkSQwz67uih5ffz+frw6nAZkg12?=
 =?us-ascii?Q?cc1XGY/o4l4FXmGMLACMvenjAJ7IHc36wkgygt434qv84MEiBCwQ9H8/7NQH?=
 =?us-ascii?Q?lsItCs9F+AwcMYNeYGsUtePITHWWFq5BwpQo8rw8SE7H/8ya6umQ0r6iw//x?=
 =?us-ascii?Q?exOe+ACcIGVCEqMn66YlovHnnVmWS28kVHadmkM3cp/iUNpJmL765jMeXFG/?=
 =?us-ascii?Q?IjBoKGlMAbTyu8o112rG7LdqIaLHkyMtSBGlX7wuMRFktsS7WNR8nzMSINtD?=
 =?us-ascii?Q?XsDp/XJiIpgBa8KMGUUqyP6LRwCeySsO4Mp+8eWxIi+5oNded31lAiRcaowY?=
 =?us-ascii?Q?+1ifavK/xHn1C0SyMiFSZtJCYpRfFOtMqCnHMwBfdv61PUnDr11gwjEDgIKT?=
 =?us-ascii?Q?Mgxh/r7yOn57BerWHPRT+hHI8b4GKzrtv8LNecqLDB49cjF69BRZrVIgdFug?=
 =?us-ascii?Q?rl8W7atawKghBh15DVbjyO+zFeCIrEkU1Ms6Jk9DX+QqtSiReRpR9uAHlNuc?=
 =?us-ascii?Q?Jrq+7xlSXOSVxAS38fKY7+6yr0v+uLjoN6vgN6fttmhRGAOiKnvDjnTvGvzc?=
 =?us-ascii?Q?s+ZiwZ/Of+flMmRuYtcUCoYKRCiEiMwzp/r8XM0zGffbT4Zr5jdt28RKuk8R?=
 =?us-ascii?Q?JW9pNnqjW2t8k8iOCFaJhbdpiPMdxkQyh26f+uwbaetCl5sMZXyPS3Aes5Yi?=
 =?us-ascii?Q?7e3B0e1XzWEiQrTWkG3oHLlwWNqbcvMmToxSojs5YYjT2EQFwImh3ki0WBK+?=
 =?us-ascii?Q?Ni8I6Rl4wxylS643Le1IoY+TRi7RF3fcnZtivBQXl73teDWZbnouq4BEcMKg?=
 =?us-ascii?Q?FwliJA9Y6NYgSQlyj5Oz5GKQBbwwRYPAZ0lJ0OCWUKEwRJAz0YfDUM7f6FbV?=
 =?us-ascii?Q?Av8swk9i0ralgjNsIVjXiVHaarkD/IauXJ7p+HpRzwtD4xSbhcNGdjcVE4uP?=
 =?us-ascii?Q?vCc+c69rDo6MYD34M/UJ9sNrCPnQ53xdqDXCzAxO3TRmxLN+GLs8dk3cVUSE?=
 =?us-ascii?Q?k+PoUylnlH7MShoP19B9AJECCJyUrHYMVDT3cQ7dp5Wsnqdr98T0sSlt4LRS?=
 =?us-ascii?Q?SwLPXRilJse6O2C+jay6y1Ozvo58IklJMf5ZLxQl7rW6RuCceYXaUL+2TSZ4?=
 =?us-ascii?Q?hd29nJ9TwHxgz+rw7W213ZYVrsa/PqLqnMzb8U+kCG+eMb/almQT4dLdCGHp?=
 =?us-ascii?Q?DeG7noWUbk2GQYMba1Njqql8xJhbV605hEoLkSmMVcilEsNxAzHjbH8behiR?=
 =?us-ascii?Q?6Ixfiw/a2rjPU6VM7q6jWEJeQp8uZm/iryy7VY5bWuFR0H/snngzSlxEBoPm?=
 =?us-ascii?Q?I/2w2/8x2B9ECQDqeTMC3j5y39cnPwaeAhbMpkCCKZgFJSUhAixNnxYb6RWh?=
 =?us-ascii?Q?2z6ZKZ+YtyVMHVPj/djinwVp1NXqWJMEeMriPSCjZtFQGpcIPBU3ffPMKIQv?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zFThfGEi+ykYrPhYHQkqAgNjbaHoZai2cfGJsJv9huRj09L3KCZar5y2NMNzha7yBHdrM6d8WQXyZcl6enxA+T3QqMcy/xIc15QBLMrWt6gKghhl2NqoMoUMjQ5jncO0cA9cpXJ64hmGZaIYeMX7D9pHgDwrroORtP232tm8WDbbDkgi6MnonE/T1Jzpwc0JvVSOS8rdSRONK6QKLTopca8T+krZcInF88IeRoMkS2SJGVylfZ2WW8CmU4WufeTiKuWT95TujtAyU5G/vIaae7XEjwh4djltGiR7hpqthXtexRtyrlaPTU00tMHmk7hCkd01aXMRHPzUG7fibpQMCg2K/EmWfXL8AOgbVX3he3YWieW9Lyo3UmEdB71e10sPM6o3YD/QAZDvx7OOZbU6gEfnKmBdpCkj2tE3H9fA9Yqs3V7msg5Sj15Dh19uUsVQLFZl+k/e1pfPE+Rmuor7dsSJQdBz4wMcTPGM2bhXY+hsQrv0U7z2O2g/YqLGYjFWsJgIJnvWE2kzcQKIouPVsi0Db53K3kdCswZ4CZJY/l224u912ecwkYAsbLgpT9ieRWqCd15c9NVtlWCz6DP+hsn0B9b/Rt1w2uPbOkHIAKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b031d9-912b-4ec7-6cd6-08dc8fa27d59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 14:25:23.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg7gFFGv54CeegNH6FaYXNl9siGZvnw7/uXJ6F3FSR00fSvZYpZ6ys9pm8P1aaBkCnoFVyaymdFEYRQF/+RR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=958 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180107
X-Proofpoint-ORIG-GUID: GJ3iqlyLHIxzaQak2jpt1-rELZ6zbla-
X-Proofpoint-GUID: GJ3iqlyLHIxzaQak2jpt1-rELZ6zbla-

On Mon, Jun 17, 2024 at 09:08:59PM -0400, Mike Snitzer wrote:
> Hi,
> 
> This v4 fixes a few bugs in v3, reorders patches and improves patch
> headers and code documentation. Please pay particular attention to
> patches 17 and 18.
> 
> If all looks good to others, for v5 I can rebase to the -next trees
> for nfs and nfsd.
> 
> My git tree is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/
> 
> This v4 is both branch nfs-localio-for-6.11 (always tracks latest)
> and nfs-localio-for-6.11.v4
> 
> nfs-localio-for-6.11.v3, nfs-localio-for-6.11.v2 and
> nfs-localio-for-6.11.v1 are also there.
> 
> To see the changes from v3 to v4 please do:
> git remote add snitzer git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git
> git remote update snitzer
> git diff snitzer/nfs-localio-for-6.11.v3 snitzer/nfs-localio-for-6.11.v4
> 
> These changes have proven stable against various test scenarios:
> 1) client and server both on localhost (for both v3 and v4.2)
> 2) various permutations of client and server support enablement for
>    both local and remote client and server.
> 3) client on host, server within a container (for both v3 and v4.2)
>    My container testing was in terms of podman managed containers.
> 4) container stop/restart scenario documented in the last patch
> 
> All review and comments are welcome!

With my NFSD maintainer hat on: I'm concerned about some of the
long-term maintenance work being added by this series. This is
more of a concern on the client side, for sure, but, IMO:

In a perfect world, we would have an RFC for this, and the set
would come with tests we can add to our release CI framework. I'm
not holding you to all that, but I would like to see something to
help me out in the long-run.

Because this is not part of an Internet standard, this patch set
needs to come with some architectural documentation like something
under Documentation/filesystems/nfs.

It needs to explain the use cases and why this design was chosen.
It should have a specification for the LOCALIO protocol. It needs
to explain how to test the facility being added -- basically we
need to know how /not/ to break this thing as we develop around it.
I'm also interested to know who, besides Hammerspace, can benefit
from this facility.

(This isn't a hard objection, just a request for some help with
the long-term maintenance burden).


-- 
Chuck Lever

