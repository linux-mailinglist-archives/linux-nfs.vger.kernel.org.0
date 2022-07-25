Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBD57FFE1
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiGYNcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYNcn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:43 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49713DF9
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 129so3094672vsq.8
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teqHuH0ftgyvyp4dgzXH6ChVUVh9xQfAhdQSa6fqtZY=;
        b=iWtOtPOxIpf8uhPVTyag6zqsATYJCyeEmu26KCbOqVuDsN3aJZuX0rKUAaP8pt6y6y
         biOVCtGTO4phuPVqhGaDPUYJH6CyCpQzF6AfJeQcW3ne1AM7q2zQph46hjaxzjAf6zp4
         XR2QEe2i16c11ob/vVEV7oHvpym+4lneG7RYuY/jFuGB82H4O+kh2arHufQnx5SOgA9E
         v38CvytWlbQ37baPtRUgJSMLyf+qd+2d1pGMmFLIICMb/x11M1cHOT+dht0X36SztYlu
         w4GMdDCB6vaWPsMlseDLop3YaNSGtx4YCKyLMIz3rpNkeZvAn8lWlL4PonUfZhaUL9tf
         dpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teqHuH0ftgyvyp4dgzXH6ChVUVh9xQfAhdQSa6fqtZY=;
        b=PJ6FVB1se1UVV0G8moJ1b2udNnMfVpBTMrhTv9jIT+HBqykGBHAZtUuoem/XXgzM3l
         sVxPlhc3DGE9l8tlP0VUgg1fQs7eiU8kT+CoJl0dVYt65gyhWDxh6T9o6gEbsVOJBmFw
         3/1kjQ53+cA7k6WZT9OkuWxp1hCDnAL90yLblYyCOu/X4pZt9+P7rhM6/kGeu8j8FuDB
         yfDBNQDqKoiLo253JLYdlWZIp8BGO3Fx6zLOsiv4hAMiuBOKUhnQa3l84+GHhZqGRZk3
         V9YIf3j59BwgVU0h77mhnWw/lJfRI1YtybpwIrJuFU7zJowtH/RH+R48yfK0aQyPaaMj
         YblA==
X-Gm-Message-State: AJIora9hoVVgIjNmzlM+p3L79vRClUEMeoGVJX26ggg71EHjbyFZOQCm
        pFDVP1JqxK4v6OtyWOlgbfFD6W/AOxk=
X-Google-Smtp-Source: AGRyM1u4kIpnemli4/XbF248nScp3Up/cU7KoNguI7Qf5GSony7klGcsqfzdm6myg11ZZwZalSEdTw==
X-Received: by 2002:a05:6102:334d:b0:358:4e29:4d01 with SMTP id j13-20020a056102334d00b003584e294d01mr2505310vse.31.1658755958560;
        Mon, 25 Jul 2022 06:32:38 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/11] SUNRPC create an iterator to list only OFFLINE xprts
Date:   Mon, 25 Jul 2022 09:32:24 -0400
Message-Id: <20220725133231.4279-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
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
index 2b079c4d8af1..68021b70340d 100644
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

