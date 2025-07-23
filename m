Return-Path: <linux-nfs+bounces-13222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203AB0FBBD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 22:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4692A1885010
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBF235050;
	Wed, 23 Jul 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwmkKjjA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829ED1EE7B7
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303036; cv=none; b=cPw5S/GqLmO50zEl2CN/HCU2DwME8Nhv9vwMnJ2yrlGBb13PEp4wgA1n3MvjyCbdeD37oDQtZd06IMz1rPF1LHS7BgZUCqUJQkqW2oxYysgVGyH7GEHMlnQgc2C1yDd75fQarQVjH6f33MbGxvEm1dGtf9ibhlRdjMpKrxRY4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303036; c=relaxed/simple;
	bh=z33NO2TcEOyPJamE1yACLEn0u06Uow+CbhmlhP/xF0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqcfoIZHZo9ZDqy8n+DEGruPNstI8raOXn7HyIf2qftnEPWsdMOBDoZ/VM8xcK8gszJI2YUDHglbJhagXeyl5M88z5xXMHWA96vXDgsMcI1aVXOfEhrhAV++RflVMaqx4pQuJb5hVv/udystvson2QOHN1IuXMCf4Llv6YmQrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwmkKjjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD98FC4CEE7;
	Wed, 23 Jul 2025 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753303036;
	bh=z33NO2TcEOyPJamE1yACLEn0u06Uow+CbhmlhP/xF0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwmkKjjAGK8VGHFewBCe7VmpqsliguzaoU3noIIYgGjnQAatoiINW+RryKprfQHZc
	 xqlR+9A197BPYXi3IHeMQK1UIBsoT32pgJYl0WARhVKZUMmVZ7RmebXmU0bVNswXob
	 kkue7kvwYUUJltKIOt33S4SI/1aGhw4G3h+I68LYuQYXiCwOZqsho+20JdAAP5q7jd
	 Z9y+1wtye0cuIKTyVWWiMWktMlk47e1Xn9CemHujVOGe4yUjSd4UOwqkpwwRzBkG5q
	 MpuASH/YpiqloGcs9GO8nQsu6eYY7CZ6eUqmRosdmqZB/s+KnhWjgnwHgAYQPUkJbh
	 rKW5l20CClfxw==
Date: Wed, 23 Jul 2025 16:37:14 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 6/5] NFSD: filecache: only get DIO alignment attrs if
 NFSD_IO_DIRECT enabled modes
Message-ID: <aIFH-g5A9N623blv@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723154351.59042-1-snitzer@kernel.org>

Avoids needless extra fh_getattr() unless NFSD_IO_DIRECT enabled.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 5447dba6c5da..5601e839a72d 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1058,8 +1058,12 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
 	struct kstat stat;
 	__be32 status;
 
-	/* Currently only need to get DIO alignment info for regular files */
-	if (!S_ISREG(inode->i_mode))
+	/* Currently only need to get DIO alignment info for regular files
+	 * IFF NFSD_IO_DIRECT is enabled for nfsd_io_cache_{read,write}.
+	 */
+	if (!S_ISREG(inode->i_mode) ||
+	    (nfsd_io_cache_read != NFSD_IO_DIRECT &&
+	     nfsd_io_cache_write != NFSD_IO_DIRECT))
 		return nfs_ok;
 
 	status = fh_getattr(fhp, &stat);
-- 
2.43.5


