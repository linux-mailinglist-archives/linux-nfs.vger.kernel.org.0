Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968152F21FF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbhAKVm1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAKVm1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:42:27 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC421C061794
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:46 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 81so25656ioc.13
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5liZYq4WMP3PzOsZBtOQnvuU8+oGFgGBRuz1trokjI=;
        b=g2wIJhKnP7d+lMouvkFMwcicgLwJmUgkU93JdC6CodP1QfxsijQQXvyQRNZ6yohd6k
         cQQDcan7jkg3SLQc8EpPdNTvwoKg1AHKbgAdewSv79dZJrkj5VOCXEMYvyYmw3txGsgF
         zShvVe5Asf/285n2ftI3g/W2yk66uyUDJlHUIsnEBmeuhqJxtcLYPaTb54lwIEeNvTn6
         u8KaaLIrSEh9Tu09/jaIhGLIyzmqiZvc0HLV9yT/G5oEfKjlVI2OkH4xxcGpUkhWyu80
         k4aelI0qh5wbWIvUzqVIz34+PjWL3lfERAeNwtRs6SOo40viNK5w+PiASpf2Zmvdgysi
         nGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b5liZYq4WMP3PzOsZBtOQnvuU8+oGFgGBRuz1trokjI=;
        b=RcC/8P6EdhtPyt2feLPDrJACBeqeeBokFROIbHZ8a7f563uhA/jQWniaM05rr8Me1u
         aOutZqb/dKAak3+ZJ2vIKNlPWIex7Mxyec2E9VtceSdTxq7GjUSBzI46oLaEjWB+xBS4
         GG7rvYFZBSNN5+SC9LPUVK86+ytXIt7j9nyaUkgaF9y7sDFASXDnzSUX/p5hiyDUP6Tx
         SqKHf0vBNAJF0bycZ7Mrv+GkvynvYvH52L6L0T8wGqjAbrxJXJLB5aGGcw7rY0zUK1vN
         msqrGVgs5DaI3fxstqjqMNJHxtX29QW91K484Z+F4iNrDZAJ8d0cnQxv3anIf1wFLVkr
         +8iw==
X-Gm-Message-State: AOAM532LZzIbFPPNyFLbyVVuyEh6wU2dtQJ7FfEwnHWcrbBQ861/BZCH
        gVjICYQnMClTqrqBRFf7Ady/DkBxgNc54w==
X-Google-Smtp-Source: ABdhPJzGotqXSFYP8amAq2P10hMq353I9Nw9n6WJXeMPyRPUbW0xrxjv9SBbcIT1wJ0oHtjhpSYuYg==
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr955810iok.171.1610401306106;
        Mon, 11 Jan 2021 13:41:46 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:45 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 1/7] net: Add a /sys/net directory to sysfs
Date:   Mon, 11 Jan 2021 16:41:37 -0500
Message-Id: <20210111214143.553479-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Sunrpc will want to place its files under this directory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/net/sock.h | 4 ++++
 net/socket.c       | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index bdc4323ce53c..cd986c6fbc6f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1765,6 +1765,10 @@ void sk_common_release(struct sock *sk);
 /* Initialise core socket variables */
 void sock_init_data(struct socket *sock, struct sock *sk);
 
+
+/* /sys/net */
+extern struct kobject *net_kobj;
+
 /*
  * Socket reference counting postulates.
  *
diff --git a/net/socket.c b/net/socket.c
index 33e8b6c4e1d3..43986419d673 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -141,6 +141,10 @@ static void sock_show_fdinfo(struct seq_file *m, struct file *f)
 #define sock_show_fdinfo NULL
 #endif
 
+/* /sys/net */
+struct kobject *net_kobj;
+EXPORT_SYMBOL_GPL(net_kobj);
+
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
  *	in the operation structures but are done directly via the socketcall() multiplexor.
@@ -3060,6 +3064,10 @@ static int __init sock_init(void)
 		goto out_mount;
 	}
 
+	net_kobj = kobject_create_and_add("net", NULL);
+	if (!net_kobj)
+		printk(KERN_WARNING "%s: kobj create error\n", __func__);
+
 	/* The real protocol initialization is performed in later initcalls.
 	 */
 
-- 
2.29.2

