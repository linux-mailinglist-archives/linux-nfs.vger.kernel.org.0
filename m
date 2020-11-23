Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CF2C15F1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgKWUJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgKWUJp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:45 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC7C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:44 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so18310099qkf.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dl0ilOvpHBVP4pwo3/beWKpAeJ7AQDc9hRiT/6vt6rQ=;
        b=PviXerCmGJk3YwbIBWLtUa7e98oQIcyXHR7GFr+GQhrak02oTFohDzdeEffza4p4DM
         yf73AGHv0qFJ+yJbdgkErI9YcVxTA08jDOxfZChJ0i2ElM5TfvwnzRR69o144UG5Hqwo
         Xg8A9AHvZi7qxv06bSMzMHYd7Uf14OE4VvcnRtRLctDxXK249ORJJOzk/qIA1tAtV7gs
         Nzcjk77spgeBffSnp5A1mqc/1FWKCjSS+gI/0b0kpaUah3rJQPNjm7mECSWtwHcshl0A
         bkSXRc+qtzX4khT2a3kcl+jSoE2ATXFyVgLIC/s3uKeZO4Nn+yXvdgkmQWvsh4Dmhjio
         VC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dl0ilOvpHBVP4pwo3/beWKpAeJ7AQDc9hRiT/6vt6rQ=;
        b=su93JHDTcyYrb1xIH7ipaqrO02b4bkNVOpirnvrFySsvLjPK+BRE0CrTk3z/29hzak
         fFqJzqZNdQvQcu/j+ilKK6y6nMOu+dJCB2d8kuA/kyKx8UQtspNojBFYpYoQciI7oozp
         F+VD9Lw6J7NAU+YladzYSAlBLlP9LULe3nuCBtOp9rqq1qkW9wHuJVJ/ZYJPqLaw2MhK
         86ecFyc7ByBoA6Qmr14jULxGGBuc+gtUIjO1Jv7uh+ACBkWL6WtIDodx3AFoNIOfydvc
         4MVMWglV2jF3a365HgV2HoiMSPZ6ykYoaOl3hnEq0In2LIO2wjCG1WzOJS44O1uQNTUP
         8yHw==
X-Gm-Message-State: AOAM532vDqbvf5eHfMik6W63rHSGT8mGPfZme/HrlEOlaL3MmlbC9eO6
        WgeBr2e7/Dg56whbGkbOWzqUMqkFtDE=
X-Google-Smtp-Source: ABdhPJxoJR3qeaAu6TDvSHQXZUan78W+T8NlccPNGIHBc1Ye873kiRlYPKzWleVY49r4U9+eIePMUQ==
X-Received: by 2002:ae9:eb10:: with SMTP id b16mr1279531qkg.494.1606162182976;
        Mon, 23 Nov 2020 12:09:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t51sm9715698qtb.11.2020.11.23.12.09.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9fm3010471
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:41 GMT
Subject: [PATCH v3 65/85] NFSD: Replace READ* macros in
 nfsd4_decode_layoutcommit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:41 -0500
Message-ID: <160616218130.51996.15666019727368165292.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  120 ++++++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4be809f00eb1..febdc4b10e13 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -274,20 +274,6 @@ nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
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
@@ -651,6 +637,29 @@ nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
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
@@ -1796,6 +1805,41 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
+			  struct nfsd4_layoutcommit *lcp)
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
@@ -1820,54 +1864,6 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
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
-	status = nfsd4_decode_stateid(argp, &lcp->lc_sid);
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


