Return-Path: <linux-nfs+bounces-21524-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLduAJtRA2qR4QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21524-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:13:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEE5246D9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C37BC30324A0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440E3CC7C5;
	Tue, 12 May 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQtpkc6b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254523CC32E;
	Tue, 12 May 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602380; cv=none; b=qFb2rgFU1W7/CGk1O7jJ/p9Z+X5YoM60fMx8ebBInJZdJ/bZ44BtJXy6nebuUGeTRr/f6o0fs6OWyisQ+eGuhH9m512kTfaN4/yC5dGurDTso8Etp/OR5oRlPhgmK405PDG5BhGHG5tvFVlMgKXiwAo33I2mny/SDzqFOHh/NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602380; c=relaxed/simple;
	bh=QjF9bEGw1mWRIYsh12FSZSTNDWn2exN2PWuDq1/xAqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oti0GDEUwWXYQw1uf0GBKCncHQuTEpGCv9ejRCWr8lM7urkbEq210rVhwBjRpIJxHBXPJIVHd7/5eHi5Xyg0QbCpa3iHnxLMab/Xdc+SIjtEkhdVp7MTdTRfcJSNK18JQa0ZLz0eF6QHY5xvjkQsv5vGZT3YZ7fEr3qBQqf7/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQtpkc6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0405DC2BCC7;
	Tue, 12 May 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602379;
	bh=QjF9bEGw1mWRIYsh12FSZSTNDWn2exN2PWuDq1/xAqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IQtpkc6b8Jwlz+eXTq36BQZN/4Tjm4UQcJQz97OWZ98ro74CsoEfoxNKi0ylJyBKQ
	 1Fa+alPYU5e2tB0du1cEXQpHcawZ7OB97KQU2/zGCek1xjG1rz05HcKX55/anjDqzs
	 n3NMPXgffEmrW0Ki54hOhrPHg5McqBJrh3lc8Ngq9pBay1kW9/CoarngHF5FxIb6GF
	 xwkBnZn00aGZVb+GJKwS/WqAW8+dh7UmlzZ6zQGvB3p3NCxRdq8EbY46t1wqmLFk5A
	 WkFBmOXPF1ia3XFILoD+Guk6ORLo8tgltVXi6MzMVwqMxIRHy7R0TmGYa0gEBXos83
	 H/6sNeIEa6n2g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 12 May 2026 12:12:44 -0400
Subject: [PATCH 3/4] nfs: replace NFS_FILEID() and nfsi->fileid with
 inode->i_ino
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nfsino-v1-3-284720522f4c@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
In-Reply-To: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=34787; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QjF9bEGw1mWRIYsh12FSZSTNDWn2exN2PWuDq1/xAqA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqA1GHwaeGgtQc5NebyYyW4LhbcDOMgGDNe2oMr
 wdZ550vX6iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagNRhwAKCRAADmhBGVaC
 FYasD/9oNEPDaNOta01msYBT1Ag5ADrF+NmZd0NfJ7v28ma1ouwnuSf4ZWrUUYcFD7LYbjbY6l/
 AAIrTgWuCeYmwxAMnaNjzrIlSPsQCzElX7ljL7vV0xNALgonSh9p5rJZQl6HbYDM/BfoLjAn9Kr
 mwqnySOHiNVkZNRajomHUxKT084Acw+0l2AoE0L2iW2Gc5f37djh+MlXuJGWMo4tlJmuhc1QTim
 8C3ez8ZD7y3+KLbuyGKCw+/N9nO5saUQ6h1yTrXmkjlyQEb8NTxO8bWLZrTV7hVc/IUHRKNLBQl
 EwDfpX04Nv5SIjJU7+dOrQkfWI8GZbh9FEaEaYaew9qn9aa0VEAw9wjbC7MnB1SwSEOOIaB6/a8
 SPPuLyiKScLqTjRXRgnx2YuLjjGEOrpGTzexbAilT3Dt87W6lMx6SIIp+w/2q26u0qGy/ne74tJ
 dJ1rw5uxto9ylwZ6iZt04NsR6sO0xHiTUZ9DAQ1Ub6mWQkW4obNLYq+X6+BgcFsZpnC9ZhKXqGV
 ychb/eriaGjAbF7088wFiXJlS3B1uXEVCFtb/tNtuui4sj0S9dV+Krz0myaJxMB536zr5M7vyuF
 zIEY9N/AzTlrs/acHpFw7wFea9cPQ8hiTs4ab49JGWZggSMc7LSt/sN2eUkwGXZ13nEk0MrSC8p
 8zypxVTTmMiSiEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 87DEE5246D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21524-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Now that inode->i_ino stores the full 64-bit NFS fileid, replace all
