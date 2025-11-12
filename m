Return-Path: <linux-nfs+bounces-16307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55569C53DC6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 19:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84FA4F886A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516C340287;
	Wed, 12 Nov 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ActtmNRL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A53347BB6
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970569; cv=none; b=kcUo6QGt5GngpYuXecW1wRyUIkl6Dr71d5SQ8ZFjnfud3NkDcgeaUZCvn30xiDGNsQGSLlepl8koRXfBdBcl50VFagtfYbimuzIvM3yq/SfKJMGXVWiPxxyQnfnKWG3ggYn0Mag9R/X+YhKoe+moFSnUmnrYf0CdLyFpqS2ADYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970569; c=relaxed/simple;
	bh=pJXNq7nWHLgL7Z2QmZYy19z/ob2CV0QYQqYwaTP8uXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHC7GRVloZnd83cTXcAGCXtURChNglQZSVpgrYVehgfGxo/QVovmvIttGCXkhQ/qeNgdPVx+nc/Vh8aFUimEGMkobfpyeDCoS72U93ib9pFP3LQLg7iEBa+cOrejM38e85xgZeym8by9YZh/vZ6T/muBiRSNGKSs4f1zgDHRfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ActtmNRL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so228131566b.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762970565; x=1763575365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I6P5+InNxbRtt54+O7hkAcOS9XQZk7rvLRdH65PFTQ=;
        b=ActtmNRL3R4UKq3+6plM9arTmqVk+QZsn0yRjialdOvrZGwPwjsfbCI97YgA+6UHsK
         ChSa8gUZTaYehET5MRzH1l5DL2BPwln3rU92d1qUwNJrpvM8PT51SxkyqODqP2UP83wL
         tVe9jCmWCs8dXSU//VAMpEzxTeN2X8CJHmh3zOQUppHNFKDoh15PJsQhv+zOFvYdysmJ
         Msf8G941PNG7LE/HhI9D1n28uXDl3zMRz6rGQJFABxnQ0VY5XiTe9BO3DWjDBeMsBJIE
         KJwkpHRiQ2IzUCtuNitVIEaoyiZDp+6n+AOS8ylTNQ50qhNnEkgiouYQCmBLhYITjzzj
         DbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970565; x=1763575365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I6P5+InNxbRtt54+O7hkAcOS9XQZk7rvLRdH65PFTQ=;
        b=AvKWHTwGmI5EgNQXgLCL+fCBoYNd1omRHVY6VUnrnBmggyCnYDf5YebchWaz4+0kzS
         tiVbHEvpgkRArFjSrbRDw5j2FZZtPZ4lb/zczRyebhOHWuT8LsZCsg7gAah1awT64vNz
         p3WELTdT1ok+R5Jl9NAqDae0RlscDF2NkDQHoq+vUDHSWYs0uluNKMtsFHjQnyxegYnZ
         uaYp/LwPXXf77LBeNf6fn4qSpCwr9+hHqszAOEOy4xRzuCl+myISTpJPAooFDNfRUdY6
         KbDWm86EUA1lChvPyO5fXiZWijRrqRUVTFLwxvkO+uj3jZtDvLV8Cs46HUW1oYasYTkr
         H/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWLy09fRuLQEgITkNw0zh3ZVMPYlErBD/76jwZEZMgEd5k1bgXCHbWHZW9uodJEvYMW9olFXmLn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26brIhOY3y0QJ2YOmPfpy3Wcg9IiY95Yf90dxOSePOfQ09VMq
	owzwTzGEYVp6ZQpX+o2R3oMAqLGv3md3zMgQV/8jNvjdI/livCdf4Z31PwZnarOgCs6Mdm9YfQR
	ByjS+
X-Gm-Gg: ASbGnctkxin7KIaD23NigKz7OcoqKNB3/h1r28hV+qLpr09al320VEZfbwGtDNABmla
	Kczq50+9O8AL6eFV3hi2sIFc0jcGby7LIpm22TOtABIdGYJ9saDuQfpJRh3Rnr7O7Exa/GDnStR
	3OC8BjELaHZYfwKGwIBurzsSD3d1C1jpG0qZABSk6WzaWmt+HPHha0SYekkMwZcoaFMYwiXFSBl
	nAuBYcWmQ0bL12eXw2S557/ZgBQMM7ESP0cNGT32Q9JzTD+esvbCI8R96tCmSryOILavVdFXHVf
	jAJv8kbLziOIALSkodJHqvEEAKRRnzLfT5dSDkZNxrwEkEZbH/OakEnNvoaOxOqyTmQYocRO6mt
	I13ivHO4pF6mgo7EBGyLvPU5mX/7IqQuP28YnzKa+onjRTvHfVc+0HHQPU1zGY5M+nE2E9KxdSD
	Ao
X-Google-Smtp-Source: AGHT+IE/8CNXMJNP69vNyYi5NR6+56wQ5L6npYz7X53rZ/ywz4B94NkdBhsSb8AbSOFYn5RNO0Twyw==
X-Received: by 2002:a17:907:da6:b0:b4b:4f7:7a51 with SMTP id a640c23a62f3a-b7331b3bcb6mr468553666b.62.1762970565585;
        Wed, 12 Nov 2025 10:02:45 -0800 (PST)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b72bf4fd021sm1633902266b.25.2025.11.12.10.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:02:45 -0800 (PST)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Haihua Yang <yanghh@gmail.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid
Date: Wed, 12 Nov 2025 18:02:41 +0000
Message-Id: <20251112180242.345608-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This diff fixes a segfault in pnfs_layoutcommit_inode when
nfsi->layout is null during the core critical section. My initial fix
was to check for null here:

   if (!test_and_clear_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags))
       goto out_unlock;

This fix worked but I suspected it wouldn't pass code review since it
doesn't explain how we got in this inconsistent state.

Around the time I was looking at this I also saw Haihua Yang's diff
for ensuring layout commit happens before layout return. If such an
invariant could be established then it seemed like it would also fix
this issue. When I tested that strategy with stress tests it resulted
in deadlocks. Adding Haihua to the cc in case they're seeing a similar
issue and may find this diff helpful.

Over time I studied the history of how the NFS_INO_LAYOUTCOMMIT,
NFS_LSEG_LAYOUTCOMMIT and NFS_INO_LAYOUTCOMMITTING work in conjunction
with layout and lseg reference counting to ensure layouts and lsegs
stick around for the commit operation.

The next fix I tried was to hold a reference on the layout in addition
to the lseg during set_layoutcommit. This worked but building a
complete fix was looking complicated. It was later noted that lsegs
hold a reference to the layout as well, so such logic appeared to be
redundant. At that point I searched for a place where lseg reference
gets removed without also clearing NFS_INO_LAYOUTCOMMIT and I stumbled
upon this path. With this fix the crash no longer happens during
stress tests.

I added a fixes label since it seems to be introduced from the
referenced patch.

Jonathan Curley (1):
  NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in
    pnfs_mark_layout_stateid_invalid

 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1


