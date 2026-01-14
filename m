Return-Path: <linux-nfs+bounces-17876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0310D1F913
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77EF3004226
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523330FC08;
	Wed, 14 Jan 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3DPuXnT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D530F54B
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402487; cv=none; b=k7LqqSHrLb+nKQpuRYuXJSMC12ugINsS4ECUYzA9xPQV9zQJPAAxmD07NP/4pCy/tMciD2lS5/EkeZr8eA8rSxTRokkvmKrRGuJu8Dj1DwAlMJXTT5Qi2b2OJZJxvD5DZ3vuxx9ostZZdQYl/kvlnvOoVIbjDnBY6se4PKZkGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402487; c=relaxed/simple;
	bh=YikR99JuZ8NfFZTNIbnoT2pa0ihyo6QC/W1aH65ig8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8c9iM1zKmWh2Zbp52B+K/PLi05MlALcz/6x4C8qulywUfviGvkdMAlxTfjKA3IQRukaPQln7uu0oP67PIIHtXR2HVu8ywJTC0AGTgfMC/4baUUIdJjKoEvVtzgV2K6+rhV5RD8IFKj0J+GzoCp0d0C7MvwsIxw5wEY7MmuA6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3DPuXnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWXjoI3UYL6UVuKotKriH0XXjQ4jpWrGaPtN9ypvv+Y=;
	b=A3DPuXnTkKVGqVSTdQCdr/JTE1dstzQJoclexGgYUPcqXYY9JdE15kCrp5P52XJ99iaNgF
	r68G967L2IJDYnXS9mu0N6unk0vZ38HLCDTR0prqxLvrMV0WvjqlyesJAw6Umm3Hg0qaqV
	Z43HG2Mxf0Z2yi/1n8zQONRj1ZNUeAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-vA1gA3AvNGOpe4zv53X1rA-1; Wed,
 14 Jan 2026 09:54:39 -0500
X-MC-Unique: vA1gA3AvNGOpe4zv53X1rA-1
X-Mimecast-MFC-AGG-ID: vA1gA3AvNGOpe4zv53X1rA_1768402478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C29681955F3F;
	Wed, 14 Jan 2026 14:54:37 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88BD71956053;
	Wed, 14 Jan 2026 14:54:37 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id D46DF5C63A4;
	Wed, 14 Jan 2026 09:54:35 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: hch@infradead.org,
	carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] Rename CONFIG_NFSV41 to CONFIG_BLKMAPD and disable by default
Date: Wed, 14 Jan 2026 09:54:35 -0500
Message-ID: <20260114145435.826165-1-smayhew@redhat.com>
In-Reply-To: <aWc5dO3fP4J67x0H@infradead.org>
References: <aWc5dO3fP4J67x0H@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

pNFS block layout is deprecated in favor of pNFS SCSI layout, which
doesn't require the use of blkmapd.

Since CONFIG_NFSV41 (enabled by default, but can be disabled via
--disable-nfsv41) is only used to enable blkmapd, let's rename it to
CONFIG_BLKMAPD and change the default to disabled.

Distributions that wish to continue to include blkmapd can do so by
adding --enable-blkmapd to their configure script invocation.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 configure.ac        | 22 +++++++++++-----------
 systemd/Makefile.am |  2 +-
 utils/Makefile.am   |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6da23915..bcbf0d69 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,22 +85,22 @@ AC_ARG_ENABLE(nfsv4,
 	AC_SUBST(enable_nfsv4)
 	AM_CONDITIONAL(CONFIG_NFSV4, [test "$enable_nfsv4" = "yes"])
 
-AC_ARG_ENABLE(nfsv41,
-	[AS_HELP_STRING([--disable-nfsv41],[disable support for NFSv41 @<:@default=no@:>@])],
-	enable_nfsv41=$enableval,
-	enable_nfsv41=yes)
-	if test "$enable_nfsv41" = yes; then
+AC_ARG_ENABLE(blkmapd,
+	[AS_HELP_STRING([--enable-blkmapd],[enable support for blkmapd @<:@default=no@:>@])],
+	enable_blkmapd=$enableval,
+	enable_blkmapd=no)
+	if test "$enable_blkmapd" = yes; then
 		if test "$enable_nfsv4" != yes; then
-			AC_MSG_WARN([NFS v4 is not enabled. Disabling NFS v4.1])
-			enable_nfsv41=no
+			AC_MSG_WARN([NFS v4 is not enabled. Disabling blkmapd.])
+			enable_blkmapd=no
 		fi
 		BLKMAPD=blkmapd
 	else
-		enable_nfsv41=
+		enable_blkmapd=
 		BLKMAPD=
 	fi
-	AC_SUBST(enable_nfsv41)
-	AM_CONDITIONAL(CONFIG_NFSV41, [test "$enable_nfsv41" = "yes"])
+	AC_SUBST(enable_blkmapd)
+	AM_CONDITIONAL(CONFIG_BLKMAPD, [test "$enable_blkmapd" = "yes"])
 
 AC_ARG_ENABLE(gss,
 	[AS_HELP_STRING([--disable-gss],[disable client support for rpcsec_gss @<:@default=no@:>@])],
@@ -398,7 +398,7 @@ else
   enable_nfsdcltrack="no"
 fi
 
-if test "$enable_nfsv41" = yes; then
+if test "$enable_blkmapd" = yes; then
   AC_CHECK_LIB([devmapper], [dm_task_create], [LIBDEVMAPPER="-ldevmapper"], AC_MSG_ERROR([libdevmapper needed]))
   AC_CHECK_HEADER(libdevmapper.h, , AC_MSG_ERROR([Cannot find devmapper header file libdevmapper.h]))
   AC_CHECK_HEADER(sys/inotify.h, , AC_MSG_ERROR([Cannot find header file sys/inotify.h]))
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 5e481421..9cc940dc 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -32,7 +32,7 @@ unit_files += \
     nfsv4-server.service
 endif
 
-if CONFIG_NFSV41
+if CONFIG_BLKMAPD
 unit_files += \
     nfs-blkmap.service
 endif
diff --git a/utils/Makefile.am b/utils/Makefile.am
index e5cb81e7..bfa12081 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -11,7 +11,7 @@ if CONFIG_NFSV4SERVER
 OPTDIRS += exportd
 endif
 
-if CONFIG_NFSV41
+if CONFIG_BLKMAPD
 OPTDIRS += blkmapd
 endif
 
-- 
2.52.0


