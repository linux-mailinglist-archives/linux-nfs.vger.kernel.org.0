Return-Path: <linux-nfs+bounces-13537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5948B1F8CF
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8457C3BD18F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C92367B9;
	Sun, 10 Aug 2025 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QcQnRkVE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632B1D63F0;
	Sun, 10 Aug 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811002; cv=fail; b=OUPtToibYnuFmKS8QQNYQ5SaWxiHjU9Z091X7cZRZBEgoeNYt9vsckkHlDKCz+ZBUBXm+SN0D8isElPsOtHRfP52HWSsPoYoqhZmCAE71iuzeh0IRMkFB+Vw/I/wM8HqrxvNIo1lRu+8JteyPVBP++HHO02ociWlW97qSRwo4is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811002; c=relaxed/simple;
	bh=+Le4aUt1VPioLSnU2w+aipoUrs7pnw0gzPQbBdNBPSU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dZFiNSOL4PqFgqLYvGqnS2Per5Iy1p6RmH7grSvsX8okBUeplBigeoBkZ1KAWgE32uG8mnDTfRNWYSTV2hC4lF9xwHSWs4JX2IkT/j+RnYfpVvNIEgkjh5E2eQqoAI3HnF0x9rCWj2PclsrLwH9xh7Nhj0BikaOhUTZ+vQGlJVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QcQnRkVE; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP5q+fVFNQ7E/9u3fHbp+t4r39MlnvwjqSGFnhvoVs78b9LEXlhRfexsLblyCkXtudAIIh8EASNfZ4vw4ej145QGBo8gpdjH09fp0M/jrebmCLDmm7j5L0hmONQVXSZNyme3kXHKDRftsfCia7S13/oROuW9Mcx7PrvyHOPNGDnrpbN3bFSGGu/UNw6Y5TyetnSKS5uuafyy6vAe99enDkVZ/rz5CQtNIdNy1ksFwZ7tVq4cgu4ZQ3m2dd78NAN/60Jpt8go+f4AM9950dzo46FZiVeCTXFIpEiBVo18ag8nZvxekG+VACFmTBqBChV+VIRLIBcsww9biQLTKOgHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx3Q6BIJsz4SFhMycTuBTm7WDPCKU8ZELUop8xyIIj8=;
 b=Q83XLMHKRNt8ShOEEEb2OJPsUq2MsKPA+EgIpS2lLl6zuPRqfbO1WC5So5gdp4/g2+KreLNy6buaPs0cRT9AEvSWZSBFgV+HzPkzaYL+yggJAJHqoL4sZWEokcW+sXLzZqw3UJFJcIjL60nHhqYesXGRXO6tVOnLortDXdZvgBQ/LbPV8HJ5zkh/yEgpT7FLvdRTb3X5Uz1GwLXEIgwdSZNAloe16wP4viTT8nmgVF9OJ2z8CNFmPQipkgAA7jJzYZYRzdoKrThwUE/lp+sNsbtm+TwVPGniFEh0pf9Lm1qc4/XZPBNs1jLfDQWUOdWe6xNnugAQxADA7G/Ncuv+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx3Q6BIJsz4SFhMycTuBTm7WDPCKU8ZELUop8xyIIj8=;
 b=QcQnRkVEIZNctZ0e9hVQIEa8DpqkTDayYJwA6jAeENnGXRyrmeI4P5x1wFCIfnbz3yhYXOvPNE+wb+CTS0U1fTfrhzHYmhQTJc8mhwNvECxMF0GjG9IBGs0XsIsa9qDp2ISgS7QXgiuGIltEpAcFipctIl5DEGlnoWz9ry1L0J5fkIxw//Ec7ZFtUrC5X2HvxKsGn6CK3TB5+edddvrtflDqdjBLwc9mAU3QHyoNu3l6oVBC7kXIqLPlwoZTy3O8x7DRl8aVi3NPG6hIJ3z0Z7fk3nhatxSxYfWqKxbMqPfKenj0GilfTohdSLOoA+KaNmpRFgA85HIopPScpNZk5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6576.apcprd06.prod.outlook.com (2603:1096:400:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:29:56 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:29:56 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP]),
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:RDS - RELIABLE DATAGRAM SOCKETS),
	rds-devel@oss.oracle.com (moderated list:RDS - RELIABLE DATAGRAM SOCKETS),
	linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS)
