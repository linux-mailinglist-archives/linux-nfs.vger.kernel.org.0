Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411ADB265F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfIMUBL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 16:01:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38796 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUBK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Sep 2019 16:01:10 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so39975221iol.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2019 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ccIHo0l+h/xU5pctdAqH+Q/HxDOFyp3Uz2vU7pPgKXo=;
        b=aHf5SlvL+woCI+gtDSE+xIBfrYkjUXAGZAh0QEizbz6YoNt+6xcbz3Ke2/sMHthIg0
         DR3IERAJq6Ag+C4CaCx1A7zUD0dPFOkDns6giilygZOwAVZZTRpbxfA5JQdWurB0n/FS
         zePgJtNlrdDME8ALOzOWqQHxDPCLXSnghRZxvh8+C9oQUC8YkevLTS63YdAtT5846HZD
         JPVUejASWG68SmARwNfFfuUyt6jREgvYpdrOfoOTBbMdcxi3VhXCwl4Czsy+3anRQNSF
         s9wZ9XuNbzzMEqZeZ8Or/wM/4EZiy7xeNrgJAHC2zhFCKG/oOPo/5dD/Az+pi/fYryo9
         dokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ccIHo0l+h/xU5pctdAqH+Q/HxDOFyp3Uz2vU7pPgKXo=;
        b=qITZt65aJcLIkxA5LrxyiDWdBSpWTQylUEn6pni37D6q54Z0kbRvErkIEpFeI3tcyb
         snKSoHoeY1hqEpcJFg0WNAAdOXme5ZlRfmcfJGqEi25b+MMxJt/4pZJqwxhUHPcm0pkq
         +/ZBJ1nAtQMwW+WtAqrpE9OJomN5Ii7HjXEr1Jk4GIvASKbdvgg1hnrJc9TxzvIhk18v
         fUPGAmQ0ApN1CLj7bQyXBTAvFjb7+1iu2UBIJZsucru8uZh0V7orI5JYKgGT4Rgl3au9
         5E96ZGcze0HMMbbCse8+5CIFmdNOwEdP/RdxOCD984Kf3mzFoXfJbIG5hxlLADPkJTb2
         wUFQ==
X-Gm-Message-State: APjAAAX80l0tYoETc5hSF/6yWsO8TnrPBDVVvezdk2OkL+BDSP89M8mw
        BDnGBbuJexOrZeLnuoMuXHjf2IUE
X-Google-Smtp-Source: APXvYqwUJUCEZYbAOYt0KE8OG9YARtNPaLkMDymnKyra+x2zwqTbDXamFBDPaASPL6fsZDhm/RtYLQ==
X-Received: by 2002:a6b:3ed4:: with SMTP id l203mr1796835ioa.275.1568404869681;
        Fri, 13 Sep 2019 13:01:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k6sm20286278ioh.28.2019.09.13.13.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 13:01:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x8DK17QV017642;
        Fri, 13 Sep 2019 20:01:07 GMT
Subject: [PATCH] SUNRPC: Fix congestion window race with disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Sep 2019 16:01:07 -0400
Message-ID: <20190913195959.2400.92744.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the congestion window closes just as the transport disconnects,
a reconnect is never driven because:

1. The XPRT_CONG_WAIT flag prevents tasks from taking the write lock
2. There's no wake-up of the first task on the xprt->sending queue

To address this, clear the congestion wait flag as part of
completing a disconnect.

Fixes: 75891f502f5f ("SUNRPC: Support for congestion control ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprt.c |    7 +++++++
 1 file changed, 7 insertions(+)

Hi Anna, Trond -

Please consider including this fix in next week's merge window.
Thanks!


diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2e71f54..0f94a3c 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -456,6 +456,12 @@ void xprt_release_rqst_cong(struct rpc_task *task)
 }
 EXPORT_SYMBOL_GPL(xprt_release_rqst_cong);
 
+static void xprt_clear_congestion_window_wait_locked(struct rpc_xprt *xprt)
+{
+	if (test_and_clear_bit(XPRT_CWND_WAIT, &xprt->state))
+		__xprt_lock_write_next_cong(xprt);
+}
+
 /*
  * Clear the congestion window wait flag and wake up the next
  * entry on xprt->sending
@@ -671,6 +677,7 @@ void xprt_disconnect_done(struct rpc_xprt *xprt)
 	spin_lock(&xprt->transport_lock);
 	xprt_clear_connected(xprt);
 	xprt_clear_write_space_locked(xprt);
+	xprt_clear_congestion_window_wait_locked(xprt);
 	xprt_wake_pending_tasks(xprt, -ENOTCONN);
 	spin_unlock(&xprt->transport_lock);
 }

