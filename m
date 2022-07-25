Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F157FFDF
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiGYNcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiGYNck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:40 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3202013D5F
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k129so10681709vsk.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wosDX36v6gglpAi11Xe3KOeYvm5RG0CwIq9BrzDs9c=;
        b=POY6sGdOCq//qk3hTbKS+0PxBGOvjnXvdjDYYU+MS0N34//6Y1b7zkBAipqBgqAcql
         Mc9qDKBba1WQ/X+51CWmYjUx7JqKj+ONkISXw01E7xBOtUgZ6BXiyxV0uesr6Co5mtRf
         UCIYlBtYV1/IUORPumwK2mKydavgb/+wmCaOVW9avViWSw5t/4OW0qjE6kTVZ31tifFm
         1oTysnxgdkEQiOyjyRyUF07jmUC1jhq0x/6J1RIAvIawkQtouBKlG0/8qGpXekv6rWLz
         RXCM0z6p2kYTl5Jmo2RDw/id6B9DNOW5o7NrkGRtgx5UJBQtpQ8eXiGCIylwe75Ghutf
         I78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wosDX36v6gglpAi11Xe3KOeYvm5RG0CwIq9BrzDs9c=;
        b=Bc0k3w0/tCogEVQKeO8IVFxkNugiekp8SKz74oT1U/ft/qX/X/f6nptdwvr/gihJuk
         CGE1devWGZm1ojr2ZB6ZyhPovO1Bm8JT9kN5/Pzm439OfCG4Wy9Sn30ryRMr/GAU5srS
         xkRKNHhJXpM0rbb05RsuRHQxzP3ZMJCmA9rRH81iGfKxQBwf7kZ1UnXnoTaFDrLxv1Hq
         odSE+b4+77lxK8IuwTQMVNeIQ/gAv3SiVDj451B9svesm0eDWvWZIgN3aTJdlOyXwFjr
         YI6b0+6jb4sVJWQfrwlTSK5hZ+37BH5pSiHfU2iagJLQqqgOM6wnJbEVeo4thEsLBzi0
         Of5w==
X-Gm-Message-State: AJIora+tsTtzipbqYLxxUzwqFt7ToK87AA8edpLzXln1ZrYCFzmOK7CH
        MDdavRDVnA9vysExk4dUZ4zc6PSwhys=
X-Google-Smtp-Source: AGRyM1tE8cLJ3bOroBPaQiK1cntJeWMEqPITHSHqxrS6PYhHJH+gnx5dYqqpACfurSQFh7s328JWGw==
X-Received: by 2002:a67:b008:0:b0:357:93a5:f0e0 with SMTP id z8-20020a67b008000000b0035793a5f0e0mr3511170vse.34.1658755956114;
        Mon, 25 Jul 2022 06:32:36 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/11] SUNRPC add function to offline remove trunkable transports
Date:   Mon, 25 Jul 2022 09:32:22 -0400
Message-Id: <20220725133231.4279-3-olga.kornievskaia@gmail.com>
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

Iterate thru available transports in the xprt_switch for all
trunkable transports offline and possibly remote them as well.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 90501404fa49..d14333f4947a 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -234,6 +234,7 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt_switch *,
 			struct rpc_xprt *,
 			void *);
+void		rpc_clnt_manage_trunked_xprts(struct rpc_clnt *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a97d4e06cae3..2b079c4d8af1 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3000,6 +3000,52 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_offline(struct rpc_clnt *clnt,
+			    struct rpc_xprt *xprt,
+			    void *data)
+{
+	struct rpc_xprt *main_xprt;
+	struct rpc_xprt_switch *xps;
+	int err = 0;
+
+	xprt_get(xprt);
+
+	rcu_read_lock();
+	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	err = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
+				(struct sockaddr *)&main_xprt->addr);
+	rcu_read_unlock();
+	xprt_put(main_xprt);
+	if (err)
+		goto out;
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		err = -EINTR;
+		goto out;
+	}
+	xprt_set_offline_locked(xprt, xps);
+
+	xprt_release_write(xprt, NULL);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return err;
+}
+
+/* rpc_clnt_manage_trunked_xprts -- offline trunked transports
+ * @clnt rpc_clnt structure
+ *
+ * For each active transport found in the rpc_clnt structure call
+ * the function rpc_xprt_offline() which will identify trunked transports
+ * and will mark them offline.
+ */
+void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_xprt_offline, NULL);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
+
 struct connect_timeout_data {
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
-- 
2.27.0

