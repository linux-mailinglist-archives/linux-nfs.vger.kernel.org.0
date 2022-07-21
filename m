Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990857D680
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiGUWHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiGUWHX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:23 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E08875F
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:22 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u19so1519061ilk.7
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRwqEk/Tje8Bd1rVzX1MY35Msd1ee7K5czYsHF7UGI4=;
        b=CsUsCS7r4c5eANn+za7VEbf8kT4vwx552mdmEKGS7PuWePxA9lU7G8UoFmj+aKMa5N
         I9EXhV3BSjWYbdQhILrr4sTVNggmi56qNtk8ZibV8BtmMdQp6QuYwqI4SjZSqMRNA+pp
         OtxY5ipja4jXawJxqtteQByFRAFM0DMbkL2dpnBr5ghI9joi1Ui3b2wXlIz0/BUzODbF
         aBSjh/GcwcUrbmp7Z/0s4OLa0iP0yiS5vL2pp77yo0n4v1VsadWyasFnZiEnypqyXZ3B
         7v3SXPzPB6vF1KRaUz4gez8F1euMePHa31h32God4qPFtc7irS4aY6pjbcNsY91xEBJd
         P/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRwqEk/Tje8Bd1rVzX1MY35Msd1ee7K5czYsHF7UGI4=;
        b=bXYXZ8AdYyxw2JMherI1RrnqXRzNtdf/U/jNOEi4rFv4+fpL/zDKYihBhJepIwo5yl
         oImhFWdSBDvRO0Um+5KEi39lOG/ErAPJ7QtDHtMj3iMnh6ASVuJX7NNuAa0z8la29OVC
         Zk9EF52mFwEVaqyDLt+ls37gm/RBANGmQ5zM8dUFlREc8wSopLypUoT+L7XsS4s9s3uC
         mswAjwHUlwc3uPtDU+mSgTK0TxtTRmbv/5kzm6JZPLzPvfb2xrjCbqpx9lP4YTPVippZ
         19gzAnJoyNmX4cItCNX7w0rhV4Pa4Bgk5UEaXn2C9QnSv0nlVAWc4hXKvNnco/IEieGp
         NCPQ==
X-Gm-Message-State: AJIora8mbpP1FsOHBRjgtP8VxrEP409aVzIdVEve4e1zxEbTwQkMtzE6
        6UfNeg4sG5BKoYzO0ME4el4=
X-Google-Smtp-Source: AGRyM1s5+KwhJkUNOXec/2ImWIG17+D5m2dQWvzSlV9sYvjCFTWK0xdIG2spSzFnFY86eJD5oNahBw==
X-Received: by 2002:a92:ad07:0:b0:2db:ec23:909e with SMTP id w7-20020a92ad07000000b002dbec23909emr223035ilh.204.1658441241663;
        Thu, 21 Jul 2022 15:07:21 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/11] SUNRPC create an iterator to list only OFFLINE xprts
Date:   Thu, 21 Jul 2022 18:07:07 -0400
Message-Id: <20220721220714.22620-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Create a new iterator helper that will go thru the all the transports
in the switch and return transports that are marked OFFLINE.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h |  3 +
 net/sunrpc/clnt.c                    | 11 +++-
 net/sunrpc/xprtmultipath.c           | 99 +++++++++++++++++++++++++---
 3 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index bbb8a5fa0816..688ca7eb1d01 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -63,6 +63,9 @@ extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
 extern void xprt_iter_init_listall(struct rpc_xprt_iter *xpi,
 		struct rpc_xprt_switch *xps);
 
+extern void xprt_iter_init_listoffline(struct rpc_xprt_iter *xpi,
+		struct rpc_xprt_switch *xps);
+
 extern void xprt_iter_destroy(struct rpc_xprt_iter *xpi);
 
 extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6417ccc283f4..ada45b3b1dad 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -786,7 +786,8 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 EXPORT_SYMBOL_GPL(rpc_switch_client_transport);
 
 static
