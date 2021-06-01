Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9320F397C46
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhFAWLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhFAWLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E437C061574
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j184so440012qkd.6
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfOiM1XR9lNK6PSHgQIrMJNvgr1VyFeIIY2C6xQXnto=;
        b=rjJkqMezdC2uxfeyGAlmF+F24GAs/vOAf8P+wWuvL+I8u3DsgBCZgBMgUcseVXebqe
         oBI8KFPOsDByNGHsnddKI8FqFoYsn+gJaFLh3Y5YBCerfL2pAQRT/CAjvy4HuAuqYrJ1
         JLvnadxrqZniWRX7l+Nj6BIblNQSSai/HPTr40od38BoeoRCM9TRBkjDZe+uFsAOhPd8
         rpHX+DaxdmWTLu1lVRtu4AiL43LTGmj6TWDI/r0sa2SmwO5keRzvdMZXayhRD3inHNA7
         RSupXV+4n+M0FE4pB/4Q1Avn64Ed00JaGYeT2FHrZrfHste5eEX0F734eB7APpZsV8tP
         Sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfOiM1XR9lNK6PSHgQIrMJNvgr1VyFeIIY2C6xQXnto=;
        b=GkhfHJZz1rAc7Dvl/D0HcpsIjKakEx8zeEgy/QhEkskY9lzgYjqsuWJjU8LUnJcyun
         dvhLpWvykbMPjdNcrFX9xhhGTDsAynxZyrejPoKYdEMBwy+xmPJXQ1seN4XucDKFAE7I
         KSmeyMstQ7taVFGrcDuhlEPrQEnO+ZYY2Eo2axhKRJ/1pSE5/tgmqbQtDoOOPenXHfFE
         PryWCvL2Zdot+rORwjrVfZ7KRtgL1ckDBWen/K5SEacJNnY2/0BKwbx4fTNn5pP70frQ
         wviiAGwSS8fz1tMC93T/xc+enIHoW2+XB3bGEEjZIZTi8H0TV4mZIuyEj9P3TWrY3B+Z
         LFhg==
X-Gm-Message-State: AOAM5320mAYlmY4g7+cQunP27fviQpVf3+XtfnaOL79fj3iLnCGBgmfk
        k7AjXzbytM6RHTwrbWuQNqZXo7dRLUw=
X-Google-Smtp-Source: ABdhPJwqpPamXn3uO4nf/nuQ8qOleMJRyZvl3o9aA2ziTgr+SjM9E5NphTI7TqW/CZomq9bm0mF7hA==
X-Received: by 2002:a37:aa84:: with SMTP id t126mr914885qke.95.1622585391687;
        Tue, 01 Jun 2021 15:09:51 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 13/13] sunrpc: provide showing transport's state info in the sysfs directory
Date:   Tue,  1 Jun 2021 18:09:15 -0400
Message-Id: <20210601220915.18975-14-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
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
index db2ae28bd0c3..887123e0de1a 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -112,6 +112,49 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -250,9 +293,13 @@ static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
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

