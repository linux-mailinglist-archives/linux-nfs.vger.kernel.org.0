Return-Path: <linux-nfs+bounces-17664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF35D05CAC
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 20:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5107300C2B4
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F1314B60;
	Thu,  8 Jan 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAqmaJIM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C542E40B;
	Thu,  8 Jan 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899409; cv=none; b=R2+aKSQGDE7Feud/uKjDBtjiNEm1H49ZRM6a3+4FRtmTDwh44LTmqG5RRRZH0DkOvbISSI98Nx7sfjHlEJFRAT9rmDKaumqpfsSsxSTJqyzVfEboZ33h0b3Jsw7aAuV0ETIeI49DW5UwaNPWDqiTaXEhewmQjfzjTUysKnYp3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899409; c=relaxed/simple;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoNbQkHB6He+v+OJnErvSJg4jKiDgTwUsK67VagOwmnFRsUd0/SpdZ+KYPBtaUGKyfiytj1FLPUBHIW4SV0UxrWb+FxWqmerz2BTB6sZVZ4nDCAxupnvlkOiuSea3xl/Wa/Y45HTOJ+UBJ7IWw4fdeMaALmfeIFluTDwxjAxz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAqmaJIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A547C19422;
	Thu,  8 Jan 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767899409;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAqmaJIMho1JoxwEl0hPa1lbdgLavvivJ77/JUA4FDPrM3zPQjqAZweMOsrFOYFrV
	 QIlL3AQn9RAGRL0ig9XfzlVtC/Aqq48VcyCC9Ou49gqTnQul3GDQnMy008ro8QrZ5f
	 ZbNIGeD+YYyzUqmV805HsYQQnPqHFRZ3Ko7u8LitzSUAySLNnjgpxd8TsTsFFbYExj
	 A3iP9OFVPRGFJxEjoaBi2l0oyB5/1vt9QChhb9WMikKT+CDW42Y3jolTFTvZvC34PM
	 MbEDFTuS/pJKlmJp3Js5uXo0Jie/WdQZAzN3prOWKPQocexLyTMw57DFEiztGwV5BV
	 6RXcmCW9UoKXg==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Couderc?= <aurelien.couderc2002@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH 6.6.y v2 4/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Thu,  8 Jan 2026 14:10:02 -0500
Message-ID: <20260108191002.4071603-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-civic-revered-b250@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
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


