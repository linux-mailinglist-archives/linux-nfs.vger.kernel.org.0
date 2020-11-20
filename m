Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3452BB779
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgKTUkB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbgKTUkB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so10174293qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q5V126LhdaXHlP+i06x0ohlkA0uX6G+kzwqm6afJP+0=;
        b=TgHiiHdon4CEQQYQf17MmuEqUSpxyKfgJyxI5Q+Uwk8phpj5OkV+XcORWmlesVGGBC
         iBj+bxfWJCap8nc201mtwAyUtK16Fe7rSPZrY6pbX4y0bhpMVq/8eHXHEUxtujIyQF6S
         VPvoFxPOOMa1VWYrB36IF23NyqkmGCD2wXzMTqqm/4hhpK0YgVurCBCa3WMhodRdt398
         ddhB5dEypAkXPJb9jjqvTIuTwMVJVGQ0tAADjnQu+fQhqbHcoxE/i7g9cEw7WzRgGfYQ
         Oz7QhFSnsWT9R71LrN83Q7qwEzoakrsmMvgcabT0NHJGZ7DSV9unFTycyRf5Mtm+3eRA
         OGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q5V126LhdaXHlP+i06x0ohlkA0uX6G+kzwqm6afJP+0=;
        b=QaJRkc3BR9eo58KR4W9yfZPQEf0ecbpMSBevJoK9Ws6F/SerJusESUw3u7FveMXK+y
         52tItAln5/yBD99aUZmc8g0AwqECxDRkqueGtKfCIN65FKC2Vi3cnL3PC6einy26Bf+u
         u0hqg4rgZlxug3Sy5eF/8lQApr8bq5HZ9NME2oWsEPtA7hBLkCo+cnEM81VBEIhUca6z
         YPKx1+HPvoZQVSqHqmYgmhIFN70mGjwQhzDdWGsYoD4BzQ3ud6k+mgjHSLrvpLx4pkqN
         PLOIE3vLINK9l0D4qalx5diBIW3hz2vH3uZSxqutGzUV8I7NQQtu1F/EAIgErBT6oMBN
         K0uQ==
X-Gm-Message-State: AOAM5313ck/4GrlAUDvO6n4K5x7DuptpW7mLtEl85ficdA3nCwlegBNz
        zs5WmYmBcpSVV4qvki+QVZN+8CdoVuw=
X-Google-Smtp-Source: ABdhPJyJHXVR9b2vqufNQWITqH4Zm0oJmIzptOggthCdGLRgoy4fcEclTldjcP9bXjwOlOSxUskO9w==
X-Received: by 2002:a05:620a:5a6:: with SMTP id q6mr17629062qkq.80.1605904800175;
        Fri, 20 Nov 2020 12:40:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d19sm2506764qtd.32.2020.11.20.12.39.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:59 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdwi5029413
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:58 GMT
Subject: [PATCH v2 070/118] NFSD: Replace READ* macros in
 nfsd4_decode_reclaim_complete()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:58 -0500
Message-ID: <160590479844.1340.3002295923429250700.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6bfc9f69c660..6325b71f3d7e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1679,16 +1679,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	rc->rca_one_fs = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
@@ -1844,6 +1834,14 @@ static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_clientid4(argp, &dc->clientid);
 }
 
+static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
+					    struct nfsd4_reclaim_complete *rc)
+{
+	if (xdr_stream_decode_bool(argp->xdr, &rc->rca_one_fs) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


