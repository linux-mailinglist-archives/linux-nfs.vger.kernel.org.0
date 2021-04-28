Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD98D36E0FE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhD1VdI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhD1VdH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D61C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i12so33636744qke.3
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0SMbaDJ8a0kqyaBonauxqdv5qcnDIjixu1ZO1KpXNc=;
        b=nXld/Sv2NpX4W4882PWk6sgk/tQy3dfGCKO36qTxXp2M4CRxJ4izWm08/ZmVMESNwy
         idSTxRUmlFOdWbpb1Lq98hVOg3MCzNqSpB+Pk4+9RLcQNdTqjqpVBFJ/bxx29WGivaBa
         Pa/5yg9i36xxUa1byEuR9fP2a8ioK6Y3Z2FPcJBQVDY2jphNsNJfrmTg0/nYI5T+RsaD
         2hnFvd8jebGQeXa/PU7XDV4uiTKThvb7xVDjstfR6cVYmki2+1Rb127uKB8M6lGv8CUm
         7df8//tXTgsXK2r8t+dnyjTRpSRwOQwvmAxN61lKND2lOg6vTTsVTuVH0E7vw7yDfe2k
         DLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0SMbaDJ8a0kqyaBonauxqdv5qcnDIjixu1ZO1KpXNc=;
        b=XGxAFb5avYGxlEaXlU5BQRfcEZ2XIHfwISYOjYl7Neud4dKFGgQ+boToDQEhMJ7Chn
         MxWrOtkJ6twJnHk99/RE2DPBsaLuA8C0OBhBgQCDIJz+wE2sRYQFWiJOKOzL0ND03YhK
         4rdaHSnBdvfnUGrlG7Tnbnfl+F30iFhU6iMYHToLzet2DUULW6Mqhr94UaY1nh5AO5NO
         7tllOUcYXvfGJiS/ucU3tRh9ywQUxmvTqiy1WVuNHKtH4NET8vgPmfgu1efhlYkL5ehJ
         QDCBXeW8um27PqjN0edZl5ReuYTuTNXrqIMPjpkacojImBRF2WLfR/wtcWQLzX6d1r9f
         7lAQ==
X-Gm-Message-State: AOAM531vgMSJlfijAnZqjOvASScysY1lLGgXzhCIQ5fMvUhCC4xYXGQ+
        bZzblUfIZ+0VTr7U22dI9Eo=
X-Google-Smtp-Source: ABdhPJyblJPPJDQZZaIiNHqZ7gL2teuKDhjPCjSiSWTE1uPY79dD8l8ZHBLzztT28cKj7AjDNABzLQ==
X-Received: by 2002:a37:a597:: with SMTP id o145mr19537356qke.265.1619645541131;
        Wed, 28 Apr 2021 14:32:21 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 12/13] sunrpc: provide transport info in the sysfs directory
Date:   Wed, 28 Apr 2021 17:32:02 -0400
Message-Id: <20210428213203.40059-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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
index 234e545a7a40..4febc7008dc0 100644
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
@@ -188,8 +237,12 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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

