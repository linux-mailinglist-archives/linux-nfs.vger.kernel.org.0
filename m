Return-Path: <linux-nfs+bounces-7341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063439A70DD
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FEA281C8A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034221EABC2;
	Mon, 21 Oct 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZzH5n/eA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HgLZpjYQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94747A73
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531034; cv=fail; b=NlQ6Cj0aQkZKaOEOZho/b7DjJBWziA1eBBMkHffTvjZ0RfGH+ZNPwz+Z7LAnzzWKwSPKGr39v5KHYi1wAqEZ2g9WlnVkCToWacBaficx4/FRRc8pp2kjUJsVqUByhRWDk1JH2ngfhnAu19i0zAhDsAxC9P1GVhjnqCB2UrpAoRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531034; c=relaxed/simple;
	bh=f02IfE6Cxi6SUO8D1K2W+dXjfr9pFpLsfVcA5XKewgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FHxmAKsjsTiNQXF+MUzRwGVFxieU6MG8PzpOGZyfRCKrNNh8Sq//ilIGbrxYQxh+9xtoYpb825NiSFoC3MHPIE+R5kzWUnOPtFmRTW6gwfRnQPVNnIYmcbSCwlGsKf3+1Q4Ei/MPcigg7gAUTDCs5iniwNn2FLtnxjXTyRGI+9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZzH5n/eA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HgLZpjYQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFtfhB013319;
	Mon, 21 Oct 2024 17:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DeMWrlmagSUJJBBSHn
	Z3Z98lFHQnQylF7TpkuhaojeE=; b=ZzH5n/eA4BWgPb+egtGizRnnpsWUWxfO8/
	7cH/DC00BdW7JJi8fFGBm2p1z+GNA1QfWNmLMgAEqPp4zSMzH6F1nVcgXqluy/9d
	6vOMw12ppjSH7EaC7j3aANxaZjrVoq6K5kzd7P8XvEm4E9YakzLPT303uCsKfTn1
	lMtsYzg9+N91oVrUyETd83+vNI1RchZdBPkcdEWu78DqrkxiRNsxR03uwNSp1Kjh
	qaOQTr4yOpXwX1rWh4k8jmTxRjWcXFbxWcl/B7cIl+Obu3XxJGB2AIbZ7XlYNhBR
	Uq8RdD0s4EvP8z6plw7cvUZrMzuctcKDZNA5tHT/+6V5BuBjPGnw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asbpcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGZq8H008299;
	Mon, 21 Oct 2024 17:11:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376maj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPyDG/6G2tPk+gZ1E1ZgVKOMYzdgtP0M001Slevkz6temX/+6Foh4UiPHrWt/qkIoWC/bWiFumwe4pQ06v6qgPy2pC/m8iS624rGM/7rB27AxjjbmxI+fNPR3GDXJcqrogzkUruZ/fdCB4PkByXu4tISy96fQWIMsgLy9/S+Ai0NZdnvWszax9fmxjtjK4Amb1PAoR0fklDJYXQCw2wI3DWtsHWawjr+P2PXhFD+K/Z0lHMMEMg3tivcQyrpSyJjtD7EJneFsNQO1IfZL9FBKF7W8WPiNOxqhiuEl4DB80Xc8TE6xlOQ0FT+i+KHWEtiv90qiBtFjagjpXo5jZgbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeMWrlmagSUJJBBSHnZ3Z98lFHQnQylF7TpkuhaojeE=;
 b=xgktjNy3sk2O57+qUiLSn4WGLhwPZ3cNbD+nFsfQa+qzjEN/M7COYQttNbXVZerBVQN0uHlF1TI1p4TYBqTPxr6oAyuNGK2pZapSAc4mJU7qzVwqGNSko+IV50EYZ7knJelFZKVzfpNUDW6bahrIDYhFbZrikUFuoMbAoR2ubtjqYuhuilVeMYsto+tT48RkPstDKNGEhCDNU1qUX8TwHev8Po68l6It4NNJd6vsnvB/JTNtd8WRO6SBzhR78i285sUKR5O2hAi5LjRC1Y6J32iN3PjRk10SnGPlqh1JR80zSnSrW0cpRgB9E3i56fVSMUYnBqZJzdCtYw2vN9wh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeMWrlmagSUJJBBSHnZ3Z98lFHQnQylF7TpkuhaojeE=;
 b=HgLZpjYQHrEr7S/WAJZ0yIwEIcyBrBW2eyrNgGR0PJaLSeHxyXNm6reD8/T+dK62dy1Oj8QN6UKrMfCptDXVbMOL9lxEpFFBnHUPFpQ/XwXa0FDz1fItf2MwT0UesK+aC9f4rx4uxvCT0jp0iiTLYMD3njQhMHOvJs/I/ink4E0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 17:11:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:11:47 +0000
