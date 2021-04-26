Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA936B800
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhDZRU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbhDZRUp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:45 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF1C061344
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:03 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r5so7031475ilb.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0zi+heu8E83aReBPxZ9EasqAnPbQehN+00ecDk1Hp8=;
        b=UlgFH/elLK5IXBICKd9Ubp6cc65wa+gRH01Af6r1Jhyf+ZFDqJe3IXd1F3ndDCg3SR
         Rqm5nMJ0+3ShKuECW13v0LHZ44gzmFQXDiJCIAosQyo9TPQcIpKesfPz+0xUSZzajT+4
         WhbF2oOzNMoOKA3nCufa5IEYD7Sh44QcP6KujIyLbUWeZ0HnFZgjPtBPzg4/Pjffo9VN
         HUaxtLZ78WUj7+zLD4mRLHdI1+7qWayGR2Q3KCQcpBH/WEAkIQl+teK0X6K89a+4yLM3
         rAWWig6M4QCA9sYsWVwjrx6MK8Mr002eaBS1S3hopdkhGb4Ee/I4PCaCE95TsmGdG2Jo
         yNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0zi+heu8E83aReBPxZ9EasqAnPbQehN+00ecDk1Hp8=;
        b=LHbcaoxtu3S1fQO7Qe62LprwEJ6d9+BC1xkxWxi0EvSUdeLjSczURZuWgWRUdI5tzM
         aszxDM2SWnhR4vLcxAmycslvlzcQptpj3QjyJcGudZCcOnKU7QMqL0MqXIqv0YBRQroY
         UVygbQZBVyORq12cugZgpdJqc7Q0CBenhGGFs2jj9BybSQrOmP1BAxYcx0nRphqdUqkI
         BJ60tevxQ10V80vLywDR0XB7usrE8oCbwMYU+hRN8/kczGmC9kzLwqBrCGOKP0ILPBOT
         Fvn+9K5m9BYv6zSFwsHp1T2ny0i1ljyYWZYaJug8f9FdM3qMHbffnrwAvuORSxIGIpFY
         XtBQ==
X-Gm-Message-State: AOAM530ktjD4q7emBSESc9kUwdDUmtgP+WVMYuStLOSnrt4E19lBA/cM
        zPiZBD45t5FnLutuBC3ScYw=
X-Google-Smtp-Source: ABdhPJwPp3CcIny9pLkYmBXA36rdMuW+kSuTb2l/yEa+K2v6t2ESACfnjH/2cnRxmGxLocnuSGGppA==
X-Received: by 2002:a92:d383:: with SMTP id o3mr14501636ilo.131.1619457603305;
        Mon, 26 Apr 2021 10:20:03 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:20:02 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 12/13] sunrpc: provide transport info in the sysfs directory
Date:   Mon, 26 Apr 2021 13:19:46 -0400
Message-Id: <20210426171947.99233-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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
index 076f777db3cd..93d4111f6ee3 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -72,6 +72,56 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
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
@@ -171,8 +221,12 @@ static const void *rpc_sysfs_xprt_switch_xprt_namespace(struct kobject *kobj)
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

