Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F72C15A8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgKWUGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgKWUGI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:08 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE20C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u184so3652975qkf.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GbbuIt6bNV9R56FKI3sLcSwWIUfDrNRC3We1Pu2tUGg=;
        b=R4N5mxMYYWuh5n7knvssW+GKhkOALNSbxT8+R0OE7ItZmquE9MgenZM2faZzFZpkzb
         B7sYL2Gin+BWxMhVkpvKull/bvK/RI9Pj12KybV2LmlcCFonc3RhcyNriIblgr20McW7
         hWgEY8GAjbS182ZgsFHTVSi4qDH6KrbwIrcz4ErDF7mLroJ7PzsZ5yqJecAaO83/pKA3
         QGxEOl/KO8kT9nmSkBGA/oWzrDc7Z+GBtYPQ2TorO+OZKW2kEcRAl7dIlp/Bl8EDd/Ev
         OhJfwBbjwv+7Wml/FT321dukZOfkDX3SGis11eEo9wsxApXB3bcFfyL4I2o/w1o5NjTe
         sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GbbuIt6bNV9R56FKI3sLcSwWIUfDrNRC3We1Pu2tUGg=;
        b=IlUSiMzg8ajDCfL1RA/Nf9PQRN9Jopitwkrx/DKFoT8yjR7uT55HFqcBV4Y2Q8YKIE
         hzGFB+ITLdtcLQiRMD3EvzsNMut8Pua6Oo51/WAticbXJ11h+/wuX6DszQZC8LlNs9RU
         FgC/isld6u2wkj7fS5uZHe+7XTvT2Br2t53dpSaozy5eRCl0K3ExuQFx/g/GAy2AYmAT
         lkLw1t2hZtPdMwTDNCKTTYHYM18lp9g9wc0+2GYcRdwvcsl05t/DrOKbHuc4qEnlImJL
         AoBswMZwwFdLMjKw/SpVb/Pb8ujlxw2r0DkPp0zLe6gjKBsyqrup9BBDjFRjnmuS9jqg
         /JDg==
X-Gm-Message-State: AOAM533GvSuTto59uoS4WNH09qUUGwPwaqznUJXPIfvBcVQc4NX/KW1J
        fkHvUAkQVsf2HsKE03dl9QrGj9TtOG0=
X-Google-Smtp-Source: ABdhPJyL7CgiSsEz5nDuHLfQB7TXgox5y+PV7jBIsAWjIcvqAlad3lcv5fbaGZ2jibJCpDL3jDh4TA==
X-Received: by 2002:ae9:c001:: with SMTP id u1mr1306105qkk.74.1606161967025;
        Mon, 23 Nov 2020 12:06:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b64sm10354147qkg.19.2020.11.23.12.06.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK65ei010340
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:05 GMT
Subject: [PATCH v3 24/85] NFSD: Relocate nfsd4_decode_opaque()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:05 -0500
Message-ID: <160616196539.51996.2006468103191305772.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable nfsd4_decode_opaque() to be used in more decoders, and
replace the READ* macros in nfsd4_decode_opaque().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 472d715e8632..a8e0cf30b073 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -207,6 +207,33 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 	return ret;
 }
 
+
+/*
+ * NFSv4 basic data type decoders
+ */
+
+static __be32
+nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (len == 0 || len > NFS4_OPAQUE_LIMIT)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, len);
+	if (!p)
+		return nfserr_bad_xdr;
+	o->data = svcxdr_tmpalloc(argp, len);
+	if (!o->data)
+		return nfserr_jukebox;
+	o->len = len;
+	memcpy(o->data, p, len);
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
 {
@@ -943,22 +970,6 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 	return nfserr_bad_xdr;
 }
 
-static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	o->len = be32_to_cpup(p++);
-
-	if (o->len == 0 || o->len > NFS4_OPAQUE_LIMIT)
-		return nfserr_bad_xdr;
-
-	READ_BUF(o->len);
-	SAVEMEM(o->data, o->len);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {


