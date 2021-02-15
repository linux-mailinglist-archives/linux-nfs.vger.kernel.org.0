Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EF31C0D2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBORlm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhBORld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:41:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C3C061793
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jj19so12568394ejc.4
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3CklkawBYlWE0T+slCXVcG84oQksA0ep6RTt5W4hSc=;
        b=dsUwtoDU2LG8JjqiVFBZaRuHBY2wpELQR2CvThGIFmuD8X2EPzN+fo2un6WEQJ4BoO
         PhE/DLBlhM4mw5XrbMOU4j+pnbyyALUqv+7vPOWYmSnaLo6UBdyqnkf6cukxzLGAWsPE
         JGr3fgu+nkojaIOPbrSwLNN1rVk69EU2fnstA1jTQ4tXygG352xVMXdZ21/5oEHtCjmp
         YqNWL7hJAVw7uWoUljhE/piwmJUiMKwUrej9aTcqWuJhqnLZLHBCXirdAVBvVOZcK2I8
         W4JFVAeVbnm4OgGW+a8Kk+pDLwOrxCdhb1voIkStOErSBR3Mae+3eL/Tuix4dWN4gx2D
         9Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3CklkawBYlWE0T+slCXVcG84oQksA0ep6RTt5W4hSc=;
        b=tmlSrQhk79f9B304qs9E664OPsYldczoSm1h6ZpklY1gxf7/X7z9vPHpfdxVYPa9iu
         90TlzWSIvZky02iT3L3ll/wxpV4Azy23bKoQxxe2xoW0Vz15O38Sbla9bM4ftmLCX5NK
         4Jbynx/z9o4Rlz0P4LM25I7JOaZXyh9kWsnrJfwGwA8Xj51LmS2bysNEA2rxvrEIcruF
         RYZudNdqrH2Zm6blIdRjAMRVN7vPjOoc6X3hgUo/IhodiJA1RBlfcXVrsvUBV/tt1Hz5
         mODMzDUb9je7/IjlMewF9Eqw0HHKQg7ZtwOOuO5kqV0UViD9UDSxXMdmoLu3XHUUFw4a
         clOg==
X-Gm-Message-State: AOAM531WC6C5o2A1H4xuMZPuSjDxCDFpjQpa6ShuDeu+zgQpZnAMj3JS
        LBNcLyFBQJOBx8Y42rdolLL/X5OuGW2JEA==
X-Google-Smtp-Source: ABdhPJy+mHe/TaiwSAuhC3Y/duDVXZ6AZJ6ljXU6J40F/0dyZbb8ykRqcwLIv3EnH34pjf010ojBmw==
X-Received: by 2002:a17:906:3f96:: with SMTP id b22mr16416022ejj.478.1613410814217;
        Mon, 15 Feb 2021 09:40:14 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:13 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 8/8] sunrpc: introduce an 'add' node to 'multipath' sysfs directory
Date:   Mon, 15 Feb 2021 19:40:02 +0200
Message-Id: <20210215174002.2376333-9-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allows adding new transports to an existing multipath switch. This
is similar to what the `nconnect` mount parameter does, but instead we
can do this while the NFS mount is live.

For example:

    echo 'dstaddr 192.168.40.8 kind rdma' \
	   > /sys/kernel/sunrpc/client/0/multipath/add

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/sysfs.c | 104 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 3592f3b862b2..d745dfb7cef4 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -315,18 +315,116 @@ static ssize_t rpc_netns_multipath_list_show(struct kobject *kobj,
 	return pos;
 }
 
-static ssize_t rpc_netns_multipath_list_store(struct kobject *kobj,
+static ssize_t rpc_netns_multipath_add_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	return -EINVAL;
+	struct rpc_netns_multipath *c =
+		container_of(kobj, struct rpc_netns_multipath, kobject);
+	struct rpc_xprt_switch *xps = c->xps;
+	struct rpc_xprt_iter xpi;
+	struct sockaddr_storage addr;
+	struct xprt_create xprt_args = {
+		.ident = XPRT_TRANSPORT_RDMA,
+		.net = c->net,
+		.dstaddr = (struct sockaddr *)&addr,
+	};
+	struct rpc_xprt *existing_xprt;
+	char *opt, *str, *arg;
+	bool has_dstaddr = false;
+	bool has_kind = false;
+	int err;
+
+	opt = kstrndup(buf, count, GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	str = strstrip(opt);
+
+	while (1) {
+		arg = strsep(&str, " ");
+		if (!arg)
+			break;
+
+		if (sysfs_streq(arg, "kind")) {
+			arg = strsep(&str, " ");
+			if (!arg) {
+				err = -EINVAL;
+				goto out;
+			}
+			if (has_kind) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (sysfs_streq(arg, "rdma")) {
+				xprt_args.ident = XPRT_TRANSPORT_RDMA;
+			} else if (sysfs_streq(arg, "tcp")) {
+				xprt_args.ident = XPRT_TRANSPORT_TCP;
+			} else {
+				err = -EINVAL;
+				goto out;
+			}
+
+			has_kind = true;
+		} else if (sysfs_streq(arg, "dstaddr")) {
+			arg = strsep(&str, " ");
+			if (!arg) {
+				err = -EINVAL;
+				goto out;
+			}
+			xprt_args.addrlen = rpc_pton(c->net,
+				arg, strlen(arg), (struct sockaddr *)&addr,
+				sizeof(addr));
+			if (has_dstaddr || !xprt_args.addrlen) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			has_dstaddr = true;
+		} else {
+			break;
+		}
+	}
+
+	if (!has_dstaddr || !has_kind)  {
+		err = -EINVAL;
+		goto out;
+	}
+
+
+	/* Discover an existing xprt */
+	xprt_iter_init_listall(&xpi, xps);
+	existing_xprt = xprt_iter_get_next(&xpi);
+	xprt_iter_destroy(&xpi);
+
+	if (!existing_xprt) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	xprt_args.servername = existing_xprt->servername;
+	xprt_iter_init_listall(&xpi, xps);
+	rpc_add_xprt(&xpi, NULL, &xprt_args, NULL, NULL);
+	xprt_iter_destroy(&xpi);
+
+	xprt_put(existing_xprt);
+
+	err = count;
+out:
+	kfree(opt);
+
+	return err;
 }
 
 static struct kobj_attribute rpc_netns_multipath_list = __ATTR(list,
-	0644, rpc_netns_multipath_list_show, rpc_netns_multipath_list_store);
+	0444, rpc_netns_multipath_list_show, NULL);
 
+static struct kobj_attribute rpc_netns_multipath_add = __ATTR(add,
+	0200, NULL, rpc_netns_multipath_add_store);
 
 static struct attribute *rpc_netns_multipath_attrs[] = {
 	&rpc_netns_multipath_list.attr,
+	&rpc_netns_multipath_add.attr,
 	NULL,
 };
 
-- 
2.26.2

