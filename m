Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14D4872C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFQPbh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:31:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42901 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPbg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:31:36 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so22043704ior.9;
        Mon, 17 Jun 2019 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=Kg3Dm9z2UxJtjJKWi/p0ufBExWWCOVBfWhCvzhR1IPwaaO/xqQoOxI9csek0UjZaxq
         +OLC/FFUbRB0kLchd4jnKGHhLpbBzCORaGI72VFi519G0SqQZlr2EmPjKH1Q/EFy67Hl
         vhSrAdk3qBCOLI7DoKRqVXT4KYUaOwgJt1rYqwPSrKHg/X/f1TuDQLS3+x+UGlD2ZLRO
         vjiM+3V6fipkGnL1OBw7V/2wRpknv7JqVTaj2YzE4VP06XeTmK0Pgcp5jpKhdqO4sTg8
         AV6/R3TVCbQJzhF5YP3pvQaFlUu5NrAEORrmKxcUtyvAE4RmBsgJlhE5rWuAKFyp54wf
         rQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=Qpit6uEmCEGH1zk1DVCNGVyMTxlhTUTTortrzIzmBjObcP5lhPFxxNkoDj3WDB9iNJ
         jpYFeJZ8Z0B4tyoJQGKHGCKtSp6EckKag/KMERJYsNtwcwxopYJ/0IshV5XAl7A+CgMY
         PCBq2/l7Rqf/9KxpDFP7+okpCuRwmzRvpPYIuAuwHiZnVDXb7XWJ3pFXMdS11ug87mNk
         xnA4W0prjrZDtFVPALOPkxXE3/IMmusr0qpEZJa1AOr3q10eAEiMPjRlI7E+0WpqoKl2
         cHxBcNWP2+Hzfig0q35nqBiJOlfsMR5y5iXHaYfIR2rK5n8LPBBUE+96zsZ6WD2GYfgP
         qT7A==
X-Gm-Message-State: APjAAAXZXFEuqpmFYIIB4LLfTktwNrw/cwrIJmr52jb55vn55GRE5nXD
        4dXnq67nWp0jEvUhFQ05V3s=
X-Google-Smtp-Source: APXvYqxKJTYQe4VMePbMFkWX7UEgvQgf59CD4DAeZlTTz0i1JtMVct8f73DNXn+FSuchEu93Z5jtpQ==
X-Received: by 2002:a02:b016:: with SMTP id p22mr36231186jah.121.1560785496139;
        Mon, 17 Jun 2019 08:31:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x13sm9364594ioj.18.2019.06.17.08.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:31:35 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFVYFD031188;
        Mon, 17 Jun 2019 15:31:34 GMT
Subject: [PATCH v3 01/19] xprtrdma: Fix a BUG when tracing is enabled with
 NFSv4.1 on RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:31:34 -0400
Message-ID: <20190617153134.12090.89845.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A backchannel reply does not set task->tk_client.

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index df9851cb..f0678e3 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -559,7 +559,8 @@
 		const struct rpc_rqst *rqst = &req->rl_slot;
 
 		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->client_id = rqst->rq_task->tk_client ?
+				     rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->req = req;
 		__entry->num_sge = req->rl_sendctx->sc_wr.num_sge;
 		__entry->signaled = req->rl_sendctx->sc_wr.send_flags &

