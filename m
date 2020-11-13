Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F482B1DFF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKMPDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKMPDu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:50 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E908C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:50 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 199so9004787qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w/WxUfgtJ7b+Xw9H9X3rk+hwovNFukJ15YvbIyHDjLU=;
        b=FpMXDMpb82r57E7VgpZ3lTp8rAQRO4Rz09nAtTUo6Pj22WMhdKAtimWtUEnaysU8v0
         gV1YNqaBikJ+fxYzouox090T8I3nE8P7tmoLFD3m6Zfgge9JscmawAXqJv0+Yi4ViSHV
         UoSYnrbdjwWS50H4qi7bJxwS/lFE5V6lugSDIRaYW8fFgkKaTLsdn+aCl69Sznshu82T
         IbXPRbyYXRDkReyHPLU5kpAB0mGOKqME0FmueQnB5uA6gx2vsQbwOpc+lU82O736sqxD
         KJRNAKH0RAe51U3kQjek8oADdD7R1ZbBdZiVhBaH+MTKVlm4pZ7i5KfDL7cvvRE9jzGu
         W63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=w/WxUfgtJ7b+Xw9H9X3rk+hwovNFukJ15YvbIyHDjLU=;
        b=i9cWXXgAt8lKXIL64muY1MQIQEKKwePhExU6Zd8nCoUfPfJsX4XcsfA0MQ3iY7kgGX
         FlzfaUvZau4ubkdgASAc88b8gbCc2mrsZSHIOG0pNcdaEDIP+ib92OpZUz+PLaqAlMVY
         a6w+fPDogolipZLV2z4cIUfGwBbgWpycRifk9xgZALUJedGYWwYZN2x+CTegkdag5yxV
         9d24CNBQLACvR4JhcSZYVtS9rDfSxFXjsLtXKHMqzeP4ZktJYFZYIecUJjY03Nstd+Nr
         4RZ7Va3GKHU/djV8ai2cwPIOJdYE4S392kxoew5H9EQEwXic12otda/OaJlrgr2sNeHV
         i6Nw==
X-Gm-Message-State: AOAM533CFDYilMUkOyLWbRW2soq6vmEMuH2npcsWNhw5+6oh2h0xJktx
        WPVj91a2B8hRlccqiELkrZa9vL/JQJs=
X-Google-Smtp-Source: ABdhPJx5oqUKRuf48PaUjR1mF6nilRpxdvtLIpVZryzzX4R7SGrr9pInCsgwQiN60U1tv2rX5BsZZQ==
X-Received: by 2002:a37:58c6:: with SMTP id m189mr2438086qkb.129.1605279829100;
        Fri, 13 Nov 2020 07:03:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n187sm7136887qkc.133.2020.11.13.07.03.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3lXo032685
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:47 GMT
Subject: [PATCH v1 16/61] NFSD: Replace READ* macros in nfsd4_decode_lookup()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:47 -0500
Message-ID: <160527982752.6186.11841203632390056940.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 88a8d002303c..6bb6ffa676b7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -852,16 +852,7 @@ nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 static __be32
 nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	lookup->lo_len = be32_to_cpup(p++);
-	READ_BUF(lookup->lo_len);
-	SAVEMEM(lookup->lo_name, lookup->lo_len);
-	if ((status = check_filename(lookup->lo_name, lookup->lo_len)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &lookup->lo_name, &lookup->lo_len);
 }
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)


