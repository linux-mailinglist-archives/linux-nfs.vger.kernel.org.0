Return-Path: <linux-nfs+bounces-9585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F203AA1B8A7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB1E16AB8F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46310136E09;
	Fri, 24 Jan 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abulXpTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C2111AD
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731758; cv=none; b=jA/gSkVV0836s0rjWPc2xS5qAqpmDHxLJuugiyG5b+hAI/B4YUYgTpiO9OJOlol+Qgw+hsFFq6ty2xGeGvmy/GkAA3UgIo0P2GhHxdXEtoHoItHF9sgxOhJgAbv7W9fsQGoeKSP24vK/q2OPWSNR9cYQxSm38yJBnzoVnyILZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731758; c=relaxed/simple;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNEvdTeR/Z+n8uAb8/wOOq1/ZHdQGzAucg8d/I2oz6UD6pGdos31V2VJFVELWFwXjtTqyI7P9Cfbw8ps4s8iAOAZOkb3hLUuIYCyyhonD9JDD9J0GtQi4ePY5Aj2cUwZNYj8zOFbguOHJIZBsu1JzvVv3fEHjPxUD07+5XXOT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abulXpTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F3C4CEE5;
	Fri, 24 Jan 2025 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737731757;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abulXpTXcei/izbehih3RSjmRSbYrlRfkpVHFkm66AGqinn+BqwXBa5IrJKUUA6WN
	 U35Zh0QAjiZMy8Zmn3hm9Nhm1ohkRdtcerG4FoDhBxkwSP9IdjaiYuwI3Ac2RiySqv
	 bfM5rGV3cdQGc2N/2moAhmwAVKLInATxI3gjaW5BDMmsNf++hn7y9bH/D8l13x4xi/
	 TBZGDQ6bDeEOmGxy6CzDbfAJipiDr8n8/Ia9Tpn35Wj6E8cy1DaJQNh2BxGxKAwi+A
	 glQGu3VuOx33w0/lQdfTb93YOO3gn0cjzTVX4L72hgSswWMbax1mAda9KgSveW0Ay/
	 2zYGti7cQXaBQ==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/4] NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
Date: Fri, 24 Jan 2025 10:15:50 -0500
Message-ID: <20250124151553.17824-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124151553.17824-1-cel@kernel.org>
References: <20250124151553.17824-1-cel@kernel.org>
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


