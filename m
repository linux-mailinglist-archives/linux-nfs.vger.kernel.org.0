Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE22BB720
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgKTUec (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbgKTUeb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:31 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:31 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so5329712qvy.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZHKC7O7bKMdtBlGOzhOf6cKLSnD5Yst/iMkIzzR6Sak=;
        b=mBSwpAzw3O+Od/FWcf5WrbOyrNFaXpjSocIOGk//7Ax5vQKQG/6NEekEvHvJrZN5Q1
         1Q2zgTNLgz4XizDM5xx13jCn8o34MoULdIlc/ezWyRnWvMSYlMCFWRr6ZRq+PVq0Enfv
         cDpgJK1T5cUgeIXXQezFr0ZRW2MEhZWUrcM6XhEGST6J0vnHzvME+jwL/XNSx2UtDi6J
         3Snm7pbBsKxjBEKhDa3F2wR4q7qfSUyEa7EwiB/RUI/wHn0vSR26BaFEjJ3YrUEYZBJx
         KVPGvizvNwQyncVwg7H3RRuf6wEno34wfrkHKPVlBa89/8FXCP4/zwU6atQzDZJ8GftN
         IHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZHKC7O7bKMdtBlGOzhOf6cKLSnD5Yst/iMkIzzR6Sak=;
        b=sbrvoxsLo1dgTpfPiuhpSQFfcsEwe8p5+AIUuYyN8/PuLpOKIIStOeGCqdPE7EsVAr
         34FAUJCsGS3dx023EygV4ZlTqrb/dlNPsXU/vy4T9+f9vaF3GVqRV2wp+iC3UZ2yzibY
         paPkYWLM3OiDYY6No5qKJBC1f/N8MGOnmmLyLIRaNvOxfs1FSY7w0uWRCeWqgYf1418y
         Y44/+3HQHXpewjmqbgPDyyUXkTcLjd2aaes1Km92IVAW2NgWRmL3xuNQ+y7yaKxjb4Mv
         V1vv7yQVUFlaQf0cvVehJvHuop8eWnFd6BdDjFa6L3RjNNTDijIdB6g5Jv2dGaCjJFL3
         xfpg==
X-Gm-Message-State: AOAM530K7upYE7q1ATAVBKpI2HzOqmjSFaLAqbvAUKTFOtPKcfGK5V9Z
        kZFDbehpl/buEkrqWS/sPCqiyyeKYfw=
X-Google-Smtp-Source: ABdhPJwJhi6n6O8stYO3ve8TtL5nD2rly1IGQq+kBEKzMXqeU9QstRc16bIWZQNbBo/KqY8JT0h9Mw==
X-Received: by 2002:a0c:c38f:: with SMTP id o15mr16065793qvi.12.1605904470218;
        Fri, 20 Nov 2020 12:34:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm2774646qkd.74.2020.11.20.12.34.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYSxW029226
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:28 GMT
Subject: [PATCH v2 008/118] NFSD: Replace READ* macros in nfsd4_decode_close()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:28 -0500
Message-ID: <160590446846.1340.9664040070243046724.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 027582d682ae..06028e4f1b5d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -558,13 +558,9 @@ static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	close->cl_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &close->cl_seqid) < 0)
+		return nfserr_bad_xdr;
 	return nfsd4_decode_stateid4(argp, &close->cl_stateid);
-
-	DECODE_TAIL;
 }
 
 


