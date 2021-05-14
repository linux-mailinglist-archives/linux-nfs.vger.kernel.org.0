Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1663380B48
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhENOOu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhENOOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128EC061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j30so4043009ila.5
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSus4G4n3nhSZZZ+VOrB2hmd5cf0+6NDHfZUH1eQibw=;
        b=vSui/E573R38WT92MGW8yy4LCq5aIp3Ad7xUoWGoUyd2wvymmzChjHcJZ9I1aN+6T1
         WJbgaLs7MfnIC/zsI3okGfd5x9fsvsI6Bt8jS69uHx6V4z142b2MD53dJehfQsA7zwb3
         dCOPujEdiOqvfWwia/j46uv1MkT9gl+QOA8AqJwjt1qP+Us1AN/eo6ROtz0HPm5OAsPh
         y0pJElmSfXpu0h18UzBEN7by6ZjMLJqlmw3Fia2/rQMTRSa062Z+DTByHLkMx1BdniPT
         FhJSR4Ls/jMQvvG7M/mEMvTRTMdNwF28rKtUKMg3hs0p9r6rIHQHM0djC8UYyHRpiA9g
         zyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSus4G4n3nhSZZZ+VOrB2hmd5cf0+6NDHfZUH1eQibw=;
        b=rtjMBXoPlSTqx6KKiTPoIJmIvlbB+S7snppH+vnaBowp4tdAVeMHGW/UFztc/asAmL
         OJjk5HurSOh07BCj7O0Urt2lxH7KFoyqHX8BS5MNJHzhoDQVSfzzELtFvK7bsV6t7i24
         X7hszIXwucEAXccoptI9SpDg3Zmtfp9bP3jI+YUgxfZMPRQTA5OhQS9TumuPEg3+z9JX
         4MBrH6LVG8sMhOuvEeQ9y5i59OPxQ68FlIU/RAi+I8+UCmiYa5/vHklmwby3QpNfH66g
         anRglc2s55lPUzQaeXtFMnctJB6JiKwI2qWkga9fWtFGfMN8Z4s/cVNK0AJeGEaOj7At
         wNow==
X-Gm-Message-State: AOAM5310l0SLifyhnzNfTUc8c4y+30skeovG6qeLeKiQSP5jghkTGuhz
        UlWdPT9t7O0WVegWOpq4zqg=
X-Google-Smtp-Source: ABdhPJzCrj9kJ3G4PpUZVTvbPLg9QP00644OvzujhmtYmE8YdakfofYwJ5nP+PMZg73IJO7MgLMSBw==
X-Received: by 2002:a92:700a:: with SMTP id l10mr3612607ilc.44.1621001617122;
        Fri, 14 May 2021 07:13:37 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:36 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 11/12] sunrpc: provide transport info in the sysfs directory
Date:   Fri, 14 May 2021 10:13:22 -0400
Message-Id: <20210514141323.67922-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index f330148433c8..f1936effa5a0 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -82,6 +82,55 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
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
+		       "backlog_q_len=%u\n", xprt->last_used, xprt->cong,
+		       xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
+		       xprt->num_reqs, xprt->binding.qlen, xprt->sending.qlen,
+		       xprt->pending.qlen, xprt->backlog.qlen);
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -200,8 +249,12 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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

