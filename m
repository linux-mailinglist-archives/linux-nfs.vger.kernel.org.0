Return-Path: <linux-nfs+bounces-10213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD2A3E15A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E665517F653
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D9214220;
	Thu, 20 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGuNJaaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88F212D86;
	Thu, 20 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070051; cv=none; b=t3rum16trFcAZQOy6m9SygafLeHePB6EYMM1nW2i5BLbwIm5VYJtTIGmw/GcvKsd0uZfADkOUFHai6/HUfahGRH/r8Y8SRbIMD1kdZJbpdlZD5rU/r2964LnUT90b9FmY3kk5ck0CGXs8t8bJVSsL/wXFO/DuRtEw4ff4VyB42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070051; c=relaxed/simple;
	bh=ila+U1RbL04csr1V3SrKR23UcsiSK+mTiCSxKDF7PPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLAFFbO/RKiI4l+YnRjE8XvYX4QNVUkFmfRaCo0hE/TcejUQHU0ny+ce3LyOWlbUQlgQfHZAsS/CbMjE2ECb6jzJ8aGWTV10u0zdXjEbyPaeuaSuaMEJIueJE5L4oxTuYezxdvq6JDVaWZlQ68a0yW3p7GxUOSTGftFCBEXXt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGuNJaaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC7BC4CEE2;
	Thu, 20 Feb 2025 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070050;
	bh=ila+U1RbL04csr1V3SrKR23UcsiSK+mTiCSxKDF7PPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UGuNJaaKioadX1AWSd5yBlw7i/yf3OaYPOk//FjtLu+mMazVM4CvQ4WSEV2Er1tdp
	 IXMLtEUn6kNCI5LVJNzJi4NEYKQa5ZSdms9teKIkfY1YBl+tHkfyr4VmWG8qBheS1I
	 UvoA+yCxD0HTau+HzYEa11+jekvYrr5HTosUpPQ8VxC4SMweuQBaINOa+7Fve56C1m
	 kKFo+A4dtRyrlpeqW2sbGQDlzmAQL5awsC3Nlu7h4A1V3p+zReBivWiA7VkP7iSnis
	 5eZOCzgum+/rMLfpnUtesg3Z6wzPrNPhF+kE4y5+cxrS0nWRP9jkZCvKuT9OGqA3sT
	 OOmm+VHkFRoVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 11:47:15 -0500
Subject: [PATCH v2 3/5] nfsd: replace CB_GETATTR_BUSY with
 NFSD4_CALLBACK_RUNNING
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-nfsd-callback-v2-3-6a57f46e1c3a@kernel.org>
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
In-Reply-To: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4425; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ila+U1RbL04csr1V3SrKR23UcsiSK+mTiCSxKDF7PPI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt1yekIeVzU2mnGiQR4Cik3t8bX9ez2J0ynAvy
 ZFawIB3RSKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7dcngAKCRAADmhBGVaC
 Ffj7EAC4zNF4gP+kE8zUapXIUfRNiHlDsCX/WMLQPqbjPCK2fhBkPBGQNAvIRRu0ZEg2oszaFH/
 o4ftFqE524FdteYwynzxtxmGjf06fO1lu+S5YGUjcMp1Q5TcqJDHzm1+AkVXwj4zyq7EMd8/X+l
 Du5exjMwRafGhiWcIwRMt0yLhLLduFSFdGgc37Q648eQPHVf1gw4sbIUHtrexKgca8wi5gP2DkG
 3kRJgm4Qg68bGMvqmLEWOG3wQl1MGKAxodPU4oclOVwhx/HcKeiCLf8fxR9pGZ2E5uK8iWq5iD0
 JNuFEyNkcBOQIzbYhATbofUNS1F8RWZy9F7QWHHpPPjUYqZedARR2oe5/NE79CtWz7oRbFv5KoG
 NDMcOww2x0Gl+LEU6Ec8Olr93+rP/UZYhgEQvN/kKUMGFTOwJ+8xRF0QtsdK8P/l9hZ4+OrbG4M
 3NS0GdSFOCb5va2m/8AfSeCjeX4C1PB0dUNdhXX19YktOhRrZh7l3dnM2IOkUhGH/tw7+TXhY5V
 NDnHdgnIi3LnIGEEi6kI35IDhljjWVXLLQYZkiPC5QgMz/4JQ/DKq7wbNq09yp2YVA6dcu0fg7Z
 LAJ7mxvHP2lk64XH4LxnV2QQBo+Iqy7l+16xaRMFmVxPn80bcJ7lMPsJib7gdZlRoYfRmhDqEeK
 dbWMog3MZnmiAbg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These flags serve essentially the same purpose and get set and cleared
