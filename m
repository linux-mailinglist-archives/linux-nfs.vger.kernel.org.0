Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148F819B671
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgDATh4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 15:37:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44228 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgDAThz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Apr 2020 15:37:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id x16so1154078qts.11
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2020 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bMOoSDbiik8tuCzrQzumpxZbl0LyO5dkAMzsicEViig=;
        b=gfDacRK/lgkPo2GslN5gN6EG5pEA7d9G0NH1/xerqYxK3Y23RqJtKDNJQCHBwi5COR
         LMu5xXFeuQ/8/KXL/AVM+pVH65v6Xf7bdU7bYyquGhRCDKJeAKEasMhBu/7Rd4Zis+bD
         Q9xdhMeCaDF2svXZDpt+vXY5GlbTUepi1iDk2iuk+kuzgcOYdXNnxCg3aR04G4GcfySQ
         1XgeH/ZAvFR7dkNeB4g8tQJAasffSUW+c0C8/zy+xpzaZYnUOZyZmk9ThIGdR4PfH7PO
         Ko6plx+wgZbRAUp2VguV3Q9JmjYtfQdE4qj7f/JdlzfhkOH2iUdZVK2MmgFIFixaQGB4
         MEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bMOoSDbiik8tuCzrQzumpxZbl0LyO5dkAMzsicEViig=;
        b=Nf788vxqE7O92nwQBk749QI4k6u15MvlB08td+KvoB9fXZNSAl1/lrb8n0M1g1EuQG
         k3rexYwgGj/t8HgDtXyYCvpoKWckZ4HiC9HdU7+riI5cjEIRbpU5C2OITm2kPiAY8YnY
         0UEzH/Pwr/zoKcMt/2DaDq4ndafUveid72s59JkrEwEX7ThX4nUwGV80kq4KWENrBGmb
         +NrZSxQpEoEK+mNIIZj0+vFYDwFGAmC+y4uLRrpR679sred+NsDSgwfV1xn7k3lRP5Xf
         2CKcju2FZrm8koqMfoz2lvHQqgvuo5J54Ud8sR22qWLpvrN2SZYo9hJStqjvO7wUdA3q
         e+FQ==
X-Gm-Message-State: ANhLgQ08k1mH9HOO4NHVIAEUuh/DriDPloAa22NMkO5nijN1zzsWRQFJ
        Rh2EAyhVm9JzXOh/ltXp4mvvVdx8
X-Google-Smtp-Source: ADFU+vvMhUvH/xRf2Q0RnoGtwuSbcbuXuP9ckyXDLJqEzxV0b5Mp1O+BN2rXEMTQAGdtqI3DGpdxig==
X-Received: by 2002:ac8:1c72:: with SMTP id j47mr12382339qtk.377.1585769872807;
        Wed, 01 Apr 2020 12:37:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b189sm2030488qkc.104.2020.04.01.12.37.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 12:37:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 031JbosK022639
        for <linux-nfs@vger.kernel.org>; Wed, 1 Apr 2020 19:37:50 GMT
Subject: [PATCH RFC] sunrpc: Ensure signalled RPC tasks exit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 01 Apr 2020 15:37:50 -0400
Message-ID: <20200401193559.6487.55107.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If an RPC task is signaled while it is running and the transport is
not connected, it will never sleep and never be terminated. This can
happen when a RPC transport is shut down: the remaining tasks are
signalled, but the transport is disconnected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/sched.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Interested in comments and suggestions.

Nearly every time my NFS/RDMA client unmounts when using krb5, the
umount hangs (killably). I tracked it down to an NFSv3 NULL request
that is signalled but loops and does not exit.


diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 55e900255b0c..905c31f75593 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -905,6 +905,12 @@ static void __rpc_execute(struct rpc_task *task)
 		trace_rpc_task_run_action(task, do_action);
 		do_action(task);
 
+		if (RPC_SIGNALLED(task)) {
+			task->tk_rpc_status = -ERESTARTSYS;
+			rpc_exit(task, -ERESTARTSYS);
+			break;
+		}
+
 		/*
 		 * Lockless check for whether task is sleeping or not.
 		 */
@@ -912,14 +918,6 @@ static void __rpc_execute(struct rpc_task *task)
 			continue;
 
 		/*
-		 * Signalled tasks should exit rather than sleep.
-		 */
-		if (RPC_SIGNALLED(task)) {
-			task->tk_rpc_status = -ERESTARTSYS;
-			rpc_exit(task, -ERESTARTSYS);
-		}
-
-		/*
 		 * The queue->lock protects against races with
 		 * rpc_make_runnable().
 		 *

