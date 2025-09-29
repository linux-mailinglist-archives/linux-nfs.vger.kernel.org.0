Return-Path: <linux-nfs+bounces-14774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20921BA9E46
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B41920AB1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88930C111;
	Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YorQWkFI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771630C10D
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161412; cv=none; b=SpwlfexPjyNgZBO1dphZ+7xjn92tdPu/P+lDyun8D2y7UDANu6HPIsE1R5D01cFxHy4PIBxvRtj1gt5H9uIfpRloSdwZZQsemdsqY/3TkldMwMY2WMtjtIj/Ceq9GeKt969cl1Acm/UZm20lMax0STQFGh9+pxjZbrMDelqlgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161412; c=relaxed/simple;
	bh=MjO5AYv8fbA+9EmKf6cWI2qhwn6mZD0rbNckjTji4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gC1UEIKSLfY3vNMmUHvq8bX+ESB3DEgeB4RBEmcwJFaz1hG9pVxvcsx/0BSJaRgRlrPhp44fgJjS8v54Y+3ug1giYjXKc+56uzO+czADIj3iHCMNDu/vuCOVMhc/nww5GPI8NA5BMbD1kh+jidv2y6R/r1+3F8vYcKNStifF6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YorQWkFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DF6C4CEF7;
	Mon, 29 Sep 2025 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161412;
	bh=MjO5AYv8fbA+9EmKf6cWI2qhwn6mZD0rbNckjTji4mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YorQWkFIIxmfN8v0/T0ha1zo3aLyqhX+sp/ss+tymXdYtpUDAE/MIRvi7YknW7646
	 UtjVVlUKynkKke6LoORxu/lyaAlO0HH7BJpsYEbct7O+9z2qimIztT/GF9y/aoVDeS
	 BGAicEDDAOzIzUUZqZ1AP2iitso8YZwC/01Epc+MCi12JikPxNzuxLbSIjC0zC36hP
	 e6aGkUem3GhAeNpvlc1boeSRmV4rN6S/IYYBUKiKHWcK92V6/jgRLM2dr+XmUpx2+3
	 bziy4B3Z7n5epQ+uQnXAIkvLWKbj1C6LCzTGUzRvVRbMbTV3tczMVtZxUyAV2fEtQB
	 TC0MBpgMkVDQQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 5/6] NFSD: Prevent a NULL pointer dereference in fh_getattr()
Date: Mon, 29 Sep 2025 11:56:45 -0400
Message-ID: <20250929155646.4818-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155646.4818-1-cel@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In general, fh_getattr() can be called after the target dentry has
gone negative. For a negative dentry, d_inode(p.dentry) will return
NULL. S_ISREG() will dereference that pointer.

Avoid this potential regression by using the d_is_reg() helper
instead.

Suggested-by: NeilBrown <neil@brown.name>
Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..16182936828f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.mnt		= fhp->fh_export->ex_path.mnt,
 		.dentry		= fhp->fh_dentry,
 	};
-	struct inode *inode = d_inode(p.dentry);
 	u32 request_mask = STATX_BASIC_STATS;
 
-	if (S_ISREG(inode->i_mode))
+	if (d_is_reg(p.dentry))
 		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
 
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
-- 
2.51.0


