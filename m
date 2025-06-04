Return-Path: <linux-nfs+bounces-12094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960FACE104
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC18B3A834B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5709290D80;
	Wed,  4 Jun 2025 15:12:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F285290D97
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049960; cv=none; b=NaFY82cSTeGeQIFdZ1NU06ot1HFrf1FJ0dx230k3K/Za3K+NhUdbLZijqr4PWtC/ikXva2Lx9iLJUdGDagIlSmoyirpK2BEbJxteEu2GggEFvaACo0f6sgTfgT0n0HOfVFuAY++n5MF8LCSsFQPQrYjvOUiJWkKBeGHS7QXQLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049960; c=relaxed/simple;
	bh=NErDkwDaPBdOoLcKhE1pONSR1BPaoKY06d9RWO8QczA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F9n3HYTmY+DqpeU1yEyiLw6eVEzouyc5NvpyN/VGIU8x7Uz9C1f+oX1dFbal0OCToTHP2ssQXeb+jOGZ0iyI9C7y3a/vOrbVILnvefvfU6bPExWvl/q2t72Rsfy2xz+PWdjEbwZLkkaaagGBxemhoB13I74wKn5yIXG/bMSHRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-EBlIGYM7PkSL2XVW-Og99w-1; Wed,
 04 Jun 2025 11:12:36 -0400
X-MC-Unique: EBlIGYM7PkSL2XVW-Og99w-1
X-Mimecast-MFC-AGG-ID: EBlIGYM7PkSL2XVW-Og99w_1749049955
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEF1A18002BD
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 15:12:35 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.65.168])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38DE118002A5
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 15:12:34 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] configure.ac: AC_PROG_GCC_TRADITIONAL is obsolete.
Date: Wed,  4 Jun 2025 11:12:33 -0400
Message-ID: <20250604151233.89866-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

configure.ac:581: warning: The macro 'AC_PROG_GCC_TRADITIONAL' is obsolete.
configure.ac:581: You should run autoupdate.
./lib/autoconf/c.m4:1676: AC_PROG_GCC_TRADITIONAL is expanded from...
configure.ac:581: the top level

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d8205e80..e402c22d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -578,7 +578,7 @@ AC_FUNC_ERROR_AT_LINE
 AC_FUNC_FORK
 AC_FUNC_GETGROUPS
 AC_FUNC_GETMNTENT
-AC_PROG_GCC_TRADITIONAL
+AC_PROG_CC
 AC_FUNC_LSTAT
 AC_FUNC_LSTAT_FOLLOWS_SLASHED_SYMLINK
 AC_HEADER_MAJOR
-- 
2.49.0


