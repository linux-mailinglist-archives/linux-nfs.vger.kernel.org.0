Return-Path: <linux-nfs+bounces-9794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A432A22F5C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28D41881DC1
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7011E3772;
	Thu, 30 Jan 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeRnpGLw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F81E3DC8
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246854; cv=none; b=B+vf/QtUuTYJXdh4x+eZ7IqxOuA/YBU5S6CrCSRpqf5aGyygdroI7RECLNAb4KLXO+bDcbZeWQuwz0IjGDiZMzFklCmYe4kIlyKr19wyMrDrFYRfTRE7WFr2/jBNwoTK9NxDzozPjfS9U0Kfjr1KRILlMT37rc52qqupd0PYSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246854; c=relaxed/simple;
	bh=OI5/0ERKTgkWaq8YkOkWCdfESyjZ2p1uCTlwVwfuBC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9IyqqP7YvzroSmfz0AwrgB3vP2YSaurVVMS9oZ2gQe3hpsYajijciFYT98baJyeMb/2bJ3isyH2jQHn2EcQoTFTKh6W8VwslO2gNZF6X+5krhMM7Jz6UFlJG+6G+MpHhUH2NdrSJ8J0ekM96GAM+7vuLe80lv2vwvvVxjEm40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeRnpGLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhaqrh4lZDuWplsQ0AhOqQlJ1/OA1lhGzx0eRmkWYp0=;
	b=BeRnpGLwgwCqevUecRw7qzcJYrVc1k/P/JHD095uzFjwDDcbYyg8ZICk06HAkSK1O7ATYp
	Q2cLdd5jd49GvaolUNaH2NJjjdNQMdHtwqyw2FXqtxIJJZTyXk6JDtGkC9CFjVT7BDad0k
	vpV3fGUQUiYeN66BWvOJ0ENoaGlv8ew=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-AJQx7af3N56-lBx2OW4hFA-1; Thu, 30 Jan 2025 09:20:50 -0500
X-MC-Unique: AJQx7af3N56-lBx2OW4hFA-1
X-Mimecast-MFC-AGG-ID: AJQx7af3N56-lBx2OW4hFA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6ecd22efbso133066985a.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246850; x=1738851650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhaqrh4lZDuWplsQ0AhOqQlJ1/OA1lhGzx0eRmkWYp0=;
        b=p1sHc0m0yWJV6lbMeXgDEdtDetV0lFJLIC+1gYTlA//mLhAw4KEAZC9DGJrnvWjzl9
         gFZWTHN2ENxO+SD1w+hBdp+wWovW0uVMauNvhiMU81cNcpSJUI4NmX/lBh0oCSCqguqG
         GMwuKcjrtpn2w1qiiVp49KYzRBf6lE6cjx4Cuzgow0hcJ3WKVaQc3hK5ZrWQIcQdXX25
         u6epk6guAQ/urgCT4wmFnUet+NlpmoH5kOMM7suG7QtUReoijNaB7kf5pt1FG/I/hB4L
         3S0df6i6bYb5GWgnEIPTlGQLQxkTH1D2GetJsuYcGXipYibJgElUnk83OQ7iYhvQX27D
         l6UQ==
X-Gm-Message-State: AOJu0YxDGrB5C/sKNLG67RAh86RIqAsBwjxOkEtZ23j1iE2bjZJPPLY7
	r5PlUuy2fmmOQQE8uXism8PcqkX1ojC2aKPr0RmoTJ3Dz7DGPaOes3s2IL7pD4F0J97GZqUsuY8
	RITrp5KhXq9xrz5qxSMNlBmJ1MX66oJQeGPC141naFsTCwlKAvQOmZbD378JUykFWxl6MAjP6+J
	jqlZ9o2+V7U+D8W+HhwxzuDE++z4ICA/EzK+MVL3Li4w==
X-Gm-Gg: ASbGnctYZD1eNa3bSfkymDDpWvGR4p+6C/XBKZdPcQSVLI8y0E3sFdkqVeqo/YsDv8w
	9JRnkcyIdKzdGWUa1tkPksYeq1HCyC/mVXRhsundLV2rMsfmxiJzgUaXikygk/z4fQn9HHAPyYG
	U+FwT5okVnZD/2J8RwegZPxR/Z0etVR7gqw1JAA7EO3FlsGy5k3owIyd7K8uxnRCrMQyb6WVTI1
	1JKCTF0xlkJ3lnbUao9dbbtJTtuAn9jtzuxmgDd4wnkXuemjiswWbZGW1JeqHdl4P0YolXczfAB
	opCpxbbCbhYjfOC+/jNHQdKTZHZjS33/Vb+OepehAGhOeOONOUOl1s1tQNW8RFgF
