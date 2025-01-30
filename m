Return-Path: <linux-nfs+bounces-9792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C9A22F57
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B7E18825D3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462F1E493C;
	Thu, 30 Jan 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0bafogT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551041E8823
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246852; cv=none; b=L9byic021P1mkJUEVHpYuJkgRrJ7GlNS6Ur30l9ilb20u0io+JYP1FSTiYQO2Ev1vKdfd2I383beBJ3u+Hv9sMFrrZBFMd6+Mjb1IQ3CBPnJAeVLLin8WBQf9+/KZIwZ0iEkGbtQGhcCMqDpQ6jS+atyqL6VOqOfJ2AV/57BJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246852; c=relaxed/simple;
	bh=mmrba3hwT6r0qAYSNNaLQjcywuXvabGJqIUocgBUIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGUYERTPTKDJ9vJT9xoezpj5EEJZcH0BfWngjCCtYLLmtqoh6QlAu6oFSL/XGRpzHFimhZBwF3c9kW0tWs75KCpoXCAkE0BapknuExtZw02EYy4nCSjHe82J1ewLFBJBD8jZabpiKRCN7GmBwk1y42KYesXM+XHFfj5M0tBArTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0bafogT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwnF5vIKkyH8jTZi+6GZTx77ML4e1uTz/hF8YpNSqX0=;
	b=P0bafogToIPkAV4ZytVOf2DQGvCvlfiUmxTbCANeorH6iAPd5YO/D4XsjemTuHwZHe12kT
	ZFqLmGXLM60Vwg5UgBoIJL+ImnF6UoazBXrJGsc9ADTbmfnc3Nd1sWqWUMqKR4H/7fWgYp
	GalTzDbF82x2JIdXB+QDA0tzokMZHkQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-QgrE0bWSObOCGhyCpin0-Q-1; Thu, 30 Jan 2025 09:20:48 -0500
X-MC-Unique: QgrE0bWSObOCGhyCpin0-Q-1
X-Mimecast-MFC-AGG-ID: QgrE0bWSObOCGhyCpin0-Q
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6eabd51cfso135364285a.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246847; x=1738851647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwnF5vIKkyH8jTZi+6GZTx77ML4e1uTz/hF8YpNSqX0=;
        b=fQubtadtit5PgmY+fLoued3ieoNyMJDGtVEu2jpVQKAsz9cyzOGYLzbF/CR4fB3pYp
         AWW8+22P3X/QqnnfEVhxY5dX2AjIuCHLP6iYgJr1CbwqKIIr59msNLKvuXer+HmbqF5N
         Dceq3uEnhShF7iMtM6Ykn5day95PGO4FvUMPiXyFL/CQZzf9pZfX3jZGhdh6jYnQMaUI
         hETnnCGczidM7tN++RxM8aJ7IWfelalluIpkOmP+1Lmy/SkgJB2kFlsu/Hl0zFivVxeU
         cJV2d2Y8vIeoBhlQKmYrHLDsUgr75eI0bwyoeeVh3+xrtQ2WMKbMNV2P47BETDkkxj3L
         iKUQ==
X-Gm-Message-State: AOJu0YyldfXMLYyheOPRspkdAM7H87DQpj32jfm+Kp8viS4KsInMPjn3
	Hrh2WpKa8m6cC2py4Awy3a/4Y+ZikeXJmm2BlQvbzCbBeofbGeo6tEQP5OlroBWajWADrKIjmh+
	CI/o3QqYfGlZNvguoQxD3KSVfyG3l0CM3GDqlt2m6SU3lqC9bDD/UR1vmE5m6y0zEii9m9U/SZp
	OMtf42p01CEdG6eImYoyQI86o7N6kwVEHeRqAJekLgzA==
X-Gm-Gg: ASbGncs5IbRj9GSDRo2/IvK1E7AiWdUrB7+iteKxIP38jPFWD7Tkv7GRwBn8wHpIyG9
	fAwNCby4SegH3v7nuQI7XSWAIBcTYT6maTJP6VscjzPlONZ0JEf6X49R/LhmDzHKv6l8yiwyNNo
	A+uYIwta/H0vUL/yDvRU9cnZ93jv5ON6CQ1Eo9jfAoq6U78z19ooQ3+4v49eNOpsJbFW1uzlTrF
	tVULr5IEPJ1TvLakljGaYqCiE8sFC0z3FaaTfbAYTcpij8dOWqzwrHZxWUFvP/p9O/ZqWIqGHZw
	HmfGcvaqj+McBzDGcVkJGNkfaPsXkEOJDc28K0oYdlVikDF83rNvWYDcvTBJmQPB
