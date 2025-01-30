Return-Path: <linux-nfs+bounces-9793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82BA22F59
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17C118832B6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892DA1E8823;
	Thu, 30 Jan 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0MY/+lY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EB1E3772
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246853; cv=none; b=T9rnEg7QfdVTxuz7tw0p30GVIEoxgARLfm3NtNzAWRlKof4hX35kAKG6ByX0Ai6yC5b1ux9OP3xQvdquESp+nHKItXRcdYK+lT2RKwlcx5jtrUyQR09utPfYoe9bF2Aa91HvXM162UVcP2raOSDWQCZEL1GvUoeZ0GOYlLHNhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246853; c=relaxed/simple;
	bh=Q7vHG0tNoJCPhFpV123pYZbTZpxZ+BWa/9tq/lOTiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj5eqTAwV6UfLCc3Sb7oRKoj3vzUDKunZnM0+cBXbxwCNdLoQ37XHoE8MPRVZcx+n3q+EVG8N2CmEr3MrwK5lCvx+aOZf4rWxb1JuEl22Rya9UjQ7m27E6u2PbyG0scU/LW6VneVgIWUXYV5k13LlsdVQjw11Kqe3q8tbiP1dZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0MY/+lY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0C+dC3U+JUYgz5Cxn8LHNO3xmUdetsZk4Fsgzmrt9jM=;
	b=c0MY/+lYGa/CR2NKv/kC6EZZ8ywi9m+0z1E4/g7iFhOsK5dgnhKlbm4nQjjVH7yiwQZPlC
	AitUCrCtpjVKEXZD7bl/yxo9au1cBDFy0ICFLgbk2vdjrDOYT6ZjhIPwOWyI6AvBUdU+XB
	/XHYb6bg4pgx1ch4wNZEsQNziMo69e0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-yG7pT4gpOfGMTM6lfVGcDg-1; Thu, 30 Jan 2025 09:20:49 -0500
X-MC-Unique: yG7pT4gpOfGMTM6lfVGcDg-1
X-Mimecast-MFC-AGG-ID: yG7pT4gpOfGMTM6lfVGcDg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6ef813ed1so132100385a.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246849; x=1738851649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C+dC3U+JUYgz5Cxn8LHNO3xmUdetsZk4Fsgzmrt9jM=;
        b=YmnImSckGo/KWJnZQiW+CnY5T1NKlg5cLIycPSQHDH1eaYx1GImcAy9Uga6h7ws030
         HpqCrb2RTP35k7lV/5vd98y5LNZb9iOGQu8X5MFrn9EM0j+t4WGPYFaXaI9aNTlqMyy3
         SxsiwaY27Jpez4hQ5Jjlgts1ZgMmycE1QdRTD6rARz2AMqGTK5OSxHXmGFTdmLHu8Dty
         +y6E6fueAbLzSsyWD6UxRNwlV4KNV5OJGJYau0fj4PYvk9NHsLuqAyE1yRm+/Xup6bxS
         JGNBhmy9hRI9Cuj4+p0PUJGm1oA6oIrxUK9ZqsUfs+Redv7ifrFdmnsjoe1DeC+fCZeF
         +5OA==
X-Gm-Message-State: AOJu0YzQ+e3P3DJQ2HodZw0uRFqOvOcAPhyLkRP8KIc0ALP8VKbn/0gc
	rBRqF+HUsgn+ni3iYUqANoZpCf2gD110NsmX6KxaBupBEpqbRtyQrBA78yG270LwYfSUTbEhUCg
	1Ad5zeUppQpjIM5BeDfsotEVAMyoQ/q6Kdn4sFkVhFroXo5IbfTATtgOV34dPnqgRG2he4IIdkk
	J91xVeO4wEHJIkQU54u8MuMnp7+2hSwWC2QNz15+9jbA==
X-Gm-Gg: ASbGncs18XNymDGqW/NIg/Ik817ls5OnAsr7ijGJ7CsmWstJorBftCGDg8TsXxVufMP
	pPVucHTf7bft5csJJfvJlU+0/RYoWnK2pBnuwocT8siArR9w0IBEDRnM37QyfpWLf8ZQPuCSTsH
	q8mTPP/oPaXaGiJYyWL++LqLgxoQZaqiPJVFNM6JrvazRJTnEa49tVKQtLP85tc3ehjsnT9BwpW
	tHXiYnN8iGJfiWMCYVC9LBoFb/xtU48NFzZ/OBl8MFqw8gkWU6XMXaBhEtZvyMuXz+JtM6WuPQ4
	LHMcTJ7PXmQXpz3/vFLqx3b37AQ00EWv5D8ErNSvgxA+rkE9L5ev3W6UdDhjjFKs
