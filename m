Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654F3564A1D
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Jul 2022 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGCVxN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Jul 2022 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGCVxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Jul 2022 17:53:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA361129
        for <linux-nfs@vger.kernel.org>; Sun,  3 Jul 2022 14:53:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so10860374wrd.8
        for <linux-nfs@vger.kernel.org>; Sun, 03 Jul 2022 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=McfkW5FgXVmOmLQo7EHgyZNeCP9HbMy8V+hctevhQsk=;
        b=DZ8Sj1HgVEn4oHZlNEc3/C7gme0XecZg+HlNJ5Hq/m1U5i7DceP7cLZLuFJNDwKjfe
         Tku1v5jnLSSVUckJ5tbIEioo4eTJyskzFZDq7KTp28WvKTX03LBL/8+AR+3759belYX6
         N+qdsmIze79Pu8iidRnQOGbnXQcNHag+wqh0V3GnPNMj44IChUsSyW6gsWJiepL91ECp
         QvzUQi2i/VmLQYgwAa8lZM+2lcWmIb3+SmRhZ8GAdg1oT021djkJjTnHIDN3B50oWuPZ
         5SEbpMjldXMUqU3eciqf+dfn1r5opTbQewu7jXnTE5Uam5Q56fDkRk7ifA1zkNQNXJ7C
         lCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=McfkW5FgXVmOmLQo7EHgyZNeCP9HbMy8V+hctevhQsk=;
        b=FCRtrQF3d4IVSpqfcMEKJud4vK66slyoS32UMfsvdQjQfKqYFe9f1G321pl/GZ+U6y
         Ry5SlR+OYMaLmxxqEWe7vEsMvd9FV6ITbdAs7J2pGa0HS7+VEHltKFLRqSq1qiVYj12d
         VnyxmeP1FnnjN4E9xWj7oRLrKq0q4fkTXsLJVNtvc9nruNb3BOAk19876jxnnqDv7dTC
         0p4JXVllgRC7L0ya9pFngYhJ+f7OC8ED9aNC0kv1rc2szQ2ZLPYmi9EXE0yobYShn2iE
         TOukig9nEaP10iln6q8+rubx23xziP2nLANFybBmJ8EORKFrW84a/JVE0RYY+pqVUf16
         4u4g==
X-Gm-Message-State: AJIora95rmWuo8xvUcpwA9dNZHOjKcRNvLT6R+5GL8DXfMwq2V6wo1YN
        64HP4ZLTdwtFew+Wqxoy37sJv7MJA3qLwQ==
X-Google-Smtp-Source: AGRyM1vjT7kRRZIocZq8W6mDlI1TlwcuqojKypA3ZTq8OYffgZguApGl5x6lJgxWWT/eadshcfk1FA==
X-Received: by 2002:a5d:60c5:0:b0:21d:6afe:8499 with SMTP id x5-20020a5d60c5000000b0021d6afe8499mr1398250wrt.258.1656885189104;
        Sun, 03 Jul 2022 14:53:09 -0700 (PDT)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id az38-20020a05600c602600b003a0323463absm17629460wmb.45.2022.07.03.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 14:53:08 -0700 (PDT)
Date:   Mon, 4 Jul 2022 00:53:06 +0300
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] SUNRPC: Clean up the AUTH cache code
Message-ID: <20220703214628.2zzixg62do6d7jhh@gmail.com>
References: <20181023163404.27777-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023163404.27777-1-trond.myklebust@hammerspace.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2018-10-23 12:34:01, Trond Myklebust wrote:
> @@ -456,32 +495,24 @@ rpcauth_prune_expired(struct list_head *free, int nr_to_scan)
>  
>  		if (nr_to_scan-- == 0)
>  			break;
> +		if (atomic_read(&cred->cr_count) > 1) {
> +			rpcauth_lru_remove_locked(cred);
> +			continue;
> +		}
>  		/*
>  		 * Enforce a 60 second garbage collection moratorium
>  		 * Note that the cred_unused list must be time-ordered.
>  		 */
> -		if (time_in_range(cred->cr_expire, expired, jiffies) &&
> -		    test_bit(RPCAUTH_CRED_HASHED, &cred->cr_flags) != 0) {
> -			freed = SHRINK_STOP;
> -			break;
> -		}
> -
> -		list_del_init(&cred->cr_lru);
> -		number_cred_unused--;
> -		freed++;
> -		if (atomic_read(&cred->cr_count) != 0)
> +		if (!time_in_range(cred->cr_expire, expired, jiffies))
> +			continue;
> +		if (!rpcauth_unhash_cred(cred))
>  			continue;

With `!` flipping the `time_in_range(...)` condition in this past
change, looks like we are skipping the head of the LRU which should be
pruned, so actual expiry does not happen at all in case there are more
than about 100 old items in the LRU.

Reverting this, I saw the correct behavior taking place.


-- >8 --
Subject: [PATCH] sunrpc: fix expiry of auth creds

Due to an inverted condition, instead of pruning the head of the LRU,
the loop stopped short at the beginning.

Fixes: 95cd623250ad ('SUNRPC: Clean up the AUTH cache code')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 682fcd24bf43..2324d1e58f21 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -445,7 +445,7 @@ rpcauth_prune_expired(struct list_head *free, int nr_to_scan)
 		 * Enforce a 60 second garbage collection moratorium
 		 * Note that the cred_unused list must be time-ordered.
 		 */
-		if (!time_in_range(cred->cr_expire, expired, jiffies))
+		if (time_in_range(cred->cr_expire, expired, jiffies))
 			continue;
 		if (!rpcauth_unhash_cred(cred))
 			continue;
-- 
2.23.0

-- 
Dan Aloni
