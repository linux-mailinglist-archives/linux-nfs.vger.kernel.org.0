Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03E01B7E94
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXTIu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXTIu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 15:08:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457DC09B048
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 12:08:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so11276727qkc.11
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vjL1A60vMGZSyAD2t3jEI6jFFGQdWWPbUF7NN5dPSPY=;
        b=nTXcWuBGPUAZOtTSx3qjMp693c/Clu/yxD54yeXi1kY+rUcfb54N8Yt/hbXJZ7YTaV
         uPW/2tBUxOlKFcGa3aebEZM0oxxV+9lutUPfDur7RgLMOj4EamaE2HMed7cSG6P/lJAx
         D/gGP+tOeiP54Ch84VH29Y001sFAE1rQ3xGABTZxzG3r4byCEiWW25pFFWIhC8TtfeEG
         O0BDplUmJ8OuY0nIEbpG9k3+UU/ukH7gQg8DsPQev5lQBLn/5SP0Kc0F8CJQrlB2biqJ
         MjW+o62hl/pjFXcTiegcxF5UQ63XHiKH7qJumnFXKR3drPWRfmLTDCZSJWc/IrcRAMi+
         tW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vjL1A60vMGZSyAD2t3jEI6jFFGQdWWPbUF7NN5dPSPY=;
        b=P9xsJF6RpQP21Gi+6ocByFWvEW3MjtdEUxKoh+sT/P1AmvnpkYrx7xLDPwdwYtJgOK
         HuoXM4cECxRW3wGgUrmhczF0chIFT2ArlBsED4/zBXCUY0lXDfuM0QsERaUxQrnJvClq
         taHEd/t3igYWgum6bQQlUTnzTu/+OsFgze814rKv/7LqaXZOqkRTpHSHu9i+SzZJKIHF
         +FTMlcibVVBkp+H9foeWrRGCTMZvcS02TLmMgidyGI9X3GMGxUWstWGizyf63hhssHAs
         huy0MEF32+JdkpQV4BfwKyFkhG+anMe0He5eNgih7kTzo9g2ubQt8kdDS+qcU+8Q8FBi
         f62A==
X-Gm-Message-State: AGi0PuaEJFX2kWw2EBSjVnQ8s9s0RUgXn3jGzpJEXjiSB2XVzBiu1wTK
        s5Hka39HzA7QT6jgu6fhTnwofwpl
X-Google-Smtp-Source: APiQypJEthACrrCEUXssYiH32+BDM5oveNZ4u6sVOOIGCmr7Y0d1DrXWparYvcCCI3LN0HOg/H+E9Q==
X-Received: by 2002:ae9:f70a:: with SMTP id s10mr10346114qkg.313.1587755329235;
        Fri, 24 Apr 2020 12:08:49 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m26sm4588097qta.53.2020.04.24.12.08.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Apr 2020 12:08:48 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION
Date:   Fri, 24 Apr 2020 15:08:56 -0400
Message-Id: <20200424190856.30292-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, if the client sends BIND_CONN_TO_SESSION with
NFS4_CDFC4_FORE_OR_BOTH but only gets NFS4_CDFS4_FORE back it ignores
that it wasn't able to enable a backchannel.

To make sure, the client sends BIND_CONN_TO_SESSION as the first
operation on the connections (ie., no other session compounds haven't
been sent before), and if the client's request to bind the backchannel
is not satisfied, then reset the connection and retry.

Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c           | 6 ++++++
 include/linux/sunrpc/clnt.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 512afb1..69a5487 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7891,6 +7891,7 @@ static int nfs4_check_cl_exchange_flags(u32 flags)
 nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs41_bind_conn_to_session_args *args = task->tk_msg.rpc_argp;
+	struct nfs41_bind_conn_to_session_res *res = task->tk_msg.rpc_resp;
 	struct nfs_client *clp = args->client;
 
 	switch (task->tk_status) {
@@ -7899,6 +7900,11 @@ static int nfs4_check_cl_exchange_flags(u32 flags)
 		nfs4_schedule_session_recovery(clp->cl_session,
 				task->tk_status);
 	}
+	if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
+			res->dir != NFS4_CDFS4_BOTH) {
+		rpc_task_close_connection(task);
+		task->tk_status = -NFS4ERR_DELAY;
+	}
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index ca7e108..cc20a08 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -236,4 +236,9 @@ static inline int rpc_reply_expected(struct rpc_task *task)
 		(task->tk_msg.rpc_proc->p_decode != NULL);
 }
 
+static inline void rpc_task_close_connection(struct rpc_task *task)
+{
+	if (task->tk_xprt)
+		xprt_force_disconnect(task->tk_xprt);
+}
 #endif /* _LINUX_SUNRPC_CLNT_H */
-- 
1.8.3.1

