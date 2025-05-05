Return-Path: <linux-nfs+bounces-11449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEACAAA876
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6244F1647B3
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6F34EC5D;
	Mon,  5 May 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET0dhtx3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBE34EC56;
	Mon,  5 May 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484817; cv=none; b=gXXTEMCBsblhlFWar3kTq+OjV64QulGmdRVDACz2XFoADrgRlrpTjncpR9UBWyMTYFYL0LD9fxYn20JBoJOuvRVDPDmVjbX5IMtN5BwIVL8zAQlgS3Mr1IvvG2MF6rs+PNUWQr5W7ooK6D1TE/H3L8Yrcx5nL0Vd0oCQc5Jr74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484817; c=relaxed/simple;
	bh=ucd1nA/5/wyDjK7agmIG94R6kXabw4DE4YgBtCp0ucA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ox5vV11wJQu5hm529QLPO6N0g41dOVHK1fhNQYbMO/PYLyhCloNSHo72vr/SfnvvB629VS7KUt0ggaEH54LLz3xIjKpP3MbHiokNirUAuLIHsr6WZ59T90LBVP2JabJct7PeWnwMhWqpw6TErXnrt99G7IQA88GAaISVMRWWyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET0dhtx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACE2C4CEEF;
	Mon,  5 May 2025 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484817;
	bh=ucd1nA/5/wyDjK7agmIG94R6kXabw4DE4YgBtCp0ucA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ET0dhtx3fvtdJQ/vmo96YMWyWJGvHi5BE/Jv+L0OQI78LmRTeJ3FDEuiUU94bd9e2
	 wzrhm8133n4Rl/8xnj45Uf9rcv2MgdA/EGSaC0q0rtwxOZHKd393uKhOX/LZXUotUm
	 kwZ8M24Tr3C+SgUP4Rc+Dk0mUDQwKLSn5WMibH4qR91hNQSTJa5Um1w5wgTpcRacvN
	 6qLwHIQytu8Jf3/wg6P75qUzrWBu+JTiuxxfF8IZONL3iYtOX5JkEvI36D0cbxKl8h
	 iRjNuuy3YVilEJPTTwQX0tDWTYo2XQpHLT7HDA7kGnBF49d/VzIYq1LOp7aTLWHSCU
	 p4f4TQwz3dFMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 028/486] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Mon,  5 May 2025 18:31:44 -0400
Message-Id: <20250505223922.2682012-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 0af5fb5ed3d2fd9e110c6112271f022b744a849a ]

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index dafd61186557f..397a86011878f 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2740,7 +2740,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
-- 
2.39.5


