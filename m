Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307C6B7BDA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCMPXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCMPXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 11:23:50 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2093.outbound.protection.outlook.com [40.107.115.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585251C98
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 08:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLalHjIa56qWQ0m+TijJTyRTEeBSBaVT0h5lO6mZWWNMxd2NRZrxOExugTos0WobPnHky8tGtXwLHQkdJh91lZk5+VOBndTS6YVqr8IkSOBGtr1TNKnWAzYuVvb0vCgtqggB5aquhmURZCWBqyySjvdAL1uiD7Pph/BcUME6S8++nECIJXdsto5J/ADDHtGNB44WzTPIYgJFWxF+H0bhiFj0KQOQ97OfZ2AhTEKUZ1VaaHfkszlp7frpiRg51Ao04elyTaXv1czExrRSb8SjNeIgziGulYxlo5GnE3af3iXTjdcEWhIRxzSsiA28b9QQcbsaFwatgrFMALLKlKNArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2+AgpwU0ZpT4DYMrSzH90ktHLgETkvnwvRrFceOB+c=;
 b=atGyRJLJUfQCpiuA5wTUfo1D7tlJ4xQLmDianeRSGQMaFu3YU0tOl4V9V1GkLqoSMh3vEG/jYpaNw7RItDS1WYeFx0WkLD+jd14785Aa2vB5/fupDfsjPBDbXQYhvbC0aGEpPrbQdeOM1j0DsX7KppTbKUCnYwMhmO92ev2Jjqy9jn+LlWlhO9/ONiW/9PvcRhdAUIvyySqqi1l5CC36tFGor3lhO6cyhARb9YEy6/QFqcFljA3xECNWfiEKN7h9uhjo+UYNqLs5C59inah0iqJKBadq528sFWs5KoMYkfOoaXcUWLjURPvOAKu4y2B4TcT9637PeA+Rg8NWg0axvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 76.9.214.104) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=ak-test-nfs-01.jamfilled.com; dmarc=none action=none
 header.from=boatrocker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2+AgpwU0ZpT4DYMrSzH90ktHLgETkvnwvRrFceOB+c=;
 b=fvsvmzojhvg4U8exLghetUtnHQx/zkL5E25gtkHqfyzzegzJ3nFaog63lxqq+ViDOwkpyhnRppRpQ/iTfjRLIs6Jv3cRXODxjpNGTwdEW7CuN76Mjc7UipE9yKG9EJObqJ37An8fMd8p9wrEv/IxmMM2ZkBVHooUzcJMaML0Iko=
Received: from BL0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:2d::19)
 by YT3PR01MB5809.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:23:43 +0000
Received: from YT3CAN01FT019.eop-CAN01.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::5d) by BL0PR03CA0006.outlook.office365.com
 (2603:10b6:208:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 15:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 76.9.214.104)
 smtp.mailfrom=ak-test-nfs-01.jamfilled.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
Received-SPF: None (protection.outlook.com: ak-test-nfs-01.jamfilled.com does
 not designate permitted sender hosts)
Received: from webclient02.jamfilled.com (76.9.214.104) by
 YT3CAN01FT019.mail.protection.outlook.com (10.118.140.71) with Microsoft SMTP
 Server id 15.20.6199.11 via Frontend Transport; Mon, 13 Mar 2023 15:23:43
 +0000
Received: from ak-test-nfs-01.jamfilled.com (ak-test-nfs-01.jamfilled.com [10.30.13.2])
        by webclient02.jamfilled.com (Postfix) with ESMTP id 7A7ED1E02AB;
        Mon, 13 Mar 2023 11:17:47 -0400 (EDT)
Received: by ak-test-nfs-01.jamfilled.com (Postfix, from userid 1000)
        id 5C532FE7A3; Mon, 13 Mar 2023 11:17:47 -0400 (EDT)
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org,
        Andrew Klaassen <andrew.klaassen@boatrocker.com>
