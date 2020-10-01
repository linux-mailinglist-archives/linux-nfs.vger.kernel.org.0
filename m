Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5390280A9B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgJAW7A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC723C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:58:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s131so39933qke.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KuV3dBIsxavGBuYK7B41fhlln1/F6q/ozvwmeDWHoa8=;
        b=vAFRsUhNUJLw/zn/IOQ6FNcinC848NYehe1+wGJUE0dW6ZzFBcGnv65j6SW1JCawUq
         IXUhoy2iC9oM6OjnSrEmAawegY+5/agnNBL253hOC3Ddf1ztcYlUdQCD2gR21pRfCSj4
         W+UFJpwOaosxOYOhqJ00aC/ZwPrynKdNu0rfziEldIYjq2VPRKihndbw1GKaHug8gRma
         9/Lzw8eOaB+8WibEpT/VrK6ngGw8NL+swqiIjUoMS2xrlx3+ptjKOBcLBL1swjpDr6S5
         5mKXbELDguEpeBZsosHGy4eHvwqV0+07MRVEbJ7he0xXoG3FSWL1K0EBOc77fL0o2Ld/
         4Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KuV3dBIsxavGBuYK7B41fhlln1/F6q/ozvwmeDWHoa8=;
        b=J/pNNG8kPRu43L2VDjnf1hURw5VigU9la84Fse0iyA8NWZh1WqqwFpRzy/uzA7hFEd
         gyEglIfd7p4fvKeGcfHpvSceDmojReEHm8bz0up+NuIKwEVkrlm2bmt4JpK3FEEGo/Rs
         lcMHErtMqG8Nl5BLiU+1duAcbq2VjcAjRbtJKiM3TCIiYnyrkQLU7+iqSf3AVRq7zrIL
         bWohabjbVf2eYzuH9EyjrE5W6z2pyEPC4MX/eUUmcezCRfI8pkpZgmfEupWl9om6QjLy
         EAcaKSIRQcMQ9vfSsJTy4x9/PFiOpGYNSC3BP7rXmGnfMXYGNfh1jTmL0vxScb26NxJN
         kKGA==
X-Gm-Message-State: AOAM53293CQL9ot/UMOAzUkM6/eEDm78rCKfEi4xdAdpCsdSMHVe2UGt
        pNd7QIHgx+k9jiOBL5wjnZqCh+hvLSHiqg==
X-Google-Smtp-Source: ABdhPJxdr3Zuqye34zEa8WTYWymWiVnKE1oMPQKRdlcG9IcZXiThj6REch2VBdfPiOdjQ+nbaVZTHw==
X-Received: by 2002:a05:620a:c16:: with SMTP id l22mr9926719qki.121.1601593138670;
        Thu, 01 Oct 2020 15:58:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z3sm7461890qkf.92.2020.10.01.15.58.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:58:57 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091Mwu0L032568;
        Thu, 1 Oct 2020 22:58:56 GMT
Subject: [PATCH v3 02/15] NFSD: Add missing NFSv2 .pc_func methods
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:58:56 -0400
Message-ID: <160159313695.79253.2027381422043199787.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's no protection in nfsd_dispatch() against a NULL .pc_func
helpers. A malicious NFS client can trigger a crash by invoking the
unused/unsupported NFSv2 ROOT or WRITECACHE procedures.

The current NFSD dispatcher does not support returning a void reply
to a non-NULL procedure, so the reply to both of these is wrong, for
the moment.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6e0b066480c5..6d1b3af40a4f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -118,6 +118,13 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 	return nfsd_return_attrs(nfserr, resp);
 }
 
+/* Obsolete, replaced by MNTPROC_MNT. */
+static __be32
+nfsd_proc_root(struct svc_rqst *rqstp)
+{
+	return nfs_ok;
+}
+
 /*
  * Look up a path name component
  * Note: the dentry in the resp->fh may be negative if the file
@@ -203,6 +210,13 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	return fh_getattr(&resp->fh, &resp->stat);
 }
 
+/* Reserved */
+static __be32
+nfsd_proc_writecache(struct svc_rqst *rqstp)
+{
+	return nfs_ok;
+}
+
 /*
  * Write data to a file
  * N.B. After this call resp->fh needs an fh_put
@@ -617,6 +631,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_xdrressize = ST+AT,
 	},
 	[NFSPROC_ROOT] = {
+		.pc_func = nfsd_proc_root,
 		.pc_decode = nfssvc_decode_void,
 		.pc_encode = nfssvc_encode_void,
 		.pc_argsize = sizeof(struct nfsd_void),
@@ -654,6 +669,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
 	},
 	[NFSPROC_WRITECACHE] = {
+		.pc_func = nfsd_proc_writecache,
 		.pc_decode = nfssvc_decode_void,
 		.pc_encode = nfssvc_encode_void,
 		.pc_argsize = sizeof(struct nfsd_void),