Date: Mon, 21 Oct 2024 13:11:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] SUNRPC: make sure cache entry active before
 cache_show
Message-ID: <ZxaLUCTkOITwRPaH@tissot.1015granger.net>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
 <20241021142343.3857891-3-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021142343.3857891-3-yangerkun@huaweicloud.com>
X-ClientProxiedBy: MN2PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:208:23d::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: bee7a5e5-dbbd-4533-f2a8-08dcf1f371ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQ2JOGORMg3EX0kTSYghzMjoqsAuLiASxK6jfjrnAgxsKmd8WSJQjqfpkDVv?=
 =?us-ascii?Q?lr6ajqfQWr3L1bc600AtkFJpFC+MIGL/05mH9hjojjTHqyOSNuympIIhREaa?=
 =?us-ascii?Q?TGgMLDSmnB/WicvnNLEgHrR0Txg0qrzhz96Lf7gs2zUGhKWzh7CE3F5txduh?=
 =?us-ascii?Q?P12GhZee8ryxreGvFdFMYvJkT2mNELZelOC00c1bB0mi2gPstrM2M9wTBl77?=
 =?us-ascii?Q?V1DqUvRV1BXwWqcLd2pRIUK/ckVR6A3U367TKqyNmJ3Wet4NQn3amJpwRzRW?=
 =?us-ascii?Q?jdy1QgMdjFGP7nQh2ENeUNLeg8lt804Wu2CgVajxi5SY2A/px78TUeMbISAX?=
 =?us-ascii?Q?H7oUG+XInwBC6Za59fd/ZLlwl/9G907ZF+xYqwyLhY1l+rI+2N5Yv9nhy9nc?=
 =?us-ascii?Q?1y1nCumHwwnNnSszBMKl2ciy5ClaHYlfoVTDisOMHex/miB5Xf431406YSq6?=
 =?us-ascii?Q?RlZD6OZXN/EZH//HAPozq+mG/gaRaS+C1ULPZ/YWAXaisgGSl8gyVdaX+6oO?=
 =?us-ascii?Q?yE4zAmM8IRmycTbsqifvUtFUE3pjZtT3H+SR0NIOBKQKxIe/CFNawnmT4Dvw?=
 =?us-ascii?Q?6RGhlqMbpI3TU8vbne8gzDhyelLgWSxU2nKJU1Bd5+Vu72L/R27mviJ4DGJA?=
 =?us-ascii?Q?5kkeoHcD4HNEmhxRh5KRL2IomoN7ZhxE/tb47ceKJOU8FNPm7uaz7jSa2IDX?=
 =?us-ascii?Q?FfU+4WFEOtAoq9YIjzaN7E8u0q+yLcOhLOl9jj/T+QH9dfDGWAd6BL8R6OsL?=
 =?us-ascii?Q?h+3/AaPwAL8yCFeBwBQ4r2OL0UCGd0dhHu829bkk8hQLCQSG3qy0cio7xPCx?=
 =?us-ascii?Q?OCDDmzHRBwHpHZYRUy9I+b4b/sM1i5pilnhDNdhzHVUwvygdvEUtiGe5Mzab?=
 =?us-ascii?Q?A2By+DcSLAugRS6sVkK7pNrVQXxTi7dN2RtQMZP4wg76eI/4KPdjkl83TKau?=
 =?us-ascii?Q?114M5VpHT3246JBqJLZ41QQmSLWfs49S1LVa0cj6OqRGc4Wq3SlxyErx8qxZ?=
 =?us-ascii?Q?4ApdeL2Zrpg/zgLoAT0Rb/ttKf22OUKcXHwc5yqyIi7R/JHJsUUtdw+iE/+b?=
 =?us-ascii?Q?go743XPddUtmMRDyXFFTL+Z6oA7Aho8vqmT51PnW0dxy7MiaK757FO5Bb3Av?=
 =?us-ascii?Q?NmCEWo9JexxSNFUKkj+NWap6BwWr9XtvVYlExMD5VZeNpqQXutm2hy/0/Zr6?=
 =?us-ascii?Q?7QMRUjp/EZnKsisVOm5pnOaltDRIAJ/ZfxYOYAqBLa2/C19g8kyLUUr3PFK5?=
 =?us-ascii?Q?cryO1uDZ7g78qyrgbZl5/fCOwb8wrKolW/nlNVBQ59fOmzaMyiWqbBNLzUqI?=
 =?us-ascii?Q?3MzB4IgdOOmkEFSn+5obK5Wd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKGm5IZaqMMj/+NPZ22FyG+5SE7Xru0T+VS9arbL78vbIJ+ANV92lLZzR00p?=
 =?us-ascii?Q?bGfF/I6hC0DW/0a3ge3OzEZJnlG6+TQAKtShduv74qCIU4xdAbtpefN8Pu+A?=
 =?us-ascii?Q?ILywuZDjicHZ8wJAnFssKLiiDJ9DcMxKkgV0VWPUS6PggGgLu4MmjTyIQhHU?=
 =?us-ascii?Q?HjuxlI0YvW0ap0ZOdkKAM3ifbZ0ZFJwALGDHLNkjzoE88EMQJcnZTu0gyXYS?=
 =?us-ascii?Q?qGb6OH4NX65719n0KWq6l/ZBDdnCuo4/kHE1T4+DbE5MUiNkSkjJkvMPI8RR?=
 =?us-ascii?Q?/uK5z0Qk5kcQMoTR60+llyirhtcJpQNXg2Ep7ZgQwpoQmt4R7Ls3KiQTtiJX?=
 =?us-ascii?Q?7ii6q1/Y9Hdcv1Pd7KVOYR+1gSX4AWpCWFOeY5bOtB9/BPCjoGjm7nKUmYST?=
 =?us-ascii?Q?MlEdn8Re2Kk8tvA97uVr066No7tLIgngpMyb83C7KB3x6Hej4hJKSG4YeLKz?=
 =?us-ascii?Q?X5G4oPfyIxcwJaSYiRkd6BggLXtq8lJWaqK0dFoQcR5jnZGtjSLM03Nip5Ld?=
 =?us-ascii?Q?MngaS9cREyepR1rFebMSnXE9K3o+shs8w+P+MHKw3I+UOM8iG97+ogUqJN3X?=
 =?us-ascii?Q?ejYYRp+m6JAxuNxCoP0x/DtC8phEH08zr11ju4ntOeQfb4BKe2/m1WhlHgo6?=
 =?us-ascii?Q?W4SAlhA0QISfr+5sWW8/5L1LYj0u4wjeHFfTukReSaQT9zc2YFqde+koPT0F?=
 =?us-ascii?Q?tX6L04NM5br7BDf1fJwvfRHLBVy8lQ3xOTIqlZz6ni0dsfnJ5e0g6S0zAd9d?=
 =?us-ascii?Q?6yKseSSC/it0IKYMXIZOjPLPFn7IkgGTmGqatfrFXudlOaO7eKQUyDkO/qVj?=
 =?us-ascii?Q?L4bKnDsBlAHrl4fSPsE1J0VbG6gg9EZc++GUJrk0qI7AqENp3p44y4R5ULDw?=
 =?us-ascii?Q?Y0kRt8rihwTuO2LcW6eEAxAfM5I8MedDpNphpLgzspzDu57lKZcEktmJDC7p?=
 =?us-ascii?Q?1OWw1HJ0L9LQqcF4Q5+XK5/NJDbpQUJTvIAbPJbEboCmdt+vkU6UfWIbo4s7?=
 =?us-ascii?Q?m76cL2UK7TGbnCQWbUyDG9VmDOQEwYlTeuD/MLXvDFWoKNAP/AMR/N1MJw/U?=
 =?us-ascii?Q?bFjEzITyM6bcps4CI5OUITVDj5URwXleXNa68UpfLBILEfn0ruCEPHqc1z6m?=
 =?us-ascii?Q?Xk5umoUfnRkSLsJMnktqX07sJGjoL3wZJFq2S0C6EmOwp9q1m4wErwnPlQTs?=
 =?us-ascii?Q?Ld7jphoFBc+39hHv/qtXRcF363h5pmSy/maQXhk8TGEm9AL4HfYsy2qReKJL?=
 =?us-ascii?Q?sp+5v2tEWPQqnBaJPljFjp8bNLWKM7BXWjiP3UyPWLX0kiYmRaeSxG013zK5?=
 =?us-ascii?Q?uqU0qdNNqJlAfCF69irE2jMqyfl+ix7WohAMa6lkPPz1BMuT7navbRnhlJPJ?=
 =?us-ascii?Q?BQHbi2+YPV6GUJoROO1FRinWHvSVyRGUNeuAWCQljsaspbDRObZH1fkRxFiH?=
 =?us-ascii?Q?1cQ/cizAemSdiZCf8EMAGjZ1jhdrfbNjWu26wPZSCsrE5zg9AwylWoI4IIqj?=
 =?us-ascii?Q?FJj7nYSR7j3y2kdqrlWPkbLZWW4SeKunc5lfYL/bdt2ja4Tjd7c73xPljDKu?=
 =?us-ascii?Q?EzlLaDLLSfUwUO6LcrCmy2ZgvuEGeVkozTsFxrJoSP6LBKuMJhjSA0le7cqr?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kg3OYfGUgcSKwHXHFumuBF3ju6Ji4QQKU9F4+wdkey2416w283bYNL21ijDoBsAjN92YoFSQA0exz6TlfJFreofYwHyJT83UJeubwcy/kISjcyxM+JIR55hVQTCO3lktwchHr6+7Lpq/mdtqoS0FrO9/5U9igiJiFVjGqkF3eFzXPKQEVH7m2dfJdtyKMhbD+oboodtHAhrKkJF5hfUmYlJ4L+Ds/+oIk8C4i5Znmzl+S+ukJzg4UGvYcs1NqG4DoCJUC10WjU32/FmDcFva6gzNB+AFbX5k/T+Ai21x9cbGS1aWllBfovupkqig9bWyP9UMP+tlvoK8DX/8U2X6H5qBxJHCWk45GhchumF4lHyi7riZyVJUzyn8q1eoDtCPOHBRIJXy1hGoPGseA86Qr187N7x93LcVdKjsTDfBeUHOM+f7oCloisTGOfpVq3xGCYsKYFKYQM6LwMRqFT487qq+L6B1as+Bs3iOKDFq/ogGsSW5IK/xAYWooJ7To4Vjp+M8PQfHTgyBSaumxlsN7as9h1bYgLiB7G0DyzlmbslSkGj1RPlDftw0vc2ribEbEY0IBBQUN6/IE7MbuXYFq9QQG+QmmqQnPkOVLTB8+30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee7a5e5-dbbd-4533-f2a8-08dcf1f371ff
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:11:47.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOFk/UY32FGdmw+GVnMhyxvU1h4QRyWT+KVn3gsbKRLqt7CNalReTw8Ld54RPOD0MDieGUADNAZ8ZoKbk5kEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=923 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210123
X-Proofpoint-GUID: tLMtpfg2MwrgqNPpKW-g-7kPb-dqo6I2
X-Proofpoint-ORIG-GUID: tLMtpfg2MwrgqNPpKW-g-7kPb-dqo6I2

