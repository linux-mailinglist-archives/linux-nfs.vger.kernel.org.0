Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486022C15AD
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgKWUGf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgKWUGe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:34 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E42C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:34 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so14313340qtb.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2LwNUUWkDti5LAK63SJ53gwcMiEFz/uOOwzDlwjofOA=;
        b=QN7aCGWLmXeSmelozR6pCsvXGEKvV+F7bhpZA6yJcwiuek4mDGx2MBE0f2E5Ve0NIR
         7sA7F2y371+YgP2wKYQbcbFxC4MlUQThTy0MyGX2YXXEo8mATK0BMv37TL/Qh4rii1aN
         6OBMs9GQlcrXl9IdfFM+Gc3VADIWbAZ6+uvts1eIYposMA3mJ/h0TEhVb7Nc1aVu9Jdh
         YurBSqvP8YnQKse6F9/Qcv07NUtTBfJNHppjJIiV2MFD17hD63MQQoa9ESU66fUUVopt
         yhgnoISgQzgwE8UlFfLeg53qh8wNBGXaihqnrOPyiXP9rnfpdYIUVZu8DOECgpCLIwRj
         7NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2LwNUUWkDti5LAK63SJ53gwcMiEFz/uOOwzDlwjofOA=;
        b=hHcgLgfFKALwtESrSi/ypVh7ASPl23+TWWDV66jBrAr+xG28z6ST+GN3AyoefA4bbD
         4fW5x6IoYuNlniFmI6Q6MmFLaBSSgD595RS5J+4SfD3kjl6jvKTM6OiSJrgxxp9z/RIx
         YT7LdfXS5dz6kX5/d8G19SrvgQWefvBDGEyAoWQEKkuQR5TcjHCBaXJkJ05OKyKR3uS9
         L6+K902ujvNQF3fgKMi83FabOVrqp2f2SWB+K4X7J+nO/mdquTaHo1gGoBy1m7hvU1c7
         RCKbcdTTHoJpPXNG9MASJSeJmZYGsFaKgyUzGL0ZWDj37/9Fm7tpN0lD4YuCqyzlhnLl
         Gbsg==
X-Gm-Message-State: AOAM530nM0+q28hxu2Kbv/pJM3B3xPxu7TN9O0LoNjp5lpf6UtdM4y5Z
        t2EnyQEQ4Eyuz4KM8sqGyrcNLHmNPug=
X-Google-Smtp-Source: ABdhPJy4qAq2fwhIyiwThH/NLMYWjs9N4BvB+X5yq6Et5VaGOa3UF6T6IRxB68jJP6GyC1z+A9BbHA==
X-Received: by 2002:ac8:130d:: with SMTP id e13mr883844qtj.3.1606161993489;
        Mon, 23 Nov 2020 12:06:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r190sm10255717qkf.101.2020.11.23.12.06.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:32 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6VuT010355
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:31 GMT
Subject: [PATCH v3 29/85] NFSD: Replace READ* macros in nfsd4_decode_locku()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:31 -0500
Message-ID: <160616199182.51996.8327994885103199696.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e2bdc69db4f9..0e7032030cec 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -909,21 +909,23 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 static __be32
 nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(8);
-	locku->lu_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
+		return nfserr_bad_xdr;
 	if ((locku->lu_type < NFS4_READ_LT) || (locku->lu_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	locku->lu_seqid = be32_to_cpup(p++);
-	status = nfsd4_decode_stateid(argp, &locku->lu_stateid);
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_seqid) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_stateid4(argp, &locku->lu_stateid);
 	if (status)
 		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &locku->lu_offset);
-	p = xdr_decode_hyper(p, &locku->lu_length);
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_length) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


