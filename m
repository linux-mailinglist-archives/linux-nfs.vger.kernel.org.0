Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D065520BE
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiFTPZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiFTPZY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25917E01
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id p63so8011543qkd.10
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v4+ZxnCO/CE/1Ve4CstINsmXzqfmZHhiLoXQ2o8VjU=;
        b=USIA4FATjAIuBhKYvhXGG17e1sUJiXT0qczEX1YtGZGayZJFIHzsjFj8oS7bcQRYmH
         yTqzCX0ahE2Kw09KT/yzzDryzQWmu+DtsH23C/aau+VaLblBkHrNsLHShvRtutLINsHs
         7yhxUlBykgxwojaVNdt5azwFnnU5mgeP5A15oaQ0D0vIB+7o3OYZ/IYG42+WXxp5vNnv
         tU/11Hww5cyI5KxfWRSPgoM3+dQMPALp04EzQxQSVM88UlKkRQ4qcvmcPMmSfFHFdtZk
         lPmFfylzbAseGaY9wwd95ut1Y/nSMgHblZWUY9iHvyiCohS7x9XaDwsVdnHuU9SJYT5o
         YHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v4+ZxnCO/CE/1Ve4CstINsmXzqfmZHhiLoXQ2o8VjU=;
        b=2fLiSECPLuXnrKmg8LMYVTJ4S+fj6VUU+pd3pGwfI+MksLlufmIjD1FQ/D4eWZw9gj
         R57zExcIsHRtwkrVR2AEJ+ZQT3UGG5Rl/ey7iFyW6dodpaQRMhzRcfBe2zB3kGc2EsUF
         frROuNFlqOO4cOCisH49pdqWsSDTcXqgADq/GMuCrJc54lqM/UR9MxzxE6mEJwUw+tR6
         GjMrrakXkcIjATyFfHnjsoGKezbedIP4YVSg+arPT2GoIlFYJXjXYQBavXSBLGQiqAba
         Aa7KEdOUxQVxb6sfSW+Rirqc9q4FlHw+ZIxpQcIvWRY6+h3VjeGnH3RnKaIVwCEYNAfw
         OIEA==
X-Gm-Message-State: AJIora+cuoGpMx7vd0Ex7KS9YLtq94k9Ov5MKme/1zAi9mCPqJY+cY2C
        +RDmFZ7/4GdDksP8C6LDzSw=
X-Google-Smtp-Source: AGRyM1uYkqucyK2wdRs2Eid57zuVLz44Y0MkJcnF6oQn/xBvwM1CsRfZLXwqqKEoXFFCijLpb2IKKg==
X-Received: by 2002:a05:620a:142a:b0:6a6:8a05:f862 with SMTP id k10-20020a05620a142a00b006a68a05f862mr16519063qkj.11.1655738675218;
        Mon, 20 Jun 2022 08:24:35 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:34 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 04/12] SUNRPC create an iterator to list only OFFLINE xprts
Date:   Mon, 20 Jun 2022 11:23:59 -0400
Message-Id: <20220620152407.63127-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Create a new iterator helper that will go thru the all the transports
in the switch and return transports that are marked OFFLINE.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h |  3 +
 net/sunrpc/clnt.c                    | 19 +++++-
 net/sunrpc/xprtmultipath.c           | 98 +++++++++++++++++++++++++---
 3 files changed, 108 insertions(+), 12 deletions(-)

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
index 544b55a3aa20..410bd6c352ad 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -785,7 +785,9 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 EXPORT_SYMBOL_GPL(rpc_switch_client_transport);
 
 static
-int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
+int _rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi,
+		void func(struct rpc_xprt_iter *xpi,
+			  struct rpc_xprt_switch *xps))
 {
 	struct rpc_xprt_switch *xps;
 
@@ -794,11 +796,24 @@ int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
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
+static
+int rpc_clnt_xprt_iter_offline_init(struct rpc_clnt *clnt,
+				    struct rpc_xprt_iter *xpi)
+{
+	return _rpc_clnt_xprt_iter_init(clnt, xpi, xprt_iter_init_listoffline);
+}
+
 /**
  * rpc_clnt_iterate_for_each_xprt - Apply a function to all transports
  * @clnt: pointer to client
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 1693f81aae37..4374cd6acc55 100644
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
@@ -259,8 +272,8 @@ struct rpc_xprt *xprt_iter_first_entry(struct rpc_xprt_iter *xpi)
 }
 
 static
-struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
-		const struct rpc_xprt *cur)
+struct rpc_xprt *_xprt_switch_find_current_entry(struct list_head *head,
+		const struct rpc_xprt *cur, bool find_active)
 {
 	struct rpc_xprt *pos;
 	bool found = false;
@@ -268,14 +281,25 @@ struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
 	list_for_each_entry_rcu(pos, head, xprt_switch) {
 		if (cur == pos)
 			found = true;
-		if (found && xprt_is_active(pos))
+		if (found && ((find_active && xprt_is_active(pos)) ||
+				(!find_active && xprt_is_active(pos))))
 			return pos;
 	}
 	return NULL;
 }
 
 static
-struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
+struct rpc_xprt *xprt_switch_find_current_entry(struct list_head *head,
+		const struct rpc_xprt *cur)
+{
+	return _xprt_switch_find_current_entry(head, cur, true);
+}
+
+static
+struct rpc_xprt * _xprt_iter_current_entry(struct rpc_xprt_iter *xpi,
+		struct rpc_xprt *first_entry(struct list_head *head),
+		struct rpc_xprt *current_entry(struct list_head *head,
+		const struct rpc_xprt *cur))
 {
 	struct rpc_xprt_switch *xps = rcu_dereference(xpi->xpi_xpswitch);
 	struct list_head *head;
@@ -284,8 +308,30 @@ struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
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
@@ -310,7 +356,7 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
-		const struct rpc_xprt *cur)
+		const struct rpc_xprt *cur, bool check_active)
 {
 	struct rpc_xprt *pos, *prev = NULL;
 	bool found = false;
@@ -318,7 +364,12 @@ struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
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
@@ -355,7 +406,7 @@ struct rpc_xprt *__xprt_switch_find_next_entry_roundrobin(struct list_head *head
 {
 	struct rpc_xprt *ret;
 
-	ret = xprt_switch_find_next_entry(head, cur);
+	ret = xprt_switch_find_next_entry(head, cur, true);
 	if (ret != NULL)
 		return ret;
 	return xprt_switch_find_first_entry(head);
@@ -397,7 +448,14 @@ static
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
@@ -407,6 +465,13 @@ struct rpc_xprt *xprt_iter_next_entry_all(struct rpc_xprt_iter *xpi)
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
@@ -460,6 +525,12 @@ void xprt_iter_init_listall(struct rpc_xprt_iter *xpi,
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
@@ -574,3 +645,10 @@ const struct rpc_xprt_iter_ops rpc_xprt_iter_listall = {
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

