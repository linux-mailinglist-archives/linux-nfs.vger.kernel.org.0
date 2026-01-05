Return-Path: <linux-nfs+bounces-17459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE7CF5896
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 21:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C956F30559DB
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7B25783A;
	Mon,  5 Jan 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/ZRssUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30E3D561;
	Mon,  5 Jan 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645388; cv=none; b=TL6h0ReGGvsjrXt2drth69zewqKwamhhpZ4cn5/WccrsE1fzSMRJ1pnpBtcykjdYcfzFznm9buqH0OtfmDCIlBpbNeBJDd91BynsqiV23xrpn2F6t+j92OGZPvCosPxxTzH7z2+MkLMceDFiteoRHpMcDI7AdoSCG4FuD5l2Kgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645388; c=relaxed/simple;
	bh=iis2Fo8pBFndr/Jl7CzIwiOy1E8dXCovasz7XB33ifA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfAfVJja+SckE0Y/t+XsXTUPv3lxbEVgmu82UYjmpe46Y74xbd5Tw/qn9J2QiSnyKfUzo+cF6INoDzXsSLplBofyPERQfSQUJWHpYMKPjOQhC5DMUeRy8Ghh1QAlgXoOgavFA7Ntv7rcN+Z2iHd/cWxmCYocG003hXCUYCCzdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/ZRssUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCFEC116D0;
	Mon,  5 Jan 2026 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645388;
	bh=iis2Fo8pBFndr/Jl7CzIwiOy1E8dXCovasz7XB33ifA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/ZRssUtaF/R2YasnYNLSwe+ktcRmGbRU+Wy4A5HaP+yGlBSPhAiEGOAvUleOgU+c
	 slhDiD/cZ9X0AsfxybzwKBR1/U/VAGPBfJI4yugb41gtRxZjnySvPksoviUVnvhNlv
	 z376aGVGMvYK+m2+jKsWAPNadLF/X3+SNZuMQAgQ18rjXTnVWJvZ2Z2diDfMda4Xl0
	 GWsRBOVKzz06OfQ13Xw+bjWpg9T2DjP0hIG+CnFzjCVVfCs7IaJiBkbIardjkEXSK4
	 hrj605ZQiiKv6ZmKAM6spVdbUYqj+l+U5x1MdQpF8RYHw8Vi3wj4aqRskPIVvIhSR6
	 1WxjpPM+mZ1rg==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Aurelien Couderc <aurelien.couderc2002@gmail.com>
Subject: [PATCH 5.10.y] NFSD: NFSv4 file creation neglects setting ACL
Date: Mon,  5 Jan 2026 15:36:25 -0500
Message-ID: <20260105203625.3562597-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122943-shuffling-jailhouse-320b@gregkh>
References: <2025122943-shuffling-jailhouse-320b@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 913f7cf77bf14c13cfea70e89bcb6d0b22239562 ]

An NFSv4 client that sets an ACL with a named principal during file
creation retrieves the ACL afterwards, and finds that it is only a
default ACL (based on the mode bits) and not the ACL that was
requested during file creation. This violates RFC 8881 section
6.4.1.3: "the ACL attribute is set as given".

The issue occurs in nfsd_create_setattr(). On 6.1.y, the check to
determine whether nfsd_setattr() should be called is simply
"iap->ia_valid", which only accounts for iattr changes. When only
an ACL is present (and no iattr fields are set), nfsd_setattr() is
skipped and the POSIX ACL is never applied to the inode.

Subsequently, when the client retrieves the ACL, the server finds
no POSIX ACL on the inode and returns one generated from the file's
mode bits rather than returning the originally-specified ACL.

Reported-by: Aurelien Couderc <aurelien.couderc2002@gmail.com>
Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: stable@vger.kernel.org
[ cel: Adjust nfsd_create_setattr() instead of nfsd_attrs_valid() ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 54be4cd9794a..7739a47356e7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1335,7 +1335,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * Callers expect new file metadata to be committed even
 	 * if the attributes have not changed.
 	 */
-	if (iap->ia_valid)
+	if (iap->ia_valid || attrs->na_pacl || attrs->na_dpacl)
 		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
 	else
 		status = nfserrno(commit_metadata(resfhp));
-- 
2.52.0


