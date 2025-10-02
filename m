Return-Path: <linux-nfs+bounces-14920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C81FBB5213
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480A4482B56
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DA2BDC34;
	Thu,  2 Oct 2025 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfhsP7Vz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D029BDBC
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437100; cv=none; b=k2WNTfby1kS1O5Qbn9oZCqlrM5zz+FODKTNeUg9Mr3NT6taK1BZboe0wbFjybQHREv7JcK7pkFEFnYRgC6i139lU3VBLkG+qNHs/2+0DjWykZF2t2/iv9q8jk9kqGO2htQGEXZf332yPAHD2g3ecl4QwlkQDLMxDdzHF0jGanFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437100; c=relaxed/simple;
	bh=Xz/6eqYYcI2AeHdk/uSMvcnM84/4fheOZAIWCeZxUfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOykAmtd/nlEYCVG2qdVeQ0Yi9q6Jh0n3hDLNdJ/AbcQFPbwZ089mgGBl57hkDNYVLSvpwQbd3WnG05VekWK06HhTPQCqlC9Ch0WOlqEzMrCJuYXYGAWec9aLQ2d/p2LKfFRNSEzYIJk3Bn21pdEK4LKvuaRvUrVYB0IXqsBUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfhsP7Vz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1983682e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437097; x=1760041897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6mwD1k8tJtPn/oG49qeOmgMB45GcYhaofTWn8l5t9A=;
        b=hfhsP7VzIrcad/G4SP2x+lSEDvZr4ZGvgbDyfQoJsmNCygESjPFW8vS/haOVuc+UGK
         iNv6IDj9f9ZlawTFwsIkgR487iOs/0iOp3MLrd2nWagFsJWqUsCZrv2huOVvF27Rb6B6
         kEEpqkJf3KH5yQbNaC1/u2Ref/eIpls38Frdr8VxlAKc21P7i3j3lVltFxstyFWYanB7
         r6bDVyKctgXJ0gf7dtwxKWGYNY31VB8+CwwHH/YMxqQfdhgRRIUOEA7n1EHt4VRDUc+9
         FTK2qSs9SWSfXbePVwlX+QN5QYChMvqKdV8NXMGhBMmsg0cK0HExYyowVras8jO+TbbU
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437097; x=1760041897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6mwD1k8tJtPn/oG49qeOmgMB45GcYhaofTWn8l5t9A=;
        b=F6hr+q22Ql89QT2k/cZOygAL8az1DUMP1QU7jDsomHh5fsoJquE9Ff3pj0cjVz7hyQ
         qSbElBLbCGUrft1M62qT+WsnOy795QM4nbpA+iivOth3k0MZel7gq9tv+L1YwiRNMrTp
         ZsLsfvB38h+C+x59trSt5p5OzdfD8VQEQf1pIdKnvoIUb7YUxbq2jAX6uWAYq3+JN7F7
         P/pIC0U32C/aRb65aDGNM0qpL3MKllOGRFsXmYKqsKgpmwZO+I4ByOiQVBmVy5Oyupxd
         xgvM2MV1Bxb3AlKyiDAY2NY9pzcZdju8w/EGf1q9DMUyKHuVXHi+xDjD1Hjm77cDfHNH
         hRkg==
X-Gm-Message-State: AOJu0YwIn7xpKLFz+817Gk59541CnpwprV/r5Ql/MLt1MRAhc9dXjGC1
	84WyQM1fMCT8sRA1xkXpLNn3gbdsjEzbPCrdl4Q+nJybKlLIwf7b/kDuWevR4X33
X-Gm-Gg: ASbGnctgDlxrJnEiDIoMsz+IMqRTEianTxE4B3hCVntSR2DRMit4mhw+SKha4duDBOw
	Kn8tDMfpWlcqPzYkO3uja+vW+ja20KwJk/au3omkr/Zinnv9QBzp1JFbAabTM6XP9jacfAsay/1
	WfuXymvH6gqXmtGVmPiA2gFAQalA2c9535AuvVWmNy3sCjTzDSRERZEv96bUghIMIVbhxbASusX
	QKojkm98BC8IK7eFKXZj3H5in6WvuCy+S8B+yJRpvS09+gCFJ6/vBnjhEBzp+DOBL0nUxX5nJT8
	S0krryv8QTBsO0uwhwbEzHlVcVzbPZmzRetNOJwGXKsIPOqPRsZi2NxtuHJYa1Y26mrwuqz6Jlt
	Yh/+tatQM98cocEyfQd8IU3ZU+rvkYBSh3DwimHFfMX6TeEDuix/bFl7YDSyC+1rjHJXncEuZhH
	/WOSFE94NL4jc=
