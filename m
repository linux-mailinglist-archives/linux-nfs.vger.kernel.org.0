Return-Path: <linux-nfs+bounces-13159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A1B0AF9D
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430833BE6AC
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02D22256F;
	Sat, 19 Jul 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDHlqGiQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529A33086;
	Sat, 19 Jul 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752925058; cv=none; b=KWBZ+XtuabNIE110XL1bByZswIqqylJ8DwmIKLWfua3MUyrRLoqGzqi3QoHxOEjLwGqT6i9R1L/aay5enocVVktEn0YdkDToIWi/rjNte1DCPZ/NMrbXdUHmRqSzbFot/ggqTzeyYiLYgvUc1F76cVJS4QTXv7ilVa9w/5+ydSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752925058; c=relaxed/simple;
	bh=ZfMI25QHUZSwQG3NMh5F1DQkcrlpzfG2pIZc2YV5Ljk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wsk3okrvldUv9ipYyyInpcAN3e6ARI/v+8MxNZ4AbW+ApYQfLd5oURZOoyuw6T10ul+ErwfTv6kmJX7BpPmHOCSviSrEKh8YitR1QpNSoqqJLNFGFUtb4MaLbJnxqAyiPDjlX5iEVqj5O/LeQV6VNMWQcJ1QroCDGbqr16O7Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDHlqGiQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55511c3e203so2781958e87.3;
        Sat, 19 Jul 2025 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752925054; x=1753529854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ERF2Sk0XqRBkD3XsxUBB+tND9y8lq/D9RF87CJ77e8=;
        b=QDHlqGiQPeHVWFaWN0Q2rE9/X9ZJO2gvbZgnMLo/xZzKlE7z77r0ZOCK43AO7PT9BG
         frbE05Gr9kAjgY3xhy9sUhR7gnx4m65J6fMaXK+crXsU7iD3TI1JaC+wrxsaheklFta7
         HK1ZxbCx5q6lBmAkWwCI1EKiU/wxl2rWoqls5Yag8zUNCzUQf7U2QQcuympMJxtsM8HX
         5wYF5G3TlxYNsctCZ+Lq0f7qi5WiQC9IMlE3GgpPTc51uwZe3zOPx0pQuOiuXirNmHlL
         fLI9PI4yfJbOtHpiMnLK42f1JhcSytpLe48eQ4ZPG1iITvDlKWlpFXAkFkIGmEgxwk3g
         K/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752925054; x=1753529854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ERF2Sk0XqRBkD3XsxUBB+tND9y8lq/D9RF87CJ77e8=;
        b=iacU4nah0HTjRm615ARt+X/iQyqq92F/kn04GMorJWQwW7HgrHQ1QT15aLug6WRg9B
         naTkLb5OwhmQMIWVICGuZX+kbGXzC+QRnj2vvQji0Els+EXMbzB5ESUVIb9vUN73cblg
         2XwZXmgwBTAYN5SIbFOX13qlw16tvt/EtU7HM3u5TLFU+uTcPf2YNCLluVoP9QIaB/O0
         ufSGLlofI1Tpy0v2sFQx4YiRy9UnRQi0Cuch00HwuZN9BcCHX+VohDKuxocibbKGsKZk
         UjOT4qquYXTpYco8VtlmhpWNTw4BB0wTRMGzVMMvwOsqzsH081dhRaBYZeynOsJDfdye
         ++SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEDlWX4FRVC000vg/qh5h+1LAHQOkZ0Re/lL4X8VqRx3kGtpS+s58HP7pmTkm9OpFuYTVVB5hmkU0tyTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykoWnMtFOviiUaR7aL0gD0ajHYkf6ZXY6NJDWUKtsF3f/7aLp
	+0gwf4EbyBpxmtpn4jq3gjko/zhfhAun4Uwu8Iu3L/9NHFXzfjkq32oU
X-Gm-Gg: ASbGncvtWB8IQa3fwPH/3xbwPAUrXGSihnEmX5m3MtV3tAN1hXJGcXG6FWT5bU+YTOE
	8Ev+8ITi4tFjzrO6QWZHbysjJGYOSXvDz6yVdQiVr7qE1jWDD+qzDywU2KUUyiGcr633+d9BWwh
	nYyERdCmWDwf2U2+hST/3NQAa+iUdfi5scrZuv4nomd/lfYH7DAMW58CBxQSO4zPYTcdNPg2Gc0
	JnepHUUA0kmcuaqMJivJDTN5NYKWkF/Rrtz1Kh4iaPUNQU+EdUmOq1hvt588e+mDsz+OSUrSe5a
	iT2emqeRXs1YTfZnVmdheKoVxeAJu1nt1IV4tmyof5YYHBzD6yACOVsNGaZYh33VFoct0+vVMsM
	3jT6HC3M+eymMOZ34301DafxqLMq3WtTuGwjythMM2kwMD55WDKxd5+QTiYY=
X-Google-Smtp-Source: AGHT+IG+9LlUG1qH0+6z9tQS7rdjofP4KWefH0bcwJKwXf65VSUr8FfVIWj0L0dB7SeTD2mJ+9scWA==
X-Received: by 2002:a05:6512:1595:b0:553:2e0f:96c with SMTP id 2adb3069b0e04-55a23ef82dbmr3984293e87.23.1752925053876;
        Sat, 19 Jul 2025 04:37:33 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31dadf26sm672074e87.213.2025.07.19.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:37:33 -0700 (PDT)
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
Subject: [PATCH] NFSD: Rework encoding and decoding of nfsd4_deviceid
Date: Sat, 19 Jul 2025 14:37:28 +0300
Message-ID: <20250719113730.338129-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilers may optimize the layout of C structures, so we should not rely
on sizeof and memcpy to encode and decode XDR structures. The byte order
of the fields should also be taken into account. This patch adds the
correct functions to handle the nfsd4_deviceid structure and removes the
pad field, which is currently unused.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 Tested on the block layout setup, checked with smatch.

 fs/nfsd/blocklayoutxdr.c    |  7 ++-----
 fs/nfsd/flexfilelayoutxdr.c |  3 +--
 fs/nfsd/nfs4layouts.c       |  1 -
 fs/nfsd/nfs4xdr.c           | 14 +-------------
 fs/nfsd/xdr4.h              | 31 ++++++++++++++++++++++++++++++-
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index bcf21fde91207..9ff2a23470e61 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = nfsd4_encode_deviceid(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -156,9 +155,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
-
+		p = nfsd4_decode_deviceid(p, &bex.vol_id);
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
 			goto fail;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index aeb71c10ff1b9..28eb5bedb7e13 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = nfsd4_encode_deviceid(p, &fl->deviceid);
 
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
index ea91bad4eee2c..f3a089df164c6 100644
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
+	status = nfsd4_stream_decode_deviceid(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a23bc56051caf..ec70cb9c17788 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -595,9 +595,38 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+nfsd4_encode_deviceid(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	p = xdr_encode_hyper(p, devid->fsid_idx);
+	*p++ = cpu_to_be32(devid->generation);
+	*p++ = cpu_to_be32(0); /* pad field is currently unused */
+	return p;
+}
+
+static inline __be32 *
+nfsd4_decode_deviceid(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	p = xdr_decode_hyper(p, &devid->fsid_idx);
+	devid->generation = be32_to_cpup(p++);
+	p++; /* pad field is currently unused */
+	return p;
+}
+
+static inline __be32
+nfsd4_stream_decode_deviceid(struct xdr_stream *xdr,
+			     struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	nfsd4_decode_deviceid(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
-- 
2.43.0


