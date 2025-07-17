Return-Path: <linux-nfs+bounces-13135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B031B0952C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 21:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428E64E8423
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAF2063F3;
	Thu, 17 Jul 2025 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeulW/sC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178601E1A3B;
	Thu, 17 Jul 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781729; cv=none; b=EIe+dTYWr5FLsJN5w12PJcp4C4JTBL9Nyr6zLatRzsMU/AtuAouBcBlY9Imws3BzqeeJCnvPj5pMJ7Vv+WTzhN0V1VFOJt/M//l4FJWect4/cYT1H5PhWdfTUVcRmz9/UxAh/cu7uRCPxTjrmP6p2LLp+Fq4IGPicjqNynXN1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781729; c=relaxed/simple;
	bh=XLfo9xdgqPqfrUjggEb+xsrTARAiYj5fc2yaDrRMzMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzrmZprANjTRPzSy9KgD/aA7sAqU1Lp11rIbc8NYlCKQQPC2+gDP2RWIpFCjdZpFhyvgOoT5uqKBemUQLfn4fSQDcmtNP+uFNdcu0M/PoHuXPcpirx3q9jdPn+YmuWjjL5E/6va9TalYSg20inSrDg4rMWmP2C0mRZRHM4aOa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeulW/sC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so2971434e87.1;
        Thu, 17 Jul 2025 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752781726; x=1753386526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxIH2istwBc0yjJeSPBbwOZzsTZZG6vXiWymLFKx7a8=;
        b=NeulW/sCqiLLmCSINWqE7Lp+ee55lU8+U6HJb+DbDG8ZpQinwMaLJE7z+VQ9AM3ZM+
         3gIIPIiQnidZK3odVNb5F+kfJpjqb7Uk/aCJYOtRaPrdnz8+duHQmq+GdtHjSZHhC+5t
         eKZf0rY81NrV6VrOO56GXAgxT9D1qe0dOrvLf8xvOxINXeNSXRKUySJZ6mFgnW9wooQA
         lrCuBKzcgDc/IkLp/SJj4kLSEG9obs0zRrhFLnVhwJJmp2+Npwr61OKvKOoOugfa19k/
         yDqCZZLXzTVN0FdqQ7cEL8GUByOq9scey2jpT45vvXS+A2SgTTDt+ZK5mtsjl0ozg92i
         /DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752781726; x=1753386526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxIH2istwBc0yjJeSPBbwOZzsTZZG6vXiWymLFKx7a8=;
        b=W3/l9qrCI067IO9MPmwBY8gTbJ7j2zg3uBbG2jWaH3jKhGdPOtFrR53uuh+mE1r2ok
         O0/u00QRHFBxC+BEql3xsQDUk4BIV917edSxr58sNObBqh1HgS+9oVmSHeEZHAJkJN32
         PfTBUDx7CJKUbLpfgP5JdRtbFjrMBKHS9T4QEoS+ETCEnyIpqUgmf1W4lf5H1kdSq39f
         jOpwyJPB7FyidLLv7J/G7fpPkXvSfSS+4dukNrBp1Yy2pkoin3/vN0rH+IWQif5tithw
         kLhc7UO84Btc2/4HACoZAdbXILd6vbNvSz85Q6bDB4egY1eQY+PO99MOaIRekXll2D4O
         wtxA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ohCXuJHqmnC2z7BXPhLpIrrcsqy/dtOC7h9VXEjk7ks4tzbkwEXmbFXPGGufHFOfvjguJA46uPgAc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJpCVkauMK3Mzqj3v+cqp4HiTO1Jeiy2m4p1hyG4UyDxPgkOd
	6EdYvnuUvdCb0/TV29IgHu3LQi/uPyS2+ERqtCYCxkmxSPQXyA2X2dlP
