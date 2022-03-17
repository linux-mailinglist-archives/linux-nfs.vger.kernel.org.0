Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B34DBF33
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 07:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiCQGUM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 02:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCQGT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 02:19:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16976E33B6;
        Wed, 16 Mar 2022 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=RnNnvxScmOOrZ5E51nA93B6vLFD/DYSAzW7tLEbHXvo=; b=Tbhcgz4qFu/F8doNKjklq5GT/n
        tN/WNzmDi9ZU4T9RIgNZg7+0VQWg1Qr/d+ZQZEtol1QHF/Bz1L7ftmAdN0QAoML8l0diRxTapNA54
        0KRXNzkBQoqBudUP0Jerjkua/EXnRTU90zcBTUhKTNevcgJ+sAlsKnG5qVmAM2lq6tLaePDkdribA
        +UlhwxMVVE5c2OPlWat9Aap9+Kk8pcy7mpcc7GMYscgpHeR0GgprP1vJ3E57KWN1i5IpVcvb0ys45
        w3kFOi48Y26DNfNaSRZ7LRaPDeClzbwQbKRYgHTm5l8UmcB0HLlc5fr75yJ2jPgVClmR48nlDBSFB
        6IRKQH4g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUjK3-001nz7-L8; Thu, 17 Mar 2022 06:09:20 +0000
Message-ID: <9053a28a-0cc5-a35e-b613-c63689b9f8f7@infradead.org>
Date:   Wed, 16 Mar 2022 23:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfsd: use correct format characters
Content-Language: en-US
To:     Bill Wendling <morbo@google.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220316213122.2352992-1-morbo@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220316213122.2352992-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi--

On 3/16/22 14:31, Bill Wendling wrote:
> When compiling with -Wformat, clang emits the following warnings:
> 
> fs/nfsd/flexfilelayout.c:120:27: warning: format specifies type 'unsigned
> char' but the argument has type 'int' [-Wformat]
>                          "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>                              ~~~~              ^~~~~~~~~
>                              %d
> fs/nfsd/flexfilelayout.c:120:38: warning: format specifies type 'unsigned
> char' but the argument has type 'int' [-Wformat]
>                          "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>                                   ~~~~                    ^~~~~~~~~~~
>                                   %d
> 
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for ints and unsigned
> ints.
> 
> Link: ClangBuiltLinux/linux#378

Please make the Link: more complete, such as a URL/URI.

> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  fs/nfsd/flexfilelayout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> index 2e2f1d5e9f62..070f90ed09b6 100644
> --- a/fs/nfsd/flexfilelayout.c
> +++ b/fs/nfsd/flexfilelayout.c
> @@ -117,7 +117,7 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
>  
>  	da->netaddr.addr_len =
>  		snprintf(da->netaddr.addr, FF_ADDR_LEN + 1,
> -			 "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
> +			 "%s.%d.%d", addr, port >> 8, port & 0xff);
>  
>  	da->tightly_coupled = false;
>  

thanks.
-- 
~Randy
