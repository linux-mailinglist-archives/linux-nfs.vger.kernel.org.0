Return-Path: <linux-nfs+bounces-18268-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL8IJNhAcWn2fgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18268-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:10:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 359465DD69
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F52474CFBF
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD566340DB1;
	Wed, 21 Jan 2026 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O5R1GeRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFB3F075A
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027896; cv=fail; b=aI0XkkQxBOsB/PhRLAT1we7xSVvoVgWsGHte5RCLxlqKgjLhsW6hn3qQLIRIfc5bKHLzPo5hANgBTq1Y+LrzG9HPX5rBP6HahxmJRpz1rkMS7nE0f7L71AkphLMuQvmIS3YmM/NIr2ZTzvQL88VI6sdzLAdDypghLtBxHTxs61g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027896; c=relaxed/simple;
	bh=FvQuL4HAyy7pNTJINzEkz2H00uWEfNj4+8RANnImgqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZASf2qoyoJZtbgVKT1cG9jr68u4hPrpZlVMp5lazXYvN2pzjpBNr+P1oZTXuPcNmddk3uUUkbtbE8xZ5pOZC+CGMJP9UN7J99x6d853aZZ3BNfB7dPY5YvZlYMjR/BYQSRxlS3OIAP/93sNaL7v8FkaOdxn5WcRyX14AX/65KEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O5R1GeRq; arc=fail smtp.client-ip=52.101.53.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrF2Nc1x9FNtZxAzmHvNoYP4r31gdmsbm+4PIBGVN49m3xD+aoG3PvghecESf9VKvjTMrubaicySsJ3+QPzXJ9WQoThUJQmgj57Cug1lx9dopJI5KsuNal70lfc/IZhjrmpFaBXu3+n4VMMvZpqox2/XfFfvrtE5jABjRzQHFzYAPUCEOBPWkNGbTOEpwAx3eY7FANQxc/3r55A6x7CgUCMmlHHaDPvdLeCkmishExmHVph37pfF3WpLe9pyv9XdkhhE4NSp36FLt02HkpUKusuITnH9f+9674Y9gqkPQ0a/Qh4Jn3HRtN6Kutn8FNJ8wXVRZlo43VGKO30We5xtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brnMB8/YnfvbCySsh+6Xj4mr9ENhJ31zHjBe3CUKBjw=;
 b=JWa7CVtlbKIibF6/51k7glNCqu0Z+J8UZwK1IXzjogvHCDErMPmUdRO+DbR5D2r+/EWXNs02j6R88UtlGj+7kLhdA+2jFmRtZCyaUas1KLEvJ+l9N4icvuPVGzYuG6Ytt7PLoPOvvsIKn2hHzAkqWowqv3c0MiuHgplfrH6dfVYs51IOBfPBAb4gkdE+PoVsr3zZ0ve+9+Mw5dffkoR+nzqsUy6C/mbM8RFI17pwmdmLOBHsZrd0R7jVHnM3KdKel4sMXoSbI/SDv850TdvjrCY5yAV1CoRn2l41ZqDezFszUtXkeVoLY4caYgM3BcQR89Inb4F0wv06bDRkgnMz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brnMB8/YnfvbCySsh+6Xj4mr9ENhJ31zHjBe3CUKBjw=;
 b=O5R1GeRqQDj9Tgs4tXg43oc0u5+wTjbnJj5Ef+ycWJMZU9w4OJlC0Ron+ynpJpkCPNpVdw69JHfaZhG+GgCr+g8xa+JnYU35cb8lWcBVJFmrafxv3vlBTWB+Anzu+eMCE7zeJm/2sBkXLCgyOEcBec4rZbCnQBxSPt1k0YhMXNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB5422.namprd13.prod.outlook.com (2603:10b6:510:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 20:38:06 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:38:06 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 2/2] nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
