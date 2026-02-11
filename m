Return-Path: <linux-nfs+bounces-18890-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHfWDQ65jGnlsQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18890-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:14:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DFA12683A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E608E3011787
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E422FFFA5;
	Wed, 11 Feb 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="dvjP07FU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342D288C2F
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830068; cv=fail; b=o4noF0XhXUv9uLDqjLRBki+ruj9sOPBraZZDwHmmlhyqB2qsu6loK3rBg1uzhN1SKjfclamcnTldHSLt9NEroBOemSnQJTlsZEt+gu0CUWAzgiluoJ/rTzbB9jocDilRsHl40mtz3Ghz1GSZFeM9Gq/byfcUjdeTr9k5A0IqS+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830068; c=relaxed/simple;
	bh=jdjZ7y9dzsZuGLUWNC/33ToMoDL9MySWetw4jVKplGk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lk55Vz6zigattOHiC+3m+0NGsbA62OCtVo/QmPVNeIKRCkALYkiPjDbOM27rIpr+tGiDm2WrHiB1GZWMbSh7Ig2cjt/OqTlj0LH0TvIaGf42FaqbYJdEeEA7ufaaZR+QYWMd204SUxGaiDU/WcstKCm0F5pmYuuozaWAeY1uPJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=dvjP07FU; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB1H5Tel83ho2XKdZXBmlEFlG5sJa9A5aogjJoTl0dnIISL3DyR8iR++T4INCGCHdg4OEhRbP3N3Cs3R76pjSM2vE95t/LNogF5tTqo8hqLG8sOOHg5bFv+zpKi17ULvs7jmHUX2wvtuMTd2jE/TlgbY/W6yl2UQtasJpMD4SkdEfafJjEwkyeVNlatZTrUXeDB1m1mBMXlN+J2aNm+qPprF78ozPcJsokjghmNLYGA8T0Kq67ILsiHiX1EXzDfFDtovHkS5jemYIOl0XVGMB85f0qp5eQLXhAvVpPX3lmUgLesITbWbVQv29b75OGBGLZFCVjeLe9Wwj7vQ3UxOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpGnvH3MKgD0WUI8vQNij+ms2yq1U1r0r9rvYV7wKr8=;
 b=vrcD1TVkBhsKueCwI+ehpH2YKSyqwkKk4OirHSiXBBy57qtmTLPePrd7Wui/x40HV22s/okGjwzhafSTDb7hVP2oAifSDP2/R1eYI10T0+5St762/9p6u1oVIyJnB66Dipoz5R7aNT4Xz6+rtOhesKzpjeITUYLgs3aucDiP8BNpBOv9Ssil+MSd4bd+C1xl4VF2axqjeWfH3oP4u6PZ5c09SvY0qBK+6nqPLv3Z7L/bmYEl/mVAzhKn4hpwDj4I5wdxPqgftf7n5JwYdyy2Gg2OdqRFRYRdwz8bm5Rpd8+0XyhR14V/pCb2VV0uhpAJVyZW06CJCd9uFNk5QI0vPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpGnvH3MKgD0WUI8vQNij+ms2yq1U1r0r9rvYV7wKr8=;
 b=dvjP07FUGpOO6RZ3fX2xUnPJZjS2XyBvpMuAo52eBv5ekexN81Sjg71CH34c7S6FuJkqb6UBxUjT5lrz2DewqFht4jprDZcx15x5zB+6dmMj+cNdf76/H9tTRWlnRWrCkeGcBHPIiH68Ch5ZJAp7VggDUX0L2c8I5C+DE7jY+ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5941.namprd13.prod.outlook.com (2603:10b6:a03:430::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 17:14:20 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:14:20 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 0/2] nfs-utils: signed filehandle support
