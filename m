Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618192BB769
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgKTUjD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgKTUjC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:02 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50CC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:02 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id j18so803220qvl.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=00+T3huLM22eOSssufROExKLfDYH3VdGFxhADh+9pnU=;
        b=UkTrVOvgdHOHAYm2Q0qbTLfnKdgPytSwAOeTuq7Ag7VLW+DnApi8AlJL4crK4CRTJo
         XFDIPQIvA4YmGMnclHI6TmYwBv28132NJAEei9fXkjUo3bmRVNCKEIthRDjeU0Ih5Xar
         YKxwgG2g+2N8O/CL21pfsP96qMbm7B8tufRsXDmQ4Lx/gOy3EWK6XdGyB0wNvF5ZkyAX
         cb8MsWfHLVC+bIPLIGyhWtrnOMc0K14p/iCb/UOaviQd7Jwnxn/pRv0lsX8iGoiA5ENA
         /1vl9jAMk89gN/tD6pDttkgHroOOVLGZlVIEEgN4uLIWLfMVzP9UQ2kPHyMaRvDaCOwT
         H0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=00+T3huLM22eOSssufROExKLfDYH3VdGFxhADh+9pnU=;
        b=q0FtJoQKC4TToEJFVTme+5SH+ViX9k0pgI2qmKaCFWN70dCHzuN5KY7d27XnVw0NSR
         nDBMoITFyovSfO6jXITFFZcvNrr9cShhkHVXGHz7W/0PvMC2pncrpHs2rFUQnoi+5RI9
         mY3tCd7KQ2yCeGS8w05a4GEsy3MRG8aRYxFoniUOvfeKycnuhdLRUQx/Blw/fqec3my5
         z8LowerLcjVxbnI8pBXLe9ORLs12YIx+C7rGltzbe8/PKvdXL/J59TrJfsWNOXj/90eu
         798Ht3T0yAfc2ctB4ysj8pjOlGGDecFMtDV/KFHBF6bGjcnLesIfNNi7I18XcXGGDjU9
         CUsA==
X-Gm-Message-State: AOAM5315zXsOeXZZRWRzUz2MJSCfXc9KOQeIOc2Sg++BtlyJHkcFH1Hd
        1qvYdjM/xsI21gSzbPP2+vkwlBdfmE4=
X-Google-Smtp-Source: ABdhPJwmPxck9ozY7U+RGeyvlbZMOOEXBpZeUFiqtxzuIyHXcFVztbOt1jBeWiRAtdvTxuWky4PQhA==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr18186166qvp.28.1605904741641;
        Fri, 20 Nov 2020 12:39:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u24sm2955772qtb.33.2020.11.20.12.39.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:01 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcxgp029380
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:00 GMT
Subject: [PATCH v2 059/118] NFSD: Replace READ* macros in
 nfsd4_decode_create_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:59 -0500
Message-ID: <160590473992.1340.1671446268080011381.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e2b0895c2a32..38a54bd9f1cb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1591,24 +1591,28 @@ static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
 {
-	DECODE_HEAD;
-
-	READ_BUF(16);
-	COPYMEM(&sess->clientid, 8);
-	sess->seqid = be32_to_cpup(p++);
-	sess->flags = be32_to_cpup(p++);
+	__be32 status;
 
+	status = nfsd4_decode_clientid4(argp, &sess->clientid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->seqid) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->flags) < 0)
+		return nfserr_bad_xdr;
 	status = nfsd4_decode_channel_attrs4(argp, &sess->fore_channel);
 	if (status)
 		return status;
 	status = nfsd4_decode_channel_attrs4(argp, &sess->back_channel);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->callback_prog) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_cb_sec(argp, &sess->cb_sec);
 	if (status)
 		return status;
 
-	READ_BUF(4);
-	sess->callback_prog = be32_to_cpup(p++);
-	nfsd4_decode_cb_sec(argp, &sess->cb_sec);
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


