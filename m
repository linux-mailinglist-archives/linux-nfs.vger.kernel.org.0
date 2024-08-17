Return-Path: <linux-nfs+bounces-5430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF69558C7
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 17:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925B6B215FD
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6581494DC;
	Sat, 17 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVXjOPqk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QwVdJ5zY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B71487DC;
	Sat, 17 Aug 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909691; cv=fail; b=KFczJ7JRF51fpqzHAwKJ2i995y0p7J78WKXvos75GvAULwuRCsxFU9bLnZ0zAtjnNMK5kQRARV0x+yWQb+sDuOmHsmAp4hWzlQ+2RV8zlBi5GZLpAuWxerC1Al2ZR28S6yJxHUBRvOmuFTzpzr2TWGrQE2920mQN0VEbX92GuDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909691; c=relaxed/simple;
	bh=4QF4t7evlOM+g3IA/zi5kgtta6tsb823hFDKZvZdRV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZtuteUX6QyMP3cpOQiKLf1fCF4yyyhwKePWM4Kz/MnF58iPr8mi1XGHRkLL5fBb8HVK0E3vOBAWNjdYgvoH41UMjOkvOqfBp+SfUURLySNgIW3ot5Rj6VUqFrc1H8mdNONX6d5I7YfsY9C0HpgimRhqub8qrRuB6EoA8f6v7S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VVXjOPqk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QwVdJ5zY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H6es0Q028718;
	Sat, 17 Aug 2024 15:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EJ4rlGb/OXgGOcp
	PXUwtalG9wSSnxoY8KDPM7XZIroI=; b=VVXjOPqknxQF4O1q3ZPJV465ASx1lao
	RK7aYURyYkrz3D2GSZUGGdxoy9AttZBm9BU+a6Vg9qU/I2tmGmUcmPt+JxoPfu5e
	fBc133Mve5jFNb/eiNecIck4iNnyg9BtGX3+7+AqoMexfk2BGO0cAszNhA6r36Ft
	fhLV6k3E2siyL6FK4h7a2HR3fOirIzh6tm0E8mVw0EOrTjAtgaz1lgErTAysE7uJ
	WN08foSwrbX6mLKRtTFY7XEyJxF3miVZRouFoSo+R9r2oviP1KNDHfXo+MRdcONx
	rZ92XKNyJazVVXczbSu6QtCsaDoTRYrXgidDOCpNOAeTMYq6EstAmrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4urdfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 15:47:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47HD6lMU037274;
	Sat, 17 Aug 2024 15:47:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5ktyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 15:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSDlc4qN8I5bov3N4/D/+mL3gedkO/4t1NEYQ8VlxtuLgnQbF4eKjKUjg18K6vfKj94uKlhW+5MHDTuvOdmikF5t3dnYyrS/FffXVMhjKTn5zNNF9ZgfB0aaNTgly0BeFMJl9/VeIqV3kmr8R6Mg9HTY3AMoPNtNAle0h/iNEw/6+NroWYs8YUZCeim9JM6mrnQJr57JPKK0IePxq+Ofx8EpJcMJzEGWYfqRi9JkJfiqYMe6WLjEbMUd/8vQmCpVyO6stWZlGaUHNZv0sbo2P5Daa5VwRN6mEVZCMVjL+cZ0P0jvbvjx8DxaZnuOsCRrm5zGS+OfLq4OMiGyIaDfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ4rlGb/OXgGOcpPXUwtalG9wSSnxoY8KDPM7XZIroI=;
 b=IRv7ZPSa5uzztQAi18ddIcJdFjz9ZOadHOmmFA5owK/saQb1486k0Qe3ecRVGu1XD1AmCcizG3bHJUr3abnPgA9edYDwN4LOb9MW1C5UEvn8UIwyBOaW5RRJqvSA7PzVnr9Vnt5dbJzsuJT3J/FuyfNYnrYdqKa712Thwoti6DwPcV78ftfiaS0tfMrt/ARy1DlQERr5tDwXoUk/+QN7KSv4hIQQ3I/qr08mYPPDtEfGoRn7TOXAFBPVAF5OkqH8HFnw3kom06N4FlNn8qT1wmwLNr4H/kvRNfdGsTXN9Q0y9miPaCzYw2I9Rd/WtuvXPAYPwrLKHqKz/QnyRt92jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ4rlGb/OXgGOcpPXUwtalG9wSSnxoY8KDPM7XZIroI=;
 b=QwVdJ5zY9KMKDBQsGoyG/NXt/b7iXqtZVhs3e51nND+CACYu7KR4k1BSuR2n+ZF4e7etWiFE1IlPTiRvnYQ3mVxfDifbyVqtWkCuY0utFnaILb7XwrlhW0GIRM/5kd35tU/WaynESrR91UHUGBvvgmn5jmqGUMhBzvBuFnp74B8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4151.namprd10.prod.outlook.com (2603:10b6:610:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 15:47:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 15:47:26 +0000
Date: Sat, 17 Aug 2024 11:47:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH] nfsd: map the EBADMSG to nfserr_io to avoid warning
Message-ID: <ZsDGC4V/erGZugSh@tissot.1015granger.net>
References: <20240817062713.1819908-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817062713.1819908-1-lilingfeng@huaweicloud.com>
X-ClientProxiedBy: CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: f733b2db-4941-47a0-6892-08dcbed3e4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jy7NLONF7C3oFnMWoGQ6kHKur29SwKsjBGtIUVCkpRdNTYz3M3V/fmn4pBFF?=
 =?us-ascii?Q?NOzbUOX5GkAADt4PdjmQ+cyh4ljgP3KSpObXd/54rcMw9e5VOEo60v4ZR061?=
 =?us-ascii?Q?KGhZFBsNJ4pwhmPP7Y3Wv7G7DrDUuf8LjthOau6NYW7a65WeIY2a1l4SLAvG?=
 =?us-ascii?Q?8V07fGzrG6xI3xD3lzbCqxJSZF5/oZ9H2eQUp3kHrHEgJEp9eZLlNXrZeHDi?=
 =?us-ascii?Q?ySrCeZmtCc9Ho5RcAuxBgxI5+9/qv581cKlAOv+qul4jPipuvgyH93MaH5ix?=
 =?us-ascii?Q?T3aOQu90fXcsq0I6it16Lombw9cb3i9qARap04wJdnxJws17XIeK5BiI64Jp?=
 =?us-ascii?Q?9t41u2PdDLERb2VsKTYnLcUO8clg8FFDrSIJKdE1ZutxoL2WuBcAwxTdxH3I?=
 =?us-ascii?Q?E+DsHZjWuTWa7mAQGktYqbrf0WDrYX/zy1mN71qRbWn2FX01b7vhZI1Uyrr0?=
 =?us-ascii?Q?ncJdQhh3rE1UmWMPpAbt9KVY3fDan+uHJSJK9766FcwQJdtfhIZLlXtRgtJO?=
 =?us-ascii?Q?Jj8gkxTzEOB3ksNl7NiUe009qYFGqx3X5M6AeUM9w4hedRto5r+oX1qhNyk9?=
 =?us-ascii?Q?RaIcjovrcf1v9fqEwqGnMGbHohTgahJQJW5wFcysv+MsGDsUHcMFMkRhkPHa?=
 =?us-ascii?Q?RXrLqN90w4zjk+tHLRIflIKragHOd8QAIBLrQ7jea+TXtE8K1c7dl6Q5rh8N?=
 =?us-ascii?Q?PL8XFzdOvo36iEo3UCMd7kymgSUs4TVxi8AJP5TUP5jxiPQvGPI6CX8vssTC?=
 =?us-ascii?Q?MY/Yd33gp4TclEmFJXYkDmJZwAWHnDcJkzzl70Uw9f8fga4bVMy7IFM/00ll?=
 =?us-ascii?Q?iBbAYr2U+chHCl9573rdAgS2UVXyszcv2zymH/b7vk4XlZ8rhIOGME5nSTvj?=
 =?us-ascii?Q?7XUmgJOAfITeR5hMu/MEqPFVZLNHl+OUQQk3dn10HmjbmjtNoE1SwN1laN29?=
 =?us-ascii?Q?B8hH071edlowVKsqtYUjizHGUJ7PbawbMnfiSFtNKSBaiMCJ4GVO0S8qmyM2?=
 =?us-ascii?Q?MacQJGTz1TKP+gcfqQYXdNmtzCS/uOGjX+0ml8+ceOmLyW7XQ1o+DUcvaTul?=
 =?us-ascii?Q?bSg5ohdeYcbpTcGh+FfUehTA9Q7qJHyKX5o0PBmTx3whXvpxXAlLRkEjjmq/?=
 =?us-ascii?Q?Gx0s5TyWaZIAl5GrKbvX0zVeQn0w87bJKxZqwhrqjf0OMVgXWszdhu9pCEuk?=
 =?us-ascii?Q?mhboYwEssUb51bSeuk9e1D4pooMG19p9gEzY5rFGpjYaj0bpKhrPykhwbjO+?=
 =?us-ascii?Q?MZ7cseYNfQcnuWUxeuRV6eqNPrMwGIrSYzltH69irlrA0L1KL6CxCdEiNQOJ?=
 =?us-ascii?Q?mcRAWNFqE/0Oo7j3aoeTNF7IvJeFflK+jkpl8ADCHHOIWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LA+hIaF3+V+wm2yW+b4PJ2/784rRXGYKfR0/xRK0Hl3/rStk6GDGcmHlmw1H?=
 =?us-ascii?Q?h0oYZWLvGjV9apxaUx9mF6Ey4re0chabj0QtWiqOUt/mcCPOtPCIqDUphzrA?=
 =?us-ascii?Q?usmLT390ScLigqTO5gEFHr7TSVl1DrniNo2I2O4YGe+bTYFo5kbKOGAqH3d5?=
 =?us-ascii?Q?ZhrMOVndlUJEfkhie9iCC5wjFLT8OSMbsFvs4UgnrEchYA1HUwo05OFmo8dG?=
 =?us-ascii?Q?li0hKxGE2JFBLa86VJe5jd84GuOBYeCAlUdrwQs+OtBEEKd1xIEh+Fn1Io1k?=
 =?us-ascii?Q?kQWV0h/hM6cyHBAGl1b6Fb4qWG6fCwQdzuEqlUTsXLoFMAakRdVeYrMtirmF?=
 =?us-ascii?Q?5tR7jIDLqGJe0n4MdUgkBY7ea3YlcdtSfcXiDue/3iIJpzXLVCPpnTqrC65u?=
 =?us-ascii?Q?HFfXmRer8vhHX7kK6C8WN99Mz7u0q+DPZ0803kE123PXguIE/8qVRvQvwcdT?=
 =?us-ascii?Q?0NFOR3UVIMmaJ7Kn9gp9J7eNvhHO4fdvFrCr/zG953YEGc+rIxi7wg57JpcL?=
 =?us-ascii?Q?eX6ieDi0cRbdDwEguiZQVtUTeU3nswkof/6bQagYakbi//co1HKIEBlrncGp?=
 =?us-ascii?Q?SUvMJKY2lBXWVwbkSqZCPZUcytr10uUOflszDYIBzXdjC3cH7AS2AJ+BJqvO?=
 =?us-ascii?Q?Gpt6AtCsEeI8bDiKhXom0DK3O1UMvHM4ih+AgZtJxWuwc6Ghoq5Y0+magU34?=
 =?us-ascii?Q?jpvtdpquDlN+dX652p5NSvwFfwKLK/RtlbyYRTQZWhRaNbCTapWMfQVKKXgz?=
 =?us-ascii?Q?WhQxPxI1/1paXKg6M988IckG6K3xw55NMjg/H5e0udIwoMJmPtl6i/WWmyS/?=
 =?us-ascii?Q?dxK7yOyw9wZErvELKl+dAXM41JJMiBFv2+Jj+ffTrPIhMmS1f/6Sn/zd1lK1?=
 =?us-ascii?Q?7JcdIYJlK4JL7St3TAcnFn9EsPw64I1FlXie1uQTnCq4RaCwZHhWPZoXF5jL?=
 =?us-ascii?Q?elp6c3bJKO7eceMfAPAt5bka00cEeuh6oQu/Nc5RuCRBrk7r3+NlZrew69JR?=
 =?us-ascii?Q?hnVe2zMuVH3zdp92SUlwcVfq0PaK2Sujn8lnFCYLSGKz67ept5kMPmLiBrUg?=
 =?us-ascii?Q?r1QuiH3Y/xarcrrLDGlB+3vyMAIojGRV49tN8+qyzc1Pj5HISCSw2lj6KvOp?=
 =?us-ascii?Q?dIhYayNXyJda4cvaUfCJd+EMsIUsD3FniH7XPRHbX9tw5zAHTZIujhE4svI4?=
 =?us-ascii?Q?dwB7r62oKzmOm8Mt49QfjRR3BNrZR3B8UyI7NF1JzYc/2L+2tOlxrQsOSP2Y?=
 =?us-ascii?Q?i9TyvHopxCvDmE7+9DjNuQXMB5NRCivvF0r+tD+uylDjECi9NpYytw47UTRa?=
 =?us-ascii?Q?D203TYuO1NsayBnO5NfqaetcDEkCS+0FjV0dKkzKztIiVDFIPhZX3zB7TFx5?=
 =?us-ascii?Q?w+qKJFCbZQT+Ncx7rGyG2pRl21Pai45hl8bNrxbkx6O/GzRY2K+TiUUXHgJ1?=
 =?us-ascii?Q?IpqraIsfz6cuS+HMEzIWXmIpqE/VBqLGd2iIa8L8DqXv+q/+c2w/TwDoHK6O?=
 =?us-ascii?Q?fpTQof1b6eoPV0G+YTAb8u+hpwTylp6zR01Rgaz51DImT3Up/n++cRJjM8hl?=
 =?us-ascii?Q?8dvmXsZ5WcEh9qQLxFCaE9eBb6KFsQvhF4iqb/RX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oxgFT3sWIfa9ma3i1qHFMeBN9ILC79+gm1lJCQONLxNvVcRIymQF1GebB1wEAg4xvdtWZTe9MOCOUQo1l9dMZs6j6NQi0AW7OKMKnrUSshVUiP/tbrD37EcZFsxQNudKEgPbNplDqoHe5PvCefjhVLi42hBT+SG1nJhh53dPbFmusgx8H3q6h0NG3hf/WhrGOZzfakFf/XyjoOc/WpLz1vjX19Qz9SsFZkl+S8u4URTkHEfSUwjy+HuDDZVO6xOmr4AXgjyv2RuHrxI5E9XPRjGDM6Uj4rc2SZFaLWKhfdueSoesBKYfwTc3HL2P8AtKqMPhJnMQ3uJhCutWkXYtYH43AAybV4roGb7+UwOtit2NIKOAwaC1WXwpPIukk6X+WRkuvsCB9obYXz42g4/S8i0QH1mep0SzYtBYpvzCSE7kyaBWVgBA2ACTt/VeNJf/sY1Lqgu4PoFxBJ9b7EiGttXSCcMbGdjayFc7bxnHyr2sJNWQOxcX+XDCynUGVPJyH0BhmOHOM+Mn0vNXCrkwFj3dKTy9jWMwH1pvMwP5hTTAIc7lb9H7YNqvQOxH+YNdKa2jYWMFd+WP2yJ0TILGIyqVa4275cOi4ZQGgn7IFkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f733b2db-4941-47a0-6892-08dcbed3e4b9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 15:47:26.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt6Hk9N+9vrdaSaA1MDxDQKvDP1m/Erl6jNhzOBC4tadBDMK419kTENWodBCQ9HiZqSgAMQoPMqpbF4a5ZLO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_10,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170107
