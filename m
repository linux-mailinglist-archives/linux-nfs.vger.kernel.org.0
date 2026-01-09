Return-Path: <linux-nfs+bounces-17702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0535D0B415
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15AF8311F8FE
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239ED3644CD;
	Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqXa1YmS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F0350D74
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975716; cv=none; b=bhxGU0ynzt8V8LOya8Za+4pZIQGPlBUdwMbtdvQwBX/bK/0Epd/nVm0EkEOK4OPQlJBrScoJlfFRof1CHWX7MZ58LYkRhMeal4q+HeSMy1Ec6/TfFAc1jAWrYXWQ3ncLhCx/bnC2lb0b9+Fk9ePiDPiIREPHiG7ggtW9tuny9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975716; c=relaxed/simple;
	bh=8Pwtb3p3t1L1tJZykAzWpgPdrHD+1wDdOb1x6D66leo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8B7IAiTMPIBCpubycqc7gxm8MdvfCTTfC08m+OdIPleXd4VJbSsZ0/TjpiL7FCWvlBd1dDoPZ3/KfmvjMwRroX9vAxZHyBhj4vEU0agUoPV+/t+Rw68G7RhaD/yavhMxypPyUS+9kYoEBPj+rs3TvSgETnxvvfTxdJBGKL+b6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqXa1YmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EEBC4CEF1;
	Fri,  9 Jan 2026 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975715;
	bh=8Pwtb3p3t1L1tJZykAzWpgPdrHD+1wDdOb1x6D66leo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqXa1YmSG+iswfLjeMhwiNxvcpToXjpriCU8OaYN2aB1XSjPFUbmj36nKk9jmpq6W
	 kneWcUuwm0tUzMDhefk7m299R5Jax1/vy+qDAoGtkFvs1klSaB90bzR7xIT5tNqum9
	 oPRwgbPNkQKbKkV2NyTRfjrdckzXhm+qBndzJxx9qFaFCawQ/S/XviXyIybztxR+lx
	 hjitwMSFzGOuRX4NkeTpVa6cAkt5hRcXFbOToV0X7qozvQ5AkckXrcGMpEArUUEa6T
	 3pRv+uVIWQ8Ri7QG2RkEv0T+liftQr84EBc2QxdB1Tu1Ju9UUiA6HTed/aHv7wtIOW
	 V1fBjuwbL62Ow==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 08/13] NFSD: Do not allow NFSv4 (N)VERIFY to check POSIX ACL attributes
Date: Fri,  9 Jan 2026 11:21:37 -0500
Message-ID: <20260109162143.4186112-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e7ec87b6c331..a77ec0685eee 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2380,6 +2380,11 @@ _nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


