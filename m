Return-Path: <linux-nfs+bounces-4542-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72392438A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE0DB259AF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A781BD4E5;
	Tue,  2 Jul 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNeGZkbr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823211BC06B
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937719; cv=none; b=DlmObn8C0xFJ8ddbPVIX9ZX56WXAPlXFdASNZsskzzgB6+IrGSPtlUJ7PsW/UPU52KcDd8CquSchYYREpiZPdFnMMDm/IgGDfasYkqEvbC1O0426cJ0y81cACHAHMpXPO8v+SR+bbhMNJRX/ryPqnrS9lI1zdtwf1PkpA9PvOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937719; c=relaxed/simple;
	bh=sk4tA8UjP1N08DF2U6NzSQfYN1q9ZnuLJ3s63y2YfPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Htncm52R8o5TgeQ4BDBDeCsrFkDdZRaJ196yWSko29miieP8vf+NzfaU/I/uLmsdscuFaG/E6nKxkTOwrtDS8/gkQm0HK+Wm2W2N8nM/vtvaR0iBQe4xaCDBGlRADZEa/dAv5VGaDPfi3hB+JjYueDpN+QVGNaS/EpoOdZMHxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNeGZkbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3A8C116B1;
	Tue,  2 Jul 2024 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937719;
	bh=sk4tA8UjP1N08DF2U6NzSQfYN1q9ZnuLJ3s63y2YfPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNeGZkbryC4IDNkFEAtUJ6YxT0zxKbgMd3Vu3Ole2ZtsrqAK7ljErOKmQGQPrnQ7R
	 Cd8r6pyF4T5bupvltVEbhZJ530z0P+Zy5tWMyl09GMbRUZPOvBycFw4WIGFIVJebVP
	 XZkd3DlZ8dc+d0QOrpYk8WDvRxLedRTvVuDCk164XO1zb08YLf/s70B3keY8HRDRUO
	 +KmeoYY28pIDy40Q1LxlXra2fim8dTpxfLml1NzUrNzOYrLFbnxLv5RD6mdo/O+6H1
	 pjRMeBwfffs2FzsttNwBP6QwCV+8JcvwZmBB0qDK4mpZ0TcItxJKO4JA3/lq68mMyt
	 FNebNt0P9skyg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 05/20] nfsd: add Kconfig options to allow localio to be enabled
Date: Tue,  2 Jul 2024 12:28:16 -0400
Message-ID: <20240702162831.91604-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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


