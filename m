Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6631F2B1E35
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKMPHM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgKMPHM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:12 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2EC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:12 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 199so9016639qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JbWgFE61PLjU9GAdj0oHrl8/eNQKOjfOnfeODNsr/aw=;
        b=OxZH50dn201x4ugxYa/GyhnNCChAPeddxyQIr4N0pfWYeqlvfszUWlgNKPhZTnmLY3
         O5me8OCKOprv0aoKXhjak8xiO4MNxPtMAbk7K3x8DRgabDa84bopts+vjbAlkbA6fXHg
         UtULg9LYmS9sOweaSkvfAq5P2+/kqARvElhtM3THWGR09Gb+bywI8RXRNXDFWnJwtgHZ
         kPHD9PUZkGIoD8tmHNrM60V5C6sAGfndZlJsIZdKmZ9BQ+LiCTIJ4PMiien6LR55Vb5J
         pAIv3Y/pwilVpb5wc17XFaVd9z0uXn7mkuMLLngMpAmxHR25oYcRQBZsv0vMXdWoDeLA
         WCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JbWgFE61PLjU9GAdj0oHrl8/eNQKOjfOnfeODNsr/aw=;
        b=jhIjhJMOL7/RPdIjaOGt9Z5QbLY05AKgrY1G4qquLspjVPftrs1A1RlbGa5aV3qBIT
         9yKw/v2tT2excw/2cvxr4D1ddBLffvbbLS3ei87sxVj5dV4ZrA9Ek1eY9kOYtENjiyH+
         S/TsGbQeZsSMxOEYzanqnvyIelCJx85WFlNUrFd7S24EuIdgzi/zReZNPLEDtWl08Pgh
         yFt/xWtqreUsKJxjpfKduDYe1tPe7W8xVMwt+CX2yNrcd5NFWWHXwzAAva7CCq2Z/60V
         /TtSBL3xDSxtXxx2UjhhBzvJBkCsJ4e2tkBjHUikLcB48ml7ktrBH/tfr/IeeghPAVJ/
         cI6w==
X-Gm-Message-State: AOAM5333wk7r0DVEpyY+q5OeA6OMrEvBmIWbc035GeCuk2STWzascVkF
        YKFEvXJVkeHvCKVnlevaeeeOzcADl4s=
X-Google-Smtp-Source: ABdhPJymmiUeQhJ0W8SI7eFa5AaI3HhfbfP30+a0XG7Hd19g4g7NT9s/IjuK71fB7O9vxfEWiGH41g==
X-Received: by 2002:a37:4d7:: with SMTP id 206mr2370948qke.233.1605280029539;
        Fri, 13 Nov 2020 07:07:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q11sm6616807qtp.47.2020.11.13.07.07.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF77s0000331
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:07 GMT
Subject: [PATCH v1 54/61] NFSD: Replace READ* macros in nfsd4_decode_clone()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:07 -0500
Message-ID: <160528002768.6186.12249785285512383070.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9afdb83c5c23..7e969f04f62f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1968,20 +1968,26 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
 	if (status)
 		return status;
 	status = nfsd4_decode_stateid4(argp, &clone->cl_dst_stateid);
 	if (status)
-		return status;
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_src_pos) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_dst_pos) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_count) < 0)
+		goto xdr_error;
 
-	READ_BUF(8 + 8 + 8);
-	p = xdr_decode_hyper(p, &clone->cl_src_pos);
-	p = xdr_decode_hyper(p, &clone->cl_dst_pos);
-	p = xdr_decode_hyper(p, &clone->cl_count);
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,


