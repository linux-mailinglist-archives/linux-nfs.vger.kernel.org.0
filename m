Return-Path: <linux-nfs+bounces-15568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E6C0145A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38954EA08F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED98314B65;
	Thu, 23 Oct 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDiGlrfA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37180314B64;
	Thu, 23 Oct 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225173; cv=none; b=F6tIn6tLpL8bWiNYbz1XazkuL9+KxE/rGulF/q7gAQmfZoev1bXIN6fMEsBqhOnTtCooHfw+kiI7uZswOFiSRkKMoo2yFqMShPkwpxArgrFdrZtpcdwM+mvzP5zSMz+SyI42d/9gQvl4DW1sZRN+ijp51kKzPVX7hdpoQFBUA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225173; c=relaxed/simple;
	bh=tzzuyli2FJUV4/l41vMHQUNLHoHIcr850IlfoNC0cBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IaXzPVpi6xVk0MVTXuM4vQA6uNfJysQgqmq9sI3rkyrp0O5rUcbX4NLSfU18geq8sIV8bh5jiia5kUOCUwZqiwY3jt0X7OEUQ1uGhyf6RdiCkjBbcX3sjsROPipbunqB9B8uQPLLw9Qm6lzrCvBwm/SxM3VaZv2QjWV32VSrcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDiGlrfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC30C4CEE7;
	Thu, 23 Oct 2025 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225172;
	bh=tzzuyli2FJUV4/l41vMHQUNLHoHIcr850IlfoNC0cBg=;
	h=From:Date:Subject:To:Cc:From;
	b=nDiGlrfA37aIAhGaVwA9zfzMIEgZkkjTmYDfMYYdQGKLA5oR9pTpbZqeMjmzAv72j
	 Sxvz7ZnRUq0W85VGWd9G5K5w8vMC6aTOXrwdV2/HY5Uoa3WkmhxTLDUX7CbGlQzxFQ
	 0FqkHTxgKPbd5kO1AcBpyz/ONDDQnfNM6U4qGQ5cJ0spzUEEEm15q93IfTU/vYvLV2
	 J9HXoCLTJ7JNj3c7rCnEGNzzvE6JAyf18MGgoqXNz9i4uqKu3u50HJdPb7ekSXk3H2
	 F1bsQlRd/JtlO7xSRWjF6ab+4J+uleDSli7qxsuV8mFyJmRe2V+ezCbiVKZLplX3Na
	 aJJJAkln/0TVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Oct 2025 09:12:39 -0400
Subject: [PATCH] lockd: don't allow locking on reexported NFSv2/3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-lockd-owner-v1-1-1d196b0183d1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMYp+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNj3Zz85OwU3fzyvNQi3URTI8tUE9MUCzMjIyWgjoKi1LTMCrBp0bG
 1tQDsxRhIXQAAAA==
