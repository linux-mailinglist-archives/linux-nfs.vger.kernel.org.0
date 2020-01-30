Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104A814D85F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2020 10:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3Jna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jan 2020 04:43:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgA3Jna (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jan 2020 04:43:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so3182856wrt.6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2020 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=QgJOQHhmjkavyIGLdjt9HqiKD1XvGmDtbqJA2LK5nkY=;
        b=gBCRw5EHKRM0ZL02VcP6SZaFqZ9nEO4D6q/I8ljsIk96cKYyIXyWQBw7zIINcnwy0p
         kvmgvQlvMoplcTdtJ0jIxht6F5jrA+g7QqkejFJ712yl3U6ugeJMs517U+ceu1VO/mql
         Kg6qWD43fc7wUtLiVVjZZh+IFlTPpAfzQJc2ncKI1Z2H1sevJ3qj0ANHfxJ2j3aIT0lq
         yrBrq4QvrttZrlrm1dUxoY6Im80OTC0L2IyXy3iW9dueA0B0M6hf4QkTbEgtOqFpn0hi
         p9voonFOQFFWpse43jES/hp+JYvpxvEoWlkk/zPEh8lX28wi05Rlo91kyssKoJvoDx3I
         Lteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=QgJOQHhmjkavyIGLdjt9HqiKD1XvGmDtbqJA2LK5nkY=;
        b=QxgQvcqyY8aybc0+0IiTmogGdl5t7PxtZOZGPYs3vjNdYJlgagSoFX5eeATs0aJQ8n
         6AXOMCkV4kkHhw5TQ+U8mGlOyAJfo7vH/bgoexIbflUkX0Dc4yuMr2M/tRbPFzMgC21o
         JhWb82ivq8QO/ee6AMMjMD0r5vIxMofYETDHQFZCTRYCI0frLkcbvCbQvdOKWenPtubq
         xb7ufQx3iRzbUJt2RZ4cz1slKpD+G9KCckjCbt6d/1Q7ndvqFCOkIPtCg0w96q2LXCM0
         Oq1NFUC2Fol69ETAP0NWAEN3RGbuqhs2j7t2HRZ+rcuqpElDnJF1wziReQisD1v8duaZ
         gBtw==
X-Gm-Message-State: APjAAAX+yOmOUbWrU+6JSC/M+jxcB4rhZ3aBs3Thy3aRFpoaG+a9MoMB
        yVtf7NTObx/9gVOsUiWxaIkoIBx8SiYuzQ==
X-Google-Smtp-Source: APXvYqx2/PvPhTphOfNfD3Dwd6nL2p9Q3z7u2A/+/rVHQ+8W12rEhfJJOpqMdOgnMMsuhlm1vGJRgw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr4437277wrx.304.1580377407540;
        Thu, 30 Jan 2020 01:43:27 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id p26sm5372155wmc.24.2020.01.30.01.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 01:43:27 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>, <trondmy@hammerspace.com>
Cc:     "'Schumaker, Anna'" <Anna.Schumaker@netapp.com>,
        <chuck.lever@oracle.com>, <trond.myklebust@hammerspace.com>,
        "'David Laight'" <David.Laight@ACULAB.COM>
Subject: [PATCH v5] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Thu, 30 Jan 2020 09:43:25 -0000
Message-ID: <030001d5d751$b834d290$289e77b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXXUWTAvVUbuUN2Sj6HbyyCYI4aQg==
Content-Language: en-gb
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
@@ -446,9 +446,7 @@ extern int nfs4_detect_session_trunking(struct
nfs_client *clp,
 extern void nfs4_renewd_prepare_shutdown(struct nfs_server *);
 extern void nfs4_kill_renewd(struct nfs_client *);
 extern void nfs4_renew_state(struct work_struct *);
-extern void nfs4_set_lease_period(struct nfs_client *clp,
-		unsigned long lease,
-		unsigned long lastrenewed);
+extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long
lease);
 
 
 /* nfs4state.c */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..affc150 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5019,16 +5019,13 @@ static int nfs4_do_fsinfo(struct nfs_server *server,
struct nfs_fh *fhandle, str
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
+			nfs4_set_lease_period(server->nfs_client,
fsinfo->lease_time * HZ);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
@@ -6084,6 +6081,7 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32
program,
 		.callback_data = &setclientid,
 		.flags = RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
 	};
+	unsigned long now = jiffies;
 	int status;
 
 	/* nfs_client_id4 */
@@ -6116,6 +6114,9 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32
program,
 		clp->cl_acceptor =
rpcauth_stringify_acceptor(setclientid.sc_cred);
 		put_rpccred(setclientid.sc_cred);
 	}
+
+	if (status == 0)
+		do_renew_lease(clp, now);
 out:
 	trace_nfs4_setclientid(clp, status);
 	dprintk("NFS reply setclientid: %d\n", status);
@@ -8203,6 +8204,7 @@ static int _nfs4_proc_exchange_id(struct nfs_client
*clp, const struct cred *cre
 	struct rpc_task *task;
 	struct nfs41_exchange_id_args *argp;
 	struct nfs41_exchange_id_res *resp;
+	unsigned long now = jiffies;
 	int status;
 
 	task = nfs4_run_exchange_id(clp, cred, sp4_how, NULL);
@@ -8223,6 +8225,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client
*clp, const struct cred *cre
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
@@ -92,17 +92,15 @@ static int nfs4_setup_state_renewal(struct nfs_client
*clp)
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


