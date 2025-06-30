Return-Path: <linux-nfs+bounces-12824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE97AEE6D9
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A43A3DA6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A228DF29;
	Mon, 30 Jun 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nio9rovU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784F28C2C7;
	Mon, 30 Jun 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308573; cv=none; b=lh8wxtM1Xo2/6nYwygkHM8Z9E6CKNhs87nFB2k8kOV1/BM6Z/fX2v4pxCz9J7GiZlyVgD+DiZI42m8JFdbyNQ6E4h5wP3Zo3YViFHxKVsi5M0l0Xa31yVgMaxtWtBPOZPq11ZjTUP5Agy6nW0SyxOU49orjSL7G4SaLI65oN1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308573; c=relaxed/simple;
	bh=ZxZLnWtmmUilKIymsjRaHEtJE+C4+MCqJFqKLECf+So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuqhGSnQhsqVzngT5CnzJZzSXgG3c0GGq7t8F+VrXMkoqkJKmZYOjGJDKba3V/stV5LEwgjTTcpzc/LlQJdLqwk0uDRGxBE0SY/FOOIqQbdW2k1wmxC/Eyjpa+xRhKOCkZgecrMEkGm7fJs+znoFU36O1txZ48zm6icX1gafbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nio9rovU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b82f3767so2732788e87.3;
        Mon, 30 Jun 2025 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308570; x=1751913370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnL+VKcG6vtnAyOcHVA/msL4mcR1nmGy9AOG7qAyXtg=;
        b=nio9rovU5ofSrh5eIU3SnFUC/3r2nIbh1lF0lCvnbLkIHAPG0hQqq1akVGNhwkerAt
         mCwAbzucvmlfWtJWJAPxzZ7TLxFPvWzimzAjqFYU20sNXWft0Egonuq/jsT1+yXCHOhf
         wlwkl2mmDcsbS1+hD1sGugY5z9NO3IjhGGohdC6cLAnWNL95IzyfNyQVajq1+SBeGFsf
         JuugBQmmClo7NMdsxj5ruEpAVs1K/QMALCaOHxKZnIP892Rq8GqDpzAN2tdb72eGHJqT
         bG0Uhv+8XejG9Eqo1aeqDHE3UQDUJ8YdCtJaI39KVA75HWJBCj6QEc6pjSp70gl51aGS
         xarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308570; x=1751913370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnL+VKcG6vtnAyOcHVA/msL4mcR1nmGy9AOG7qAyXtg=;
        b=SxurVFLpeAKUQtUERiQ6uZWomKAOtOA6dHkrbcwQ7W/pVJK0VcshSc/URfGBzSjZHB
         fmX6q7G80AWXJUe5RhNhep9ztV5UESL6zsHrRFgoUnD2eKl16F55e3UBDkAvi+j1hrJa
         XY3R4sLVHlYy62n8RZVWBZ8eEy/bWhC3Ck2GN+wXRU8H9GHh3Q7lHjfNX38kq/VUd/Jm
         kfGzpGH031dn5eWhKeSHUIq3t21vDzAL1lQnLy2201PRCQUEv4+LuYFrfBXcF4AhiArM
         xEbD2zbT9PhVJYRBJ89fjzyk6T2VIT44V5HuQUIw0eUyou4pYdz5tGcOSZJuBpLEUEeq
         qe6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6ywlBCaN9dmaAPVinmYphXpxvcy+npNCHVjis7D54BmPhNJMbRkB6RkY0F7SOSVzGQvFeyUdtEZYTcM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrZBvcrqgrASAFdkiSdOxUsyJ/sZmi2Xp/PWYYqT3AXjJFj6B
	UD+pZ7t49Umo3LG2amHkXUUPJ3rnYGH01UMrJfjfZarFuwva3KLPp05a
X-Gm-Gg: ASbGncvr88icvfRmNGsUyymmJf2Y8ENNWoZ0y4XmwtMtJqGDp8Q9dFJ8Mg3hBG2B423
	YS79RtJB3Qs5TOyzxrXhsFGgGw5Mvcc5gPgDe50Ed3SzQ+53/FlznUKBiQhg4vVQXGmxkf1ohHi
	S1vK1fJTrJ/dmjmRRPafO4Mw1AJ2ya2wsZzzpB8Q3FdI0jEs+W+Ji3pE9s1hw7+UCIYz4IBSkY+
	vzI6J1gLGVoB78kLojh4d4vdMwOzQ+KIplHCYfEJl3dxRM0DHDva+J3pLSkfVAQIwdNwCPK4+yg
	54ql7TlfjRToWuhN2XmvKz6jF6H/RfpzZ6xbM/o1cZWvRvug30iJTJxhk5atRBBRrJkp64QLLtZ
	U8BZr49xo4cX91g==
X-Google-Smtp-Source: AGHT+IFiEi1lzg3OKTfZ7KElVz9E/tSmTqGl9ImbBdSyLZcLeyCqOQm4aFQ6bSDiNTvBlrTSY41q6g==
X-Received: by 2002:a05:6512:3ba6:b0:553:d910:933d with SMTP id 2adb3069b0e04-5550ba23b5fmr3911409e87.48.1751308569578;
        Mon, 30 Jun 2025 11:36:09 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1530793e87.88.2025.06.30.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:36:09 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 2/4] pNFS: Fix extent encoding in block/scsi layout
