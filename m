Return-Path: <linux-nfs+bounces-9788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E88FA22F52
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B441649AC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED31E9901;
	Thu, 30 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REkkYqBp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5C1E98F1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246848; cv=none; b=Fzat1IdvsW+inPpTTRxpuik+Abi2/uj7As+iucoIh6h1+RNe+seU2ouBl1u7tqsO95ExJgFPYGXCXbhURiszg/7aL9FL90prIQVHZT2Er0fVMzPBsZlXgp06r17aMaskzxZeMr6WLuDsqIlBJERu9fQyaW4E80CHp/O9xmy5DgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246848; c=relaxed/simple;
	bh=JLkFAVPMb5tHRj5wrQBX6nt0kYk7IOJ7LltpYOnt6o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMbFHoq1fvf71luJsOzDYTWDgEGbhvVL+5uYzQIx+KXJHBPTVu/4H2OFZXE4zX7ShhQaDaM3xGZxNEB46/ekMH4FCFVFdxnotO+0CUYlgPVn3ZGeN7kPFMXTtw/hzpMsCpVQDT8bmfOcP7bKCIRk635NKPpbQeBbLe/zgD5Hwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REkkYqBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i7ympnvOtakgFKVBVaKy6+PYwdzP3Ome7vSw6Hqx41o=;
	b=REkkYqBp5+IIm8CZ8NSI+8VddDizzDQo4cuHf/xG4IUDJN/OgCjRd9atiJXHG6GLp7N+qF
	6VJhvrG2A7Ve5I0eyaP5QFRqUM67wTTK9dNTONVWV9HfrkwYFe62dBQtvwYmDo2oA6T6F9
	RbBApsYkZw6uoTdhF7j5QT+XedczUIQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Y-V-DIMQP7699tOH2FxQww-1; Thu, 30 Jan 2025 09:20:43 -0500
X-MC-Unique: Y-V-DIMQP7699tOH2FxQww-1
X-Mimecast-MFC-AGG-ID: Y-V-DIMQP7699tOH2FxQww
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b7477f005eso198573385a.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246843; x=1738851643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7ympnvOtakgFKVBVaKy6+PYwdzP3Ome7vSw6Hqx41o=;
        b=XVBT+MJ/9cVxommZRjSvdoL6s9AXab0Y0CgNT4sKkVp9rUnmStANWaE1ARpNTSieFB
         5YyEhunyJRiR2LDJ2iYaqAANAc7ddUvM4INojGrvu0epiCJdfpdp1KtRp2ajAoDa89cK
         hj7TWrgO2VY0tFp+JjJWtTfEZ6jc80Fs3bvYPKtljD1M5BmSQvrUtS/mzShdj8u7OTfN
         XXZzs5xURgO+C86F12oEVKyU1dzceZkV+qrrsy1fuZw7HJiog1uJK7grn+t3uVPg4v1S
         sUnY0wJmcy1W9Ejje2Q2wyYOyjjmK6AzDD1imOxDTrYk+hM2N1zzCn2dKaG214NwfP+L
         y2xw==
X-Gm-Message-State: AOJu0YwyKr1LNGZAoQ6VUH6SGCZRq5tiSkLTj10QEgxFU1WVwijVLCTj
	UzPIST9KsPeDRKIpLQa3cd6xJu3a2WIzihejUVTmA3nJMRoAQ3ptqwRm3KlxwLTiWVKavTTOSty
	U1FHy7lFHJOEM54l9XWmgXVNFTe+VflLbmZtBvzNNqEJjgN26/PipvWMBhm8rpQnBe02+GAd60P
	yZAnE7MCe4BN+kJCCxh05rwnl9xbtOT51z6n6o4TN6AA==
X-Gm-Gg: ASbGncu8enIc8U60gCl5PJ0hkcEN04IZnLqP+J9pj3zVWtQlbiw4dDi79hm6fp9ly17
	5+I8Fr5m+xoWxdOvNBGC/atU+ZaL0YldmGTCIkYasISxHNU96RMpwo2PQM2hXBes4X2gwnGI3XZ
	p21cz7DNqKMwsC4yv9hlIov5VTCnBs9Rn9iZNhG/C7rB88kr67zL0rxcxd/c8uJ1ZssvTUBBuyw
	xLCpatQ4UySMXlMiNA27haGnaY8dFytjQe6B/MitX3d/PVHnarupY7u1fMdlmiEyq0pP+1koS39
	SnOxR1xjnKJgXOfhyEX9YPrOW9HtrkiGdQy4soadGBkyRCaf5oic2wF8rsYIyHxU
X-Received: by 2002:a05:620a:1906:b0:7b6:cbc6:c87c with SMTP id af79cd13be357-7bffcd0f2c6mr997063785a.30.1738246842822;
        Thu, 30 Jan 2025 06:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc384QfZJeolVxbZcYPU0Icyd43/AXkPB5shEEfwPFtLYFxVlGM7/nUG/2GSNrKIwZimUNTA==
X-Received: by 2002:a05:620a:1906:b0:7b6:cbc6:c87c with SMTP id af79cd13be357-7bffcd0f2c6mr997059285a.30.1738246842238;
        Thu, 30 Jan 2025 06:20:42 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:40 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 2/8] mountstats: when printing iostats, verify that old and new types are the same
Date: Thu, 30 Jan 2025 08:20:01 -0600
Message-ID: <20250130142008.3600334-3-sorenson@redhat.com>
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

It's not sufficient to verify that old and new are not autofs; both
should be the same fstype, in order to cover other potential
mismatches.  This prevents crashes when a path is a mountpoint, but
not nfs or autofs.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/mountstats/mountstats.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 00d1ac7e..59139ccc 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -961,14 +961,15 @@ def print_iostat_summary(old, new, devices, time):
     for device in devices:
         stats = DeviceData()
         stats.parse_stats(new[device])
-        if not old or device not in old:
+        if old and device in old:
+            old_stats = DeviceData()
+            old_stats.parse_stats(old[device])
+            if stats.fstype() == old_stats.fstype():
+                stats.compare_iostats(old_stats).display_iostats(time)
+            else: # device is in old, but fstypes are different
+                stats.display_iostats(time)
+        else: # device is only in new
             stats.display_iostats(time)
-        else:
-            if ("fstype autofs" not in str(old[device])) and ("fstype autofs" not in str(new[device])):
-                old_stats = DeviceData()
-                old_stats.parse_stats(old[device])
-                diff_stats = stats.compare_iostats(old_stats)
-                diff_stats.display_iostats(time)
 
 def iostat_command(args):
     """iostat-like command for NFS mount points
-- 
2.48.1


