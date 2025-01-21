Return-Path: <linux-nfs+bounces-9438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBBA18572
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE38164974
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73315278E;
	Tue, 21 Jan 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSwTRx2u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A0E57D
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486204; cv=none; b=uraq4n1GLFiufFFekvlOQO2ffJ2aoED728ZUZUHxIK7PNNafpOzKUzLyq8YCUvOxn3MlsW79hfdV1vM848kRSmvYm9HsWiyMbYN5RSYZK5zG4d8wUgMfDZK1LOaw/4Z6FRBIgf8+QYDwakJAV5BruSpGHj1B1soUEqzdc8x1fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486204; c=relaxed/simple;
	bh=ozqcQllG9U4fhQi3455Krh4Y95N03rENtRRF2gh5Jp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paJ6nYyJk4yG0MWPucCMhKiKEQM1xmk7uvBYlCU53QaS7EeXeb97H0coIfOySi/zVDKWRDBp6XNvVgcs+wbzAoCcTNppR4DFmg1faAJISeN/KTGzoeHTfDc3BJ9OSXDCsq12okmoSJeJBjY62r+WddJOuMU3GR8TTPX3LeHXSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSwTRx2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737486201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bzWzoeaJFqOk30BV/H/Csbrm39iH2w0zc46mRdu2aDg=;
	b=XSwTRx2uTb0WEfKAkBtsXkmIqpBAp+mZWGBJ1hRDUG0509WZ0X71gMVmKMaP1GPziB/Nh8
	JToat9qJ4ekcL7WMjME9aOqzJDgq+NtBRBxVUl64W9x/r7Z/sy4OebAtJGUz3H8XjlPEgD
	2isCBsjPLD0cmNEuXAMSrtiZAP05PuQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-K5_nb3zbMkOYATMIGoHrgw-1; Tue,
 21 Jan 2025 14:03:20 -0500
X-MC-Unique: K5_nb3zbMkOYATMIGoHrgw-1
X-Mimecast-MFC-AGG-ID: K5_nb3zbMkOYATMIGoHrgw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A8E71955DA0
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 19:03:19 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (unknown [10.22.58.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9446C3003E7F;
	Tue, 21 Jan 2025 19:03:18 +0000 (UTC)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com
Subject: [nfs-utils PATCH] nfsiostat: skip argv[0] when parsing command-line
Date: Tue, 21 Jan 2025 13:03:15 -0600
Message-ID: <20250121190315.1498852-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Just skip argv[0] entirely while looping through the command-line
arguments.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 85294fb9..31587370 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -592,11 +592,7 @@ client are listed.
     parser.add_option_group(displaygroup)
 
     (options, args) = parser.parse_args(sys.argv)
-    for arg in args:
-
-        if arg == sys.argv[0]:
-            continue
-
+    for arg in args[1:]:
         if arg in mountstats:
             origdevices += [arg]
         elif not interval_seen:
-- 
2.47.1