Subject: [PATCH 1/1] SUNRPC: Use rpc_create_args->timeout to initialize rpc_xprt->timeout
Date:   Mon, 13 Mar 2023 11:17:16 -0400
Message-Id: <20230313151716.34280-1-andrew.klaassen@boatrocker.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3CAN01FT019:EE_|YT3PR01MB5809:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b263c5e-31dc-44b6-7e72-08db23d6ee5f
X-Forefront-Antispam-Report: CIP:76.9.214.104;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:webclient02.jamfilled.com;PTR:76-9-214-104.beanfield.net;CAT:NONE;SFS:(13230025)(136003)(396003)(39850400004)(346002)(376002)(451199018)(46966006)(356005)(82310400005)(83170400001)(36756003)(81166007)(40480700001)(70586007)(82740400003)(8676002)(70206006)(4326008)(41300700001)(42186006)(8936002)(498600001)(316002)(5660300002)(44832011)(2906002)(47076005)(42882007)(2616005)(336012)(35950700001)(83380400001)(966005)(26005)(6666004)(6266002)(107886003)(1076003)(66899018);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFmnJ9R9DTSjgG190En+L8IALBOifXKXIm+J8nNj1RA51XOrYz3Dtk5R3hczeLTczcfOn52g21v797Elzw11vHw3ue4DR991zJF/wRcDnNjozrDynC00Bs/snU9g8DSm7ZvAxO0R81YKbozrZBxjMVgzxXEYX5pK3G3BO5L6uEGgzGBIJJxIA8sqY5uHVIK74/Z3jb8QZY/p1gEJCZv55yX3xPn6lXfI1ua5jYag2A94ZvugCz8C9zDzYjF4QEkpON92gin+MlRkzVRmTrHKjZ8Vwpn7c6H/Nub5YhIeS81LzhNuR5Mgxek4Xs4nmXpCzCtGPTpvqsB/k8wQIyGHMp3VCiy6f/ambSNp/b2v+IFXiRwVsbsVh3haprUZW4WqSZ4utVWPZ0TDuE3EXAE5yElEs5SNL1rqKNgD7JFUEP68E76RnIC/A8GVIdtMVuzFFhdGNCHMp2GqCSqqVvZ7OWZfcH0pBVwVkn1Q35M6W71VKmjmqHnbK+TYiOZfBU+/CiwIixulWZQ/N3g+fKCnCZBUS8G7qkeqVfsTpoiP5KxPrcU0lRzaXkuoba7xlXhgtIoURYl57ppCmKF9MMHy9zXv6D5yvv1JFALqA5+Gr+G+jinAs1gu7+d+ZHfT5r0EcP09tWql8WUmTNIdgsHEkF31UqcA/pK3RWYaSu2+df0=
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 15:23:43.1953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b263c5e-31dc-44b6-7e72-08db23d6ee5f
X-MS-Exchange-CrossTenant-Id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=fd92a966-cd05-4664-965e-b69e7529781a;Ip=[76.9.214.104];Helo=[webclient02.jamfilled.com]
X-MS-Exchange-CrossTenant-AuthSource: YT3CAN01FT019.eop-CAN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5809
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We are using applications which hang if any NFS servers fail to
respond.  We would like to be able to control NFS timeouts so that we
can control the maximum time that the applications hang.  We currently
can't do that with TCP NFS mounts, since RPC calls made to an existing
NFS mount are first subject to the default untuneable Sun RPC timeout
of 2 minutes.

(I'll note that the existing NFS manpage seems to not describe current
behaviour correctly, since it says that this two-minute timeout applies
to initial mount operations (which it does not), and does not say that
the two-minute timeout applies to operations on existing mounts (which
it does).)

An existing thread discussing this patch can be found here:

Link: https://lore.kernel.org/linux-nfs/45e2e7f05a13abab777b3b0868744cdbfc623f2d.camel@kernel.org/T/

This patch uses the RPC call timeout to set the xprt timeout.  In that
discussion thread, Jeff Layton has pointed out that this may or may not
be the ideal approach.  I have suggested these alternatives, and would
be happy to get feedback:

 - Create system-wide tuneables for xs_[local|udp|tcp]_default_timeout.
In our case that's less-than-ideal, since we want to change the total
timeout for an NFS mount on a per-server or per-mount basis rather than
a system-wide basis, but it would do in a pinch.

 - Add a second set of timeout options to NFS so that RPC call and xprt
timeouts can be specified separately.  I'm guessing no-one is
enthusiastic about option bloat, even if this would be the theoretically
cleanest option.  I'm guessing this would also involve changing the
Sun RPC API and everything that calls it in order for it to accept the
second set of timeout options.

 - Use timeo and retrans for the RPC call timeout, and retry for the
xprt timeout.  Or do the opposite.  The NFS manpage describes the current
behaviour incorrectly, so this at least wouldn't make the documentation
any worse.  I assume this would also involve changing the Sun RPC API.

Use rpc_create_args->timeout to initialize rpc_xprt->timeout

