Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69048B0E93
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfILMJB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 08:09:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45382 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbfILMJB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 08:09:01 -0400
Received: by mail-io1-f68.google.com with SMTP id f12so53798738iog.12
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8ZixN+k2MPi6o7J+EFSTvWu1Ymp0kkCai84UaRmYPI=;
        b=A29JJOW+MsS/4OdwRehgGqOBLyw2vZARj9DVZtiTS87d6Dq/JatbG5iXxGZEdfJaA1
         EL6TyIIrlZjrdzUgPBNGopiAttCz83EABjzYml3FUQmns26nhL+2dBZCyDjB/5FJA1Ef
         z7h/FfsAGpY7SFvMVWGlYNkxWpu+rnOfJZ6GRBFcgEOe+ZeANtL8qm9rbRkJtm+TNye3
         qR+GZuI5BtBTuf+hTXCaN5yp9MR419DZxPWsMSb9dCtROC78zmCKIS8U7EElyVIxrto6
         dABlNp+zuZR1pUWH4zSsmL+Bj0OakyWr8zyvgG6DjQhFBOQxqwavEz1Oepk6WlbpgeCF
         9OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8ZixN+k2MPi6o7J+EFSTvWu1Ymp0kkCai84UaRmYPI=;
        b=meSxwaLpHpPpsYsZa704rQYKxETulwOmHlOIQFTpeQIrbI6nbrRb/qYuCY3leBIJba
         06+N8ve/tjSH+aGT8fMlKTjxYFQ1jUYfZ4JXaFcyBD8ZNFn7er32FvQtHCV6ZulUlq/P
         fbPedgQ3ZCMpqotVkh0vYVPNOA4cCCLJt38b13omWZ3XmUR3J8Oqx+wzktJOgGwOQZl1
         o332x6omDKQNWZNqi7Fm3HX5sZVEj7SFPW3JLzIYxJRYl/JcsRFj5O12ylfR7cQdM8qh
         ALuKbdt1VkBmBk0b7V3npZsMPcljEp3eMW0Wiso5NOJJ4yue8V55Ht8Goynhv8brBBC+
         VmTg==
X-Gm-Message-State: APjAAAXBmvhbl10sBSEFYOS0JRBG8x39Lg/uqHsa768IXKJZNmj88WCt
        cgvnldQMo6z60dKor8vTTih601CPJA==
X-Google-Smtp-Source: APXvYqylpqi+K/ezdaesnlGMb4V/XdAWO3r+7RP77ZDNgQXBOEn5RON2ALjbnflcqsXriITXU0kffg==
X-Received: by 2002:a6b:e903:: with SMTP id u3mr2192361iof.241.1568290140038;
        Thu, 12 Sep 2019 05:09:00 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h3sm16666370iol.73.2019.09.12.05.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 05:08:59 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: RPC level errors should always set task->tk_rpc_status
Date:   Thu, 12 Sep 2019 08:06:51 -0400
Message-Id: <20190912120651.11277-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we set task->tk_rpc_status for all RPC level errors so that
the caller can distinguish between those and server reply status errors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c  | 6 +++---
 net/sunrpc/sched.c | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7a75f34ad393..e7fdc400506e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1837,7 +1837,7 @@ call_allocate(struct rpc_task *task)
 		return;
 	}
 
-	rpc_exit(task, -ERESTARTSYS);
+	rpc_call_rpcerror(task, -ERESTARTSYS);
 }
 
 static int
@@ -2561,7 +2561,7 @@ rpc_encode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	return 0;
 out_fail:
 	trace_rpc_bad_callhdr(task);
-	rpc_exit(task, error);
+	rpc_call_rpcerror(task, error);
 	return error;
 }
 
@@ -2628,7 +2628,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 		return -EAGAIN;
 	}
 out_err:
-	rpc_exit(task, error);
+	rpc_call_rpcerror(task, error);
 	return error;
 
 out_unparsable:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 1f275aba786f..53934fe73a9d 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -930,8 +930,10 @@ static void __rpc_execute(struct rpc_task *task)
 		/*
 		 * Signalled tasks should exit rather than sleep.
 		 */
-		if (RPC_SIGNALLED(task))
+		if (RPC_SIGNALLED(task)) {
+			task->tk_rpc_status = -ERESTARTSYS;
 			rpc_exit(task, -ERESTARTSYS);
+		}
 
 		/*
 		 * The queue->lock protects against races with
@@ -967,6 +969,7 @@ static void __rpc_execute(struct rpc_task *task)
 			 */
 			dprintk("RPC: %5u got signal\n", task->tk_pid);
 			set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
+			task->tk_rpc_status = -ERESTARTSYS;
 			rpc_exit(task, -ERESTARTSYS);
 		}
 		dprintk("RPC: %5u sync task resuming\n", task->tk_pid);
-- 
2.21.0

