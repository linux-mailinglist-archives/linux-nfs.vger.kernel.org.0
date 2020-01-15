Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1A13CE24
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 21:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAOUhg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 15:37:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44286 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAOUhf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jan 2020 15:37:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so11616573ywc.11
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2020 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZlrWpxgDTE6tQy2K3ooYpYA9YSZeijzs3PBuP1a9+Rg=;
        b=kDZMm5zR0N4bqKlOJLbIAlepFtT4k1oqlXUUsUp4IbPq9WqixesiiOGwudHXWwYEmL
         agLyXMeSMg8I5P6EhWi4rZxyVRJNR1WgXub8WhPj5HDM37RiGTCFBwbNIVdi1DIrugq8
         2bS2AtZA4oKQVke+I5Z4RO/SVINWzwnzz97Ms+cTsvF/Gs5E/o/Eu9hzJT2Jtd6Zzsnp
         FSqnogxjuNf8oRCiWCjWSnxE/GfpFa2+mMSpJkJkn+KnRXxvuuXdtbLEQO0rnu47a2wt
         o+IXlE9JDi6E8xfHw9ErD9QNZIgMxZ5ifbfgSggZFLEkgtECZ9vsJtre9AHeKd9MYmpn
         sBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZlrWpxgDTE6tQy2K3ooYpYA9YSZeijzs3PBuP1a9+Rg=;
        b=q+ebJ/b2AUJ4WASfhHRQnw0DID8wtVDCHy+/QqtxY/MTZtSn3iQw3XTWWGLuSe2Ox3
         wIn3ipKzwhE8jy9R6LtL+KXwHHyHBh3bf0yWh0I2O6mVTH8kebG+YPjfo95zAQ7ZFHDS
         heBL7AoevYlOzC5elP7zF8gU1h2l50P6i3tKH8oIYIsl+jW50tJkrZmn0rpxde1D+LED
         103o2vu+QQ6ACAryr7TFG97H6m93F1FA5twcWr5GLIlt1lsClo2VCOZqrasDEy7BR9m6
         zO/6HHOHfEsYAAgt7TkseYG6QSRolpCdhVhZ+xL9kdORktC7m7M7mOJuMUqz/pGrm/zt
         bgQw==
X-Gm-Message-State: APjAAAXnRc6d3mfNYQBo88VqkJvFjDsEbg3BqxdZiSIeO8CWbrA+47Uw
        JQxm8C1oNuPWRCakf7HF/NXeaqMw
X-Google-Smtp-Source: APXvYqyvEkEHmWySZ7txpA32nuGVyGDdKEB85hHm2xfLURV7mjUugEVT3n+5KEA0d2baGHq0GzZaOw==
X-Received: by 2002:a81:d251:: with SMTP id m17mr18554527ywl.330.1579120654958;
        Wed, 15 Jan 2020 12:37:34 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q185sm8669370ywh.61.2020.01.15.12.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:37:34 -0800 (PST)
Subject: [PATCH RFC] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 15 Jan 2020 15:37:33 -0500
Message-ID: <20200115202647.2172.666.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svcrdma expects that the READ payload falls precisely into the
xdr_buf's page vector. Adding "xdr->iov = NULL" forces
xdr_reserve_space() to always use pages from xdr->buf->pages when
calling nfsd_readv.

Also, the XDR padding is problematic. For NFS/RDMA Write chunks,
the padding needs to be in xdr->buf->tail so that the transport can
skip over it. However for NFS/TCP and the NFS/RDMA Reply chunks,
the padding has to be retained. Not yet sure how to add this.

Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198053
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
Howdy Bruce-

I'm struggling with nfsd4_encode_readv().

- for NFS/RDMA Write chunks, the READ payload has to be in
  buf->pages. I've fixed that.

- xdr_reserve_space() calls don't need to explicitly align the
  @nbytes argument: xdr_reserve_space() already does this?

- the while loop probably won't work if a later READ in the COMPOUND
  doesn't start on a page boundary. This isn't a problem until we
  run into a Solaris client in forcedirectio mode.

- the XDR padding doesn't work for NFS/RDMA Write chunks, which are
  supposed to skip padding altogether.

Do you have suggestions? Thanks in advance.


 fs/nfsd/nfs4xdr.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d2dc4c0e22e8..14c68a136b4e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3519,17 +3519,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
@@ -3548,7 +3545,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
+	xdr_truncate_encode(xdr, starting_len + 8 + maxcount);
 
 	tmp = htonl(eof);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);

