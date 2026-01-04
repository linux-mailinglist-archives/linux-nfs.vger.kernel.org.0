Return-Path: <linux-nfs+bounces-17441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D792CF11F5
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE4F3007C83
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A621E0DE8;
	Sun,  4 Jan 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0aMmEZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627764400
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543028; cv=none; b=BiVdGz0QWrzoXSd3cf+UWzn7WuEa6bxNizr1wrS9AzwudYUTtUb+5El5Jps9a9tB1Gw4XlG0SjlWikho8RtYxV0nueefQOC+PZnVVuMwmmNBwseh/PvGkcEsd44my9XDsj1nudR7VYm1GXeHIbnX/Use2lj0/ahNFneg/VsVJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543028; c=relaxed/simple;
	bh=19Erw7BfXAAEftv6e1J0efTR5yU1jmmLe+r+Nw2rFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Yy30A67UTRATPzEdpD111uQrL8xwUM+2bWg89mfxEH41jD0EiMbiVvQulEv9UFEJJ19v0YMxaMxoULIbezy+HBs8XDukewc3ZyStWb0oa1YMYQm6YrKPsZqnyZ38H72O15g2fD2NLkS5QPMithSZCRedB1LvhneYgTYIVk/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0aMmEZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F0C19424;
	Sun,  4 Jan 2026 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543028;
	bh=19Erw7BfXAAEftv6e1J0efTR5yU1jmmLe+r+Nw2rFwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0aMmEZw2mDFya1SKHfBReanB3fUGDuIdR41A1/EtPi3rK797hUZdM85sDfcmfJMh
	 BR++E/CmkPGmdyRejJErlCO7qW6crYonOGtEunJhg0WhbZ++Kiud1AGc2715IKRc5I
	 yvFXYx1tmRaWxX7CuqHmRkDL8nO/05VUv80yWxeyMo/jkhx/RCZ9hrEJ1Sqxx7+tQN
	 g9u/NnqR4g5eSZyblMKZpX8jA4YAmXrvutmQOa5kTdmyv4wDp1Xgp90BAesuIyoDkG
	 5ER4L023R16rqTmjr1+lMSd8NZc0f45fYiWWKpV+1MXytsguwWzoMKFWi2LytBO30v
	 iLP6hECn9RMQA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 07/12] NFSD: Do not allow NFSv4 (N)VERIFY to check POSIX ACL attributes
Date: Sun,  4 Jan 2026 11:10:17 -0500
Message-ID: <20260104161019.3404489-8-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161019.3404489-1-cel@kernel.org>
References: <20260104161019.3404489-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Section 9.3 of draft-ietf-nfsv4-posix-acls-00 prohibits use of
the POSIX ACL attributes with VERIFY and NVERIFY operations: the
server MUST reply NFS4ERR_INVAL when a client attempts this.

Beyond the protocol requirement, comparison of POSIX draft ACLs
via (N)VERIFY presents an implementation challenge. Clients are
not required to order the ACEs within a POSIX ACL in any
particular way, making reliable attribute comparison impractical.

Return nfserr_inval when the client requests FATTR4_POSIX_ACCESS_ACL
or FATTR4_POSIX_DEFAULT_ACL in a VERIFY or NVERIFY operation.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2b805fc51262..d3f016f9d9e6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2278,6 +2278,11 @@ _nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (verify->ve_attrlen & 3)
 		return nfserr_inval;
 
+	/* The POSIX draft ACLs cannot be tested via (N)VERIFY. */
+	if (verify->ve_bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
+					FATTR4_WORD2_POSIX_ACCESS_ACL))
+		return nfserr_inval;
+
 	/* count in words:
 	 *   bitmap_len(1) + bitmap(2) + attr_len(1) = 4
 	 */
-- 
2.52.0


