Return-Path: <linux-nfs+bounces-20048-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJoBDmXdsWmaGgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20048-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:23:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD626A600
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DD830692E1
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668732D7D9;
	Wed, 11 Mar 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Zh2L8ItV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EA2DF3F2
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264225; cv=fail; b=ZLjMxoLJauVoWUO7jAqdCNgLpl+u1ZqJeHMK+bIFicHtq5V2/3hyBLIqEADNCFVih7d+/dJaF4pb1OkKhhVjRLkn2cQO5hM+ey/g5GG4mEO0LCawG01gr6a1ntvFu2t/PGE46YXbwTLpgcIyNG/TbYTLmrFbiw02EgDggNNMjnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264225; c=relaxed/simple;
	bh=tUcbHs6+h5johiUHRUMGvd5fyoYJ5ZFHSFDm5X3yT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NwPZhaGzV3N42ZnpJNuMxHhgvkXQ/nR5kjYgrwOKmHmZSmKYsS1fC8u5GnD9761aTaLHDkf1EuuP+Y43UiuD41DUeFScmdw1Dt9KMFt7qPSaBHBhUUKWwcNzRkDUZVg1a8JkPT9zoupqxwsgo5nnmGfVhSmhkc2UQRocf9ptsGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Zh2L8ItV; arc=fail smtp.client-ip=52.101.61.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+1RWbAOP6wzrrMWe4ueWrXkGEthqdG4P0B6H3U/rHY323M8s/xNEoW2HoBAW7ia6x8HTvJzG1bprW6z5tG8pD7uGCBzq6FWx/2p1ZtHFyT5zxYGURjWzt3tab5cuFIk9eXcHBYFYmA+TKVMTAEeyeRQm0+iD1AD0W8aaTPAYQbxLPPMZRZ6Nb3CcTcWumSiDPHnx78IzKZT9cc6tbmpX/3mdo9f/DAiFZZiqd2rZ9xtyjr+fsEI5VZfxU9mz+lm9OAsAdqmB/RVrkDACnwPvpHGzUDDucplPQzI9fX1+0o+jcp77G3RMAvwZhN+iZjU2hiZ83BGv5pfeVDLsEqRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9JAf+JsFlVxKhgXqQcb5nKDtdLktxJNXZLR4rnMT2M=;
 b=GvA6ag6oNEQvz8PR0N+pWzntquA47FeL8mq6Se2AqUl8iEvjtKEPm/5/2wu2RTBJktKUx/3SEB6xcrxhRW6bz5BDPrjH08B5z+2/+tyHLRO64Ld4zFoqqqiSD1R5l8L18wApmROXBcgH9smDaHjv4sIhUGVguYypXu/ZqYi2h780yRIEQas6s1AC1/dhpkCY8sOnA+7minI3o0H8gPAVlZfKKkQ0wKaN3BfVQqY9E4sGgLvbA/vljbyu7vHX8S9HqR9R7jd7ymHq0BkGCJ0FuBtebJt3WS+JQEPSZk3fF0eYTBuBHtUgFoI+BiKlYSac64yEF4HjDIS3K/3i3Y3Z9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9JAf+JsFlVxKhgXqQcb5nKDtdLktxJNXZLR4rnMT2M=;
 b=Zh2L8ItVB09SLgqVdspLTeJZISIbEpAhpKtu8w2lcksYvt7kRE4Pg/8V0fRl37QQz+ECsVON0PGc522ulC03Ys0nwSWzaDOg1SsGPgvPnL3jDu8UpygwjUEhwV8e3Mmnlpn4bY+dTKTBEumaxmzSIt25HmSezZ3eqgTMwudQrH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA1PR13MB4781.namprd13.prod.outlook.com (2603:10b6:806:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Wed, 11 Mar
 2026 21:23:40 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 21:23:40 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: bsdhenrymartin@gmail.com,
	Chuck Lever <cel@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH] sunrpc: refactor TLS transport to remove rpc_clnt dependency
