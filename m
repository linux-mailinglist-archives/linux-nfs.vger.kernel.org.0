Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8263A1F6F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFIVzf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFIVzf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 17:55:35 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB2C061574
        for <linux-nfs@vger.kernel.org>; Wed,  9 Jun 2021 14:53:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k22so24503221ioa.9
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4veoKZ0a0ni8ResyWpIUp4CiHu7n3udp9Mrl0bKQgU=;
        b=FEiIZIYv0Ntd8Xoe+ExeSIF01Sfpdg52Ph41kgOQ1HlWn7mmSQ/lrwMdufHw5kjJh1
         NT/WHqXd6uFZLZATnzg6nxb7GFI5ZHxMmNEBq1KHnq1lt8O5Rv0pIrooFcsuE5ogx1Wc
         mxQcf1+ABVzh2PaOH58n2X0W/1ynddf4QUOzSSHiYX1sZjqeAPaexfYM4b8584GmcolW
         bfqRx1GUd5f5alQ/RXx6wqz17ERK0niLQKI7PoZmUj5OVy/32UAmgcvaxUWQyG8AQkVe
         Iq97elwkLOUlzxkcUiCipxzR2szRWKfhb2t72Uw+v8Eu9WRayzpMZ9l1s4fLaI2sysvF
         VqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4veoKZ0a0ni8ResyWpIUp4CiHu7n3udp9Mrl0bKQgU=;
        b=YJ+9SkrCxFzxTcCR8BC1a0ZRWGE7uB6yhp+qPYm+EBlRHI02FcCT8IkxtWr0a7Cw+T
         grPH0FKkSlhS6fQ/sSPi9HrcSXjDQYN3u7oxYVjOG3vMPbXTBOmYUL6wA+AAReePorzd
         MXh4PVWQvOo5uRkOollXn8kwxvv7NNdLekpTCAXaOo3j8nJ4IGdZpvW9m20ZUFB2qf+3
         xZiDTCQprIOnwVhwyT1fHMV/w9fN+dfnV8twCSlmXnSxELDxyL9rXrcLT7be2kjITAd4
         7YrlzMoRQOkIJ4aFDrxK2+EjrFTk1H459w3UYBmFlfEc4uoK7kXnRNqOYJrn/ICJSRPn
         r61w==
X-Gm-Message-State: AOAM530+6mc5K5TEeXTHMFRBbbCIQ9Gmtw4ZCknf0126eG1ed+QotQk+
        M4E1OOAZYiTxoWssVzK1uwCEj8xUgIvbOg==
X-Google-Smtp-Source: ABdhPJwWOEB9gkA3+eeN2PyLIpt/WlHwttcmfuxDbeLkoL7Bed9XVqFzeJPutntD/eGocy2ulDUv0w==
X-Received: by 2002:a6b:c30f:: with SMTP id t15mr1159219iof.17.1623275603347;
        Wed, 09 Jun 2021 14:53:23 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id w25sm619743iox.18.2021.06.09.14.53.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:53:22 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] SUNRPC query xprt switch for number of active transports
Date:   Wed,  9 Jun 2021 17:53:17 -0400
Message-Id: <20210609215319.5518-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

To keep track of how many transports have already been added, add
ability to query the number.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/clnt.h |  2 ++
 net/sunrpc/clnt.c           | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..27042f1e581f 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -234,6 +234,8 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
+size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *);
+
 void rpc_cleanup_clids(void);
 
 static inline int rpc_reply_expected(struct rpc_task *task)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 42623d6b8f0e..b46262ffcf72 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2959,6 +2959,19 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_has_addr);
 
+size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt_switch *xps;
+	size_t num;
+
+	rcu_read_lock();
+	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+	num = xps->xps_nactive;
+	rcu_read_unlock();
+	return num;
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_nactive);
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 static void rpc_show_header(void)
 {
-- 
2.27.0

