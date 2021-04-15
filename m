Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60A360008
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhDOC2l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhDOC2l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A38C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:18 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b17so18907402ilh.6
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7vuUpogqSvc8cLlPB7IW3hqKwPWBq5Mgun+BSaMlLw=;
        b=rE0RWTkyyEXpBVDGHnFidCJTfPu/YkJ98wAiyZNv9/UwMi6Ek4XYYtJWH1oS84QCAw
         Xdssb6N4l7o8DBrxjNLDghGFmOfWUcCWCGwtroAcmHD2OM7joUY7mRKGjZ+Ixgt58bH/
         cEpsDNGfiSqkHc19uMCSVJB9AerXtXJGwxrmkIpRC2RHd8W6aYnh1KAvJuKTR/Sa6TgJ
         pWLeIxNgn54D1+gMbyy1F7RMgBlxL2KzsNT03S/6LAdwed9RVhbrJlhD5HB5CvjDNtnn
         JCKTycmVdQXBN6o+7p6XugbzslhBB9zJMFPXkhN3oUnwHTOtU9IDAOjn8Sr2oAalsmlM
         GOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7vuUpogqSvc8cLlPB7IW3hqKwPWBq5Mgun+BSaMlLw=;
        b=oTQ5+VRIv7TsGezovZHAlzvqUfhKSmwWVVglas5m9wJBhqjyyhEq8dky4QHijTz/oY
         cIFPCtblQe+laUa/5OYX95jUo1ZOblG9cKAFZVPiEPUhtBIRCqxqfiZ3cQZODkeeGBDK
         Ow9KlrFk6HuBLzhqA9nv7JjFdHv3tJTr8CtTUFrTRzV7yWlAG+TKiuSYkTUa4QhlSxUZ
         fzdtRc+b73H6TXgaDpOfqdOlWT/1Yp1P2FoJaNSgN+rnR+DgWjW2kFIzgL2wNM6/e1lq
         QjFdD3VjGhMgUlJooFsPvhhGmx4v/Ka+BgJEgz97pU6Dqs+9jkcR9tKzYovh24o6GQhj
         IRWg==
X-Gm-Message-State: AOAM532ovqZ61XrkDuvUl2hJmq5NL/0qBTWiuPHCZAyYIJ/dY8hp7HF5
        A2tOFsKOXmm4FfnRS5djv/w=
X-Google-Smtp-Source: ABdhPJwHs670byDqv2itCPZCunBXFvXXqiYIiUgKjZc4TfevCPEg9J/JDUDFoKDFgxX7kbkl/J18tA==
X-Received: by 2002:a05:6e02:1d9e:: with SMTP id h30mr983586ila.214.1618453698370;
        Wed, 14 Apr 2021 19:28:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/13] sunrpc: provide transport info in the sysfs directory
Date:   Wed, 14 Apr 2021 22:28:01 -0400
Message-Id: <20210415022802.31692-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow to query transport's attributes. Currently showing following
fields of the rpc_xprt structure: state, last_used, cong, cwnd,
max_reqs, min_reqs, num_reqs, sizes of queues binding, sending,
pending, backlog.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 35d8109931cb..7a56e30b92c5 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -76,6 +76,56 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+	int locked, connected, connecting, close_wait, bound, binding,
+	    closing, congested, cwnd_wait, write_space;
+
+	if (!xprt)
+		return 0;
+
+	if (!xprt->state) {
+		ret = sprintf(buf, "state=CLOSED\n");
+	} else {
+		locked = test_bit(XPRT_LOCKED, &xprt->state);
+		connected = test_bit(XPRT_CONNECTED, &xprt->state);
+		connecting = test_bit(XPRT_CONNECTING, &xprt->state);
+		close_wait = test_bit(XPRT_CLOSE_WAIT, &xprt->state);
+		bound = test_bit(XPRT_BOUND, &xprt->state);
+		binding = test_bit(XPRT_BINDING, &xprt->state);
+		closing = test_bit(XPRT_CLOSING, &xprt->state);
+		congested = test_bit(XPRT_CONGESTED, &xprt->state);
+		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
+		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
+
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s\n",
+			      locked ? "LOCKED" : "",
+			      connected ? "CONNECTED" : "",
+			      connecting ? "CONNECTING" : "",
+			      close_wait ? "CLOSE_WAIT" : "",
+			      bound ? "BOUND" : "",
+			      binding ? "BOUNDING" : "",
+			      closing ? "CLOSING" : "",
+			      congested ? "CONGESTED" : "",
+			      cwnd_wait ? "CWND_WAIT" : "",
+			      write_space ? "WRITE_SPACE" : "");
+	}
+	ret += sprintf(buf + ret, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
+		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
+		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
+		       "backlog_q_len=%u", xprt->last_used, xprt->cong,
+		       xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
+		       xprt->num_reqs, xprt->binding.qlen, xprt->sending.qlen,
+		       xprt->pending.qlen, xprt->backlog.qlen);
+	buf[ret] = '\n';
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -175,8 +225,12 @@ static const void *rpc_sysfs_xprt_switch_xprt_namespace(struct kobject *kobj)
 static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
 
+static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
+	0444, rpc_sysfs_xprt_info_show, NULL);
+
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
+	&rpc_sysfs_xprt_info.attr,
 	NULL,
 };
 
-- 
2.27.0

