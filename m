Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3B2BB758
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgKTUi0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731363AbgKTUi0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:26 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EAC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:25 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so8128189qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PWguUzYNnh3rGSojCDdJQa/ybBo6UlRXaLrHLvCuuko=;
        b=YSxI6jcbTTI2Joe61OsrlUXXsAL17DLlFQsOT4Z63dKLEu+lYE+psMC0yFIRo8hSA3
         sAJd47cJ9/qFaaMjTOsuRY++5DIOYe9+MakTx8lgpOUan50c/hQCEVUBYogMcUbOX6Fz
         RtlRRjqoW9G4cFYmYKvCRDuL7b7UP5LGmIkCbpRFO/JYWpbJN5HIcre4cFF1tMd5sNPo
         GPqrlwBrJ4EapeQecKhYZk8E8QkJ4MgS3YQdpo6lpQ6FhLFSmt5dleUyKhgSr6Xsdwml
         HL+a431pQs7xxPrmh6E9weIffisLchtgQQsHAfZMFoYGOUyaAda9EpdojbkqoT1wCkYN
         egzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PWguUzYNnh3rGSojCDdJQa/ybBo6UlRXaLrHLvCuuko=;
        b=C0oJq6NLPu4RdhUarqWFhrLiZz4YgiFR3/AvNasEF+5BH0r4sgvRBY7SqA2ADMmZ48
         9lhZW0X0iYy5IxM4pPnEng+5SjqXBVR4t8rZtdxmyPjvVqf51u9F2qttpaBWTJsl/A6O
         0xVqzlCCW8Nwj6v+YQcxil88Xvf6HWfBdX6IL7MP1KKoBJHThlBOa81GpX3qOvf9ZVZd
         QRvwBKgTwX0pPXo5uGBMmUoZjvRTRim9ZvgzbWpZAH6f08y3KWp81iT4G87lSPdrJorS
         n8183o92CS9Sm/rncMBBt/lPtULOAUeHf52Zq3u424Wo2qqtLZnvEQgA33yJcc5ycBRy
         4cEw==
X-Gm-Message-State: AOAM532QE66Ii6fgfj5lU4SxZolhMezOh0TZavnPouV9r7UC41n16sAk
        +BLs/qn9xW0Vqf9XfYzBOohl7FXwGr4=
X-Google-Smtp-Source: ABdhPJwfhD3ACoBen9KeDEzZ2GCXVs4J0Bi+tidEUepkRBhKvq8q0PCKQ8581o8lWhfE/FhANPghDg==
X-Received: by 2002:ac8:4614:: with SMTP id p20mr8295305qtn.346.1605904704839;
        Fri, 20 Nov 2020 12:38:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm2741788qki.2.2020.11.20.12.38.23
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcMsI029358
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:22 GMT
Subject: [PATCH v2 052/118] NFSD: Replace READ* macros in
 nfsd4_decode_backchannel_ctl()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:22 -0500
Message-ID: <160590470293.1340.2134119984606842595.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d9c57b2f3fcf..82282fceec5d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -733,17 +733,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	bc->bc_cb_program = be32_to_cpup(p++);
-	nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
 {
 	DECODE_HEAD;
@@ -1428,6 +1417,13 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