uses of NFS_FILEID(), set_nfs_fileid(), and direct nfsi->fileid
accesses with inode->i_ino throughout the NFS client.

Remove the NFS_FILEID() and set_nfs_fileid() helper functions from
include/linux/nfs_fs.h since they are no longer needed.

Also fix two pre-existing truncation bugs in nfs4trace.h where fileid
trace fields were declared as u32 instead of u64.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/export.c                        |  6 +--
 fs/nfs/filelayout/filelayout.c         |  4 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 +--
 fs/nfs/inode.c                         | 16 +++----
 fs/nfs/nfs4proc.c                      |  4 +-
 fs/nfs/nfs4trace.h                     | 79 ++++++++++++++------------------
 fs/nfs/nfstrace.h                      | 84 +++++++++++++++++-----------------
 fs/nfs/pagelist.c                      |  2 +-
 fs/nfs/pnfs.c                          |  2 +-
 fs/nfs/unlink.c                        |  2 +-
 fs/nfs/write.c                         |  2 +-
 include/linux/nfs_fs.h                 | 10 ----
 12 files changed, 99 insertions(+), 118 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index a10dd5f9d078..8fb08bce0623 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -49,14 +49,14 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_len, struct inode *parent)
 		return FILEID_INVALID;
 	}
 
-	p[FILEID_HIGH_OFF] = NFS_FILEID(inode) >> 32;
-	p[FILEID_LOW_OFF] = NFS_FILEID(inode);
+	p[FILEID_HIGH_OFF] = inode->i_ino >> 32;
+	p[FILEID_LOW_OFF] = inode->i_ino;
 	p[FILE_I_TYPE_OFF] = inode->i_mode & S_IFMT;
 	p[len - 1] = 0; /* Padding */
 	nfs_copy_fh(clnt_fh, server_fh);
 	*max_len = len;
 	dprintk("%s: result fh fileid %llu mode %u size %d\n",
-		__func__, NFS_FILEID(inode), inode->i_mode, *max_len);
+		__func__, inode->i_ino, inode->i_mode, *max_len);
 	return *max_len;
 }
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index e85380e3b11d..f0f53f5dc871 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -95,7 +95,7 @@ static void filelayout_reset_write(struct nfs_pgio_header *hdr)
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
 			hdr->inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(hdr->inode),
+			(unsigned long long)hdr->inode->i_ino,
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
@@ -112,7 +112,7 @@ static void filelayout_reset_read(struct nfs_pgio_header *hdr)
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
 			hdr->inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(hdr->inode),
+			(unsigned long long)hdr->inode->i_ino,
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8b1559171fe3..6a84d85e0651 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1230,7 +1230,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
 			hdr->inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(hdr->inode),
+			(unsigned long long)hdr->inode->i_ino,
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
@@ -1243,7 +1243,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
 			hdr->inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(hdr->inode),
+			(unsigned long long)hdr->inode->i_ino,
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
@@ -1283,7 +1283,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
 			hdr->inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(hdr->inode),
+			(unsigned long long)hdr->inode->i_ino,
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a21ed1c7f89d..0d9451a2ad8e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -303,7 +303,7 @@ nfs_find_actor(struct inode *inode, void *opaque)
 	struct nfs_fh		*fh = desc->fh;
 	struct nfs_fattr	*fattr = desc->fattr;
 
-	if (NFS_FILEID(inode) != fattr->fileid)
+	if (inode->i_ino != fattr->fileid)
 		return 0;
 	if (inode_wrong_type(inode, fattr->mode))
 		return 0;
