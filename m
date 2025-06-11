Return-Path: <linux-nfs+bounces-12319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE417AD5AE5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE197A875D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4361C84D5;
	Wed, 11 Jun 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGvV9/nH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8BC137750;
	Wed, 11 Jun 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656716; cv=none; b=Zhy6mwwD9UVsSCfvn9RMzR2i7PVUdgSmvUAM4tfPNlzmEg5XKsNadEmMO3BjOmg3m57yGibIdz81D+WOTG3qXCuvW47HckfdouKwnOMWlyNbWEjczMvAJ1iB+sDsTnNYWwHn3egj7jgSuxFT0ot323UgG1oe2aA4BY7GXTqT4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656716; c=relaxed/simple;
	bh=RY0x2tx+9t6x9WdWkbEoTFowcRceExpzkroTE3Sc8YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0jMxencIrSsVnPr+s0CHr5wH//n/a6Nje2S4+ARY7loQCMri6I4fv3vsDpKuCjXmtThwcF9vkvlVvXnCraOWNJ9rragLRrRWmE5dESESbhJIfy+0WIksMAZrYuHP53bg5GeNXucMu7NThrBY3B/Ijsw+NxbwxCPJ81YkvkKsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGvV9/nH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55350d0eedeso7098198e87.2;
        Wed, 11 Jun 2025 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749656712; x=1750261512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1ji8ec9sxXAFSm0mv9k2+YnJOhrrm2fDMJZg69aetE=;
        b=AGvV9/nHl5mP+fBl7GXLCvAuE4hnlkU/fgf/x5lN1i546OgAMeJugc4Fv0QFQZXeSD
         c0DNmTgi6HLhE+Bnja4XvUNNwGfiiqtelobKRsFdWkcOnvQymJwdJOhGUwmbsPS5VAaz
         H4yrUIMoER5MJjSzcQYvhEf7Q6qZ4IyLFWTacLPdlTaRBq+KFtW2s+Rir+Ek0b2nSpEp
         oP7YklKFR+3STrjpyTZeFRLbN4c5RT2m7X/n/LwI/FJ6GXaXAKCBdb7VuKI5tt2AE8Kl
         bgXRptvFQNH8W4wBnp1CGl2ii2EkoJo0TFektDvlE2fx37Ncr/NXSJ3+1aWtcXnPGgGW
         sOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656712; x=1750261512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1ji8ec9sxXAFSm0mv9k2+YnJOhrrm2fDMJZg69aetE=;
        b=W18bXiCPCl/wI7MkB2T2SkRKMY468PKM81m2Y83mpgxKe7oLGxaEffzM8HJe0JvpgQ
         YuGaKbWwtK9zwJU3FLeAfHsrCnd9G1wtYlVlupV/9hbtve8QDjDSyTy/gJzIYJGT4nVs
         NSVBtpyNs0GkDEIt9e3jK96UUowecTjIAb1jPZlCiksx63Je6UrUWj0tdxF/0B6pWu/y
         9+xJ6fOVu0ZI+BN9p5QJ6vN8/6qUqYq/kPUXHxd0h4jDBqjqWcQ7q7hdcpdC85IP8L/S
         +bt4Juq56s/o+EBfBICYHUCQRYBh50MLhiJxmkJlE8OJ2QBUH3i+LxdODUDAWrE8Xgji
         XZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2k3KtnCeGO7TzD+zIoL8YV3/DGC6AX6/llA2rub3pP6YuNtdOf902ZKxYONx+jiLSL70T2oqhBRCbQIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRNmLzLmWKwq9Ky7Qczqh154j/7mMb/X8ZxxsE0S5RqaOH0vf
	B87o2Zys1/R4QOogfoFT8jNNE8x+no6m5mD3eC38NHSQiFTpIMieyvdc
X-Gm-Gg: ASbGnctuRANJFgai0G162HaTivOePWelQiYMuK+k5lqlU5swsOTZryxXODwjxJfLwmV
	NhbQub7jgudpUV3B5gs+YVWhlkMcxdKEnl6T3wgr7KQT/Xoi8JLOeNLr0XScqzDk+Dm7NiIaTqg
	p2nUn9iodE+oYsSCl+CS+IWcllCetx1LtThRiYLNbE8LcR5IkfV3r1kwrKgyg46ZXPrFu768XTY
	nzMvXww6SCv/DK0J8H+GYECXAuYgKbEYDRVZJQpH5kaIF4DKYWHJVmT6JCZD66T9miJS1++GEVH
	VV5dyVXtA1sLMX6+bvSRg6c8UeDyl/pwhj0VJv+/kC8sf1XHMy/i2lcCry0bkFXjFZNmkn7q131
	oMJQJv9mkQNHOM5V80C1lPjuJ
X-Google-Smtp-Source: AGHT+IG7cPaOeHJaw4nzTsOoqXCEb0oIWzbRfRrSSonV0R9ILuLenBjr8+8wyIjXcW5WGSY/L+ay/A==
X-Received: by 2002:a05:6512:3c88:b0:553:3314:adcf with SMTP id 2adb3069b0e04-5539d3b3934mr1079786e87.5.1749656711983;
        Wed, 11 Jun 2025 08:45:11 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55379b2c854sm1589444e87.142.2025.06.11.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:45:11 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] nfsd: Use correct error code when decoding extents
Date: Wed, 11 Jun 2025 18:44:26 +0300
Message-ID: <20250611154445.12214-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update error codes in the block layout driver decoding functions to match
the core nfsd code. NFS4ERR_EINVAL means that the server was able to decode
the request, but the decoded values are invalid. Use NFS4ERR_BADXDR instead
to indicate a decoding error.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayoutxdr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index ce78f74715ee..66f75ee70db3 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -121,19 +121,19 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 	len -= sizeof(u32);
 	if (len % PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array invalid: %u\n", __func__, len);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
 	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, nr_iomaps);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
@@ -181,7 +181,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nr_iomaps;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return -NFS4ERR_BADXDR;
 }
 
 int
@@ -193,7 +193,7 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
@@ -201,7 +201,7 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, expected);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
@@ -232,5 +232,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nr_iomaps;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return -NFS4ERR_BADXDR;
 }
-- 
2.43.0


