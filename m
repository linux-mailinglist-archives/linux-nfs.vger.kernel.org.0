Return-Path: <linux-nfs+bounces-12397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87AAD7DB0
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 23:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AA81891BEB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BD22F177;
	Thu, 12 Jun 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE5H4xbI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BB79E1;
	Thu, 12 Jun 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764604; cv=none; b=iX+DBXZ80WSsrYEIXtPLHBR1Sj9nXSDPnRZkrsnopi2kjyNSnYgCefN4+EsJ5XmG2ZQtEG388/brEgt/ePY6VlkNguYjHRtP+ZqwVAxDjjreFNGBu7UQPNy77WuaJd5hGA0bAeeo5I13X1zyPlQwHiRZ6vcVN+wv/1W6qqksxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764604; c=relaxed/simple;
	bh=p33m3E3cKoTgqwe0eGO0wIR/NLLZAKnQ2C+i2252anA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uY0LE+gmCHLc4O7lLP2/y40QK2vJNJgolrPVbgT+ca+1SBTpgWpCBN/rQv6yWohJ0UiIGsTeBr13YXSFRjDOgGa3RFcpb5kE4bvlW/LgpE5A/9M5tEs+GDwb/LPY6V0vXrhcFffT8P3581egb2Ud3cYLGaUeo8UkX2KmtaU9RlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE5H4xbI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55365c63fa5so1255135e87.1;
        Thu, 12 Jun 2025 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764600; x=1750369400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEWzg4Rut5bf/yTovcaRoJHduEB/xJB76yd6WDJanMo=;
        b=DE5H4xbIIzbnZMezG1kiVCrOtPCttwEWpEccOBFzqctUwqZn51T4uOXE1At02RN5j6
         pWm2R7Ywz1GpLSCjeW8B+vBOBBTgU/cONShz7pdmawEolufF/DHNlt43usadINjj4+V3
         5v74nO4gRxSU4/nfcVXmaGjZDgeQgaCQy2OLHnlDGXEBVufeTb+g4NLYAM6fgBX0o6A4
         DL5MgwH4i4tHDzZX7ZA22LT3hdzEG7aGbEztmkmIAsC89sd7iaW80eMuQL+WXywe0I2V
         EG3s9mHe9JN0MTnDkS8pOA7wie+JZc0hjdqxxKHPdaHDnEJYkzXZCnavqUdTxfyojevf
         BQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764600; x=1750369400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEWzg4Rut5bf/yTovcaRoJHduEB/xJB76yd6WDJanMo=;
        b=djg6txEhpOGBc0hth31yC8rzCefN2oFlTBEkSHQvRFxsl+TBRMftzwDsBR1wxLD+R+
         FOC6wojWRzlOThRAsK2rUfeAgPvT47zDDL0ofquL92dABpJJvVT3imUcL+W/uifWte9O
         ncsE8CjNdn+IrKktw7/MBHxBPty1pC+TpA+HktRx2+R35acGm8hNi5zQKcCVPIMok6uI
         ZFttwc9TDnG6+1PcEFbO+sShD6/JVKw+RtM0bASm/INl7jzNTy/Z+9p0djtOZtIB4bHO
         LhDCr3athbJ1QDo++PO4LtITlf1ZXikpUcXYJUcfyGhN0G68yV2LEZJzmjAY6z5IShr8
         ntbg==
X-Forwarded-Encrypted: i=1; AJvYcCXzR0r1/7fp2XxW9YCOpP7kJI2svR5xN88sWs+NhlBwJu93iAXVAa9/KOsyqvRHp1RPVsOEWMdbwj7B5bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+a7XksJeHbxd0yXxOhOpJf6HZvuVWX3RFY5bUWOxyrdUd8gaT
	QYj6+KcCkiv5jaPCrvO/B9hocZJsioAxQeJ0XVKn3+Gg9xp8OgNk6Gww
X-Gm-Gg: ASbGncs5ksoMPe6f+t8aKgrdPhgVwX0XRWPIrTmxQUUrqxmFwRiWeQpbICBuI+Ciaph
	LESozwUgfyYJoUS7xbW5T5hLrHHQ/h4i9TTlK7a/O8WVPW0nh0W8LefDKf7oV9x4bwea+K3+ke6
	y1+599LhnmpKXtAlYBZq10JhJnPiMN/mHOMda0HKQHcaWg3q/KVrBK17/HLyHppyw60NQrPeTWf
	hWequNSfXtHDIwD0kebyIpnrEpt/cyXr6Zl+t0IEiwSHf5pzQfJbGHiTRn5O7koy3NcIs7UWXoH
	QhY3GLABqltYpV36x0ayq+fSonnt30IJZ5/E1anh460Q/EObnddRmWLucZsFM/SYyr8JanCUfrp
	A5vqidIwSJZTQ