Date: Wed, 21 Jan 2026 15:37:56 -0500
Message-ID: <60b9950b8c33978d3b2940be45c7b4b8287c857f.1769027750.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769027750.git.bcodding@hammerspace.com>
References: <cover.1769027750.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2af031-8023-4aaf-0653-08de592cf98b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BII8pG+ywo2ovfhXv2MYPOSRYTF9D0gjNKW3F9Hbf3Kxi5T3J1IhQ9fZT53l?=
 =?us-ascii?Q?LdGTtjreQL8lQ2By7PCprx9Fki9XRRKtdoSXbp9Jy+Uc6wTXkmgslCdUcVcP?=
 =?us-ascii?Q?2fsn7zRE1ogTNA5rFr+5WOtOz2McL+U7Og2sF/y0mdKtdOk1AD4K7D9kQq+j?=
 =?us-ascii?Q?RWhug9PAKWKAV9ivJtJ+D3iuvI8tfwNhAT9Kz9UmEZxaesdcNKyjMymWlG8V?=
 =?us-ascii?Q?h38qKMbmyMv8KFbuKA0zjYDTyRLBerI3PXEcBogXqqgwfAC4BszSa+27oQtk?=
 =?us-ascii?Q?xUgx3GYKUYNaNwMHkiQ/1Y1Nytf/xzSdntuOj8Ki2fWGlFgtKH6/oEEBu+J6?=
 =?us-ascii?Q?8gmD2SipNsZbheN11/FRc4P5v0YLSdLiNTUq65YOoZG5AKrq+mOdqlGEHssz?=
 =?us-ascii?Q?+qneTm53teUwrqAgGbt6lFjtng8Fwj+Kji5gOZMYlkeF2PZ4plzqa8MO9osQ?=
 =?us-ascii?Q?n1qQCrlfoTDQnRCcZHmU4yiB4D3P26fam6C1mPEqAFWVWv8ZO72vbtSLQciP?=
 =?us-ascii?Q?Sl1OBclNAYUiT6PfhFlgLlUCeR+eLL6duWbm1C072Uf0KWM9syPf47j65jJi?=
 =?us-ascii?Q?CpYXhHRwcNzFvutI81gA0x9Xuc5T96aJ4yjG8NP3XYQj0Gh9m3FQlyrt+ogs?=
 =?us-ascii?Q?kHm26UneXtSdHc5+b4a2mypnGBMh2NRWnnQYT7zJ6S08wj9ILTW6DsM8+Ihw?=
 =?us-ascii?Q?lsvNZK5/WrUeQmUKOApdsgz2CqmVqYeZoj54BUdDlSeMXTRWpssVJY9MFDQj?=
 =?us-ascii?Q?gx9Wyl2alAfAfLHDQfGeHMGAv96WjOP6wBXztLrKFhHDCz106EcAIhc7UMAt?=
 =?us-ascii?Q?aa5aJJK89oMjgovDq9F5bG45V2hYWRZPz0PD2ZY7C8P0Zuso49GnpUdWRCpl?=
 =?us-ascii?Q?AvvrdgG29ozg68sP+iOjsedf8S9HES3p8PbuvlPT1HSc8RPE8SeYCCI8SmpD?=
 =?us-ascii?Q?VeKYpqezdHDQrvrKjakw0+aYMKSG+4r4dbaPzmFyKXZlxuMPpUKhgP83q1Ud?=
 =?us-ascii?Q?owMWEGMSufeMNdTcmRuBZput+EgF/LOBjjezstZCqQDUQ8PQ4TRCY+PMP6Cc?=
 =?us-ascii?Q?Q8B6zFHupO9ITNy8zwnt6XhNyGTueMMxhY38pTQD6FFFQNmpoJIIGPjjYiRi?=
 =?us-ascii?Q?mx2cd5ajy6bwAN8D17IGTudKgMbqLndnZ7+h8Ne9YKEeHFTllcExUE9mA7/k?=
 =?us-ascii?Q?PV6n7wsepXL09lI62pXXwYLxsEeRTk5G/bQVoRJazhYiexvxmH7CSqeOrWY8?=
 =?us-ascii?Q?EZqa55x79UuFKaJ0A44V1HCepwG3MMYvUbkRfyt5d0cIADsM4emx59MXyy33?=
 =?us-ascii?Q?GDC8RWBJvfvUL2xdPdvLPeWC3YS9w8N/xgmiPSxb8VMV5M+86YNcILcwR74n?=
 =?us-ascii?Q?EdIlu6uWgKDeFz2qbjBlDFBTLUlLZMVLKi1xhh2Y4HQi2SCq7r1AHSAgvGMr?=
 =?us-ascii?Q?Y213SR7buLMJ4+Zlrh6Jt1lGJha3w3mI2GYAIxNRtL4NzxxFrCjTguO5mqOL?=
 =?us-ascii?Q?4cKQBlmbp9L/lO0eq75A5qKFDFcPC5z7ju1t6sA93i40ndhHgopuqcWXyHyV?=
 =?us-ascii?Q?L3iUNVMg+nFe5cNdbi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4WeE330qzVWfnCCdBGnRObTg4rCK8Kf/P1nk5zP1JVsQSJoeXa4R1bZ1hDv?=
 =?us-ascii?Q?NOD+EKI+PP7OU95JVg8tmoBzY1cIktVCV9PUYdslOVBCGsczw/RZxiCQg59V?=
 =?us-ascii?Q?/FjOAM+WctuRY7Qiy6vR8TWw4TD5HetgiLx1fKz/qomLoqeX906AB/nmCoip?=
 =?us-ascii?Q?MviPjVDJgZwNGGXagLvGkgf8YDMJnrG+xQpV1dHa//8EAQPQ4hsSurXVRk5y?=
 =?us-ascii?Q?T/RD9YNgjOaKYcWoBvPBwJe7BPEEjvMuCvCko8Dmmp9ZqLhkZHZlGtqZR0yF?=
 =?us-ascii?Q?td84RN31+pjIvqhfLHyPmnqzVPysEiBDY8NkiNDoQgvhx3+LiZgF5YENdb5Y?=
 =?us-ascii?Q?pP1oxrbxPw2cO+7pS5UXj3LubbFo6NlgveYvlEkQI/ncy8sB5DCTe8cO8u8N?=
 =?us-ascii?Q?1xlrCtWqynKSCsHZKIsN2lB8e5aPVQ+CCtWxB58FvU5i8chxwh8WA7SFk/UH?=
 =?us-ascii?Q?c9EZa3fVwLZg8jM2JjDtofL/klshNThx67IzVGh69qTOs38IQi76dGr2VpK3?=
 =?us-ascii?Q?M9USKSipeojYXoZCUjprPapPSRkpZm1IMcRrOnNFuXv/YE/gvvN+rWPdUURg?=
 =?us-ascii?Q?flUhjts8a+II/d5NpJRufBylm+zydktFSM5oFsf4jHs80Gk+kjyFhe1YqUyY?=
 =?us-ascii?Q?pGa67L1CW6d157JxhUzamXtEO0OKkP3L3Wks9FfP6e3EiFkcZpq5xioQ0tFB?=
 =?us-ascii?Q?jN/dzkiuXKuVctCkZfgREHzNt5AhbdSiHhko/zp3uwjYvJRog/NB/QZrts9j?=
 =?us-ascii?Q?cJVJCttsHA7VxFrKTuMFoY1ajL8rUrIhffPLofSJqTJGifVi2bMMK9k+Uf4U?=
 =?us-ascii?Q?h4CvH7mGoWYnTXq6yyLphEaTode+BDzdAEg95mj3wkH3kuUE8+jJBjZPoOtX?=
 =?us-ascii?Q?uFP4BxCTUB9gtKLETWg43az46uCy3psrm9tqx6to2q8qtef/p9IK/fzRsv1d?=
 =?us-ascii?Q?A+n/l1KS8Gjr3oiJUg8LDpDWsZFyy2tM2BrqxirAhD9uJ2RymwjKss+aWIRP?=
 =?us-ascii?Q?AXJ0xyZfROpUFsu98+5kr1+8wruEDc8LLU4E3GgSUO02e3G39KnFozdX2cM1?=
 =?us-ascii?Q?NVMTdM4PTmBS1t7S1GvX5vI02FldJgN1dOlsts2C/Rjfbw8ELM0zYOFUkCl3?=
 =?us-ascii?Q?NMwuRJ5HMwifbu7Js55FKO1s8xJ8mtgC/c2TyfBicuYtPVO0LK7Z5DvL2hCv?=
 =?us-ascii?Q?qwfBARSCQDAxkCL5SEJIZ5+U1f4d+HOC8VV86o6CRV7vlPGRQosvklwJAE29?=
 =?us-ascii?Q?/Bq+84Ed1ETgC6Revoclv+DVyfr7pFsMP4GNmMLJLMRN1W/I5BXPCDUUlfIi?=
 =?us-ascii?Q?E2GQ1odR9G7Xrwf6VT42Moz66NvEW1YfVH2AXT6Wf/pzuLv95tgC1LcrcPHm?=
 =?us-ascii?Q?HULX82ViD3NaeDvGkq6nlRyl0wXauLQin3RiooFJYl67IsKis/l5LN4vX6SF?=
 =?us-ascii?Q?uHj7x3YX6pgtlhtCxTdB235UB2hyRJnH+U3nkRTkbqNSCNooFejr0UZ5ZPkj?=
 =?us-ascii?Q?JMTV01C+4Olk7ltBCW9q753UiQ7Ht0IV8F02f0XS6osS2DJ6fW4p9fg0RF7q?=
 =?us-ascii?Q?W/dqYJfeRmSXMEVJopkFtFeQHwodmeZAaK09gmZMvnYovPYEGn3BhGawFc1q?=
 =?us-ascii?Q?uCh7a/Xhqby6I3ZyNFlDk5C4WmGINdAUKsT20ozDlIl5j16HEA1OZv+aBBUx?=
 =?us-ascii?Q?Y/kZ7lodEkXVynUOz2Jz6OO1ZuNARxX58WXy1SMZ5KlewIQRxwgxPVpFkt1s?=
 =?us-ascii?Q?/Ky9QyEh51+3FZWvKozxJntrkwh/fYw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2af031-8023-4aaf-0653-08de592cf98b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:38:03.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cRdYuIY/B59Yt/J4UsiAxlaYKiE9u8cqco6HXtCZ7XHRwYsNgU6T31tcGDMj6ydlTHProx+XtArcUi8RBAxzurFCdZzIw2n0OLxBNLuEO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5422
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18268-lists,linux-nfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,libnfsconf.la:url,configure.ac:url]
X-Rspamd-Queue-Id: 359465DD69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If fh-key-file=<path> is set in the nfsd section of nfs.conf, the "nfsdctl
autostart" command will hash the contents of the file with libuuid's
uuid_generate_sha1 and send the first 16 bytes into the kernel via
NFSD_CMD_FH_KEY_SET.

