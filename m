Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCC2BB797
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgKTUmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgKTUmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:10 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:09 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so8083216qte.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G2VLslRQXVCDK/dyCPR0uUfeg0ShKfOg8H+6cjVC1s8=;
        b=F8tTWrrX3INWxmq0eFaCaon/rqLh9q+5lCmz8BPfKGFwwLGBiVvFymJKNl/UJ/kzVN
         Fx7hFWSg+nQy77fcm2CJ/60UoMFSA+7RkZjoKcyefXQoIXIOgosGkBT/jORVcb5pmsnv
         iWNdQ8Qf/yZ8chl0NF1PWVOd1HRbtNuPOFR8RTkMdydFXfxqsHz6g1SJV3+S0FssBxKm
         XbarjQF2zn8K3e8Hk5gyoWNj+cUKWPrjmtLpH+AWizwsE1E5EQEPJR4Wh3V73nw8PWH7
         hv1pOs/eH2tw0ZGrvNcopahgOuOHmQrNvw1GS/Rc5bTqh3at3yzDku9QeUXBFruk5m9U
         MC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=G2VLslRQXVCDK/dyCPR0uUfeg0ShKfOg8H+6cjVC1s8=;
        b=Uaucn9qIXl/LZtt73ANQ9OO3TpjviAy9k/lClm8NxwEOIobMMKkmk7lxjn7rxcomii
         LqRnsqRlI/HrjQ2Q/34R1NXX2Wrb5vakvmkujB6CczaEkUJY9Zijm2QOgPP+ISnKycqf
         KY4wPgP4Vq+XlMgqfF6niuXnBqMzPNl0EzT+VIrk39c98/iLdy7LpJKlAn6s6iNMQT47
         cJX1QeEHMEDrl5KzNZw7ApPs77BTUcF/kAEi4PJJpKNNbfHGH6M1it8ESKKafQ6ros5t
         NBAF7c+O21Dv9rwE/EtMCtcTzajrINt6iwJTJl9HPbwGZOQx5n4Nj73hj35CsyG21ovR
         w/Kg==
X-Gm-Message-State: AOAM530p9ZhZiPkDJbjFrx08foPX00APSKiWbcz+7+CPe9vA4zEGANVM
        BYPv4YIyuS87fNAYX+prpVKNXwFe92Y=
X-Google-Smtp-Source: ABdhPJx9wWSEChBh07Z4m8gcljm1e1g8s6hq0pVQMDqmDitk902tjJcAXofpQfMp15STm+1GcxBP6Q==
X-Received: by 2002:ac8:4612:: with SMTP id p18mr3749061qtn.31.1605904928160;
        Fri, 20 Nov 2020 12:42:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm2731856qki.134.2020.11.20.12.42.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:07 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKg6VZ029495
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:06 GMT
Subject: [PATCH v2 094/118] NFSD: Update the MKDIR3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:06 -0500
Message-ID: <160590492647.1340.17848953532890465659.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ba1b24f54443..ec4778f01472 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -612,14 +612,12 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh)) ||
-	    !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 }
 
 int


