Return-Path: <linux-nfs+bounces-9638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78427A1CEDE
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C87166886
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8A14A0A3;
	Sun, 26 Jan 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4wcSADj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079825A64F
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928225; cv=none; b=P1SDx+sD6CdKIjwtZkb+annX7h/hVq0POLXyaNVop0yikaclXut/pVDprqrI4dP7CqJnQyq+Zva43k1imYHnssTqTfe2drMqjLSl5D0qxc5iXU1qzIh7PsT1VW+wIOvSXaLxGwIkgYHi3n0DKSYeXtnKR1veAbZcs8+HjUBJHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928225; c=relaxed/simple;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG41/D2xb344leueQOr3kIkmFRio6rKcOS7UxJEJ4TT4X2ebHm20RHgQRE4iSy+MmNwrv4v6MHG/U7VQWtza3GVN9Jf0iaClY/y4D9c7XqH53Gmp4zQyrQbdgdzXE2ljlexfcAZbuotPKRCzWnBLSUh5PloQMUPCSS5LPEUu9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4wcSADj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373CCC4CEE4;
	Sun, 26 Jan 2025 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737928225;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4wcSADjRo1wtHCtZRF/OeQb8X1RvfxN5H56SFfsfMYXdIK5e/Sq0tQUG+eGx1Aw9
	 ojFR/kzghX/NoXuuSLWEV3iqpSfQxzAK3wMTYxhQ3lzC8s+3aua+OoHogloyjvNMO7
	 ABm/y/MS/WL7Ah8fi6I5oL03TWkQvMrNlIGJtphvO+vf40w6X448GiLaU9IRl0pCQy
	 TYhbeJOn8yVzzmRL5fhQS/dc2Cr0acwnc3SphIkVfgoITxWDGYIUQAjYKl8R7xmWA5
	 5M1cxo0g5K/J/Cjoclb+2QDIw3YuyBIVUgQQphEPEl7A525o3Mqh2aHKQ+2YwLmob0
	 q8qgrDMDYvmrw==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/4] NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
Date: Sun, 26 Jan 2025 16:50:17 -0500
Message-ID: <20250126215020.2466-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126215020.2466-1-cel@kernel.org>
References: <20250126215020.2466-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If fh_fill_pre_attrs() returns a non-zero status, the error flow
takes it through out_unlock, which then overwrites the returned
status code with

	err = nfserrno(host_err);

Fixes: a332018a91c4 ("nfsd: handle failure to collect pre/post-op attrs more sanely")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..2d8e27c225f9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2011,11 +2011,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		 * error status.
 		 */
 		err = nfserr_file_open;
-	} else {
-		err = nfserrno(host_err);
 	}
 out:
-	return err;
+	return err != nfs_ok ? err : nfserrno(host_err);
 out_unlock:
 	inode_unlock(dirp);
 	goto out_drop_write;
-- 
2.47.0