-int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
+int _rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi,
+			     void func(struct rpc_xprt_iter *xpi, struct rpc_xprt_switch *xps))
 {
 	struct rpc_xprt_switch *xps;
 
@@ -795,11 +796,17 @@ int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
 	rcu_read_unlock();
 	if (xps == NULL)
 		return -EAGAIN;
-	xprt_iter_init_listall(xpi, xps);
+	func(xpi, xps);
 	xprt_switch_put(xps);
 	return 0;
 }
 
+static
+int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
+{
+	return _rpc_clnt_xprt_iter_init(clnt, xpi, xprt_iter_init_listall);
+}
+
 /**
  * rpc_clnt_iterate_for_each_xprt - Apply a function to all transports
  * @clnt: pointer to client
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 1693f81aae37..8def8423fc0a 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -27,6 +27,7 @@ typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct rpc_xprt_switch *xps,
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_singular;
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_roundrobin;
 static const struct rpc_xprt_iter_ops rpc_xprt_iter_listall;
+static const struct rpc_xprt_iter_ops rpc_xprt_iter_listoffline;
 
 static void xprt_switch_add_xprt_locked(struct rpc_xprt_switch *xps,
 		struct rpc_xprt *xprt)
@@ -248,6 +249,18 @@ struct rpc_xprt *xprt_switch_find_first_entry(struct list_head *head)
 	return NULL;
 }
 
+static
+struct rpc_xprt *xprt_switch_find_first_entry_offline(struct list_head *head)
+{
+	struct rpc_xprt *pos;
+
+	list_for_each_entry_rcu(pos, head, xprt_switch) {
+		if (!xprt_is_active(pos))
+			return pos;
+	}
+	return NULL;
+}
+
 static
 struct rpc_xprt *xprt_iter_first_entry(struct rpc_xprt_iter *xpi)
 {
@@ -259,8 +272,9 @@ struct rpc_xprt *xprt_iter_first_entry(struct rpc_xprt_iter *xpi)
 }
 
 static
-struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
-		const struct rpc_xprt *cur)
+struct rpc_xprt *_xprt_switch_find_current_entry(struct list_head *head,
+						 const struct rpc_xprt *cur,
+						 bool find_active)
 {
 	struct rpc_xprt *pos;
 	bool found = false;
@@ -268,14 +282,25 @@ struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
 	list_for_each_entry_rcu(pos, head, xprt_switch) {
 		if (cur == pos)
 			found = true;
-		if (found && xprt_is_active(pos))
+		if (found && ((find_active && xprt_is_active(pos)) ||
+			      (!find_active && xprt_is_active(pos))))
 			return pos;
 	}
 	return NULL;
 }
 
 static
-struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
+struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
+						const struct rpc_xprt *cur)
+{
+	return _xprt_switch_find_current_entry(head, cur, true);
+}
+
+static
+struct rpc_xprt * _xprt_iter_current_entry(struct rpc_xprt_iter *xpi,
+		struct rpc_xprt *first_entry(struct list_head *head),
+		struct rpc_xprt *current_entry(struct list_head *head,
+					       const struct rpc_xprt *cur))
 {
 	struct rpc_xprt_switch *xps = rcu_dereference(xpi->xpi_xpswitch);
 	struct list_head *head;
@@ -284,8 +309,30 @@ struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
 		return NULL;
 	head = &xps->xps_xprt_list;
 	if (xpi->xpi_cursor == NULL || xps->xps_nxprts < 2)
-		return xprt_switch_find_first_entry(head);
-	return xprt_switch_find_current_entry(head, xpi->xpi_cursor);
+		return first_entry(head);
+	return current_entry(head, xpi->xpi_cursor);
+}
+
+static
+struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
+{
+	return _xprt_iter_current_entry(xpi, xprt_switch_find_first_entry,
+			xprt_switch_find_current_entry);
+}
+
+static
+struct rpc_xprt *xprt_switch_find_current_entry_offline(struct list_head *head,
+		const struct rpc_xprt *cur)
+{
+	return _xprt_switch_find_current_entry(head, cur, false);
+}
+
+static
+struct rpc_xprt *xprt_iter_current_entry_offline(struct rpc_xprt_iter *xpi)
+{
+	return _xprt_iter_current_entry(xpi,
+			xprt_switch_find_first_entry_offline,
+			xprt_switch_find_current_entry_offline);
 }
 
 bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
@@ -310,7 +357,7 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
-		const struct rpc_xprt *cur)
+		const struct rpc_xprt *cur, bool check_active)
 {
 	struct rpc_xprt *pos, *prev = NULL;
 	bool found = false;
@@ -318,7 +365,12 @@ struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 	list_for_each_entry_rcu(pos, head, xprt_switch) {
 		if (cur == prev)
 			found = true;
-		if (found && xprt_is_active(pos))
+		/* for request to return active transports return only
+		 * active, for request to return offline transports
+		 * return only offline
+		 */
+		if (found && ((check_active && xprt_is_active(pos)) ||
+			      (!check_active && !xprt_is_active(pos))))
 			return pos;
 		prev = pos;
 	}
