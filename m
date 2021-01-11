Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018DC2F221F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbhAKVqu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbhAKVqu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:46:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB68EC061786
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:46:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 81so38781ioc.13
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbP1OQZq+5+FFGKGb0LjAahO6kCFsRQ76eQrVUZXeys=;
        b=ANucLuunrQH+L+xa6AzdtLNk6EHkN9ql71SFxW0KgUyr0uRF+X2ETAeZ+s0St6lDg7
         XiI9K5nlk+6AHtRsDg8yBup5SETjdYxbHTXTNY3atl0o92bht1OrpUhInIuDIiLHExQF
         IMzyhJmf/09vHw0URcEFVjlV/+QRfkmNA+Qyrb6OG7N/ndZ1f8eqk3IijDOGHWcfmDAj
         1Jr2RgzBYDGiAOmnWwxdT1l8Nrg4ODrXtI9dcTofpXOTAgwK+6eDDnvDhNsqvlKjTvSU
         7MKPEqnPiFy2SZUqWCmUuM2ZvAbL+jk/RWCNDwUoUJRRBqYh1J+umnRaDwcEbjGKl4Rr
         DEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LbP1OQZq+5+FFGKGb0LjAahO6kCFsRQ76eQrVUZXeys=;
        b=uY8lpLY0PJbCCjKN43E2EDyHUOU6DKW5UpRdiojYZkY1P8V4kHDyDv4vlVJNvOUgM5
         wG/POKNVVcwjGnJNOZLYHTjfoPhUd6kAlE0tYhocVk/Qt1jeLoALf2sJ/BxTPitgHUeh
         eiUUj3v8H8DzTW32WM8TP5dvAuEcaDAoeElvDZX8RcOoqWKL5tuFvqZ5JAErz2it8b6K
         XwFCKZHO4W2SgNajHT6RfRZLozAerJfxEzSW0N8XPmZDkLLWjyIT1h9h4eardJQ+X+sA
         AyF/vxl9KUktzY/KurZwholgasAgstOPTjVDgF5tyjpsH0ilkVkI337AYXPb5z9sp3u1
         k+aA==
X-Gm-Message-State: AOAM530Zdfr0rID82pH5qDTrEqlZa5iAnKIEKUFEKpG/V5Gt/mphXk2U
        3AmEkCPPxYGANpHSgSLZGoKYc9CIVvJ48g==
X-Google-Smtp-Source: ABdhPJxgrib6YiLoM51xwZ2Ym/mVFDSyfdNeqxy+jHBBqlbGiECfUEo4/waTyz5g3jNNPs0rDCdjwA==
X-Received: by 2002:a02:650e:: with SMTP id u14mr1464274jab.143.1610401568974;
        Mon, 11 Jan 2021 13:46:08 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id o195sm655885ila.38.2021.01.11.13.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:46:08 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH v2 7/7] sunrpc: Connect to a new IP address provided by the user
Date:   Mon, 11 Jan 2021 16:46:07 -0500
Message-Id: <20210111214607.553939-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We preserve the same port number, rather than providing a way to change
it. This keeps the implementation simpler for now.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Whoops, I forgot to commit the actual connection code to this patch!
---
 net/sunrpc/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 537d83635670..5bf8d293ab7c 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
 #include <net/sock.h>
 #include "sysfs.h"
 
@@ -70,6 +71,20 @@ static ssize_t rpc_netns_address_show(struct kobject *kobj,
 static ssize_t rpc_netns_address_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
+	struct rpc_netns_client *c = container_of(kobj,
+				struct rpc_netns_client, kobject);
+	struct rpc_clnt *clnt = c->clnt;
+	struct rpc_xprt *xprt = rcu_dereference(clnt->cl_xprt);
+	struct sockaddr *saddr = (struct sockaddr *)&xprt->addr;
+	int port = rpc_get_port(saddr);
+
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr, sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	kfree(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrndup(buf, count - 1, GFP_KERNEL);
+
+	xprt->ops->connect(xprt, NULL);
 	return count;
 }
 
-- 
2.29.2