On Mon, Oct 21, 2024 at 10:23:42PM +0800, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> The function `c_show` was called with protection from RCU. This only
> ensures that `cp` will not be freed. Therefore, the reference count for
> `cp` can drop to zero, which will trigger a refcount use-after-free
> warning when `cache_get` is called. To resolve this issue, use
> `cache_get_rcu` to ensure that `cp` remains active.
> 
> ------------[ cut here ]------------
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 7 PID: 822 at lib/refcount.c:25
> refcount_warn_saturate+0xb1/0x120
> CPU: 7 UID: 0 PID: 822 Comm: cat Not tainted 6.12.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xb1/0x120
> 
> Call Trace:
>  <TASK>
>  c_show+0x2fc/0x380 [sunrpc]
>  seq_read_iter+0x589/0x770
>  seq_read+0x1e5/0x270
>  proc_reg_read+0xe1/0x140
>  vfs_read+0x125/0x530
>  ksys_read+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Instead, how about:

Cc: stable@vger.kernel.org # v4.20+


> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  net/sunrpc/cache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 1bd3e531b0e0..059f6ef1ad18 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -1427,7 +1427,9 @@ static int c_show(struct seq_file *m, void *p)
>  		seq_printf(m, "# expiry=%lld refcnt=%d flags=%lx\n",
>  			   convert_to_wallclock(cp->expiry_time),
>  			   kref_read(&cp->ref), cp->flags);
> -	cache_get(cp);
> +	if (!cache_get_rcu(cp))
> +		return 0;
> +
>  	if (cache_check(cd, cp, NULL))
>  		/* cache_check does a cache_put on failure */
>  		seq_puts(m, "# ");
> -- 
> 2.39.2
> 

-- 
Chuck Lever

