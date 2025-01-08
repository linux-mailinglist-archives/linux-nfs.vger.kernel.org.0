Return-Path: <linux-nfs+bounces-9001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A082DA06900
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 23:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D88A1888F0B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDE20408C;
	Wed,  8 Jan 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXfHvVyr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B992040A3
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376886; cv=none; b=tr+NvmDmg66HNFAaO4P42O9LAPo3LbkKhvvseHYIHoKk/XAmuj+NG9L0Fmyme81wfioeNXF6TmWOsRvWUOfTaUhGRsJPofeREq4OAmqW3rof/7dg75ERTju9ykRTyD0rsNTHJfQyy6AhkPfA8x05XKWhy9mun8+0bIe0GdaX6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376886; c=relaxed/simple;
	bh=PsktHwbeo92KFMG2d8kJgen+2bKXv3mNXw9pVPvW9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmNX41qmRROLD1uXtog5aj4sfdv64DzQAj2wKbDV00+RZjaoiWzpBYWCoq3vaqGF46TkDHeYXZs7I3MTHr2f7siIjgVbe0EVezZ0F1Q4o7jbkkP43kOBU1FKCLlX22CVMa20WOa0nMXf5kO875HN0AmtfX2of7uOi+aWU/fc3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXfHvVyr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736376883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=whZNX1Rilyr2aqPPJZpq67r3niRHtAdZ8tFoam4hgpw=;
	b=cXfHvVyrtmDiyI+uUUGzZ5PkZ6JKgX1H4U7Ci9htMuQzOkXnIS4oBJ+xTBzNSrPvcsPH8a
	YcepJraddMIgCH33+y/iy+X3LtuBKNx/S/3UODZxiVHQ/E5WT4EO8el8tEBeT/GFosx5i3
	+kZ8072SlbUmHjLs9HoUGYc6hhzB0nw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-ayJESXIwNAGnt0Dt2PI3wg-1; Wed,
 08 Jan 2025 17:54:41 -0500
X-MC-Unique: ayJESXIwNAGnt0Dt2PI3wg-1
X-Mimecast-MFC-AGG-ID: ayJESXIwNAGnt0Dt2PI3wg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E355B19560B3
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 22:54:40 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97DAC19560AB;
	Wed,  8 Jan 2025 22:54:40 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 628302E9E19;
	Wed, 08 Jan 2025 17:54:39 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
Date: Wed,  8 Jan 2025 17:54:39 -0500
Message-ID: <20250108225439.814872-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The section for the 'nfsdctl version' subcommand on the man page states
that the minorversion is optional, and if omitted it will cause all
minorversions to be enabled/disabled, but it currently doesn't work that
way.

Make it work that way, with one exception.  If v4.0 is disabled, then
'nfsdctl version +4' will not re-enable it; instead it must be
explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the way
/proc/fs/nfsd/versions works.

Link: https://issues.redhat.com/browse/RHEL-72477
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.8    |  9 ++++--
 utils/nfsdctl/nfsdctl.adoc |  5 +++-
 utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++---
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index b08fe803..835d60b4 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2024-12-30
+.\"      Date: 2025-01-08
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -172,7 +172,10 @@ MINOR: the minor version integer value
 .nf
 .fam C
 The minorversion field is optional. If not given, it will disable or enable
-all minorversions for that major version.
+all minorversions for that major version.  Note however that if NFSv4.0 was
+previously disabled, it can only be re\-enabled by explicitly specifying the
+minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
+interface).
 .fam
 .fi
 .if n .RE
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index c5921458..20e9bf8e 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -91,7 +91,10 @@ Each subcommand can also accept its own set of options and arguments. The
     MINOR: the minor version integer value
 
   The minorversion field is optional. If not given, it will disable or enable
-  all minorversions for that major version.
+  all minorversions for that major version.  Note however that if NFSv4.0 was
+  previously disabled, it can only be re-enabled by explicitly specifying the
+  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
+  interface).
 
   Note that versions can only be set when there are no nfsd threads running.
 
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 722bf4a0..d86ff80e 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int minor, bool enabled)
 	return -EINVAL;
 }
 
+static bool v40_is_disabled(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		if (nfsd_versions[i].major == 0)
+			break;
+		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor == 0)
+			return !nfsd_versions[i].enabled;
+	}
+	return false;
+}
+
+static int get_max_minorversion(void)
+{
+	int i, max = 0;
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		if (nfsd_versions[i].major == 0)
+			break;
+		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor > max)
+			max = nfsd_versions[i].minor;
+	}
+	return max;
+}
+
 static void version_usage(void)
 {
 	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
@@ -778,7 +804,8 @@ static void version_usage(void)
 
 static int version_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int ret, i;
+	int ret, i, j, max_minor;
+	bool v40_disabled;
 
 	/* help is only valid as first argument after command */
 	if (argc > 1 &&
@@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 		return ret;
 
 	if (argc > 1) {
+		v40_disabled = v40_is_disabled();
+		max_minor = get_max_minorversion();
+
 		for (i = 1; i < argc; ++i) {
 			int ret, major, minor = 0;
 			char sign = '\0', *str = argv[i];
@@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 				return -EINVAL;
 			}
 
-			ret = update_nfsd_version(major, minor, enabled);
-			if (ret)
-				return ret;
+			/*
+			 * The minorversion field is optional. If omitted, it should
+			 * cause all the minor versions for that major version to be
+			 * enabled/disabled.
+			 *
+			 * HOWEVER, we do not enable v4.0 in this manner if it was
+			 * previously disabled - it has to be explicitly enabled
+			 * instead.  This is to retain the behavior of the old
+			 * /proc/fs/nfsd/versions interface.
+			 */
+			if (major == 4 && ret == 2) {
+				for (j = 0; j <= max_minor; ++j) {
+					if (j == 0 && enabled && v40_disabled)
+						continue;
+					ret = update_nfsd_version(major, j, enabled);
+					if (ret)
+						return ret;
+				}
+			} else {
+				ret = update_nfsd_version(major, minor, enabled);
+				if (ret)
+					return ret;
+			}
 		}
 		return set_nfsd_versions(sock);
 	}
-- 
2.47.1


