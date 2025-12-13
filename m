Return-Path: <linux-nfs+bounces-17072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C2CBB242
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 813EA3001629
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75623EAB2;
	Sat, 13 Dec 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5EdbBAQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945E1DF748
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651330; cv=none; b=Ut7UApdfXrDMt0XCFoXoPxPQGN1rGMwfdYJLYh2yXerLDMGmKxRwuu2/OJzWWj04m3iVGVmEG0IXM2QiHQywigfRRkRH1ogeKZflPE1oeEE0ohmlhdvJ9P4tIKlGNwMVpLC9Le/Gg877i6cjw31pgNktR/0nTyVmqVRdzylVxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651330; c=relaxed/simple;
	bh=JMrt6DUfb8sb2a0U+kc+4CKfuOcJJbITrjrOD/j4MgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sANGcnDLPVkjur//t4uLlcAJqibpEls2nq2uhoBo8eOkY7YJAoxzOon4q1Cv4ihnBErYAhJkDN6iLnGfo9hdpiM2M0SBddnEaEjbm+GIuHRBGICO1Ct/sxXAQwPSW6R1g2YfA50n/jtoTGfxzx9wbu3L/2rXKSxYtPpkjih2Q5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5EdbBAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F289AC4CEF7;
	Sat, 13 Dec 2025 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765651329;
	bh=JMrt6DUfb8sb2a0U+kc+4CKfuOcJJbITrjrOD/j4MgM=;
	h=From:To:Cc:Subject:Date:From;
	b=e5EdbBAQnMKFJt6kZv7RMqSJgwfBvVdrM4Y3GcLudLuCorICPJhP7iLsQrQapIwGX
	 8t79/hLRTPnUsSsOpdhjnEcUHLotl0CwGZI4AgKNN0Zk3zFJ0uqqufF5FEtSuMgO3X
	 oWdLlH5mtIigVHZH4s3W/OIYnxCZUVgftOWgngJz5segMOotENYv84b7CB2meLBpJn
	 Z0Fo0Q74popVy5baL9XdEJ+R36+7tUAtYXg4WkllGIgs2tzQ8n2O1c7IgRRGCRaoT1
	 ic5+2wNLOyuOONlyJocI2m5X0OlPJNk/QXe7Xf87K1FN8C48hayLVdSdNR7aGsj/Hy
	 sHlCw78lKMA2Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/2] provide locking for v4_end_grace
Date: Sat, 13 Dec 2025 13:41:58 -0500
Message-ID: <20251213184200.585652-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following up on:

https://lore.kernel.org/linux-nfs/175136659151.565058.6474755472267609432@noble.neil.brown.name/#r

This is now two patches: one that can be backported, and one that
simplifies the fix based on mechanisms available only in recent
kernels. I've also addressed all the review comments I could find.

These patches have been compile-tested only.

NeilBrown (2):
  nfsd: provide locking for v4_end_grace
  nfsd: use workqueue enable/disable APIs for v4_end_grace sync

 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsctl.c    |  3 +--
 fs/nfsd/state.h     |  2 +-
 4 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.52.0


