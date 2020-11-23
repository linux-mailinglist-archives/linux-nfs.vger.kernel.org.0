Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7942C15E3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgKWUJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgKWUJR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7FC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so14343334qtw.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bgtRqKg843ZWylFn2dEPW9Le7aPHCKY8iBa7h0ejojQ=;
        b=rqCghze4+2/SAvx5qO1WvqnS006dhmgXmrxxuOypKlwe68jAB0RZ2pIQLaUWRxyxkT
         LN9hwe0eu+ZtwI98K4hp0vvLH5UYTgI48G0lEhpQwZNRPi8BG3gAZ4WRlI5TP8JEp35z
         T8wqIm+WxVphhL7v1iqpM8/752TW3LZBx/YKirNRnLdrwUry3trQSVXxEtmKWRz6foln
         KYGIu6ZyjB6CqYTxxqVBWbrL7JjwQk2h/H6mTjsPwmnKjmVJs4sJ3cV2vPdvwHKS1K7h
         nc5mv/FYh4JYdmBbLlR1ZpSb8NjDBTnlowallJB2ZwyNWLy9FajPJdnQ3hXGRW6hekxk
         L46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bgtRqKg843ZWylFn2dEPW9Le7aPHCKY8iBa7h0ejojQ=;
        b=JK++ZMszMVRZxHPpWsn8uJK9yPQKfPUOnueBf6nMywPOtSzw0J3ASzqkvZ8XHYVwg9
         rh8NmOfe5muFA8BUqfYV1f0wjYU6+IqinLAotyjx6TPm3nQCh3JqzSmFXlKtk8NxfW9s
         pQHFnEHA6zharuHFrLwrExF+Y1Gg9H8j47/hWtlzaZi263nzVUGoupZT09WU/3JFzaup
         ghrOv0+ban6SG0zfkM96plYXhMjVQL5P5lv1zBYyjBmMhq/J9B5IPxBGoUnLH4MhZKIv
         RS0N5HtG0KL4zgiW430cJPg6ySyIdskzDO7eqiMpOU/t4EnWanAav8fOYXePjRJVJMwq
         O8TA==
X-Gm-Message-State: AOAM530xFr7yVl87BwQ1RSnPTG9dOsYi4tudKJGW/Arf0gTnTig/Qd1Z
        okhhqkhfTCTXebWN3DL4yAhBHqoWtUc=
X-Google-Smtp-Source: ABdhPJyO4Sfbh22TkIhaLZazHeeOZWPf8CmYFQjpwnq+Xz02OG0lrHFzQyZ2FMGSWohUjFw99lKU5Q==
X-Received: by 2002:ac8:7551:: with SMTP id b17mr923388qtr.35.1606162156465;
        Mon, 23 Nov 2020 12:09:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n9sm5512484qti.75.2020.11.23.12.09.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9Ew3010456
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:14 GMT
Subject: [PATCH v3 60/85] NFSD: Add a helper to decode channel_attrs4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:14 -0500
Message-ID: <160616215488.51996.10296408285780429558.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

De-duplicate some code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   71 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c74aa6203989..06de62f8185c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1614,6 +1614,38 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_nfs_impl_id4(argp, exid);
 }
 
+static __be32
+nfsd4_decode_channel_attrs4(struct nfsd4_compoundargs *argp,
+			    struct nfsd4_channel_attrs *ca)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 7);
+	if (!p)
+		return nfserr_bad_xdr;
+
+	/* headerpadsz is ignored */
+	p++;
+	ca->maxreq_sz = be32_to_cpup(p++);
+	ca->maxresp_sz = be32_to_cpup(p++);
+	ca->maxresp_cached = be32_to_cpup(p++);
+	ca->maxops = be32_to_cpup(p++);
+	ca->maxreqs = be32_to_cpup(p++);
+	ca->nr_rdma_attrs = be32_to_cpup(p);
+	switch (ca->nr_rdma_attrs) {
+	case 0:
+		break;
+	case 1:
+		if (xdr_stream_decode_u32(argp->xdr, &ca->rdma_attrs) < 0)
+			return nfserr_bad_xdr;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
@@ -1625,39 +1657,12 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 	sess->seqid = be32_to_cpup(p++);
 	sess->flags = be32_to_cpup(p++);
 
-	/* Fore channel attrs */
-	READ_BUF(28);
-	p++; /* headerpadsz is always 0 */
-	sess->fore_channel.maxreq_sz = be32_to_cpup(p++);
-	sess->fore_channel.maxresp_sz = be32_to_cpup(p++);
-	sess->fore_channel.maxresp_cached = be32_to_cpup(p++);
-	sess->fore_channel.maxops = be32_to_cpup(p++);
-	sess->fore_channel.maxreqs = be32_to_cpup(p++);
-	sess->fore_channel.nr_rdma_attrs = be32_to_cpup(p++);
-	if (sess->fore_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->fore_channel.rdma_attrs = be32_to_cpup(p++);
-	} else if (sess->fore_channel.nr_rdma_attrs > 1) {
-		dprintk("Too many fore channel attr bitmaps!\n");
-		goto xdr_error;
-	}
-
-	/* Back channel attrs */
-	READ_BUF(28);
-	p++; /* headerpadsz is always 0 */
-	sess->back_channel.maxreq_sz = be32_to_cpup(p++);
-	sess->back_channel.maxresp_sz = be32_to_cpup(p++);
-	sess->back_channel.maxresp_cached = be32_to_cpup(p++);
-	sess->back_channel.maxops = be32_to_cpup(p++);
-	sess->back_channel.maxreqs = be32_to_cpup(p++);
-	sess->back_channel.nr_rdma_attrs = be32_to_cpup(p++);
-	if (sess->back_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->back_channel.rdma_attrs = be32_to_cpup(p++);
-	} else if (sess->back_channel.nr_rdma_attrs > 1) {
-		dprintk("Too many back channel attr bitmaps!\n");
-		goto xdr_error;
-	}
+	status = nfsd4_decode_channel_attrs4(argp, &sess->fore_channel);
+	if (status)
+		return status;
+	status = nfsd4_decode_channel_attrs4(argp, &sess->back_channel);
+	if (status)
+		return status;
 
 	READ_BUF(4);
 	sess->callback_prog = be32_to_cpup(p++);


