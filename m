Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02D745C68
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jul 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGCMmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGCMmg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 08:42:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C408B3
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 05:42:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so36093725e9.0
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jul 2023 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688388154; x=1690980154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XFpyBBKRCRxMK5NDafYwUBbAGkW92zQFpIIitblDTU=;
        b=TQOz34arDctByX03GqE4gew0cK2eEd/da+QRoo53Fgy/ZionE5Z6h1o2FiuB46TnNI
         isUtX8mVzbQhs8T0Zm640m7uc5PXuNPlseOiwIVErmlk1kVW0asPUynkL0kTo3N5g4sx
         R8Vmhx+hVGxounKVqwNP+DRuBDwKkALS8ukWwcxoFqWA3pRus2l6uxbQoMMJqyY4avx0
         CT98nunTuCEfsGHhHbzVcxz8EkpPElEcPTP1hEwr/QVmHDhE7Khouln2mFrtVivbzAzd
         vmS7lHcXNtJcPJUbi7kIvLHEcmxriYVwqBGd5ccG/O3Tu+N1qDFvE++2Dc5P3hW8rP3a
         OGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388154; x=1690980154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XFpyBBKRCRxMK5NDafYwUBbAGkW92zQFpIIitblDTU=;
        b=jsPp/Ad/G5NF2E6BKVRvOLtF6C5l7ypgX1zrrZ4Wj2yaldfojX8mdRxxFNSNIb7JZv
         Cn+YU4wCaKm5b/pLeDXyZgHTiHpFnGy/tJl8nG9QjJS1e/QBXt7aGGYWO7ah/Vtkcp6H
         i6YtNAkilayNRe/xkJnZKckTXDwR6Tjb5rBWKIEwx5jYU1VjMJOx35zUsWFSph5pCZKQ
         DPYQegilCbN6AEu9PfYw6bY/WuCuLNo961kjDC0gq35H+RzawsEI2PUjR86IoYHgoDqj
         02DH9wGNvRE6BU9ceywPAdr9rHNRIGj3x0kB3VG3HHGsa6iYN+xaimsf7DxqFs64WQI9
         rg/Q==
X-Gm-Message-State: ABy/qLaSBlqVXyWyhjLmscNLtTkhwxmu3jeTfNK5haKvFGOdbt36bzIe
        +pSRV+yCtud07kntvndpyKg7fg==
X-Google-Smtp-Source: APBJJlHmKXwYmc6bUIZGLmaOqk9O6Fh1cerKmaDJcs/cHxEJzg2Trr6gyCR/U+D+qz+dlnaf36IChA==
X-Received: by 2002:adf:cc90:0:b0:306:3352:5b8c with SMTP id p16-20020adfcc90000000b0030633525b8cmr9514161wrj.7.1688388153797;
        Mon, 03 Jul 2023 05:42:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y7-20020adff147000000b0031438e42599sm1866268wro.82.2023.07.03.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:42:32 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:42:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Dan Carpenter <error27@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] sunrpc: avoid constant-out-of-range warning with clang
Message-ID: <6b963674-fc5a-4abb-8678-a82d35a3f3fd@kadam.mountain>
References: <20230703113737.694995-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703113737.694995-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 03, 2023 at 01:37:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The overflow check in xdr_stream_decode_uint32_array() was added for
> 32-bit systems, but on 64-bit builds it causes a build warning when
> building with clang and W=1:
> 
> In file included from init/do_mounts.c:22:
> include/linux/sunrpc/xdr.h:778:10: error: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>   778 |         if (len > SIZE_MAX / sizeof(*p))
> 
> Shut up the warning with a type cast.
> 
> Fixes: 23a9dbbe0faf1 ("NFSD: prevent integer overflow on 32 bit systems")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/sunrpc/xdr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index f89ec4b5ea169..6736121ee6a03 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -775,7 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
>  
>  	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
>  		return -EBADMSG;
> -	if (len > SIZE_MAX / sizeof(*p))
> +	if ((size_t)len > SIZE_MAX / sizeof(*p))
>  		return -EBADMSG;
>  	p = xdr_inline_decode(xdr, len * sizeof(*p));

I sent a patch for this last week that takes a different approach.

https://lore.kernel.org/all/2390fdc8-13fa-4456-ab67-44f0744db412@moroto.mountain/

I probably should have used a Fixes tag just for informational purposes.

regards,
dan carpenter

