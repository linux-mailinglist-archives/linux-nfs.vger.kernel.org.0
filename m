Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5513771A2CC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFAPfF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjFAPfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 11:35:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F286B3
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 08:35:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30aef0b8837so937864f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685633698; x=1688225698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7vgYVinn8HmukmdJAr7+JQOGyYSPsJ6nrQffS/GhDg=;
        b=E1I4V7xJUAmIBxEneYl8aDXqGyO489UASu5AcIIY409Hlg1/mEEJJnV0kN+cjOlWwR
         dE71iIH6GPtWyhZ8gzbwdrnnwLkEGcs+8IfsfZZC6VxhyJarSpxUtYobM6vW+k+bbvor
         wdd118s4r866PACYykjLMtogEcuFFDCmsceSz8XVEda6zfzPOED3O3uW/Yp3YsivaYg6
         M1ReNkwcwxUufR+tyGPXTQaSOlWfvaFvcoLk90vxKf+2A5qRvnez99ld4XplxqXVEgvf
         4Ce9tcLU4bx/zTcU23Rf4t18nFD8xlutEnivdQvMGR67JNJIJor3fsqIoPJwQwNAlJxP
         jM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633698; x=1688225698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7vgYVinn8HmukmdJAr7+JQOGyYSPsJ6nrQffS/GhDg=;
        b=CWooEdzZrck/vmmHrOFN/JcYYt5dRitF3Y7MJlQ/YugOq1+MMgDhXbgZHRhiteAQL/
         6SE27ozdtBuj4kqJsC9IeH6yxKxvvglxXlkMnZSMLIC+MRJdKr/3Db+rb22Os/5GugR4
         ZaE0SJQonWEpu4NWYMLJWYErmCLxvgIzB5qLBCcbks0YFy9Zf2t56QmCxWB75nDsJLdC
         OH8wDfWDJ/EFTeKNav6IbMnqf+70hb45VKDcLGRV4FYNDGriDWTP50+5aQk6U5vygzfW
         1o0dvYGNqZvIPPgEGxsisVHMXznFpsJoOxyV16vv2VP6+YQiak+zosyMozJA75nyBXfk
         XW0w==
X-Gm-Message-State: AC+VfDwI7pk9T4hKPzzpHNbFatN/2EaaZiMBvthhwvaesXRV96qxDjFM
        XC7DQl9kBOP4J+y774X+/EsR5A==
X-Google-Smtp-Source: ACHHUZ4fKAqFpi3u3X2LFUV8EZj0m8Ap/lhPEYmJXfrTyoHo7a8xNle/XK+kfKrDImZexZL4/08x3w==
X-Received: by 2002:adf:eec9:0:b0:307:8555:35e1 with SMTP id a9-20020adfeec9000000b00307855535e1mr2380684wrp.19.1685633698604;
        Thu, 01 Jun 2023 08:34:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030c4d8930b1sm1026022wru.91.2023.06.01.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:34:57 -0700 (PDT)
Date:   Thu, 1 Jun 2023 18:34:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
Message-ID: <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
 <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 01, 2023 at 02:38:58PM +0000, Chuck Lever III wrote:
> > - if (len > SIZE_MAX / sizeof(*p))
> > + if (unlikely(SIZE_MAX == U32_MAX ? (len > U32_MAX / sizeof(*p)) : 0))
>

This is a bug in Clang.

Generally the rule, is that if there is a bug in the static checker then
you should fix the checker instead of the code.  Smatch used to have
this same bug but I fixed it.  So it's not something which is
unfixable.  This doesn't cause a problem for normal Clang builds, only
for W=1, right?

But, here is a nicer way to fix it.  You can send this, or I can send
it tomorrow with your Reported-by?

regards,
dan carpenter

Fix the following warning observed when building 64-bit (actually arm64)
kernel with clang-17 (make LLVM=1 W=1):

include/linux/sunrpc/xdr.h:779:10: warning: result of comparison of constant
4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is
always false [-Wtautological-constant-out-of-range-compare]
 779 |         if (len > SIZE_MAX / sizeof(*p))

That is, an overflow check makes sense for 32-bit kernel only.  Silence
the Clang warning and make the code nicer by using the size_mul()
function to prevent integer overflows.

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

