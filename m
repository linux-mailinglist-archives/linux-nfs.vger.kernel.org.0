Return-Path: <linux-nfs+bounces-17692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F37D0AAC7
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ADFF302550B
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8873612F6;
	Fri,  9 Jan 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBDYuW7y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEE3612F5;
	Fri,  9 Jan 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969592; cv=none; b=HIhZG3VjG/y57wCOTz0VSrwv3nLc3X4fqwYITx4edPPQoMeqbMkFnSdhI/A4ps2ih5UWVi1WhqSAcMir6RmUWmo83upQDdcuHfZMaQTZXZeWGBstrRIZ+JSKssjss5AcyKN2XRBphgAIRJEKfzlL34fzKO+/SfZ7YS0g40ocxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969592; c=relaxed/simple;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLB4Vq0Q5MVBhwkW1eBdQhL0ipLdkRdH3ddoiIWhvYuUXeo2UCEc5QbNG5yLq49iUNWWe60jBDzprwvlBjemw2sVFZJSoWOU+vzTX8JrxaysFr/k1np5K9CNi+KiKeSqdWNAASaGGJ589lksn3eVQZBG/otHIwvEWF3Y+Ym7ojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBDYuW7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A22C19421;
	Fri,  9 Jan 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969591;
	bh=zVkt41vdPJD3tmLuU3NTIvlss5s57PzVhoysbLBbYTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBDYuW7yuidDeIpKrcdZqP2Pw7hBsu7oz8zNNJv2UXg/d+Tq83PwK6lBvM6heWExk
	 E0kNAHlDUyCl9Q4yhQdxPrJvSh3hlIk4ORKPzsdQnWuMOe1Vfmo2jJoaZnIpJBH9F5
	 362tMR4GeHlvlJvV04NjWySP3OBpGuacu1BbydZ4SFhy95x6/BHgjX3lZTcbxNrAKh
	 J37WbUa0SnAvtyisOGGqxZn1RKxr4ojSi1sUzoI1/JqtpmMoMOkKnhJuHivdEqqiCk
	 uqwn0v8Km95zP18P53muRG4cqGZlV+Uvre5OwuGZTDByueO/tVLaCdGoiMWSHmOHgL
	 7l8W3YMSZV9lA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Couderc?= <aurelien.couderc2002@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH 6.6.y v3 4/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Fri,  9 Jan 2026 09:39:46 -0500
Message-ID: <20260109143946.4173043-5-cel@kernel.org>
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


