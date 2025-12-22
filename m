Return-Path: <linux-nfs+bounces-17261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E994ACD6F74
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 20:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57AF23002287
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FE30595B;
	Mon, 22 Dec 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMGp+Dh7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFB332EBE
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431810; cv=none; b=Zwp2GdD0Nt7X7LKA1B1dyB1VMds5PI7ibNH5lpsqsBD6eSc1Vaitxlfma3Z5AcMOkWjvJszFXy84gTtrknRROTNpDxIBgiWX5m4fh2GtFBpF9ZBaJ/OCj9OkLLde9Q77+9GWNJaq0DDEiTtp6BFqo7JBQM6PS2QsXrHT22QHbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431810; c=relaxed/simple;
	bh=gZjvFTLmLJAFoXpnXR3yxUbCIOnht43+JEu7UaZ30FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxfiAA7bkoqDHqCjmHbpoAtk8NaSXCY7jNUpSdiH/zjrvY7gfEhd/Dg0Yd0voEkhkJ/BdS4x/Bvuabf+1ctq8Casu0wBL3w/JyW8DAChqh33lah5vGsm+Y9BzgMyhR5LpKTBl7OCEvknhWkwFmbizjaHPSYF7c2qPHHlzwElN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMGp+Dh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F1C4CEF1;
	Mon, 22 Dec 2025 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431809;
	bh=gZjvFTLmLJAFoXpnXR3yxUbCIOnht43+JEu7UaZ30FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMGp+Dh7YLa3BqX/IL2U95t7tdppOUxr4l37MoLDGtMlf/uR+VZycrYIb4ICyGJxv
	 TsCfr3mqTCtToLyTKzWi6Fo29ltFDUgUW7ERn8L1+7baYt+1dlmIqluvUItcMKbRy/
	 izU+vM30pSP/3CLYwHQYLj0eNN7mVYY28T9VLyjm+4NdqOdS15e8kjsra1+Z+8LycB
	 GIJ93gv+UvyA+JqN9d2xDi+VK6tazSfsU4r2GYH1NcHFkNlJYY5mncehSD1V6aTAVf
	 ssIWY9o0vBIqjHOrmNMTvNJgGqsuLYyL/F8SisWDsi88u5zydeI3kzhOMvSbEbt9W/
	 eIJVZbG+eoBWw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Anthony Iliopoulos <ailiop@suse.com>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 2/2] nfsd: fix return error code for nfsd_map_name_to_[ug]id
Date: Mon, 22 Dec 2025 14:30:05 -0500
Message-ID: <20251222193005.1492196-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222193005.1492196-1-cel@kernel.org>
References: <20251222193005.1492196-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anthony Iliopoulos <ailiop@suse.com>

idmap lookups can time out while the cache is waiting for a userspace
upcall reply. In that case cache_check() returns -ETIMEDOUT to callers.

The nfsd_map_name_to_[ug]id functions currently proceed with attempting
to map the id to a kuid despite a potentially temporary failure to
perform the idmap lookup. This results in the code returning the error
NFSERR_BADOWNER which can cause client operations to return to userspace
with failure.

Fix this by returning the failure status before attempting kuid mapping.

This will return NFSERR_JUKEBOX on idmap lookup timeout so that clients
can retry the operation instead of aborting it.

Fixes: 65e10f6d0ab0 ("nfsd: Convert idmap to use kuids and kgids")
X-Cc: stable@vger.kernel.org
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4idmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index b5b3d45979c9..c319c31b0f64 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -672,6 +672,8 @@ __be32 nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_USER, name, namelen, &id);
+	if (status)
+		return status;
 	*uid = make_kuid(nfsd_user_namespace(rqstp), id);
 	if (!uid_valid(*uid))
 		status = nfserr_badowner;
@@ -707,6 +709,8 @@ __be32 nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char *name,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_GROUP, name, namelen, &id);
+	if (status)
+		return status;
 	*gid = make_kgid(nfsd_user_namespace(rqstp), id);
 	if (!gid_valid(*gid))
 		status = nfserr_badowner;
-- 
2.52.0


