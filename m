Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF82C15B6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgKWUHW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUHW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:22 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C2C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:22 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id n9so3155265qvp.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R0OUPEJNqWMapI2K2ucv9jX1Umz8GgkM84dNcE1MLeY=;
        b=lFGyRTfwojIOQCdZ8BXPpt4Ispc0srvjZGRbXczd6cokaXaOEKOLvZFp3QXbzAZxxG
         Z2S6NFi2Ek37lkBw33wmvWYt8tMpZdYJ6gc+Ys3kFZmkJv73ZNuiOolU7lBQ/SqGAMHL
         epdOX36BWOruLne5AbJIXwsSvXAeDKBjp/aMWvI8xHaAyQ6zZ6iLjehSNKv7Ju2geiy+
         OQNqL/bcBAlx5xxKZLnkMvpOIVAX6g5Xe3aDZbvXb7zL9sXvKDtE/TBTTiANJWIFhYRW
         XHDIPdxJc5JyI5uuSHkjMkDgdR3cZ2XBGfCixTrsYxck+pJvfCNU3JK7eFDu2A7IXwt9
         DjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R0OUPEJNqWMapI2K2ucv9jX1Umz8GgkM84dNcE1MLeY=;
        b=p0n784PDhibebgA6GhPNKr2VMEj532DI2r1MydTbflRuTF6xXUq+8+cyUrft5TSCoY
         VHBR4yLNe5TMCxUIrSNXwEpMNAV71HEwVo/mX9rH0vQdV5FOeGo7CuYUsjcti98LPXYK
         dRN9Xwuo/oeI2HDhq43jxuBbptvaf3RRMjgRThvrcipI6y30/6ZXfy4K8Yikp2qvqnPG
         7ir5DyczZ1T8q/PLEsuaMsaBnNdR91Oz0jlCHpJLNYfcZsbmkVdBHnih6trBhmeTkKwt
         zbl0De0ZCN1sgnBqwVLKywGAPldM0IJ1EbFNyWeHbghghjgJ3fzPLH9oa9ASvrDr7dTC
         gFmg==
X-Gm-Message-State: AOAM530XWxmdQKrF9crCP8d0c/vn2WmKfgiT5bVwAr9Tz1gKiO401WAQ
        oSPVmlFp0VFPCg05AxpnrJIE6yNGqts=
X-Google-Smtp-Source: ABdhPJzEB3i615EjY/gB5YOyY3yFKfQxVs34F/OkBrLz2D5m1aoKmT+pV3e+jS4K9kEh2H1fh5x4Og==
X-Received: by 2002:ad4:5483:: with SMTP id q3mr1228665qvy.24.1606162041086;
        Mon, 23 Nov 2020 12:07:21 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l22sm10491291qke.118.2020.11.23.12.07.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7JWJ010382
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:19 GMT
Subject: [PATCH v3 38/85] NFSD: Replace READ* macros in
 nfsd4_decode_open_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:19 -0500
Message-ID: <160616203937.51996.12129336772635835508.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fc244661b048..f0484d9c7b78 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1155,18 +1155,18 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 static __be32
 nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	status = nfsd4_decode_stateid(argp, &open_conf->oc_req_stateid);
+	status = nfsd4_decode_stateid4(argp, &open_conf->oc_req_stateid);
 	if (status)
 		return status;
-	READ_BUF(4);
-	open_conf->oc_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open_conf->oc_seqid) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