Date: Wed, 11 Feb 2026 12:14:15 -0500
Message-ID: <cover.1770829825.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: b61250c6-0f1f-4552-e769-08de6990fec9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a/QjqHxPrIioqxPNQcY4LtDhpjcZvyEBYAIHHoh+K9km6HDvW3cOfS5B4ZUe?=
 =?us-ascii?Q?Ht/pC978jbsQXhXOKinrZHG9AlJF8KaWVwja0bGn16EM/qdvgQIBR7vc4iaJ?=
 =?us-ascii?Q?BlKa77Xou5I56pxG76VAGnEiQm0fQSAhHBEDUN4B8sACTTzhr7Yie0qFqe1L?=
 =?us-ascii?Q?+J8f4sOaeDJSf4XYvtAtaXxJr++8vOYk7FtSETGat+H6lA5wTnwzMacr17tp?=
 =?us-ascii?Q?81rDuz2amjU9MhKXsd6TPvxFqAt6+zkoTvbJzWx4jVSlzVqm/Ykeelfnq/Co?=
 =?us-ascii?Q?/GdCCa0qUKJiHXHShGTlmC7ONSQPbU+OshL1A0OFS8AtSakH2Fp6pjMaZOY1?=
 =?us-ascii?Q?wFQOxxtE0AUeiOIc59942Qk1fv1Of9MRoaieguN0vYyhckZlRuuapAgsIP/W?=
 =?us-ascii?Q?/a+mmX1Df1XW87n/xzLD9sO0Vrz2WQlqB5U5NiaR5/HwABYSzWKS02bTUuUm?=
 =?us-ascii?Q?im8A96hW3MynT+ZrevHHniQfm5O8YDh8D6fpz0HOBkANh7nLler5GuFC5bcs?=
 =?us-ascii?Q?r7PuLtWLLJGegeqZNmL4RckpZLrzAX7whvwRvHNxtVOvRT3z2HH/OspP0oW/?=
 =?us-ascii?Q?kn7XN0bRkk7LNSarGFBYta7HkGZ2QJkonBTGAJwgv3A5S2ISp23mh7QhSg7y?=
 =?us-ascii?Q?GJ5QKExI8pz/oZrIcMeLIiz8RwZozez+Ua3FbYxb0VWUah9wLWmTcvVSW+bV?=
 =?us-ascii?Q?1XFtWlU/WxDqLrrbR0y1fA8SX5keHKnB9gqwLVgi8NqDf8snBblTtmlOSs3Y?=
 =?us-ascii?Q?OVvtl92KLec01HBtxJHajAOgOKauslNe3VELUzj0lzvZ5G9Y1mkI6/hMojh6?=
 =?us-ascii?Q?j1DeHqtbYGcOnrUM2DgK9plBfltuQDD6IXI+89Ky169fCZJXYuJg6NxXMLA4?=
 =?us-ascii?Q?1HmNiKSvfAywtq+m2TC3WdqwwRFh5b1BuFJwaPR+ZaxSU2MspVX4tCbczOJg?=
 =?us-ascii?Q?ola5gPXC3qDgupatPeTevACJoyu0CKMYCSM3ExmALFMwuCMeQcFpRq8PTPKc?=
 =?us-ascii?Q?8jjg7KhFswuBmVvY6Jv08NL0gt0W47dQrQdUM56ijkCpfH7zxRybeiaXRshm?=
 =?us-ascii?Q?kvf+lZ0mbBuk8VcAzTR42jBG9AB/Lw2BSftxymGEvyNk0GLTrVieuiwzQnyp?=
 =?us-ascii?Q?kuW725o9UIONmOrFbmOCx1RQVQro2rRHrzmbR35cO2U3DjnQUGekuXZgb1EP?=
 =?us-ascii?Q?ulKq2Oje9xuRXou5QN3j21/v/+5Z8d+gp2OTwh2x8MxnkwXyXcEbiGcX2pwj?=
 =?us-ascii?Q?xP4TPRRneZpWz1tE0xf2yI42D7I8kspvUf8kP4xH9AMcSdCg9my7sE2rRJY/?=
 =?us-ascii?Q?9vx8m6McYGU9fyoKO6h8nwEk7MWzF3FWO1OEnI2azAsRAoVXoEIWb/4APZxS?=
 =?us-ascii?Q?ZObc0ELTFGJkgeqQkqNDr+dEGg2WXp8s+z6OG2rsTpOeZ5BW8GPv/R4zd7jB?=
 =?us-ascii?Q?+xeSNUegpe21wqDqta60bzbjhpG/kEu0Y2fQAD5VViwR0Nwe72cqLJVaSMzl?=
 =?us-ascii?Q?ua/6O0ngRARLRkCucIPV0SMXbFSPehASJaav/9yrxe6bfKllwkuNJDdNmA41?=
 =?us-ascii?Q?dI8iIXBCwBUinWQSueU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O6EnltDy0HmFKD8MZq8ZCQUny6/e34QeMZVTGkx8ks0Y/Ic3kQpr6fK13YAB?=
 =?us-ascii?Q?fTbLDEn+Jo78vZfXppY/H1i++d3TbfynWXFTvqs+oyRhRH/w8wV4+/xlS4nD?=
 =?us-ascii?Q?fn8LY0OS3i8SAnVrafkNhanU/2LTdcyQ6QVmPZBSjExIPv7LvKR0lfE9K8wm?=
 =?us-ascii?Q?SLx/EMTPD4GPtWk6K/eDe0ffXgeMqTn4G58lxve7UrLJg3RNkiJtD3O4Qlh7?=
 =?us-ascii?Q?jkWTox0VRqmtdkI/aMbVikX40XRUqhgDAUixcb1s4JUV/NWZD/fmAKVlDMqP?=
 =?us-ascii?Q?IwAKdMB+kbkgzSmgNpN1g7/g4UNIZrTHJ06JRmr0NnKgdm7hLqxJASS7wDim?=
 =?us-ascii?Q?M3/tWzdJ596w31tCPo1N4hCDtMY0Ly+QDMOpkj3s8WmYsSI6N2xtErQ7Ij2C?=
 =?us-ascii?Q?AY4gCAJiAASMt3QLLPhr5KO6OHxFT3ubj18HYh9gfXzwHCjJ3HcEBGeklm2a?=
 =?us-ascii?Q?scUMTqBL4XEF4zhMTOApirFfH6WBiCn6CnBxCTn21XWo6eIM/q0NkDb+xuF3?=
 =?us-ascii?Q?lIAZbJZpHE8Sklx1tU9zZ/yaneULk0wRNoIXm8SjLP8YcjoVkUWBAf+jJg1q?=
 =?us-ascii?Q?6k2Cqv6DQCyNHUHolhzWoxAx0aEHTDWens3+/DKXrYRd3sB2LrcxUEKCB2uC?=
 =?us-ascii?Q?Hr87hnC8pR6Bc26isN4sJW0qGeZI0XAUwnXvHSXv+C3l2qYf/3i3mR5UAV/l?=
 =?us-ascii?Q?PDtMI+ZR+hAOKa6CQJOa8T22T6omVtzCVO/a8nfGnlBz2216iil1dXS5x5EB?=
 =?us-ascii?Q?RIK1P1vIdTzPYGpcMg3NMYjDn/96Iu1NoTQW2PptKDd+x3CP/VX6Ye9doUmn?=
 =?us-ascii?Q?em6LVI5wZl+Ceb7fpbPho7djpnQahGgIQp+tkooKZ+6yCY4HcLSRiW3Wz2Hs?=
 =?us-ascii?Q?r0Kd6SgQp4Z5a0uzGzpZeIsLXnjFYQKzZFVC0h0BoCqWQDsHrO3hY8Xb5Nxd?=
 =?us-ascii?Q?HeXcyRAvCitEfAChMKA/baXMO8K/A9fCporJi4ZVAMHbojLQeQaK4R+Xk8og?=
 =?us-ascii?Q?6dn96zGS9pBH64ne0XgvihQLpZ+lVhFCNb2EESyXZaTCphhpEcFCWxiensmg?=
 =?us-ascii?Q?XNAes88GCBYQBopCnMwReTx2U94ARn4FOHA91gkCPL/l8sRH4zl6Myu5Mh98?=
 =?us-ascii?Q?boy6sgMoG9M3merA0MsjNvmdjRAaWEk3nDSd42SKjSb7adYwOun/LyV9Vqts?=
 =?us-ascii?Q?v3xdUZvRFnr2i3lo8qbLtF0p9tEh7luNn/jU8Id5o/9+4JgdHAuTAmEHxxxu?=
 =?us-ascii?Q?57n+hMrX2tj7VoSuzdSbTdQbQiWh6NljvvEhOhmQ0yvOhsxG4tdebVJXNmOJ?=
 =?us-ascii?Q?A69MK6Xkh17XTe1s5KlTy2j+VNV8+9eMfzCy8akgK8n1uukGVd+NA98jqXJ/?=
 =?us-ascii?Q?2+B5NJ56WfmoTzaMoOenEYgw+Ey/hTaKlQ5Pw1Juhl0nP/LffqLgu4BaWgsS?=
 =?us-ascii?Q?8hZiLxRB0NfQawR6l/cBgBB8ir6Kmm+8TPLHt6t1Jc6iRSW08/of04kKwjfj?=
 =?us-ascii?Q?6utW8hCvx4WVrABF4njI9wc9B3nQ7tY7x4lllAnRzFsDRjcYLEz6Oi6iZp/Y?=
 =?us-ascii?Q?cT118CB5/Dv5a9aCMr+xMbyMzQMh1vTCg9EeYxaIfgJHf0XHAAvTg1lPY7RI?=
 =?us-ascii?Q?o9uL2MVMbf4fZp+l1hrld8JhIJmv2Mpz7WXFfZnatjCgvWQZjVWgs3KslxRZ?=
 =?us-ascii?Q?dYpv0O9nd0Tb0mpDEv76AGTWa8aX7tb/Bbdbx68iUwEj/+i3EEFJ4euONxbK?=
 =?us-ascii?Q?sre6Kss9eBQgCxJOFkdR3fA3vrLtINc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61250c6-0f1f-4552-e769-08de6990fec9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:14:20.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXyfTamI30WX8SP0P88AtLBW6PEe36qFQVwf5Q5LkBdlU6jiTWDKxQMszxwaf6YCSNcUgFF/e5vYz1i0B1oMaRPXhd+par58uZrKQCKVm+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18890-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: C4DFA12683A
