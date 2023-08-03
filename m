Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BF76E3F4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjHCJIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjHCJIj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 05:08:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC5F5
        for <linux-nfs@vger.kernel.org>; Thu,  3 Aug 2023 02:08:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so10681201fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 03 Aug 2023 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691053715; x=1691658515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lL6o/KcStrptKgvvlzpf2g3HB3hx11T5k5Y/jU/1lFU=;
        b=NI9g2tBpu8/9zS0rwuwUWSv6MvnFoaUBwXr4sK9UTsHdyUvkrNMi8Ks+zt9da/jHrw
         Ve0Egy6UUcn+qghjFjUrSkehwu/8mQ/l4hqx5K/2v8hstX4/3f6tXBpKrxvjBzYJF9QT
         8gW+4CGXpG9VKNUlEraiLHhlMgICDJ5q7HXZhc0e0gPz8n7pw8MUYtFNvpf4yoePmNS2
         4fkDqmUXRbPTSqay4emxrXtCobrPsdHdje03JHfcam/P4/SPBEzf3BHz4jvV4wPmb9DG
         ULmjU6S25u2aY0lqaD8lJZxNL4oUvsNBF65lviF3YSY/OizSLCCaPgU5poFOrWTzxRxK
         5KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053715; x=1691658515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL6o/KcStrptKgvvlzpf2g3HB3hx11T5k5Y/jU/1lFU=;
        b=lJrS5ZD7izNZGBidvhh7iUxWiyAIGCiDwTV2igjeIlT3rVsMwZzhdBx7EQ4vrnR1Id
         uhRgHdzHzFJu+JrIMLsjfl67TmLU1/7Bg9U47/R9emB0J47e9ZNNTDrCx3yvjvtPDeLu
         hQcis/uNh055bH8WkV7qt2QFXtAuS7t2Aa26ZWzX6TgjKqbtlAp7S1iy3wE0n9vpATxu
         0h9uVio4GIOa4RhmF0YfokSmgRQjOAUD9JPaE9mKwg2T6oWlZivlyugtCHTTOum1/rKY
         x7kn3SIyTylcx2v8NQizcQtw6TL8yCvo9ANdWG4VQUyCFrb/BuHXFDdyO7Q1H5Fq5+Dh
         Ko6A==
X-Gm-Message-State: ABy/qLaTtcwGwrt5H+eF3OFxx/s9I8P5yvLXX1YFCvrexpKf87ZPTBiA
        ApTEO9n/2MTatsHb4MTXHSWDfFF81bp8KSBXuo0=
X-Google-Smtp-Source: APBJJlHOqAV2i4Wnq0dOO1J5u/qsLMvUhNpr6WrZRCrVB983RluHKR4r4vNi+n6ZlpXBeA1dY0MN1A==
X-Received: by 2002:a2e:98d0:0:b0:2b6:9ed0:46f4 with SMTP id s16-20020a2e98d0000000b002b69ed046f4mr7505851ljj.23.1691053715562;
        Thu, 03 Aug 2023 02:08:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm13156770wmq.1.2023.08.03.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:08:34 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:08:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Su Hui <suhui@nfschina.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Message-ID: <0ea832fa-de39-47fa-8666-5743a68a8519@kadam.mountain>
References: <20230802080544.3239967-1-suhui@nfschina.com>
 <531df8ee-ba09-49df-8201-4221df5853c6@kadam.mountain>
 <CAKwvOdnRwmxGuEidZ=OWxSX60D6ry0Rb__DjSayga6um35Jsrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnRwmxGuEidZ=OWxSX60D6ry0Rb__DjSayga6um35Jsrg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I could have sworn there was an issue with glibc annotating these
parameters as non-NULL, but maybe it was a different function.

With the memcpy() bug in 2010, there were never any numbers to show that
it helped improve performance.  The only person who measured was Linus
and it hurt performance on his laptop.  So from a kernel developer
perspective it just seemed totally bonkers.

regards,
dan carpenter

