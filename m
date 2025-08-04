Return-Path: <linux-nfs+bounces-13395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC2B199D7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 03:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923BE7A1FF8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE311B532F;
	Mon,  4 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH5XV7jN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A8F4A
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270971; cv=none; b=tp14mvnmmKlt8BwOpPJvVBRVOgLPB57a3lFp8LkSVWMCHyn2Wf5zLhilhjUvr1qJe0DqWevS/Wk/ZrcYyR+tv/Sl2grZXB7COJvUVO/q+qlb+XTLUUAo2hI7JtOZDYZ8dDWr4+KQ/OntF18c8fYrNEFk7Grm3EOeUQ7/cKQIfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270971; c=relaxed/simple;
	bh=1hro017Lo2XlM1Iy8fFZP6tlk8U+n3+XbHGe3CK/ZIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JhEMPnvBE0AbD5XvdiLWHyGUKabN9zPRLKORlWK0EKPbPiJVtHugYduuP8ccpIbY7fBfZGBVffmJRDm9VKPdTHov6MspMVlSxY00VTAuKd6BQDLRXb0/IQ+AEFI0CK8fOwYLPkZMRiHZ8ij/uuy0KPU0LLVnOgxSaZopKVamGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH5XV7jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0466DC4CEEB
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754270971;
	bh=1hro017Lo2XlM1Iy8fFZP6tlk8U+n3+XbHGe3CK/ZIw=;
	h=From:To:Subject:Date:From;
	b=SH5XV7jNWCzGZ+/bMjgHZ2ZDplbcKfht3Afc+Tii4fFzzuMMHxhyZCsB8pCSkBotn
	 vz0YeXkxrsBSzxIAeloczpcjzITsaUxc5ke2j11ZqZhzEZPX+DZhSTlvV4ZlZGZkj/
	 I26IBRCMi2UM8PNILPDgSMns8bstSJTRJ6/45UI6CidFnEdIWT0G8zZhTJvP1reCeq
	 0YZzB3wb7kILuc5s8SGLaNAHvkLkORq6CD8+bPFevJNwZ70/IJuVhJSdpZNzA2eIGN
	 zVb90z7y55rqowt5xixIKveJO+AcTvabDGEkzu+obr0dpu9HVjHnmmQQwIPqiZ1Cx9
	 46tt7XAXZj+UQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Fixes for the NFS automounter
Date: Sun,  3 Aug 2025 18:29:27 -0700
Message-ID: <cover.1754270543.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This series addresses 2 sets of issues with the NFS automount
functionality:

1. Capabilities are being inherited from the parent directory instead
   of assuming that the subdirectory may have different properties than
   the parent. This is particularly problematic when the parent is a
   referral.
2. We appear to be repeating some operations unnecessarily when
   traversing a submount point.

Trond Myklebust (2):
  NFS: Fix the setting of capabilities when automounting a new
    filesystem
  NFSv4: Remove duplicate lookups, capability probes and fsinfo calls

 fs/nfs/client.c      | 44 +++++++++++++++++++++-
 fs/nfs/internal.h    |  2 +-
 fs/nfs/nfs4_fs.h     |  5 ++-
 fs/nfs/nfs4client.c  | 20 +---------
 fs/nfs/nfs4getroot.c | 14 +++----
 fs/nfs/nfs4proc.c    | 89 ++++++++++++++++++++------------------------
 6 files changed, 93 insertions(+), 81 deletions(-)

-- 
2.50.1


