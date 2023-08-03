Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F6D76E3FF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjHCJK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjHCJKw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 05:10:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E618E7
        for <linux-nfs@vger.kernel.org>; Thu,  3 Aug 2023 02:10:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so7482605e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 03 Aug 2023 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691053849; x=1691658649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJpah36ty+h1V+d/yS60/V9o8V1RRKpQA+HMeX/JC0I=;
        b=zRU32KM/s4kejwypSNsftglC4dId0r9jmFUNmjuS56xQIPZKXicT/nxtm7K0Vo7rmt
         e7H37M922zt/gFoHsDGnUXQLs+jyzey5hfJLzRcvYwBowjqlU8tySGn/7oiJafC/5tde
         f0qol4Y3xusJ/wEZBTGEpSqzTQrZyMkwmTnWZt8bZ3Tewr+DkOsdty638egRkk2g/4RZ
         Gp+cfU27t6obG+V6TwMCjrKMsu5o2Q9dpUtpXZ7eTD7DWf6DMOf/+GepJGqhF1etOI8/
         fW/zxjuzkaC17izXgyg1IuPbrUX7RvxojGxpwHiLncGwtQrfSDDRQxYkZnkgT1TZKiEn
         hHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053849; x=1691658649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJpah36ty+h1V+d/yS60/V9o8V1RRKpQA+HMeX/JC0I=;
        b=bTlDk14L/bxGzsr/h5ZNf6/dhxriHGBKGiwWDejYeUrxmQtGZUsKORGcSkN3AL7JD5
         kkpFpYVm/x5AngVV4WlzeB3SE2/9FoJSm71TdvJroxoHTtAijZPcuHF5TLXxVe0Q6xIF
         5RJ6MBzcWt0HZUcuTUM9icVcgNnx5SERnHkQk3lao4tGsgnXsW3BTGUVKqSprPV2h4zt
         ++bfiMFYfeYVmNSdyNTZhjZQ4mFuKAW/Bia9WSNd7W+L0WJPJpHyJeeC2Y47dbQxZvYp
         6iwSB+OaCskaiB7nzWy36mtuWFGq06EaitGCUZFPWbbGj5zju8DfLrSbMkLHQSeY/GPZ
         Y1+w==
X-Gm-Message-State: ABy/qLb2fgmP8fTyhdYMVgh1B3UxNgv+Y/QP0og+6fIH7wO5olQSZBz2
        On7eV0LpN+8uNvNpXM6+ceOAag==
X-Google-Smtp-Source: APBJJlG1QbuLw2+H8HhnJeVT1Av59WDq9CwoIWlgg+11h4NWNHUKX3rJlFzg7p+nNHtO4/ZveaIgYA==
X-Received: by 2002:a7b:c34d:0:b0:3fe:179a:9eee with SMTP id l13-20020a7bc34d000000b003fe179a9eeemr6942588wmj.30.1691053849395;
        Thu, 03 Aug 2023 02:10:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b003fbc9b9699dsm3702132wmc.45.2023.08.03.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:10:49 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:10:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Message-ID: <057a4eea-d55a-4402-81c1-46b04b405a73@kadam.mountain>
References: <CAKwvOdnRwmxGuEidZ=OWxSX60D6ry0Rb__DjSayga6um35Jsrg@mail.gmail.com>
 <18edc2c7-2fb0-493b-9a9f-549acce4e87a@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18edc2c7-2fb0-493b-9a9f-549acce4e87a@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 03, 2023 at 12:16:40PM +0800, Su Hui wrote:
> Should I send a separate patch for this bug and add you as Reported-by ?

I feel like neither of us know if we should add a check to the
intializer or remove the check from dprintk.  If you know the answer,
than absolutely, please send a patch.

regards,
dan carpenter