at the same time. Drop CB_GETATTR_BUSY and just use
NFSD4_CALLBACK_RUNNING instead.

For this to work, we must use clear_and_wake_up_bit(), but doing that on
for other types of callbacks is wasteful. Declare a new NFSD4_CALLBACK_WAKE
flag in cb_flags to indicate that wake_up is needed, and only set that
for CB_GETATTRs.

Also, make the wait use a TASK_UNINTERRUPTIBLE sleep. This is done in
the context of an nfsd thread, and it should never need to deal with
signals.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c |  6 +++++-
 fs/nfsd/nfs4state.c    | 17 +++++++++--------
 fs/nfsd/state.h        |  5 +----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1f26c811e5f73c2e745ee68d0b6e668d1dd7c704..bb2cb0d1b7885bf5f6be39221cb3dd95518326e5 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1312,7 +1312,11 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 
 	trace_nfsd_cb_destroy(clp, cb);
 	nfsd41_cb_release_slot(cb);
-	clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
+	if (test_bit(NFSD4_CALLBACK_WAKE, &cb->cb_flags))
+		clear_and_wake_up_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
+	else
+		clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
+
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 422439a46ffd03926524b8463cfdabfb866281b3..b68bc3f12a8c29904e6bdd2b5a1e4ed6418104e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3205,7 +3205,6 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	struct nfs4_delegation *dp =
 			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
-	clear_and_wake_up_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
 	nfs4_put_stid(&dp->dl_stid);
 }
 
@@ -3226,15 +3225,17 @@ static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 	struct nfs4_delegation *dp =
 			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
-	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncf->ncf_getattr.cb_flags))
 		return;
+
 	/* set to proper status when nfsd4_cb_getattr_done runs */
 	ncf->ncf_cb_status = NFS4ERR_IO;
 
-	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncf->ncf_getattr.cb_flags)) {
-		refcount_inc(&dp->dl_stid.sc_count);
-		nfsd4_run_cb(&ncf->ncf_getattr);
-	}
+	/* ensure that wake_bit is done when RUNNING is cleared */
+	set_bit(NFSD4_CALLBACK_WAKE, &ncf->ncf_getattr.cb_flags);
+
+	refcount_inc(&dp->dl_stid.sc_count);
+	nfsd4_run_cb(&ncf->ncf_getattr);
 }
 
 static struct nfs4_client *create_client(struct xdr_netobj name,
@@ -9210,8 +9211,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	nfs4_cb_getattr(&dp->dl_cb_fattr);
 	spin_unlock(&ctx->flc_lock);
 
-	wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
-			    TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
+	wait_on_bit_timeout(&ncf->ncf_getattr.cb_flags, NFSD4_CALLBACK_RUNNING,
+			    TASK_UNINTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
 	if (ncf->ncf_cb_status) {
 		/* Recall delegation only if client didn't respond */
 		status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6967925f4b438b24c2abd5fcd4f3bd6664a81862..b7d6be45ad022194e90cdf8d19c2879be08143ff 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -68,6 +68,7 @@ struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
 #define NFSD4_CALLBACK_RUNNING	BIT(0)	// Callback is running
+#define NFSD4_CALLBACK_WAKE	BIT(1)	// must wake_bit when clearing RUNNING
 	unsigned long cb_flags;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
@@ -164,15 +165,11 @@ struct nfs4_cb_fattr {
 	struct timespec64 ncf_cb_mtime;
 	struct timespec64 ncf_cb_atime;
 
-	unsigned long ncf_cb_flags;
 	bool ncf_file_modified;
 	u64 ncf_initial_cinfo;
 	u64 ncf_cur_fsize;
 };
 
-/* bits for ncf_cb_flags */
-#define	CB_GETATTR_BUSY		0
-
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is

-- 
2.48.1


