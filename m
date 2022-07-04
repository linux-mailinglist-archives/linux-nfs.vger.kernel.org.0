Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E544F565641
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiGDM5F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiGDM5E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 08:57:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D2BB6
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jul 2022 05:57:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so8015663wrr.6
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m5F6cWoPa48iig/dSKI2gqSUpBFOJ6h4y9fAGHQZ+3s=;
        b=V0Fe6xmWsCYCqNp3jCYd4nuPOm1IVpI6Hmw7u7DGUBWLeKYIFOzydvCg2P/RA/AFxh
         mEgJJeIntl1mPXUL2ZdhH6cqk6D909zNwHfBkkHbSRXazPIFj2wNO4LGRA1VbgvaWIbY
         unq94sYUa53yb4A0vhI+d2mc0ZIM/TghN2rwyR1HWmcv44rc9LIm2Ms4I2GYAPfb1Yec
         cmoM5346tb8Xgo7AYS5mynQtfppAGMW1P7r5TNv8x62h5+yfjqTtM8AEUxmghN/BLMmM
         O4ky+ncaQ0hTma2SqSCcGmjoo4UXczBly54k5A2T0FJ9quwvwLOAijg9XHv42rOWXA6W
         3mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m5F6cWoPa48iig/dSKI2gqSUpBFOJ6h4y9fAGHQZ+3s=;
        b=DEbBo9v4HA9XaUqEpU4Si7o1Jj+AXtT6yXDlbwJrLer+gqAeBFFWkLdymO10ltm5to
         YQX4jJ0gzvi8L0EAg7UDdFYF/omGco5UbL38j47O37wSctJzAE8pMJENn8thAgZ7vWFA
         p7FdP6jt4w3FgTJdTtOEjRKoS6WgGsSsn/HWCfIUBLQJfXdYnHunz/NOpdJC+FU8CB2s
         ON4BfswZ5WIjOBi+Q5JSgzIgs4fKylwqIP9NbDfimmKXqW7oiQHdhgEUqJzVDMx4JgG3
         6WDxijU85DngEp59zs3LC6JOjr6GHLYxEUFaoGh4gEnoZWprRLp/Q953g7YvuVOjDrfG
         KiTw==
X-Gm-Message-State: AJIora9Cb7OoMPOD4lc2gsVGch4V5LesLOVYu/lDyBm4f1mblPtE7s5a
        ZYBiRPJUbzkRqPKQ/X0PjyeFUSu4dYpgiQ==
X-Google-Smtp-Source: AGRyM1vstbPcz4G71S90hgkw1wfbdm+r4xCS1NpGhScPBiIO1jnuIhMCnrJGmzJQezONqZUguGN+dw==
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr5822455wrx.546.1656939421060;
        Mon, 04 Jul 2022 05:57:01 -0700 (PDT)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b0021d6e758752sm648199wrp.24.2022.07.04.05.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:57:00 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:56:57 +0300
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/4] SUNRPC: Clean up the AUTH cache code
Message-ID: <20220704125657.apczddzlpqng2ov3@gmail.com>
References: <20181023163404.27777-1-trond.myklebust@hammerspace.com>
 <20220703214628.2zzixg62do6d7jhh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703214628.2zzixg62do6d7jhh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022-07-04 00:53:06, Dan Aloni wrote:
> On 2018-10-23 12:34:01, Trond Myklebust wrote:
> > @@ -456,32 +495,24 @@ rpcauth_prune_expired(struct list_head *free, int nr_to_scan)
> >  
> >  		if (nr_to_scan-- == 0)
> >  			break;
> > +		if (atomic_read(&cred->cr_count) > 1) {
> > +			rpcauth_lru_remove_locked(cred);
> > +			continue;
> > +		}
> >  		/*
> >  		 * Enforce a 60 second garbage collection moratorium
> >  		 * Note that the cred_unused list must be time-ordered.
> >  		 */
> > -		if (time_in_range(cred->cr_expire, expired, jiffies) &&
> > -		    test_bit(RPCAUTH_CRED_HASHED, &cred->cr_flags) != 0) {
> > -			freed = SHRINK_STOP;
> > -			break;
> > -		}
> > -
> > -		list_del_init(&cred->cr_lru);
> > -		number_cred_unused--;
> > -		freed++;
> > -		if (atomic_read(&cred->cr_count) != 0)
> > +		if (!time_in_range(cred->cr_expire, expired, jiffies))
> > +			continue;
> > +		if (!rpcauth_unhash_cred(cred))
> >  			continue;
> 
> With `!` flipping the `time_in_range(...)` condition in this past
> change, looks like we are skipping the head of the LRU which should be
> pruned, so actual expiry does not happen at all in case there are more
> than about 100 old items in the LRU.
> 
> Reverting this, I saw the correct behavior taking place.

v2: Made a better explanation in the commit message.

 
-- >8 --
Subject: [PATCH] sunrpc: fix expiry of auth creds

Before this commit, with a large enough LRU of expired items (100), the
loop skipped all the expired items and was entirely ineffectual in
trimming the LRU list.

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
