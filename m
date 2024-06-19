Return-Path: <linux-nfs+bounces-4107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6D90F7AA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE78728338C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24E159571;
	Wed, 19 Jun 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX0oN6Lb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864C1591FC
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829658; cv=none; b=D09EaSG6YRmjgpiiUwNKoI1BecXtiJF7Fyq3iIHqa3AxNCbDSxBAsNSGbLZAA+vd/+tcDTDHcZOW1pKGLdCymjnRCLts9y2mM7TVVQ4HmzQI/+XqeztdhEZEplxKJZG5Ek6hysfNwY7KTpkq/eCFZnbz3/AwcJvNIRUpPBONWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829658; c=relaxed/simple;
	bh=n7KqzD+QeP690GhXTCVAaa7sRFNrt84jt4GePXfQFYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/qjA0nXbqe3Dh1TWRKSJp3hqBes4XXO1mqpkx+ixwxsvmcYo2VvyvDvkoYTUVqR+yH/fQzOCiCreZXxPJAzxPEifJOTaEDTyJrO1cJwf97ODFaPQd7cp6rXcH/p1Fg042g7GyozuJNB/fF9VTnIS4lWTxugJVi4/a2W03YPgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX0oN6Lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4892AC2BBFC;
	Wed, 19 Jun 2024 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829658;
	bh=n7KqzD+QeP690GhXTCVAaa7sRFNrt84jt4GePXfQFYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QX0oN6Lbv0vChcrJgEL+457b+HTzwfw4gT20I3+aK10mJktnBszyZpqzPcIHy0lui
	 fe10kr25ooDb/O6/0YSO6lOHYdpQLIMcgpUQ4nNXWCiDmCrrTcAxegMZT14g+pXmd8
	 v0vmKuK6iWToPU0Nk0gcZfhyYBIhlUOzoHVyoWxTRtjbJ32StzxWial/WI8XgEs6Gb
	 j9lHoqj41XQpZ1boJ4Yn0/7U9m3f5uCkbWLdvE26BtH4u1KeOTUw/gCHvP1h466blY
	 ewMr1GSLP7GypY+Yef3eG04hsPnNcrRmQPxvH0o8to61Gy6fj71NIm/X8ArxYCf1tP
	 OX8j933fKwnMA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 18/18] nfs/nfsd: add Kconfig options to allow localio to be enabled
Date: Wed, 19 Jun 2024 16:40:32 -0400
Message-ID: <20240619204032.93740-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the localio code is complete, allow users to enable it.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig      |  3 +++
 fs/nfs/Kconfig  | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/Kconfig | 30 ++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

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
index 57249f040dfc..70ff4f7a1a22 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -1,10 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config NFS_LOCALIO
+	tristate
+
 config NFS_FS
 	tristate "NFS client support"
 	depends on INET && FILE_LOCKING && MULTIUSER
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
+	select NFS_LOCALIO if NFS_V3_LOCALIO || NFS_V4_LOCALIO
+	select NFS_COMMON_LOCALIO_SUPPORT if NFS_LOCALIO
 	help
 	  Choose Y here if you want to access files residing on other
 	  computers using Sun's Network File System protocol.  To compile
@@ -72,6 +78,18 @@ config NFS_V3_ACL
 
 	  If unsure, say N.
 
+config NFS_V3_LOCALIO
+	bool "NFS client support for the NFSv3 LOCALIO protocol extension"
+	depends on NFS_V3
+	help
+	  Some NFS servers support an auxiliary NFSv3 LOCALIO protocol
+	  that is not an official part of the NFS version 3 protocol.
+
+	  This option enables support for version 3 of the LOCALIO
+	  protocol in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
@@ -86,6 +104,18 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_V4_LOCALIO
+	bool "NFS client support for the NFSv4 LOCALIO protocol extension"
+	depends on NFS_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ec2ab6429e00..edae34a7b7e5 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config NFSD_LOCALIO
+	tristate
+
 config NFSD
 	tristate "NFS server support"
 	depends on INET
@@ -9,6 +13,8 @@ config NFSD
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
+	select NFSD_LOCALIO if NFSD_V3_LOCALIO || NFSD_V4_LOCALIO
+	select NFS_COMMON_LOCALIO_SUPPORT if NFSD_LOCALIO
 	depends on MULTIUSER
 	help
 	  Choose Y here if you want to allow other computers to access
@@ -69,6 +75,18 @@ config NFSD_V3_ACL
 
 	  If unsure, say N.
 
+config NFSD_V3_LOCALIO
+	bool "NFS server support for the NFSv3 LOCALIO protocol extension"
+	depends on NFSD
+	help
+	  Some NFS servers support an auxiliary NFSv3 LOCALIO protocol
+	  that is not an official part of the NFS version 3 protocol.
+
+	  This option enables support for version 3 of the LOCALIO
+	  protocol in the kernel's NFS server.
+
+	  If unsure, say N.
+
 config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
@@ -89,6 +107,18 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_V4_LOCALIO
+	bool "NFS server support for the NFSv4 LOCALIO protocol extension"
+	depends on NFSD_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
-- 
2.44.0


