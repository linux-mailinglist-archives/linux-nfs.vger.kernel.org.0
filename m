Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576532B1E1C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKMPFa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:30 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BDFC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:29 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id d38so3362425qvc.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yA+DP94Pfqfd4BIvF3KjEjwpQ4b7os8QlMhrDBLPiEw=;
        b=sQ0BNjtgJmwHWq90/2A4+dC0wbv+nz1DVT3bUw9TEYwramzHIw/xSCyu1V8vA8iOON
         W2dj/t/3UOz7sl0ACLxjqxzqMsWjbuTJw71FLLUroGX4kjlYjAIpltdYbQTxKZfBFanC
         gn5Zv0/ATn2hlIfkSwO5HYM2OFQW7NXudpIY4y16nKAju5MysB/elSlHIZpz6mQKr6FM
         6bCshyMD3HWiwuMc9ftD2R7E+Wfo+QQoM+gYPzbv+fmSC6EhC4Q+AE/OTyQqguJVhKxR
         mBQ81rwWeJv2OGn68Txioy7B8unL9CvUDJjweGVrfDUK7WyBF5d3p3RUSPzm5yMEVaTJ
         hMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yA+DP94Pfqfd4BIvF3KjEjwpQ4b7os8QlMhrDBLPiEw=;
        b=ch2IyiWnKcFB6kOeiqnBMbT7h5FlV9o3K3qOd+P5Ig3OANGcFbh7qG4ph/zzwQtr9f
         MkvNzZHVPDvkoTDC6lfzGvtxUpJL/bmGYsJ2mu0RmC+cRLyouev5SyXjO8/DylGGhCQL
         w8lqerMsD0o9stxAtC7gXc0fYDoPxzxJj/edBIiYR6GPvM0k1xuOjH/z4ejR8ubnLV2s
         Jdab+SmlCJlwabz5wONblI/LJKpWdYQ2xheMT/yyJoOYfzoxDnvLGtiewYa3cuUaXT+t
         C1Whw2WVooQWL2YIx999YrDylzGLtxCThbK1yy3I7GFzThhLoAECry04/IaN25aSsLAu
         oQeQ==
X-Gm-Message-State: AOAM531U3D1IaHQl9rWgNc4IB+4JxaYXQOYpIgTaPiwN7cCRd5r34Zgb
        AL2bcbqcY6kzanLkTqXuNQL6uKvqiPc=
X-Google-Smtp-Source: ABdhPJzHoFPltoK6gkBf2RjImr2qJyuD28qDi6uth/1z8L2ET9VrHQjWd2bazvicZ2+HCNZBWC6c7w==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr461445qvb.54.1605279928831;
        Fri, 13 Nov 2020 07:05:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r18sm6801662qtp.89.2020.11.13.07.05.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:28 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5RwN032742
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:27 GMT
Subject: [PATCH v1 35/61] NFSD: Replace READ* macros in
 nfsd4_decode_backchannel_ctl()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:27 -0500
Message-ID: <160527992717.6186.7292700826290967478.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2d2034d7f48e..ff466bea0084 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -678,17 +678,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access
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
@@ -1450,6 +1439,15 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 	return nfserr_inval;
 }
 
+static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
+		goto xdr_error;
+	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