If fh-key-file=<path> is set in the nfsd section nfs.conf, rpc.nfsd will
also hash the contents of the file with libuuid's uuid_generate_sha1 and
write the resulting uuid into nfsdfs's ./fh_key_file entry.

A compatible kernel can use this key to sign filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 configure.ac                 |  4 +-
 nfs.conf                     |  1 +
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/fh_key_file.c    | 80 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/nfsd/nfsd.c            | 16 +++++++-
 utils/nfsd/nfssvc.c          | 26 ++++++++++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  2 +
 utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
 11 files changed, 163 insertions(+), 9 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c

diff --git a/configure.ac b/configure.ac
index 33866e869666..db027ddbd995 100644
--- a/configure.ac
+++ b/configure.ac
@@ -265,9 +265,9 @@ AC_ARG_ENABLE(nfsdctl,
 		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
 			       [#include <linux/nfsd_netlink.h>])
 
-		# ensure we have the pool-mode commands
+		# ensure we have the fh-key commands
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
+				                   [[int foo = NFSD_CMD_FH_KEY_SET;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
diff --git a/nfs.conf b/nfs.conf
index 3cca68c3530d..39068c19d7df 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -76,6 +76,7 @@
 # vers4.2=y
 rdma=y
 rdma-port=20049
+# fh-key-file=/etc/nfs_fh.key
 
 [statd]
 # debug=0
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index eff2a486307f..c8601a156cba 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -22,6 +22,7 @@
 #include <paths.h>
 #include <rpcsvc/nfs_prot.h>
 #include <nfs/nfs.h>
+#include <uuid/uuid.h>
 #include "xlog.h"
 
 #ifndef _PATH_EXPORTS
@@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, long *pos);
 void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
 void			fendrmtabent(FILE *fp);
 void			frewindrmtabent(FILE *fp);
+int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
 
 _Bool state_setup_basedir(const char *, const char *);
 int setup_state_path_names(const char *, const char *, const char *, const char *, struct state_paths *);
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 2e1577cc12df..775bccc6c5ea 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -7,8 +7,8 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 		   xcommon.c wildmat.c mydaemon.c \
 		   rpc_socket.c getport.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
-		   svc_create.c atomicio.c strlcat.c strlcpy.c
-libnfs_la_LIBADD = libnfsconf.la
+		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
+libnfs_la_LIBADD = libnfsconf.la -luuid
 libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
 
 libnfsconf_la_SOURCES = conffile.c xlog.c
diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
new file mode 100644
index 000000000000..ff71e402f759
--- /dev/null
+++ b/support/nfs/fh_key_file.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <uuid/uuid.h>
+
+#include "nfslib.h"
+
+#define HASH_BLOCKSIZE  256
+int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
+{
+	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
+	FILE *sfile = NULL;
+	char buf[HASH_BLOCKSIZE];
+	size_t pos;
+	int ret = 0;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		goto out;
+	}
+
+	uuid_parse(seed_s, uuid);
+	while (1) {
+		size_t sread;
+		pos = 0;
+
+		while (1) {
+			if (feof(sfile))
+				goto finish_block;
+
+			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
+			pos += sread;
+
+			if (pos == HASH_BLOCKSIZE)
+				break;
+
+			if (sread != HASH_BLOCKSIZE) {
+				ret = ferror(sfile);
+				if (ret)
+					goto out;
+				goto finish_block;
+			}
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+finish_block:
+	if (pos)
+		uuid_generate_sha1(uuid, uuid, buf, pos);
+out:
+	if (sfile)
+		fclose(sfile);
+	return ret;
+}
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 484de2c086db..1fb5653042d3 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -176,6 +176,7 @@ Recognized values:
 .BR vers4.1 ,
 .BR vers4.2 ,
 .BR rdma ,
+.BR fh-key-file ,
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index a405649976c2..08a7eaed4906 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -69,7 +69,7 @@ int
 main(int argc, char **argv)
 {
 	int	count = NFSD_NPROC, c, i, j, error = 0, portnum, fd, found_one;
-	char *p, *progname, *port, *rdma_port = NULL;
+	char *p, *progname, *port, *fh_key_file, *rdma_port = NULL;
 	char **haddr = NULL;
 	char *scope = NULL;
 	int hcounter = 0;
@@ -134,6 +134,8 @@ main(int argc, char **argv)
 		}
 	}
 
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+
 	/* We assume the kernel will default all minor versions to 'on',
 	 * and allow the config file to disable some.
 	 */
@@ -380,6 +382,18 @@ main(int argc, char **argv)
 		goto set_threads;
 	}
 
+	if (fh_key_file) {
+		error = nfssvc_setfh_key(fh_key_file);
+		if (error) {
+			/* Common case: key is already set */
+			if (error != -EEXIST) {
+				xlog(L_ERROR, "Unable to set fh_key_file, error %d", error);
+				goto out;
+			}
+			xlog(L_NOTICE, "fh_key_file already set");
+		}
+	}
+
 	/*
 	 * Must set versions before the fd's so that the right versions get
 	 * registered with rpcbind. Note that on older kernels w/o the right
diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 9650cecee986..4f3088b74285 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 #define NFSD_PORTS_FILE   NFSD_FS_DIR "/portlist"
 #define NFSD_VERS_FILE    NFSD_FS_DIR "/versions"
 #define NFSD_THREAD_FILE  NFSD_FS_DIR "/threads"
+#define NFSD_FH_KEY_FILE  NFSD_FS_DIR "/fh_key"
 
 /*
  * declaring a common static scratch buffer here keeps us from having to
@@ -414,6 +415,31 @@ out:
 	return;
 }
 
+int
+nfssvc_setfh_key(const char *fh_key_file)
+{
+	char uuid_str[37];
+	uuid_t hash;
+	int fd, ret;
+
+	ret = hash_fh_key_file(fh_key_file, hash);
+	if (ret)
+		return ret;
+
+	uuid_unparse(hash, uuid_str);
+
+	fd = open(NFSD_FH_KEY_FILE, O_WRONLY);
+	if (fd < 0)
+		return fd;
+
+	ret = write(fd, uuid_str, 37);
+	close(fd);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
 int
 nfssvc_threads(const int nrservs)
 {
diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
index 4d53af1a8bc3..463110cac804 100644
--- a/utils/nfsd/nfssvc.h
+++ b/utils/nfsd/nfssvc.h
@@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers4,
 		       unsigned int minorvers4set, int force4dot0);
 int	nfssvc_threads(int nrservs);
 void	nfssvc_get_minormask(unsigned int *mask);
+int nfssvc_setfh_key(const char *fh_key_file);
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index 887cbd12b695..f7e7f5576774 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -34,6 +34,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -88,6 +89,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_FH_KEY_SET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 67cf27b04ca3..1d673d7bdc90 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -29,6 +29,7 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <uuid/uuid.h>
 
 #ifdef USE_SYSTEM_NFSD_NETLINK_H
 #include <linux/nfsd_netlink.h>
@@ -42,6 +43,7 @@
 #include "lockd_netlink.h"
 #endif
 
+#include "nfslib.h"
 #include "nfsdctl.h"
 #include "conffile.h"
 #include "xlog.h"
@@ -524,8 +526,10 @@ out:
 }
 
 static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
-			int pool_count, int *pool_threads, char *scope, int minthreads)
+			int pool_count, int *pool_threads, char *scope, int minthreads,
+			uuid_t fh_key)
 {
+	struct nl_data *fh_key_data = NULL;
 	struct genlmsghdr *ghdr;
 	struct nlmsghdr *nlh;
 	struct nl_msg *msg;
@@ -550,6 +554,15 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 		if (minthreads >= 0)
 			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
 #endif
+		if (!uuid_is_null(fh_key)) {
+			fh_key_data = nl_data_alloc(fh_key, sizeof(uuid_t));
+			if (!fh_key_data) {
+				xlog(L_ERROR, "failed to allocate netlink data");
+				ret = 1;
+				goto out;
+			}
+			nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
+		}
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -584,6 +597,8 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 out_cb:
 	nl_cb_put(cb);
 out:
+	if (fh_key_data)
+		nl_data_free(fh_key_data);
 	nlmsg_free(msg);
 	return ret;
 }
@@ -612,6 +627,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int *pool_threads = NULL;
 	int minthreads = -1;
 	int opt, pools = 0;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", threads_options, NULL)) != -1) {
@@ -654,7 +670,9 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
+	uuid_clear(fh_key);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,
+				minthreads, fh_key);
 }
 
 /*
@@ -1611,8 +1629,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
+	uuid_t fh_key;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1687,12 +1706,20 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	uuid_clear(fh_key);
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+	if (fh_key_file) {
+		ret = hash_fh_key_file(fh_key_file, fh_key);
+		if (ret)
+			return ret;
+	}
+
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
 	minthreads = conf_get_num("nfsd", "min-threads", 0);
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope, minthreads);
+			   threads, scope, minthreads, fh_key);
 out:
 	free(threads);
 	return ret;
-- 
2.50.1


