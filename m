Return-Path: <linux-nfs+bounces-12335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88744AD606C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 22:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D7817246A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAA2367A6;
	Wed, 11 Jun 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aogdzj6e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B674223338;
	Wed, 11 Jun 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675332; cv=none; b=ntvjUq7HIW8sRV/D9wOyhFJsg3uzWAdWkSy+R/8hjNKkBMPMsn9hba+Nm9lz561jXJ/fz55H2V+RoCbCDHePMRYcTqZ1Wl7zphtC0EpS4nmHo90YXmOLytRqjALFua4q9u3lrfuiaNUfHPBbkrqIZqenzvTKgseVcQQAu4mDV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675332; c=relaxed/simple;
	bh=hnp/kJEXjusD8DYduTGUIAnvDTf4MgPP0RhgmbzD1iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYm54LEU+NnScnRQEkVom035u6FNtFESUfiRH18TlDIyWhZsYSYLoINFwYH7biKVmjOWz8EJ6oFxzgzvAfk7pmi7ZSPj4NMUQkFruvI3Im39L7Cnw2TQAZ9nT8epnrYvadlsyG4iBRoT3+bB3PfjzftTkBC98DBn9Pg+Z/6cmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aogdzj6e; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5534edc646dso218989e87.1;
        Wed, 11 Jun 2025 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675328; x=1750280128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvzW0vZPIz8QN8BU0BtSA+GIuXmGeBjyf+f83L+wAUU=;
        b=aogdzj6eKlhIVc43gajnNQMq3YPhs0U2nRlJ6nR2Vb2wAfM1KhuZoAwA49aCMzNCaF
         xulGkvLfRF38ie7/RSRQyGBUSNSMa9a+0m+oIaC23eMKsLoIjT7wzSpEniTCzPFX/HnV
         D6w4/J07Iq+uF89KJ9VQ+ZQLOEF1l9xkHhKwNefOAuuUBRkDsA37CkIJJL/1i7HjJbse
         frHK8vob1Gk0FgIPOFUwbrcsJMeJ4AUIErFDSLBfbw8RoYypwoeQzHf7KNaTSr1w0/VX
         yq7IaGhNRh6RtDdgMD448pgQW2/H+7f9oY/YauX80nyApEe3rEb72velna3MuM1CS77/
         NGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675328; x=1750280128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvzW0vZPIz8QN8BU0BtSA+GIuXmGeBjyf+f83L+wAUU=;
        b=TXMi8zpSojBRh5Yh2bjXieeRuzv7xZqn8CCxl9AOJNa3wqrZMcyOskAVbBzxcB1gy7
         2ZlIT4ju8q9dJ1njA+rlKiQeQFNhFLYwF5lGB1XjabeSbcC1RQPAh49tr0Hz93armDoI
         UfxxFSdnm1R/tZF7cIyjSijtr4cGPvpuaeuo91d74Jy51OQ1NdvIexFQf9GiELKsZfe0
         cSSccoFv9bGivbOQmy9/FL/d0hIWBZXZb+V2BeMS1T94zi+UzpAWlUamEk4Kb4SGz96v
         VHg4l4ncs6rikYk5F6p1/SJ65I2sV+q2w9rfPcuFsQp1o4xNndhzHEPN8auHobLh8CqL
         FsuA==
X-Forwarded-Encrypted: i=1; AJvYcCVML91/TkCgKDgUEylcCU5mWfrSZbaM1CXxZAHSGEF1uoRlbFR7Kdn87jBVYL8HZVpofGPyLQVmUTg8Vic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx/z9+4IrTO3qa/clJQTczmFjzSwyALhekrKcn+n4V1iPtkGl
	51566A3OKBHRugLYyVopn02DFMRX47/00S2VVZWntdWERJRiGHizbQr2