Date: Mon, 30 Jun 2025 21:35:27 +0300
Message-ID: <20250630183537.196479-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630183537.196479-1-sergeybashirov@gmail.com>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ext_tree_encode_commit() function may be called multiple times for
the same file, layout, and last written byte if the provided buffer is
not large enough to encode all extents in it.

The first problem is that the last written byte field must be zeroed
only on a successful call, otherwise we will lose its actual value and
get an integer overflow on the next encoding attempt.

The second problem is that we can't count and encode in one pass. The
extent state changes during encoding, so if we return -ENOSPC but have
already encoded some extents into a small buffer, they will not be
re-encoded into a new larger buffer on the next try. As a result, the
client never commits these extents to the server.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/extent_tree.c | 80 +++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 0add0f329816..faccd5caa149 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -520,10 +520,71 @@ static __be32 *encode_scsi_range(struct pnfs_block_extent *be, __be32 *p)
 	return xdr_encode_hyper(p, be->be_length << SECTOR_SHIFT);
 }
 
-static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
+/**
+ * ext_tree_try_encode_commit - try to encode all extents into the buffer
+ * @bl: pointer to the layout
+ * @p: pointer to the output buffer
+ * @buffer_size: size of the output buffer
+ * @count: output pointer to the number of encoded extents
+ * @lastbyte: output pointer to the last written byte
+ *
+ * Return values:
+ *   %0: Success, all required extents encoded, outputs are valid
+ *   %-ENOSPC: Buffer too small, nothing encoded, outputs are invalid
+ */
+static int
+ext_tree_try_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 		size_t buffer_size, size_t *count, __u64 *lastbyte)
 {
 	struct pnfs_block_extent *be;
+
+	spin_lock(&bl->bl_ext_lock);
+	for (be = ext_tree_first(&bl->bl_ext_rw); be; be = ext_tree_next(be)) {
+		if (be->be_state != PNFS_BLOCK_INVALID_DATA ||
+		    be->be_tag != EXTENT_WRITTEN)
+			continue;
+
+		(*count)++;
+		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
+			spin_unlock(&bl->bl_ext_lock);
+			return -ENOSPC;
+		}
+	}
+	for (be = ext_tree_first(&bl->bl_ext_rw); be; be = ext_tree_next(be)) {
+		if (be->be_state != PNFS_BLOCK_INVALID_DATA ||
+		    be->be_tag != EXTENT_WRITTEN)
+			continue;
+
+		if (bl->bl_scsi_layout)
+			p = encode_scsi_range(be, p);
+		else
+			p = encode_block_extent(be, p);
+		be->be_tag = EXTENT_COMMITTING;
+	}
+	*lastbyte = (bl->bl_lwb != 0) ? bl->bl_lwb - 1 : U64_MAX;
+	bl->bl_lwb = 0;
+	spin_unlock(&bl->bl_ext_lock);
+
+	return 0;
+}
+
+/**
+ * ext_tree_encode_commit - encode as much as possible extents into the buffer
+ * @bl: pointer to the layout
+ * @p: pointer to the output buffer
+ * @buffer_size: size of the output buffer
+ * @count: output pointer to the number of encoded extents
+ * @lastbyte: output pointer to the last written byte
+ *
+ * Return values:
+ *   %0: Success, all required extents encoded, outputs are valid
+ *   %-ENOSPC: Buffer too small, some extents are encoded, outputs are valid
+ */
+static int
+ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
+		size_t buffer_size, size_t *count, __u64 *lastbyte)
+{
+	struct pnfs_block_extent *be, *be_prev;
 	int ret = 0;
 
 	spin_lock(&bl->bl_ext_lock);
@@ -534,9 +595,9 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 
 		(*count)++;
 		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
-			/* keep counting.. */
+			(*count)--;
 			ret = -ENOSPC;
-			continue;
+			break;
 		}
 
 		if (bl->bl_scsi_layout)
@@ -544,9 +605,16 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 		else
 			p = encode_block_extent(be, p);
 		be->be_tag = EXTENT_COMMITTING;
+		be_prev = be;
+	}
+	if (!ret) {
+		*lastbyte = (bl->bl_lwb != 0) ? bl->bl_lwb - 1 : U64_MAX;
+		bl->bl_lwb = 0;
+	} else {
+		*lastbyte = be_prev->be_f_offset + be_prev->be_length;
+		*lastbyte <<= SECTOR_SHIFT;
+		*lastbyte -= 1;
 	}
-	*lastbyte = bl->bl_lwb - 1;
-	bl->bl_lwb = 0;
 	spin_unlock(&bl->bl_ext_lock);
 
 	return ret;
@@ -577,7 +645,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	start_p = page_address(arg->layoutupdate_page);
 	arg->layoutupdate_pages = &arg->layoutupdate_page;
 
-	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+	ret = ext_tree_try_encode_commit(bl, start_p + 1, buffer_size,
 			&count, &arg->lastbytewritten);
 	if (unlikely(ret)) {
 		ext_tree_free_commitdata(arg, buffer_size);
-- 
2.43.0