Date: Wed, 11 Mar 2026 17:23:37 -0400
Message-ID: <a57879782d2d383e2d1af292fe2b9005a43ea06c.1773263233.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA1PR13MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: c614e334-ad6e-444d-2cc7-08de7fb47724
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|7142099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	OTSt0SL80ElXopk92MllojcHiCQiep0zjVD5I0o4ikLhTE/fy7qEkBds+4jk8M5sLzpzVczO2AjOgERSKU6Mimx7Itcp7istF9QO1wWki0SVyCf4+ZNgoDwuxqv/IsYGlkgwFaWVH65GFQbAiTk0cdpU8PwKrqI4ZwNJJERD0NmJDlrXisx2D9UuTBlkR7V4WJHvy3Sxn0AyxTwc1sGpG/d2ZO974xagcRNmKcIMB0hNPpkgBUAj+CuYDS6CI88st0QDlZZ55R8vsi/OpPrLjJW77OyGqLncOTG2Wy+YW0dF9clCMG+Ab/dyath7bKzL+lrMpXkf/sfXvfu5WFQ5m5ldEXr9wDt6qu1YKDA11fjmm72wJ75b88/pWcCjkRLP8ekENkkmm/QLVItylR90DvAqIN8GylEi10CMQhPSrrsUwS6gMiYcVyTF8mttGmC+/m7Mre+3yz5ySX+SIjzWbqwrBCU3PaxzUMxsrvclbMCVPVwml/XcLsys79k5dP+YY0dDo07lGtQ7uIemohzDFGgVAc2F5PLGorC8ZeEEx8YYWIadBrBUu6vYYwuhozNqe9uP7d8k/x2XLutVD+jN7H2ZAbbeoy5eY2nQNcXr6znuk+Y64Yb8cu/YSQQXbLAvLNbFcLjSHKBeHPz3uwtIUVoukSOTZ5KnqTmzBz4Z2hRAoB1d/B2bkxXYlrBx8sS6eEBHmaoukG10FMMq0W7NUeIXH5B28SSq10b/zBaS5wa8diuTDZEu9ZrFFtrE3Mt+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(7142099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UtCnUxLyKLOwIz3KNpEDrdX5z0U5uB95OwVhztdwmyXTUSXtyA0kIZcuquHK?=
 =?us-ascii?Q?cy6FuZva97RXBICFHUohdcU9PBi6mkj/wLN87B2zorubHkG842Awdb3PcEtf?=
 =?us-ascii?Q?7TH9pX93dpeQ3uVhEluYNwy6g42CiTGnKp/uX2JMnLWCaMB0wyTuto6Z3D6M?=
 =?us-ascii?Q?0+LoXmxJ0uzYNEgdqS+OqWZhYrXOzDNdE/oasQTBseZWaw39+OWmi8M9weZO?=
 =?us-ascii?Q?40HeC3Hxys8mYmtZEc+4rBLzGoWjdC0nc6C78fYX4UCtebP5OK9Gu+IHTEbQ?=
 =?us-ascii?Q?M74Ur7uiOQ2jHSGK6iV4WPGc8SOoH+5a6CuqMq4vnlJHCRZEED7fxmFBEWxw?=
 =?us-ascii?Q?l3JsuBLoR8P21W8BS34ENojaoBPiNnKVnJNYk69ouFGGHQaXojbjNFt+iz2P?=
 =?us-ascii?Q?mnA/65bk540feQIw+t90heU9YIApgblT7ABdfyW4aLz0v5re904FArccQwpL?=
 =?us-ascii?Q?o6y2YifP3odWwY3/3b1Y0m3/KUlSemuIaS8M8zBRWr90IiUvVpGDQuhflqLj?=
 =?us-ascii?Q?4zoBtgLhzGbE/QGdXlCHhKTlnHSXdvS5aWig4nS/an+GQGEZZ9pJIOjJNeLR?=
 =?us-ascii?Q?HHqM0qys23hE403VMxxro7/Amnxk/OdxxT+pUL6Sj+IB7zoXLOF7VTPov7Vs?=
 =?us-ascii?Q?63UxuZmPN8v4GAw6w69I38vF5lz5HaMXKs/JqypNRsaJkJAijD8ycRDD1PIK?=
 =?us-ascii?Q?qK0mCdZlIgmuVn3p94uEU9pXwaylaUS0Im9r7ayv+yqeQU0HyixjhIUTLuzi?=
 =?us-ascii?Q?8SF4vGgTIyN8XarCK0ck44KXXWluDXn/sYtxEkVQfg0GDwSXgQOYSvmv7MsC?=
 =?us-ascii?Q?jfgODbN8s39DHjqApw9Y7z2wBCuEGHtUvh/xEq0QRaBSB5R4k5qap7ywYCts?=
 =?us-ascii?Q?AenMb9nAd3qG3jxltqtvhcU6C2NO3j3AymbUTw2Oz8eeseBdOpwS+bz40Wpv?=
 =?us-ascii?Q?STXTG6Xauv/92teMU05feDJi8r6UsVkVjKexXFvftDpOiF8uOT26Yk3quNZQ?=
 =?us-ascii?Q?zy3rUpP5TMKKLmiWCRynoqPQkWtKrsxEfppHMiWkjDeFUJGbHtsQZ8MbOLPe?=
 =?us-ascii?Q?eldG/ypdDYqC2EiDvhkmSHJbRZY9TbwkpCzN5lzUF7UWxdWtXXmvH7SD4bGh?=
 =?us-ascii?Q?H72GVrZSFVNDwUipgoC0Zh8tS/kAmDFt+hBTyThTemRyYp6h1xiyh5Juj7x1?=
 =?us-ascii?Q?bvuREOBl75izsOvnQxsPy8P27VAa9nRPsrC9ZWWH2jynlJA/DXTubv6CE8WH?=
 =?us-ascii?Q?8lITcp9K66+jcyQa3ZnxD8oNLK4p3Se3zRuWZxur2mnBLGq9+iglins61LxY?=
 =?us-ascii?Q?eHlk+sRH3McQjzc59PKcYLRsgMCCIguEeja4bnwC1Gfw8sRl22P94LYzMDxS?=
 =?us-ascii?Q?AVjUZH93n+UDVbg/TxxK0SsPDaHk+4l0ufaA8s4wr2L5yCHXQBtLWrcLmTgu?=
 =?us-ascii?Q?zjeGlmp6XHmaSKYLOEIbg0Ir+71VUrSBEC3XcpXgrw59uptszA+wMISBOR/T?=
 =?us-ascii?Q?Qllj1Tt44Oc/UpBKN6Ve72CXXT+Rf7UqSJqnAqiLydXnjBz7ILbHSYgBHT/l?=
 =?us-ascii?Q?UfVxYQEW1YtfiDgT/6/m3ARPU9brsQnTIqbG2NotgZ3WEGCORyoGtG1L8I6I?=
 =?us-ascii?Q?+9XfLxAzEMom/GkB9f/ff9mV0j1yPHwkvbhJ0F0GThLEMeMBLOFV5h3Pr/tZ?=
 =?us-ascii?Q?rqtq2WeK/wmzvNFzDNKsCb46V94q8cqbgr+LZYDFQsybife02IzZctoL5oLM?=
 =?us-ascii?Q?fNKjUXItRBNIJKzBeIojCSmeKtz4i9w=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c614e334-ad6e-444d-2cc7-08de7fb47724
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 21:23:40.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7WT/p2Q5bPgbmi7n6PTM7PSL+F83eBbBaE+dTdI4uCQBlbhT1ZK/Tpv/SNtsrdb9Io4cCwGHBubdz9/KKfYReolPDMtJSaeYZFAShTWfYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4781
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20048-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid]
X-Rspamd-Queue-Id: 10BD626A600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TLS connection worker (xs_tcp_tls_setup_socket) currently
requires a reference to the upper-layer rpc_clnt to populate arguments
for rpc_create() when setting up the lower-layer transport for the
RPC_AUTH_TLS probe. This dependency led to lifetime issues and a
use-after-free (UAF) of the client's credentials if the task finished
before the worker ran addressed previously in linux-nfs upstream posting:
https://lore.kernel.org/linux-nfs/20260309112041.1336519-1-bsdhenrymartin@gmail.com/