X-Change-ID: 20251023-lockd-owner-a529e45d8622
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4793; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tzzuyli2FJUV4/l41vMHQUNLHoHIcr850IlfoNC0cBg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo+inO29Iw5bYLT5S/wQi/YVPrS4avOWRIR4TRu
 aYAWoNzahuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPopzgAKCRAADmhBGVaC
 FWPHD/9M8NDGWxtCAue2dXEEYlXiAlHhX8ndOk389s9w3onaFjNJD/vJQiTcHdWRj0qEqqZRL5B
 k4KGI+1gosKmazE3ncbkFjJQWo1qBCRHIYLKk4Ws17nzMWj0DzbALqjC/XOCWk1gqUdVNHR4ROZ
 rsILU6XrD1vEYYajPptLq6GPs10Cl73hfZ+hQoULsntK/CVTP43gm/FVIxgkN9cwAbYq0c+xg5f
 7lsH4Cvvnejgn5g0z+qUPJW9R7/QX4BFBBNA8RQAOk/U3WPsIWT8i/th/gjEgcNxMDTHYksgX63
 iUhpaTM/kw3KCf/lBksMtdMxGmlrLaW3ZWTTxJNWu1qHUg8d4alfSnMtPeOi24lx5eqbRsH3tQY
 WUO+9etvJH5ruedoS2Lme3i//mtyh2+mGaaiNrpGR1tRG3v2ke6hAAkULzcWmOWb/rwAQBUdw/m
 W/9CYAZRnVNdv2zl7pXeVWIljVoGIFsSih2ugi0lnKXucGbsWegZMJhyWhSlIBviyBbEv9fgJif
 CEys/o8EsWC+feURj04ibbcbLJmY3JefOWjQCpB1fJNtbAdrtQUUGOpzG6h2PRs/O+E/PSWOcLp
 F7p0vBtxJqJw6qcFDCwsxiUy5RtjvYQu0sKdA2Biq7MekN/6LPxTkm/rgjYGivc61dUPO6YS5ab
 NKLCVd/I/5lH0oQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Since commit 9254c8ae9b81 ("nfsd: disallow file locking and delegations
for NFSv4 reexport"), file locking when reexporting an NFS mount via
NFSv4 is expressly prohibited by nfsd. Do the same in lockd:

Add a new  nlmsvc_file_cannot_lock() helper that will test whether file
locking is allowed for a given file, and return nlm_lck_denied_nolocks
if it isn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Regardless of how we fix the bug that Olga found recently, I think we
need to do this as well. We don't allow locking when reexporting via v4,
and I don't think we want to allow it when reexporting via v2/3 either.
---
 fs/lockd/svclock.c          | 12 ++++++++++++
 fs/lockd/svcshare.c         |  6 ++++++
 include/linux/lockd/lockd.h |  9 ++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c1315df4b350bbd753305b5c08550d50f67b92aa..cd42e480a7000f1b3ec7fca5ecc7fb8dc4755a09 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -495,6 +495,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	if (!locks_can_async_lock(nlmsvc_file_file(file)->f_op)) {
 		async_block = wait;
 		wait = 0;
@@ -621,6 +624,9 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	if (locks_in_grace(SVC_NET(rqstp))) {
 		ret = nlm_lck_denied_grace_period;
 		goto out;
@@ -678,6 +684,9 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	/* First, cancel any lock that might be there */
 	nlmsvc_cancel_blocked(net, file, lock);
 
@@ -715,6 +724,9 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	if (locks_in_grace(net))
 		return nlm_lck_denied_grace_period;
 
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index ade4931b2da247abd23bd16923f1d2388dc6ce00..88c81ce1148d92bd29ec580ac399ac944ba5ecf8 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -32,6 +32,9 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 	struct xdr_netobj	*oh = &argp->lock.oh;
 	u8			*ohdata;
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	for (share = file->f_shares; share; share = share->s_next) {
 		if (share->s_host == host && nlm_cmp_owner(share, oh))
 			goto update;
@@ -72,6 +75,9 @@ nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 	struct nlm_share	*share, **shpp;
 	struct xdr_netobj	*oh = &argp->lock.oh;
 
+	if (nlmsvc_file_cannot_lock(file))
+		return nlm_lck_denied_nolocks;
+
 	for (shpp = &file->f_shares; (share = *shpp) != NULL;
 					shpp = &share->s_next) {
 		if (share->s_host == host && nlm_cmp_owner(share, oh)) {
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index c8f0f9458f2cc035fd9161f8f2486ba76084abf1..330e38776bb20d09c20697fc38a96c161ad0313a 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -12,6 +12,7 @@
 
 /* XXX: a lot of this should really be under fs/lockd. */
 
+#include <linux/exportfs.h>
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <net/ipv6.h>
@@ -307,7 +308,7 @@ void		  nlmsvc_invalidate_all(void);
 int           nlmsvc_unlock_all_by_sb(struct super_block *sb);
 int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
 
-static inline struct file *nlmsvc_file_file(struct nlm_file *file)
+static inline struct file *nlmsvc_file_file(const struct nlm_file *file)
 {
 	return file->f_file[O_RDONLY] ?
 	       file->f_file[O_RDONLY] : file->f_file[O_WRONLY];
@@ -318,6 +319,12 @@ static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
 	return file_inode(nlmsvc_file_file(file));
 }
 
+static inline bool
+nlmsvc_file_cannot_lock(const struct nlm_file *file)
+{
+	return exportfs_cannot_lock(nlmsvc_file_file(file)->f_path.dentry->d_sb->s_export_op);
+}
+
 static inline int __nlm_privileged_request4(const struct sockaddr *sap)
 {
 	const struct sockaddr_in *sin = (struct sockaddr_in *)sap;

---
base-commit: 316f960d9ffb8439e0876dc2eab812e55f3ccb2a
change-id: 20251023-lockd-owner-a529e45d8622

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


