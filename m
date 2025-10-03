Return-Path: <linux-nfs+bounces-14949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC6EBB653E
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E423A7F42
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339DE28A73A;
	Fri,  3 Oct 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDNC8yhZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B5287518
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482685; cv=none; b=hDdw98bKgchvfJMb3GJD3DX8YStADAeVXCklfiTXOOySaPplPR3npd49V1wbIXM/+fUQhK5Te0YduXShn+G1BaDCKwmacDsYLkfgKpJIvrztnLOeVvu4RX7y6NwvzOwLEFt9caZ0dUbCBIzOF1JOk0dkEvDrw1Ntk3i9GBqDIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482685; c=relaxed/simple;
	bh=5qgmGmYUOhVgTZvRetnu8/iMUpcsPIqnDj4z+RlR7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbeDk++CgEXGml5cZAJGOSgMt5kigHlubtgoCJ+C+s+IFqp7ocE5GqbQSGiEB09PJv/UFHb1J1JMV1AWWzQ6t/u6MDa6GX0szbPqXERQL2cc4b8bCST77rajlU3vZ9SQYBmPjFoVHsxoUF32kxtQr5n5GHGcEimbk5WBKHw6dMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDNC8yhZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33ca74c62acso17297031fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Oct 2025 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482681; x=1760087481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arnOv/Eb+ei+WprDdJ+AExiCBQfw52nTIK0kxgp5nQs=;
        b=VDNC8yhZ0euZu+Sakhfq1zPg2AzcbewP7Ea/L8hXjLnvodrUcHqpwmxsetxZ15OUvo
         KZBbTFBGS/XdVA8EmrsfPO5ml8g+pB+qDn/kqQg+P8ZJiO+zNHnMlXnh4k8L4d9PGPFu
         9Dqg2bsEG+ytT6E4tOT/w3WQreaIC70Xs+r9Hb7MdQ/uB0oRuzuJiedNEIpmUQALo2xg
         rme723sLziHkh1tDRnPOa6au8V0c1z8MylVjMln8rj5Q7HmJWwtrCUvLz/ytgzyLc3HO
         UEki9ZvSwBiYmh+FUqQEzlxDA8LV9m6PRuP+JoXZUWnzIBG0dnmBq7yfEcfa8wTUVuUl
         B2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482681; x=1760087481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arnOv/Eb+ei+WprDdJ+AExiCBQfw52nTIK0kxgp5nQs=;
        b=Juz18fy3Hj31XHjpnagDDU0cGbTVmEdaRhNvRsJrQifHhkx3yMiIbImDmYMp3ihsMx
         0FXlbW0aj8AX330UUTRuXgOJFLJ/rKLPGyq9Itf9ao8KnYtuaOYuI5tCAofe76TIwU08
         8uoFYlIXtx4fodWa6A/Te25CSaeMIwddIr/kEjd4wZ9As1WWntqDsQ470t8WhyO7Otio
         l+Edkq+NcYec9RPzxzB57DEDhb0/z7Q0Cag3j+LaXDRR8qdHJsb5uneEYgpKtztHNoIQ
         GFCrj4GcqFZHAeZ+s4JT26BRB2OijK2pol9akStPOfU2Zt+QJWVCJCwUuJmxkJWUyAHk
         zhTA==
X-Gm-Message-State: AOJu0YyyLvf70QQZnUnBkSspLPKj35RDht+Jpd0Ysg6qi7pJATTHOGb3
	2maF6zTXsxiz0kNauF/npfErq0iB5pxjFPDyfaF97lr3HlMQWP0u4j2g
X-Gm-Gg: ASbGncvtHZ6ym0cSC0GhLk8ylr6zmrvJvIRsK8TjKyY7GuaFcCWYHuQJWTqSfSctnLs
	Xc60kmjaCG3z6doDWDz0uyZs6FP9l1xg2UqHF+nl1Tmb5x99nM89PAqo2RiGNWg5h/ymm1WrIXk
	GB4rGtBqht1LH4evI7I2smBeTu4G3HAGFm/x4rMm1doJJMVKaaIqW5a6oA7EC5c9/YMK5IEC738
	5Tlrl84Pb3O5YN+lF9ntTjJQi1IEyTCkxsrwDO0Eolz6fgK6kqiluFenPjaoE5eOk5ih8ZLts0i
	Nj8VuW814AllFb3ghaKeBXk3+CNAY3VfMU2KhQ9ik4b3VSdSlLnR0I+LA88a/xOq8nnWlpnWRvx
	rpru6GOHiKtvrrBNHIIFXE3zouIjtSBuTyY5LimmeGs+fuCzxmWYrMiStnaLhX5/GKJ+tmsazT1
	AX
X-Google-Smtp-Source: AGHT+IE0aTdUm34GWxVWeIcSrnaWArAnE74mpIbehfqtmMHNBlov2Lov3oNlbPMqnpOMOxtDIGa47g==
X-Received: by 2002:a05:651c:1548:b0:372:9420:9509 with SMTP id 38308e7fff4ca-374c37001bdmr6162771fa.15.1759482681129;
        Fri, 03 Oct 2025 02:11:21 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:20 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] NFSD/blocklayout: Fix minlength check in proc_layoutget
Date: Fri,  3 Oct 2025 12:11:03 +0300
Message-ID: <20251003091115.184075-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003091115.184075-1-sergeybashirov@gmail.com>
References: <20251003091115.184075-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent returned by the file system may have a smaller offset than
the segment offset requested by the client. In this case, the minimum
segment length must be checked against the requested range. Otherwise,
the client may not be able to continue the read/write operation.

Fixes: 8650b8a05850 ("nfsd: pNFS block layout driver")
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..425648565ab2 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -23,6 +23,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
+	u64 length;
 	u32 block_size = i_blocksize(inode);
 	struct pnfs_block_extent *bex;
 	struct iomap iomap;
@@ -56,7 +57,8 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		goto out_error;
 	}
 
-	if (iomap.length < args->lg_minlength) {
+	length = iomap.offset + iomap.length - seg->offset;
+	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_layoutunavailable;
 	}
-- 
2.43.0


