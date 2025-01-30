Return-Path: <linux-nfs+bounces-9789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B7A22F58
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD007A2804
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681A1E7C25;
	Thu, 30 Jan 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOtZDC2d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DD1E7C08
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246849; cv=none; b=hKB8cK/speYChAPxCTymCkziz8FjxpViVQ8YbamKiaDFFbQpjCAMSb/9NnnOwNDgcWoHbBC0m7+z1OMO1KbMQp8rfgJK2NOoXNBWnZcXhthdRGD5PVx9/bsbytoBl7Qtg8MT6Z+Axu72+7YhANUg9bDviCd+VpC/j5hQvkA/WOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246849; c=relaxed/simple;
	bh=o9GH7584folDNBRVMHVFD6f/c2IOQFst1XYgylgPaI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIzfrjdBAxQbEGzfdNjMlVvMSBwtBNPlu8lxs16PzUvTQNEvfNP0b9nmqBslX2Ny2AJOoqNrkbo7lJulfGOM3OpTyeHIFs/aRzghERu3Nv9IaC6qHQTir6ghgG+TvXumIIxQWFHT/xpzebFSMNxaKgXnX+fKMqqn1AaUj280+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOtZDC2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2U7G4Rk5TXX4t5vQvkhWSV5ubPXuuVRQwuOW6RiiruI=;
	b=UOtZDC2duhpSoWMwbWFQMcQwQvs+jd57pDZTZS29a3z/sFnYf6NJm5/0ZFvXS6gu86wuIn
	xfS7PYzGdMDCHqX0Fn7Kg6735kBW7z5tnIwl8lyFZmeL6778qvPcyxGb2qgYHji0nUDg2G
	Oikb3WhSwfCyJcrAsuPKJLTbkdr6lEQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-IuEVS5C6PZuinBBI53nlvA-1; Thu, 30 Jan 2025 09:20:44 -0500
X-MC-Unique: IuEVS5C6PZuinBBI53nlvA-1
X-Mimecast-MFC-AGG-ID: IuEVS5C6PZuinBBI53nlvA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6f943f59dso141533985a.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246844; x=1738851644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U7G4Rk5TXX4t5vQvkhWSV5ubPXuuVRQwuOW6RiiruI=;
        b=xIzUABaNg4UX9ZmBMHGies+HC7DFG1hq7JQuU842lE5rGuaBGT0FFBCEioBM4lZB/K
         oKE9ktHvK+YfFTxs6jN2JQ7tV/K7/Hbover5iqCD3Jf47rgaVRJvlAdBFR+K7gpTdCnJ
         j3JypRsREA79i3UOBJzXOSus5KFNoLaWHpB6pJAY41OW8hizp1Sdbkuo7akqll/1cr1m
         jVbEOAKO2vodZkA3qNuRM/pYq6iMiMrvy9LC2lPldUjznLMYr9T7CvkIBMVzRhrjx+Gl
         8PIcl621KHHVdfGsKHvTu0zHLuUL8Pf0j9qk3We3SV/M3KSYm2OEDt50Wu8XNUmdy2Cz
         3mPA==
X-Gm-Message-State: AOJu0YyGqSLNXBuO4H+tvK9ypclqrhBUDlmk2RcjU1KqgUwn1Idy/Mtu
	cgawHYSAYMwHpVbhYIKSJhAaxyCP5ckmHi0rs2GMkn45xFn62gWbpFt5nFkJHECcql+He1DW3O8
	JVOE2/1/oKB4rbIBjR1DFI4PLjGWT9Iv093wVPHSvzAXAeOL68aMXRszRNcpLanJGRU3H1roqya
	7gsmpw3cZCUkTzJ/vtXp1ndGcJH9ZfzPoHCMw7g6wsjQ==
