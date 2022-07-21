Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667D57D686
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiGUWHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiGUWH3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383993C25
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n7so2433742ioo.7
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLZyY+3mcqNnIhGziWEpPlQT8AF5MejXmXGzyCqVaII=;
        b=gfWUuTDFAd+JZdKsBKj2Aavr7m7Jw34AQRAbKngM6/JO9vuze+zSfvCIQYKzTgKzvN
         u3VCjpuk2jAfv5CiyhtYuCHsyMaqqs0s0q8X9M5255kcjiUFjaXBBWfhDx1ZWIqXR5Sj
         CrCUKXDR3Z7wivl7FRwhok9LPKoZSx7mpfGSiblI+PpW37SFCYQ9pEJC5Jo5ur1TJHq5
         o82c/jLgYyWIxCKNNgBlRabramyNj87dZv65M3brl4VBFCazPfSMZYs6gbDxD7FYPaPx
         WUZgU5J1o7i9uT3jerVU7RLPbQWtgNANZd798QkwXrRLNbXWgIUAt45M/TL9Wntztbf6
         NMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLZyY+3mcqNnIhGziWEpPlQT8AF5MejXmXGzyCqVaII=;
        b=Fk1vBEKZPWeOXjbcxp7S953Q4/WJZ711yijWHwNF/7vZBwNQvurVxhqp1HEI5NxO9h
         wSB3TCAhUPvgZAKMhBbyu70fgZHEge/RYKgPRKZ9phoaO7kY8NeJ74ieBZnK8wAp5IOv
         lm8jy8Ba3cJtkhRo5POy2YMjkmW+Gvs0STD4+QD7db0AwPlkWhPl8I10XZJPn1aRLO72
         55x6GDixOHE1l8esNA4FqRujt4/Ppx1h2YRkBeVhyawabdH+i/PXJvj+fwunf5iuYOIH
         5LWekJp2pmYZhzQKPkXBr+tvw1z2d51Dlf/BGqmc9zBnvQo5b/QZ4+4JRVhP+FFUWxBf
         tTVw==
X-Gm-Message-State: AJIora+q3xOsiPjyw0U4WfipyPJM1No6Z+PyhHdulBu5pfbyduQqBIfF
        /FIA+C/fXvaiwNtcICzsqDSIlxZNY1s=
X-Google-Smtp-Source: AGRyM1uljsw/BU13IqUapJpljymz+L2DZG/PV9q8IscL8lJN2Kr0OAhd3kiwTZgA/sB8Lg3yRSGO0A==
X-Received: by 2002:a05:6638:210b:b0:33f:5635:4c4b with SMTP id n11-20020a056638210b00b0033f56354c4bmr330051jaj.116.1658441247885;
        Thu, 21 Jul 2022 15:07:27 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:27 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/11] SUNRPC create a function that probes only offline transports
Date:   Thu, 21 Jul 2022 18:07:13 -0400
Message-Id: <20220721220714.22620-11-olga.kornievskaia@gmail.com>
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
index c226025dbe97..0c24a97ecba0 100644
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

