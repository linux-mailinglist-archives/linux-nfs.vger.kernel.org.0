Return-Path: <linux-nfs+bounces-3172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D48BD2F0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAFD2824A5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5297868B;
	Mon,  6 May 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ0N4Wo7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22342AA0
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013369; cv=none; b=V51AFP6xsPiypHJcSS62ntDEo3VjkcynNtM2Q5ZfFJAcCsqFlx8LduZga5GQrQPRc7kMjb0FctGeOKq5osBVkgYEpaq4S37mri/RYfRWq3DgKj1Kw3GL+o9WYndTlNUM/Rxk87xu8eF6l6xMuY/aefhOuq0UtEwEpFuCPyJeN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013369; c=relaxed/simple;
	bh=4iFvIyqyy+Zk2ziHZSC2tI7nfrXhtwBKLlPyAf//K88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuyWisLQ/ag0T9ZFV5A6cCX+tWVI/oBW15NDdRtpl9W2HLczpH+H+RMcBf6cgeH5Lkc4ajAWL+HbvUdT4QKrlaJrNJEIfZor5f8oyRAxCOG2DpXSqXg00XXQZU4VSX9QkS/j054eWPlGAoT7DlLPZEdCGwTg5Z+D6iWAfFWpWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ0N4Wo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D6C116B1;
	Mon,  6 May 2024 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715013368;
	bh=4iFvIyqyy+Zk2ziHZSC2tI7nfrXhtwBKLlPyAf//K88=;
	h=From:To:Cc:Subject:Date:From;
	b=HZ0N4Wo7SkbWCSVDhtwn+sWl/ozcV0fGOB548s4WXEX4l857aR135/NskoiTYDh7t
	 dI+as4DraQU4C6a7H2lHHrGXjRpVwIKRlT1f9EyyqMHEuuhuydYG785WSqGLBjJYTN
	 0n10UlAghVGfZOlkuGn1xUDsEQpsp0BPVV4lv8OkIH6sOAn2flkGVrBIGbwCuzEtvx
	 o6kAnRUjTrroZgbZBy61iuJ0+zAX+ZFay5Ji2BE4DKT4q/2Q99921C+tpjtDj/m0L2
	 l+5cx10TKY/PzGZwz+LcheObAy0o2/tINJ9o7vgkB0i9c0kNNogh0uNfU/EG6Nv7IX
	 ceFCsN0QwBJNA==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] knfsd: LOOKUP can return an illegal error value
Date: Mon,  6 May 2024 12:30:04 -0400
Message-ID: <20240506163005.9990-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The 'NFS error' NFSERR_OPNOTSUPP is not described by any of the official
NFS related RFCs, but appears to have snuck into some older .x files for
NFSv2.
Either way, it is not in RFC1094, RFC1813 or any of the NFSv4 RFCs, so
should not be returned by the knfsd server, and particularly not by the
"LOOKUP" operation.

Instead, let's return NFSERR_STALE, which is more appropriate if the
filesystem encodes the filehandle as FILEID_INVALID.

Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index dbfa0ac13564..d41e7630eb7a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -572,7 +572,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 		_fh_update(fhp, exp, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
 		fh_put(fhp);
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	}
 
 	return 0;
@@ -598,7 +598,7 @@ fh_update(struct svc_fh *fhp)
 
 	_fh_update(fhp, fhp->fh_export, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	return 0;
 out_bad:
 	printk(KERN_ERR "fh_update: fh not verified!\n");
-- 
2.45.0


