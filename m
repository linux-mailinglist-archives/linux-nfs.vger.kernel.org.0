Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55807342045
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhCSOzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCSOym (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 10:54:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9277DC061760
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 07:54:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so10183403ejj.7
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5LxGSvdfhBgXA9/vt7weVi24/gBgmdo0yCkTsbvOMGc=;
        b=AvJykrTH2Q44dpunvZa1TDAqcTF5a0NtpEThBnr1wBPHPuTspGC5HDdIqCCEJ+fokA
         Xi55RMx6aUe4J1++O2Rnaoalh6UakUG6JzXhyBD1i7Qm4zDuTJIU/jqriGuCpDzUQXkB
         LYT3HKtI7z9i8QQ7GCwA6S1NjrqE/uQjrhYIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5LxGSvdfhBgXA9/vt7weVi24/gBgmdo0yCkTsbvOMGc=;
        b=d0LY12jl5LYkzkUk0dFixe/QDvjaYdD+fa7ZavbuKwmoC21crNSM5qf7jkdXR0XX4X
         HrycKjivWfsUS3W/EnELdVz/fcr0FrPQJ0+V1yRwyJEgDFxH+a8Lmz8H/8Q4IEgqc+2c
         I9SGdjpZ/lh/T4IvkOcs/4hujk80EWgTpuH/IULZm1tHK2HSXqxl9s430MYMEvO0fnB6
         /7sRoYWq+DqAa4YI8ivjsRHvarzD2bAdn36cEeqOt4seJmhsl3GCKMwaE1HgxoYKqW7x
         g6yqbybFUjnLEuUKJVQSMa3t6+LR+FkoJVOB49hR5F5Qib6a/RarlgUfNPvluq3i69no
         +DLQ==
X-Gm-Message-State: AOAM530f3QI+bX05Y0db3bd5YjQw86m/G8A8y/oeWrzmOPp2feQnXCeN
        cbtxyuIZaGe1ZE4ILcV3D5KaUu5NaJlmlH1q
X-Google-Smtp-Source: ABdhPJwOUSsvj1QWMXnRmoiI1EgyWCffsISxRsq0qGqvSx5cdsMAN/7ljirdZjieocGKqWVCBMZGZQ==
X-Received: by 2002:a17:906:71d3:: with SMTP id i19mr4867632ejk.347.1616165679905;
        Fri, 19 Mar 2021 07:54:39 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id r17sm4127977edt.70.2021.03.19.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:54:39 -0700 (PDT)
Date:   Fri, 19 Mar 2021 14:54:39 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-nfs@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] SUNRPC: Output oversized frag reclen as ASCII if printable
Message-ID: <YFS7L4FIQBDtIY9d@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The reclen is taken directly from the first four bytes of the message
with the highest bit stripped, which makes it ripe for protocol mixups.
For example, if someone tries to send a HTTP GET request to us, we'll
interpret it as a 1195725856-sized fragment (ie. (u32)'GET '), and print
a ratelimited KERN_NOTICE with that number verbatim.

This can be confusing for downstream users, who don't know what messages
like "fragment too large: 1195725856" actually mean, or that they
indicate some misconfigured infrastructure elsewhere.

To allow users to more easily understand and debug these cases, add the
number interpreted as ASCII if all characters are printable:

    RPC: fragment too large: 1195725856 (ASCII "GET ")

If demand grows elsewhere, a new printk format that takes a number and
outputs it in various formats is also a possible solution. For now, it
seems reasonable to put this here since this particular code path is the
one that has repeatedly come up in production.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: J. Bruce Fields <bfields@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: David S. Miller <davem@davemloft.net>
---
 net/sunrpc/svcsock.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2e2f007dfc9f..046b1d104340 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -46,6 +46,7 @@
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <asm/ioctls.h>
+#include <linux/ctype.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/clnt.h>
@@ -863,6 +864,34 @@ static void svc_tcp_clear_pages(struct svc_sock *svsk)
 	svsk->sk_datalen = 0;
 }
 
+/* The reclen is taken directly from the first four bytes of the message with
+ * the highest bit stripped, which makes it ripe for protocol mixups. For
+ * example, if someone tries to send a HTTP GET request to us, we'll interpret
+ * it as a 1195725856-sized fragment (ie. (u32)'GET '), and print a ratelimited
+ * KERN_NOTICE with that number verbatim.
+ *
+ * To allow users to more easily understand and debug these cases, this
+ * function decodes the purported length as ASCII, and returns it if all
+ * characters were printable. Otherwise, we return NULL.
+ *
+ * WARNING: Since we reuse the u32 directly, the return value is not null
+ * terminated, and must be printed using %.*s with
+ * sizeof(svc_sock_reclen(svsk)).
+ */
+static char *svc_sock_reclen_ascii(struct svc_sock *svsk)
+{
+	u32 len_be = cpu_to_be32(svc_sock_reclen(svsk));
+	char *len_be_ascii = (char *)&len_be;
+	size_t i;
+
+	for (i = 0; i < sizeof(len_be); i++) {
+		if (!isprint(len_be_ascii[i]))
+			return NULL;
+	}
+
+	return len_be_ascii;
+}
+
 /*
  * Receive fragment record header into sk_marker.
  */
@@ -870,6 +899,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 				   struct svc_rqst *rqstp)
 {
 	ssize_t want, len;
+	char *reclen_ascii;
 
 	/* If we haven't gotten the record length yet,
 	 * get the next four bytes.
@@ -898,9 +928,14 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 	return svc_sock_reclen(svsk);
 
 err_too_large:
-	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d\n",
+	reclen_ascii = svc_sock_reclen_ascii(svsk);
+	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d%s%.*s%s\n",
 			       __func__, svsk->sk_xprt.xpt_server->sv_name,
-			       svc_sock_reclen(svsk));
+			       svc_sock_reclen(svsk),
+			       reclen_ascii ? " (ASCII \"" : "",
+			       (int)sizeof(u32),
+			       reclen_ascii ?: "",
+			       reclen_ascii ? "\")" : "");
 	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
 err_short:
 	return -EAGAIN;
-- 
2.30.2

