Return-Path: <linux-nfs+bounces-7587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB59B6D4E
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 21:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DA51F21B78
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C41D130B;
	Wed, 30 Oct 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX5CuUy8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76B19922F;
	Wed, 30 Oct 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319097; cv=none; b=UP2nCeyNteY0DxDMtZb+w4j5Km4ESQw3SPyBHDrdYySaQJcYvFfKFrCpEBbn6hRytVb6r3XZ3v8+fLdPMHYPw1GIRezU1lvm8eeM/UjQPzjXxMxrPCLnuQaFbn7FbKGWsx+ATU8qhxv1niN5WpAEcxH//rWO8E1JCsdU7+g6hAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319097; c=relaxed/simple;
	bh=akjH3ly7GRoMzhOlcXspEd+T9bhyeYyBx+WKQX3ErHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC1efat19BvlfeZ05GKadH9XeDJ5in6ktRRmR/sNkMzRiBY59o/e/Tw562CN9wr1z+zCRBIBXRXYeqW9F4N3RNBy7PP94KWlTUrc6Jwn2Z0LjN4isQ1LtMD2A1iblTPeo69N39A3+eroQwihlxHcy7SwSi9mo35HX3NRI34DTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX5CuUy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB1FC4CECE;
	Wed, 30 Oct 2024 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319097;
	bh=akjH3ly7GRoMzhOlcXspEd+T9bhyeYyBx+WKQX3ErHk=;
	h=From:To:Cc:Subject:Date:From;
	b=bX5CuUy86bbReCWiz2MaJzzWQyfDMJmdCPTpZJQgR17Zg8ls7ZfeuUFJFItMbJuDR
	 OHz38UFHHZfcmh/AudL49d6kQ7f+ckw6kWoDezlX6MxzbnjwT1lQBVlXhJE2Lya6Ja
	 /UEKz1tPPTHnbJKmtD/KenCS8ffyVTAmP+i9MNcEUO9GTas3WtmdYCXw3Xsm4wt8uN
	 FyJJrulg5npGQUwgPmWtxuGZU6KQ5DtGSBfn2mw0DvU6mTVOoblbHoYLN8VV5neOhY
	 wv+aEH538td3f0SwslEoZMZJ6OKUZ68YAZ2E79bmb6Ky5k2ShmdY0H97Xg0HEhHCwF
	 Pld4RmF3O/ajg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] rpcrdma: Always release the rpcrdma_device's xa_array
Date: Wed, 30 Oct 2024 16:11:30 -0400
Message-ID: <20241030201130.47742-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Dai pointed out that the xa_init_flags() in rpcrdma_add_one() needs
to have a matching xa_destroy() in rpcrdma_remove_one() to release
underlying memory that the xarray might have accrued during
operation.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Fixes: 7e86845a0346 ("rpcrdma: Implement generic device removal")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/ib_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 8507cd4d8921..28c68b5f6823 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -153,6 +153,7 @@ static void rpcrdma_remove_one(struct ib_device *device,
 	}
 
 	trace_rpcrdma_client_remove_one_done(device);
+	xa_destroy(&rd->rd_xa);
 	kfree(rd);
 }
 
-- 
2.47.0


