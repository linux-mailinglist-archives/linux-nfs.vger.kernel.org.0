Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8F14F345
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgAaUlt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 15:41:49 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45081 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAaUlt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 15:41:49 -0500
Received: by mail-yw1-f68.google.com with SMTP id a125so6054430ywe.12;
        Fri, 31 Jan 2020 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LTMvTQVA4iVgG4sSgvmo3F/nyb4ms19PmRgM8uHui8o=;
        b=bAdbc+13mfXVgvCbbEZv37eGftafAh3gSklBW3gEvAB3VzC8nR7Vt29yA8+XR1g7Vp
         JkX3E0uHNrn9m4Ipa6ngr7VDu8jBtPhA9hzsRWK+AV32W/CDlXfQ009MPIxu+vgYPWyw
         L/38wgxV2gW/nXD9pUroUHRY9C4nEPzf9ucDgGqikMMgY1BGCT08vXwb0YybfswoxFFY
         vpPckNi+nhhK/ryOEQNio0GkLmOyj2IVtCLBobWguXFXNLi7ihibPNzFVk7wl64toILr
         EV3+FeYrF1YDnirwKERcfacP9p2avW2GhxIOSdSX1IoK4Ohqy8eS9sf6jBbbDFlfxRLE
         RIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LTMvTQVA4iVgG4sSgvmo3F/nyb4ms19PmRgM8uHui8o=;
        b=uFagff6ZJHjP1sZFuggaMa9kvspzrX2zKsTHwJzNbG/FUEddkLx+vfwijTA1DqQT2u
         Rbqlv9fgnxh7VekBBbcvY1XKA4S5fcehlZ0CCRhxl0LXTEaAnKVPnVBtkhaqaQQctgCv
         t2T0X4EDeSeVi/m9Y761yT+kBDnyQrvyJRWWIWhUZqzxGLw++jNITEeNh9fAhcdyzC0d
         iFHOb4RK7/2CbNSG+GsO8M9wqu/OrJphQc5APKT02bHD9pEa1xrRiLBYW4l8LwIrPLbT
         kdi5XwyDyhMhrqeT9b7Ie5ANl3u5SPULekO04WB0I0uoqNHTxhJ5vmtXJyf3C7YfVEpz
         W1Gg==
X-Gm-Message-State: APjAAAXlabk7gocta5o3yOOm71XSPL4SsnmtWpcq6gYaK9itBPaMB7wi
        3xJKsBD2ywWMF3B0BvayabZaO/CJ
X-Google-Smtp-Source: APXvYqxGcmgL4gUNE+3CdfRvQ7MupnWElUOExC8cu4/uyTEvRpNhg7frOrPgwJAlOSBOJFynD6PsxQ==
X-Received: by 2002:a25:808d:: with SMTP id n13mr10428385ybk.483.1580503307360;
        Fri, 31 Jan 2020 12:41:47 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u136sm4316945ywf.101.2020.01.31.12.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:41:46 -0800 (PST)
Subject: [PATCH RFC2 1/3] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:41:46 -0500
Message-ID: <20200131204146.31409.29902.stgit@bazille.1015granger.net>
In-Reply-To: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
References: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
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

