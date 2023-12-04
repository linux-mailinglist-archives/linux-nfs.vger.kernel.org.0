Return-Path: <linux-nfs+bounces-307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0E803F37
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 21:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AB1281209
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A233CF5;
	Mon,  4 Dec 2023 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwKhTgFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66E30F92
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 20:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0CBC433C7;
	Mon,  4 Dec 2023 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721514;
	bh=jGaimABQR5t/c4BV2PeLWaX4aPh5s8kWXUeMbNBorQo=;
	h=From:To:Cc:Subject:Date:From;
	b=BwKhTgFDorqUo8TqYMbIuQRoDE8nErQLgruQskPd5kD3LREEoW0iyyHBCZBFWLJR3
	 77iJYoXuTlFNYWzCGNZdO1ILvdnnyasnmhmgOmTdlG9xjaA4Vw8bJmDXXr45e0n9BV
	 dEXV6V2kIFDeP6MyXfvm64vuyj3f93igJiPE8W0CcO/KJ6E3DzSg26Mb1D7vkgXTSG
	 dVUDqqcpZX6N8U/diKeuv21t+3yeSyUmnZuFozG9qxzW4G0JM17UQ039wBYhN+UjXv
	 oaS0MjpCiKNaGkH6FjgjSEuP0fpyNoz6K20MHT5w9gdLoB85WM17KghgyLsHC+HOp5
	 UsBqd7O6w700Q==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 0/4] SUNRPC: Various RCU fixes
Date: Mon,  4 Dec 2023 15:25:08 -0500
Message-ID: <20231204202512.108047-1-anna@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These are various fixes that I found after turning on CONFIG_LOCKDEP,
CONFIG_PROVE_RCU, and CONFIG_DEBUG_ATOMIC_SLEEP. I didn't hit any issues
when testing against a Linux server, but running against Netapp with pNFS
had several different lockdep & rcu related spews show up in my dmesg
(and that's just from running cthon, not even xfstests). These patches fix
all the issues that I found, and have a couple extra cleanups that I noticed
along the way.

Changes in v2:
* Have rpc_xprt_switch_has_addr() unconditionally take the
  rcu_read_lock(), since we don't need to worry about this deadlocking
  if the lock is already held by the caller.

Thoughts?
Anna


Anna Schumaker (4):
  SUNRPC: Clean up unused variable in rpc_xprt_probe_trunked()
  SUNRPC: Remove unused function rpc_clnt_xprt_switch_put()
  SUNRPC: Create a helper function for accessing the rpc_clnt's
    xprt_switch
  SUNRPC: Fix a suspicious RCU usage warning

 include/linux/sunrpc/clnt.h |  1 -
 net/sunrpc/clnt.c           | 45 +++++++++++++++++--------------------
 net/sunrpc/xprtmultipath.c  | 17 ++++++++++++--
 3 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.43.0


