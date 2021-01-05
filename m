Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8B2EAE5F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbhAEPb3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbhAEPb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:28 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C966C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:13 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z3so21021896qtw.9
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=T9U5ag9DLt7J5bSYP8Pf1bsDxgr8EiUPWCu7Lzp07Cc=;
        b=ulO9vc1xHW5nwTBN6tsS+IOmX2tNU78Vzli7VT6rMARpPu9idJ8mjZnHR9d/sCiwOI
         xg+6uTbi7Mu/YZ6YaiUB7CwrLcns40JdrqjUvMlBt9aCC6+fMjdyPyRNu/m/y0+P9qe3
         cUSSonH4+kPXcEgnvRU0Vx2xbgqDxMO+L8/dkJizc2szjggqBlXr+6imRkmX65B+cbfC
         mu4bInStrJxxu5L0bz4EMU8+nJWX8GblRdCoGv8GnrO0PH9Dn6PMh27xqxJqMQtacJ05
         PLeuD/U3KbGh/D7owYLPV/REQFECpugqh7V4zwlNHabyGi55PeRhoT65b2AC2gw5fojT
         nQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=T9U5ag9DLt7J5bSYP8Pf1bsDxgr8EiUPWCu7Lzp07Cc=;
        b=dG0dwPGe97nxQrLQ7TWmjQ/6UzThDfnCU5eeADAuLYWFSRfI6B61/oLA8EYIlvtfU9
         MS8HiLz4KVPnIoCd4LesvDQR0tEq0zkqB04mmpxU86J4hCVEDFAwgBzbdwlFZoIpkxOO
         BRiTsWuNcYepCzy7jIlWVQ/LuQx+dnLB+7LQswqTUmFq4VDkh+hJ0H0v9AgdnNNAkZi5
         C81VQHJ/FH1dqk8B6lYo6EioJo8XfdvGu9b0R/V5qvjwewOVKlq7SoyGgvOxuhQ5iNux
         sNviSn0jR3jlhHQxL3pTFSIqRqz33D4bnxstnffyL6HodRRWS/mKskt5tHsUqZibY//8
         0AUQ==
X-Gm-Message-State: AOAM5328YnhZNRq08C65jqX0k2YxJhv+l3IInK+H5dFwyPmB99NczSzn
        elX6Ua5COHImvo5STvMgeRvHwzP2NSE=
X-Google-Smtp-Source: ABdhPJyeja9/SXEH86PSbrC7r+scrfCUPoT6mMg4Ud0zcRUQowa4IzK63AECQkMpiqzAaAhT0PS2JQ==
X-Received: by 2002:ac8:6987:: with SMTP id o7mr8964qtq.295.1609860672411;
        Tue, 05 Jan 2021 07:31:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b12sm60934qtj.12.2021.01.05.07.31.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVAON020871
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:10 GMT
Subject: [PATCH v1 17/42] NFSD: Update the CREATE3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:10 -0500
Message-ID: <160986067046.5532.729852070349122190.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef536fb00728..559344c95de9 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -580,26 +580,26 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
 		return 0;
-
-	switch (args->createmode = ntohl(*p++)) {
+	if (xdr_stream_decode_u32(xdr, &args->createmode) < 0)
+		return 0;
+	switch (args->createmode) {
 	case NFS3_CREATE_UNCHECKED:
 	case NFS3_CREATE_GUARDED:
-		p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-		break;
+		return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 	case NFS3_CREATE_EXCLUSIVE:
-		args->verf = p;
-		p += 2;
+		args->verf = xdr_inline_decode(xdr, NFS3_CREATEVERFSIZE);
+		if (!args->verf)
+			return 0;
 		break;
 	default:
 		return 0;
 	}
-
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int


