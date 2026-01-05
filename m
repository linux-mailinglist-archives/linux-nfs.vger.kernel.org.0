Return-Path: <linux-nfs+bounces-17457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A4CF5877
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 21:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 731233009D73
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 20:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632A1DF25C;
	Mon,  5 Jan 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Ctc05J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F23D561;
	Mon,  5 Jan 2026 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645194; cv=none; b=kXRtupoX7nXQ2BoARNwZwJwe8stjsTyzdRSwt3z0OUw8xklnN2yZZNTrr7th52+L73SZGMhLafW7jyKzVUWiiNXnRuIFBz+aDjzFF/i7clKGHt8i8KQSM0XMQ1ad7+INqyNGVuNLQ16r/v+YSWPCCAAFNtgAbo1LaI9oji1wSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645194; c=relaxed/simple;
	bh=43e6AFEK5pwFVuGG/J7sxOO7pJKtJHUPE+Eebltgv/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXmis8De1uxOrA2L3HHNTsUZ6LEgiJnDTmJFUNMajmpjVTR1KUCQ7qBf1cupOU7dyMk0jNWAiBa2KFBWMX6qnK5Svg9F/0L7zPq9vaxEZ7raRzFO9BHTInsDrboURKlOgS4zNT2n2y8cNMeSZmDL4WSZ840s65iOyV1e8RWjWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Ctc05J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17632C116D0;
	Mon,  5 Jan 2026 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645193;
	bh=43e6AFEK5pwFVuGG/J7sxOO7pJKtJHUPE+Eebltgv/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7Ctc05JucVEbroM4Unk57KXhIdPgF+mW1mlfEBgjlN8CiOf082rSuswva/w2cVGr
	 bmgRW96RN/uzwuhTjzyq5gLX2YLPm3EzJ3lqrFbZuMVznoT/CBwy8ylpbQGxKht3H5
	 /OquvzbJ9RB8GR5HOHkiEwYBA2dHfo9mf4LQtMPyAt2+34Nk1xJlFNkRbwsJK7sAQD
	 H0vRDBkZZhrZMUC6Fwyw4UBZ/dxCUnmkSuDMUkVM2fwxlPP1Z2PXOK2UnhbGWxkZf0
	 tLrp5ASJQk0hqKgrJyAkomI9nphGh5b2yXqUyak8MrMXcOtbCl8gQ2wDCiZfiTZs/k
	 8Hpbg3Ggnxqog==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Aurelien Couderc <aurelien.couderc2002@gmail.com>
Subject: [PATCH 6.1.y] NFSD: NFSv4 file creation neglects setting ACL
Date: Mon,  5 Jan 2026 15:33:11 -0500
Message-ID: <20260105203311.3562329-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-crusher-hamstring-d100@gregkh>
References: <2025122941-crusher-hamstring-d100@gregkh>
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
index cdf73700d053..87a596fc6654 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1320,7 +1320,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


