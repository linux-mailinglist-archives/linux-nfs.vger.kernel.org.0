Return-Path: <linux-nfs+bounces-9637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA60A1CEDD
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DDC165C92
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3286AE3;
	Sun, 26 Jan 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knzv4ETj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016625A64F
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928224; cv=none; b=RwWS+Vd9P3JeXF/Etgn4NvTvPBonHe24WQiJ+qflxWlHVKttsj7vnPw/W/wgfJw+xE8d41Yv+uPYeaSi8U+/YaJrpskcRjzUd8C/DPxkzjEVEFiKhtyUNNDybENDhz/dHcAAJ8nDlUbmhCCx8FPeQmShtVLBfQ2dG9b5hnzhG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928224; c=relaxed/simple;
	bh=eelTOMF0nytP5T33dk4/k9It3sQ21l/5p05Fiu/naQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqJVGTC+ZFmEh2KcBeCasYLyDyQwNMKsxYU7amgRxFMR2soeTO4NZ1vDNom8RNTpW+zGW2NpSbBVtUAlDJuOuJqet/VilBVyUZWhUNRAUKjfvAOtze7FGxVM6LxcB6u5kumvUooo7KeI6VDNw7pbm8CltaT4qwWKGxRCcUpFsTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knzv4ETj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E1EC4CED3;
	Sun, 26 Jan 2025 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737928224;
	bh=eelTOMF0nytP5T33dk4/k9It3sQ21l/5p05Fiu/naQE=;
	h=From:To:Cc:Subject:Date:From;
	b=Knzv4ETjOECTPeKocT8wnZqWw5QFkMpwlTuaJEAuoe6N2dQBrN12DJlGKvB6IPdoN
	 ByJKbxbCvZhxkiz0rm+bODtt6CXZ3ehzwAEZ7hQVJZryhSQbqLl3MnmkToq0JYs8AS
	 CMPYJ1zU1zypfJrhw8Ria+tF0w9RwTUaFjFHadLju8d3AHl7f3lvPiw8V80TYrfqRM
	 k/xhkxJzBMKD7cmzAUGVfLAXB/KlcYoVHJJ67brqi8sPkg66/a8uyd5zB7fdAo6Z99
	 J9bkpiYtYSYO3Z8PyfEAe03Ld6bSNXkUP4sexv2KR9gULsveIo4Px1iUXnHMt+yQKv
	 pL17V1MZcbKPQ==
From: cel@kernel.org
To: Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/4] Avoid returning NFS4ERR_FILE_OPEN when not appropriate
Date: Sun, 26 Jan 2025 16:50:16 -0500
Message-ID: <20250126215020.2466-1-cel@kernel.org>
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
server to return FILE_OPEN is when the target of the operation is an
object that is open and cannot be closed immediately to satisfy the
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

This series has passed git regression and xfstests. I'm interested
in review and comment about this approach, but please do test these
if you have the ability to trigger -EBUSY easily.

NFSv4 OPEN is also affected, but because of its complexity will
require careful audit (ie, a separate patch set). Please send a copy
of the output of WARN_ONCE so we can see where to start digging in
that area.

Changes since v2:
- Fix crash when renaming to a non-existent object

Changes since RFC:
- Address a minor code odor
- Clarify some code comments

Chuck Lever (4):
  NFSD: nfsd_unlink() clobbers non-zero status returned from
    fh_fill_pre_attrs()
  NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
  NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
  NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file

 fs/nfsd/vfs.c | 105 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 26 deletions(-)

-- 
2.47.0


