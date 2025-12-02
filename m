Return-Path: <linux-nfs+bounces-16856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A80C9D3CB
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 838D33475CC
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4B2FAC17;
	Tue,  2 Dec 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A53o8nWA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C52F691E
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715332; cv=none; b=S3DYJh+cFazPCAls5dmX8PsLfzlv2wsUGdYry/QQaIVg5ayxgIm5luaVN9dX8xIFgbRqQLtk8gNiaxFKuU3vd38vHe7oln8vUTyiTwX59VDs2kyAV2Gi0gNime5KVuw+UlJgP45juHliUGBSFW4E/nr2KsDV5IOpO/0Md8KbVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715332; c=relaxed/simple;
	bh=j4dty+LYN+S9YvKiR9+nkWOHDtz/PtjtO4y/cGgIRhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhaSin29PG3qk8u8swVTj7+qR4zIWIlgckgybuPncC8H4PN5L9ExJ77pPNb6U+wd2yw+AFk7mt0Ok59/bWZIgfEL0fIeBfiCMca7A/R2372BrKikgseSGUtAm3826TH89XZJ9QkQPk/E9lCe14sm6N2qeuGFKlDC+rcbWykY34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A53o8nWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0927CC113D0;
	Tue,  2 Dec 2025 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764715331;
	bh=j4dty+LYN+S9YvKiR9+nkWOHDtz/PtjtO4y/cGgIRhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A53o8nWACfxAg2CpPSh/6zL6LGqDcyiQKKYkyI2nNPI8icdocy0OUfmUEiR2tBINX
	 tyrZh35BSJBX4bqmoAzbtUCM0D9bzQEHKUuI0dCzi9o2M0jsTom5PYvIgPnJ+jPUBs
	 gMg24lprfG4wALOqoPRRbXV75cobCxxY/VV6Njm8BXjXTxdOLDpu7BDLtMII/AVOY5
	 4mr93EvgD1XsNqkslrIcQbAsXcrQiZrGk6JhPuw9gIP+mQqNX7cnPQuQZjF0TBB/7v
	 KATAcCO7XUJX+2Lm+yVBjF2vVj6dCgiwYzTzw0a6z1DV4qhVZl2GXXcvhbI0CY4PW/
	 Wvy/KLxvz5kCw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] NFSD: WARN if fi_fds[O_RDONLY] is already populated
Date: Tue,  2 Dec 2025 17:42:08 -0500
Message-ID: <20251202224208.4449-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202224208.4449-1-cel@kernel.org>
References: <20251202224208.4449-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_add_rdaccess_to_wrdeleg() expects that fi_fds[O_RDONLY] is
NULL. If it's not NULL, there's a software bug somewhere else that
needs to be looked into.

Replace the redundant fp assignment with a WARN_ON_ONCE.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1c9802d06de1..b8fd0ed3fd53 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6236,7 +6236,7 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		fp = stp->st_stid.sc_file;
 		spin_lock(&fp->fi_lock);
 		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
-		fp = stp->st_stid.sc_file;
+		WARN_ON_ONCE(fp->fi_fds[O_RDONLY] != NULL);
 		fp->fi_fds[O_RDONLY] = nf;
 		fp->fi_rdeleg_file = nf;
 		spin_unlock(&fp->fi_lock);
-- 
2.52.0


