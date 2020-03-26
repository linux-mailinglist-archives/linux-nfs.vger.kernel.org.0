Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F399194238
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCZPAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 11:00:44 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46641 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZPAo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 11:00:44 -0400
Received: by mail-qv1-f67.google.com with SMTP id m2so3042126qvu.13;
        Thu, 26 Mar 2020 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ygcBKCp+0WYFKntXrF557PkaUGgSa7RUea/+BnXY+Iw=;
        b=ckfMy+ko331Di/eJBTkHXmfLrNLdygWBsFQhraRs0/LyxH5TD8fgmqSIiuYErtJVsO
         dlsDC63LpKE2+2ZgdnXbcdinQQ3NIDGlZuSYFZsZqyHbqno2zIc4+omk7XQyi+UBWGZr
         s7ub8Po32TP2jct/Ho2lloZpOaDs9FVFWPKdl7ddUCOhSc4SeviAi9ZVLS0M/TU6hNr8
         jTlPUui7rQ0vl4JsjEHMkB5jljzotlx/0lUQeva+e/2QK2H9yMFulV6mp7xi4Bla8Xdv
         pPOyqTi4VLPpXGUUCuOs9Iqgil20xOiDJPMMX0x4cPUGnsLV8Sz8tIEMyecp+Lza64Tw
         5MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ygcBKCp+0WYFKntXrF557PkaUGgSa7RUea/+BnXY+Iw=;
        b=fKeugFSzfnZZkM2EUakz/Q4uEfkdzwPuoFOE6Yar6QXIyY5Urn5Kg5PNwMC4/8OQ37
         ssopoajetF0kLGiTzI8itBdiIrnhCs0n47X2biXc9O6FIA09VvPVOWm1khKoGIW0YBWm
         5++v/Z4jNkcu0GYIDYaQwLbL83SkXQ2JjnJ+vIrw5yE2dCtyZqIwXKITnTDXYqbrIGTR
         mjJb2f/BcH7098ScGkYmW0yzXLr7gDVAw6dOK0fx2V89QfSNU4UqVNGkZjQqzG4q3EZO
         Bfc9C+0H+OcciCyzjfrj0rX8dkd3iLtpV2W4JgUiBux6Z9W2m4Oy3y0ROQw+mvZ2iFmz
         +iYg==
X-Gm-Message-State: ANhLgQ1yY1BVg09dIvi+iPauA6jC4VeuJBqGJsxpm6DZpxHixo3hU7S0
        YTJYG9B2KkBQ55WPRoqHp6LvsrQs
X-Google-Smtp-Source: ADFU+vvMhRwqEvLeWKqvwuAADPwYsLk6SdbMkdPfM6oevC4/8PJwgjJ+uLzkE+RD7Xfnz0R4cCAl0Q==
X-Received: by 2002:a0c:ec07:: with SMTP id y7mr8672795qvo.142.1585234841667;
        Thu, 26 Mar 2020 08:00:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w9sm1521587qkf.28.2020.03.26.08.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 08:00:41 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02QF0col001280;
        Thu, 26 Mar 2020 15:00:38 GMT
Subject: [PATCH] svcrdma: Fix leak of transport addresses
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 26 Mar 2020 11:00:38 -0400
Message-ID: <20200326145920.29379.46066.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-7-g1113
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Kernel memory leak detected:

unreferenced object 0xffff888849cdf480 (size 8):
  comm "kworker/u8:3", pid 2086, jiffies 4297898756 (age 4269.856s)
  hex dump (first 8 bytes):
    30 00 cd 49 88 88 ff ff                          0..I....
  backtrace:
    [<00000000acfc370b>] __kmalloc_track_caller+0x137/0x183
    [<00000000a2724354>] kstrdup+0x2b/0x43
    [<0000000082964f84>] xprt_rdma_format_addresses+0x114/0x17d [rpcrdma]
    [<00000000dfa6ed00>] xprt_setup_rdma_bc+0xc0/0x10c [rpcrdma]
    [<0000000073051a83>] xprt_create_transport+0x3f/0x1a0 [sunrpc]
    [<0000000053531a8e>] rpc_create+0x118/0x1cd [sunrpc]
    [<000000003a51b5f8>] setup_callback_client+0x1a5/0x27d [nfsd]
    [<000000001bd410af>] nfsd4_process_cb_update.isra.7+0x16c/0x1ac [nfsd]
    [<000000007f4bbd56>] nfsd4_run_cb_work+0x4c/0xbd [nfsd]
    [<0000000055c5586b>] process_one_work+0x1b2/0x2fe
    [<00000000b1e3e8ef>] worker_thread+0x1a6/0x25a
    [<000000005205fb78>] kthread+0xf6/0xfb
    [<000000006d2dc057>] ret_from_fork+0x3a/0x50

Introduce a call to xprt_rdma_free_addresses() similar to the way
that the TCP backchannel releases a transport's peer address
strings.

Fixes: 5d252f90a800 ("svcrdma: Add class for RDMA backwards direction transport")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    1 +
 1 file changed, 1 insertion(+)

Here's a possible fix for v5.7-rc.

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 46b59e91d34a..d510a3a15d4b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -252,6 +252,7 @@ xprt_rdma_bc_put(struct rpc_xprt *xprt)
 {
 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
 
+	xprt_rdma_free_addresses(xprt);
 	xprt_free(xprt);
 }
 