X-Gm-Gg: ASbGnctvECWwSWJ3IhlxSY4CiWcs798aivR7oIUeLbp+93yBXWiRSjyHuTzDuk6zApo
	Mlx5VALtmtHQ7fI5fVMPkzTbpxUUx47MtggC1T3RCYvkSojvkY31aIkwgbTQdCQnvJsKjW9iRWu
	lS8nhqFEl9jqZA2opHlX0qFZI3GyA8YTFO9ZiQy+4iaHlVdlMO2x7ec+Zt2NT8/xhrCCtN+bU+c
	9ReSGCKSqoS0x4X3H8Kfe0OhbicLnx6f4Y+/uR2tXPV66EzmeHiBG3Dv+4yUJyA9HiRA+F2hNIq
	HTogkn9vI0HAxwTJrLwLDNygylwLbqynjCNEANBQ1+JkQ2FOCTd49R9Sb9b7Jsij
X-Received: by 2002:a05:620a:178b:b0:7b6:c462:6b82 with SMTP id af79cd13be357-7bffcd9d397mr1360267185a.54.1738246843768;
        Thu, 30 Jan 2025 06:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+C1a6xhyDBXkN0iMx/EfVtr7w6zH+pxxpdq7ExNWvK+h8jDRLGGZfn+sYjPZz/UD9C6vSrg==
X-Received: by 2002:a05:620a:178b:b0:7b6:c462:6b82 with SMTP id af79cd13be357-7bffcd9d397mr1360262185a.54.1738246843257;
        Thu, 30 Jan 2025 06:20:43 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:42 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 3/8] nfsiostat: mirror how mountstats iostat prints the stats
Date: Thu, 30 Jan 2025 08:20:02 -0600
Message-ID: <20250130142008.3600334-4-sorenson@redhat.com>
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

Currently, nfsiostat assumes that if old mountstats are provided,
then 'old' will contain all the new devices as well, and will
therefore crash if outputting multiple iterations and a new nfs
mount occurs between iterations.

'mountstats iostat' covers the new-nfs-mount situation by checking
that the old mountstats contains the device before referencing it.
It also verifies both old and new mountpoints are the same type.
Therefore, make the nfsiostat output function like mountstats.

However nfsiostat also has to allow sorting, so we can't just
output the full/diff stats as we go.  Instead, put the stats to
output into a list to display, sort the list if necessary, then
output the stats at the end.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 42 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 95176a4b..bf5eead9 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -476,41 +476,27 @@ def parse_stats_file(filename):
     return ms_dict
 
 def print_iostat_summary(old, new, devices, time, options):
-    stats = {}
-    diff_stats = {}
-    devicelist = []
-    if old:
-        # Trim device list to only include intersection of old and new data,
-        # this addresses umounts due to autofs mountpoints
-        for device in devices:
-            if "fstype autofs" not in str(old[device]):
-                devicelist.append(device)
-    else:
-        devicelist = devices
+    display_stats = {}
 
-    for device in devicelist:
-        stats[device] = DeviceData()
-        stats[device].parse_stats(new[device])
-        if old:
+    for device in devices:
+        stats = DeviceData()
+        stats.parse_stats(new[device])
+        if old and device in old:
             old_stats = DeviceData()
             old_stats.parse_stats(old[device])
-            diff_stats[device] = stats[device].compare_iostats(old_stats)
+            if stats.fstype() == old_stats.fstype():
+                display_stats[device] = stats.compare_iostats(old_stats)
+            else: # device is in old, but fstypes are different
+                display_stats[device] = stats
+        else: # device is only in new
+            display_stats[device] = stats
 
     if options.sort:
-        if old:
-            # We now have compared data and can print a comparison
-            # ordered by mountpoint ops per second
-            devicelist.sort(key=lambda x: diff_stats[x].ops(time), reverse=True)
-        else:
-            # First iteration, just sort by newly parsed ops/s
-            devicelist.sort(key=lambda x: stats[x].ops(time), reverse=True)
+        devices.sort(key=lambda x: display_stats[x].ops(time), reverse=True)
 
     count = 1
-    for device in devicelist:
-        if old:
-            diff_stats[device].display_iostats(time, options.which)
-        else:
-            stats[device].display_iostats(time, options.which)
+    for device in devices:
+        display_stats[device].display_iostats(time, options.which)
 
         count += 1
         if (count > options.list):
-- 
2.48.1


