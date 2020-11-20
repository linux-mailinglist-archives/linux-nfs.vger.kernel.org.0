Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305F32BB76D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgKTUjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgKTUjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:24 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6EC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:23 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id l7so1818194qtp.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MU+l/To7ZiO+Ch0zE8OE45GD7x+7KlDKAeeFOnZT2+A=;
        b=pHXvI2bv0oY11y/gmkWXd6EuhDSxmfLHTu3oMh3xCAtb5yn5b/+wvzDuzapxaHPcqs
         YFNb5JjxU4Y8/CccHP3r2fbZ3bgh9Hk4TglYwvb3uuFWoDMcD13Mv7EYqlXjEVP6elfe
         ALN/l1W+CH46CG7C4xm7jgMHh/IaA3VHfYLQJH2Ui/DbdjjwURtX583+WLeoJD260pXB
         eUSw17ZZTEMQoBTdw8qbg1WI54BsbXut1ltpieQLJI6JwOHItGX8zY07eoUFMp0pCq3V
         0fXwGHLID1ckKndZZNR4wvcMsnYdxPkSkBWEOmU+CLtmuQCFwAzU1s+A9AQ6a9R2Da63
         /+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MU+l/To7ZiO+Ch0zE8OE45GD7x+7KlDKAeeFOnZT2+A=;
        b=rRxoa7JXHJ9A5NQKiLO6twccazbVTOZ6/87EBklkJk8NMoRZDlBdF+85zmaOd2fEXD
         qXYC3smRcdgV6m//bpQRio41437IhM+hMLKTAsm3astaTnji2ELnIy07Uur5wsDZulQb
         DCYN+lEpzOshz4j+x2o8slUIRQqWJvCJSRkBpF+wL0WpL/xAE2vKmC71pu4lqpsnemdg
         VKsDaviVXYJ6FpLF9vxS/GiDSW6z/Dhu7l2MYFaj5YHuNvLoObC6HcD165FsiF0HpxBx
         3PEGvkU1QXykFAnZc7mb8E4hmW5sI7m8gpJpg+owYo+qTDQ6Gv2/Cc+u7jXu/w1SbpcS
         zhiw==
X-Gm-Message-State: AOAM5326uqxPu/oPsGuS0GCZw61JJ1FDC5YOv+wrigqZMJuT0Ye3MSim
        9XGYttx9LftoHUuLyUdIlRjZ8vjs6nc=
X-Google-Smtp-Source: ABdhPJzWwSiLTEdycX/GEWHM8gD6c8aERF64CM3YuA84vcNMSBWAEOMvO2MSTTrFke6PywerTWw1eA==
X-Received: by 2002:ac8:490f:: with SMTP id e15mr17493970qtq.155.1605904762843;
        Fri, 20 Nov 2020 12:39:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q31sm2154282qtd.23.2020.11.20.12.39.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdL2n029392
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:21 GMT
Subject: [PATCH v2 063/118] NFSD: Replace READ* macros in
 nfsd4_decode_layoutcommit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:21 -0500
Message-ID: <160590476131.1340.13315793122233336452.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  119 +++++++++++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 04dfb578bec8..2c75e5d3b2f2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -272,20 +272,6 @@ nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
-{
-	DECODE_HEAD;
-
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &tv->tv_sec);
-	tv->tv_nsec = be32_to_cpup(p++);
-	if (tv->tv_nsec >= (u32)1000000000)
-		return nfserr_inval;
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
@@ -596,6 +582,29 @@ nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
 	memcpy(devid, p, sizeof(*devid));
 	return nfs_ok;
 }
+
+static __be32
+nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_layoutcommit *lcp)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
+		return nfserr_bad_xdr;
+	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
+		return nfserr_bad_xdr;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
+		return nfserr_bad_xdr;
+	if (lcp->lc_up_len > 0) {
+		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
+		if (!lcp->lc_up_layout)
+			return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32
@@ -1737,6 +1746,40 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
+					struct nfsd4_layoutcommit *lcp)
+{
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.length) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_bool(argp->xdr, &lcp->lc_reclaim) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_newoffset) < 0)
+		return nfserr_bad_xdr;
+	if (lcp->lc_newoffset) {
+		if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_last_wr) < 0)
+			return nfserr_bad_xdr;
+	} else
+		lcp->lc_last_wr = 0;
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT);
+	if (!p)
+		return nfserr_bad_xdr;
+	if (xdr_item_is_present(p)) {
+		status = nfsd4_decode_nfstime4(argp, &lcp->lc_mtime);
+		if (status)
+			return status;
+	} else {
+		lcp->lc_mtime.tv_nsec = UTIME_NOW;
+	}
+	return nfsd4_decode_layoutupdate4(argp, lcp);
+}
+
 static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutget *lgp)
@@ -1761,54 +1804,6 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutcommit *lcp)
-{
-	DECODE_HEAD;
-	u32 timechange;
-
-	READ_BUF(20);
-	p = xdr_decode_hyper(p, &lcp->lc_seg.offset);
-	p = xdr_decode_hyper(p, &lcp->lc_seg.length);
-	lcp->lc_reclaim = be32_to_cpup(p++);
-
-	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
-	if (status)
-		return status;
-
-	READ_BUF(4);
-	lcp->lc_newoffset = be32_to_cpup(p++);
-	if (lcp->lc_newoffset) {
-		READ_BUF(8);
-		p = xdr_decode_hyper(p, &lcp->lc_last_wr);
-	} else
-		lcp->lc_last_wr = 0;
-	READ_BUF(4);
-	timechange = be32_to_cpup(p++);
-	if (timechange) {
-		status = nfsd4_decode_time(argp, &lcp->lc_mtime);
-		if (status)
-			return status;
-	} else {
-		lcp->lc_mtime.tv_nsec = UTIME_NOW;
-	}
-	READ_BUF(8);
-	lcp->lc_layout_type = be32_to_cpup(p++);
-
-	/*
-	 * Save the layout update in XDR format and let the layout driver deal
-	 * with it later.
-	 */
-	lcp->lc_up_len = be32_to_cpup(p++);
-	if (lcp->lc_up_len > 0) {
-		READ_BUF(lcp->lc_up_len);
-		READMEM(lcp->lc_up_layout, lcp->lc_up_len);
-	}
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)