@@ -320,7 +320,7 @@ nfs_init_locked(struct inode *inode, void *opaque)
 	struct nfs_find_desc	*desc = opaque;
 	struct nfs_fattr	*fattr = desc->fattr;
 
-	set_nfs_fileid(inode, fattr->fileid);
+	inode->i_ino = fattr->fileid;
 	inode->i_mode = fattr->mode;
 	nfs_copy_fh(NFS_FH(inode), desc->fh);
 	return 0;
@@ -580,7 +580,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 	}
 	dprintk("NFS: nfs_fhget(%s/%Lu fh_crc=0x%08x ct=%d)\n",
 		inode->i_sb->s_id,
-		(unsigned long long)NFS_FILEID(inode),
+		(unsigned long long)inode->i_ino,
 		nfs_display_fhandle_hash(fh),
 		icount_read(inode));
 
@@ -1343,7 +1343,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%s/%Lu)\n",
-		inode->i_sb->s_id, (unsigned long long)NFS_FILEID(inode));
+		inode->i_sb->s_id, (unsigned long long)inode->i_ino);
 
 	trace_nfs_revalidate_inode_enter(inode);
 
@@ -1373,7 +1373,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	if (status != 0) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) getattr failed, error=%d\n",
 			 inode->i_sb->s_id,
-			 (unsigned long long)NFS_FILEID(inode), status);
+			 (unsigned long long)inode->i_ino, status);
 		switch (status) {
 		case -ETIMEDOUT:
 			/* A soft timeout occurred. Use cached information? */
@@ -1393,7 +1393,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) refresh failed, error=%d\n",
 			 inode->i_sb->s_id,
-			 (unsigned long long)NFS_FILEID(inode), status);
+			 (unsigned long long)inode->i_ino, status);
 		goto out;
 	}
 
@@ -1404,7 +1404,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) revalidation complete\n",
 		inode->i_sb->s_id,
-		(unsigned long long)NFS_FILEID(inode));
+		(unsigned long long)inode->i_ino);
 
 out:
 	nfs_free_fattr(fattr);
@@ -1453,7 +1453,7 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
 			inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(inode));
+			(unsigned long long)inode->i_ino);
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9b8d482d289..60024b978ee0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -377,7 +377,7 @@ static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dent
 		*p++ = htonl(attrs);                           /* bitmap */
 		*p++ = htonl(12);             /* attribute buffer length */
 		*p++ = htonl(NF4DIR);
-		p = xdr_encode_hyper(p, NFS_FILEID(d_inode(dentry)));
+		p = xdr_encode_hyper(p, d_inode(dentry)->i_ino);
 	}
 	
 	*p++ = xdr_one;                                  /* next */
@@ -391,7 +391,7 @@ static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dent
 	*p++ = htonl(12);             /* attribute buffer length */
 	*p++ = htonl(NF4DIR);
 	spin_lock(&dentry->d_lock);
-	p = xdr_encode_hyper(p, NFS_FILEID(d_inode(dentry->d_parent)));
+	p = xdr_encode_hyper(p, d_inode(dentry->d_parent)->i_ino);
 	spin_unlock(&dentry->d_lock);
 
 	readdir->pgbase = (char *)p - (char *)start;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index c939533b9881..1ed677810d9d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -597,13 +597,13 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 				__entry->openstateid_hash = 0;
 			}
 			if (inode != NULL) {
-				__entry->fileid = NFS_FILEID(inode);
+				__entry->fileid = inode->i_ino;
 				__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			} else {
 				__entry->fileid = 0;
 				__entry->fhandle = 0;
 			}
-			__entry->dir = NFS_FILEID(d_inode(ctx->dentry->d_parent));
+			__entry->dir = d_inode(ctx->dentry->d_parent)->i_ino;
 			__assign_str(name);
 		),
 
