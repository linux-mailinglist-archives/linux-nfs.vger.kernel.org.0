Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E192E9D84
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhADSzp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 13:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADSzp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 13:55:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC44C061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 10:55:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so33202377wrj.7
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1otDMgFPebVJmYJRuHWeGNLRattHSi5SvhI1pyE0M0o=;
        b=F2JL/XNw23JKTd+ProC/q3bvMny/UTOJItn0/WlmlJ6iGDjIds20ax1D4GxQRjp5BF
         8EJ1yPCXlLbFun3EaQUME5o9QbcoJBVI8CmW0Glp9qHGE+0Sa0qkdPASPO/pEkqEsSyd
         Eh/aIIVq8qw5EDnlY1/mrmhTXYJngxd2O0YX+pjd+3cfARqMfhWmxPFiYLsh0N7kVGPf
         U8j8kTZgMrWwxye5fyZdhF/x3YecsQc5RpTAXvEse36JsenL4KAI9YK+L4vw7iGXHuvt
         vLq4dKjGnUg4BcErKJjIg+E04kxnnA5v9yoDO70kUDYC3Rekz6lX8KVnb48OaaVw621L
         G/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1otDMgFPebVJmYJRuHWeGNLRattHSi5SvhI1pyE0M0o=;
        b=oEqSJJOQkfYC5eqcQkUVQSQ1YpF3CjxtMRinOV4+xkpmfCxI+ybl9U2Z+8Jm4jnMIg
         SjSPGm9GQACkDsiEJEti7Nl3cZkU9tADRhMZ0IUCvBtKQrH9UvssOAgrakYNKWwnIaoO
         rbYHo8pPD/tTWzzYDRp6fK6hfJo7+9yYTgvKDqDEbb7DC102Y4vqHdfT+zbZ2aezE78m
         h35Nq36ZCSLOhvbOpKxkLLO1Gks0ALCft8C+//5bSl7+ezPNfkqC+C8k5UdrtYxBsG11
         D6jOmtGOPWhqfnbLNPsuUIFtxNVgIzkcvjsl9h6vrab+9B/dVuvIIV5RKI7QNknr4yFP
         F1tg==
X-Gm-Message-State: AOAM531HFyFVz7bU2Ovrow8Z02LbAwWbspRmJboVHuZD6NMTIku2Rv9W
        7cf62nxcemJHvwUlU2caUppnOv32Zs4IXQ==
X-Google-Smtp-Source: ABdhPJxZhKK4YbjWiO6c6h6WgA7MTRwHDpcDSrhThyLB1R/PyTOh9EkOsFuEA7iXABv7l9nitAXNBQ==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr80177404wrx.7.1609786503865;
        Mon, 04 Jan 2021 10:55:03 -0800 (PST)
Received: from localhost (host81-153-154-190.range81-153.btcentralplus.com. [81.153.154.190])
        by smtp.gmail.com with ESMTPSA id x7sm370517wmi.11.2021.01.04.10.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 10:55:03 -0800 (PST)
From:   Hackintosh 5 <hackintoshfive@gmail.com>
X-Google-Original-From: Hackintosh 5 <git@hack5.dev>
To:     linux-nfs@vger.kernel.org
Cc:     Hackintosh 5 <git@hack5.dev>
Subject: [PATCH v2] systemd: rpc-statd-notify.service can run in the background
Date:   Mon,  4 Jan 2021 18:55:00 +0000
Message-Id: <20210104185500.4018-1-git@hack5.dev>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
References: <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allows rpc-statd-notify to run in the background when it is
only in use by a client. This is done by a timer unit with a one
second timeout, which is Wanted by nfs-client.target. The result
is that there is no longer a dependency on network-online.target
by multi-user.target, so everyone gets faster boot times yay.
---
 systemd/nfs-client.target      | 2 +-
 systemd/rpc-statd-notify.timer | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 systemd/rpc-statd-notify.timer

diff --git a/systemd/nfs-client.target b/systemd/nfs-client.target
index 8a8300a1..b7cce746 100644
--- a/systemd/nfs-client.target
+++ b/systemd/nfs-client.target
@@ -5,7 +5,7 @@ Wants=remote-fs-pre.target
 
 # Note: we don't "Wants=rpc-statd.service" as "mount.nfs" will arrange to
 # start that on demand if needed.
-Wants=rpc-statd-notify.service
+Wants=rpc-statd-notify.timer
 
 # GSS services dependencies and ordering
 Wants=auth-rpcgss-module.service
diff --git a/systemd/rpc-statd-notify.timer b/systemd/rpc-statd-notify.timer
new file mode 100644
index 00000000..bac68817
--- /dev/null
+++ b/systemd/rpc-statd-notify.timer
@@ -0,0 +1,9 @@
+[Unit]
+Description=Notify NFS peers of a restart
+RefuseManualStart=true
+RefuseManualStop=true
+
+[Timer]
+OnActiveSec=1
+Unit=rpc-statd-notify.service
+RemainAfterElapse=false
-- 
2.29.2

