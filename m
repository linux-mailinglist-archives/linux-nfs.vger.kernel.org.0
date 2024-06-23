Return-Path: <linux-nfs+bounces-4241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A58913B2A
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4756281DF8
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF018F2C6;
	Sun, 23 Jun 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ2p9x9g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558971822D9;
	Sun, 23 Jun 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150294; cv=none; b=djqQdyqEl3o2b4jOv4BiTLAo+W5izBLeHwG5vIDK79vFAbGnNOCxASxU6OqRHEzLH86s1XkgeoZ+wpjaeNSkHKWum33NEBqY55tWT7PB21Sil4dE7QjG/oRIjC9E/9VIAk9NTq8o0sDa0Yzf9lC0mM9ZWf53S4AILf5IJzKrswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150294; c=relaxed/simple;
	bh=Ir1p6yFzpMnK+ZnqK5INdsQJHgRhIC74V2RcyvI2lhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujYbSsjKNHoz1jSxOAWx1tHEh/+rl9XjcytzhtiujziOhQ92KPEaMQMbSfT79g84F9/B3cyMuJFNMVu/YUALQrgWlTGEt+4rWuANdOwUtpTlUDQNlpoSEW0/Q2FUjDvMCfTDDcHIZAL7qRvxmHYDtkFgtdVgGxOjvaEIAMB7EfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ2p9x9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A852C2BD10;
	Sun, 23 Jun 2024 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150294;
	bh=Ir1p6yFzpMnK+ZnqK5INdsQJHgRhIC74V2RcyvI2lhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJ2p9x9gL8jqsTpm5zjTosq8+2CKOvKNRBl86Ld4X683uwdEZdsiS9utv7eUDIEbY
	 p8rI2evQW4o7dwHt8ANFPfPvwvSq3DiIKMOaShRweLPe5Is0Ks/mNIczdLA7VtSQXs
	 tNm9J4/0mdO0ylzR9jnP7uod8ueSm3qrozrSrN//kg8v/8mI83n1AHNzeTiXeZK6hV
	 MAtaLvMS9/664VxRTyLTUESJSkDcljgxYVXi2q2WKFnL+rr00ISauJp1OKQ/8e8uUR
	 YVNbo43REOOi60Fhf+hEnFZn2XSltimRL9Lh/j++RUi9m6+9+qodmWZT+zSKeXda+R
	 nQJq241+mbdCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/16] nfs: Avoid flushing many pages with NFS_FILE_SYNC
Date: Sun, 23 Jun 2024 09:44:32 -0400
Message-ID: <20240623134448.809470-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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


