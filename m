Return-Path: <linux-nfs+bounces-13161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38708B0C6EC
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297C93B1826
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DA2D3725;
	Mon, 21 Jul 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wiaj7mTd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47572D63F3;
	Mon, 21 Jul 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109545; cv=none; b=W7O/l8dD4EI4HeNRPhEKIUL502Ee9n0ZPcld86G0J6XjViYPTByVsvFXK8gYCU0RFl27MfrTCKSbk5hKFB2R+lt0zFYen3lALYDzQF2Y25lcJzSCSIqkKUNOwFFB0WtDS40LKUhwJ4fbMy6iTUFSdsxctb+FUHUKZOU03VnJwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109545; c=relaxed/simple;
	bh=iyqjDj45FHzKPDe29reOIdDLLuaVrUYOzWmSyD/0Grw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LY0fYHKElUTRsy27RNPhodzykAii6cSGRHzqlGBK3ilnOYaDvIBTla83iWagF95hHfYuXoBeSkRJ4g00Zs0Ij77dWuKLOWb+tLB3Tt4pNBEhJujBw4uDJBa/Els+F2WxZ2AefvVlWs2dbDFnsoHHd++wS+xzyMeTnRrZSkJU5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wiaj7mTd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54b10594812so4316521e87.1;
        Mon, 21 Jul 2025 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753109542; x=1753714342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4JKTvsSyWeh3Xi7pSkUxMxZWl6P3uoFs0eZVsH4tRE=;
        b=Wiaj7mTdbt7rYsY3ZfEfNiVVDiItx0ovMsn8Cxs3qmuOb1E1hEzgE4BcDbOHHx+eGL
         Busq63MqN4qq/4Vt2vK82sQfzdEEjQ68wR3+mu9/p0I0hXDrApERuqt25nepSaamjBHN
         FaShNbOQTDYjAf6hiEXR4QvE3Z1Nq1i6kr95Bdsy1zoEZ96ZHvwGTbNt1LWUTLjoeSqB
         sgJPLf1xgX0hWQSbJNI73UvhdjP8mXMQ8P//S6sA9OwTt/i7bYYJ/Pe/5byGJAN1b4yi
         07+kAWX8o9ALJ+BUTWTxZdCP7U7q3lF2HhIVCQMkfLNuwxfE1uth8qh2WkOAIv8VKnQi
         ovYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109542; x=1753714342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4JKTvsSyWeh3Xi7pSkUxMxZWl6P3uoFs0eZVsH4tRE=;
        b=uMCkZTb8xjVE/Jw4oeEqLCuV7RjhQI422Z+pKP/ALQq8CFPc4pY+q5lx2T1gS2GgdX
         AaCkfY9ij8CUGbfylU6IKUoulhpq3e1yGFNNzqmY1+RLpTRyF1GHwW1Yommp5rnTtfKX
         q+ncemu3O4p96VqyHSf1SDB2tQTiehxYm9Il3Mb9TBIzMHdV/NojigCr54iuRfROU75P
         5aOLIUmxlyQVSjvgaP4ofXgLOrMJXxZQsQQmwMy349a00soeAYZNw/5FCeo6eP0FP7G/
         y3LcrodRIQMnq6VBgVa2psshnb1CHNhYU+uxt23Z+eOzQnCPB5NLLE3ADBsUeT68Rdsf
         gTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVdiHnbvgrMmx1ni2QhVYuGifSw4+xsq9td89qzMtz/htlOVWOi0GrIAv5+w72N11hmIpxDdOKsE7X1ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9GlNXDPCNmJMaSxTDqX6UL7j985TafAptR5fH2j7BPbct5ms
	IbMm0ZA4ZENWmXD6pY7GetgObicOIU6lxz4kX2FYwXJyfHWfDCK5OSa3
X-Gm-Gg: ASbGncuCqhWaKYQKQR1lEO43i+A0/GPV8ysWY3eiCTCQNa5IBa/GLuyf0MRDTyH4YKb
	6P2i60apif/u1b4Q54i/RitbsVRnIcFPSkjNchdctvOlwK+4zpADGtavV6Tfo+d/k06BePLQ97C
	E/GHWONupM+Q3nisHGJU9VIVIHx/4mvF8EKXp7keQCc4a7HLASq/UizDosHkGk0QLqDJhavPS0n
	qvJlQ5u/7SADzylgdQMg3gIJyFRji5c4UO97WrVun/8fYzlaZUPykd1JXWyTMLLv2FVmP6u+yYs
	u9v4a6Ilc4ChhFcmLxoCRDD36P+OpIpx9RWSttxOy8Lgwtll7i74xISva2UCbKHvWjh8i3NQaai
	K8oTqIw7pYtwyu8wti7HzFW/L/zfpCtTbmup4nHQ3kbJevw4t
X-Google-Smtp-Source: AGHT+IHp5tMrzbaw57CWCVYB0RoV0tEqsl85F1RSOYA13WIAtZmdCi0B3fYi5Do/od4mZYTslqfiMA==
X-Received: by 2002:a05:6512:b99:b0:554:f76a:baba with SMTP id 2adb3069b0e04-55a23ee1deamr6945660e87.3.1753109541472;
        Mon, 21 Jul 2025 07:52:21 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9110bsm1587515e87.154.2025.07.21.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:52:21 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
Date: Mon, 21 Jul 2025 17:48:55 +0300
Message-ID: <20250721145215.132666-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilers may optimize the layout of C structures, so we should not rely
on sizeof struct and memcpy to encode and decode XDR structures. The byte
order of the fields should also be taken into account.

This patch adds the correct functions to handle the deviceid4 structure
and removes the pad field, which is currently not used by NFSD, from the
runtime state. The server's byte order is preserved because the deviceid4
blob on the wire is only used as a cookie by the client.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Tested on the block layout setup, checked with smatch.

Changes in v2:
 - Renamed new functions
 - Removed byte swap operations
 - Updated code comment and patch description

 fs/nfsd/blocklayoutxdr.c    |  7 ++-----
 fs/nfsd/flexfilelayoutxdr.c |  3 +--
 fs/nfsd/nfs4layouts.c       |  1 -
 fs/nfsd/nfs4xdr.c           | 14 +-------------
 fs/nfsd/xdr4.h              | 36 +++++++++++++++++++++++++++++++++++-
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index bcf21fde91207..18de37ff28916 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -156,9 +155,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
-
+		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
 			goto fail;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index aeb71c10ff1b9..f9f7e38cba13f 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &fl->deviceid);
 
 	*p++ = cpu_to_be32(1);			/* efficiency */
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index aea905fcaf87a..683bd1130afe2 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea91bad4eee2c..2acc9abee668f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -587,18 +587,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static __be32
-nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_deviceid *devid)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
-	if (!p)
-		return nfserr_bad_xdr;
-	memcpy(devid, p, sizeof(*devid));
-	return nfs_ok;
-}
 
 static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
@@ -1783,7 +1771,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a23bc56051caf..e65b552bf5f5a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -595,9 +595,43 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	*q = (__force __be64)devid->fsid_idx;
+	p += 2;
+	*p++ = (__force __be32)devid->generation;
+	*p++ = xdr_zero;
+	return p;
+}
+
+static inline __be32 *
+svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	devid->fsid_idx = (__force u64)(*q);
+	p += 2;
+	devid->generation = (__force u32)(*p++);
+	p++; /* NFSD does not use the remaining octets */
+	return p;
+}
+
+static inline __be32
+nfsd4_decode_deviceid4(struct xdr_stream *xdr, struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	svcxdr_decode_deviceid4(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
-- 
2.43.0


