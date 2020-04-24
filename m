Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1680D1B81B2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDXVpp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXVpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 17:45:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F8C09B049
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 14:45:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so9267677qtm.4
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FdOXTtHy+tCOIWxiQkJvu6mdbfuP/REbWenvSsfQc9k=;
        b=thCXb3rIaXehMSl+LourIZlw8pvC7TCRw3EkU6LvfGn3UGa5EPc9ow4UFRBpAWobdQ
         nQ4BIXkZVeNgzC+0rxowoOvJkBq9N1xX9rStKLKjKNlFivvY6wq78PikCboJJQgqfjnG
         pXxcIPbRfHIFRwPQ9EOdWzhN/XF6S5RQ+9BsMhkhenmJGrNDDm40Lbi7+bLV376TxpWu
         WGuX7ACCZrdlSZ26/QLzOyak/J3/CjtXYUC1oSWAdNe97g74ieIdcLk5IOrF6AIpUVd1
         sHCNuKRsVH/Ubw1mKGv2xDnfcTWhMsuTMolwAqLGNwKqBjiHB7jN+9dt35iod9iaT5Dk
         C2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdOXTtHy+tCOIWxiQkJvu6mdbfuP/REbWenvSsfQc9k=;
        b=hgrNc3AiudulU0knOvpP/HvmQQpDy2/LeqDBDG9P9XKlOE2G+wI3UpVsWbm/QuLdtA
         RWvkJI6Qp9/MvduzBtdDKXcwpUqkFHJ03EBfLlHIEfKhbv1+iSGEay88UtSL6VrMtN+W
         owPakhX1I7v+1csnnXLWVbkHZK3ibN5h07sDfBS3PqojGxLcUYSgl4wVqbmoBU75G5Kt
         JUaRrva3Ap8j6oOzSnwJ2H6zPK5GUrV5kGvVMgkqRlijuDZyP86hMh8WIN0DDr1W5I1v
         aBO+1haQgmOAPI68bdwFMZGivGYe42kpmYYHHoSf/I/OEZTCdOWbUDlk4YkCMs0TuaXR
         s07w==
X-Gm-Message-State: AGi0PubLsyTTsNV2ZZddmTboP2UfUHPyhSA3l7hOsE7VZU6fxrizRaRp
        TMEvTywaZ4vSCT8O/V73deknn6fQ
X-Google-Smtp-Source: APiQypJQcnZam1W+iJSKgc4ISK1KYMyAollJGMaelt2+c9Z9TvL6chAML2kdjaPaiyNw/Hcv4Wcmog==
X-Received: by 2002:ac8:2f15:: with SMTP id j21mr11876350qta.259.1587764742885;
        Fri, 24 Apr 2020 14:45:42 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i42sm5052315qtc.83.2020.04.24.14.45.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Apr 2020 14:45:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION
Date:   Fri, 24 Apr 2020 17:45:50 -0400
Message-Id: <20200424214550.30462-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs4proc.c           | 8 ++++++++
 include/linux/nfs_xdr.h     | 2 ++
 include/linux/sunrpc/clnt.h | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 512afb1..7e7c24e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7891,6 +7891,7 @@ static int nfs4_check_cl_exchange_flags(u32 flags)
 nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs41_bind_conn_to_session_args *args = task->tk_msg.rpc_argp;
+	struct nfs41_bind_conn_to_session_res *res = task->tk_msg.rpc_resp;
 	struct nfs_client *clp = args->client;
 
 	switch (task->tk_status) {
@@ -7899,6 +7900,12 @@ static int nfs4_check_cl_exchange_flags(u32 flags)
 		nfs4_schedule_session_recovery(clp->cl_session,
 				task->tk_status);
 	}
+	if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
+			res->dir != NFS4_CDFS4_BOTH) {
+		rpc_task_close_connection(task);
+		if (args->retries++ < MAX_BIND_CONN_TO_SESSION_RETRIES)
+			rpc_restart_call(task);
+	}
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
@@ -7921,6 +7928,7 @@ int nfs4_proc_bind_one_conn_to_session(struct rpc_clnt *clnt,
 	struct nfs41_bind_conn_to_session_args args = {
 		.client = clp,
 		.dir = NFS4_CDFC4_FORE_OR_BOTH,
+		.retries = 0,
 	};
 	struct nfs41_bind_conn_to_session_res res;
 	struct rpc_message msg = {
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 4402304..e5f3e7d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1317,11 +1317,13 @@ struct nfs41_impl_id {
 	struct nfstime4			date;
 };
 
+#define MAX_BIND_CONN_TO_SESSION_RETRIES 3
 struct nfs41_bind_conn_to_session_args {
 	struct nfs_client		*client;
 	struct nfs4_sessionid		sessionid;
 	u32				dir;
 	bool				use_conn_in_rdma_mode;
+	int				retries;
 };
 
 struct nfs41_bind_conn_to_session_res {
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

