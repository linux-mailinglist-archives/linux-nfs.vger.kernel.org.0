Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BAE617D03
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKCMtd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 3 Nov 2022 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKCMtd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 08:49:33 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EDB98;
        Thu,  3 Nov 2022 05:49:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id k26so1007446qkg.2;
        Thu, 03 Nov 2022 05:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COmpkeGuuNrJHAgtC1xywonBxmmPoZsg3DPh2rk8H2A=;
        b=GtOFzofKcoEAZzI5sdc9C2hVURP+n1TICq1/zcItdr9YwDWIf6SzIDQdYvQwKr3kcA
         LXnTSqf8E/V2pri+wf9wt4j7CInEQGTRWQY0VV5YWRp1EXU2CoovAd/QpCdC++cQMMAu
         sahHha36jV9u/TZuWgo6+hEK3MaIByfZaIN9sBv9k4MwL9NA3dt37B/N3oNjRgZYF+qg
         gO0ED5CW5v5d61/DqGvp1JPr5AJMh5dYaWY3Kbc23Iq9KMBHcz/eT7fVyq+iz4q8xNA5
         zoKSXsofG9GAB1kxV8NEPE+awkEGvogzXKAK0gzFgBnRcVQt28b2U5wrmC9SCHkQEZM1
         1vbg==
X-Gm-Message-State: ACrzQf3068iwhkge70565aUI8NADy9dsMCZFk7vCqMe48m1R8bjRxkib
        w4Q6rfmKUDcAuT+32waLOg==
X-Google-Smtp-Source: AMsMyM6aySgZsmREOs3vK2QOeZBzOrRIBDDOY+gafuKEaUiPkl4B+pDHQL7AfIYYv89RzZs19l9uSQ==
X-Received: by 2002:a05:620a:c8c:b0:6fa:6402:4d00 with SMTP id q12-20020a05620a0c8c00b006fa64024d00mr5707929qki.164.1667479766715;
        Thu, 03 Nov 2022 05:49:26 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b006ee8874f5fasm704008qko.53.2022.11.03.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:49:26 -0700 (PDT)
Message-ID: <229b424a647bfbd18942eefef4cbf6332607ca2b.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: svc: Remove unnecessary (void*) conversions
From:   Trond Myklebust <trondmy@kernel.org>
To:     Li zeming <zeming@nfschina.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 08:49:24 -0400
In-Reply-To: <20221103013510.3062-1-zeming@nfschina.com>
References: <20221103013510.3062-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-11-03 at 09:35 +0800, Li zeming wrote:
> The iov_base pointer does not need to cast the type.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  include/linux/sunrpc/svc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index daecb009c05b..4b0eead91c94 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -222,7 +222,7 @@ static inline __be32 svc_getu32(struct kvec *iov)
>  
>  static inline void svc_ungetu32(struct kvec *iov)
>  {
> -       __be32 *vp = (__be32 *)iov->iov_base;
> +       __be32 *vp = iov->iov_base;
>         iov->iov_base = (void *)(vp - 1);
>         iov->iov_len += sizeof(*vp);
>  }

If you're going to submit a patch just in order to strip unnecessary
casts, then why are you leaving the equally unnecessary cast in the
next line?

That said, why waste time "fixing" an inlined function that is not
actually called anywhere in the kernel? svc_ungetu32() should just be
removed.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


