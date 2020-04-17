Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744081AE0D6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDQPPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPPn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Apr 2020 11:15:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0392C061A0C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 08:15:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so2691824qkc.11
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H2wogtu4IhaCEW6EMuS40p5PUHnjiSqx4hVd7AUf+ww=;
        b=UWFJHdK5t+u7Cabf2S+LkzlhalX7JQ1j2hSUuox8IyNfekcw0Q4jwgaAxIaVerRr54
         nkLHhlxMeG28oJOk/23LhRCreo+iVJmridC6IFvZUSXDNOzW9u9aLxyqdbQdHaBkrJEg
         hHTnTagR+7uU/ORtiLS8q5hIg5cfKOfuNPDXnke+R59NJLe6vQeqcrYlIK612uYQNFIu
         PFNF/f3Nnv+PAJMKEZud8j8O9zb/KxvqpEe7rD7dIbIIXJ09XzX9PXH5wOVgqPOJGg+0
         EfuPGrfArtFICmA+UOS0IbSvfl/1Z17OGCDkZlgMcTRjgyWmAGr/g6RdxbzS545hF67d
         /lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2wogtu4IhaCEW6EMuS40p5PUHnjiSqx4hVd7AUf+ww=;
        b=PZWckJpfq550FAOxO6sS98G/elauEGEu1S18PFbu0dpSqkIkaiogow6O+5TmFX/a1l
         KH9FJphmhjBGGPk7hmRJ2VLgf+axxqTQ8n/ypmX8GPcOuLpuzfVMuu6F3nlmyga4Vxqw
         ojNsb+Cx42X9QDBIq3MYg9y7SglSiE6x0ToIKSoH7eVuuhKDjqVyx9wcQWH+WPniSIOB
         E8pE25eq2sbXn3wRLlokkJnSu3BubkGWm99eaSxWUVQovoRKnWchjKiLSoAyf38jh9Xm
         /Lp0dS3WAGnWqGJ3bZagf3Ez/brjRLZOwphC99CkluX6+P9AcTT8SyBClpkxXDQA2DSd
         ERLg==
X-Gm-Message-State: AGi0PuaUiDYqOepj/8wSVeNLfl+JHXUZfpAZzTqZQhe1eatj3kwL2mPl
        ZlMKXXRFXzqJd4PDjjhwNJLmQ/PB
X-Google-Smtp-Source: APiQypJGz0NMMqvoId+nRCJ68wb+dHC7bZR6OH8tIzYKLVixEba9D1/3EqUxadV5hhuHpFx3dnsSwQ==
X-Received: by 2002:a37:6754:: with SMTP id b81mr3679566qkc.129.1587136542044;
        Fri, 17 Apr 2020 08:15:42 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id q17sm7150738qtk.84.2020.04.17.08.15.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 17 Apr 2020 08:15:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Date:   Fri, 17 Apr 2020 11:15:40 -0400
Message-Id: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When nconnect is used, SEQUENCE operation currently isn't bound to
a particular transport. The problem is created on an idle mount,
where SEQUENCE is the only operation being sent and opened TPC
connections are slowly being close from the lack of use. If SEQUENCE
is not assigned to the main connection, the main connection can
be closed and with that so is the back channel bound to that
connection.

Since the only way client handles callback_path down is by sending
BIND_CONN_TO_SESSION requesting to bind both backchannel and fore
channel on the connection that was left going, but that connection
was already bound to only forechannel. According to the spec, it's
not allowed to change channel binding after they are done.

The fix is to make sure that a lone SEQUENCE always goes on the
main connection, keeping backchannel alive.

Fixes: 5a0c257f8 ("NFS: send state management on a single connection")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 99e9f2e..461f85d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8857,7 +8857,7 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		.rpc_client = clp->cl_rpcclient,
 		.rpc_message = &msg,
 		.callback_ops = &nfs41_sequence_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
 	};
 	struct rpc_task *ret;
 
-- 
1.8.3.1

