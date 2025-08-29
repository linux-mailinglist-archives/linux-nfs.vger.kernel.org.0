Return-Path: <linux-nfs+bounces-13952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14EB3C165
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B1F189AD85
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49E33EAFF;
	Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL97E3q8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11633EAF2
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486665; cv=none; b=MyseCZUYauG39xqDENtaN0qHdPkdJ97YqVhmVtEzpV+M+P1hKyaGz9XdQ8WxacEbzIdx32KSMUJmKjeLMBCLBLFxonbG6VQm3ExTKo+VkoEr+u/nbHupSADPqNem6qXZcG00n84aMyBLJamfbFdgb0Ae0xYAYxN2xcKS9pNIvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486665; c=relaxed/simple;
	bh=fGjB5VQV3eqQ31ICxyKTt5viJ/fHvQ1fIMppT4IWLoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4FtLMnI3SDYGdEvsndM10X7dix8vQfHKxt8dDHARJxH4ZgsKBj9j+9rlK20DoCJ/d7ildR0eR4GWdI9SeXt1S2WYT+AInVeo6qnlLKP3sxWPibnHSM4ROQ2aAlRFkrIsT1rOaTeG697mbe7CNhQQzZS1vtLSPanZV2G/sZb224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL97E3q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5446C4CEFA;
	Fri, 29 Aug 2025 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486665;
	bh=fGjB5VQV3eqQ31ICxyKTt5viJ/fHvQ1fIMppT4IWLoc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VL97E3q8hcHqr+BCwrHzF2gcYPM+eMgERASq/EFQ1h6wXuZq/NTs9erQOLMDX+lzO
	 6DujQqIncLgiaXk86+my+tPvuk4kjI48njNO5cKoM5Y0V0YVTHFsLqjit8l4V7p6Iu
	 mNYXOjKuxFJJimVvjzyaVS6RvrGtmB9zQbTf3ua9+wga4Vr+WJQav/lLQ7IeiHGY8s
	 qnEvWDV9k+6daa48f3K4F7FfBnY8KSpkApY0gJdk/qdl6dbP9byC4fH0seMKXXWkjD
	 o6y2vcg3GRX+V9nDj/zbhXFT+hbm3cx0qYvtbkpxYRtW3Ll8MPct0fUtKZSGhiLWjf
	 1QrP5c6NqCtQA==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 1/4] NFSv4: Don't clear capabilities that won't be reset
Date: Fri, 29 Aug 2025 12:57:39 -0400
Message-ID: <31f1a960ad1a14def94fa0b8c25d62b4c032813f.1756486626.git.trond.myklebust@hammerspace.com>
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

Don't clear the capabilities that are not going to get reset by the call
to _nfs4_server_capabilities().

Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..5b92fcf45dd7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4092,7 +4092,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.51.0


