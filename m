Return-Path: <linux-nfs+bounces-10789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20618A6E7C0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F23B889F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD71494CC;
	Tue, 25 Mar 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsNZruic"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC77149C41
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863602; cv=none; b=GWCI2gMrjb8mwLY45mSVQeasem2kgdCbbfxoycJZKO/A5M7ZQu1ThGuL7m1HS2AWoNdT+jGK076bELdxoePQmjuiy8BBX4REaxQRx6vUn7p7OTzCxTjMcGhFVuiQlirlSydwiqTCRw+Uc2waMwSHfimVrZJQVMe9BjBnonO++6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863602; c=relaxed/simple;
	bh=MnAEOxXKb+Yv4shqe0+/v7Z2v9SG0rbYRhs3xsaLu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaTNMt9MkYFi2m9tpbr7hHW0kTdm2zOFjd7uk23xRnl8TGvCdYiLDxWNwgw4t0SHfpeXvLmcyF7f5YRuHKOrVDEFoQIR4LkSBoo4iPTPaIyaX3tY+oyTVfxzmoHcgy1ZwR0KVQ+nvm7flKmfJ9v+dWg13CrdZ4coo/65AmsmBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsNZruic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF574C4CEE4;
	Tue, 25 Mar 2025 00:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863601;
	bh=MnAEOxXKb+Yv4shqe0+/v7Z2v9SG0rbYRhs3xsaLu4E=;
	h=From:To:Cc:Subject:Date:From;
	b=gsNZruics/idboLC+sRM+eOG3tzQYTI1R7Z8dkVVPR5F2xI0sUrv4FFGxMkmliJCs
	 eUqMuL16xYoVZ8202ItyPT99IDPbk1pb1ThJl6W+3hcLwoU7aI+6vp9LjEQnWf8X8j
	 jH/b2nPXeqfOqYkyr6CG6Amme8rmqDNmyNJqFXp70j5vHdXk8ccu0+b50ja7rCgq60
	 41lb4WgJ/iFp4PWojsMryll0i5lD/WoNNrk5x3UQvM1b3dz1RET8/gWg0tZGG0ZaqV
	 6mdDVBBdjhJQu2qW4+c2tmAzkbfzxTMAdGLtRBEcpcH+YYwx5Wwa7wFzVAkZ6LYMV/
	 YPN11IXz4sEIg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/4] Ensure that ENETUNREACH terminates state recovery
Date: Mon, 24 Mar 2025 20:46:35 -0400
Message-ID: <cover.1742863168.git.trond.myklebust@hammerspace.com>
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

Trond Myklebust (4):
  SUNRPC: rpcbind should never reset the port to the value '0'
  SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
  NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
  NFSv4: Treat ENETUNREACH errors as fatal for state recovery

 fs/nfs/nfs4state.c     | 14 +++++++++++---
 net/sunrpc/clnt.c      |  3 ---
 net/sunrpc/rpcb_clnt.c |  5 +++--
 3 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.49.0


