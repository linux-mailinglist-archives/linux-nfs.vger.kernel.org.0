Return-Path: <linux-nfs+bounces-16729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64AC8833A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 07:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8BBD355E58
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 06:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A7315760;
	Wed, 26 Nov 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh10WVLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61B25782D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Nov 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136892; cv=none; b=ZOPgwrfshoElun0Tvuok9APFeFJ9jgq0XVjDy/aF/LCRs9oqrQTG0Rr8z3UT3es2wbRNNHaDC1DU3TfDoz68P6I6KEDfLEVfjIuQGKfwiizTnCrbzbVnBSDe5UAF4qa006Yc9Ey02k0BiPbjLGVafh1T4v9EfDzFDPe/bHgdoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136892; c=relaxed/simple;
	bh=N/D51v0xpc25YU7Qpsjy3D+to5GEQg3bUWJA+owRvoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnt81pP7q0H2T0bvXxqaqLgdfxKteS2y9qbEnTHWJ4WeJsZZgAiMH9tsHjlNqlv9QBupL06+v/3Lw/zGdHXpwV7Q+5/0flzYxHVXvxRY7kYgHNOHZeQYU7nvsNFFWxJmviNcS96TF744USn4oJzWOt8vXGEUjOpXSxweqrGhy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh10WVLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5916FC16AAE;
	Wed, 26 Nov 2025 06:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764136891;
	bh=N/D51v0xpc25YU7Qpsjy3D+to5GEQg3bUWJA+owRvoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hh10WVLVcK4GPVwuUdhCtYDF0hDOGtCpiEiuIDGqRlLrLuwnnCdT0dBvZnCooX8/f
	 2MCzf/UTHJGNdageKM9Wyqob/RNtC1Y2Jlj3LwOE3hEo8S9agL0Ai73n5jKhbRFH6m
	 KAduiJ3r0tj14nZyt7mlHVxyAyDcTsYPcyjpkvHSMsZcuNeW2qmiw65Q6kc4iFoRNT
	 NzGPdRVASpVRMu1dJCrzfyrOYHwhbnvnSCxtxQ5JZOmMMw7G3S6iJ2LkOWnJMssmfI
	 KOPpQNJvquH7JVjx6RkDIX7rpzoSPZ/pAZJTf7qlhrc1cNpceIXPu+fE9MmnV91FwR
	 7db1EOmdGsjTQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH v2 2/3] nfs/localio: remove alignment size checking in nfs_is_local_dio_possible
Date: Wed, 26 Nov 2025 01:01:26 -0500
Message-ID: <20251126060127.67773-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251126060127.67773-1-snitzer@kernel.org>
References: <20251126060127.67773-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

This check to ensure dio_offset_align isn't larger than PAGE_SIZE is
no longer relevant (older iterations of NFS Direct was allocating
misaligned head and tail pages but no longer does, so this check isn't
needed).

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index e30ea1c54c616..560caa2e4238f 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -339,8 +339,6 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
 
 	if (unlikely(!nf_dio_mem_align || !nf_dio_offset_align))
 		return false;
-	if (unlikely(nf_dio_offset_align > PAGE_SIZE))
-		return false;
 	if (unlikely(len < nf_dio_offset_align))
 		return false;
 
-- 
2.44.0


