Return-Path: <linux-nfs+bounces-9115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBFA09C4D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B833A9B5A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7AC218ADB;
	Fri, 10 Jan 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElXRYgmt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37F22332F
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540274; cv=none; b=fjZhDD/g5y3sLCe6VNwzyVYFZVpDKz4AWAEQXdEDmx9gguIuGj2KK1qkAtwcgcdjeY9PRPQX4QO3d3mOPRWN7Z+ZZeWb46jeDYc/VcuIz5xcgRSnQXp4CEE6JRPdNKyFIusVRYO10vFkMxrQcYBNFCnpJagPdTu5CMT3NZMXgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540274; c=relaxed/simple;
	bh=50MwRORWrQ4AR9DgZAyJidu2U9c8JzITqMkgVrpb72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBTmkB2+eDjNclg7pqjdsnWomqetKvv6Sad2cFUR6+P581zz8SblYpOHGM9TVG7+PXeRiKZluKphgTPHD5mduRxYyCzDgy/HfXGmGjR0roQkLWql5L0DS3u1Xf4r3ghz9GOpUR7KwUsfl793d8UpDtJClVjM30hsI/gaaHxRo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElXRYgmt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736540271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfVTK2dcM4xy2CN54FgNVjlK++KLAB66tNc/J9SUg0Q=;
	b=ElXRYgmtrmaqcEPfmpnw7EK3fw7K9GIGtg4Fe00hqoCM8CPbSfjLqifRXEY6GZuMY8sfjF
	sc5d2KCPyLPQNPXA62OLKSUrrJ26VfbKaAWdWQ/I7HVo8Lf9W1VAvDkFkARxvxBEGvapbH
	agSGNHRTrWjH66x8WEthPdEfQ86qiq8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-JTiAoZN5NiWlC6uFl8nRIQ-1; Fri,
 10 Jan 2025 15:17:50 -0500
X-MC-Unique: JTiAoZN5NiWlC6uFl8nRIQ-1
X-Mimecast-MFC-AGG-ID: JTiAoZN5NiWlC6uFl8nRIQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B071955DDA;
	Fri, 10 Jan 2025 20:17:49 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03982195E3D9;
	Fri, 10 Jan 2025 20:17:49 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 1A2102EA239;
	Fri, 10 Jan 2025 15:17:47 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v2 1/2] nfsdctl: tweak the version subcommand behavior
Date: Fri, 10 Jan 2025 15:17:45 -0500
Message-ID: <20250110201746.869995-2-smayhew@redhat.com>
In-Reply-To: <20250110201746.869995-1-smayhew@redhat.com>
References: <20250110201746.869995-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The section for the 'nfsdctl version' subcommand on the man page states
that the minorversion is optional, and if omitted it will cause all
minorversions to be enabled/disabled.  Make it work that way.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index ef917ff0..38c22225 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -754,6 +754,19 @@ static int update_nfsd_version(int major, int minor, bool enabled)
 	return -EINVAL;
 }
 
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
@@ -771,7 +784,7 @@ static void version_usage(void)
 
 static int version_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int ret, i;
+	int ret, i, j, max_minor;
 
 	/* help is only valid as first argument after command */
 	if (argc > 1 &&
@@ -785,6 +798,8 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 		return ret;
 
 	if (argc > 1) {
+		max_minor = get_max_minorversion();
+
 		for (i = 1; i < argc; ++i) {
 			int ret, major, minor = 0;
 			char sign = '\0', *str = argv[i];
@@ -808,9 +823,22 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 				return -EINVAL;
 			}
 
-			ret = update_nfsd_version(major, minor, enabled);
-			if (ret)
-				return ret;
+			/*
+			 * The minorversion field is optional. If omitted, it should
+			 * cause all the minor versions for that major version to be
+			 * enabled/disabled.
+			 */
+			if (major == 4 && ret == 2) {
+				for (j = 0; j <= max_minor; ++j) {
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
2.45.2


