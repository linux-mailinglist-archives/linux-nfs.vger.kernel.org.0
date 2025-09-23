Return-Path: <linux-nfs+bounces-14629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56EB97AC0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E524189EFFF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD630F930;
	Tue, 23 Sep 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxEPGVGa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3230DEC7
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664805; cv=none; b=jEZoJ2UAHk5nb883nKWSomC8hUQf8EaEio+aodzsEIyfTZcfJybZZOj50PHyV1pPsNADFr0stszVVaW+nnjCpybb89pIzXToXpLD2foPm3n8BRwOc5VH90eFr6C7Yrn3BMCA+d1GYlkjFgYxyZ4Jzhtm+mwFSaT93q5BuVlJb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664805; c=relaxed/simple;
	bh=etBiuTuKDh2hYNAbIkfM+ZSc/FwaOSLeNj1whikE0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRoUptGjwmBOLFyimS2tcJgn5BVJCRFY/ePLdBlbwFsbFX2H4PEOau31CsKJB7EblhXciIutZuLNWhrux+ztJUmq7BXKheqtOsjPMeAdtDgyvVc003/a0Rv3DPiTAKgvQON4bW5x2XxTH6Jwi2oZ4bR/5BIAjx/OKhznZhUw288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxEPGVGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq1Us6+kPsAxbhtRdZ/yi/9v8AIUj0rSbMwTHsfosvI=;
	b=XxEPGVGaJveiIp0X3tinB5CHdiRM3PVHPKR/Q90RvtV7LTWHv+2QtRMM2l5xKNon8bmdTj
	xfP3NJrFRts1+r78g7g2AQMIt95DE54Q10GZQ7tQZD7hBuJW5uaCIcuvO+xCLGLOg0B9Q7
	DR9wnqZ1DVXi6IGIq7SIWhDwmqqmCGI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-li3IzEjNMWypK_R8W0IzgA-1; Tue,
 23 Sep 2025 17:59:56 -0400
X-MC-Unique: li3IzEjNMWypK_R8W0IzgA-1
X-Mimecast-MFC-AGG-ID: li3IzEjNMWypK_R8W0IzgA_1758664795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDF941956059;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93B6F30001B5;
	Tue, 23 Sep 2025 21:59:55 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id E4CE146F6F5;
	Tue, 23 Sep 2025 17:59:53 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] nfs4.1: make serverhelper() deal with "bytes" objects
Date: Tue, 23 Sep 2025 17:59:50 -0400
Message-ID: <20250923215953.165858-2-smayhew@redhat.com>
In-Reply-To: <20250923215953.165858-1-smayhew@redhat.com>
References: <20250923215953.165858-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Most of the strings in pynfs are not str but rather "bytes" objects.
Make sure that serverhelper() works with these (just like the nfs4.0
version).

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/environment.py | 8 ++++----
 nfs4.1/server41tests/st_reboot.py   | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 48284e0..3c77153 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -233,14 +233,14 @@ class Environment(testmod.Environment):
         rebooting the server)"""
         if self.opts.serverhelper is None:
             print("Manual operation required on server:")
-            print(args + " and hit ENTER when done")
+            print(args.decode("utf8") + " and hit ENTER when done")
             sys.stdin.readline()
             print("Continuing with test")
         else:
-            cmd = self.opts.serverhelper
+            cmd = os.fsencode(self.opts.serverhelper)
             if self.opts.serverhelperarg:
-                cmd += ' ' + self.opts.serverhelperarg
-            cmd += ' ' + args
+                cmd += b' ' + os.fsencode(self.opts.serverhelperarg)
+            cmd += b' ' + args
             os.system(cmd);
 
     def new_verifier(self):
diff --git a/nfs4.1/server41tests/st_reboot.py b/nfs4.1/server41tests/st_reboot.py
index f8c51ea..722f05e 100644
--- a/nfs4.1/server41tests/st_reboot.py
+++ b/nfs4.1/server41tests/st_reboot.py
@@ -18,7 +18,7 @@ def _getleasetime(sess):
     return res.resarray[-1].obj_attributes[FATTR4_LEASE_TIME]
 
 def _waitForReboot(env):
-    env.serverhelper("reboot")
+    env.serverhelper(b"reboot")
     # Wait until the server is back up.
     # The following blocks until it gets a response,
     # which happens when the server comes back up.
-- 
2.51.0


