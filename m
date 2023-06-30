Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2574389F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjF3JrE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjF3JrD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 05:47:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577F10FF
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 02:47:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso14765085e9.1
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688118421; x=1690710421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GclBgXm9Q3XbGCOTf6wDEXPVGEyfn5qEyPiaLKc6uYM=;
        b=iROPQ3uyJUbR73/EmgO0lq8jkRTRpaKxc9hXMOAfFJ6YSLlWACsaSPgz4BOsX/XyBm
         wifYby5SEIu+SProcw2R39cSI9PU9BKgmJux76CtYbtmLr3V2ia28uWftCJgqkBwXUJ0
         A1z0qE46cVI9UGK7hSe+Hm0mJDmZv4CxMGaNL+2mLEZGI7TX9I8zVOZVEO9Ih7HA+A91
         ulycw9uLpfM6MdQxkriibHCINZzd/lAPc1szOulfozPdr6kWOeTYQd4yaMWLlU+IkvXi
         vKjOcFP+ZR3UUhNnJ3Us79yWg40DfN4vSBTZYdUvTIN0gw/QHhkXchXziIlBgCOfVaRN
         iziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688118421; x=1690710421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GclBgXm9Q3XbGCOTf6wDEXPVGEyfn5qEyPiaLKc6uYM=;
        b=j0hGM1Q2zhvdHH3ehcx0sRHvXqcpcvcSMmr/MsxDA+1dBFKADSprXh5UBN0/38J5SO
         vTym8fEeZpQ9c4W8dQKPl2f2/rHT58R1XAF1O1ZSJSlUR87Ww6YlOHnsBNdNQziJ0xVE
         8mpC7kB1hxCwL2r7/d02e5dCcQBEyMTb+eJz97xmmgBxnFLAyhXSWWFB7Lv/eMiHsTGj
         g8PBy8+ggh9YJgpa4M5gUTb2UPvzayIyNHvJGOlGEgSgvwLjggpGxOMn8DVNUITUUBla
         jUaf5zKPKKFM9bljJF5FgEsC509mWTdve5SpoN7yZjvN2ZSZ3dYSnwk+bzIFj/1m4DNO
         4JZQ==
X-Gm-Message-State: AC+VfDzNpSYX9Q4EjgYaWmtUxmdAxkxEASqp5L2olYme7wZ9lDcNRn8M
        2DRqJCXQOzCeGYFcSBtdFPHdxw==
X-Google-Smtp-Source: ACHHUZ5ZhQr9vrR7J5QnqBkd72WjZ2AWUvoM0O8d2CRpMrfzaYrD2py75FQQRIBDIuytsk2U5d/Cww==
X-Received: by 2002:a05:600c:3552:b0:3fa:94ea:583c with SMTP id i18-20020a05600c355200b003fa94ea583cmr7336415wmq.8.1688118420757;
        Fri, 30 Jun 2023 02:47:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003fafe32c8f6sm12264726wml.10.2023.06.30.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 02:46:58 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:46:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-nfs@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH] SUNRPC: clean up integer overflow check
Message-ID: <2390fdc8-13fa-4456-ab67-44f0744db412@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This integer overflow check works as intended but Clang and GCC and warn
about it when compiling with W=1.

    include/linux/sunrpc/xdr.h:539:17: error: comparison is always false
    due to limited range of data type [-Werror=type-limits]

Use size_mul() to prevent the integer overflow.  It silences the warning
and it's cleaner as well.

Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://lore.kernel.org/all/20230601143332.255312-1-dmantipov@yandex.ru/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Btw, since the Clang developers are automatically CC'd, here is how I
silenced this type of false positive in Smatch:

1) Check that longs are 64 bit.
2) Check that the right hand side has a SIZE_MAX.  SIZE_MAX is defined
   as -1UL so you want both the type and the value to match.
3) Then on the other the other side, check that the type is uint.

I'm looking at this code now in Smatch and it's kind of ugly, and also
there are some other places where I need to apply the same logic...

 include/linux/sunrpc/xdr.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f89ec4b5ea16..dbf7620a2853 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -775,9 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
-	if (len > SIZE_MAX / sizeof(*p))
-		return -EBADMSG;
-	p = xdr_inline_decode(xdr, len * sizeof(*p));
+	p = xdr_inline_decode(xdr, size_mul(len, sizeof(*p)));
 	if (unlikely(!p))
 		return -EBADMSG;
 	if (array == NULL)
-- 
2.39.2