X-Google-Smtp-Source: AGHT+IENhMFofFuRpfmNhDfNDvAuH5eKkEts3QazVzdgUeI7rcIWdGPMuHSPpz9M6PfoWCIBMKvLsw==
X-Received: by 2002:a05:6512:2396:b0:55f:6f5b:8e65 with SMTP id 2adb3069b0e04-58cbb4416c2mr109330e87.30.1759437096449;
        Thu, 02 Oct 2025 13:31:36 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:35 -0700 (PDT)
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
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 4/4] NFSD/blocklayout: Support multiple extents per LAYOUTGET
Date: Thu,  2 Oct 2025 23:31:14 +0300
Message-ID: <20251002203121.182395-5-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002203121.182395-1-sergeybashirov@gmail.com>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the pNFS server to respond with multiple extents to a LAYOUTGET
request, thereby avoiding unnecessary load on the server and improving
performance for the client. The number of LAYOUTGET requests is
significantly reduced for various file access patterns, including
random and parallel writes.

Additionally, this change allows the client to request layouts with the
loga_minlength value greater than the minimum possible length of a single
extent in XFS. We use this functionality to fix a livelock in the client.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c | 47 +++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 6d29ea5e8623..101cccbee4a3 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -89,9 +89,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct pnfs_block_layout *bl;
-	struct pnfs_block_extent *bex;
-	u64 length;
-	u32 nr_extents_max = 1, block_size = i_blocksize(inode);
+	struct pnfs_block_extent *first_bex, *last_bex;
+	u64 offset = seg->offset, length = seg->length;
+	u32 i, nr_extents_max, block_size = i_blocksize(inode);
 	__be32 nfserr;
 
 	if (locks_in_grace(SVC_NET(rqstp)))
@@ -118,6 +118,13 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 				PNFS_BLOCK_EXTENT_SIZE)
 		goto out_error;
 
+	/*
+	 * Limit the maximum layout size to avoid allocating
+	 * a large buffer on the server for each layout request.
+	 */
+	nr_extents_max = (min(args->lg_maxcount, PAGE_SIZE) -
+			  PNFS_BLOCK_LAYOUT4_SIZE) / PNFS_BLOCK_EXTENT_SIZE;
+
 	/*
 	 * Some clients barf on non-zero block numbers for NONE or INVALID
 	 * layouts, so make sure to zero the whole structure.
@@ -129,23 +136,37 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	bl->nr_extents = nr_extents_max;
 	args->lg_content = bl;
 
-	bex = &bl->extents[0];
-	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
-			seg->iomode, args->lg_minlength, bex);
-	if (nfserr != nfs_ok)
-		goto out_error;
+	for (i = 0; i < bl->nr_extents; i++) {
+		struct pnfs_block_extent *bex = bl->extents + i;
+		u64 bex_length;
+
+		nfserr = nfsd4_block_map_extent(inode, fhp, offset, length,
+				seg->iomode, args->lg_minlength, bex);
+		if (nfserr != nfs_ok)
+			goto out_error;
+
+		bex_length = bex->len - (offset - bex->foff);
+		if (bex_length >= length) {
+			bl->nr_extents = i + 1;
+			break;
+		}
+
+		offset = bex->foff + bex->len;
+		length -= bex_length;
+	}
+
+	first_bex = bl->extents;
+	last_bex = bl->extents + bl->nr_extents - 1;
 
 	nfserr = nfserr_layoutunavailable;
-	length = bex->foff + bex->len - seg->offset;
+	length = last_bex->foff + last_bex->len - seg->offset;
 	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_error;
 	}
 
-	seg->offset = bex->foff;
-	seg->length = bex->len;
-
-	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
+	seg->offset = first_bex->foff;
+	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
 	return nfs_ok;
 
 out_error:
-- 
2.43.0


