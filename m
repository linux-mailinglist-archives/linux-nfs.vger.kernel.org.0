Return-Path: <linux-nfs+bounces-9790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D9A22F53
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D11882EDE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0031E990A;
	Thu, 30 Jan 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvsdkxRU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE01E8823
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246849; cv=none; b=puMEQkStnxuyoWtMqE12mDfvMP2yr1PWWKJvkq4069TRa8mrcnxjVtr1T/Jy1HPg/tKdazNRuxebmDQm47jNLCKQu19dtiijm1QsDH9rmgKypzhgWxkuyNMIDX7jNjyZL3epUkky/acLK7ZvRJ5wLo5b0lPQ2+QxEwJFb8iRq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246849; c=relaxed/simple;
	bh=VJ2pH26Wnp/bJW+vKPe2uDfNAJ3LkjeDIQHMW5wGkeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UamGrkoj7apnsP/FMa8zTLhJSMUV/TAnPrEo6ghg6sGDI1Rb1gfgKz1EEhovHCpsHb7Y3IIj8dYdgFVB49RWTZ4AYSTJ1vzM5HdP+RtVZD81S5vEnYciAVV8+Rf/fY3JI9CDiyBm/Z7sLyJPS2nuPMppDbM6n0rlHgelhXDXhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvsdkxRU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738246847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6s4uioLKzdoeSnVuIIR8qNUDReFPfpWvoPugWeF0XE=;
	b=CvsdkxRUgIM+iP831FnmAuKP2Gp/gwytGG6AQMeLgTBZvnXNl6xA+2IivP1UG9iql8SBgU
	VOEdfFmadGxK7YFTj4Y/MtZrDaaw8GYjeLltU98bjZXaqX5CB9AuIqkrI9fcU8CRK/lzJ9
	v8UzkNNmKvEDedleQm4RbsfvDC/ADKI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-iwz04zbTPU6Qgljg8XqwgA-1; Thu, 30 Jan 2025 09:20:45 -0500
X-MC-Unique: iwz04zbTPU6Qgljg8XqwgA-1
X-Mimecast-MFC-AGG-ID: iwz04zbTPU6Qgljg8XqwgA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f2515eb3so80183685a.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246845; x=1738851645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6s4uioLKzdoeSnVuIIR8qNUDReFPfpWvoPugWeF0XE=;
        b=bE5QIR5ozT5bdFYi019y2KwC4GAqQL1w8lw9+eCti4F0GuTPxzmBfpbaRwHXbuo7cK
         hLaTcBWerIBp4noJ9m9P1vPG5GTIEWbVwpW3WBIJICs+wmDSkXLplCQ+Lk1TNEB5ahyQ
         gj+9k39/n6Fi9Pv/rs8gjvwvq7/IWVjT2QFY3359PGs3uH+IosY3StfhRZgbhSntHwND
         2m2b1D8zRQXvTindteC5bmbpOb+pH2Axx6y6qmiNIMVMWke4Ganz0aR+Y35nbWvXY7mE
         3B2AaMURadgmJ16bW50RN8/SpHzvuUc5WyvMJH9E/qOeMvAXggJKKNjz6Y8Ob2u1OSFB
         qvKw==
X-Gm-Message-State: AOJu0YwXWx//blyureMLaaPDoWhyrzhEL02+h9lHwLW3cHnKHnuCJ+LU
	LEZLnDWtrqTkmlQyhs+BKHvOwrD7yjiTfVLttNy9JnfStY3HsqH4NNph4XCufo0klBbmq3mkbP5
	/MASkR1IXtycv9s2IjW9QkuEXhpfSitHm1frRva5uYEq7fWKS4DYBuQ/GcZtsRbBIEtBCiZO7PT
	E1JqcPWhYfyuevdwy9YsNEcY21pjnGTgzKB5ci0bcTmA==
X-Gm-Gg: ASbGncuN1L/wWe+sGrnV0h7J2O6RZYFlM6hvvciBK+fTOfMkwv4kPHqrzm7kSiWAv+m
	/4nAUHX/pn71GiLp2dlSBq8dkhXbmZ+r5ktJ3/MZwWZNRWZBfCGTeRMlIjzpw6bjLF9TWfOit8U
	WUKPVOGIXtK7f5l57rzIxJ+lOmpFDQiIr6UJrKeBUBHa35bSzh2aIvNUVF/cWCHDGhL9d3+uRZ+
	MZ2OYf7Djm15+Y0rITaL9CGAUJvSLiisX08P7f+1wzOrWEkvUr/1Cxtdk8A/Ymz6L6kS4ihThcJ
	HTy0u1NcMHASY/0vZcoH6fp1kDO01GpPczy96omsyMdwZL/JbxW4U5+v6EHnMluw
X-Received: by 2002:a05:620a:6084:b0:7b6:d631:266f with SMTP id af79cd13be357-7bffcce5266mr984149485a.14.1738246844615;
        Thu, 30 Jan 2025 06:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUmvOBxXduqoDce9fgNN3Wevb+GlU1S9th2a1NZM2U7CwCPzcwttl5oTCxs86JRUEno6naPQ==
X-Received: by 2002:a05:620a:6084:b0:7b6:d631:266f with SMTP id af79cd13be357-7bffcce5266mr984145185a.14.1738246844183;
        Thu, 30 Jan 2025 06:20:44 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9205f4sm77449285a.114.2025.01.30.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 06:20:43 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	chuck.lever@oracle.com
Subject: [nfs-utils PATCH 4/8] nfsiostat: fix crash when filtering mountstats after unmount
Date: Thu, 30 Jan 2025 08:20:03 -0600
Message-ID: <20250130142008.3600334-5-sorenson@redhat.com>
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

If an unmount occurs between iterations, the filter function will
crash when referencing the 'device' in the new mountstats.  Verify
it exists before trying to access it.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/nfs-iostat/nfs-iostat.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
index bf5eead9..08b827c0 100755
--- a/tools/nfs-iostat/nfs-iostat.py
+++ b/tools/nfs-iostat/nfs-iostat.py
@@ -511,10 +511,11 @@ def list_nfs_mounts(givenlist, mountstats):
     devicelist = []
     if len(givenlist) > 0:
         for device in givenlist:
-            stats = DeviceData()
-            stats.parse_stats(mountstats[device])
-            if stats.is_nfs_mountpoint():
-                devicelist += [device]
+            if device in mountstats:
+                stats = DeviceData()
+                stats.parse_stats(mountstats[device])
+                if stats.is_nfs_mountpoint():
+                    devicelist += [device]
     else:
         for device, descr in mountstats.items():
             stats = DeviceData()
-- 
2.48.1


