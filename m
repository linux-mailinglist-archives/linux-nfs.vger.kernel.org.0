Return-Path: <linux-nfs+bounces-10875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54BA70CF6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8076C3BB37C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA3266B77;
	Tue, 25 Mar 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djpbjGTy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBC1E1E05
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942125; cv=none; b=YiJj379gDkOIPSQGpXOAR30cPbIETbfrAh6XfjMOXLv+jTsffw7dgtDBvTp1mugTnC9OiZ+cl04K9Vh2OzYY0ebzVndFkQbW7L4bWtl8TrM9IcrEraWs7gKPnfYpZTnVcOJegGxKAj5yLFWInBfc0/8jyprVFfvSqBZD9THH8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942125; c=relaxed/simple;
	bh=FEDFqRit7l0j9Qr0z/U+MAAaNYMS7UvgOEBKbXSYBAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D80J7FcLt23PzWYxhNWYH7AjAcuD3qG92B3ejQuoUxHPzqiZXChLxkSZ4K6kbe7OrTviby0qE1sSwXqweeGXRoVvnhcrPzUspHJ/cJ98KztiqUjvT0FBXDKdpt8K3QQLWxr0DD3pbroWptO/zAx07+Upwntm4x2QlK7WyS8beqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djpbjGTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692C2C4CEE4;
	Tue, 25 Mar 2025 22:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942124;
	bh=FEDFqRit7l0j9Qr0z/U+MAAaNYMS7UvgOEBKbXSYBAw=;
	h=From:To:Cc:Subject:Date:From;
	b=djpbjGTyH6cz5Mw1CubPyH4Ac6i+6XuAa5frOSuqRGORsLeK9XQ4iYt+gCq64BeCd
	 //lVN6u2aVTSkZpT1wd9IPHghusv5ujWC/f63Gc9BrUzDhPcxSP3RkQzhr5e/iiPOQ
	 7OlMcowWZ+YFPgZSst0oTx8vKs6J5gYZHBmhtTwXUh/qSx1mi9NfjX/wOVyyBOJGIc
	 h9wwp1iJENtmp352v3bWTBtdYiR/zviE24EWSoU4IuqwgSUKLjH4QkgSMyRcQ2USSW
	 J5tDzmfG9CZjWK9fCMHBq7cAztZHd0rkb521j9e37AleMkdgGRp9UHhHOLyKM16jKm
	 54OpH0ZGxBk0w==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 0/6] Ensure that ENETUNREACH terminates state recovery
Date: Tue, 25 Mar 2025 18:35:17 -0400
Message-ID: <cover.1742941932.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

With the recent patch series that caused containerised mounts which
return ENETUNREACH or ENETDOWN errors to report fatal errors, we also
want to ensure that the state manager thread also triggers fatal errors
in the processes or threads that are waiting for recovery to complete.

---
v2:
 - Return EIO instead of ENETUNREACH in nfs4_wait_clnt_recover()
v3:
 - Fix sysfs' shut down of the nfs_client
 - Replace tests of cl_shutdown in NFS code

Trond Myklebust (6):
  SUNRPC: rpcbind should never reset the port to the value '0'
  SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
  NFS: Shut down the nfs_client only after all the superblocks
  NFSv4: Further cleanups to shutdown loops
  NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
  NFSv4: Treat ENETUNREACH errors as fatal for state recovery

 fs/nfs/nfs4proc.c      |  2 +-
 fs/nfs/nfs4state.c     | 14 +++++++++++---
 fs/nfs/sysfs.c         | 22 +++++++++++++++++++++-
 net/sunrpc/clnt.c      |  3 ---
 net/sunrpc/rpcb_clnt.c |  5 +++--
 5 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.49.0


