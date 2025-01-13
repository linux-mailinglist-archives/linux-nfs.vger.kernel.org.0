Return-Path: <linux-nfs+bounces-9187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65592A0C561
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664AD1885788
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617EF1F9F68;
	Mon, 13 Jan 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW9Zznb1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED81F9ED5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810008; cv=none; b=JgQbu1K7Qw11VgrK+z4qEvdMPA/Bx3F9r/HFOfY8iFNxlmOF5TkPLLIx7NygGdeQEFYORaO4p5NPOzPAwsXs3+pHf5q2RkeFhIIMyd7GuognwZK5OaZoVV3uVc9y0t1d9zU0rFcBHBmTvzNhc0mB97Yp32FavjD0ONSW9tOAB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810008; c=relaxed/simple;
	bh=uvnlJVJ9Pe8jma4qd+CjRbhn5BfP7p/0sfujal2qTC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGZ1SeVDxEEkvrMUYrIQYEKJh0NNyNxkGhqplQ3HVWkPW8Kdk9/IK61PsQK9U5HEayxKfyxhhMQY9+DdYLITlUG4iTow3QlaJrq0xqIGy3WQ/Aqsid0s27sdrqulPbTBVZAUcHT+IgCGcjbx5kyzP1SO7omcfBCNTtmfRV+FwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bW9Zznb1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736810005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdIDgQ/Eo5aILZciaFRhUOxgFcG0RvZdN4Jl3Jl0UN8=;
	b=bW9Zznb1CXJHXCk1Mc/cSfUcBUbVsXOsbTUuZ8R20okOM/3J/2irO0Pi8w7UgUxdmErSTm
	03+2pR2/bxEbAaqu+ylRdTzw0+U3NURR7FnrFrFkM59JCUhSXoc2Mr309+rytSRXhTu4t5
	8YDvz+0TjC2l0aCGUwGSx9mcU4mO5qg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-odIo0wtfNdGngZWSIOw5kw-1; Mon,
 13 Jan 2025 18:13:22 -0500
X-MC-Unique: odIo0wtfNdGngZWSIOw5kw-1
X-Mimecast-MFC-AGG-ID: odIo0wtfNdGngZWSIOw5kw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6E219560B0;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D36530001BE;
	Mon, 13 Jan 2025 23:13:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id BCB212EA88D;
	Mon, 13 Jan 2025 18:13:19 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 1/3] nfsdctl: tweak the version subcommand behavior
Date: Mon, 13 Jan 2025 18:13:17 -0500
Message-ID: <20250113231319.951885-2-smayhew@redhat.com>
In-Reply-To: <20250113231319.951885-1-smayhew@redhat.com>
References: <20250113231319.951885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The section for the 'nfsdctl version' subcommand on the man page states
that the minorversion is optional, and if omitted it will cause all
minorversions to be enabled/disabled.  Make it work that way.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 003daba5..88b728e0 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -783,6 +783,19 @@ static int update_nfsd_version(int major, int minor, bool enabled)
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
@@ -800,7 +813,7 @@ static void version_usage(void)
 
 static int version_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int ret, i;
+	int ret, i, j, max_minor;
 
 	/* help is only valid as first argument after command */
 	if (argc > 1 &&
@@ -814,6 +827,8 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 		return ret;
 
 	if (argc > 1) {
+		max_minor = get_max_minorversion();
+
 		for (i = 1; i < argc; ++i) {
 			int ret, major, minor = 0;
 			char sign = '\0', *str = argv[i];
@@ -837,9 +852,22 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
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


