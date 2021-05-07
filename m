Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473DD3768B0
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhEGQ0y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbhEGQ0j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:39 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1FC061763
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:32 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i22so8117276ila.11
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXUG80a/XGscONnZgix+IyhnyZpueGk0RiTatBoGksg=;
        b=ZUZYhn9WwPpIcf/wGDPi+d1nPO2BPizVtnMGGxMA9Qy7fVhsYdLUSkC4o/1Pc7/ydd
         gAdolGFsBSD1p/yDjcKNNoZfmrbVnJvmLoIlExvWk1RDfNwd3oM+Z/eFu1RiUXnkjUAC
         RR5auueLI9+bFd5CYX6zfnpayeglvsZqIbgzvDymBkPIeIwtEf0MpBbk0TpESi01+05/
         w7FJJa+WHSHuLgtNm7ysvHXT2rXOS8zV1gLhlPbya1Xz63hRynp2Ph0lWCvXOhF2/u0W
         dC5R/mAMKdhU2UKSDPmvYnmlZJlQpU2KCRuSUY3Z81/ADRqJifHN1fBJsSNL/MV+r843
         8nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXUG80a/XGscONnZgix+IyhnyZpueGk0RiTatBoGksg=;
        b=Qbu4d5Z8hxzaJP5zwMrlW42ImR4G0pcG0NIlWzIZ65iJc03gK1bGx50qOM4/jRyeJA
         zPBL7m2GscRMugSxZljvc3Ggl1LWyVvy4txPPD8GpByoYNxzi4gffa2lxsEIJmRcYz9D
         8wk9db1LM1lmcztSrEDBQcbmr81YEMwyI9WxtV1TWXv64G5lgJOq46Eh/nq+xTR+YaYB
         p+2DtHB/nW20RFNhr8VOeTKlV6MQrfVZou4Wie9tarqFDJXqsJ63SvcDZ3vameU4GxEW
         4j44YdOJmdGEJ+dqyFPqX2XPOUI/+8RGZa238Xtc+ChdBPipPLH6lw+2n9HYPQ8a+wRm
         UlrA==
X-Gm-Message-State: AOAM531iRP8+v8OUbXhRakPVTqIqzLCa+6XwRT4QhJeo+8pKahra+mL2
        sZuyeZdPoypNnLX5P7YsO2tOr87hSglv+w==
X-Google-Smtp-Source: ABdhPJy2PLERdXhvK4mU1J7HiCmBThcXvnecq3BdOEr4WDo82yQ92QgO3vTFV4xrMxpt6kRVBztyyA==
X-Received: by 2002:a92:b111:: with SMTP id t17mr10338250ilh.208.1620404731948;
        Fri, 07 May 2021 09:25:31 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 11/12] sunrpc: provide transport info in the sysfs directory
Date:   Fri,  7 May 2021 12:25:17 -0400
Message-Id: <20210507162518.51520-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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
index a622a97c602d..785b5f4a4178 100644
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