However, it is architecturally cleaner to decouple the transport
connection logic from the RPC client entirely. The TLS probe requires
the upper-layer's RPC program and version to facilitate the probe.

Refactor the TLS transport setup to:
- Remove the clnt member from struct sock_xprt.
- Save the RPC program number and version from the task
  during xs_connect() into the sock_xprt structure.
- Update xs_tcp_tls_setup_socket to use these saved parameters for
  lower-layer client creation in dummy program definitiions.
- Update TLS-related tracepoints to remove the rpc_clnt dependency.
- Remove the rpc_clnt refcounting and assignment in xs_connect.

This simplifies state management and eliminates the risk of UAF without
requiring the transport to pin the upper-layer client.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---

I'm not sure I like what came out here.  It adds a lot of boilerplate, and
it reduces the tracepoint data (pretty necessary due to the race, however).

Most of the fix is from just not setting cl_cred - it stays NULL.  Probably
the other values we get from the upper rpc_clnt are still hanging around.

We could reduce the dummy definition boilerplate by passing the rpc_program
pointer, but then there's a potential null-dref if the calling module gets
unloaded.

Can RCU the upper rpc_clnt?  Any other ideas?

This is lightly tested by hand..

Ben

---

 include/linux/sunrpc/xprtsock.h |  3 +-
 include/trace/events/sunrpc.h   | 16 +++------
 net/sunrpc/xprtsock.c           | 59 +++++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 700a1e6c047c..7cafc3057bfa 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -61,7 +61,8 @@ struct sock_xprt {
 	struct sockaddr_storage	srcaddr;
 	unsigned short		srcport;
 	int			xprt_err;
-	struct rpc_clnt		*clnt;
+	u32			connect_prog;
+	u32			connect_vers;
 
 	/*
 	 * UDP socket buffer size parameters
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 750ecce56930..8088a8ad83d4 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1528,28 +1528,23 @@ TRACE_EVENT(rpcb_unregister,
 
 DECLARE_EVENT_CLASS(rpc_tls_class,
 	TP_PROTO(
-		const struct rpc_clnt *clnt,
 		const struct rpc_xprt *xprt
 	),
 
-	TP_ARGS(clnt, xprt),
+	TP_ARGS(xprt),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, requested_policy)
-		__field(u32, version)
 		__string(servername, xprt->servername)
-		__string(progname, clnt->cl_program->name)
 	),
 
 	TP_fast_assign(
-		__entry->requested_policy = clnt->cl_xprtsec.policy;
-		__entry->version = clnt->cl_vers;
+		__entry->requested_policy = xprt->xprtsec.policy;
 		__assign_str(servername);
-		__assign_str(progname);
 	),
 
-	TP_printk("server=%s %sv%u requested_policy=%s",
-		__get_str(servername), __get_str(progname), __entry->version,
+	TP_printk("server=%s requested_policy=%s",
+		__get_str(servername),
 		rpc_show_xprtsec_policy(__entry->requested_policy)
 	)
 );
@@ -1557,10 +1552,9 @@ DECLARE_EVENT_CLASS(rpc_tls_class,
 #define DEFINE_RPC_TLS_EVENT(name) \
 	DEFINE_EVENT(rpc_tls_class, rpc_tls_##name, \
 			TP_PROTO( \
-				const struct rpc_clnt *clnt, \
 				const struct rpc_xprt *xprt \
 			), \
-			TP_ARGS(clnt, xprt))
+			TP_ARGS(xprt))
 
 DEFINE_RPC_TLS_EVENT(unavailable);
 DEFINE_RPC_TLS_EVENT(not_started);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..5f3103e9a8f2 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -61,6 +61,45 @@
 #include "socklib.h"
 #include "sunrpc.h"
 
+/* Helper macro to define repetitive rpc_version structures */
+#define RPC_VERSION_DEFINE(prog, v_num)                 \
+static const struct rpc_version rpc_##prog##_version##v_num = { \
+    .number     = v_num,                                \
+    .nrprocs    = ARRAY_SIZE(rpc_##prog##_procs),       \
+    .procs      = rpc_##prog##_procs,                   \
+    .counts     = rpc_##prog##_counts,                  \
+}
+
+static struct rpc_stat rpc_tls_dummy_stats;
+
+static const struct rpc_procinfo rpc_tls_dummy_procs[] = {
+    [0] = {
+        .p_encode   = NULL,
+        .p_decode   = NULL,
+    },
+};
+
+static unsigned int rpc_tls_dummy_counts[ARRAY_SIZE(rpc_tls_dummy_procs)];
+
+/* Generate the structures for versions 2, 3, and 4 */
+RPC_VERSION_DEFINE(tls_dummy, 2);
+RPC_VERSION_DEFINE(tls_dummy, 3);
+RPC_VERSION_DEFINE(tls_dummy, 4);
+
+static const struct rpc_version *rpc_tls_dummy_versions[5] = {
+    [2] = &rpc_tls_dummy_version2,
+    [3] = &rpc_tls_dummy_version3,
+    [4] = &rpc_tls_dummy_version4,
+};
+
+static const struct rpc_program rpc_tls_dummy_program = {
+    .name       = "tls_probe",
+    .number     = 0,
+    .nrvers     = ARRAY_SIZE(rpc_tls_dummy_versions),
+    .version    = rpc_tls_dummy_versions,
+    .stats      = &rpc_tls_dummy_stats,
+};
+
 static void xs_close(struct rpc_xprt *xprt);
 static void xs_reset_srcport(struct sock_xprt *transport);
 static void xs_set_srcport(struct sock_xprt *transport, struct socket *sock);
@@ -2687,24 +2726,21 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 {
 	struct sock_xprt *upper_transport =
 		container_of(work, struct sock_xprt, connect_worker.work);
-	struct rpc_clnt *upper_clnt = upper_transport->clnt;
 	struct rpc_xprt *upper_xprt = &upper_transport->xprt;
 	struct rpc_create_args args = {
 		.net		= upper_xprt->xprt_net,
 		.protocol	= upper_xprt->prot,
 		.address	= (struct sockaddr *)&upper_xprt->addr,
 		.addrsize	= upper_xprt->addrlen,
-		.timeout	= upper_clnt->cl_timeout,
+		.timeout	= upper_xprt->timeout,
 		.servername	= upper_xprt->servername,
-		.program	= upper_clnt->cl_program,
-		.prognumber	= upper_clnt->cl_prog,
-		.version	= upper_clnt->cl_vers,
+		.prognumber = upper_transport->connect_prog,
+		.version	= upper_transport->connect_vers,
+		.program	= &rpc_tls_dummy_program,
 		.authflavor	= RPC_AUTH_TLS,
-		.cred		= upper_clnt->cl_cred,
 		.xprtsec	= {
 			.policy		= RPC_XPRTSEC_NONE,
 		},
-		.stats		= upper_clnt->cl_stats,
 	};
 	unsigned int pflags = current->flags;
 	struct rpc_clnt *lower_clnt;
@@ -2719,7 +2755,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	/* This implicitly sends an RPC_AUTH_TLS probe */
 	lower_clnt = rpc_create(&args);
 	if (IS_ERR(lower_clnt)) {
-		trace_rpc_tls_unavailable(upper_clnt, upper_xprt);
+		trace_rpc_tls_unavailable(upper_xprt);
 		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
 		xprt_clear_connecting(upper_xprt);
 		xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
@@ -2739,7 +2775,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 
 	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
 	if (status) {
-		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
+		trace_rpc_tls_not_started(upper_xprt);
 		goto out_close;
 	}
 
@@ -2757,7 +2793,6 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 
 out_unlock:
 	current_restore_flags(pflags, PF_MEMALLOC);
-	upper_transport->clnt = NULL;
 	xprt_unlock_connect(upper_xprt, upper_transport);
 	return;
 
@@ -2805,7 +2840,9 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
-	transport->clnt = task->tk_client;
+	transport->connect_prog = task->tk_client->cl_prog;
+	transport->connect_vers = task->tk_client->cl_vers;
+
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);
-- 
2.53.0