X-Received: by 2002:a05:620a:1d0a:b0:7b1:48ff:6b56 with SMTP id af79cd13be357-7bffcd957c2mr1113109485a.43.1738246848690;
        Thu, 30 Jan 2025 06:20:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8LvuP73BrEcVKJ4waEcA5dNjnfj9FBKi9/IFFs6FMIoOFdimCzdbDlpye2gzx/mnfEgwcVg==
X-Received: by 2002:a05:620a:1d0a:b0:7b1:48ff:6b56 with SMTP id af79cd13be357-7bffcd957c2mr1113105385a.43.1738246848318;
        Thu, 30 Jan 2025 06:20:48 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:47 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 7/8] mountstats/nfsiostat: Move the checks for empty mountpoint list into the print function
Date: Thu, 30 Jan 2025 08:20:06 -0600
Message-ID: <20250130142008.3600334-8-sorenson@redhat.com>
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

The test for empty device list and 'No NFS mount points found' message
terminate the program immediately if no nfs mounts are present during
a particular iteration.  However, if multiple iterations are specified,
it makes more sense to simply output the message and sleep for the
next iteration, since there may be nfs mounts next time through.

If we move the test and message into the print function, we still
get the message when appropriate, don't terminate on an empty list,
and also eliminate two extra copies of the same test and message.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 13 ++++---------
 tools/nfs-iostat/nfs-iostat.py | 14 ++++----------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index e640642a..fbd57f51 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -958,6 +958,10 @@ def nfsstat_command(args):
     return 0
 
 def print_iostat_summary(old, new, devices, time):
+    if len(devices) == 0:
+        print('No NFS mount points were found')
+        return
+
     for device in devices:
         stats = DeviceData()
         stats.parse_stats(new[device])
@@ -1005,9 +1009,6 @@ def iostat_command(args):
 
     # make certain devices contains only NFS mount points
     devices = list_nfs_mounts(origdevices, mountstats)
-    if len(devices) == 0:
-        print('No NFS mount points were found')
-        return 1
 
     sample_time = 0
 
@@ -1026,9 +1027,6 @@ def iostat_command(args):
             # nfs mountpoints may appear or disappear, so we need to
             # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices, mountstats)
-            if len(devices) == 0:
-                print('No NFS mount points were found')
-                return
             count -= 1
     else: 
         while True:
@@ -1040,9 +1038,6 @@ def iostat_command(args):
             # nfs mountpoints may appear or disappear, so we need to
             # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices, mountstats)
-            if len(devices) == 0:
-                print('No NFS mount points were found')
-                return
 
     args.infile.close()
     if args.since:
diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 1502b431..f69ffb0e 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -478,6 +478,10 @@ def parse_stats_file(filename):
 def print_iostat_summary(old, new, devices, time, options):
     display_stats = {}
 
+    if len(devices) == 0:
+        print('No NFS mount points were found')
+        return
+
     for device in devices:
         stats = DeviceData()
         stats.parse_stats(new[device])
@@ -612,10 +616,6 @@ client are listed.
 
     # make certain devices contains only NFS mount points
     devices = list_nfs_mounts(origdevices, mountstats)
-    if len(devices) == 0:
-        print('No NFS mount points were found')
-        return
-
 
     old_mountstats = None
     sample_time = 0.0
@@ -634,9 +634,6 @@ client are listed.
             # nfs mountpoints may appear or disappear, so we need to
             # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices,mountstats)
-            if len(devices) == 0:
-                print('No NFS mount points were found')
-                return
             count -= 1
     else: 
         while True:
@@ -648,9 +645,6 @@ client are listed.
             # nfs mountpoints may appear or disappear, so we need to
             # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices,mountstats)
-            if len(devices) == 0:
-                print('No NFS mount points were found')
-                return
 
 #
 # Main
-- 
2.48.1


