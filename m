Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC50B2B1E16
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKMPFK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:10 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6017C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:09 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id b11so4698622qvr.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+jVRcRBy4kdonFvOYvkqx8Zys4s9YbgDXzHUnlo9VX0=;
        b=IKJ9D2rVMGzaMEeq3p7YiAIL2VMPdLozJcRyvRV6Qnm5SIawxs8ujw/KuAjToUxh5d
         kf7wcquPbkjJkcaeYZx0Dpu/5tiEEUbeY/zYfipoHYpLugU/MfUxuB2kdr0nMPgUOoiM
         SSem8m8qZVOl00Iql0F4LtcKl1W50TjaxWmioriyd4N8fe1w+W88r1XDyhtqEQ6reNa9
         ovQBmdTS53HXYksDijITLYRK775VIqcoyO3rm9qgjOWP/lIwLYbnS1ypf+LB0gui3JYn
         Y+Czq+nfhNDLwSV8jhPxTICYg8/euacvucUeYndIJhtGTDKoSUDt7fyZJaC/i+XB/ukv
         0VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+jVRcRBy4kdonFvOYvkqx8Zys4s9YbgDXzHUnlo9VX0=;
        b=uU1+dhuJqGemCaY17VsVk1L6DSvkXQouDfG4esqv5GUX+Kum+Q/8Nn5KAE8VXkwrIa
         KMVWrOckEGXVlUR22Go0UWFulgNVACbki5ywj4+gmueohmZ/5tY9lpSELdtV106MonKl
         6vvvTBQcRbPZxT5tUQ/bz0X4QCrKHZIVlKUf1p8tVvVNwilloIDBCOSraOfdNPcfV/pJ
         ZKSjrV/H0qFOWM0p2X/lYWs+lW8JlPX+z3sT9m6PVpCphM3YIr2vn2cVkMk81evk7r0l
         6ZL7ObUNF+yhEtcq8uJqJhZxBki3+mZ+dxN654YiVqub6I7h9zYK9B15C5NoaGN1+j2f
         4C7g==
X-Gm-Message-State: AOAM533MvZfi0zVq2tbHIfq3eyrDm1eO/ovwK8CHvQoOqc95qDBGyZ+B
        CECkLlAM0zWq2a/uMlSR8qpeoap7ut4=
X-Google-Smtp-Source: ABdhPJx2xN2VtJPosGiyzeZEgqm4woz3x+VhheEzel9A0fEUPrLg8wZN7qgpxzGR/9H7yvu04B12gQ==
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr2615391qvu.16.1605279908000;
        Fri, 13 Nov 2020 07:05:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t188sm2482794qkd.45.2020.11.13.07.05.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:07 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF56cb032730
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:06 GMT
Subject: [PATCH v1 31/61] NFSD: Replace READ* macros in nfsd4_decode_verify()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:06 -0500
Message-ID: <160527990625.6186.11138759150096411072.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a6d6f999433c..71a9bdb67d06 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1356,7 +1356,7 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 static __be32
 nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
 	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
 				      ARRAY_SIZE(verify->ve_bmval));
@@ -1366,12 +1366,22 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 	/* For convenience's sake, we compare raw xdr'd attributes in
 	 * nfsd4_proc_verify */
 
-	READ_BUF(4);
-	verify->ve_attrlen = be32_to_cpup(p++);
-	READ_BUF(verify->ve_attrlen);
-	SAVEMEM(verify->ve_attrval, verify->ve_attrlen);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u32(argp->xdr, &verify->ve_attrlen) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, verify->ve_attrlen);
+	if (!p)
+		goto xdr_error;
+	verify->ve_attrval = svcxdr_tmpalloc(argp, verify->ve_attrlen);
+	if (!verify->ve_attrval)
+		goto nomem;
+	memcpy(verify->ve_attrval, p, verify->ve_attrlen);
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 static __be32