X-Proofpoint-ORIG-GUID: aaPhWgS86twAzDcwof_zb3_jf7T4Z6sn
X-Proofpoint-GUID: aaPhWgS86twAzDcwof_zb3_jf7T4Z6sn

On Sat, Aug 17, 2024 at 02:27:13PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Ext4 will throw -EBADMSG through ext4_readdir when a checksum error
> occurs, resulting in the following WARNING.
> 
> Fix it by mapping EBADMSG to nfserr_io.
> 
> nfsd_buffered_readdir
>  iterate_dir // -EBADMSG -74
>   ext4_readdir // .iterate_shared
>    ext4_dx_readdir
>     ext4_htree_fill_tree
>      htree_dirblock_to_tree
>       ext4_read_dirblock
>        __ext4_read_dirblock
>         ext4_dirblock_csum_verify
>          warn_no_space_for_csum
>           __warn_no_space_for_csum
>         return ERR_PTR(-EFSBADCRC) // -EBADMSG -74
>  nfserrno // WARNING
> 
> [  161.115610] ------------[ cut here ]------------
> [  161.116465] nfsd: non-standard errno: -74
> [  161.117315] WARNING: CPU: 1 PID: 780 at fs/nfsd/nfsproc.c:878 nfserrno+0x9d/0xd0
> [  161.118596] Modules linked in:
> [  161.119243] CPU: 1 PID: 780 Comm: nfsd Not tainted 5.10.0-00014-g79679361fd5d #138
> [  161.120684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qe
> mu.org 04/01/2014
> [  161.123601] RIP: 0010:nfserrno+0x9d/0xd0
> [  161.124676] Code: 0f 87 da 30 dd 00 83 e3 01 b8 00 00 00 05 75 d7 44 89 ee 48 c7 c7 c0 57 24 98 89 44 24 04 c6
>  05 ce 2b 61 03 01 e8 99 20 d8 00 <0f> 0b 8b 44 24 04 eb b5 4c 89 e6 48 c7 c7 a0 6d a4 99 e8 cc 15 33
> [  161.127797] RSP: 0018:ffffc90000e2f9c0 EFLAGS: 00010286
> [  161.128794] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  161.130089] RDX: 1ffff1103ee16f6d RSI: 0000000000000008 RDI: fffff520001c5f2a
> [  161.131379] RBP: 0000000000000022 R08: 0000000000000001 R09: ffff8881f70c1827
> [  161.132664] R10: ffffed103ee18304 R11: 0000000000000001 R12: 0000000000000021
> [  161.133949] R13: 00000000ffffffb6 R14: ffff8881317c0000 R15: ffffc90000e2fbd8
> [  161.135244] FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
> [  161.136695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  161.137761] CR2: 00007fcaad70b348 CR3: 0000000144256006 CR4: 0000000000770ee0
> [  161.139041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  161.140291] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  161.141519] PKRU: 55555554
> [  161.142076] Call Trace:
> [  161.142575]  ? __warn+0x9b/0x140
> [  161.143229]  ? nfserrno+0x9d/0xd0
> [  161.143872]  ? report_bug+0x125/0x150
> [  161.144595]  ? handle_bug+0x41/0x90
> [  161.145284]  ? exc_invalid_op+0x14/0x70
> [  161.146009]  ? asm_exc_invalid_op+0x12/0x20
> [  161.146816]  ? nfserrno+0x9d/0xd0
> [  161.147487]  nfsd_buffered_readdir+0x28b/0x2b0
> [  161.148333]  ? nfsd4_encode_dirent_fattr+0x380/0x380
> [  161.149258]  ? nfsd_buffered_filldir+0xf0/0xf0
> [  161.150093]  ? wait_for_concurrent_writes+0x170/0x170
> [  161.151004]  ? generic_file_llseek_size+0x48/0x160
> [  161.151895]  nfsd_readdir+0x132/0x190
> [  161.152606]  ? nfsd4_encode_dirent_fattr+0x380/0x380
> [  161.153516]  ? nfsd_unlink+0x380/0x380
> [  161.154256]  ? override_creds+0x45/0x60
> [  161.155006]  nfsd4_encode_readdir+0x21a/0x3d0
> [  161.155850]  ? nfsd4_encode_readlink+0x210/0x210
> [  161.156731]  ? write_bytes_to_xdr_buf+0x97/0xe0
> [  161.157598]  ? __write_bytes_to_xdr_buf+0xd0/0xd0
> [  161.158494]  ? lock_downgrade+0x90/0x90
> [  161.159232]  ? nfs4svc_decode_voidarg+0x10/0x10
> [  161.160092]  nfsd4_encode_operation+0x15a/0x440
> [  161.160959]  nfsd4_proc_compound+0x718/0xe90
> [  161.161818]  nfsd_dispatch+0x18e/0x2c0
> [  161.162586]  svc_process_common+0x786/0xc50
> [  161.163403]  ? nfsd_svc+0x380/0x380
> [  161.164137]  ? svc_printk+0x160/0x160
> [  161.164846]  ? svc_xprt_do_enqueue.part.0+0x365/0x380
> [  161.165808]  ? nfsd_svc+0x380/0x380
> [  161.166523]  ? rcu_is_watching+0x23/0x40
> [  161.167309]  svc_process+0x1a5/0x200
> [  161.168019]  nfsd+0x1f5/0x380
> [  161.168663]  ? nfsd_shutdown_threads+0x260/0x260
> [  161.169554]  kthread+0x1c4/0x210
> [  161.170224]  ? kthread_insert_work_sanity_check+0x80/0x80
> [  161.171246]  ret_from_fork+0x1f/0x30
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfsd/vfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29b1f3613800..911e5e0a17af 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -100,6 +100,7 @@ nfserrno (int errno)
>  		{ nfserr_io, -EUCLEAN },
>  		{ nfserr_perm, -ENOKEY },
>  		{ nfserr_no_grace, -ENOGRACE},
> +		{ nfserr_io, -EBADMSG },
>  	};
>  	int	i;
>  
> -- 
> 2.31.1

Applied to nfsd-next for v6.12. Thanks!

-- 
Chuck Lever