X-Received: by 2002:a05:620a:258e:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7bffcd9d19dmr974961385a.47.1738246846977;
        Thu, 30 Jan 2025 06:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMNaEwqTUSAf2/FnKQ+P83n+70fkw/N89Uz98tMzMq+jLTtxLiBcA1vMS4fZURlP1/6r+CzA==
X-Received: by 2002:a05:620a:258e:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7bffcd9d19dmr974956485a.47.1738246846465;
        Thu, 30 Jan 2025 06:20:46 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:46 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 6/8] mountstats: filter for nfs mounts in a function, each iostat iteration
Date: Thu, 30 Jan 2025 08:20:05 -0600
Message-ID: <20250130142008.3600334-7-sorenson@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130142008.3600334-1-sorenson@redhat.com>
References: <20250130142008.3600334-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, 'mountstats iostat' filters for nfs mounts when first
parsing mountstats, and never re-verifies the list when printing
multiple iterations.  As a result, new nfs mountpoints are never
detected, and unmounts result in a crash.

nfsiostat covers both new mounts and unmounts by filtering the
list of devices in a function during each iteration.

Align the scripts by copying the nfsiostat filtering function,
and filter each iteration.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 53 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 59139ccc..e640642a 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -971,11 +971,32 @@ def print_iostat_summary(old, new, devices, time):
         else: # device is only in new
             stats.display_iostats(time)
 
+def list_nfs_mounts(givenlist, mountstats):
+    """return a list of NFS mounts given a list to validate or
+       return a full list if the given list is empty -
+       may return an empty list if none found
+    """
+    devicelist = []
+    if len(givenlist) > 0:
+        for device in givenlist:
+            if device in mountstats:
+                stats = DeviceData()
+                stats.parse_stats(mountstats[device])
+                if stats.is_nfs_mountpoint():
+                    devicelist += [device]
+    else:
+        for device, descr in mountstats.items():
+            stats = DeviceData()
+            stats.parse_stats(descr)
+            if stats.is_nfs_mountpoint():
+                devicelist += [device]
+    return devicelist
+
 def iostat_command(args):
     """iostat-like command for NFS mount points
     """
     mountstats = parse_stats_file(args.infile)
-    devices = [os.path.normpath(mp) for mp in args.mountpoints]
+    origdevices = [os.path.normpath(mp) for mp in args.mountpoints]
 
     if args.since:
         old_mountstats = parse_stats_file(args.since)
@@ -983,23 +1004,7 @@ def iostat_command(args):
         old_mountstats = None
 
     # make certain devices contains only NFS mount points
-    if len(devices) > 0:
-        check = []
-        for device in devices:
-            stats = DeviceData()
-            try:
-                stats.parse_stats(mountstats[device])
-                if stats.is_nfs_mountpoint():
-                    check += [device]
-            except KeyError:
-                continue
-        devices = check
-    else:
-        for device, descr in mountstats.items():
-            stats = DeviceData()
-            stats.parse_stats(descr)
-            if stats.is_nfs_mountpoint():
-                devices += [device]
+    devices = list_nfs_mounts(origdevices, mountstats)
     if len(devices) == 0:
         print('No NFS mount points were found')
         return 1
@@ -1018,6 +1023,12 @@ def iostat_command(args):
             time.sleep(args.interval)
             sample_time = args.interval
             mountstats = parse_stats_file(args.infile)
+            # nfs mountpoints may appear or disappear, so we need to
+            # recheck the devices list each time we parse mountstats
+            devices = list_nfs_mounts(origdevices, mountstats)
+            if len(devices) == 0:
+                print('No NFS mount points were found')
+                return
             count -= 1
     else: 
         while True:
@@ -1026,6 +1037,12 @@ def iostat_command(args):
             time.sleep(args.interval)
             sample_time = args.interval
             mountstats = parse_stats_file(args.infile)
+            # nfs mountpoints may appear or disappear, so we need to
+            # recheck the devices list each time we parse mountstats
+            devices = list_nfs_mounts(origdevices, mountstats)
+            if len(devices) == 0:
+                print('No NFS mount points were found')
+                return
 
     args.infile.close()
     if args.since:
-- 
2.48.1


