Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3314BCA1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA1PMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 10:12:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgA1PMi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 10:12:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2954979wmf.2;
        Tue, 28 Jan 2020 07:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=FHCjbQa1iFpsgX64Wzl1txNaIuacqKkOV6H+LDHHMuE=;
        b=WdMjo/YxfmC3NVae9Rt9TyqK0TjSap9gGpE/uYxmQKxDNtFylAp6hJgROFX5QT+pOv
         M/yuDpUb5MitQ0MaENNRk7ALdsDtLnGTaklDD/ug+ozOICrSHzdlsd5MmnqtpTrQRdlV
         k3Ygsk7u8nK5w6tIIc7mXR3jxyBUmglqnWv0Q6T5m7d7DoWdu++y2HjyysHKg68cNUS0
         EPpqPpMRiWhmUksCn/OUiD7ee1MWd7keZF5pD9sBrlMViO0/+OedXXgd7kFUndkSaGgK
         obmlh9piuWhcV6Eh+CMtbNXI/TKmkkR23mqqYNm8/g3Z8gEqUXpG4+G4z6TGe0xdv4Eb
         4xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=FHCjbQa1iFpsgX64Wzl1txNaIuacqKkOV6H+LDHHMuE=;
        b=q2uccemY2dMLfScLcWUOUYsTUdsu/nA/RZ3buPBF2t+TdgPTu0N1wGUpEQ/GstAQdO
         Oxmo7cGkE3+8mdD8xGR4ea8wK4hh+DTF5nPaA3SC0Qu+VeGsog4IydVxd0X3YTic+p/V
         804mW1R5lrREuCe4L+uegCPnw5ks9RFeAf+cUDHE+D0bjVXXlo+ALPMxnnNxZXvuZRBQ
         by9IoedjyazFI05ffH2ByLDARBbkH6sCv7V/XTWFxHmhynOhz6uSBFwkugu9PGJXPIXM
         OUeANk06rt/kPkvCYCZrxbqMQU0WtAi13ZJ2jeLBvqcnAKVgGt3biXrhlX3nAUypoR+w
         ZKpA==
X-Gm-Message-State: APjAAAVroq1AbLkfiWCI+xDSg+33l7IrixMZPG9FIgv33B9FpKMIS4Vv
        Mn45utuE3t07dKxFxU1po/Q=
X-Google-Smtp-Source: APXvYqwBFcJDr/jAeKt8wUuaB/o3frKrKD7JUopwa+CuFrWcBImH8DrfPFYav0k58AEFhtu8CpSYlg==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr5373755wma.81.1580224355666;
        Tue, 28 Jan 2020 07:12:35 -0800 (PST)
Received: from loulrmilkow1 ([213.52.196.70])
        by smtp.gmail.com with ESMTPSA id t131sm3468772wmb.13.2020.01.28.07.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 07:12:35 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "'Trond Myklebust'" <trond.myklebust@hammerspace.com>
Subject: [PATCH v4] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Tue, 28 Jan 2020 15:12:33 -0000
Message-ID: <004e01d5d5ed$5e7ca490$1b75edb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AdXV6tGXVv4pqJJkS9G0izuAHIy3vA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, each time nfs4_do_fsinfo() is called it will do an implicit
NFS4 lease renewal, which is not compliant with the NFS4 specification.
This can result in a lease being expired by an NFS server.

Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
introduced implicit client lease renewal in nfs4_do_fsinfo(),
which can result in the NFSv4.0 lease to expire on a server side,
and servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.

This can easily be reproduced by frequently unmounting a sub-mount,
then stat'ing it to get it mounted again, which will delay or even
completely prevent client from sending RENEW operations if no other
NFS operations are issued. Eventually nfs server will expire client's
lease and return an error on file access or next RENEW.

This can also happen when a sub-mount is automatically unmounted
due to inactivity (after nfs_mountpoint_expiry_timeout), then it is
mounted again via stat(). This can result in a short window during
which client's lease will expire on a server but not on a client.
This specific case was observed on production systems.

This patch removes the implicit lease renewal from nfs4_do_fsinfo().

Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4_fs.h    |  4 +---
 fs/nfs/nfs4proc.c   | 12 ++++++++----
 fs/nfs/nfs4renewd.c |  5 +----
 fs/nfs/nfs4state.c  |  4 +---
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index a7a73b1..a5db055 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -446,9 +446,7 @@ extern int nfs4_detect_session_trunking(struct nfs_client *clp,
 extern void nfs4_renewd_prepare_shutdown(struct nfs_server *);
 extern void nfs4_kill_renewd(struct nfs_client *);
 extern void nfs4_renew_state(struct work_struct *);
-extern void nfs4_set_lease_period(struct nfs_client *clp,
-		unsigned long lease,
-		unsigned long lastrenewed);
+extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long lease);
 
 
 /* nfs4state.c */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..7b2d88b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5019,16 +5019,13 @@ static int nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle, str
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	unsigned long now = jiffies;
 	int err;
 
 	do {
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
-			nfs4_set_lease_period(server->nfs_client,
-					fsinfo->lease_time * HZ,
-					now);
+			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
@@ -6084,6 +6081,7 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32 program,
 		.callback_data = &setclientid,
 		.flags = RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
 	};
+	unsigned long now = jiffies;
 	int status;
 
 	/* nfs_client_id4 */
@@ -6116,6 +6114,9 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32 program,
 		clp->cl_acceptor = rpcauth_stringify_acceptor(setclientid.sc_cred);
 		put_rpccred(setclientid.sc_cred);
 	}
+
+	if(status == 0)
+		do_renew_lease(clp, now);
 out:
 	trace_nfs4_setclientid(clp, status);
 	dprintk("NFS reply setclientid: %d\n", status);
@@ -8203,6 +8204,7 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	struct rpc_task *task;
 	struct nfs41_exchange_id_args *argp;
 	struct nfs41_exchange_id_res *resp;
+	unsigned long now = jiffies;
 	int status;
 
 	task = nfs4_run_exchange_id(clp, cred, sp4_how, NULL);
@@ -8223,6 +8225,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	if (status != 0)
 		goto out;
 
+	do_renew_lease(clp, now);
+
 	clp->cl_clientid = resp->clientid;
 	clp->cl_exchange_flags = resp->flags;
 	clp->cl_seqid = resp->seqid;
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 6ea431b..ff876dd 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -138,15 +138,12 @@
  *
  * @clp: pointer to nfs_client
  * @lease: new value for lease period
- * @lastrenewed: time at which lease was last renewed
  */
 void nfs4_set_lease_period(struct nfs_client *clp,
-		unsigned long lease,
-		unsigned long lastrenewed)
+		unsigned long lease)
 {
 	spin_lock(&clp->cl_lock);
 	clp->cl_lease_time = lease;
-	clp->cl_last_renewal = lastrenewed;
 	spin_unlock(&clp->cl_lock);
 
 	/* Cap maximum reconnect timeout at 1/2 lease period */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3455232..f0b0027 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -92,17 +92,15 @@ static int nfs4_setup_state_renewal(struct nfs_client *clp)
 {
 	int status;
 	struct nfs_fsinfo fsinfo;
-	unsigned long now;
 
 	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
 		nfs4_schedule_state_renewal(clp);
 		return 0;
 	}
 
-	now = jiffies;
 	status = nfs4_proc_get_lease_time(clp, &fsinfo);
 	if (status == 0) {
-		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
+		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
 		nfs4_schedule_state_renewal(clp);
 	}
 
-- 
1.8.3.1


