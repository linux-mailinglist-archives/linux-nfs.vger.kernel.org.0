Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C039AE76
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCXA6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 19:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCXA6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 19:00:58 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21130C06174A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:59:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m6so4089048qvg.1
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UlQsP7v7vMM8cBzMOBEgavYrD1ix6NnsgDsDx9brgZ0=;
        b=KDmjBNE/tjG1d7egD0GKdOAlvqxfmV4y5qmwAeLUeKNy32rhfPfXykYM8zyScd9RyI
         gsIln/0ZgPjOYG45Kw8KXvHZ9CZJct+TGXSa17K71y9/y3/9qeKadCnmT1GoT2YoLQCS
         Heo/odmb9h3qXi5lzW8jKm6O4AdnzDLLXkEQE6onjYCZKXPfNbUVhqEnHLVDZAbZigiQ
         QzHcuh8rHAVJsMx2kHQ/YFt62nVcBrdAWQDhoxE6/V28cqXNcjFLOLtEkqHNraCzlvt9
         EvUoKw0Zd9mfdLety4IZNRJA7/Rk47xCv8NmVnkh6UZ5pekH1YX1ip+YNmHF8tokZ/iL
         oiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlQsP7v7vMM8cBzMOBEgavYrD1ix6NnsgDsDx9brgZ0=;
        b=QNGa0KOLD1rjGY7lvboglnTLV2BspgpS7Vk2QD1y+JNbpIGNmq6bcThglTIY6nt/TX
         Tjrq6u6cqOTQVyIOVqLJpKdOjrveBB7Zh12jfviXpGyVGfczd7tTYfp9vW046HeHDluZ
         3Ep5KiVOvpCM2v73YRZghZAv1FeJbwp6qUs7oUIP5wU9YVamd1G87TA3TBUBwuN9b80D
         cFFaTRBjjO7Gq+Vp/kJZhjC4artWTDl45wS45XWqrjY9uQw1oAk2GWLUPgsNL1J4Xfau
         Cgc/4R0qTCFJwlGFQHRe1N6VGwWeeybplDP6b6TiOIO3tlIoP52cjQR2sHxMfC9lZ79u
         ChqQ==
X-Gm-Message-State: AOAM533Y6MuQRm5tytILfTqbzUAYnqndtbWQL1ezJ9ghU7XPQBOT5aYx
        VQEZL+eXCWmm+EL6rTDbQsQgz6rrAF0=
X-Google-Smtp-Source: ABdhPJwfBngg2oVDG4OdjS+Sa8NffJhgAdQ+fbbUB3x8zauv2gkNUSOIUXDeCVpBmuoLyjUc6VGR6w==
X-Received: by 2002:a05:6214:c2d:: with SMTP id a13mr1970952qvd.37.1622761151260;
        Thu, 03 Jun 2021 15:59:11 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id h19sm1479497qtq.5.2021.06.03.15.59.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:59:10 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 1/3] sunrpc: take a xprt offline using sysfs
Date:   Thu,  3 Jun 2021 18:59:05 -0400
Message-Id: <20210603225907.19981-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Using sysfs's xprt_state attribute, mark a particular transport offline.
It will not be picked during the round-robin selection. It's not allowed
to take the main (1st created transport associated with the rpc_client)
offline.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/clnt.c           |  1 +
 net/sunrpc/sysfs.c          | 42 +++++++++++++++++++++++++++++++++----
 net/sunrpc/xprtmultipath.c  |  3 ++-
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 13a4eaf385cf..72a858f032c7 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -293,6 +293,7 @@ struct rpc_xprt {
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
 	struct rpc_sysfs_xprt	*xprt_sysfs;
+	bool			main; /* marked if it's the 1st transport */
 };
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
@@ -426,6 +427,7 @@ void			xprt_release_write(struct rpc_xprt *, struct rpc_task *);
 #define XPRT_BOUND		(4)
 #define XPRT_BINDING		(5)
 #define XPRT_CLOSING		(6)
+#define XPRT_OFFLINE		(7)
 #define XPRT_CONGESTED		(9)
 #define XPRT_CWND_WAIT		(10)
 #define XPRT_WRITE_SPACE	(11)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9bf820bad84c..408618765aa5 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -412,6 +412,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	}
 
 	rpc_clnt_set_transport(clnt, xprt, timeout);
+	xprt->main = true;
 	xprt_iter_init(&clnt->cl_xpi, xps);
 	xprt_switch_put(xps);
 
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index ec06c9257c07..02c918c5061b 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -118,7 +118,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 	int locked, connected, connecting, close_wait, bound, binding,
-	    closing, congested, cwnd_wait, write_space;
+	    closing, congested, cwnd_wait, write_space, offline;
 
 	if (!xprt)
 		return 0;
@@ -136,8 +136,9 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 		congested = test_bit(XPRT_CONGESTED, &xprt->state);
 		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
+		offline = test_bit(XPRT_OFFLINE, &xprt->state);
 
-		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s\n",
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s\n",
 			      locked ? "LOCKED" : "",
 			      connected ? "CONNECTED" : "",
 			      connecting ? "CONNECTING" : "",
@@ -147,7 +148,8 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 			      closing ? "CLOSING" : "",
 			      congested ? "CONGESTED" : "",
 			      cwnd_wait ? "CWND_WAIT" : "",
-			      write_space ? "WRITE_SPACE" : "");
+			      write_space ? "WRITE_SPACE" : "",
+			      offline ? "OFFLINE" : "");
 	}
 
 	xprt_put(xprt);
@@ -223,6 +225,38 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 	goto out;
 }
 
+static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	int offline = 0;
+
+	if (!xprt)
+		return 0;
+
+	if (!strncmp(buf, "offline", 7))
+		offline = 1;
+	else
+		return -EINVAL;
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		count = -EINTR;
+		goto out_put;
+	}
+	if (offline) {
+		if (xprt->main)
+			count = -EINVAL;
+		else
+			set_bit(XPRT_OFFLINE, &xprt->state);
+	}
+
+	xprt_release_write(xprt, NULL);
+out_put:
+	xprt_put(xprt);
+	return count;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -293,7 +327,7 @@ static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
 static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
-	0644, rpc_sysfs_xprt_state_show, NULL);
+	0644, rpc_sysfs_xprt_state_show, rpc_sysfs_xprt_state_change);
 
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 07e76ae1028a..39551b794b80 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -230,7 +230,8 @@ void xprt_iter_default_rewind(struct rpc_xprt_iter *xpi)
 static
 bool xprt_is_active(const struct rpc_xprt *xprt)
 {
-	return kref_read(&xprt->kref) != 0;
+	return (kref_read(&xprt->kref) != 0 &&
+		!test_bit(XPRT_OFFLINE, &xprt->state));
 }
 
 static
-- 
2.27.0

