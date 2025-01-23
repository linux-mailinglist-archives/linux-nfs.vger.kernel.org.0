Return-Path: <linux-nfs+bounces-9545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA4A1AAB9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F01162AA7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA35191F8E;
	Thu, 23 Jan 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POgrvVb+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E687E105
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661967; cv=none; b=Jcza5mqMwP6vd7Aheq/UgbB68aozljyR+XW8/DbsKX2aCSWc9Bs0BL9yRSRrt4YzMAXTNcXvZlkrhQ1YzH4KQcecio5pvPNuegL9wSHOQ/gl0VK6WrvSaDpOT//mIzSwZdVqY+QTMb2ngqB4UqtSkymbQu80FbRDeEkbY2OIzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661967; c=relaxed/simple;
	bh=6w7SDhFnGDkWT7TMYJfIxEhPREgkUf90bXYKr5SVKFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKwLzvGukgKjfveptf2miGSj0PdS91t1ea28xVXyYKzO0Cv0T67af/2ux0enUa15HjRATV8p0iyA9w0OGH0JK1HTJ4ZIkURvf0EeLJGhXU89V3JSCftgIIMv0s/zkNeRuRx5o+9iOs3zi68vMJcpYFKAzdBGdNoy3TZp+Hc77uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POgrvVb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E1C4CED3;
	Thu, 23 Jan 2025 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661966;
	bh=6w7SDhFnGDkWT7TMYJfIxEhPREgkUf90bXYKr5SVKFM=;
	h=From:To:Cc:Subject:Date:From;
	b=POgrvVb+CiNCl7sLi6cD40cKwgK/z4ZvjPnchITYO/3LaCzVKobzjgI3lcgbY7zdL
	 +FnpCNSxvJreIky3Rz5P3Rn0o4k530gcOf0Bcl8tcKYM/1lmZ3GohuOVUNjlfU1PPb
	 G9aGxmb9zY5GS06u1n7O048KpXPPFtIMo2onx3oZKdMCtel+MYMplWASAduHygb5fV
	 6paE/dK2XMZwE88ugAlLXnNgRLO5Q23hzyPjtHVGB6Zb7IoFUuSf+TSrXpBD3hpgli
	 ZNw3AMFBclFUfmQWyBokuj6XwV8bC5kDX9kKjf4/t293ubmqe/cwCbRVi4GkvO0Ixl
	 TjBOhQ0LlN8hg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/4] Avoid returning NFS4ERR_FILE_OPEN when not appropriate
Date: Thu, 23 Jan 2025 14:52:38 -0500
Message-ID: <20250123195242.1378601-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This short series aims to prevent NFSD from returning
NFS4ERR_FILE_OPEN when an NFSv4 LINK, RENAME, or REMOVE operation
targets a directory.  The only time the protocol spec permits a
server to return FILE_OPEN is when the target of the operation is a
file that is open and cannot be closed immediately to satisfy the
request.

I would have preferred these fixes go into NFSv4-specific sections
of NFSD, but the current structure of the code prevents doing that
while maintaining operational efficiency. Plus, these small patches
should be able to apply cleanly to LTS kernels.

We can defer deeper restructuring for later. For example,
fh_verify() could be made to return an errno instead of a generic
NFS status code; then the VFS utility functions in fs/nfsd/vfs.c
could be made to do the same, making their callers responsible for
the proper NFS version-specific translation of the errno into a
status code.

This series has been only compile tested. I'm posting early for
review and comment about this approach, but please do test these if
you have the ability to trigger -EBUSY easily.

Amir notes that NFSv4 OPEN is also affected. nfsd4_open() is a
pretty deep stack of code. If there are stack traces available, we
should be able to see where to start digging for errno leaks in
that operation.

Chuck Lever (4):
  NFSD: nfsd_unlink() clobbers non-zero status returned from
    fh_fill_pre_attrs()
  NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
  NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
  NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file

 fs/nfsd/vfs.c | 102 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 26 deletions(-)

-- 
2.47.0


