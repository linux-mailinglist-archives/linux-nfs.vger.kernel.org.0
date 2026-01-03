Return-Path: <linux-nfs+bounces-17420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77835CF052A
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A483302A10F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AD1FF5F9;
	Sat,  3 Jan 2026 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLMd24yR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2631F4613;
	Sat,  3 Jan 2026 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469153; cv=none; b=O9kUI0D5Svm3eWeLsNXfaJYPFvrndfZQNYVSCVusRoOU6gVgzNVX4OzOCtAWcgMHwphFUnfszJs6epVOwkF0qCpI/1tadZBTZRZ/AftWaIX0qJ5EzA1WAk2PJzK0AAf16/WCAanlivsCiSL1PhMj7jn5BIUVwkDad2tU+qOnbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469153; c=relaxed/simple;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hvu6sseOQDm7n+bhRPDIxGxrG7iTBAn6MPpd+T/QJadzjPp8Of/XmaYrMQuA1jvQA2n8kOTx4Mg5ITU8vMGtpa3pSs4Bwks1fVXx91Q2FuoBLMDuAEx0mazB0U+rVZzBDg/ACAaY/Kz4Gd3COcuDrekV87hisjDk/1TsUB9FYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLMd24yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB48C19425;
	Sat,  3 Jan 2026 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767469153;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLMd24yRB/RJCDrsowFWA94KWok8hesuXJCI79R2VpVBUvlGF5p15Xndc/D8gNkcc
	 fFgBYb+UZ1lxf2yCYXQFD9AdMi5OJIzYGuRBbBnPRj0tznht5VB+DrpFR/B0+fkwNC
	 XSbggcuc+U/ve0NfbSkRmf0olstvQz7lTp3LmoKdTfNNAo5Va7/wxE27GrXkiOJ2Zm
	 sCY4+tRIpyuNP4X9Z2fQOXBpcmJUGTYap5gRjmDyger5o3MlVXxZn0yrSKrfAlt74b
	 S/QOJKoznjzv5VXW3ndGSlcLKZR+aye5HIXRoeAsv2x2in5GYSD/NAp7Ve9kAzCNWt
	 x5cxqb0IAkNVw==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Couderc?= <aurelien.couderc2002@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH 6.6.y 4/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Sat,  3 Jan 2026 14:38:54 -0500
Message-ID: <20260103193854.2954342-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260103193854.2954342-1-cel@kernel.org>
References: <20260103193854.2954342-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 913f7cf77bf14c13cfea70e89bcb6d0b22239562 ]

An NFSv4 client that sets an ACL with a named principal during file
creation retrieves the ACL afterwards, and finds that it is only a
default ACL (based on the mode bits) and not the ACL that was
requested during file creation. This violates RFC 8881 section
6.4.1.3: "the ACL attribute is set as given".

The issue occurs in nfsd_create_setattr(), which calls
nfsd_attrs_valid() to determine whether to call nfsd_setattr().
However, nfsd_attrs_valid() checks only for iattr changes and
security labels, but not POSIX ACLs. When only an ACL is present,
the function returns false, nfsd_setattr() is skipped, and the
POSIX ACL is never applied to the inode.

Subsequently, when the client retrieves the ACL, the server finds
no POSIX ACL on the inode and returns one generated from the file's
mode bits rather than returning the originally-specified ACL.

Reported-by: Aurélien Couderc <aurelien.couderc2002@gmail.com>
Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: Roland Mainz <roland.mainz@nrubsig.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index df9baaee052e..6f059c5ac22b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -65,7 +65,8 @@ static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
 	struct iattr *iap = attrs->na_iattr;
 
 	return (iap->ia_valid || (attrs->na_seclabel &&
-		attrs->na_seclabel->len));
+		attrs->na_seclabel->len) ||
+		attrs->na_pacl || attrs->na_dpacl);
 }
 
 __be32		nfserrno (int errno);
-- 
2.52.0


