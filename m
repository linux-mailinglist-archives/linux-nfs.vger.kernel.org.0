Return-Path: <linux-nfs+bounces-4399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BD91C7E2
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF661F237CA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F380028;
	Fri, 28 Jun 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUF9y+BA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67280023
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609089; cv=none; b=DwE8OY0ehQ3D4+aqkBtF36nk0cHt6jj2S3ONUsLrdpvngaxgmr4HOhx98uZj8bV2//r+Y3SUPt8BJZlfDznSI8PDf/UinEhxazxrlU1DfZX0tL++TOuxc+jAM6eDVbN3b93YFORaAlKPZLTC3QM0WZQHHVddcdpsXKbbxNPWPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609089; c=relaxed/simple;
	bh=ec3XlO0ykQnMl6Hqgplw/sKStVr+axU8YmdBT6hlQds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/MFSfX/5FmzwvOmiGjy7ft9wS0Ikygy6PqiQhk4p0DsHTUioV/2eCbs8Z/4XIroFygSOHWT7vjZoK41cHjbSmSNQJJs3hFeqIXRaAX3DrLWyqKSyh3WICKyseb2RUKdNSDIQt14xr0uXytTJv3Yvw+ofx/xppDLoaYlFstKOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUF9y+BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FF9C116B1;
	Fri, 28 Jun 2024 21:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609089;
	bh=ec3XlO0ykQnMl6Hqgplw/sKStVr+axU8YmdBT6hlQds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUF9y+BAAQqElWtzbwxVLypXcg8jdFlM0x1a/1hW/EDYkAuebOZ7mUkDDRqZbprJJ
	 glnQgYOK8P8OF5gJ29Dd80r8IekDaBDmrw1Uv+JU+FJi9BqKdikjjGCWLbWHdSLgyp
	 CjNaSi2WFLGYZZXA9jan4LPJt5tXpJindBcwm8S5RnInmaShiuWXH+b7rcqz+YcOob
	 m5B9l28QkCNlsqw9K7KNfYQ/CtJEYc+pGQKd/T2amSoZsq3IboTU7uQI3ktcu2Z8Ji
	 0elqB9obEGPkK0+LK45SvgJlj25diG8HJ7MnitESUVXjgeYNQhXawPQeoM+YVeY80C
	 4mKvZKfpJth/w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 16/19] nfsd: add Kconfig options to allow localio to be enabled
Date: Fri, 28 Jun 2024 17:11:02 -0400
Message-ID: <20240628211105.54736-17-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_NFSD_LOCALIO controls the server enablement for localio.
An earlier commit added CONFIG_NFS_LOCALIO to allow the client
enablement.

While it is true that it doesn't make sense, on a using LOCALIO level,
to have one without the other: it is useful to allow a mix be
configured for testing purposes.  It could be that the same control
could be achieved by exposing a discrete "localio_enabled"
module_param in the server (nfsd.ko) like is already available in the
client (nfs.ko).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ec2ab6429e00..a36ff66c7430 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -89,6 +89,20 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_LOCALIO
+	tristate "NFS server support for the LOCALIO auxiliary protocol"
+	depends on NFSD || NFSD_V4
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS version 3 or 4 protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
-- 
2.44.0