Signed-off-by: Andrew Klaassen <andrew.klaassen@boatrocker.com>
---
 include/linux/sunrpc/xprt.h |  3 +++
 net/sunrpc/clnt.c           |  1 +
 net/sunrpc/xprt.c           | 21 +++++++++++++++++++++
 net/sunrpc/xprtsock.c       | 19 ++++++++++++++++---
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b9f59aabee53..ca7be090cf83 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -333,6 +333,7 @@ struct xprt_create {
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	struct rpc_xprt_switch	*bc_xps;
 	unsigned int		flags;
+	const struct rpc_timeout *timeout;	/* timeout parms */
 };
 
 struct xprt_class {
@@ -373,6 +374,8 @@ void			xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task);
 void			xprt_release(struct rpc_task *task);
 struct rpc_xprt *	xprt_get(struct rpc_xprt *xprt);
 void			xprt_put(struct rpc_xprt *xprt);
+struct rpc_timeout	*xprt_alloc_timeout(const struct rpc_timeout *timeo,
+				const struct rpc_timeout *default_timeo);
 struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
 				unsigned int num_prealloc,
 				unsigned int max_req);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0b0b9f1eed46..1350c1f489f7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.addrlen = args->addrsize,
 		.servername = args->servername,
 		.bc_xprt = args->bc_xprt,
+		.timeout = args->timeout,
 	};
 	char servername[48];
 	struct rpc_clnt *clnt;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index ab453ede54f0..0bb800c90976 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1801,6 +1801,26 @@ static void xprt_free_id(struct rpc_xprt *xprt)
 	ida_free(&rpc_xprt_ids, xprt->id);
 }
 
+struct rpc_timeout *xprt_alloc_timeout(const struct rpc_timeout *timeo,
+				       const struct rpc_timeout *default_timeo)
+{
+	struct rpc_timeout *timeout;
+
+	timeout = kzalloc(sizeof(*timeout), GFP_KERNEL);
+	if (!timeout)
+		return ERR_PTR(-ENOMEM);
+	if (timeo)
+		memcpy(timeout, timeo, sizeof(struct rpc_timeout));
+	else
+		memcpy(timeout, default_timeo, sizeof(struct rpc_timeout));
+	return timeout;
+}
+
+static void xprt_free_timeout(struct rpc_xprt *xprt)
+{
+	kfree(xprt->timeout);
+}
+
 struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
 		unsigned int num_prealloc,
 		unsigned int max_alloc)
@@ -1837,6 +1857,7 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
 
 void xprt_free(struct rpc_xprt *xprt)
 {
+	xprt_free_timeout(xprt);
 	put_net_track(xprt->xprt_net, &xprt->ns_tracker);
 	xprt_free_all_slots(xprt);
 	xprt_free_id(xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index aaa5b2741b79..687e06226433 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2924,7 +2924,11 @@ static struct rpc_xprt *xs_setup_udp(struct xprt_create *args)
 
 	xprt->ops = &xs_udp_ops;
 
-	xprt->timeout = &xs_udp_default_timeout;
+	xprt->timeout = xprt_alloc_timeout(args->timeout, &xs_udp_default_timeout);
+	if (IS_ERR(xprt->timeout)) {
+		ret = ERR_CAST(xprt->timeout);
+		goto out_err;
+	}
 
 	INIT_WORK(&transport->recv_worker, xs_udp_data_receive_workfn);
 	INIT_WORK(&transport->error_worker, xs_error_handle);
@@ -3003,7 +3007,12 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 	xprt->idle_timeout = XS_IDLE_DISC_TO;
 
 	xprt->ops = &xs_tcp_ops;
-	xprt->timeout = &xs_tcp_default_timeout;
+
+	xprt->timeout = xprt_alloc_timeout(args->timeout, &xs_tcp_default_timeout);
+	if (IS_ERR(xprt->timeout)) {
+		ret = ERR_CAST(xprt->timeout);
+		goto out_err;
+	}
 
 	xprt->max_reconnect_timeout = xprt->timeout->to_maxval;
 	xprt->connect_timeout = xprt->timeout->to_initval *
@@ -3071,7 +3080,11 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct xprt_create *args)
 	xprt->prot = IPPROTO_TCP;
 	xprt->xprt_class = &xs_bc_tcp_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
-	xprt->timeout = &xs_tcp_default_timeout;
+	xprt->timeout = xprt_alloc_timeout(args->timeout, &xs_tcp_default_timeout);
+	if (IS_ERR(xprt->timeout)) {
+		ret = ERR_CAST(xprt->timeout);
+		goto out_err;
+	}
 
 	/* backchannel */
 	xprt_set_bound(xprt);
-- 
2.39.2

