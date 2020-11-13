Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2932B1E3B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgKMPHh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKMPHh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61368C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:24 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so6822000qtq.12
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cdih5GI/dhHUpJziNpURGNtIgUUPJvHL110ZAtZlyiM=;
        b=t95sG2Efpr0dfVXhWHm/ui9WQcVGiNK0plKdLjeqlBvXtwxxq3C0CQPVR7ZRcmWfvY
         q8twVsRjmLeHcjmAp/2AU8tF8dd1eD6NRoYvxi/+suXs+0veApKAVzyGAKzm10PjVATI
         mJ2bkEjAFx0jUQKFCthU4NJOe3eLiCJT5wBvwhoj/IQtC6pdfN5SDI+TWgvkCLZf0ckz
         4EFZN9+ix72IWOTFyx0KX/dk7SKHTWwKDUzYsmeTOlYibryUF8j6AMrGxD+tVLXKU3gY
         ytjTTylZynAK183SPqci/bpI+3ZWXbE0Szn1Ry1uGGs0F/3KhdmqA6LZ/c8QO226ng/n
         fAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cdih5GI/dhHUpJziNpURGNtIgUUPJvHL110ZAtZlyiM=;
        b=piM5cmlsaLT5kU/kpQbMdj3LMh3tstrM2cvKPwXVZdOR368U2EE/PyICDxDEUM1H7i
         lvoq2kPoSrIzwSt6bITPxQ9W/c1QLp15sR+O5fGl7oY/TWKlOVy7r5NoEgfu3kLHGMZm
         LxUM2SO2euMOO6sfcxeUNFJmNiLBwG6958gXH62YDGP4Csk4IstTsJjhE66kst100QbR
         Z1qpOSJAUs8SKebTnfv8ZWPIFEFIwrvdUfbE/OeQJADHAMVb6VKtEt/biy+4TBmgOsy8
         0ZTVOtspiG3tcOVgJt/cMoVFrbyoBqPiPq4XHs/QiSbwaHnVTVJaxZRv6i9iNqmKF9Zj
         IGOA==
X-Gm-Message-State: AOAM532wTeWVVmSIuiYAZWx8m8bNNjmIsQk7yd9RIeEKyhn5yvzX5yLu
        Ktz4hhGOOziHP/bhmQoAj1+aT/2Dd2E=
X-Google-Smtp-Source: ABdhPJwBzKrbUFWDbPu1Xn3IIwLGR3mdBMaT2IKiPk3BCDU9ubHnY1WCOjS8GBkkixeAQRtNV6p3iQ==
X-Received: by 2002:ac8:5bc4:: with SMTP id b4mr2178088qtb.189.1605280039958;
        Fri, 13 Nov 2020 07:07:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a85sm6887683qkg.3.2020.11.13.07.07.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7IiH000337
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:18 GMT
Subject: [PATCH v1 56/61] NFSD: Replace READ* macros in nfsd4_decode_seek()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:18 -0500
Message-ID: <160528003840.6186.12603304346209628234.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 408da2625dba..1f7eb2f67390 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2110,17 +2110,21 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
 	if (status)
-		return status;
-
-	READ_BUF(8 + 4);
-	p = xdr_decode_hyper(p, &seek->seek_offset);
-	seek->seek_whence = be32_to_cpup(p);
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &seek->seek_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &seek->seek_whence) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 /*