@@ -355,7 +407,7 @@ struct rpc_xprt *__xprt_switch_find_next_entry_roundrobin(struct list_head *head
 {
 	struct rpc_xprt *ret;
 
-	ret = xprt_switch_find_next_entry(head, cur);
+	ret = xprt_switch_find_next_entry(head, cur, true);
 	if (ret != NULL)
 		return ret;
 	return xprt_switch_find_first_entry(head);
@@ -397,7 +449,14 @@ static
 struct rpc_xprt *xprt_switch_find_next_entry_all(struct rpc_xprt_switch *xps,
 		const struct rpc_xprt *cur)
 {
-	return xprt_switch_find_next_entry(&xps->xps_xprt_list, cur);
+	return xprt_switch_find_next_entry(&xps->xps_xprt_list, cur, true);
+}
+
+static
+struct rpc_xprt *xprt_switch_find_next_entry_offline(struct rpc_xprt_switch *xps,
+		const struct rpc_xprt *cur)
+{
+	return xprt_switch_find_next_entry(&xps->xps_xprt_list, cur, false);
 }
 
 static
@@ -407,6 +466,13 @@ struct rpc_xprt *xprt_iter_next_entry_all(struct rpc_xprt_iter *xpi)
 			xprt_switch_find_next_entry_all);
 }
 
+static
+struct rpc_xprt *xprt_iter_next_entry_offline(struct rpc_xprt_iter *xpi)
+{
+	return xprt_iter_next_entry_multiple(xpi,
+			xprt_switch_find_next_entry_offline);
+}
+
 /*
  * xprt_iter_rewind - Resets the xprt iterator
  * @xpi: pointer to rpc_xprt_iter
@@ -460,6 +526,12 @@ void xprt_iter_init_listall(struct rpc_xprt_iter *xpi,
 	__xprt_iter_init(xpi, xps, &rpc_xprt_iter_listall);
 }
 
+void xprt_iter_init_listoffline(struct rpc_xprt_iter *xpi,
+		struct rpc_xprt_switch *xps)
+{
+	__xprt_iter_init(xpi, xps, &rpc_xprt_iter_listoffline);
+}
+
 /**
  * xprt_iter_xchg_switch - Atomically swap out the rpc_xprt_switch
  * @xpi: pointer to rpc_xprt_iter
@@ -574,3 +646,10 @@ const struct rpc_xprt_iter_ops rpc_xprt_iter_listall = {
 	.xpi_xprt = xprt_iter_current_entry,
 	.xpi_next = xprt_iter_next_entry_all,
 };
+
+static
+const struct rpc_xprt_iter_ops rpc_xprt_iter_listoffline = {
+	.xpi_rewind = xprt_iter_default_rewind,
+	.xpi_xprt = xprt_iter_current_entry_offline,
+	.xpi_next = xprt_iter_next_entry_offline,
+};
-- 
2.27.0

