Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203EC36B801
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhDZRU6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhDZRUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A870C06175F
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:00 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y10so6503321ilv.0
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C48GAA8S+IcSfL9O3pFMYAcocl3KuQHF61IzCT1Om5w=;
        b=GlnPQDvoHP72U0hEXXuxHMMhVpUCM4ksBry0zJSSRDp/1Sj1/V/DXGPG3NZ2dNd9p4
         kzOpLFK5ekNN/cmsGktfBt8mBkuhi+yEad+SMGZKdA8Jb2gB2OzQvs9olm2V3SV6+8F3
         tr8C5lOk57DYUTxXFYKGasZeaOYUTS88cfeVydrTqJ3rionw9X3UoTKCuU8cHjndhbth
         AWuSYXb/mCKGTgUjSOr36KWnRTVLTFzGmDZBPcu9E9sm1OH555xBG1EwF9taTGi+L7gh
         xAuB6XxgzdMxLPQJE86daj3EG2GdaGVJT7eqbzH6TA9ddWLEUyuZu0S0w9M6jwzb4at3
         /IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C48GAA8S+IcSfL9O3pFMYAcocl3KuQHF61IzCT1Om5w=;
        b=PnzdUOpQ9wSr/E/InvNy6s6ZKXx4DfqT8EZJdQANkdcVRS2OQv7dUEPdg0+GVNbdyW
         n6T3NCYfp1dToQqwguvKT8L2rW5B01LhM856sHY/+A55PmaJLMPEkOIKS+3gkzccXYSj
         tERKKyR+M44iGa2ADW+CXclAaoJTjKWQ5AtMaQJgXwZrx7U3fa2rfETXHml9T4+RFYD5
         ZOCCwu1pJrqAaFOub7EodbIb4BfA4leXtekJPvIg8U+jZEzxyKgIRUZEJlVlxVdUxsbs
         p6HDArlEQSv4OmZPa0E15H9IriBDRsE8UtmfsYx3pkieFYV5rgfFBrF86Fd247EoBSR/
         UHdw==
X-Gm-Message-State: AOAM530UsyPVk2MlpufBxtaq5fh5nzdaqmwT0HDN8b43DaQTchAn3T78
        gs458z9adMV5yoa/4+8Rxxo=
X-Google-Smtp-Source: ABdhPJzOvyRfuSt9zl5GP0AFsNRKxwkmmm71WY22Sn/KNRM6r+9ahyi2ibGymUfyGnsrK7/soT/ciw==
X-Received: by 2002:a92:7307:: with SMTP id o7mr14817928ilc.5.1619457600061;
        Mon, 26 Apr 2021 10:20:00 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:59 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory to the xprt_switch
Date:   Mon, 26 Apr 2021 13:19:43 -0400
Message-Id: <20210426171947.99233-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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
index 03ea6d3ace95..871f7c696a93 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -150,14 +150,30 @@ rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
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
 
@@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
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

