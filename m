Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC814CDFB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgA2QJy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:54 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43170 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:54 -0500
Received: by mail-yw1-f68.google.com with SMTP id v126so54943ywc.10
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZThcUy2zV3P2cAwdY3NUiX8vOGUC+wN33NQGZpDoLek=;
        b=mZ0jEqnMuHh8+HMDMXIYo+f6v4AzMgi6dKMQglFMlae3869o0UVygtxR+Mceyke0qi
         b8s4i9iL8r88ednusMvg5ZdUJF35qNAlwRA6a8hEEc0L9oEJCKKE6TM0J+Kh4MKDaFCr
         0O2/BuPu90qMcEzwT9hrEyO6QfslI1vSnzgs0gm38pk+JYfN8BehdrNnlguEorIU6hxA
         gOzzi5os6ltLPvnU4TXTSULz9CeJLqcurl23+H3N+1QWkaijC8MD8V27ei/Tjz+7+U9A
         KXLNiPk+Bmv9g7iwvf79P5ocvGKAFMeXSQnyHunbUaVPNwrvim/Idr/8kv212VEK2Cp3
         u0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZThcUy2zV3P2cAwdY3NUiX8vOGUC+wN33NQGZpDoLek=;
        b=bRNpbLKZ3/pwgnKMcXX9rTaqjAyJcLe4GRZGuNZRGoaT8IGyijFLAM/A1BvYKtIeyQ
         aVrvZlcSOyv0KKOXjgIViExrkXxBzzT1Vcd0ibCuMUq2+oJ4sHFFDRMiWgx3aAttBZ1+
         Sy1jR6eFQRufvRQd/DEkEvN3IXW5dtUcPVqozBwzFOreXGPQZxDU+iYEnFhQ6gSQhXHi
         w6lKvJ3EI4Grxdj+GW1bygL7vLhladkGKaT/kdm/g58HksoRuUQF4TwKKh6Hnsjt9Tcm
         3euJfpNHbs/P0209qNignfswTh+ntQqPHzW8fjDPG7L4f3InpaQHmvqkl7s9BSRnPO1X
         P3TA==
X-Gm-Message-State: APjAAAWkZr65lrR+c0pSLXScWgNfcQIGAUZ/JDiuo5LhVxeMPyvKVzn0
        gBHoQ6ptA8A3ta+bg18ZudQ=
X-Google-Smtp-Source: APXvYqyRi2+LCTRkdc2rCp5MH+8AzdC5C879NxhSTHhhzw28V142wQDEmHSKsARSpG/IRTiQen4x6Q==
X-Received: by 2002:a81:a0c3:: with SMTP id x186mr20126179ywg.344.1580314193675;
        Wed, 29 Jan 2020 08:09:53 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z12sm1136629ywl.27.2020.01.29.08.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:53 -0800 (PST)
Subject: [PATCH RFC 5/8] NFSD: NFSv2 support for automated padding of
 xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:52 -0500
Message-ID: <20200129160952.3024.44348.stgit@bazille.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index b51fe515f06f..06e3a021b87a 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -455,13 +455,7 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 
 	*p++ = htonl(resp->len);
 	xdr_ressize_check(rqstp, p);
-	rqstp->rq_res.page_len = resp->len;
-	if (resp->len & 3) {
-		/* need to pad the tail */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p = 0;
-		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
-	}
+	xdr_buf_set_pagelen(&rqstp->rq_res, resp->len);
 	return 1;
 }
 
@@ -475,13 +469,7 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 	xdr_ressize_check(rqstp, p);
 
 	/* now update rqstp->rq_res to reflect data as well */
-	rqstp->rq_res.page_len = resp->count;
-	if (resp->count & 3) {
-		/* need to pad the tail */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p = 0;
-		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);
-	}
+	xdr_buf_set_pagelen(&rqstp->rq_res, resp->count);
 	return 1;
 }
 
@@ -494,8 +482,8 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 	p = resp->buffer;
 	*p++ = 0;			/* no more entries */
 	*p++ = htonl((resp->common.err == nfserr_eof));
-	rqstp->rq_res.page_len = (((unsigned long)p-1) & ~PAGE_MASK)+1;
-
+	xdr_buf_set_pagelen(&rqstp->rq_res,
+			    (((unsigned long)p - 1) & ~PAGE_MASK) + 1);
 	return 1;
 }
 