Subject: [PATCH 0/3] net: remove redundant __GFP_NOWARN
Date: Sun, 10 Aug 2025 15:29:39 +0800
Message-Id: <20250810072944.438574-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 273237f1-d127-417a-cae4-08ddd7dfb48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOcx0Ylzw9FfPrHWn8IkVkPaee0xdfm6bN96fQDe9gsmip6J6ruJfkTzWKIS?=
 =?us-ascii?Q?rbm/d8w4TwJMJAyODTHF0wmQn77o8Q+FqzRyyv9Uy552niPFj/mHEAVVGOpO?=
 =?us-ascii?Q?HZ1sNDDg1a8T5o2zv0G5w3qM/33WFUU6R3jkUuooAiLEs0x0+5Kp+r57EA6j?=
 =?us-ascii?Q?UXpUP5ZKKG7vJVQ9L7uCHmVP83LrKGW2Q7coUOwjvw/38s7Ok3sP89eGAzge?=
 =?us-ascii?Q?0wI10P5Jx7V0eqqlnJ705ncBfT+nBzAh61wO7uLOyS79p9Y1pKPH7A3eu7ce?=
 =?us-ascii?Q?uw5lKFlMAL8sN3PICoWADEE2c6PRj+McTlTYNEsf3q8A+T9XD/Qjidpu3VPD?=
 =?us-ascii?Q?FQxHduKAv54HSOlWgolDVf1C2Dq+zRoTb09VGTEpyjFBqpanhramsVSlRHBE?=
 =?us-ascii?Q?48pJbR3dyy7E762PmYf+IhcOxXnmtKxgfaGWlwRPysxWUWieIh1/oEHNA7u9?=
 =?us-ascii?Q?psirETpbdJ33QYeRRNM6ynR8l7vyljhEyXWzwCqn9ObfmOhR1xT/iHuTuO2P?=
 =?us-ascii?Q?jhWA0DLJSr6F0C4pSHKl19PosQuuOjtfzOWyNp4K8GWBxyLN0cdYcVJ0f2tu?=
 =?us-ascii?Q?gtpYLg3748Wiaqpe0bqEhHZuO+c9FGqxJggHpDucW2qfVFkrBw/6XFiK54i+?=
 =?us-ascii?Q?W3MCoN4unzXL16u9nvm1ySS1JdXEjKzpvKcEW1lOlOxr3GIXcnBqTZJIYiS2?=
 =?us-ascii?Q?W+WhjodEiIRccCCUaCwiJfVJYzOsicS7578Tcjj5RFcyZIVeErzJVFTqKnCa?=
 =?us-ascii?Q?ZT0zgsqE9x7Rci9qvEHVJ7KpeM0/UkO4f2+EaqtIZcvxq62cee/s2+56+cZQ?=
 =?us-ascii?Q?CvLxiVJ3TVPsO7y0JZhlwYU8UJWlv0qF7gq+ked2L+55rK0BY9GTUAk9/ODu?=
 =?us-ascii?Q?e0O5QJmRXYzPTucqhC1TFkUwQ5xgz6O5/jeBOMXqjdZvZKC+5t0nYYIoa00m?=
 =?us-ascii?Q?/OB6mqC4PtPrtRTywmzBTyTILU6Zo5IKcsj9U2EVth51NDkmmaOj4OF6+hjP?=
 =?us-ascii?Q?Zbn8fYXfAKOQVJ/xnfLXLD4J9OnLX5S35DeXzBXB0c3WR1D71SEc/OndYw4w?=
 =?us-ascii?Q?uLioF62mcA/W2+5cs25uMaCTYRrwAh4JRTTLAal726cQ//hHl1neryCC4Z/M?=
 =?us-ascii?Q?mgtf7Pbu78REBWObuOXufUdjOzWRbYS2hdii+TxWvqH1dKyIiMwyYrKQwVo0?=
 =?us-ascii?Q?5ar+HtQ3vgSfIiQ3TaIp77zkcHqysObaLFbG1Yal/sLpUwe/5Kc3i5zyjRcQ?=
 =?us-ascii?Q?P9J6L0InyDY6U1eJ2+EluakjWThEZYD483UHPNPCUk2hfiLPqpTPTg5ZtD4d?=
 =?us-ascii?Q?hZtoZ9+Hc9mgRFe+qcTr10gbOrriMUkDKkx8eRRXlkxu5nFObs9SABGRZG6v?=
 =?us-ascii?Q?ePlKH73h6pYlSonQXiig5Uzgy489hqf2mkgf33i2WfxJSlx3SMsKlWspRTeq?=
 =?us-ascii?Q?BSNkdiWR02mOjK5bjfV5m24dje/f9/nY+Wca3wYtFuC9xtr55/+UNqqdJBKJ?=
 =?us-ascii?Q?WFsC/kUEmEcGmoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zot+gfd9g2R1P0q5kavWQlDhI8aKQg+cCY/nmbiF8vZ20JNSu0Pv8Zul2FdW?=
 =?us-ascii?Q?0hiaFop4STacopIwCuJmnk6VBtNGIcvywkwb4rOGNJrmRzRETR8eBiMAvpVr?=
 =?us-ascii?Q?O72pg13KNKvR4pnGIIPLQpv7FU5pOeU6/OlAvkUUtBPmfHoEU1YATaRo/ZXW?=
 =?us-ascii?Q?VtRj6mgwLgce26lQUQXhee7y4Dmqs+nA6EHPlXGyAi5h3/eRmi92mOjB5XTA?=
 =?us-ascii?Q?G84wD0GW6lG3oiZIYG7ANmxpGvCy1XDEMl/OBDXfbPMpbXIdfn/nOsRjr+GJ?=
 =?us-ascii?Q?qOmkb4aL4c95otFEHDziYPq1w9JFNHeMfusCusTFdjwDHI3Hq9nLpRQxVMMA?=
 =?us-ascii?Q?QmPYtqa1RCzBHEUDKjm71daAcBrtdAe1uiIj8m2e+PamRrtBgsqcrepS+8U1?=
 =?us-ascii?Q?AXLCPefTdoBCdtsFHnF4X55O4JA6jh6Xf8l9hZphdmvmOuRScw678HBk37tV?=
 =?us-ascii?Q?ecEkwwAORZ7kECECRaOSDgc7kOpfZRlkOKBodbMVfGGbN8CGNem42gJb+oLT?=
 =?us-ascii?Q?ak/bg6mUeuL9VX7Tw2UTvbpkY920RHKF8+vFE8wNN7/RQhUDN0l1iEutmis7?=
 =?us-ascii?Q?iLV76Y58weFzFEv684UNKVCj/4AqAPcxOKIsN3Zj0JKLqe+jC8iRaz82YoJf?=
 =?us-ascii?Q?DLiB0kQtrlDxOwNBPXFf/hLQFBgWys0XanqzbUlDeiTUu94iF0Q03l1qBQGv?=
 =?us-ascii?Q?f+Ux9vsMAX0H3eMSZsHV3IBtmUQXTSTLNLWTriF682cSI3xWDiZ6xGXyibpO?=
 =?us-ascii?Q?z9QMo/W66bpbfDly83JEMWEgDJ8BwTG8A6v8mUblE3jfYOraC2ny6aopjp05?=
 =?us-ascii?Q?JZpP7XDgNUikz8LMy2iwXzf2I50+9BVjArBAsNpSk6DOk5/OYxNg82NWTZKl?=
 =?us-ascii?Q?D5odascNLEzuOt5c5roSLQ0I8wbIE6rbs90K+2SmAE3TWu+YggVWbNQvgF5q?=
 =?us-ascii?Q?Kk5Oa3XCJH7r3jgjDLsUWE9mJVs4uB2XJF1llG2dg7/pz2UX/IAjnupwXH9n?=
 =?us-ascii?Q?hm23uHbi7UE4u91SD3ti/xAb7FSjThxuhIm8b3+sCgAa0E7Mjwz9Fa5J2s83?=
 =?us-ascii?Q?QBCq2UxsBAvH1ThdC3XfrjcpFhuoae56FtnlZZXiRqe9IGfmfATzSrPhzVG0?=
 =?us-ascii?Q?P5GQ33ZVIrqPi3nTt8dLUPYEFqrr3hi5DVTvMP2v/ADN7JtH+3RxB7/sO7UD?=
 =?us-ascii?Q?MWl4DM74IJHycJIb/fztd7m8IsjzrEltcnf3u3KxVMWO8AP6uaDlQhv0Xgyz?=
 =?us-ascii?Q?kzH7v3LJrvKtMLtp7VLiTpd3haslnqB7C6aPzq92hwavj5jW6Ka7W1hj9je3?=
 =?us-ascii?Q?mhCR0p0nuCDbPzht/F5SQYd5/DmnPDDZNlNvVfZSeIMgpFy2AmDK9k7T7M7j?=
 =?us-ascii?Q?O4TZxhgUdMoOlhsOSrWfeQ+vFuMNWafuYYLeuOzwu6XD7fh2JcsvXE4bhKY9?=
 =?us-ascii?Q?EiAvvKKtwatJJXZ0/8ubHqdKpXVPIRHKz6xaqRlRG6hUFruP8hSAZyZXVbtZ?=
 =?us-ascii?Q?wUc5NX0AGQDDHRXjZcbm/7V0Bc0To8ZFi1VoO6D7nlRA1gL4bqVmDCawefU0?=
 =?us-ascii?Q?ZzluZ7F8WEkf1HWk2R9azTmge42NLpMMl7KnHgul?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273237f1-d127-417a-cae4-08ddd7dfb48f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 07:29:56.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErNI0H7fHJlP4+xY4r4sKEyBgNcfQA+o1Oo2NUrU590uC2suL/kHwsx8eM2ZC56Nn5H6lrbKzcKkylSM7jyODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6576

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

No functional changes.

Qianfeng Rong (3):
  tcp: cdg: remove redundant __GFP_NOWARN
  RDS: remove redundant __GFP_NOWARN
  SUNRPC: Remove redundant __GFP_NOWARN

 net/ipv4/tcp_cdg.c             | 2 +-
 net/rds/ib_recv.c              | 2 +-
 net/sunrpc/socklib.c           | 2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