X-Rspamd-Action: no action

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v6 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1770828956.git.bcodding@hammerspace.com

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

.. and Jeff Layton's v2 series to fix up userspace handling of kernels that
may not support the most recent netlink attributes:
https://lore.kernel.org/linux-nfs/20260204-minthreads-v2-0-a7eba34201e9@kernel.org/

.. and my patch to automatically load required modules:
https://lore.kernel.org/linux-nfs/09076517d782c31cc0a654563b42b78c846c5f38.1770236512.git.bcodding@hammerspace.com

Comments and critique welcomed.

Changes on v5:
	- add -k,--fh-key_file= argument to "nfsdctl threads" command (Jeff Layton)
	- fail if "nfsdctl threads -k" unsuported by kernel (Jeff Layton)

Changes on v6:
	- fix a premature exit from fh-key-file hashing routine

Benjamin Coddington (2):
  exportfs: Add support for export option sign_fh
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key

 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/exports.c        |  4 ++
 support/nfs/fh_key_file.c    | 71 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 +
 utils/exportfs/exports.man   |  9 +++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 +++-
 utils/nfsdctl/nfsdctl.c      | 57 ++++++++++++++++++++++++++---
 13 files changed, 153 insertions(+), 10 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
prerequisite-patch-id: b0d57152c98d360daa9a71e6fa9759b7eb9de348
prerequisite-patch-id: 99680869954aef9f878c24ec9ee1302ab7f24b1a
prerequisite-patch-id: 2ab31271461352d11bcce760e45573f9e6459553
prerequisite-patch-id: 22c392c9dba2e63916af6cd8fbf4e9d6bce9d01c
prerequisite-patch-id: 50f6f48932426f89060eb77de58718baa80b979f
-- 
2.50.1


