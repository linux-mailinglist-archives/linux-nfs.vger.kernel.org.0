Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95857FFED
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiGYNdA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiGYNcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:50 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756CF13F07
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:47 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 14so4582313vkj.12
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74JoiiH+MwVY31GHjxJVwhZK7/xR+Va+xIk9R1BA1Ao=;
        b=nRh6qDZjrWU/sOKd0cXLS9HZXMN0zSU3DKHfNYTmYVs3BzZ4pGyPT4Ry9KpLUjrVnB
         LhOe1oe1f8k8dxbhNgPMfKOhs0QjmpYJH6/Z4i3eXU8hGxCAxuD5R4jtHmoHM64veQcC
         KSfSvV4gKifxpZCxdiadibXvNfOtj1c0vWsZatZzxsvN2Xp72QBv0JghkA8Y/DE7Ge7n
         TU/txFTmVL4H804xCQfl3AzX3eOSa1Y5F2YlfmT6rtK2/P7WDeV2ZIVUNvdgxDeUmjLD
         EJvaFqytJGoea5caH8oerkfakNMonDi0jXit6ABCPVBjo+tEHLZbDJjNlXHm9FpLsjaQ
         ORRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74JoiiH+MwVY31GHjxJVwhZK7/xR+Va+xIk9R1BA1Ao=;
        b=WnKi6SZ51bJH44xO5guKuj0Xc/Lbu38xwA3Evj0+0HzkLlaXe1qmoCrACnluXpg8cs
         sodAASVTwMRaW7nJCj+NOABUO98bYCGFz+ZCUlVBUppIuIET1f32oP8i4p+MNKKzKw10
         18uDV1bgSmoaLlAM1DiLCKhIFNdPHRxBw9u4XcKzcVOqCLXpJBjMpNDI3/g2lbcf6kZz
         WgV0InmT7+1DcxmZsIDVdXejM8eGrRjXlz1SHGHW27fLz07l5IDv74aATfHAoFj/LJu8
         DdktcSkh31SBRKZhU9WJ/SraZHLorI6asPFaRtJuqz9tWFHDZg3MgmjwVDAAijC/K9cW
         TkhQ==
X-Gm-Message-State: AJIora8hiEbIN4ulr9njGg9jxhe7tl2u5v4kfGqJTX5Tbx7P7/c9mZ8U
        QUcggmXUlP1ZQ3VBkDwZVHjq6VGciSc=
X-Google-Smtp-Source: AGRyM1swLUXuh4wO+4mUpJap++OrIW1s4kVmQ/erUVwPKXSpAQneBB6hPYZVTQzXFg7GOMKgp3CTLw==
X-Received: by 2002:a05:6122:410:b0:374:9b13:daae with SMTP id e16-20020a056122041000b003749b13daaemr3255294vkd.24.1658755965872;
        Mon, 25 Jul 2022 06:32:45 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/11] SUNRPC create a function that probes only offline transports
Date:   Mon, 25 Jul 2022 09:32:30 -0400
Message-Id: <20220725133231.4279-11-olga.kornievskaia@gmail.com>
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

For only offline transports, attempt to check connectivity via
a NULL call and, if that succeeds, call a provided session trunking
detection function.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  2 ++
 net/sunrpc/clnt.c           | 65 +++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 7a43fd514398..75eea5ebb179 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -235,6 +235,8 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt *,
 			void *);
 void		rpc_clnt_manage_trunked_xprts(struct rpc_clnt *);
+void		rpc_clnt_probe_trunked_xprts(struct rpc_clnt *,
+			struct rpc_add_xprt_test *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9c9712274ca8..bbfc47f03480 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -807,6 +807,13 @@ int rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi)
 	return _rpc_clnt_xprt_iter_init(clnt, xpi, xprt_iter_init_listall);
 }
 
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
@@ -3018,6 +3025,64 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_probe_trunked(struct rpc_clnt *clnt,
+				  struct rpc_xprt *xprt,
+				  struct rpc_add_xprt_test *data)
+{
+	struct rpc_xprt_switch *xps;
+	struct rpc_xprt *main_xprt;
+	int status = 0;
+
+	xprt_get(xprt);
+
+	rcu_read_lock();
+	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	status = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
+				   (struct sockaddr *)&main_xprt->addr);
+	rcu_read_unlock();
+	xprt_put(main_xprt);
+	if (status || !test_bit(XPRT_OFFLINE, &xprt->state))
+		goto out;
+
+	status = rpc_clnt_add_xprt_helper(clnt, xprt, data);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return status;
+}
+
+/* rpc_clnt_probe_trunked_xprt -- probe offlined transport for session trunking
+ * @clnt rpc_clnt structure
+ *
+ * For each offlined transport found in the rpc_clnt structure call
+ * the function rpc_xprt_probe_trunked() which will determine if this
+ * transport still belongs to the trunking group.
+ */
+void rpc_clnt_probe_trunked_xprts(struct rpc_clnt *clnt,
+				  struct rpc_add_xprt_test *data)
+{
+	struct rpc_xprt_iter xpi;
+	int ret;
+
+	ret = rpc_clnt_xprt_iter_offline_init(clnt, &xpi);
+	if (ret)
+		return;
+	for (;;) {
+		struct rpc_xprt *xprt = xprt_iter_get_next(&xpi);
+
+		if (!xprt)
+			break;
+		ret = rpc_xprt_probe_trunked(clnt, xprt, data);
+		xprt_put(xprt);
+		if (ret < 0)
+			break;
+		xprt_iter_rewind(&xpi);
+	}
+	xprt_iter_destroy(&xpi);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_probe_trunked_xprts);
+
 static int rpc_xprt_offline(struct rpc_clnt *clnt,
 			    struct rpc_xprt *xprt,
 			    void *data)
-- 
2.27.0

