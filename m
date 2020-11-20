Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23292BB733
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgKTUfq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbgKTUfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE9C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:46 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so10209508qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vxuxXLBxT7Heh/YRAALcLe4qTiKcDDbTFBGZdzCuJIs=;
        b=IQ4+Fktr/e1ug+77hled+1LSz0xUBWprZY/uHnciuDXgUlmW6uvG6/wD/oJK7aTvpl
         RB7RF61ADeiidHZdRSuS+7gC4+Mmo6rk5tXtpi1PfW6pe8AfwB9lnY0fHjMf0mJ/IKsd
         P95yOsW9a9W9qw2A31Ve25nKDiMB2IXLirEVt82GnBgNjQiJdExsKXIx5E4coaBSChM6
         uPaPaXjh9+L+e35WzuQa70onp3n3Wr/c3EBEeig1AqCQVRQKi4R/tPdwebDjReRQ5F6P
         nGaAejMoqebPSKMXDHFG/FRCw+9VCfBht/6uOYSAgLh+ZF7StyJVHeBhCr5XrF8I4LYf
         UmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vxuxXLBxT7Heh/YRAALcLe4qTiKcDDbTFBGZdzCuJIs=;
        b=j+zbeSrn6FYfl9hIHJgO6/GiEQulHYsk4E8u7VVjSda+QIVIexzJjwyDqB0b4I4QzI
         z91iMZ8L25yclYeUwAxZr6k5SUBfUUEMHclqj24bzvC9R09g+QedCRgJIAmgYNpNQTwE
         wjx0Z0fpHIvkpqHh38Fv/jA+tMSx8SS+cyK0lHJVxvDtyVR9xj1sGdRZLZUpIMsGEt/b
         l9ZCOstpuuwROsuM34aJ7tRKA3re0WBm/Pg/0B0fV6pDbejH+1khw417HZqVOAJN59gu
         1W20ZvykOBjj6yAdbLXCFq8ihumi4qVZH0PnnkQaaFOyztWLl58LFGeG0F+kIYMn3NQf
         qLmg==
X-Gm-Message-State: AOAM530+I4ME8SEq/2FE8I6B5bUe3mXPaUH3+tcgEeP8CRRDNnJ0HIjY
        Qrzto61Ok1MhedD6kzQ62AGjC0QPhDg=
X-Google-Smtp-Source: ABdhPJzS7Fx+budZo5MKV0HSKD5dqyqVmfhuVwdK2NX4g05okj2NEqxKlYIeQbAH+PECOmLSLVYcQw==
X-Received: by 2002:a37:7201:: with SMTP id n1mr17487292qkc.148.1605904545063;
        Fri, 20 Nov 2020 12:35:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g18sm2630080qtv.79.2020.11.20.12.35.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:44 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZhux029268
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:43 GMT
Subject: [PATCH v2 022/118] NFSD: Replace READ* macros in nfsd4_decode_link()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:43 -0500
Message-ID: <160590454336.1340.3378637232286425313.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8594d8751b7b..8c0d4c4d7b42 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -726,16 +726,7 @@ nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *geta
 static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	link->li_namelen = be32_to_cpup(p++);
-	READ_BUF(link->li_namelen);
-	SAVEMEM(link->li_name, link->li_namelen);
-	if ((status = check_filename(link->li_name, link->li_namelen)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
 static __be32