X-Gm-Gg: ASbGncsbDni55mphtVAkqKBNBdaDW9NR5x+Kqap/RI9inQQrkfoKjbRl/5w/QdwAp3V
	OqF9NlK3wmcEAvL3odg3YqME9AlhZUfSfu6oKOWdyYV4DukYvldELE15WtOSmWqfGoDwcMca+bs
	TJzS/eqhlnJi8ZSEKcqbnIGszuAFAWBOmOyUj1FHi8goWA7vkKO3vG2g5ferLUgmD/lsjTSvUuv
	4k9+IdfHOBfVxNfxeQQEU7M9WYHaTGly3HvyYZdXpBph/9iTSTbVDhHclTZRryZ64QOOydtATIw
	hBEp2jHdO/NNV4EP41W2DcTPVu50/8vnohdz0b+l8uz0AYLCgloAtBerLwfVc+btAGjOZGcMito
	hVTyuoOgEHq/7tiUAAVjQNDNBnaoj9sqN1N/ZQ0Nhoyv+qc+5
X-Google-Smtp-Source: AGHT+IHEE8YU7MMAeIpbO0PdFHBqnLtdvUSUbQI0pcI0qikEsTL42zOwGOZxuMZgv+QU4kbpDAxiOg==
X-Received: by 2002:a05:6512:1317:b0:553:2375:c6e8 with SMTP id 2adb3069b0e04-55a28c92697mr1489576e87.1.1752781725677;
        Thu, 17 Jul 2025 12:48:45 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7ea9e4sm3135635e87.73.2025.07.17.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:48:45 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] NFSD: Change ret code of xdr_stream_decode_opaque_fixed
Date: Thu, 17 Jul 2025 22:48:30 +0300
Message-ID: <20250717194838.69200-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the XDR field is fixed in size, the caller already knows how many
bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
both return zero on success.

This patch also simplifies the error checking to avoid potential integer
promotion issues.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayoutxdr.c                                      | 2 +-
 include/linux/nfs_xdr.h                                       | 2 +-
 include/linux/sunrpc/xdr.h                                    | 4 ++--
 .../xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2 | 2 +-
 .../xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2  | 2 +-
 .../xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 266b2737882e1..2a4dcb428d823 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -157,7 +157,7 @@ nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 
 		ret = xdr_stream_decode_opaque_fixed(xdr,
 				&bex.vol_id, sizeof(bex.vol_id));
-		if (ret < sizeof(bex.vol_id)) {
+		if (ret) {
 			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 67f6632f723b4..dd80163e0140c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1863,7 +1863,7 @@ static inline int decode_opaque_fixed(struct xdr_stream *xdr,
 				      void *buf, size_t len)
 {
 	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
+	if (unlikely(ret))
 		return -EIO;
 	return 0;
 }
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index e3358c630ba18..ffb699a02b17d 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -730,7 +730,7 @@ xdr_stream_decode_u64(struct xdr_stream *xdr, __u64 *ptr)
  * @len: size of buffer pointed to by @ptr
  *
  * Return values:
- *   On success, returns size of object stored in @ptr
+ *   %0 on success
  *   %-EBADMSG on XDR buffer overflow
  */
 static inline ssize_t
@@ -741,7 +741,7 @@ xdr_stream_decode_opaque_fixed(struct xdr_stream *xdr, void *ptr, size_t len)
 	if (unlikely(!p))
 		return -EBADMSG;
 	xdr_decode_opaque_fixed(p, ptr, len);
-	return len;
+	return 0;
 }
 
 /**
diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
index b4695ece1884b..ea9295f91aecc 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
@@ -2,5 +2,5 @@
 {% if annotate %}
 	/* member {{ name }} (fixed-length opaque) */
 {% endif %}
-	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) != 0)
 		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
index b4695ece1884b..ea9295f91aecc 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
@@ -2,5 +2,5 @@
 {% if annotate %}
 	/* member {{ name }} (fixed-length opaque) */
 {% endif %}
-	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) != 0)
 		return false;
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
index 8b4ff08c49e5e..bdc7bd24ffb13 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
@@ -13,5 +13,5 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
 {% if annotate %}
 	/* (fixed-length opaque) */
 {% endif %}
-	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) >= 0;
+	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) == 0;
 };
-- 
2.43.0


