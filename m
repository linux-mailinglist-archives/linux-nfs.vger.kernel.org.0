Return-Path: <linux-nfs+bounces-4717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5546C92A528
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20091F233F4
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6913FD69;
	Mon,  8 Jul 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCR0Zx3M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lkthPzaj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF014140363;
	Mon,  8 Jul 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450358; cv=fail; b=Ai8lftoPn5/VjLmpQb7kpH7PnVxv9oEhyl0IlhNpwZhTK+XSBXoO3oF9aCKWIhcXfBjQWLbiTJ82rac32McMemy0UQ2XmDmRv0dTpfQXbIyLlmcjTZOczW24pnr0e73EPtNpH2wutyshjZJEie//kK8kU/RxgHQorH0JMo+yU/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450358; c=relaxed/simple;
	bh=pav7E5X/rJpuTaoAm1plvmM158gZcLb3czruPy8fGEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GiJok4Opcb67uFW1NYFYKTTefP8VyHQfClnVJW4++05fPewd1mq/1ENv1yX+rGNMi/SkvU/sVQ3qkCpveJnnaH144yeHtv1kc7FH7RVpKenxY8aby8dNCfjqJRVJ14C7FULl5wGY6EP00Awf6Xkqt4pWfigUJ91z8R71vzWXIB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LCR0Zx3M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lkthPzaj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fVJ4004189;
	Mon, 8 Jul 2024 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7StahTKre0/94sm
	22V0J3hiu88xff+sNIJpgpPE66QM=; b=LCR0Zx3MEjS4bpBNUHMmRRJG+mLE8M6
	DQnn82GFFx8S6fOEcVm86uRUiJA3LHx3ZpHn2bvU7Q5Q1abT+j11msoeOkMYskb7
	y1xjfEUmufGfWHpzUTbEBC7LY9yhy+NLCisMPK1xtIv2b9QV0BrfY9AT4TBxNrUV
	yhnvzPBsTdb1/v0Cp4nV1ZobV+18f7y8gl9yY4exPiGqQNoxKR2l2e6PpV5wB0rH
	YpA70bqVDRqSaPdOrL7fYErrluiaBpFuayzucLLgXEv0zqCpqbKMlaWfuPH+S4P6
	Aguiz1teUjbeOSsA9heRtBB8lvbszxodGGz1JIXlWHQjThXjFIE3ZSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8ath3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:52:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468EFVjb036244;
	Mon, 8 Jul 2024 14:52:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tuytm78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSuzX9E8ptrbExRVDOCE8ALAhDONrxP3twtOcfGmYVRlPRDqOEvhxd4jz64WYZHNXq2R/s6Ftuczuh/JRVUl05SxVVC7byIlfS35vYIb5JRgT/ktFE3qc40+EE308GMzoSRqMJVz8DfQPt1EVYUAHKSHF+ZsxjZbfZ/TjBZspzhz7rRJT8sTBhiGUUje9+d4Zxhb6XnjPtLyG6A0RJY/1+KCNVTWAczE98xEAArJMElVaI4qpEylU2BFW2pO7DmLUrg6fwZGe8Q79R6jKpJwuhhPXvmNEjhLGk1i+YQ4ETMvtgR23PQxTKcfib5riV0+EwDB2f1c2rayoy1Bp6pyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7StahTKre0/94sm22V0J3hiu88xff+sNIJpgpPE66QM=;
 b=VXnA8dFULA8Jis1kUiCTWpSNdSi45NV5ChbLjhAlP8JekQctYZ2Yn1k/SRJqHyqJFxWenAO9PKhI3EXYfA53ZZ7EibqZm2XiC3uaMlDD5Xma5FxTJq9887HkQ61my5jN7KppvQ/KTxKiNgKx7LIf2fiiHQrpHl74gGZK3qVBKECF4cAtF6ZFE9n4DKF7kcxoUa8G4uGnRjdxeBJvy8SbBSEiJL0aSxHmB/9P5ZrbT+oxZwJUbel3qVq23dW1jgBXJaooT1M1RdTBHEI93qfUIvvQUk6wdlc7PEU8TWq7V8IFXhrRzlMemuYE1gHjUdjGnkf5IvwemgxoRbzVT7RMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7StahTKre0/94sm22V0J3hiu88xff+sNIJpgpPE66QM=;
 b=lkthPzajl6i1NeZvWJryFE5sBFDES1PJresR6nVqh6NMQLVWi71sIiLeM51/pcFzh61JbsZzC3VbqvgNxKRFrE9+YGNAbxZqbSb88dJlQ2p/CCvsiGdSKR+idE4AMtUviOo0KdWI0OHrl8nKfD6kuucRMgcwu1Solj17L9j10+0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 8 Jul
 2024 14:52:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:52:00 +0000
