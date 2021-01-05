Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B702EAE75
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAEPcc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbhAEPcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:32 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA2C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:16 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s6so14793620qvn.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8YcedvkKRU4HgNJWPJMrwV8wlECAi0EaUoywCMTNO/Q=;
        b=NCSDSzXXLt4fP3eORk/WINoI93xhnc2ftyRIx80Ofs7klyOtwHs2+OXA8eWwVoEEQQ
         wRunja3G0HeHx12ag5s7nDnH92H66PxH7Bh4uh4dSf5EjT9ZBBEALTRFMOg/inrPUMAh
         6iy2Rij85ZC3vL7/luXQSB1MKUFxvbjPKgy6xNfkm9cC8WsfcGYiev+hyhBZZrqtKXWz
         IVr9hX+71jKldpdjrYlx1pI6ekHDKQ4094KoOPjjLwvBSBZtCkitMEyIUEnZAcoT4siX
         uSh7sI5sv97RIjn9Sk9JES2KFLfGPVDASeyDkfxQYoicaV0mMf16ZOt/QIQVrWc7JoU2
         35DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8YcedvkKRU4HgNJWPJMrwV8wlECAi0EaUoywCMTNO/Q=;
        b=CUHlW5wa+VUc1JnBS6dd7wySQcEuOGtgqLuQ79dFcJsgOYDwZ9C02P1C96sTmlM7CN
         5E0btPrBXfbePL5T+mKD+JP4CunXMcc82khjuEdGn9QvkE/RMVapKdj2F7cTocxYHnok
         WgrY9MREiEYJ1x/eMXs3ZuiLPPgq7ysj+bNcMPHtg8s8vJP6uIc+VpB0DXGi4hbev48a
         9LEJOsz9l+d6WREbeLyjuY2v+Sfm9FheCYqVeCxTsCV3gF9SsvlP58EPV1FWFw9kEtRL
         t+CknHcnLxiPculsMEfbVO2g+W3yKHLsViTjbg9zm1dJuAMwMjBURpH82JdUoN5wM3Sx
         94lQ==
X-Gm-Message-State: AOAM531cRlp5Uv+f7PYBxmSsOZO5GTKdF31CDz5oCKGkzMLo4v21NQ6R
        aVsHlqUvo1qPZ8Pv3ZxTeHsXUtxBAcA=
X-Google-Smtp-Source: ABdhPJxzvVAmnwj5uNpVw6s25NYaoK1RlOShls/7kpgs9xBmNwx3iZSxdDWGpySY3BeHmCgKQYTHOg==
X-Received: by 2002:ad4:4f41:: with SMTP id eu1mr145275qvb.1.1609860735796;
        Tue, 05 Jan 2021 07:32:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o21sm169450qko.9.2021.01.05.07.32.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWDPQ020907
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:13 GMT
Subject: [PATCH v1 29/42] NFSD: Update the NFSv2 LINK argument decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:13 -0500
Message-ID: <160986073381.5532.4874558814110521694.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index d4f4729c7b1c..3d0fe03a3fb9 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -356,14 +356,12 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_linkargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_fhandle(xdr, &args->ffh) &&
+		svcxdr_decode_diropargs(xdr, &args->tfh,
+					&args->tname, &args->tlen);
 }
 
 int


