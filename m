Return-Path: <linux-nfs+bounces-8399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D859E7B16
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8DA166EBE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455A20459D;
	Fri,  6 Dec 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+3LlGgD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2B22C6D0
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520997; cv=none; b=L0A5mVDPdhq3qE+o5vy0vBZLfyXLU6HI7se0ZoFL/K7/IhRi/UW+U/w+WrKhgWeSHaNUf8A/0ocYjpLf30ld5Q9cctkpGo/9Pq9rCzLS+ChqqUeNUhFawvMoLSKxU+ULVNWKvfVoCrbhnLBpj5Jg9p6BToQV/71oFaS10ocm0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520997; c=relaxed/simple;
	bh=nY2ZDmXqBtbg0vgJ6KAuFjLBbzS46bjSItdCuV41NT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYMCn9pYtKFurlrOfvh0ENeGsAzqrah0Ljlb9ErBYGbEs2xpraL4/U+X1KLfGeA3R3GWuHozUgi1e4sf/yuy/n0jdLwScHM+kxrm3cXhpzXLFAjPXlGWHyQVX7/VbFFKM2PfWZFno0hOm7cX+JdgRdyU/QmyaQij15KKv7BGGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+3LlGgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E3C4CED1;
	Fri,  6 Dec 2024 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733520997;
	bh=nY2ZDmXqBtbg0vgJ6KAuFjLBbzS46bjSItdCuV41NT4=;
	h=From:To:Cc:Subject:Date:From;
	b=M+3LlGgDppsNYtVyx5xBLPiuhADh67dKweg69XWsozyKkcdzwqdosofqsycEh226w
	 bZ06YQ4doIkZLOvZ5XGlrMPdiAmcVxcxc+zpRUtUEMDydr/SQyM0c/y2FN5OeKub00
	 jcOYL0paTZ6v1pm/EkUj1N452Q9H8CZ8IAHv8h7OyGzP1ypJJBhjeETfMBMmI5UvNd
	 wYLsbxRmI/wbzNmHXEPkgHLukD2UBrkOVOu7sRg40hwRiwctFDcg2L3qDoFT13Su9a
	 X2c/GnADCwOG5XTF/SnCykHwUU7qCEzYshRZXjkoso0D6Znvu+Mm/TtwcNhc72UWH7
	 iCaCwkuyheOFQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Clean up unused variable
Date: Fri,  6 Dec 2024 16:36:33 -0500
Message-ID: <20241206213633.405299-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

@sb should have been removed by commit 7e64c5bc497c ("NLM/NFSD: Fix
lock notifications for async-capable filesystems").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 741b9449f727..1272a1fafeb8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7966,7 +7966,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
-	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -7986,7 +7985,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
 	if (status != nfs_ok)
 		return status;
-	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
-- 
2.47.0


