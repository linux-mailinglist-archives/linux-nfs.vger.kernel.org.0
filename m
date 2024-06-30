Return-Path: <linux-nfs+bounces-4421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D991D2B8
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204721C208BF
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6FE153838;
	Sun, 30 Jun 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACnksg1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F12576F
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765470; cv=none; b=sOSLp2f0v5cn90phLVxV6KrfDqPzv3I9pgpycHufojGdbXVCDq07VGmIAD8Jy3W0NN5uVXXZbn9PN4+mEccnt+4+SUgXnLgfH9h9+J3zfA4K57gETowj4DKYKIz5vLLlZ+U3l3bzmiUarQEAcZPo2CmfA4vC/uJOvMcXU8NKlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765470; c=relaxed/simple;
	bh=sk4tA8UjP1N08DF2U6NzSQfYN1q9ZnuLJ3s63y2YfPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IECBhHFFiaAichzRIHsfJZEcA77IIQipTp3qf7K29MQ5zrX0UtYuKXI9buQr44Tq8iXkWsUJcxRXNtdvj1qp5uLwDOoXTm7H+DyNTPFvqushTxcdrZ/eRfd9QCylisWU9cGkvTATkHeb1T5Uh+bI0NYJJ42GPyzHV7JccRFpVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACnksg1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F209C32786;
	Sun, 30 Jun 2024 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765469;
	bh=sk4tA8UjP1N08DF2U6NzSQfYN1q9ZnuLJ3s63y2YfPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACnksg1ChS23JeKmOddK0aAGzUl3rZBbKQNCpQPkgKd1If658F5HFgTNClYOOlzAE
	 w62k0Xn9L+0tsM4NcrBTRgwtM6pbnJChghBf9TUEyT+tNUkBuSsM5uWEsvlV9TmX7R
	 cs612FcuuJkYH5q4Sa3oIP3s6DwdldQThZazSHS5zXDIjJRdIxKRNi02+FtKcUZwW4
	 dMXN6AJKIDj4nNqCpPfLfnpnLWqe/gugGU3kSr59VGXuovuIO6VOjjRMDKrKTwIoRw
	 puQxPNqK0wCJyhvzCumofJW1t00IkhnOAZyYOc1+IqHYIKFVRKhz2XY/a73dj0f+UV
	 Io1pWxY6l69/Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 05/19] nfsd: add Kconfig options to allow localio to be enabled
Date: Sun, 30 Jun 2024 12:37:27 -0400
Message-ID: <20240630163741.48753-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_NFSD_LOCALIO controls the server enablement for localio.
A later commit will add CONFIG_NFS_LOCALIO to allow the client
enablement.

While it is true that it doesn't make sense, on a using LOCALIO level,
to have one without the other: it is useful to allow a mix be
configured for testing purposes.  It could be that the same control
could be achieved by exposing a discrete "localio_enabled"
module_param in the server (nfsd.ko) like is already available in the
client (nfs.ko).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig      |  3 +++
 fs/nfsd/Kconfig | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..170083ff2a51 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	tristate
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
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