X-Gm-Gg: ASbGncsreY5xKH/z0tydLGcKTtNLSkAFVK/UmJBMjbsGyFl2/3B8jT8bvyxsye3OosH
	qfvq1zW/nmSfg4k5wR5E4Bq0JyhZ3eNyKtwan+obZ45iN66Cd6thnrOXsTuGD9VPLlkcCwoEBQ6
	2JsqXdXuCfATbenczhTehRJ9mtbYMT/sGQW0XykV8TAWrmqJqIyqbitND2T27u0mPAAyruLk+tp
	dP9GyWwynMKy2vHfCDclF33Bac0J3sDM3ErufnJ7UfufWadIEmDxI7lJZZfcW0j7WN3DV5PDC8a
	Za+ahuB93zAP8eMaFjUUUVjDKAuIuogsaspeiib3JsJaYS4TH9r402PYDutfX0iuL3wp23gI+AE
	QHujy4h3fX5q4Bw==
X-Google-Smtp-Source: AGHT+IEX5dhbiwT2xbEijpR3MNNcGjWDYXY5XYr3BkUWT5Z44gzf/U4zOKhxAx7l6AjupPvF5UBKeQ==
X-Received: by 2002:a05:6512:12c3:b0:553:2bb2:789c with SMTP id 2adb3069b0e04-553a55659d3mr220103e87.37.1749675328098;
        Wed, 11 Jun 2025 13:55:28 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553a702afcesm5539e87.231.2025.06.11.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:55:27 -0700 (PDT)
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
Subject: [PATCH v2] nfsd: Use correct error code when decoding extents
Date: Wed, 11 Jun 2025 23:55:02 +0300
Message-ID: <20250611205504.19276-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update error codes in decoding functions of block and scsi layout
drivers to match the core nfsd code. NFS4ERR_EINVAL means that the
server was able to decode the request, but the decoded values are
invalid. Use NFS4ERR_BADXDR instead to indicate a decoding error.
And ENOMEM is changed to nfs code NFS4ERR_DELAY.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Add kdoc comments
 - Add return code handling to blocklayout.c

 fs/nfsd/blocklayout.c    |  4 +--
 fs/nfsd/blocklayoutxdr.c | 55 +++++++++++++++++++++++++++++++++-------
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 08a20e5bcf7f..c3491edb0302 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -182,7 +182,7 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
 	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
 			lcp->lc_up_len, &iomaps, i_blocksize(inode));
 	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+		return cpu_to_be32(-nr_iomaps);
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
@@ -320,7 +320,7 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
 			lcp->lc_up_len, &iomaps, i_blocksize(inode));
 	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+		return cpu_to_be32(-nr_iomaps);
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index ce78f74715ee..cb95c5201c1f 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -112,6 +112,25 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	return 0;
 }
 
+/**
+ * nfsd4_block_decode_layoutupdate - decode the block layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded array
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the block layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the file offset, storage offset and length of each extent are aligned
+ * by @block_size.
+ *
+ * Return: The number of extents contained in @iomapp on success,
+ * otherwise one of the following negative NFS error codes:
+ *   %-NFS4ERR_BADXDR: The encoded array in @p was invalid.
+ *   %-NFS4ERR_INVAL: An unaligned extent found.
+ *   %-NFS4ERR_DELAY: Failed to allocate memory for @iomapp.
+ */
 int
 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 		u32 block_size)
@@ -121,25 +140,25 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
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
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return -NFS4ERR_DELAY;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -181,9 +200,27 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nr_iomaps;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return -NFS4ERR_INVAL;
 }
 
+/**
+ * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded array
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the scsi layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the offset and length of each extent are aligned by @block_size.
+ *
+ * Return: The number of extents contained in @iomapp on success,
+ * otherwise one of the following negative NFS error codes:
+ *   %-NFS4ERR_BADXDR: The encoded array in @p was invalid.
+ *   %-NFS4ERR_INVAL: An unaligned extent found.
+ *   %-NFS4ERR_DELAY: Failed to allocate memory for @iomapp.
+ */
 int
 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 		u32 block_size)
@@ -193,7 +230,7 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
@@ -201,13 +238,13 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, expected);
-		return -EINVAL;
+		return -NFS4ERR_BADXDR;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return -NFS4ERR_DELAY;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -232,5 +269,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nr_iomaps;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return -NFS4ERR_INVAL;
 }
-- 
2.43.0


