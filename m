Return-Path: <linux-nfs+bounces-12805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90570AEB3C9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFF21C22BC1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42726AABA;
	Fri, 27 Jun 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo5YQsrz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB012980C9
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018825; cv=none; b=rxVuwATKK415Tef0WdjqfCVwFTVuCY97MJMXewTwZItUqlrnlQzxazHIgYvcGP5skQyyrlOFNK7zTTT4cyjAS9G+AMJmsEHVW6gnA4xbz4qDauXsxoXmMGheVturg17WCUM2t/Mi6QeantfG8aYlOv8DnMNgjA7svQuFsjntjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018825; c=relaxed/simple;
	bh=7NB2c9L0qvWhYiAM/vLj+1P69kIZnskwCCA5fTGA+dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PisEezENk6eCZvdiqW20XZXdX4XbrhUp5zXFAShBpMq2MuzR6crIZ3RAnTHg7A6aGEaYXJTesh41/X8GZwhPwXwEHtWdYCwyotbNKpPDx7R+h+smPsdrF1/o8ZeDlN41PHGNCiHnuwwQ5H+n8RI+iGBWL0Uv4HZAH9OGKiNORII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mo5YQsrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751018823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hG2iLGkL8iW1IqMwUvVwKy7lWf2SLkXd/36jQWt3jBU=;
	b=Mo5YQsrzpplEgtMwJr8WPAFYNLYHJUaE7+jiSQH3eezyXN2R9BV/0+thNWhYGjnR3Pi4M3
	U5RdCq5hNhGtU9lIZsazTICgpCJBGJWSaC+7FvTcDeSVP4UEDGYn/3GbxcVL0bzd+e8UBQ
	UGWOzytzZxfRbNTlFg6I9fUkrJH6yaY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-fPejem5MM7qGG_0N3d5T5A-1; Fri,
 27 Jun 2025 06:07:01 -0400
X-MC-Unique: fPejem5MM7qGG_0N3d5T5A-1
X-Mimecast-MFC-AGG-ID: fPejem5MM7qGG_0N3d5T5A_1751018820
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458B318001D1
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 10:07:00 +0000 (UTC)
Received: from dobby.kenosha.org.com (unknown [10.22.64.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A53E2180045B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 10:06:59 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Fix build with glibc-2.42
Date: Fri, 27 Jun 2025 05:06:58 -0500
Message-ID: <20250627100658.102342-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Yaakov Selkowitz <yselkowi@redhat.com>

exportfs.c: In function ‘release_lockfile’:
exportfs.c:83:17: error: ignoring return value of ‘lockf’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
   83 |                 lockf(_lockfd, F_ULOCK, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
exportfs.c: In function ‘grab_lockfile’:
exportfs.c:77:17: error: ignoring return value of ‘lockf’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
   77 |                 lockf(_lockfd, F_LOCK, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~

lockf is now marked with attribute warn_unused_result:

https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=f3c82fc1b41261f582f5f9fa12f74af9bcbc88f9

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/exportfs/exportfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index b03a047b..748c38e3 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -74,13 +74,19 @@ grab_lockfile(void)
 {
 	_lockfd = open(lockfile, O_CREAT|O_RDWR, 0666);
 	if (_lockfd != -1)
-		lockf(_lockfd, F_LOCK, 0);
+		if (lockf(_lockfd, F_LOCK, 0) != 0) {
+			xlog_warn("%s: lockf() failed: errno %d (%s)",
+			__func__, errno, strerror(errno));
+		}
 }
 static void
 release_lockfile(void)
 {
 	if (_lockfd != -1) {
-		lockf(_lockfd, F_ULOCK, 0);
+		if (lockf(_lockfd, F_ULOCK, 0) != 0) {
+			xlog_warn("%s: lockf() failed: errno %d (%s)",
+			__func__, errno, strerror(errno));
+		}
 		close(_lockfd);
 		_lockfd = -1;
 	}
-- 
2.50.0


