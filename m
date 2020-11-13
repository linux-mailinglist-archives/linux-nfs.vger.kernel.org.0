Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D792B1DF3
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMPC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPC6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:02:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F9C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:57 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so8984096qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aWfsBE2P05+RW08yXSxRmQhF4B81eM8UDdWWWIeNOM0=;
        b=FctAwva34ej87HPpwLYK6g9hH3z0tVQVYiWsgyZiyulYwuDH18YF+NbVqff7lvq8QQ
         kp4uV5S9cXMwoEnqS3DbBMQvbEiyarkakxSJAu5KRqdwaMtVtSoUa2xoufxFad7TrJuY
         DUjzzmcoWQrGB5HVm6sv31GBxVnAUDl2YWGTesmhCQYgItibaPo05QZtK570+8uQ5QEe
         LKIgEs5vJCyJ5ZROeAPF9rKoybpt9FE66xpPMbW3J9vFBmrBhVM7ESbKgEv999X1rHrU
         Uqwf35zLiDprDKowVOcionXwwMh9fLAUKjVcIMJ0wl9ZSCVrbxcuU/0yXWNAEN8RHVUt
         Xitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aWfsBE2P05+RW08yXSxRmQhF4B81eM8UDdWWWIeNOM0=;
        b=cw9V7Dv3+RcVbQ3yLoIsIkh1w829EaOmU8pUHIt7DFvNEV7PwKYGb7j2+PrwTycd2k
         Mqeai+AvX5upk3cVa3v328SjU/locDUmucr5cQl5cBnl1+3jxqF0rgzMDCSu0je8tgAT
         kHAASD79RAyd17dLgn1Hrp0uxLjWB2WISmq0T33do/5jN/flzjX5uNObSvoHV3x0ERjZ
         CfXzK42Jech56wUdjRS0gvAZySlwlP2GULYF6oQARhukwuTYWLKQmA630c0Ks2qfk7PW
         FXK8msePCeNohXQxtWPMyJYjnk742jLg8kJ6RC1AQY7Kehr0b82+ND8KX4K0j2K2X2mV
         Ae5g==
X-Gm-Message-State: AOAM531IdQBa/tJnbnJxJJSnY7watyNFElvnPJDpjAls4ehe8TlWcd6J
        ucBgvMTZaX/+z4lbzY8n/q+A9TqHmoo=
X-Google-Smtp-Source: ABdhPJxWcpKsMR46Y1sW1mxWFgHUU9dx4snZP4BESQfs8dwwbwpKfGu8SXi5jcgChUP/0FNbJenAwg==
X-Received: by 2002:a05:620a:228f:: with SMTP id o15mr2470980qkh.206.1605279776726;
        Fri, 13 Nov 2020 07:02:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a200sm6914699qkb.66.2020.11.13.07.02.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:56 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2tbW032655
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:55 GMT
Subject: [PATCH v1 06/61] NFSD: Replace READ* macros in nfsd4_decode_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:55 -0500
Message-ID: <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26265d649c39..ee9ba5f0faff 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -437,17 +437,6 @@ nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	access->ac_req_access = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	DECODE_HEAD;
@@ -529,6 +518,18 @@ static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_
 	DECODE_TAIL;
 }
 
+/*
+ * NFSv4 operation argument decoders
+ */
+
+static __be32
+nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
 {
 	DECODE_HEAD;