X-Received: by 2002:a05:620a:2b83:b0:7b6:dd89:d86f with SMTP id af79cd13be357-7c0097b8e76mr467289685a.24.1738246849984;
        Thu, 30 Jan 2025 06:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9CquF8IlRKMCtbW59ECjrgO03yQNxQvVrHuU25eJ5trOO2Mix/wsNAh1GcBmwM0hO0bVCKQ==
X-Received: by 2002:a05:620a:2b83:b0:7b6:dd89:d86f with SMTP id af79cd13be357-7c0097b8e76mr467286285a.24.1738246849625;
        Thu, 30 Jan 2025 06:20:49 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:48 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 8/8] mountstats/nfsiostat: merge and rework the infinite and counted loops
Date: Thu, 30 Jan 2025 08:20:07 -0600
Message-ID: <20250130142008.3600334-9-sorenson@redhat.com>
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

We always want to print at least once, so move the first print
before the interval/count tests.

The infinite loop and counted loop are nearly identical, so
we merge them, and break out of the loop if necessary.

By decrementing the count and checking at the beginning of the
loop, we also fix a bug where we sleep and parse the mountstats
file one extra time after count iterations.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 40 ++++++++++++++--------------------
 tools/nfs-iostat/nfs-iostat.py | 40 ++++++++++++++--------------------
 2 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index fbd57f51..d488f9e1 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -1007,37 +1007,29 @@ def iostat_command(args):
     else:
         old_mountstats = None
 
+    sample_time = 0
+
     # make certain devices contains only NFS mount points
     devices = list_nfs_mounts(origdevices, mountstats)
-
-    sample_time = 0
+    print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
 
     if args.interval is None:
-        print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
         return
 
-    if args.count is not None:
-        count = args.count
-        while count != 0:
-            print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
-            old_mountstats = mountstats
-            time.sleep(args.interval)
-            sample_time = args.interval
-            mountstats = parse_stats_file(args.infile)
-            # nfs mountpoints may appear or disappear, so we need to
-            # recheck the devices list each time we parse mountstats
-            devices = list_nfs_mounts(origdevices, mountstats)
+    count = args.count
+    while True:
+        if count is not None:
             count -= 1
-    else: 
-        while True:
-            print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
-            old_mountstats = mountstats
-            time.sleep(args.interval)
-            sample_time = args.interval
-            mountstats = parse_stats_file(args.infile)
-            # nfs mountpoints may appear or disappear, so we need to
-            # recheck the devices list each time we parse mountstats
-            devices = list_nfs_mounts(origdevices, mountstats)
+            if count == 0:
+                break
+        time.sleep(args.interval)
+        old_mountstats = mountstats
+        sample_time = args.interval
+        mountstats = parse_stats_file(args.infile)
+        # nfs mountpoints may appear or disappear, so we need to
+        # recheck the devices list each time we parse mountstats
+        devices = list_nfs_mounts(origdevices, mountstats)
+        print_iostat_summary(old_mountstats, mountstats, devices, sample_time)
 
     args.infile.close()
     if args.since:
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index f69ffb0e..e46b1a83 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -614,37 +614,29 @@ client are listed.
                 print('Illegal <count> value %s' % arg)
                 return
 
-    # make certain devices contains only NFS mount points
-    devices = list_nfs_mounts(origdevices, mountstats)
-
     old_mountstats = None
     sample_time = 0.0
 
+    # make certain devices contains only NFS mount points
+    devices = list_nfs_mounts(origdevices, mountstats)
+    print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
+
     if not interval_seen:
-        print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
         return
 
-    if count_seen:
-        while count != 0:
-            print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
-            old_mountstats = mountstats
-            time.sleep(interval)
-            sample_time = interval
-            mountstats = parse_stats_file('/proc/self/mountstats')
-            # nfs mountpoints may appear or disappear, so we need to
-            # recheck the devices list each time we parse mountstats
-            devices = list_nfs_mounts(origdevices,mountstats)
+    while True:
+        if count_seen:
             count -= 1
-    else: 
-        while True:
-            print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
-            old_mountstats = mountstats
-            time.sleep(interval)
-            sample_time = interval
-            mountstats = parse_stats_file('/proc/self/mountstats')
-            # nfs mountpoints may appear or disappear, so we need to
-            # recheck the devices list each time we parse mountstats
-            devices = list_nfs_mounts(origdevices,mountstats)
+            if count == 0:
+                break
+        time.sleep(interval)
+        old_mountstats = mountstats
+        sample_time = interval
+        mountstats = parse_stats_file('/proc/self/mountstats')
+        # nfs mountpoints may appear or disappear, so we need to
+        # recheck the devices list each time we parse mountstats
+        devices = list_nfs_mounts(origdevices, mountstats)
+        print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
 
 #
 # Main
-- 
2.48.1


