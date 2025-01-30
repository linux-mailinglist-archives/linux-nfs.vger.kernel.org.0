Return-Path: <linux-nfs+bounces-9791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE8A22F56
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5B5162A22
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168851E8855;
	Thu, 30 Jan 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8mWLiA0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6401E98F1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246851; cv=none; b=EZH6Gvi8ipnNZoraRdPrT9cZHfyW9W7fsDOjN7wvMDdwhDJ7iMxIT9BkYjYmLHEp2oVT6TT7c+kyQQDCXpHOtA3LAgvvlaZOQsKdllun/yg/KZNuljDVdORo7xLEuZmnqF6fvpes7yuOye+mZdxDnuhVrp+T4XSQzl8+eveEsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246851; c=relaxed/simple;
	bh=SoweczzTORvFTurLVDnrfc81FFcqs5gJiXUftnjHPAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jijPm8P6d+bbB9E6ueMz9Ymxcl9ATXlj1jl2TpAgra97QjzWy/ZmQKF4/sqhraE6T7MqfspF2Kg+subcPBFZEd5k9U4OWWzv0UhEdSdcv88Uk/aCRqlXOy5pQEzN7IRH2ZIqwNoYybqC6VTd5wO2cuiQ+gHDO7434Yw6XDEnI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8mWLiA0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHk7o2CyA9nsZVViydmZdU55KVJBsJebmKxG4HW9Xxo=;
	b=g8mWLiA04hzHMGaA744DKyg8uFfNekA7skRPq6xSkV9RIG1NxDsSarlnnOE1Ou6pR7+2zE
	Ft1nMahUhpy2OzXdN1oV9s1UMtP+vtAmVecROvzubPqjTRRPS1QjNFmx6Q2pNjVbuKWAqI
	d6xNfnN+frvFP1VrbN8JONGMdMErX4Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-9ju2i_nMMhWTb1_qHDDr8A-1; Thu, 30 Jan 2025 09:20:47 -0500
X-MC-Unique: 9ju2i_nMMhWTb1_qHDDr8A-1
X-Mimecast-MFC-AGG-ID: 9ju2i_nMMhWTb1_qHDDr8A
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7bcf4d3c1c1so133885185a.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246846; x=1738851646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHk7o2CyA9nsZVViydmZdU55KVJBsJebmKxG4HW9Xxo=;
        b=G+nW9trq0POG8wB8qshwMFjl1mUidMdD1CtzsoNuJGgLaPH9ftI163JTyb7IaAJ+dA
         TgT9imGwyjHAtTFaK963q6JGXx2oNaQMNVTc2toevhmAYkQC9s0/rmOdLpvbyDvQvnAT
         GyacJl3jGKAAPvkihLs2ZTuV4uyIG0vXa04toRUNzu9p6Ac4c51wFmUZvZKHE11Y+Czh
         MH3SViJGBIgm80fVXmaO/90pyvI6f+rmJTVZOvTHOmTmT17YMqEIBwwE+5s7CGwGWDJ7
         waVGUrNieoDGnIwI0rLRE8GQAS66sSrSUUX2KVCFaPAr1tKiBUpNGUGkX+O05BhQOdGj
         NL3g==
X-Gm-Message-State: AOJu0Yxani3bbmVTtNT727dDVrz1uPHP+U58RDZWng7+3IX4PO9mdRQQ
	pU9qt4seFzRDxFBWHd/v4Z7EV8A5pkHv8OoREIlBMHyQCfZYyKImroQSdFtoLz/64WG2rKfheMa
	SS3QTRGM5pt8kM6dNQb9OqAR8YFNtqMtK1pzIyKV2WhtKFD2CnJbpdAL0CHaDX/Kb3tvk8LtrhB
	eHLi9Q/QiSZJ3nTtUg7zHMYisRlKRJw51iHCif/PZvUw==
X-Gm-Gg: ASbGncuvpLcIXbhy++XISvM2pvnMBnargQJVbU29DQMj3AMntqgqF5A00dTmsjZmMei
	Nuol1klXlc1HHVY/pGHw/fwab3TK3WKTbhgQDGEcO73/0SUP1VlSjjcFFpKDoXF7BoY02XGG2RF
	9MeBqds6uAHgMcqE2a0RSbtxShbfWrGRNexilfC7/T9T8GiEBrd+T555VrbBNidTsgElB3C4U29
	UWybf/p/+5aiROyfJc+FsGShlbjQijmNt205t48w/Brz8mToRx0xgaXeaGlZAuxwvLWU1W0dmeK
	nJLOX24et/TAMba0PhN7I4ccp2gpnd9GVgzF6sI+XLHuNkFDU1QDWC5ogNQp9DcN
X-Received: by 2002:a05:620a:4247:b0:7b6:d393:c213 with SMTP id af79cd13be357-7bffcccaf39mr1094302885a.8.1738246846091;
        Thu, 30 Jan 2025 06:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE16Qv/tF77HUXqvX7oURmPOPYYnz2uqAdIqhunpWVF2es0s7ddmFu2plx1p3aliYa+f+H0w==
X-Received: by 2002:a05:620a:4247:b0:7b6:d393:c213 with SMTP id af79cd13be357-7bffcccaf39mr1094297685a.8.1738246845646;
        Thu, 30 Jan 2025 06:20:45 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:45 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 5/8] nfsiostat: make comment explain mount/unmount more broadly
Date: Thu, 30 Jan 2025 08:20:04 -0600
Message-ID: <20250130142008.3600334-6-sorenson@redhat.com>
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

The comment explaining the need to recheck the devices list
suggests that nfs mounts/unmounts may occur when automount
is involved, but they can happen for other reasons as well.

Make the comment explain the issue more broadly.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index 08b827c0..1502b431 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -631,8 +631,8 @@ client are listed.
             time.sleep(interval)
             sample_time = interval
             mountstats = parse_stats_file('/proc/self/mountstats')
-            # automount mountpoints add and drop, if automount is involved
-            # we need to recheck the devices list when reparsing
+            # nfs mountpoints may appear or disappear, so we need to
+            # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices,mountstats)
             if len(devices) == 0:
                 print('No NFS mount points were found')
@@ -645,8 +645,8 @@ client are listed.
             time.sleep(interval)
             sample_time = interval
             mountstats = parse_stats_file('/proc/self/mountstats')
-            # automount mountpoints add and drop, if automount is involved
-            # we need to recheck the devices list when reparsing
+            # nfs mountpoints may appear or disappear, so we need to
+            # recheck the devices list each time we parse mountstats
             devices = list_nfs_mounts(origdevices,mountstats)
             if len(devices) == 0:
                 print('No NFS mount points were found')
-- 
2.48.1


