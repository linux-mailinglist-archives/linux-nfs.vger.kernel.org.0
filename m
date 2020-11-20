Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A92BB73E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgKTUg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgKTUg2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:28 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D19C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:28 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so10164416qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JZa5SATEjQC6Sdr0i1+ApJy7kslg+KrUqQhID7q0fHM=;
        b=vb6hK7URDjtVMoh1/rNC82V3tpN6XwRZbCQ1moAucuxpZxluSFnWY773+YVgkbje2R
         dzlxBzvFWKbLQ4Y3SMYq0wcjLIy0NgitB/ytYOwNGDcZseU+ppgbts8SU2rgfoCFkA1p
         imyyIuU9rjpcwMXofU8cSWa5hCvSy8SVi/6vWFFpwz17aOt4IQ411zWB2xw9ENTs0R+F
         /v4bzyFtcjMMSig0+DF4//zDUPcWx8kxHf91CKjZcMnwpOl5tbhkubg0Y77LCd4csCbv
         +7n4UNsT6xNux1yL3RaQEGCCu3OLTQIp257g+6cmAo9z7jfzy4AXHYtX9MDNj/MomB9T
         c8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JZa5SATEjQC6Sdr0i1+ApJy7kslg+KrUqQhID7q0fHM=;
        b=tHMCsYXmPcJz6TfWAJBxLMYv0e4bHGkFDypnG4kca0qTM3doyHoTo8FuvkbN+qoapn
         siWcvXKIfCI5BT8hDVsGX6mlyCLMjc4cpS59TVxmIfNmbbC79XDV7Mlwdu72aroBiVEv
         9b94OeHCThkypgyTCGqKKwJvKuIjGOKMfcACkjHbd36BTKEf2I8HExa+61lQRIIFIN68
         mmvzbi/KBGNMn4jmcTBASOCWl8rQtcRNBMyerxIAvsPWLq0ElRUObeZ9rFMsH8Occ6ul
         Ir/bBSMaxxEz3LXXOkDod9SFyNin/2a9e+eGMSD27Hm/ZM65jh1NyhYaTu5lQ/0a+pNx
         tU1Q==
X-Gm-Message-State: AOAM531fFc0/kjPBKZMbjRmGrqMH5vghsOCCGCsYsgZJU71YZVVcSWIJ
        7b5HBu5eQRKtAYutF27peaBbYc4AQEA=
X-Google-Smtp-Source: ABdhPJydYhi53vre8EzVy2OgFlGvKwRJPMAVTQI1g8LLUvu/RgNph/bvuDFY5VEqO6rvcsS+rGGdAg==
X-Received: by 2002:a37:f513:: with SMTP id l19mr18954462qkk.36.1605904587474;
        Fri, 20 Nov 2020 12:36:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v15sm2562491qto.74.2020.11.20.12.36.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:26 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaPr5029292
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:25 GMT
Subject: [PATCH v2 030/118] NFSD: Add helper to decode NFSv4 verifiers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:25 -0500
Message-ID: <160590458582.1340.15461865911567448466.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This helper will be used to simplify decoders in subsequent
patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2fe719f64ec9..1bbb637d4625 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -282,6 +282,18 @@ nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp, nfs4_verifier *verf)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_VERIFIER_SIZE);
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(verf->data, p, sizeof(verf->data));
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 {
@@ -994,14 +1006,16 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 				goto out;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			READ_BUF(NFS4_VERIFIER_SIZE);
-			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
+			status = nfsd4_decode_verifier4(argp, &open->op_verf);
+			if (status)
+				return status;
 			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
 			if (argp->minorversion < 1)
 				goto xdr_error;
-			READ_BUF(NFS4_VERIFIER_SIZE);
-			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
+			status = nfsd4_decode_verifier4(argp, &open->op_verf);
+			if (status)
+				return status;
 			status = nfsd4_decode_fattr4(argp, open->op_bmval,
 						     ARRAY_SIZE(open->op_bmval),
 						     &open->op_iattr, &open->op_acl,


