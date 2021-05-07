Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D983768AD
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhEGQ0n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhEGQ0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64984C061761
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l21so8469948iob.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/K6BjIw2y1W0AbLQSD0bBfb29FdYAs/XqpwUc9kuvk=;
        b=nyyl5bZlfFlxQ8dZi1Ij3Eurgz2nAfREE7UmBylsfSa9aJ8YoxbthJL4FH5Xa1zuQS
         bxVXZiEPq8fApq0qPkw6/1EbZg8UrfGSw4RvfHzv34Lflaf9yoDqq510peEpkJpqqwcB
         kRHyVD4nxtIfvRKC0lmxCueX6q8JCnwLXCrD+lNEdI97YhORoHmDWCGslXkSs7A5fffp
         icQA7+Kne9M8Eon2cXa8dyFjNLnA0aGHs3oev5HYe2J1TEJq/r6BudytnFP/PRVlI2a9
         yGnJ/E06Pv3Bj2EU7pLghNfTnKPL7oJ82U8kHYFEWMbNfQy+/DL2JRLV8qBwFjqRB3Uu
         JLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/K6BjIw2y1W0AbLQSD0bBfb29FdYAs/XqpwUc9kuvk=;
        b=KGCaFDu1PkOaPX9UNbJ0Tg18prnpS2SBIBBXCI4GBwU5vNF+Pki4fxR7N/ww2e+FUf
         hYwor5Cj0VMnHym1wYCmeD5Xh91NdNXookW40/zX8UCmo6L2rrVQ5Xe/SU785r8V5q7L
         ci0BQKp9NlBJXKSA6ltY/K3QBkCaFeucxYcUknFv+b43+Nvbf9JaakMycXyce5EuSWwt
         3OF/V3iegej1A4wCK6Mho2YFK2AGH7QL3mBm7nHBnPRAU5k47wOgugfQaMAuh4irgJsJ
         MGpHYfL/xn3M6YuasV8bc91mrZLJ0kJKohT62247EmeYj22Kk7qfEH0VXeIHM1+ALDmV
         JV/Q==
X-Gm-Message-State: AOAM531V+sbz98mqqxMfLBbsskTwxJqdFUHLcbzIipxQIp1mU016+69V
        c0v4DiwwFNzezdNuPr+KiU7posu6ApVX4A==
X-Google-Smtp-Source: ABdhPJxEUJ4NkniqqCax4qHPgBTRw5u+srRhOtxhPS7l++WTpovt2c/iILEsa/0s6U0+wYdV6fGQAw==
X-Received: by 2002:a6b:7f4a:: with SMTP id m10mr8338613ioq.70.1620404728864;
        Fri, 07 May 2021 09:25:28 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 08/12] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Fri,  7 May 2021 12:25:14 -0400
Message-Id: <20210507162518.51520-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

An rpc client uses a transport switch and one ore more transports
associated with that switch. Since transports are shared among
rpc clients, create a symlink into the xprt_switch directory
instead of duplicating entries under each rpc client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c  |  2 +-
 net/sunrpc/sysfs.c | 25 +++++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index dab1abfef5cd..2e195623c10d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -301,7 +301,6 @@ static int rpc_client_register(struct rpc_clnt *clnt,
 	int err;
 
 	rpc_clnt_debugfs_register(clnt);
-	rpc_sysfs_client_setup(clnt, net);
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
@@ -426,6 +425,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	/* save the nodename */
 	rpc_clnt_set_nodename(clnt, nodename);
 
+	rpc_sysfs_client_setup(clnt, xps, rpc_net_ns(clnt));
 	err = rpc_client_register(clnt, args->authflavor, args->client_name);
 	if (err)
 		goto out_no_path;
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index ed9f7131543f..98d27273d988 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -151,14 +151,30 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
 	return NULL;
 }
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net)
 {
 	struct rpc_sysfs_client *rpc_client;
 
-	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj, net, clnt->cl_clid);
+	rpc_client = rpc_sysfs_client_alloc(rpc_sunrpc_client_kobj,
+					    net, clnt->cl_clid);
 	if (rpc_client) {
+		char name[23];
+		struct rpc_sysfs_xprt_switch *xswitch =
+			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+		int ret;
+
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
+		rpc_client->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+		snprintf(name, sizeof(name), "switch-%d", xprt_switch->xps_id);
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					       &xswitch->kobject, name);
+		if (ret)
+			pr_warn("can't create link to %s in sysfs (%d)\n",
+				name, ret);
 	}
 }
 
@@ -189,6 +205,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		char name[23];
+
+		snprintf(name, sizeof(name), "switch-%d",
+			 rpc_client->xprt_switch->xps_id);
+		sysfs_remove_link(&rpc_client->kobject, name);
 		kobject_uevent(&rpc_client->kobject, KOBJ_REMOVE);
 		kobject_del(&rpc_client->kobject);
 		kobject_put(&rpc_client->kobject);
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index 52ec472bd4a9..760f0582aee5 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -8,6 +8,8 @@
 struct rpc_sysfs_client {
 	struct kobject kobject;
 	struct net *net;
+	struct rpc_clnt *clnt;
+	struct rpc_xprt_switch *xprt_switch;
 };
 
 struct rpc_sysfs_xprt_switch {
@@ -20,7 +22,9 @@ struct rpc_sysfs_xprt_switch {
 int rpc_sysfs_init(void);
 void rpc_sysfs_exit(void);
 
-void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
+void rpc_sysfs_client_setup(struct rpc_clnt *clnt,
+			    struct rpc_xprt_switch *xprt_switch,
+			    struct net *net);
 void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
 void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch *xprt_switch,
 				 struct rpc_xprt *xprt, gfp_t gfp_flags);
-- 
2.27.0