X-Google-Smtp-Source: AGHT+IFWH8RiieHbgsmFZAD7atmeam6vayBGNyDMY8+PUHvXu0NqGXEHE+OngqMpTMJ86irE8ezQcA==
X-Received: by 2002:a05:6512:4004:b0:553:2874:8ef5 with SMTP id 2adb3069b0e04-553af941b23mr190814e87.16.1749764600183;
        Thu, 12 Jun 2025 14:43:20 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.250.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f7951sm228972e87.227.2025.06.12.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:43:19 -0700 (PDT)
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
Subject: [PATCH v3] nfsd: Use correct error code when decoding extents
Date: Fri, 13 Jun 2025 00:42:49 +0300
Message-ID: <20250612214303.35782-1-sergeybashirov@gmail.com>
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
Changes in v3:
 - Add nfserr_delay define
 - Return number of iomaps and nfserror as separate values

 fs/nfsd/blocklayout.c    | 20 ++++++-----
 fs/nfsd/blocklayoutxdr.c | 71 +++++++++++++++++++++++++++++++---------
 fs/nfsd/blocklayoutxdr.h |  8 ++---
 fs/nfsd/nfsd.h           |  1 +
 4 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 08a20e5bcf7f..19078a043e85 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -178,11 +178,13 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
+	__be32 nfserr;
 
-	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
-	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
+			lcp->lc_up_len, &iomaps, &nr_iomaps,
+			i_blocksize(inode));
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
@@ -316,11 +318,13 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
+	__be32 nfserr;
 
-	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
-	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
+			lcp->lc_up_len, &iomaps, &nr_iomaps,
+			i_blocksize(inode));
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index ce78f74715ee..669ff8e6e966 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -112,34 +112,54 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	return 0;
 }
 
-int
+/**
+ * nfsd4_block_decode_layoutupdate - decode the block layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded extent array
+ * @nr_iomapsp: pointer to store the number of extents
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the block layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the file offset, storage offset and length of each extent are aligned
+ * by @block_size.
+ *
+ * Return values:
+ *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
+ *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_inval: An unaligned extent found
+ *   %nfserr_delay: Failed to allocate memory for @iomapp
+ */
+__be32
 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
 	u32 nr_iomaps, i;
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 	len -= sizeof(u32);
 	if (len % PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array invalid: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
 	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, nr_iomaps);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return nfserr_delay;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -178,22 +198,42 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	}
 
 	*iomapp = iomaps;
-	return nr_iomaps;
+	*nr_iomapsp = nr_iomaps;
+	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return nfserr_inval;
 }
 
-int
+/**
+ * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded extent array
+ * @nr_iomapsp: pointer to store the number of extents
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the scsi layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the offset and length of each extent are aligned by @block_size.
+ *
+ * Return values:
+ *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
+ *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_inval: An unaligned extent found
+ *   %nfserr_delay: Failed to allocate memory for @iomapp
+ */
+__be32
 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
 	u32 nr_iomaps, expected, i;
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
@@ -201,13 +241,13 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, expected);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return nfserr_delay;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -229,8 +269,9 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	}
 
 	*iomapp = iomaps;
-	return nr_iomaps;
+	*nr_iomapsp = nr_iomaps;
+	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return nfserr_inval;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 4e28ac8f1127..15b3569f3d9a 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
-int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
+__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
+		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
+__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
+		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1bfd0b4e9af7..3ffd2cac10ad 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -283,6 +283,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
 #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
+#define nfserr_delay			cpu_to_be32(NFS4ERR_DELAY)
 #define nfserr_badiomode		cpu_to_be32(NFS4ERR_BADIOMODE)
 #define nfserr_badlayout		cpu_to_be32(NFS4ERR_BADLAYOUT)
 #define nfserr_bad_session_digest	cpu_to_be32(NFS4ERR_BAD_SESSION_DIGEST)
-- 
2.43.0


