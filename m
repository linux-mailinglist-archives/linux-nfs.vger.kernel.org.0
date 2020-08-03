Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C405C23AB1E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHCRAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHCQ77 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 12:59:59 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F4C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 09:59:59 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p13so3238668ilh.4
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQ94gvLioDK0D2IFkp5BPVhxBDzICQm4Mh+Md8q/jh8=;
        b=IhsTT0uXXGdUmcIXWBtaIypojOx8hcTY6pkQW7kcRZOctKnIRcAJbmmEhZjI0Itm1d
         INRONysALepG3KQ89i1mzt4DYvqNFseYmqo2cGN0ZNSPv/cjIYvWBSjomdSmzSylPv73
         3wmv9Z9LtVvOwWXlvAYLG42J4pQqspDfx2MxoKdkN1DffJCtrLyIejcUwOID2TRN1Lbi
         Eg0IPL5T0hd7XUTicw7kL+NX24fvtsxjTfJ4mz/BXrmFTAq2LlfJvT6V+NRna0pT7BOo
         TdKim6pBpOBK/uivelyRjRgT+Rtf/xN0kY4Os1Vc1WJhbLEXruV4thAu+sMItiSg4FyZ
         1EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vQ94gvLioDK0D2IFkp5BPVhxBDzICQm4Mh+Md8q/jh8=;
        b=fp2D5JfPSNhevcTWiyUeA6VMfLXrR04W3KyNmr50q8OaviOxTVns1immtNiujSMunI
         Z4PUQztTn+k9HCOOR0HR2GyA8piz+loUHE5Lw0BZIdntvS9klh5FL35Xi0CH6a8Z6TYe
         aWHfQcvsVC5+F5t8gAUEwOZGxKwnMoBrjLl4SuNsrdIcPP/0+bw/K0qv4+ram1fv9+rX
         FVLeI04lYxIuvElwIP12xogbXq+bIB9FiMWxtAaP3rFsJ5CZ7Q0hyE/o99Sw68nm34/Z
         rJSY7qtbj2c8k+yzaOEXZnDTbII3hDlT3qe4Rzct/YkpEV0H40ZQrOjS+QGOQqlnAnzh
         6kEw==
X-Gm-Message-State: AOAM531hOfl6Y1P8DkIuTp35ZSQEXq28miU5LxdyWB9l3GV9OnD7OAA9
        AqY0RyHKQifvzJa1DuNuxnns3kaL
X-Google-Smtp-Source: ABdhPJxjQdtgoi3r3K4m8JGZPlDO+gjAeRrVjiyPl20ZQZaSoM/xtqLuDjIgVGavSmRa9u1oL1ODUw==
X-Received: by 2002:a92:5a4c:: with SMTP id o73mr317695ilb.45.1596473998833;
        Mon, 03 Aug 2020 09:59:58 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id f20sm10794639ilj.62.2020.08.03.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:59:58 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 2/6] NFSD: nfsd4_encode_readv() can use xdr_reserve_space_vec()
Date:   Mon,  3 Aug 2020 12:59:50 -0400
Message-Id: <20200803165954.1348263-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Switch over to the new code so we don't need to reproduce it on the NFSD
side.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..6a1c0a7fae05 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3584,36 +3584,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	u32 eof;
-	int v;
 	int starting_len = xdr->buf->len - 8;
-	long len;
-	int thislen;
 	__be32 nfserr;
 	__be32 tmp;
-	__be32 *p;
 	int pad;
 
-	/*
-	 * svcrdma requires every READ payload to start somewhere
-	 * in xdr->pages.
-	 */
-	if (xdr->iov == xdr->buf->head) {
-		xdr->iov = NULL;
-		xdr->end = xdr->p;
-	}
-
-	len = maxcount;
-	v = 0;
-	while (len) {
-		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, thislen);
-		WARN_ON_ONCE(!p);
-		resp->rqstp->rq_vec[v].iov_base = p;
-		resp->rqstp->rq_vec[v].iov_len = thislen;
-		v++;
-		len -= thislen;
-	}
-	read->rd_vlen = v;
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	if (read->rd_vlen < 0)
+		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
-- 
2.27.0

