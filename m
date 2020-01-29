Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7D14CDF6
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgA2QJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:29 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36423 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:29 -0500
Received: by mail-yb1-f195.google.com with SMTP id w9so91861ybs.3
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LTMvTQVA4iVgG4sSgvmo3F/nyb4ms19PmRgM8uHui8o=;
        b=RBINS3raUcRrE6ZN1ijdB3K19QCkY4ahbZE6RZopi9lAFJoY+wrGRzdUap5QC5xk34
         06mVESALvVCHXYqfAzoNLoIwIoMDhJeWgiNpZC2yjqLhFg3V6rvX2TxigZJmJqW3sIYD
         n6RLri83Uq/XlPqztrMtpcOvWMFTH7Okic/KrbxoiCt28Zu/7MJdxabs1TS4NcLhYvvk
         lt8YfXRCBOfXLVjKe1bG6LujXKKwYMhptaS/nL3DJ94sEz/gJuUHOiqvJ9PIhkxw3sBu
         O1M+v05HffWplQuEPqr32WulveyiT8aXAokvwsQ/+3RknG5JPVkzkEJN2uSTuW46v2aj
         2Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LTMvTQVA4iVgG4sSgvmo3F/nyb4ms19PmRgM8uHui8o=;
        b=C9nRPrtTKk1ICtzUnLTEM5kQ7A7A4OjAGq+8wlT75s0hFAJRjFmri+GcG+DFv3IhFE
         M0qtPZC7ihfEfG9259B0aDzju47HWTuDqeePvmvmvnGyofVtyDpq3JmEnyMlSwCq5sjL
         ywS17qM95Rk40oEzckifUjWCGQGZgarxF8A/r4Qo60ZDGnLhalop8/K8tykgdiI/zf1L
         F1DC3p+tIhTxHvky4ZQiSEQRWSdzu57/9UxiF9/y01anJaA5QPbi83cUuOjuTWxuRlHc
         eKWcHOHfx68O5EP+xMWe4V3/dHLINqLVOBjAylQOpSb9zyl5XzlAqHaqtG7TYtKSb82i
         fRxg==
X-Gm-Message-State: APjAAAWGhyimYHA8jwnByNRQUqoouScYOz5ZK1fkWtk/r32A4u9Fq6+i
        S2bcZPi0zUj31as1J2LfFMm/r3zq
X-Google-Smtp-Source: APXvYqzNjo4pXmUxHO3RJv/8H3JJNsvLD/cJcFHdV1TDyWcl6+1BKVnQFpisZBmb0MH7a/bOaHxe0Q==
X-Received: by 2002:a25:3803:: with SMTP id f3mr177077yba.144.1580314168576;
        Wed, 29 Jan 2020 08:09:28 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m138sm1109360ywd.56.2020.01.29.08.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:28 -0800 (PST)
Subject: [PATCH RFC 1/8] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:27 -0500
Message-ID: <20200129160927.3024.90505.stgit@bazille.1015granger.net>
In-Reply-To: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
References: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svcrdma expects that the payload falls precisely into the xdr_buf
page vector. Adding "xdr->iov = NULL" forces xdr_reserve_space to
always use pages from xdr->buf->pages when calling nfsd_readv.

This code is called only when fops->splice_read is missing or when
RQ_SPLICE_OK is clear, so it's not a noticeable problem in many
common cases.

Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 75d1fc13a9c9..92a6ada60932 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3521,17 +3521,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	u32 zzz = 0;
 	int pad;
 
+	/* Ensure xdr_reserve_space behaves itself */
+	if (xdr->iov == xdr->buf->head) {
+		xdr->iov = NULL;
+		xdr->end = xdr->p;
+	}
+
 	len = maxcount;
 	v = 0;
-
-	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
-	p = xdr_reserve_space(xdr, (thislen+3)&~3);
-	WARN_ON_ONCE(!p);
-	resp->rqstp->rq_vec[v].iov_base = p;
-	resp->rqstp->rq_vec[v].iov_len = thislen;
-	v++;
-	len -= thislen;
-
 	while (len) {
 		thislen = min_t(long, len, PAGE_SIZE);
 		p = xdr_reserve_space(xdr, (thislen+3)&~3);

