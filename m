Return-Path: <linux-nfs+bounces-7162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391899D75E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83023B23712
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70B1CC891;
	Mon, 14 Oct 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhXZSvgg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238A1CC171;
	Mon, 14 Oct 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934031; cv=none; b=nKlmW290Dmkb7Wpt8TT/qvSIaE2aLrIK/GETAUeuKjYa6vgIFSpSotnDvzobXBGZiNZSul83iMmXVVRm/NbadmpXB1V6a17+gwdTE6p2166CXn9SK6AsUD6EyKRMeRGhR6kar1nUAY1qyHIOvG0C6Q9V1r+2wehmKoZmxsMzMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934031; c=relaxed/simple;
	bh=1cZQdIadKpzmPqf4keXqTpqP8NkguLKE4M/N9rCqvlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAAYtRh0fsTzzHgG/peW+n5pxWHimYU1P0XTtfBji1RPRrHOoJTpeQRKuZ+hiU6wU9+YzsDnSYl5mcdMVjuewkL4e0qL6mMmeou57cwqO6MpouPlzfULUbJDhjmZ2lEhWMcHk3DM+CdZZrUi1ekaQqLyhnyncVUC1saj6qHSXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhXZSvgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7667C4CECE;
	Mon, 14 Oct 2024 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934030;
	bh=1cZQdIadKpzmPqf4keXqTpqP8NkguLKE4M/N9rCqvlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XhXZSvggrwkGg3A4+D3o3WOg3znJcWYwHZqbM0/7C3dEkNm/QTvjCOIr0CFjN7vZt
	 ZEn4J14ikLSnkkJ8HfNCMsihYr5mJGwLzSeDrzJwWRfVZB+MLVYOCUC13DBEGnOwGa
	 XjYkbiKSND7468lbS9e2j7jHgnXyZke67KXX6ycNWx29JLPWYCskb7j1gyDPzlQDnV
	 5WN4X++OBk2iVsLYtPUYIufIFhP48fqAzTAfz6QfWL9YsQDPo2XzG4A+JDAc8zW9Sl
	 OQNq5L1pc7bs2mEnnZAf2THm2tmKaTcBQa3+IcLmBmZWGdTwc1QT27fcuD9oFKECu+
	 ULlGUxTt4Kyfw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 15:26:49 -0400
Subject: [PATCH 1/6] nfsd: drop inode parameter from
 nfsd4_change_attribute()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-delstid-v1-1-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4622; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1cZQdIadKpzmPqf4keXqTpqP8NkguLKE4M/N9rCqvlg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCLT0dAzlFteihjm2O9Qb1MRQu0EYhp03Qak
 GVxiTscCZqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1wiwAKCRAADmhBGVaC
 FVu4D/4sziuaQH4/Y/LoEsDPwa3YHhry+1uCPqDnfsQBAaho3IeY9+luxj6a/XqD3ST7cuGpOqC
 HC7bs4ZLn2FwxOYDAaBs8kFgyHW/G6Axj1k5/HZF4XJjY7yOweZrNXZwMcTfdIKR+0F3OZi9waf
 P1ZhQO4ElWHky1/4HtaLDqPTU1DFDRXYpD3aUKyyFqlKsX76Tg+0Pa/eec+qwz4ktNv/kaVdCVX
 pcTPZP65XO24mTCTT8jRPMMnQqX56lVmRPm+4aEckepJl17nEAM17cwQqX7aGxuk/P8TMRR/VFj
 B0Y6yI2ZzVhBNGQS7+2CPYwHhwVcpP4rpRG7s5CZFQY/CXc2YY/IiIjtxqJLuJSK+gpEpU4jOJF
 webnnRTvxF7ZrCpJttFWUyFWra3kS38JaSfsDW70uVHzUe6d9Q7Rlh19g5E0M/tctc0dfb4SNGt
 RYxJFJqowmW6BT3WFLOnB+mlW7m/6SXJ8JxgBT3/js8v6+qQw+yhMUUddTx1gEhDNjf/rZXR7mY
 y3TgXrq3/CtRawgjy2ug93rTTTGYFd9PvP7bbZo9XyOjZ+yCaIfJhjsKPtzSQabTlE/RgjJ+vfC
 Hwjy/du/C2KJ5vLnrqwOhaJcWjClzEyrxiMbuxTW0cNVhWPVimXWgFFzEfDtEH7hRtOJXOOowo5
 wFFZwzVNp989SrQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Fix up nfs4_delegation_stat() to fetch STATX_MODE, and then drop the
inode parameter from nfsd4_change_attribute(), since it's no longer
needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  5 ++---
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsfh.c     | 11 ++++-------
 fs/nfsd/nfsfh.h     |  3 +--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d753926db09eedf629fc3e0938f10b1a6fdb0245..2961a277a79c1f4cdb8c29a7c19abcb3305b61a1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5953,7 +5953,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	path.dentry = file_dentry(nf->nf_file);
 
 	rc = vfs_getattr(&path, stat,
-			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
 			 AT_STATX_SYNC_AS_STAT);
 
 	nfsd_file_put(nf);
@@ -6037,8 +6037,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		}
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
-		dp->dl_cb_fattr.ncf_initial_cinfo =
-			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6286ad2afa069f5274ffa352209b7d3c8c577dac..da7ec663da7326ad5c68a9c738b12d09cfcdc65a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3621,7 +3621,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.change_attr = ncf->ncf_initial_cinfo;
 		nfs4_put_stid(&dp->dl_stid);
 	} else {
-		args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
+		args.change_attr = nfsd4_change_attribute(&args.stat);
 	}
 
 	if (err)
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4c5deea0e9535f2b197aa6ca1786d61730d53c44..453b7b52317d538971ce41f7e0492e5ab28b236d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -670,20 +670,18 @@ fh_update(struct svc_fh *fhp)
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode;
 	struct kstat stat;
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return nfs_ok;
 
-	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err)
 		return err;
 
 	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
 
 	fhp->fh_pre_mtime = stat.mtime;
 	fhp->fh_pre_ctime = stat.ctime;
@@ -700,7 +698,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_no_wcc)
@@ -716,7 +713,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
-			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+			nfsd4_change_attribute(&fhp->fh_post_attr);
 	return nfs_ok;
 }
 
@@ -824,13 +821,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
  * assume that the new change attr is always logged to stable storage in some
  * fashion before the results can be seen.
  */
-u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
+u64 nfsd4_change_attribute(const struct kstat *stat)
 {
 	u64 chattr;
 
 	if (stat->result_mask & STATX_CHANGE_COOKIE) {
 		chattr = stat->change_cookie;
-		if (S_ISREG(inode->i_mode) &&
+		if (S_ISREG(stat->mode) &&
 		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
 			chattr += (u64)stat->ctime.tv_sec << 30;
 			chattr += stat->ctime.tv_nsec;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffdfb0eedf8fca56a20c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-u64 nfsd4_change_attribute(const struct kstat *stat,
-			   const struct inode *inode);
+u64 nfsd4_change_attribute(const struct kstat *stat);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
 __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);

-- 
2.47.0


