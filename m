Return-Path: <linux-nfs+bounces-13954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162CB3C169
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8727C1898255
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D333EB1B;
	Fri, 29 Aug 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDB4k2Cp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5D340D80
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486666; cv=none; b=ZAR9+MvFOgtN8TOTgApYGEA+pZUYedRZP2MfB8TkMgZkPMqkpLTDLjJgrgAfqRENga54Br4UF2UwBw2+TktVbuIFSTbte+ETyt2kYsiwkVbt7JHcXC3TgzZGT41QveNnr5ICrRvMzU80m3DDuXdMKl2LZM+56uRKeOqFs7RNsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486666; c=relaxed/simple;
	bh=waS7MlI/ozPsrFCRSYlTh3cbdraDozT7ewpBvS32NTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgtzp440tHsZMfp/jF9hMaqnBh/M1dPuD2P9m5qzDT3c9xi1UPAs83o5LXRjGXlV6vyc/Bf/X1XripItzTuJr/lbz9UfZYz8l0rIu0Laqw2GHgMn3U9QfVsoWBoYuxxs3zlwFi0gavi0hbZtI96y+rH6NqdRoNyGxw7K7q6TcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDB4k2Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5598C4CEF0;
	Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486666;
	bh=waS7MlI/ozPsrFCRSYlTh3cbdraDozT7ewpBvS32NTI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fDB4k2CpCEWBWizw3bmHfm7Oh/h3syzcKgdb1+VIH22+ZSQn5tggFWXKZpAhC2O5w
	 c3EHRalwwmceZjX956q8trpS2LQm49qej4eSPnLBH7a2adq3U1GObcTSw7HqyTPiAg
	 qbqykbzKV6DjrufeLIVerse6kKUL14z4lzxH54CelF+QrIeiriDIymOHEvd4CPRZyw
	 ytszImVtYpVe0cVO+LdR6ViJSnXTcGfyjEMAyWUklMmMiZET8alPmjZ0uQyBIHwHWn
	 BrGkpXn83wu6dY/gbnSAkT5D13pHD8PYmbwCJhAfultCBlHbNta4Bjg3RHC6XW6BWw
	 3XGj3ZYnytLSA==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 3/4] NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
Date: Fri, 29 Aug 2025 12:57:41 -0400
Message-ID: <b3ac33436030bce37ecb3dcae581ecfaad28078c.1756486626.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756486626.git.trond.myklebust@hammerspace.com>
References: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com> <cover.1756486626.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

_nfs4_server_capabilities() should clear capabilities that are not
supported by the server.

Fixes: d2a00cceb93a ("NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d0f91d9430f6..ce61253efd45 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4015,7 +4015,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &=
 			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
-			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
+			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
+			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
-- 
2.51.0


