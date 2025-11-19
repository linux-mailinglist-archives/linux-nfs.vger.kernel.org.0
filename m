Return-Path: <linux-nfs+bounces-16503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C4C6C2CB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 01:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 588CE349FBB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CE20B7ED;
	Wed, 19 Nov 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttLY4xQj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7B207DF7
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513485; cv=none; b=IrpAuALB5zd1dNn/D7g84lcwZaJLfdmLYQQBgCOfGQ+0OH6NBpBIl3Ppj3EuGCgbCJp6glGQDIaS6bSFAlF4wY5Q/ip3zYJocjQmKq8XmvpxZ0TQZ/qpvRxLY7ePUAfChKNlTjEElhBAdyOewuxMeG7s5u/42x5MEoHdjly1AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513485; c=relaxed/simple;
	bh=mLdDu63Ufv/YA5A7jaNffnPqWFXPZLVuImcVH8wWz7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgKGkiscIgU1MduzrZHVbO2G/GNQm6umCxuQ1J8FICDfehZVb1y/Kyamg1e4eyCUbH2Y2OsIQEX4YzJ0mlwfe+qGFWTnH6ByY103rolR8IReH2BoAT0ktpP/QbM7GWINa1drrp24Op0aww5v/ntCx2GnDYkejRL1iz/nsAhegJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttLY4xQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25EDC4CEF5;
	Wed, 19 Nov 2025 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763513484;
	bh=mLdDu63Ufv/YA5A7jaNffnPqWFXPZLVuImcVH8wWz7M=;
	h=From:To:Cc:Subject:Date:From;
	b=ttLY4xQjSXkrojQzgjWaxW/LGOjzDNlA3KgkQmDVVYOtEs3ZQngoHg+YeRJSIybf0
	 QAoxGBRAxUOxm2y+3+9oF2fNSDsyRrpvEgJZw49Du1lZdE9Z+kLfRmcGQhxAZNtXzP
	 onSzUtY42uZCP2g5FAx3vE7caQwz/esWF0Rs+mPxoIaYFUpiSWTwvCBaOWU7XKWtQp
	 H93SD2YGPbOrHRoF+m0iD7PaXZQoaCT/v7Ddoas2+/GQ0MfCw2BoN4hGPGmIkGSjTl
	 K48ZA6JMFLduPYWMU1W224emBhPabjNjG/iTW/dGkESWnjHVmsXR+/ag7SGkD4wffl
	 uOZaLczd4ig+g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Couderc?= <aurelien.couderc2002@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Date: Tue, 18 Nov 2025 19:51:19 -0500
Message-ID: <20251119005119.5147-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

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
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/vfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index fa46f8b5f132..1dd3ae3ceb3a 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -67,7 +67,8 @@ static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
 	struct iattr *iap = attrs->na_iattr;
 
 	return (iap->ia_valid || (attrs->na_seclabel &&
-		attrs->na_seclabel->len));
+		attrs->na_seclabel->len) ||
+		attrs->na_pacl || attrs->na_dpacl);
 }
 
 __be32		nfserrno (int errno);
-- 
2.51.0


