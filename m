Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB69A3A04E4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhFHUCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:02:48 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:36538 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhFHUCr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:02:47 -0400
Received: by mail-qv1-f46.google.com with SMTP id im10so10654295qvb.3
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8R5h9KiaQ7MVmdjI8tZwnReX9og5Ej1v5uXoHm/LsKk=;
        b=Rd69FDCmWP4um8UpZq96ddYpEr9mQ/p+4l2yXJhb8v0BNWYpyeholea3B6DQymKHcV
         FXEae5o/5VfkloAYHRszS3+5FURKGmrHDgILyYabGQ93HbYia/TUzL7VSspRwqM0ShjM
         58Oh+eZvOyzsufAsNpeqgEc2kB5sNttTN4l3ZHWPnA1o680iTpqj9rgylBAv++gVKkE1
         8fEgeD5JGRU3bYkeO1DeMLgR7Rb3oBWuCKDjYkU54EmzdQrfISj1mL9ee20drXtKH4ip
         IZGOZ3gFulpxxWQWLB4UXenBd6rVGOZzKVcexYIy7/RaojbM8NCZJVWBopXCnycPCksG
         SpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R5h9KiaQ7MVmdjI8tZwnReX9og5Ej1v5uXoHm/LsKk=;
        b=ZTgE37K3H/D+FbIB7sHUpapmk4vaQ9Znom8fVIYnt0KcSJ8JdHslEEZkJ2zb6FvCWr
         yNXfLBA3fQ/xwZCGMs8MmL80rCJy38d8JFf7IU9hM83Lt7SfEJ2TJKbnHwuYFaKbgjAV
         IROIzaqAtBVngA1bPyhPrKhN16yhZBoqE+F3mgs99F23o8TDgK+jrxSSXsSyjg8Ej5/K
         P7JBc1p41OmYequXC9FRBan7lkSzHDWAf6hP4P8ieG7TPTFgk4rc4lHXAjavEdTryqV4
         4dDUvvYc69ZxOZgwQFxR+vCUR6puvtdNzHbKsc/UcCW7MJMA0irLAPk/7nHPxa9Gp1OH
         z+cA==
X-Gm-Message-State: AOAM533w7V5V3S4XW6ndMzdaPo4uge51+GfZUzapmH/aMwqsf6AIEvYm
        lHoNbS7r2S82H48pTKU7UditCjQb/W0=
X-Google-Smtp-Source: ABdhPJz9BvEnvoPOMedDMT9X33A/ukArW1twf4/lIP1JsYJQw+/1CS+9I1KWlATmtASZyLV6h+zNEw==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr1944278qvi.44.1623182382102;
        Tue, 08 Jun 2021 12:59:42 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 13/13] sunrpc: provide showing transport's state info in the sysfs directory
Date:   Tue,  8 Jun 2021 15:59:22 -0400
Message-Id: <20210608195922.88655-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In preparation of being able to change the xprt's state, add a way
to show currect state of the transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index b3bc76bbc2a0..2fbaba27d5c6 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -111,6 +111,49 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	return ret + 1;
 }
 
+static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
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
+
+	xprt_put(xprt);
+	return ret + 1;
+}
+
 static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 					       struct kobj_attribute *attr,
 					       char *buf)
@@ -255,9 +298,13 @@ static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
 static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
+static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
+	0644, rpc_sysfs_xprt_state_show, NULL);
+
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
 	&rpc_sysfs_xprt_info.attr,
+	&rpc_sysfs_xprt_change_state.attr,
 	NULL,
 };
 
-- 
2.27.0