Date: Mon, 8 Jul 2024 10:51:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc: cuigaosheng1@huawei.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, steved@redhat.com, kwc@citi.umich.edu,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] gss_krb5: Fix the error handling path for
 crypto_sync_skcipher_setkey
Message-ID: <Zov9DIiHSUGprMK8@tissot.1015granger.net>
References: <20240706065008.451441-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706065008.451441-1-cuigaosheng1@huawei.com>
X-ClientProxiedBy: CH2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:610:50::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7483f9-6395-42ae-0c1e-08dc9f5d8597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XUOS80TfGb3UEt7euB24Z50B7oMQJFPkFyfX5eDbBzRJ4UHbB70rh2PiV/tB?=
 =?us-ascii?Q?2ONa1qdoGvlg0XxmRbYknU7bq3JLqmh4vi8P1uAJBnVKyaCCt4Y1gkwaQWyz?=
 =?us-ascii?Q?Nf9VeSCliaw3GK+17oRitkJeWVOUK0gdnovBas0z0wS1T6CkOPFC9Tvn+jFH?=
 =?us-ascii?Q?z8+OosuAo77wp89TbDgegXaf9UR5n86B9Ol9Do+xn+esJZafwHJAwx8Dhf1Y?=
 =?us-ascii?Q?m+nJ7dSeR+DQilNZBnsHrZ+9OtSYz5zsx1LTy4WBnTfRKw5yCiazlBBV8zYV?=
 =?us-ascii?Q?wSVNjRw+oRrGJkbLqExQmWBkeYH+gZRpKtpjqBlBrJRIlHLBXkGDh6qEKEDj?=
 =?us-ascii?Q?civlvwt1aNa595nI5Tky9xtIiaT01rlQNpBY5IGmfvh49B4NL3ZQoIQRbmBP?=
 =?us-ascii?Q?9NKvwk8qYAsAGPrb3J/boXl2INQmxBPmcvxZJPzroJQ5XaUf2/lUJqGIhY2o?=
 =?us-ascii?Q?O3pPsz3vxWS+/BH/HBGTFjxrEgdWizK4PRCGu9YO4rzelR55KGhYvlbs+woA?=
 =?us-ascii?Q?IPSRG609A6gPB28Lidujy9aKjdxVDHppVjvLcADEP5fCfaNRGB/Wupwjxo0j?=
 =?us-ascii?Q?SFQPnnstEf/BP/a3T9Pl6120cb13NzsPqlvgnSunRAvXFaWyhWbsTGL3CUWF?=
 =?us-ascii?Q?XaiUfr2cRabmAa0p4hppyvD1Z/gsrG0kJo0Am2rrPQPaGGwHQVSRMSmh0MZQ?=
 =?us-ascii?Q?jwPazu8DpBC001eZO4cGaerd0nW5b83KewkPId59UgfgGVDjFJfNf7JXeF3U?=
 =?us-ascii?Q?Kk3V5mtDBrDRsqiZxoTAiLlgIP+5+uZEl54usaAvBjLCG/hs/f+sBUNFnpNO?=
 =?us-ascii?Q?HgKmwDJHiw/9lWcJudPA9u3ZdclmdDRjVxMvZyPUhPSQo+eNh66UvBw2MVOu?=
 =?us-ascii?Q?Er+JRo6y81ZwdXYozv1xg7z/RJ79IG3jVdieTy79a5WGoeR53FIr0eojlvL6?=
 =?us-ascii?Q?VsB9MecbMF47bE6w5uqCjQCmhW/zZ/5ZQqhPknNq9hRyopl4fik2Obqybddl?=
 =?us-ascii?Q?CH2gUtN46eYqKGXcZePn/orT12oMZRKHX6aZHvW2G4380SN3aGsfUjQoNcwp?=
 =?us-ascii?Q?pqbHvae8BkJCA7McLACIm9LEkDmuw4jO3AJMsO/oBb1bTT4t1miweDU26GWv?=
 =?us-ascii?Q?wLpztkPj+4Wayz/mTbZAlMYVVnJdpwrYn0KJHpHfhKCshlqSHRLrk7v+HJow?=
 =?us-ascii?Q?1CFaegkUC8Jtrsa6SBwaysnbjy+sk2AQtblz+mkTdIPNxvHMu6s3GUFGB/UJ?=
 =?us-ascii?Q?iz/MlIbNThtoPGktLP9sEHivTNG8XOTXQCF7+0OHmTyXDsYmwLQLimREiLuI?=
 =?us-ascii?Q?p8lHpM+iDcVUmZp+Pa46diGuErooLCEp7LznWAjc81bMEQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8GdXCzlu9mex9zTlAv8HIQkHSK1qQrw2VDIZ5FnD3CVVzg1FQ6jAlLzSYfZj?=
 =?us-ascii?Q?UOSHb1zJLd7Bt51ZiPMx3JR3bv0+nYib8VpMX2ElUk2iX1+NplvYuqhQQPDT?=
 =?us-ascii?Q?MojxmMM9i68by0OwCdZrsfCWX+mPzMoAca4i/rRJuzMS240IciD0CdM4Af6K?=
 =?us-ascii?Q?BlZI7B+wTJNKebGL1m5Oc49yvWtlLU4zzXR4V5be/JrJws8i47t2qsLoLPCU?=
 =?us-ascii?Q?glYQfwVgQuPLWLPIh1wo3AccuBAbDHQ+i20Bx1UjSaRdozXI5AzkVpbbCkKw?=
 =?us-ascii?Q?GdiZx8s5g0pi36w3yQ13tY6p/vbYr6+TqeCRdJVAdysha6iWmcsvlRnxmP67?=
 =?us-ascii?Q?B92gTD14skz8Evdt5wO9qA3f8IPfBvCArScgYp6QNlwSzfKjr7t3fqXC2pdo?=
 =?us-ascii?Q?fglhM9x/x385fMqLJanPgw4MnEbpf0B+aEtiWfedze80eIikI5TNsNHiKtyM?=
 =?us-ascii?Q?+Uwpm2cey5lGKxevkAOjs+U6DiqHSYRdMzIbSszMmUzv9uRZpdYfukE8f50s?=
 =?us-ascii?Q?Vn63V8DeSZCBWAnHT35CQUKFdBVJfnGvRXWeKQmZrTiDRjwcxGj7i9Slzdkz?=
 =?us-ascii?Q?RizsgYDNmy1qj8PEqss4uHp/Hfe1xqRBi9Mvi/lWZ4pCBHGNO+nmb71Ojmuh?=
 =?us-ascii?Q?yEgOhuqxsCuPwcLORGT5Nik/fzaHG9AjAuJzQLdKTaScQSpbSTxGAsTPHD+b?=
 =?us-ascii?Q?XyhXTajzPghnnPROBT65rFV8jDADIGH3M5yFiK6R2WpGKp7m4245GNXaoGjR?=
 =?us-ascii?Q?vYcfFNhWMwBASdkW3wmtVV+Z26lqEuP9YWkbz+5hG3v0mtG6/Ny/qHHHMSvp?=
 =?us-ascii?Q?1ssXI8w6lkrCnchVejmHjBoLHlMYgcxz0iqERQxRigkHC3pIbDKdC8NEjF3D?=
 =?us-ascii?Q?1PjRjjf+BCnFo1SqS0YEdb/I0neZG5oWPiHKyXiBoGO9cw/VNJlJF1+KKjXD?=
 =?us-ascii?Q?BtM2w86UWjbmgwUJLbRiGDTdyW+Xt+Ehh9wVGxJOr58dy17EG4N5LYvFmIf0?=
 =?us-ascii?Q?fxkSwQANEJ8/r41VSsqFDsFsRYULahyrhbGoAGZedfgnRyTnKSfEglMurUU6?=
 =?us-ascii?Q?69r+N6fOUVQbG7zTrJpteM0RudDUYlxHsMK4hO/rlppUOXLyFUNYVBQf/YAq?=
 =?us-ascii?Q?m0jqiSiTmAoSYU34yLQx9sYC1MoCiFOihUXmYuKdPzORPVaRSyzweEel9U0h?=
 =?us-ascii?Q?PiUq0GfSMR1fhGFeNXe3m/qZRCPGV2mt15pnpcOK4GCY+wJKAhQTQRBSVcX4?=
 =?us-ascii?Q?lyYh2laf8jgHDsKlt/yveyqPaKuvd6qdMuHCEqfQFhZj6kcMhvb2PFfJdG7K?=
 =?us-ascii?Q?Rsso9hRdCt+wUHjbvg/987bDwc5wdaVowJ8c2cR/6S0AiiN1aitr3fITGIIL?=
 =?us-ascii?Q?kCgmwdWiXuD0KfDkRlvHqLuAtH+qkSPu8fkuyxvaOflVw5zOWM27v5xFAHNw?=
 =?us-ascii?Q?rM6JYojN9yOlRZaLZycONi26uqXE3gCiik+PB4QrEnout0Mt3iPcv+ofdl4d?=
 =?us-ascii?Q?jWL+s2Mz9o5Tu61VqMFn1jaH3lo+iiQxmYWVqo104fKU+1cl3TMv5EXfIR8I?=
 =?us-ascii?Q?HthOo/fgl1c9PftCYlFou5iPJ5dY1NFTORM0ulUS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V5SkoE4fFIXxGly2ry7KTg1gSR59pvZWjlA3stjZ5pCO6fZXKTV4Q3t5QT/vlI2WI5Jf0D2FGTFEaVeyvruKelzCZw8ek0Y4gCpmvPNS22A9QyHaiYE/OXWzaxt1kGOzL1J2ZaJfVQbEGczmHRqQOpdvbcwLB4h/cVrtRgn9KRHyTlsZiEzGV9FWdeGkt3ah5tvKGg3LPirMaiXh+OmWNu7jbMt9mLo2amNbNbkvAfnnZhlSpd+qUg9vRdR/Rs+LarPCUBFk80Nmlpx7FWqcObRvmyqBdDKhYO3DteWCc6X01285tuTTQDSAmo2lIEMdOMhq7wyD1uz4CT1ON5kxPLy69f3cFWNOg43tzwqPJCQHkxBdsyuHjxB4Dsf0QRO64H1gUe2RnrAeD9i1gRgXVzSu1/DnRK8BdpDNbxF1V6cYF6LIi28wC8faOB74psxIuJr+Y/ILubkoPiZPxpaUSBx/gwQIk7c552yzsizfn/VNZhn3X7pX0UbMdBxspWpi/SFNE8Tpz/ISs3gjE9gLqnZRs5APD5d4CWPbNgpNlG/lwpNjsX78vkioVPQnUOivOXDCA7m5lEdRUa2BdqLDV98zvn4XDkYNP/0MOiTJEYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7483f9-6395-42ae-0c1e-08dc9f5d8597
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:52:00.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN9pqrlMo/66v1oajjcEBvz51h2HJ/HdARQijP0K57jQhuQWsj6y4cfux3IGWdOjDdBV07lIritLGl1fCguTDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080110
X-Proofpoint-GUID: 3fP2S5oGPgu3rbnqtvxiygXfLLoK10L4
X-Proofpoint-ORIG-GUID: 3fP2S5oGPgu3rbnqtvxiygXfLLoK10L4

On Sat, Jul 06, 2024 at 02:50:08PM +0800, Gaosheng Cui wrote:
> If we fail to call crypto_sync_skcipher_setkey, we should free the
> memory allocation for cipher, replace err_return with err_free_cipher
> to free the memory of cipher.
> 
> Fixes: 4891f2d008e4 ("gss_krb5: import functionality to derive keys into the kernel")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  net/sunrpc/auth_gss/gss_krb5_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> index 06d8ee0db000..4eb19c3a54c7 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> @@ -168,7 +168,7 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>  		goto err_return;
>  	blocksize = crypto_sync_skcipher_blocksize(cipher);
>  	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> -		goto err_return;
> +		goto err_free_cipher;
>  
>  	ret = -ENOMEM;
>  	inblockdata = kmalloc(blocksize, gfp_mask);
> -- 
> 2.25.1
> 

Anna, Trond, would you like me to take this through the NFSD tree?

-- 
Chuck Lever

