Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589C2EAE53
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbhAEPbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbhAEPbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:01 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2FC06179F
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:10 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n142so26774651qkn.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qo76xpLcKBnS58A413kyRClIdq86F+9xZlxhfW2Jr1k=;
        b=nTnIiKntaTSEqOId194RrRjaOnaMLeSKguDiHMO8RX1IpRstRprVqaKGBbJGYoOwve
         E5yw34tqZtfPhj2sl8oqFkHMY6Qs/P3Nt84XMY1jd/gfY/s795FSqXoZmc1CWSQBgQzY
         dqMoaw1Op1+0skhy/EIYO9d+A5S9YOFp34dL9uFdq3tyeevh+KRZirpsp23r8i3c9egr
         dKrzlC/ntvVn7uo44BMeV+3LMriFHLIWbdxz2W/OYKmx8DcqFdNLi81nzukqaHsott0g
         LN97mqJgdTN9ur6U3H7UnK3uwt6PJyOk1zfD+LDCvSzAphup5/jnsPy1DRS3YQ4O4yt8
         7B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qo76xpLcKBnS58A413kyRClIdq86F+9xZlxhfW2Jr1k=;
        b=NbZLpvgPOSL+sD3xdS46Hav2/IaNQyHsRGr4JrC1+O9dL53VYxoKe0eoyliMtiBK4z
         OKCXAbwOrsrlqziTsGeAp6+dUR8nhmh5Yz03K1fyDTQm9vbIvGw/TWvjx3KUFG7y+AJ3
         2HJX6a9obEud8M4o1g6a/55YZgtROkU3YUX8c8unIqD1WRDTiIeNMgp2pMQPy2ES9Jv8
         OtIKgex/LhcJsZB1AyGWbr+jpbSeIM5sjcU/vvIL0uLvXEKRn3SRKzO6kGGnMUemHsQ1
         k7wfUe6trzexbUGZamQvhkmTzAlng6iwTiluxnnV56W9dyge+aLb9lfXdxPf05dgVWC/
         Sx+w==
X-Gm-Message-State: AOAM533mp7hEj7r4BoP2TVq3lU0tXtpAod4qRNzqKDn8KI+ZslOFRUnd
        4kKCit/PzjVTRT017cGDrs6Ogvlfig8=
X-Google-Smtp-Source: ABdhPJzOZY+e/oUWiyFqsI3aLIVvrzaJAYl1dvEuCpQd6is+BOdCOz5fObqsizUGqnZxKrDsdgXzYg==
X-Received: by 2002:a37:c89:: with SMTP id 131mr40049qkm.468.1609860609784;
        Tue, 05 Jan 2021 07:30:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b67sm141482qkc.44.2021.01.05.07.30.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FU7qZ020835
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:07 GMT
Subject: [PATCH v1 05/42] NFSD: Update ACCESS3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:07 -0500
Message-ID: <160986060777.5532.11667377354502389840.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |    9 +++++----
 fs/nfsd/xdr3.h    |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 01335b0e7c60..ac680f34fcba 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -375,14 +375,15 @@ nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
 		return 0;
-	args->access = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 62ea669768cf..a4dce4baec7c 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -25,7 +25,7 @@ struct nfsd3_diropargs {
 
 struct nfsd3_accessargs {
 	struct svc_fh		fh;
-	unsigned int		access;
+	__u32			access;
 };
 
 struct nfsd3_readargs {


