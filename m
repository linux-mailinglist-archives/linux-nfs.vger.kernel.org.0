Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAD3A04DD
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhFHUCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:02:31 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33695 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhFHUCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:02:30 -0400
Received: by mail-qk1-f181.google.com with SMTP id k4so21530613qkd.0
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=i62AFISOAOTzU2tXaztfcfkxRKVl+nq3jH8+pF4iXYqIq3kGYvQfXIt1YxzwUrHR50
         dPdYp9urqkJapYVChJ6VlGUvtPciCRx9C9a5ZtQd+K0pqaymt7+u6ULgNbFMIGOHMJpO
         PXIczCLn/mU1cELdlAD7EWd5eN4eoeIhPwrq34vufiiNG7CYD9+UOT4KWpvRQ+YIxSoo
         ZG852jnesKG0ruB0xrWbB51ol47ZwHFKtfspAIRgQUAVfLFP/oB7IFQjhuv1evi1P5Cf
         N2hY1E7uw6YdCcxFqFFAElQJ9C96w4FXgTRq2+H8gmGG6LljmFwzPzVXEW+Y3bg5NuPN
         xLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94soqXL6YeuBIGDbnyeIBNAXPOYxIGr0JRdKAVfQ/L8=;
        b=dtBk1hwNNwxxhS2AhP+ocMAx80JSxuVpXzO15zvEZypjvzdl6HHm3EUnZXf07rkCbO
         yVVgFC+INfqc25izOt7wmxJRhM7SLZZ4c4pKfNUtP032xrWLauOqg7O0XA111Z4V4DBz
         lEVYAYo+h8R4EZMlb/uSbOe94UqN++6CC+I2q7ly877eSOA0GAll+FAc1PKeh7C46nOV
         3BMSpNyycDP/c0nDvY0yQybLhRgzkqGhhaRXFbusD8BbBbKnzXagZ8sub9GhBlKJCDV2
         pC0T7S1deRTrOVflb8R/LnQUraCoXVL4N8davrNj6ibBgEFY9Bf04TRcO+jQ6oSisxMl
         +YNQ==
X-Gm-Message-State: AOAM5317XqibkGiryeHYSmHcdXILhVwXJVDAzSKypDU/rogwSpBsRzoH
        qdP9k72ky6HbzkIM/4e5z38Dm5qERow=
X-Google-Smtp-Source: ABdhPJxC+HYA2RfP+twxn5AXPzJTtq5copJJkIB4CreAnAjAvKvGtK68tXEzgVjbdrZ15CX3AcSPhg==
X-Received: by 2002:a37:a548:: with SMTP id o69mr17517430qke.376.1623182376345;
        Tue, 08 Jun 2021 12:59:36 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 08/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Tue,  8 Jun 2021 15:59:17 -0400
Message-Id: <20210608195922.88655-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 22 ++++++++++++++++++++--
 net/sunrpc/sysfs.h |  6 +++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6f3f840a2ea3..9bf820bad84c 100644
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
index ed9f7131543f..0aa63747f496 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -151,14 +151,29 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
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
+		char name[] = "switch";
+		struct rpc_sysfs_xprt_switch *xswitch =
+			(struct rpc_sysfs_xprt_switch *)xprt_switch->xps_sysfs;
+		int ret;
+
 		clnt->cl_sysfs = rpc_client;
+		rpc_client->clnt = clnt;
+		rpc_client->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_client->kobject, KOBJ_ADD);
+		ret = sysfs_create_link_nowarn(&rpc_client->kobject,
+					       &xswitch->kobject, name);
+		if (ret)
+			pr_warn("can't create link to %s in sysfs (%d)\n",
+				name, ret);
 	}
 }
 
@@ -189,6 +204,9 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
 	struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
 
 	if (rpc_client) {
+		char name[] = "switch";
+
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

