Return-Path: <linux-nfs+bounces-4237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E1913AE7
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD10D1C20C79
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC5181CFC;
	Sun, 23 Jun 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1VoTa1q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F96181CEF;
	Sun, 23 Jun 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150251; cv=none; b=W6XoC4Aj74684rDn3qEogb3T2Z6f+n/SeXNoWa6QTlPmH+7jP5Tv0CgFdA8ex+Ntc90hnTTuF/oWY2u5b7Di+cGikW0HNNVYWG9A3x8zKTgbLw4uXwyxdQouHX8wB+R+3EyB7Rs3o/otrpwvgKiM4v/mcP8XdsenGRss5bCxMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150251; c=relaxed/simple;
	bh=Ir1p6yFzpMnK+ZnqK5INdsQJHgRhIC74V2RcyvI2lhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8j0KucHf6h7/d1GRj01e5hcbuaUw+RtPKSUB93J2LGR0OZYiUUSu0vVh7NGR5HgSlJRQ4S4ZMwQrIWDWA2j5Ag0cCh0HkRz1SFiTeGL55UIKyytcpPZs7mUxAhFFiqA0G7pR7y6w5re4M/HqzbCqSHJZhOExU2czfHQk5/qPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1VoTa1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFA2C4AF13;
	Sun, 23 Jun 2024 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150251;
	bh=Ir1p6yFzpMnK+ZnqK5INdsQJHgRhIC74V2RcyvI2lhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1VoTa1qk93laEQn84LhfmDjDnElN5kFay1TPU2krje4lPuRxLQNGjDXZpKPucZD2
	 coFq4PUG45h2rqoeDxzBGdcGkXuplJ+dgl+l6KQ6YxFHCyJnG+y/mgJ4sEn30IvTf5
	 zLxbjbSpPFKBve+majtvIW43XfnH0I6Kvwq6oauaqxFk+WN1MOV5Skcv+MKR0kgX98
	 q6BDD4yV6nCUsRQLGsz934BpVq+GMI5t5SVUFUDR6DKMQMt7lOElvoX9/QEGLKFAy+
	 AjnaWdyrqFEZ+ripWl/gWyh6g7NHGHPeohnFgb7+mV9/UB4RYK/SNtKsVzuIwyiZXr
	 pKqo6nPKOpaSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 03/21] nfs: Avoid flushing many pages with NFS_FILE_SYNC
Date: Sun, 23 Jun 2024 09:43:36 -0400
Message-ID: <20240623134405.809025-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit a527c3ba41c4c61e2069bfce4091e5515f06a8dd ]

When we are doing WB_SYNC_ALL writeback, nfs submits write requests with
NFS_FILE_SYNC flag to the server (which then generally treats it as an
O_SYNC write). This helps to reduce latency for single requests but when
submitting more requests, additional fsyncs on the server side hurt
latency. NFS generally avoids this additional overhead by not setting
NFS_FILE_SYNC if desc->pg_moreio is set.

However this logic doesn't always work. When we do random 4k writes to a huge
file and then call fsync(2), each page writeback is going to be sent with
NFS_FILE_SYNC because after preparing one page for writeback, we start writing
back next, nfs_do_writepage() will call nfs_pageio_cond_complete() which finds
the page is not contiguous with previously prepared IO and submits is *without*
setting desc->pg_moreio.  Hence NFS_FILE_SYNC is used resulting in poor
performance.

Fix the problem by setting desc->pg_moreio in nfs_pageio_cond_complete() before
submitting outstanding IO. This improves throughput of
fsync-after-random-writes on my test SSD from ~70MB/s to ~250MB/s.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pagelist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116e..040b6b79c75e5 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1545,6 +1545,11 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 					continue;
 			} else if (index == prev->wb_index + 1)
 				continue;
+			/*
+			 * We will submit more requests after these. Indicate
+			 * this to the underlying layers.
+			 */
+			desc->pg_moreio = 1;
 			nfs_pageio_complete(desc);
 			break;
 		}
-- 
2.43.0