@@ -658,7 +658,7 @@ TRACE_EVENT(nfs4_cached_open,
 			const struct inode *inode = state->inode;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
 			__entry->stateid_seq =
@@ -703,7 +703,7 @@ TRACE_EVENT(nfs4_close,
 			const struct inode *inode = state->inode;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
 			__entry->error = error < 0 ? -error : 0;
@@ -759,7 +759,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
@@ -831,7 +831,7 @@ TRACE_EVENT(nfs4_set_lock,
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
@@ -922,7 +922,7 @@ TRACE_EVENT(nfs4_state_lock_reclaim,
 			const struct inode *inode = state->inode;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->state_flags = state->flags;
 			__entry->lock_flags = lock->ls_flags;
@@ -960,7 +960,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)fmode;
 		),
@@ -1087,7 +1087,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 
 			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
@@ -1137,7 +1137,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->error = -error;
 			__assign_str(name);
 		),
@@ -1185,7 +1185,7 @@ TRACE_EVENT(nfs4_lookupp,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->ino = NFS_FILEID(inode);
+			__entry->ino = inode->i_ino;
 			__entry->error = error < 0 ? -error : 0;
 		),
 
@@ -1220,8 +1220,8 @@ TRACE_EVENT(nfs4_rename,
 
 		TP_fast_assign(
 			__entry->dev = olddir->i_sb->s_dev;
-			__entry->olddir = NFS_FILEID(olddir);
-			__entry->newdir = NFS_FILEID(newdir);
+			__entry->olddir = olddir->i_ino;
+			__entry->newdir = newdir->i_ino;
 			__entry->error = error < 0 ? -error : 0;
 			__assign_str(oldname);
 			__assign_str(newname);
@@ -1258,7 +1258,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_event,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error < 0 ? -error : 0;
 		),
@@ -1311,7 +1311,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
@@ -1421,7 +1421,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 			__entry->error = error < 0 ? -error : 0;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (!IS_ERR_OR_NULL(inode)) {
-				__entry->fileid = NFS_FILEID(inode);
+				__entry->fileid = inode->i_ino;
 				__entry->dev = inode->i_sb->s_dev;
 			} else {
 				__entry->fileid = 0;
@@ -1478,7 +1478,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			__entry->error = error < 0 ? -error : 0;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (!IS_ERR_OR_NULL(inode)) {
-				__entry->fileid = NFS_FILEID(inode);
+				__entry->fileid = inode->i_ino;
 				__entry->dev = inode->i_sb->s_dev;
 			} else {
 				__entry->fileid = 0;
@@ -1655,7 +1655,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			const struct pnfs_layout_segment *lseg = hdr->lseg;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = hdr->args.offset;
 			__entry->arg_count = hdr->args.count;
@@ -1727,7 +1727,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			const struct pnfs_layout_segment *lseg = hdr->lseg;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = hdr->args.offset;
 			__entry->arg_count = hdr->args.count;
@@ -1795,7 +1795,7 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			const struct pnfs_layout_segment *lseg = data->lseg;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
@@ -1857,7 +1857,7 @@ TRACE_EVENT(nfs4_layoutget,
 			const struct inode *inode = d_inode(ctx->dentry);
 			const struct nfs4_state *state = ctx->state;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->iomode = args->iomode;
 			__entry->offset = args->offset;
@@ -1957,7 +1957,7 @@ TRACE_EVENT(pnfs_update_layout,
 		),
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->pos = pos;
 			__entry->count = count;
@@ -2012,7 +2012,7 @@ DECLARE_EVENT_CLASS(pnfs_layout_event,
 		),
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->pos = pos;
 			__entry->count = count;
@@ -2194,7 +2194,7 @@ DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 			__entry->error = -error;
 			__entry->nfs_error = hdr->res.op_status;
 			__entry->fhandle = nfs_fhandle_hash(hdr->args.fh);
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->offset = hdr->args.offset;
 			__entry->count = hdr->args.count;
@@ -2258,7 +2258,7 @@ TRACE_EVENT(ff_layout_commit_error,
 			__entry->error = -error;
 			__entry->nfs_error = data->res.op_status;
 			__entry->fhandle = nfs_fhandle_hash(data->args.fh);
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
@@ -2423,7 +2423,7 @@ TRACE_EVENT(nfs4_llseek,
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
 			__field(u32, fhandle)
-			__field(u32, fileid)
+			__field(u64, fileid)
 			__field(dev_t, dev)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
@@ -2434,10 +2434,9 @@ TRACE_EVENT(nfs4_llseek,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
 			const struct nfs_fh *fh = args->sa_fh;
 
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset_s = args->sa_offset;
@@ -2499,7 +2498,7 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
 			__entry->offset = args->falloc_offset;
 			__entry->len = args->falloc_length;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
 				be32_to_cpu(args->falloc_stateid.seqid);
@@ -2568,14 +2567,11 @@ TRACE_EVENT(nfs4_copy,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *src_nfsi = NFS_I(src_inode);
-			const struct nfs_inode *dst_nfsi = NFS_I(dst_inode);
-
-			__entry->src_fileid = src_nfsi->fileid;
+			__entry->src_fileid = src_inode->i_ino;
 			__entry->src_dev = src_inode->i_sb->s_dev;
 			__entry->src_fhandle = nfs_fhandle_hash(args->src_fh);
 			__entry->src_offset = args->src_pos;
-			__entry->dst_fileid = dst_nfsi->fileid;
+			__entry->dst_fileid = dst_inode->i_ino;
 			__entry->dst_dev = dst_inode->i_sb->s_dev;
 			__entry->dst_fhandle = nfs_fhandle_hash(args->dst_fh);
 			__entry->dst_offset = args->dst_pos;
@@ -2666,14 +2662,11 @@ TRACE_EVENT(nfs4_clone,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *src_nfsi = NFS_I(src_inode);
-			const struct nfs_inode *dst_nfsi = NFS_I(dst_inode);
-
-			__entry->src_fileid = src_nfsi->fileid;
+			__entry->src_fileid = src_inode->i_ino;
 			__entry->src_dev = src_inode->i_sb->s_dev;
 			__entry->src_fhandle = nfs_fhandle_hash(args->src_fh);
 			__entry->src_offset = args->src_offset;
-			__entry->dst_fileid = dst_nfsi->fileid;
+			__entry->dst_fileid = dst_inode->i_ino;
 			__entry->dst_dev = dst_inode->i_sb->s_dev;
 			__entry->dst_fhandle = nfs_fhandle_hash(args->dst_fh);
 			__entry->dst_offset = args->dst_offset;
@@ -2724,7 +2717,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
 			__field(u32, fhandle)
-			__field(u32, fileid)
+			__field(u64, fileid)
 			__field(dev_t, dev)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
@@ -2733,9 +2726,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		),
 
 		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
-
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(args->cna_src_fh);
 			__entry->stateid_seq =
@@ -2830,7 +2821,7 @@ DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_fast_assign(
 			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__assign_str(name);
 		),
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index ff467959f733..4ada21f4eebd 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -80,7 +80,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->cache_validity = nfsi->cache_validity;
@@ -121,7 +121,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->type = nfs_umode_to_dtype(inode->i_mode);
 			__entry->version = inode_peek_iversion_raw(inode);
@@ -211,7 +211,7 @@ TRACE_EVENT(nfs_access_exit,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->type = nfs_umode_to_dtype(inode->i_mode);
 			__entry->version = inode_peek_iversion_raw(inode);
@@ -265,7 +265,7 @@ DECLARE_EVENT_CLASS(nfs_update_size_class,
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->cur_size = i_size_read(inode);
 			__entry->new_size = new_size;
@@ -317,7 +317,7 @@ DECLARE_EVENT_CLASS(nfs_inode_range_event,
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->range_start = range_start;
 			__entry->range_end = range_end;
@@ -371,7 +371,7 @@ DECLARE_EVENT_CLASS(nfs_readdir_event,
 			const struct nfs_inode *nfsi = NFS_I(dir);
 
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = dir->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(dir);
 			if (cookie != 0)
@@ -429,9 +429,9 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->flags = flags;
-			__entry->fileid = d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dentry));
+			__entry->fileid = d_is_negative(dentry) ? 0 : d_inode(dentry)->i_ino;
 			__assign_str(name);
 		),
 
@@ -476,10 +476,10 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->error = error < 0 ? -error : 0;
 			__entry->flags = flags;
-			__entry->fileid = d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dentry));
+			__entry->fileid = d_is_negative(dentry) ? 0 : d_inode(dentry)->i_ino;
 			__assign_str(name);
 		),
 
@@ -532,7 +532,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name);
@@ -571,7 +571,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_fast_assign(
 			__entry->error = -error;
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned long)ctx->mode;
 			__assign_str(name);
@@ -608,7 +608,7 @@ TRACE_EVENT(nfs_create_enter,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->flags = flags;
 			__assign_str(name);
 		),
@@ -644,7 +644,7 @@ TRACE_EVENT(nfs_create_exit,
 		TP_fast_assign(
 			__entry->error = -error;
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->flags = flags;
 			__assign_str(name);
 		),
@@ -676,7 +676,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__assign_str(name);
 		),
 
@@ -714,7 +714,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->error = error < 0 ? -error : 0;
 			__assign_str(name);
 		),
@@ -768,8 +768,8 @@ TRACE_EVENT(nfs_link_enter,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
-			__entry->dir = NFS_FILEID(dir);
+			__entry->fileid = inode->i_ino;
+			__entry->dir = dir->i_ino;
 			__assign_str(name);
 		),
 
@@ -803,8 +803,8 @@ TRACE_EVENT(nfs_link_exit,
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = NFS_FILEID(inode);
-			__entry->dir = NFS_FILEID(dir);
+			__entry->fileid = inode->i_ino;
+			__entry->dir = dir->i_ino;
 			__entry->error = error < 0 ? -error : 0;
 			__assign_str(name);
 		),
@@ -840,8 +840,8 @@ DECLARE_EVENT_CLASS(nfs_rename_event,
 
 		TP_fast_assign(
 			__entry->dev = old_dir->i_sb->s_dev;
-			__entry->old_dir = NFS_FILEID(old_dir);
-			__entry->new_dir = NFS_FILEID(new_dir);
+			__entry->old_dir = old_dir->i_ino;
+			__entry->new_dir = new_dir->i_ino;
 			__assign_str(old_name);
 			__assign_str(new_name);
 		),
@@ -889,8 +889,8 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 		TP_fast_assign(
 			__entry->dev = old_dir->i_sb->s_dev;
 			__entry->error = -error;
-			__entry->old_dir = NFS_FILEID(old_dir);
-			__entry->new_dir = NFS_FILEID(new_dir);
+			__entry->old_dir = old_dir->i_ino;
+			__entry->new_dir = new_dir->i_ino;
 			__assign_str(old_name);
 			__assign_str(new_name);
 		),
@@ -943,7 +943,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 			struct inode *dir = d_inode(data->dentry->d_parent);
 			size_t len = data->args.name.len;
 			__entry->dev = dir->i_sb->s_dev;
-			__entry->dir = NFS_FILEID(dir);
+			__entry->dir = dir->i_ino;
 			__entry->error = -error;
 			memcpy(__get_str(name),
 				data->args.name.name, len);
@@ -981,7 +981,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = offset;
@@ -1031,7 +1031,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = offset;
@@ -1109,7 +1109,7 @@ DECLARE_EVENT_CLASS(nfs_kiocb_event,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = iocb->ki_pos;
@@ -1160,7 +1160,7 @@ TRACE_EVENT(nfs_aop_readahead,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->offset = pos;
@@ -1199,7 +1199,7 @@ TRACE_EVENT(nfs_aop_readahead_done,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
 			__entry->nr_pages = nr_pages;
@@ -1239,7 +1239,7 @@ TRACE_EVENT(nfs_initiate_read,
 			__entry->offset = hdr->args.offset;
 			__entry->count = hdr->args.count;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1284,7 +1284,7 @@ TRACE_EVENT(nfs_readpage_done,
 			__entry->res_count = hdr->res.count;
 			__entry->eof = hdr->res.eof;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1330,7 +1330,7 @@ TRACE_EVENT(nfs_readpage_short,
 			__entry->res_count = hdr->res.count;
 			__entry->eof = hdr->res.eof;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1377,7 +1377,7 @@ TRACE_EVENT(nfs_pgio_error,
 		__entry->arg_count = hdr->args.count;
 		__entry->res_count = hdr->res.count;
 		__entry->dev = inode->i_sb->s_dev;
-		__entry->fileid = nfsi->fileid;
+		__entry->fileid = inode->i_ino;
 		__entry->fhandle = nfs_fhandle_hash(fh);
 	),
 
@@ -1416,7 +1416,7 @@ TRACE_EVENT(nfs_initiate_write,
 			__entry->count = hdr->args.count;
 			__entry->stable = hdr->args.stable;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1467,7 +1467,7 @@ TRACE_EVENT(nfs_writeback_done,
 				&verf->verifier,
 				NFS4_VERIFIER_SIZE);
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1507,7 +1507,7 @@ DECLARE_EVENT_CLASS(nfs_page_class,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->req = req;
 			__entry->offset = req_offset(req);
@@ -1555,7 +1555,7 @@ DECLARE_EVENT_CLASS(nfs_page_error_class,
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->offset = req_offset(req);
 			__entry->count = req->wb_bytes;
@@ -1609,7 +1609,7 @@ TRACE_EVENT(nfs_initiate_commit,
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1655,7 +1655,7 @@ TRACE_EVENT(nfs_commit_done,
 				&verf->verifier,
 				NFS4_VERIFIER_SIZE);
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 		),
 
@@ -1701,7 +1701,7 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 			const struct nfs_fh *fh = &nfsi->fh;
 
 			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
+			__entry->fileid = inode->i_ino;
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = dreq->io_start;
 			__entry->count = dreq->count;
@@ -1765,7 +1765,7 @@ DECLARE_EVENT_CLASS(nfs_local_dio_class,
 		const struct nfs_fh *fh = &nfsi->fh;
 
 		__entry->dev = inode->i_sb->s_dev;
-		__entry->fileid = nfsi->fileid;
+		__entry->fileid = inode->i_ino;
 		__entry->fhandle = nfs_fhandle_hash(fh);
 		__entry->offset = offset;
 		__entry->count = count;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 4a87b2fdb2e6..7dd478ffc2fa 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -759,7 +759,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 	dprintk("NFS: initiated pgio call "
 		"(req %s/%llu, %u bytes @ offset %llu)\n",
 		hdr->inode->i_sb->s_id,
-		(unsigned long long)NFS_FILEID(hdr->inode),
+		(unsigned long long)hdr->inode->i_ino,
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
 
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 743467e9ba20..fdedeff5f6cc 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2373,7 +2373,7 @@ pnfs_update_layout(struct inode *ino,
 	dprintk("%s: inode %s/%llu pNFS layout segment %s for "
 			"(%s, offset: %llu, length: %llu)\n",
 			__func__, ino->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(ino),
+			(unsigned long long)ino->i_ino,
 			IS_ERR_OR_NULL(lseg) ? "not found" : "found",
 			iomode==IOMODE_RW ?  "read/write" : "read-only",
 			(unsigned long long)pos,
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index df3ca4669df6..7f2e84eaaa9f 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -461,7 +461,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
 		goto out;
 
-	fileid = NFS_FILEID(d_inode(dentry));
+	fileid = d_inode(dentry)->i_ino;
 
 	sdentry = NULL;
 	do {
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3134bb17f3e3..9035bb8a0216 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1817,7 +1817,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 
 		dprintk("NFS:       commit (%s/%llu %d@%lld)",
 			nfs_req_openctx(req)->dentry->d_sb->s_id,
-			(unsigned long long)NFS_FILEID(d_inode(nfs_req_openctx(req)->dentry)),
+			(unsigned long long)d_inode(nfs_req_openctx(req)->dentry)->i_ino,
 			req->wb_bytes,
 			(long long)req_offset(req));
 		if (status < 0) {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6d6fa62ede10..83063f4ab488 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -394,16 +394,6 @@ static inline int NFS_STALE(const struct inode *inode)
 	return test_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
 }
 
-static inline __u64 NFS_FILEID(const struct inode *inode)
-{
-	return inode->i_ino;
-}
-
-static inline void set_nfs_fileid(struct inode *inode, __u64 fileid)
-{
-	inode->i_ino = fileid;
-}
-
 static inline void nfs_mark_for_revalidate(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);

-- 
2.54.0


