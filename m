Return-Path: <linux-nfs+bounces-4335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE87918E56
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34E81C21469
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D57190486;
	Wed, 26 Jun 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYJx2zaT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7619047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426293; cv=none; b=b4mVUGFauI+JyqHxNMtXKWpyDbvzy3KrEIOA7J57plWxFEOI7cc2OkcCk+hf6ZWrzvafcDdA0Zt5hEDssLqeihM8u2EhMoq80yF1octmjcRdZwfof+11WpglwOfLKlY6Tm3AxgN32YWpmCoAqVcdkirPTXT+S86x5cx7ztXFpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426293; c=relaxed/simple;
	bh=nt8Pma0dL3RpE4tCNO0Dhbf8OugOU5QH7AdULOHN108=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug0+NMhf3odvUUxC3LawjJSHdtj1LA5MG3htHcJxmPdt7IWMQhrBnzxS+ASemu+Hffz4/eDNIFwJLRzTULqrfWwunCkwZYIbIzYkEyCBdXnC4CQH8qxPBT7z4YKYqSZsaBwZHfayRKDjLeufKjhOYJYysXHzGdXWngsiuJyv/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYJx2zaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A0C116B1;
	Wed, 26 Jun 2024 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426293;
	bh=nt8Pma0dL3RpE4tCNO0Dhbf8OugOU5QH7AdULOHN108=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYJx2zaTmie0Ded/VijauAKfJokNS6d3d603CghGUpSP3gGIEtdM8Ty4JZX8R8mQ9
	 HNtu+idmTVH9Qvcpb5pzdxervTznkUdodB3WzBWTL3xX+txcqpku5Q4kR7plGeLEOX
	 C5P7GbhwZsms3mfWxN/PoO6ijBEdzCz83WtHEvBU5FURg9P/eg5+xFKcfEx/aif3Qm
	 t+GYcl/bJBbk1v+ScHDTngBknlkEfJQJhWCa6adql3eO854Lzy6v1N6MQJ9mgbvv7H
	 gN0XnpO7Ru8Hs9a+voiM3GpWSgDh0KAgA0j6J7waZJ6ng9gn2PllE0creWRG6rIv3M
	 MQFGZUleGfcXw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 10/18] nfs/nfsd: add Kconfig options to allow localio to be enabled
Date: Wed, 26 Jun 2024 14:24:30 -0400
Message-ID: <20240626182438.69539-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_NFS_LOCALIO controls the client enablement and
CONFIG_NFSD_LOCALIO the server enablement.

While it is true that it doesn't make sense, on a using LOCALIO level,
to have one without the other: it is useful to allow a mix be
configured for testing purposes.  It could be that the same control
could be achieved by exposing a discrete "localio_enabled"
module_param in the server (nfsd.ko) like is already available in the
client (nfs.ko).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig      |  3 +++
 fs/nfs/Kconfig  | 14 ++++++++++++++
 fs/nfsd/Kconfig | 14 ++++++++++++++
 3 files changed, 31 insertions(+)

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
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 57249f040dfc..311ae8bc587f 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -86,6 +86,20 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_LOCALIO
+	tristate "NFS client support for the LOCALIO auxiliary protocol"
+	depends on NFS_V3 || NFS_V4
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS version 3 or 4 protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS client.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
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


