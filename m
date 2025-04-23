Return-Path: <linux-nfs+bounces-11231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4157FA98AE3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7825445887
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D891922D3;
	Wed, 23 Apr 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iu4GVOzd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FC17333F
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414582; cv=none; b=WweuYCpZe+CAVP9yfpRlGQDzHpojHDV1O4muJymtwKyyPK/n0ed4D9e4AStStGpzBBnr+u/G/Y4ONJOXaDGMoP/AzQlpCH+ifbZ79vcuaqGXe7px70s5jtvFpDU1rwkYayToTtQYi5SroVIdb1H3xN+IQqWWhn+7WmGlbDe+YfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414582; c=relaxed/simple;
	bh=yGMSVv9f4+/4b3cn0zZNoJ4i27It+95C4eOcXL1wdAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDMoSg03K6cA/LyFxLyYGWo5E8iUbM7vl8o8hqQOd0ZBAnSGROeGtXV8HiaG/VSrC3NNb/wsk41XDK3n/pBdzWM4XzRcoOg8LQ9pNGdTvkixS3FDu1IGHnkuDDODvxDec3/bmJnJOmuQizm2b1oCCoHbttA/4BFE92WYnInKpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iu4GVOzd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so56065365e9.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745414578; x=1746019378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKMjh80pkF0U1r9Ws45Yco9sh0xx3u5MhQd3yiBsdSA=;
        b=iu4GVOzdGdvIbkMoSUvuhlzhXz9vyGHeztUkkvHfi9avJq426ILdaRtLltID3d0zWp
         la8GZ7n80hgTegYWxVoRWvJRsm6TThFJSxqyivyUp5w8nsnymgfLQtjEWEexVu35rtyc
         kbNUlI/SPWT2M4vCaave98TXhR8OYSOHpWX/T4D7ySjwOqirrW8bjgpMDfYI0W9rJ/zn
         ncBfu0H8/mjUeOZe5c8eduTav0qDU2bSugzAyHqBNEoYcZ3IZJqS+1/aDjscCKq5kFVo
         hkr+c7aRqPAO5VaJ428e29Id9rq3SQgj6CNn+mViTYGpUl0wUqaV5WQ4/vaWIYzODNOr
         AjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745414578; x=1746019378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKMjh80pkF0U1r9Ws45Yco9sh0xx3u5MhQd3yiBsdSA=;
        b=LuhJkr/eG6+QppGfurh1kesfWdxz2StZmNSqWrlnnVUKMIUofouEkHtqr1HyA/cI66
         412DuaxOQPJIIAtwEGj4Sc5wa07Qph66grlHxNHIJ13EOXB77ZxUZKM4OcCo/eSVh4G5
         hIsLqcneEqNWflYTo+3vl93pAFB+4pr5m8CsPPuc/NxZM3hkC01gHHNm3CDn7X3xNGKx
         6UEutL0xUsY3DIy1/6D5OkdjMesXNoZdjZmPosklVZQ/Hu1UrhSTYDgtNb98D0TKtnU6
         F8Rqhg05CmdPXFzQzPPcHvT8DEyn5YO9UGTY1qNLYmgOuy33n4247+efQC1OM0cfyIt2
         37yA==
X-Gm-Message-State: AOJu0YyFM1vBfJaO5m+kvQ5RsvbLgaq6A7Sa+D7Ph03811IWY5H3cziR
	Pv34rPIQd4EAhL0/nJGDEPV5zEPINqO5QtHyv0Wnv9dVzXlQtSsxOcyh52Hm8Vg5X9C+bwfNHfC
	m
X-Gm-Gg: ASbGncs1nL9nIGzA4l7dUDPbYoE4Jsa+XBhzd+Ie+LV6WLhqO9hVhC0+dvrYjpVrLKi
	z6v/C7iKIeKPyt+SvuF67SGSAh00EwHgcvWxZC0tyNaPcCeDHK7OQijpn1IWHVRNVkxv4ILpLpg
	nAiPbI1gMmVsxw6ybbcfeeSikB2BJZD1j+tmc5ujnt9DxXHAiICIJ8ylUvHAQtanT9ioKKzuhoZ
	YVeBcptUS5VXWBlHbd7z1FqBgvyfgm0FIxp7egSdn6jcF3R7R2aklHi9U2o5+RcdERZiR8esNoq
	tMVu+fIio+4BaBEX5/j1wAmc4QO7fnpHtmN7gGM6FwwgKE4RXDSXh31ZMN6vnFO5rfR31SvjzcV
	/ELRAYqY++F82XcaYb8GvOTpPdZh3QFSAsJpEq80S
X-Google-Smtp-Source: AGHT+IH3oOCJPqy8g9E1uMBWxJG33+l7Q/cJgMxL7y9T/lFqjvdA8c0HXVW/rdbAsZ8zObi1wqadtg==
X-Received: by 2002:a05:600c:3107:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-4406ac21886mr167630725e9.29.1745414577838;
        Wed, 23 Apr 2025 06:22:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f041700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:1700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d16dc0sm25792765e9.6.2025.04.23.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:22:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-nfs@vger.kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	dwysocha@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()
Date: Wed, 23 Apr 2025 15:22:50 +0200
Message-ID: <20250423132250.1821518-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, when a file was read while it was being truncated by
another NFS client, the kernel could deadlock because folio_unlock()
was called twice, and the second call would XOR back the `PG_locked`
flag.

Most of the time (depending on the timing of the truncation), nobody
notices the problem because folio_unlock() gets called three times,
which flips `PG_locked` back off:

 1. vfs_read, nfs_read_folio, ... nfs_read_add_folio,
    nfs_return_empty_folio
 2. vfs_read, nfs_read_folio, ... netfs_read_collection,
    netfs_unlock_abandoned_read_pages
 3. vfs_read, ... nfs_do_read_folio, nfs_read_add_folio,
    nfs_return_empty_folio

The problem is that nfs_read_add_folio() is not supposed to unlock the
folio if fscache is enabled, and a nfs_netfs_folio_unlock() check is
missing in nfs_return_empty_folio().

Rarely this leads to a warning in netfs_read_collection():

 ------------[ cut here ]------------
 R=0000031c: folio 10 is not locked
 WARNING: CPU: 0 PID: 29 at fs/netfs/read_collect.c:133 netfs_read_collection+0x7c0/0xf00
 [...]
 Workqueue: events_unbound netfs_read_collection_worker
 RIP: 0010:netfs_read_collection+0x7c0/0xf00
 [...]
 Call Trace:
  <TASK>
  netfs_read_collection_worker+0x67/0x80
  process_one_work+0x12e/0x2c0
  worker_thread+0x295/0x3a0

Most of the time, however, processes just get stuck forever in
folio_wait_bit_common(), waiting for `PG_locked` to disappear, which
never happens because nobody is really holding the folio lock.

Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when fscache is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/nfs/read.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 81bd1b9aba17..3c1fa320b3f1 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -56,7 +56,8 @@ static int nfs_return_empty_folio(struct folio *folio)
 {
 	folio_zero_segment(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	if (nfs_netfs_folio_unlock(folio))
+		folio_unlock(folio);
 	return 0;
 }
 
-- 
2.47.2


