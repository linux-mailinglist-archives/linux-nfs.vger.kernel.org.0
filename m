Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0614CDFC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgA2QKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:10:01 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44789 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QKA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:10:00 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so50610ywc.11
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FvixT/cv88cGCv79br0TFn8gyk6T4ue7cRMWPBqvE6Y=;
        b=NN7z8+7Es1/CpgQ2pl3Kfip0ByF+7opezVav9X0jKeX9Ls63I/WDYEECXhaLO6eWHH
         ROkTg6KOWK5ICi58hfFGrOGFG75XmH8vMhKwC78MFcGVxH1dm2KeVpkBoU7gJciKy8WY
         90kzleOg/tbvWbKjE/DtOwaqfOBjfRNESttAldkNBPxk49Yna1jvBFZoDtpN8kTLalpY
         YKt3pppCGBNAFA3aBcC468S7F6p49cZ+QbxK0ZFzzW4SY0BN8Ha5YjciamLKlFVqDtOJ
         3EjY13WtIMUKxQ3bU/5VboK9/OdrQpbN0p6zf26b3m9z9TBueSHva7AUT8BreigUWUyi
         +hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FvixT/cv88cGCv79br0TFn8gyk6T4ue7cRMWPBqvE6Y=;
        b=tLRgsEn+TvdZy0fW2PVG6x91O9PdM0lQ9AirD/LdGUq25vcve1fY8D9Pnq4pHPI8ai
         dJN9EUhg0P60v/TCFZfaTd4njprwD1KHEW6WzibDh6/s9YOtK9YJ/5CRAhyGRxXFqYMi
         hI+KL6ITk/OHueMYIcvZAwp9ikXbiGkfNvucbDFFRUE3R7+X9VtHv/ih0KKkxc7HHXCC
         iyhQYT+m3cOMIfVkp8Uxq2aq9GowvFNfq3gW8rKORo7jfHp5UkEgcI44vAE8ygv/kn4x
         v9GZ9SbMaND5XjWxIs5k/Yoi5a3YGenNU52gCaEk+ciFZd2GYVFjRZcsDz8+VZKBQGAk
         Q59A==
X-Gm-Message-State: APjAAAVDupcVzdU/ULUw+Xqh6GYxYdeJSNVC8dtiU6jHiPr9jvMmGbST
        W42SHMs5xnQzCSmzbVCrhx0=
X-Google-Smtp-Source: APXvYqyxWnc9GByHliEPMPTF+5T3ITRrG1mKLQTEDfrEoz7IOOYVeIRZA3vROCGWkJ4bSpG0gQFkJA==
X-Received: by 2002:a81:334a:: with SMTP id z71mr20239356ywz.238.1580314199906;
        Wed, 29 Jan 2020 08:09:59 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h193sm1129635ywc.88.2020.01.29.08.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:59 -0800 (PST)
Subject: [PATCH RFC 6/8] NFSD: NFSv3 support for automated padding of
 xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:58 -0500
Message-ID: <20200129160958.3024.25842.stgit@bazille.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 195ab7a0fc89..91d96a329033 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -709,13 +709,7 @@ void fill_post_wcc(struct svc_fh *fhp)
 	if (resp->status == 0) {
 		*p++ = htonl(resp->len);
 		xdr_ressize_check(rqstp, p);
-		rqstp->rq_res.page_len = resp->len;
-		if (resp->len & 3) {
-			/* need to pad the tail */
-			rqstp->rq_res.tail[0].iov_base = p;
-			*p = 0;
-			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
-		}
+		xdr_buf_set_pagelen(&rqstp->rq_res, resp->len);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
@@ -733,14 +727,7 @@ void fill_post_wcc(struct svc_fh *fhp)
 		*p++ = htonl(resp->eof);
 		*p++ = htonl(resp->count);	/* xdr opaque count */
 		xdr_ressize_check(rqstp, p);
-		/* now update rqstp->rq_res to reflect data as well */
-		rqstp->rq_res.page_len = resp->count;
-		if (resp->count & 3) {
-			/* need to pad the tail */
-			rqstp->rq_res.tail[0].iov_base = p;
-			*p = 0;
-			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
-		}
+		xdr_buf_set_pagelen(&rqstp->rq_res, resp->count);
 		return 1;
 	} else
 		return xdr_ressize_check(rqstp, p);
@@ -817,7 +804,7 @@ void fill_post_wcc(struct svc_fh *fhp)
 		xdr_ressize_check(rqstp, p);
 		if (rqstp->rq_res.head[0].iov_len + (2<<2) > PAGE_SIZE)
 			return 1; /*No room for trailer */
-		rqstp->rq_res.page_len = (resp->count) << 2;
+		xdr_buf_set_pagelen(&rqstp->rq_res, resp->count << 2);
 
 		/* add the 'tail' to the end of the 'head' page - page 0. */
 		rqstp->rq_res.tail[0].iov_base = p;

