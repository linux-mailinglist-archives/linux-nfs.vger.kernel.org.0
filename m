Return-Path: <linux-nfs+bounces-13538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F9B1F8D8
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0F8189BAB2
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142B238C16;
	Sun, 10 Aug 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gfzz8JWm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012035.outbound.protection.outlook.com [40.107.75.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47A23816C;
	Sun, 10 Aug 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811012; cv=fail; b=UdXMQxpYRTWmxv8Pr+jJpW0ejlorLRRYPm095wh6whviVbqYIMUVLKV3tBA4hF8gydKv/4XtQfBXTi2ZswnPC885lItOEgqud2rvrJLPoPkhwyjNK5+kOJprSHc0E3MdkYTMwud/FdsQTE8vN7RZPpDv3vbbySGLRIZdWAXj4O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811012; c=relaxed/simple;
	bh=dtw/Z6Arvokvg3SB94PHMTSg1w5dyToSjTJfqKqKJdo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMnLHgETPEKej+M8+Emy2DUVaQHLqmevL8/dKMi2WV4Gcdf/6SJUteex6nKE2/UWEqbDR4vGcebAQNYAuvp0f0/SAM1L4k3EUocLjiojt0pNTtwzq7Mn7bj6yMUXcax1gd6tPjzn2npmT4moorIORyhIWCClRmWi64TdEE5l+4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gfzz8JWm; arc=fail smtp.client-ip=40.107.75.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+2scD6psuk2quT2WyJWMv0tRKnzyfnEqixlOZicZ7jnaSLa5TvpH13T0aXzAOqvyQ9cF6rVsdnQADfgTk2/MUhvW9e9SMGsJIJaneiUTwcOXK+DNBf0oLs0sYl7TNNGlYk/bITCtwiyL/rfvtJhWzrbz5IsZ4743rq9H8SrHxLJjF1xC7e1HPdCpbmZ0I2xGpSxfi9Bjeyu3v0Kpr8lfrS9FjVodYzxTHXlqhu1BY6EF8Nx8n8GrDW7PvO17g6VBT2MTC/VC/EVDkUrSdWUzqt9HK85GPCtAEW4MIGmpWt+ppbb1VGIoeB0VKpxRe4cjzmvL62bs1mbI1Yl7ltjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwxeiwQERY0r5ozBHYGRJHsIYIn4n9Cb6wcwDEJuLb0=;
 b=GjAh+/O1es0Hw+j9kLhk1OtaAeMfEwSrxFkr2iLMl1HZdz9j3UzxKawBlKbzFdAPSnk4m9baJ0Kh/+rjhAvOX4e9Z8OPo14dI2nhDFDJRigf4srKY/3TtqGCrKyT/2JoPdF5EZ6bJurTagiKsrDQK1aOiAeigTktrLJyVcyLWKf6w3oTwD8JGX1CJtMX7modGPN5x10ioLAHddIMX1+QzgytZAVcsYHGkzNX+RLdR0UG9mombSnMc9YJB9VcpPAT+czPXwd+LEFbrWaqlFP6kieRaVu3vaq7M9JT+i2i/pKh8Ea0oKe2z0bFrLb9ZF3SvioNHeVUdO9SVHcQ2UkZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwxeiwQERY0r5ozBHYGRJHsIYIn4n9Cb6wcwDEJuLb0=;
 b=gfzz8JWm2GYBgr5//bRz4BieL9I5dURfheV7H61GbthhSrQbTQgcLL42muBA7eHhYY3IkQoctJdIulgie/34MWf5cetD2FIOcgc0V79exyCZXWGYggSKhuG5zZ4Edb5/ak+i0SnEIj7chVfbtJwLRxtjUfT2+1O5YDogK3//3Wp+ySMECfE5/o0lVe/0PRT1Jgzzs609LYmvF9UewVMioDL0uUn9YywK+70jhPFd6WIc9++WK20TKrnfFwU+YGU3T+KBbu2AvWsTYoRARXyvwd+w/mbn1xbrCysyx7S5807+NvsMkhLk4/zpbU3k3942n7nxSWg7qPQJ6Lu5QYWc+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6576.apcprd06.prod.outlook.com (2603:1096:400:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:30:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:30:09 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] SUNRPC: Remove redundant __GFP_NOWARN
Date: Sun, 10 Aug 2025 15:29:42 +0800
Message-Id: <20250810072944.438574-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810072944.438574-1-rongqianfeng@vivo.com>
References: <20250810072944.438574-1-rongqianfeng@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e03c2198-d634-4346-e8db-08ddd7dfbbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjEgArU55NWUC8x9QP4JryL/jwfD6gFux3XKojj36lI7BNmOU7rzr6oPqFEP?=
 =?us-ascii?Q?Ak7z6CM0Nv9F2xRbD9QZVLfJRHGJ0lUCWOlWzfyuODE01rQ9rcKBKJOx4l4j?=
 =?us-ascii?Q?Cv1tu/La8HPuamQ4DTYiZQTzlGl3ta6f0ZrH7gHFKwKBmkXUdCX4vnBZhuss?=
 =?us-ascii?Q?4nOL2tIfcJVXPOe9480lh/tOHeYudigf3sPHvpBVuz2tWOpJZE96T6c09TnL?=
 =?us-ascii?Q?p4/6p1rOWW22bC2PZKqM3tlhKWE0f0DsPn40HyBn9QX9OJVkx0ZyipPOeZaQ?=
 =?us-ascii?Q?akyXtEv32MRFB0gQjd3zh0obB3wrgbg0QQHRUfZG3qfxfKTAfPL5kmMKWX77?=
 =?us-ascii?Q?f5jv6eRjlEaUJ57hY1owZoAq+xcr3Dipny0XHJDXIbmioIC377yk17ke07TS?=
 =?us-ascii?Q?KscBCTlGodKBSviveVnaJQFiLR2eAxgB/R9uINaqMmodAESpJbEab2s1PeH0?=
 =?us-ascii?Q?OlMapfpcy9gUzg4cPd3ZPxWac9Acrp8M/wEP8Jj8vlRE1KIlUHVQhkEwpy/x?=
 =?us-ascii?Q?oXWRyz+JAvp/OHa4PUHBjBUGVp+0fFHktLuP/WTI/Du7VxWb+5nUgoNQ+8KP?=
 =?us-ascii?Q?avTVf/YYv9iVqpePi+CgWrvM9a4+nfvzuojFS1D6ktAe8WtSAaI0WA5JVeoi?=
 =?us-ascii?Q?sttl70stNUGpWWLEg8D9B4fzSU2E90H8t33JpUCZqKUZSoxpmx4TDsRb5tNY?=
 =?us-ascii?Q?BjsxhgpUhNR9+/4daTLbM6xvzovhCYUMETM0iSH3Rn6IbtdTcsXd+tFuo/qR?=
 =?us-ascii?Q?qHCIobwO3jJEwJAclUXmm1TgCBDDwUwdsx/4rE3hLKQw68s+8y+V9ctGfYpq?=
 =?us-ascii?Q?ZsKQw+qv2m7lgy3hmgneXl7gYHiD+gZZ3GXmBHjMgmpsQahhIs1XSyWQN/OQ?=
 =?us-ascii?Q?q39EVD7SydayhB1yJUDH1A3NUkFIYHhpXVsZ+XCOXcnxGE7s9DbNU8ICATOG?=
 =?us-ascii?Q?995Cs3rJ/lK0v+ycgP6sNfJS2favNBV1UA2Xzq/c4WqDmALzE2AjEAeHOIkI?=
 =?us-ascii?Q?VRr9OXKbZESR9DP2gxDHYmDv2KBIwOdw40UItRkQW1QDFDaExv2Diq8d/DTA?=
 =?us-ascii?Q?hKakJTAEU3YcjcwNVylQOG1hIbRzMitzAf9h7Ay6rGdNSr3ZpQUJ4xLlSMRm?=
 =?us-ascii?Q?Gfg4iuv0YfInxhvoj2s2BNCvVk27LjskeuR0Uklb1NxZ/I8KUVUFJL80awf7?=
 =?us-ascii?Q?KBpAqOoojKc1lDR7nJuef+UyVw+PAXBwcG/05Y0Y/mu5MOYt7vJtDewpmWEv?=
 =?us-ascii?Q?5lXybH9fdBI2SHCW4CMVMm3mOm+lYtuqR+cTsd4lbwb3vEyHvRTEMZhwjHi9?=
 =?us-ascii?Q?KBjMbaapMVnnZOuPWc6XGCo14xeXa1XOQOll2Z8UyJdpVLMl2NAs/b6T77JO?=
 =?us-ascii?Q?k4zDgrhKCiflVY63UbW7+dzneQQDAr0KF157YjB+ijxYAaBczROUqsuZWW3i?=
 =?us-ascii?Q?6SSVf/VlGiUA4YNbSexG9sRaxNi0JeJ3oHYgmP55Y4Sx+bBB1r2kgOdEwaKT?=
 =?us-ascii?Q?t7ibvo8xTrN0cZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2F5Zjy/VCfP2AZtNdsFWtsGxxqRCN5+vQgvtUy1BXv7yfmibZnaQXd0DwxAg?=
 =?us-ascii?Q?nBdmenmnugm07Ok4uCggLCzHlhCQTr+FODNzHJHUzuhJE4S83RR0/46plu+U?=
 =?us-ascii?Q?+PQoYBAsOTqMD9a4n9g5fKaCM8EqMPK88E5StPdrnoJEUpL2H0YwhDqLM78F?=
 =?us-ascii?Q?J83l55gQ7cU+YLQJOqXpkORuzsIH7GGhefcZpztYbO7w/9vqi6kGGTw30BVT?=
 =?us-ascii?Q?ja4ScDd7NBNcZFDE/M/dl1PXVR3USaWbzyJrEjQjzkW8Dr2hxY5F/RQ/Gx2n?=
 =?us-ascii?Q?oOOtEKjjgYDKB1VHwnD1mAiP1XxLm1ukg84GZyfpmlPLBVhLPDRv+cOefDwd?=
 =?us-ascii?Q?lObeDuQjHZt694Pubwkui3U/U/eNZni2YcaSSAztOJFxBQjS17zXPQEntiZ1?=
 =?us-ascii?Q?XJohkAGEr4ItD05JL7pwGGogcoJ9TlKG5AgC5QlO9qN687+nciByBQQVqlQK?=
 =?us-ascii?Q?h6LAl8hQuTlNVt/oO/EjF7zZ4m+9hvNszXkyzVoH31/HP91BF4e/qe1eKNzE?=
 =?us-ascii?Q?Pr1uT4W7qHH4BYk+XvCff21BsBGp3f/Ee03oUVdcfnivQowMFTYTRgiSlQx2?=
 =?us-ascii?Q?vc09c7jKSoguJXySeuAv2n3ZJ11+E/rx67iqvZr133HH4hKvKyOpVaQm+2+E?=
 =?us-ascii?Q?nQbe9MILC10m9JQiN2IiltCYU4dMkaj8RgfIYLjTV1Q1WBqPMeW2TRhp+YZ4?=
 =?us-ascii?Q?OWm1d28T9RzC8AGinlKnCeZIlZUgXdGWNJrlF3tMhS7Dn+I89l5P6alGkFaF?=
 =?us-ascii?Q?fwcAI6+tZcTBPeV3qotl36dXXT8NB7A2wi2RDAUokcmLQ1GuA9+FWA8h/fqE?=
 =?us-ascii?Q?qbKd6hhtIk2hqo7ydP+7jtcek/CNcXhTV5IHUs3Pt9gnJ7DSEGYDaeo1YF3x?=
 =?us-ascii?Q?7/1SZD0/QMOY4KLBYzhXdOeTP2pVQpmEMBr+QPd2U4QvfTUIpsJDs33rGJVp?=
 =?us-ascii?Q?X+BefRnZk4X7rR/S0398Ye6ZqPuEFd1jYE3sr9KGpD1T8RRB/nWPT97S46Zv?=
 =?us-ascii?Q?uS0v2oaewU6eVb8zBZ1M2g985jILSfLr8Gn+oSywooTVDMxzujgFarh4bnNw?=
 =?us-ascii?Q?KIAbvHuKtQDvI9dCnJwqPjVmEhtHj/jgOiq4cbGTp7lYibJX6qRq+u8XVUV9?=
 =?us-ascii?Q?vc5oJZ8DzNvCCmdH5RKjMeqvVypq0cjLNFpy6CpkAVRUZ3p/JhYtUwDunMnQ?=
 =?us-ascii?Q?JUX/KKfSHt94DFcVh1hHicuiRKAkJ/sXtuVC0FHWgc3WZl/bhpdN2qH5ZAfI?=
 =?us-ascii?Q?vyl3FNnr/I1DLXOD/Wz+2DpgP/ciJkCo5l0wKm+F+mhgYYLN1TwyFLX1X2nA?=
 =?us-ascii?Q?gompsGFWHXQjbHiRO27/DXwaVyP4ShX3sULox36RqalTeXmTodpwM1JbqGU3?=
 =?us-ascii?Q?RcWw0n6uH23gChE0Amqr5fHmJ2m5ZC2Cns+L0oVSSU17jEoxdDiEDwKKcIIj?=
 =?us-ascii?Q?0soPwlW5346V6zgGlJqIksQjFYvW8xvPcKMP6L8RlAG5xacz1m9UyDlSwyOj?=
 =?us-ascii?Q?310uXD18OIcOGNyXZHMtgWg3sOzCNKIo0nm/zU9e/OpO92x74/oDst81vtkC?=
 =?us-ascii?Q?BLtUMwT5hWVxkHOns8fdWaBJLGIECo7+UnRVb7qx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03c2198-d634-4346-e8db-08ddd7dfbbf1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 07:30:08.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg0jbytN6iNa5eK4nzyNHtqx1tz4j/VB2CEt4saa5rAthdTyaiDeMkRo1YXY7ucR2vmOVPnCc9kbvEmM6toVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6576

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
__GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 net/sunrpc/socklib.c           | 2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 4e92e2a50168..d8d8842c7de5 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -86,7 +86,7 @@ xdr_partial_copy_from_skb(struct xdr_buf *xdr, struct xdr_skb_reader *desc)
 		/* ACL likes to be lazy in allocating pages - ACLs
 		 * are small by default but can get huge. */
 		if ((xdr->flags & XDRBUF_SPARSE_PAGES) && *ppage == NULL) {
-			*ppage = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
+			*ppage = alloc_page(GFP_NOWAIT);
 			if (unlikely(*ppage == NULL)) {
 				if (copied == 0)
 					return -ENOMEM;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 1478c41c7e9d..3aac1456e23e 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -190,7 +190,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
 	ppages = buf->pages + (buf->page_base >> PAGE_SHIFT);
 	while (len > 0) {
 		if (!*ppages)
-			*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
+			*ppages = alloc_page(GFP_NOWAIT);
 		if (!*ppages)
 			return -ENOBUFS;
 		ppages++;
-- 
2.34.1


