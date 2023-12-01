Return-Path: <linux-nfs+bounces-247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A715B801504
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 22:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDAB1F20FA1
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 21:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0DC584FA;
	Fri,  1 Dec 2023 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KggkrY5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2826ACF
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 21:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE737C433C9;
	Fri,  1 Dec 2023 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465351;
	bh=O0N/1Fp9WeNI30M76VGot24755Op55Dq6Ku1TaPg3ps=;
	h=From:To:Cc:Subject:Date:From;
	b=KggkrY5BfL+DqstYcd7bo3n9MTTK+eKQzMjjjT0skcyoLSaDevrQjEws6vyCSs339
	 JY5xpc1wEFaYs9biMnD41HtrNdGiJzOseAKzn1ril6pUDQc/QKnJuWBcDkhGjgWZyl
	 s2jGxreSNDJaUGremxyJF0JVljFnWvqORFzLqmDgbyQysQtX/lblEt6FK5Z2QNtW69
	 sIr+GbQxf1h6Xm2omKT98Knn+yZ8aI73F7VW/IITfNHeYoWtNg9nQ6w5lWJM5pALva
	 LefSdj3E24zCv+6c5/6bH/cthbtupn4lYlUVpqCA9nriAIS9GpN8m6WJmpcA8vcXQA
	 HiS7MXepQ+LDg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 0/4] SUNRPC: Various RCU fixes
Date: Fri,  1 Dec 2023 16:15:45 -0500
Message-ID: <20231201211549.126941-1-anna@kernel.org>
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

Thoughts?
Anna


Anna Schumaker (4):
  SUNRPC: Clean up unused variable in rpc_xprt_probe_trunked()
  SUNRPC: Remove unused function rpc_clnt_xprt_switch_put()
  SUNRPC: Create a helper function for accessing the rpc_clnt's
    xprt_switch
  SUNRPC: Fix a suspicious RCU usage warning

 include/linux/sunrpc/clnt.h          |  1 -
 include/linux/sunrpc/xprtmultipath.h |  2 ++
 net/sunrpc/clnt.c                    | 47 +++++++++++++---------------
 net/sunrpc/xprtmultipath.c           | 14 ++++++++-
 4 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.43.0


