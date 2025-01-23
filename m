Return-Path: <linux-nfs+bounces-9546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D4A1AABA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA31646E2
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB81ADC77;
	Thu, 23 Jan 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpS86fff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9277E105
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661968; cv=none; b=igXhE6lWi5Tk6jccvc0vjuwK2kv80VscJidGdfbp7bmiYVhVxyiKjgyNW5Oh8ECAHJAg2uEpr9zNT8nKlhSkA23ed5Lx5GhETqh6afKBSXQI72u/KIElAGS2r8bxBi6aKIs1rpwzHNKXMIrz0NkzdkZhb8jGPkKfwRyjFKsqEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661968; c=relaxed/simple;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmO0cOjOMex/dvNGYENkDIpwACisvQvCzKNNOCjfCoFgxk3mYrM218puIMzPFyaXJ1UoV5XhRghxjbdO4DzsBTTlCVmb6iN1Z0LStQQe+jqcU6PRhn1n+F/B00n0LqmbSHjjdJXyveViWjXZwCIOe1GivbAm2zB/KH06CFnfQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpS86fff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD36C4CEE2;
	Thu, 23 Jan 2025 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661967;
	bh=XlwZPYpGxHV1byldpoOY4wzN2rz/uZBFH3IV4T33LpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpS86fffG4nHpXYDlEv0RxfgiKrKKmpMJLnfK3BqfW5pasPMDvS3BfJYPMUWZ2ygD
	 aV6mNVHeSg/Vm+Q5eImnsI/RAYMCOZCZydYbjyYYiHQVxcIgPnX3IzyiNbPdwAUaWu
	 WLLARTwCCEIS3xwn+67iRcqWrPW2w6U/kZUZvOaNfGrj6GdaroX9aiPuJ0gBJzXzp2
	 GLXImV9AF0noe3eJ4NyCXeR0kpdsuVnimmRVq0ys3HUVAX3lz3uewJGJkb59NL7Z1m
	 k5aKDwvnG+nxPDMipFSgj+TfkBFBNCqCfA5ao4l7bn+AyizDDoDlLsmSusDjlIHiJg
	 EdrE52nYur1CA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/4] NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
Date: Thu, 23 Jan 2025 14:52:39 -0500
Message-ID: <20250123195242.1378601-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123195242.1378601-1-cel@kernel.org>
References: <20250123195242.1378601-1-cel@kernel.org>
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


