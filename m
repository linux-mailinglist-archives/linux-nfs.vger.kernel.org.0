Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB57D2B1E1E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgKMPFo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMPFn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:43 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C2C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:25 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so6856005qtp.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aPofqo6TKXej4EkUb4mQaZvqVuPfdjQqbGY1MEBKs/0=;
        b=XBy0nV/LDp7BP5QX7g8YmcQIePKFTCV/rJ5q5xiBI72d2xBMf3gjdRzJYAB38N/46X
         M0+owqRGuNh7dhbiMXgzBslOqtH1BiNFDwJF6srSGB/mnJIKAiPpQ/UJOO2vStw3Z5PP
         gWfvwthgY54eQHjSb4ThNvOEogPSkSFLTdcuNDPBb2L4/Y0Xsyk45ok7avjw0MoESfqO
         uhfZwb3u6UQOk797xeFDEr0wQzD8l0OlQ2GjKPC7jLkP0ZEvCsjlQguZ7oQzPZ72OoQC
         EnG8pKfuuVoEh8gTW26lQRJ0Pbbzn8ozZC4GR7/UCU2hZaS9ZFeIqC6L4XDy9n9RZaQc
         cjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aPofqo6TKXej4EkUb4mQaZvqVuPfdjQqbGY1MEBKs/0=;
        b=Kds2PlO2gaPXmepCMFKSNxxmhHrZcfZqO6vq5dmok3oQaTzoAgaGL3zhOmllTCT8eg
         Y+QoHuDqWrYomrfLh6Ab9gd5qOc9Y0t5b+mQIt4GG33cO7dsfp8wVbQANUATGxzWZSY2
         G+o3BHqyW8lfNuQujlgXRC6kJNBrV0uqNK77LKL8QZW8TbH+gayhyyhlKiBcsB53722i
         Wzv/55P+O29wLsd9B50gqbk3UsUx2osxe0frxuLn85xfxeEYi7gmNXD6cZugRivbIVcU
         paps/c3AkHPmiREOvnP1AThcX6iXS3SqFd90XCGcDZMahddilZPWBUkJrtkfTJ/x+9AA
         4hcQ==
X-Gm-Message-State: AOAM530HSWnqEIEby6c/i5UqdOiudX2QMHclZtOcNOwLcPH5Iyw/iY/0
        ylhGerDgvP4zR8baLzWu10ht5imPvbM=
X-Google-Smtp-Source: ABdhPJwQFwtFpu1IsYHWqcGq0Pm1UTdjx6Cur8YqRKNmrZIptucKLTwn9r/PJFDeUFrWHFa553mGmQ==
X-Received: by 2002:aed:2d02:: with SMTP id h2mr2246380qtd.96.1605279923492;
        Fri, 13 Nov 2020 07:05:23 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r19sm6496972qtm.4.2020.11.13.07.05.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:22 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5L8I032739
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:21 GMT
Subject: [PATCH v1 34/61] NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:21 -0500
Message-ID: <160527992189.6186.5049295918269412471.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   73 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4a71346dcd9a..2d2034d7f48e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -570,24 +570,22 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
-	DECODE_HEAD;
 	struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
-	u32 dummy, uid, gid;
+	u32 dummy, uid, gid, i, nr_secflavs;
 	char *machine_name;
-	int i;
-	int nr_secflavs;
+	__be32 *p;
 
 	/* callback_sec_params4 */
-	READ_BUF(4);
-	nr_secflavs = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &nr_secflavs) < 0)
+		goto xdr_error;
 	if (nr_secflavs)
 		cbs->flavor = (u32)(-1);
 	else
 		/* Is this legal? Be generous, take it to mean AUTH_NONE: */
 		cbs->flavor = 0;
 	for (i = 0; i < nr_secflavs; ++i) {
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+			goto xdr_error;
 		switch (dummy) {
 		case RPC_AUTH_NULL:
 			/* Nothing to read */
@@ -595,24 +593,32 @@ static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_
 				cbs->flavor = RPC_AUTH_NULL;
 			break;
 		case RPC_AUTH_UNIX:
-			READ_BUF(8);
 			/* stamp */
-			dummy = be32_to_cpup(p++);
+			if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+				goto xdr_error;
 
 			/* machine name */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			SAVEMEM(machine_name, dummy);
+			if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+				goto xdr_error;
+			p = xdr_inline_decode(argp->xdr, dummy);
+			if (!p)
+				goto xdr_error;
+			machine_name = svcxdr_tmpalloc(argp, dummy);
+			if (!machine_name)
+				goto nomem;
+			memcpy(machine_name, p, dummy);
 
-			/* uid, gid */
-			READ_BUF(8);
+			/* uid, gid, gidcount */
+			p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 3);
+			if (!p)
+				goto xdr_error;
 			uid = be32_to_cpup(p++);
 			gid = be32_to_cpup(p++);
 
-			/* more gids */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy * 4);
+			dummy = be32_to_cpup(p);
+			p = xdr_inline_decode(argp->xdr, dummy << 2);
+			if (!p)
+				goto xdr_error;
 			if (cbs->flavor == (u32)(-1)) {
 				kuid_t kuid = make_kuid(userns, uid);
 				kgid_t kgid = make_kgid(userns, gid);
@@ -629,26 +635,37 @@ static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_
 		case RPC_AUTH_GSS:
 			dprintk("RPC_AUTH_GSS callback secflavor "
 				"not supported!\n");
-			READ_BUF(8);
+
 			/* gcbp_service */
-			dummy = be32_to_cpup(p++);
+			if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+				goto xdr_error;
+
 			/* gcbp_handle_from_server */
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
+			if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+				goto xdr_error;
+			if (!xdr_inline_decode(argp->xdr, dummy))
+				goto xdr_error;
+
 			/* gcbp_handle_from_client */
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
+			if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+				goto xdr_error;
+			if (!xdr_inline_decode(argp->xdr, dummy))
+				goto xdr_error;
 			break;
 		default:
 			dprintk("Illegal callback secflavor\n");
 			return nfserr_inval;
 		}
 	}
-	DECODE_TAIL;
+
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
+
 /*
  * NFSv4 operation argument decoders
  */


