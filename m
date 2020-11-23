Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9A2C15AF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgKWUGq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKWUGq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:46 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8DC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b144so3722489qkc.13
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7TwKR+cqMLnMzIbY8s27CBZOggaFds2ujj1KFsTMYhM=;
        b=Xok1TxWbvg189mMty2hYBAU0F6hOc871mXjfDPJlTrOTgN9cV/A8Kfemq8SdZ3Cdj7
         BCxv4OZVQGC32fshWavro6LO3YYW+KIslIDudWKTNb87ikgKEi9ppsHUYf9t+u+2C+Vh
         xJNVDwOvo3TwiVicBs0jxq4i/Od/V6T/LWoJoui4QdlkuaGkUo4UISR/bLjI+/5up4Cl
         IsrAnwTRNlRFYuvGnbl4oICnHrmwGr51IIuZGBPn73/Ac0TU3TyuE/dNv3xpEbd7zp4G
         8mHVIREuwaZ+f6QSYgodpdq4J3LdhDdZ8iC+HPjMLEtxtKVsekQg/T55pGnly3y7WBhU
         GFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7TwKR+cqMLnMzIbY8s27CBZOggaFds2ujj1KFsTMYhM=;
        b=Pc/RzuDHmuJgOrGiQpE8FtK0DnfqG86uUhOmRzN9DYMGRenLW7zxJkBzSPrsyWcfUO
         6nlwMgG4nYkfHOSorGtksGI1YzpJNwYxgEoWAa7QEANtZXRhy+flZGOR26IsHjtuNPQP
         uzfwPRsiV/+3YqmnPQ3glE6/o/w/kzcgV3WWdWsQl8ztTGu2cE/pXGJ0DAo+xe7Ior1q
         Pd/V8cBBYwnyPXGmYkQCbkLYCB75FUd1gEkmWtFUPW7CO0jHFvA/gxew4uFO+j6OMYuz
         1U5Tffc780u+dQO05z01YO8ulguC7nyGHuJpveuY4K44ZbIjbtEVm2iHh68ktARZqAm4
         aVDQ==
X-Gm-Message-State: AOAM530qRNBjhjL+Y/9dIHe3bgvsU3TsnByF9+yXIwAmCr5pxxjwRM2C
        f+32LwmzySqxRfs42m7caF6Q1bCeLlI=
X-Google-Smtp-Source: ABdhPJzACqnVotwnCQhQlnZJU0K/6g+NPrDiyZuyDrYLlZfmbI409HbClHWd3JofBHIIg8DYhskmLA==
X-Received: by 2002:a37:6697:: with SMTP id a145mr1286135qkc.296.1606162004120;
        Mon, 23 Nov 2020 12:06:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p128sm6173745qkc.47.2020.11.23.12.06.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6go2010361
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:42 GMT
Subject: [PATCH v3 31/85] NFSD: Add helper to decode NFSv4 verifiers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:42 -0500
Message-ID: <160616200239.51996.5356570219804246528.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 4c2a7b4877ad..7254c9e4e825 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -284,6 +284,18 @@ nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
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
@@ -1047,14 +1059,16 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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


