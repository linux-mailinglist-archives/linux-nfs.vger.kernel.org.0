Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D092BB77C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgKTUkN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgKTUkN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:13 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA91C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:11 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a15so5323307qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=n2dVczH5nIofYK6R7C8/PxfyVjUZ08Rq9I8TKfDdMfg=;
        b=tYopFeFArkLmsPQd75AZstl6UmduU8uGAooL+KtZWtNT9TNqStxm5m190uXhHMus4e
         8X6u25DWYdZBU1RY6aCGMvuQDK1PZfAgxNgEQhxaU7JMdjQVWFPZQihX3ggNF0OYCb9C
         f7rRy6yo+GnCR/oKglBqIHo7/bslosfy4mbJ+eSvFN/Lz/hUn6Dpv69zDn6YpmXnBu7r
         TsbMn0/1T+XR1PBSo5CCOSXmN9YisqzcxdrXpMxC85Vo6yJW6DL54OsW8lXLfmuTL9LT
         SgmIlOW0iB7NCZ4YEF8HZ1fofOkjzTg7R9pJJaIeQ/bHRPhzesUsiPYI6wkUcqYf9sp9
         DDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=n2dVczH5nIofYK6R7C8/PxfyVjUZ08Rq9I8TKfDdMfg=;
        b=AhpJUqK8VoxpTwraR/hayHXSy46F+ip1tORVDX2NJFB51tXI0v3EGtoFhrNRKM8EqU
         wwyoyd61xQK0CDrJwK954OvR7H7Ka89CPqj/A4XQsbttQznN2+mVkfEwOZlu8Kv7Sdr4
         z4ybin3ivcGl6KTUVXxv8kefnwdpzTbRspj+V1+IzU8vRTjEOxRZavej9CZcddMrRvBs
         UCHSXsIGuW5Dg85JM7gf0gR3pHIkJfeQEtXrgelAfUx2PJrijocoxQfSqlryf1xmmGeo
         vxi+35L6oJ7aj7oBLaYZO8qhC+ExK6DfKlgFjGQHV2DhVzaT+QRqQAxWOTQtIfx7tzsG
         iQEw==
X-Gm-Message-State: AOAM5319Vu3cOhbJcQ32LJtkfXRcRBUPpqCfztDzcBdYNWoPro/pvlRC
        mvW5Yo+VwgNczUdXujXZhOK7/9AygBM=
X-Google-Smtp-Source: ABdhPJwaLetx5l4dpq3ubeTW4+5U/iYZRec6M8b/7lrj3LMgLQZV28TyfeniRDOhSj3ldl5Bppltpw==
X-Received: by 2002:a0c:aed2:: with SMTP id n18mr18576051qvd.4.1605904810658;
        Fri, 20 Nov 2020 12:40:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 7sm2844735qko.106.2020.11.20.12.40.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:09 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKe8mV029429
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:08 GMT
Subject: [PATCH v2 072/118] NFSD: Replace READ* macros in nfsd4_decode_clone()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:08 -0500
Message-ID: <160590480889.1340.13450397927795498268.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0509f2c00310..ed1e6460b655 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1862,7 +1862,7 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
 	if (status)
@@ -1870,12 +1870,14 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 	status = nfsd4_decode_stateid4(argp, &clone->cl_dst_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_src_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_dst_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_count) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(8 + 8 + 8);
-	p = xdr_decode_hyper(p, &clone->cl_src_pos);
-	p = xdr_decode_hyper(p, &clone->cl_dst_pos);
-	p = xdr_decode_hyper(p, &clone->cl_count);
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,


