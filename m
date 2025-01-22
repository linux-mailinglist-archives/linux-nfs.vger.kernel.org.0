Return-Path: <linux-nfs+bounces-9449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE48A18AB1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43444188AC78
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7045BEC;
	Wed, 22 Jan 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVaQ5j+t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7810C186A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737516858; cv=none; b=OQgXRPzbmfcKAYpKLmWE5BASFmr5uanzybmlVLhwn/R+Fut1b0H+ddjMw61Rm+j/t0jIPX15oL48ufOtVl28L5r+SvdHIFSu4rYUDr4Fd6znBHRXSnTBdhy1JrYfV480ekZ8V0oLpcZq9mIJKGLhSkWNDBlyAtEdFbs3kxPVEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737516858; c=relaxed/simple;
	bh=LyD7v9uB01UDETVhX/Tvw5pFBfeXgZjEPWbamE2n4qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JANJSJMgRsSSoHttF45yrYQcew7PZ5HBNWNNtbvGQ15T5dzT9wIgA9vChjgOuFeT1kSE1J8nAJEtAhQ1t6Ky6PX44FPJbO6gCealanfqu+UE+qNMG7+xQmacz0AQXwCxiY05zmaEvrkZhO5Ls3kdOprxbAcpmdhkm8lQNm3fQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVaQ5j+t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737516855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hsdLkUvnpBRSTruPfwcBiey5EFvdk6msbgVtnw+UFFk=;
	b=KVaQ5j+tbeLnKvx9jnkFHRrwWcnIGh9s4B1pnjFqwaDa4mMET/tBwHqn3ig8b8yd6OdQiR
	8PGz8hOgZCHUO6QFI/Tl4yFIXYlstrtFszvrOTThlw8Muc2RE835kOpD8A9OBAqAZOAeUf
	4w2PkgDp7Pc2FJCO4wXviTpcWn90YL8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-yq5tAI1qMx-mb6pVEfF-kg-1; Tue,
 21 Jan 2025 22:34:13 -0500
X-MC-Unique: yq5tAI1qMx-mb6pVEfF-kg-1
X-Mimecast-MFC-AGG-ID: yq5tAI1qMx-mb6pVEfF-kg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FB2F19560B1
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:34:12 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (unknown [10.22.58.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E3BD19560A3;
	Wed, 22 Jan 2025 03:34:11 +0000 (UTC)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com
Subject: [nfs-utils PATCH] mountstats/nfsiostat: when parsing the mountstats file, only keep the nfs mounts
Date: Tue, 21 Jan 2025 21:34:08 -0600
Message-ID: <20250122033408.1586852-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Don't store the mountstats if the fstype is not nfs

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 18 +++++++++++++-----
 tools/nfs-iostat/nfs-iostat.py | 16 +++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 8e129c83..326b35c3 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -783,25 +783,33 @@ def parse_stats_file(f):
     """pop the contents of a mountstats file into a dictionary,
     keyed by mount point.  each value object is a list of the
     lines in the mountstats file corresponding to the mount
-    point named in the key.
+    point named in the key.  Only return nfs mounts.
     """
     ms_dict = dict()
     key = ''
+    fstype = ''
 
     f.seek(0)
     for line in f.readlines():
         words = line.split()
         if len(words) == 0:
+            fstype = ''
+            continue
+        if line.startswith("no device mounted"):
+            fstype = ''
             continue
         if words[0] == 'device':
+            if 'with fstype nfs' in line:
+                fstype = words[-2]
+            else:
+                fstype = words[-1]
+
             key = words[4]
             new = [ line.strip() ]
-        elif 'nfs' in words or 'nfs4' in words:
-            key = words[3]
-            new = [ line.strip() ]
         else:
             new += [ line.strip() ]
-        ms_dict[key] = new
+        if fstype in ('nfs', 'nfs4'):
+            ms_dict[key] = new
 
     return ms_dict
 
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 31587370..f97b23c0 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -445,27 +445,33 @@ def parse_stats_file(filename):
     """pop the contents of a mountstats file into a dictionary,
     keyed by mount point.  each value object is a list of the
     lines in the mountstats file corresponding to the mount
-    point named in the key.
+    point named in the key.  Only return nfs mounts.
     """
     ms_dict = dict()
     key = ''
+    fstype = ''
 
     f = open(filename)
     for line in f.readlines():
         words = line.split()
         if len(words) == 0:
+            fstype = ''
             continue
         if line.startswith("no device mounted"):
+            fstype = ''
             continue
         if words[0] == 'device':
+            if 'with fstype nfs' in line:
+                fstype = words[-2]
+            else:
+                fstype = words[-1]
+
             key = words[4]
             new = [ line.strip() ]
-        elif 'nfs' in words or 'nfs4' in words:
-            key = words[3]
-            new = [ line.strip() ]
         else:
             new += [ line.strip() ]
-        ms_dict[key] = new
+        if fstype in ('nfs', 'nfs4'):
+            ms_dict[key] = new
     f.close
 
     return ms_dict
-- 
2.47.1


