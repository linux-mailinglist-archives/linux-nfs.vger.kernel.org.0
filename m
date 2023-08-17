Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227F677FA3C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjHQPGk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352772AbjHQPG0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 11:06:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB2106
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 08:06:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe4762173bso12726135e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692284783; x=1692889583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3VUBr4xVNyWd1q3Dkt0BFJj2tgIgj7jnvk0NM4tyvY=;
        b=M0GzecahLZwhpk2812uTrtIR55hTDGmj8HklJsIPELL3S6X/KFYthmLocxDPKvrMwA
         TslRe/y2pAgT1zRqrgY9iD1N7hEw4TSXUQwxW2Gv2Ksuycn/xQB9Ehe3nCvJK+V2DWtu
         xE3nbNBl1d92aI0DHCQoylfxZ/pGQikpe5Vko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284783; x=1692889583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3VUBr4xVNyWd1q3Dkt0BFJj2tgIgj7jnvk0NM4tyvY=;
        b=ERx8lskrJMepK3KtXc1ZiYDWrSAPfGZbVx7m/RGUXz6Z7HKM1KEcg7eNoJ5UrjTvDE
         xuooPXTjODioC0oi9y+3zM/MbatPGd55532SJRVosCZTjRa1i+KzsGm3FKkwOqHB8Caq
         7mIr982Scdyq4yoifUpvCOnTJpoKtTv+NUCGgESJyBuH0iaDiwllfqdgH73iSqE9nh2J
         ZpoqOlnwdu6juIGVuyEvL+TtUo2G+PV8bhd2EFdKpz2rU7pFMwFL9CqgVRwfAus6c2xX
         c/ijUl8L1bAcZABI+H3661hxEp37eh7uuOJMEav6+ioOEGQIEVE35lmGwlaIIqLqP3x2
         wOlA==
X-Gm-Message-State: AOJu0YyhaUzeqzNShXScds+1ClbptNnlcQMdulxtjgG7amLy6K5u5H8+
        xKisiqyyhML2dcvqhnMH6tjKUuEballGPdLgo/ezz9kI
X-Google-Smtp-Source: AGHT+IG5znpLQTQz36JOfKRF2kKfvvTUZYq3dGsFVzVYriLKmH4WOsVuXvNT95XyGf0SkCrzKbFCYg==
X-Received: by 2002:a05:6512:4024:b0:4fd:f590:1ff7 with SMTP id br36-20020a056512402400b004fdf5901ff7mr5010572lfb.40.1692284783086;
        Thu, 17 Aug 2023 08:06:23 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b15-20020ac2562f000000b004ff96c09b47sm530041lff.260.2023.08.17.08.06.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:06:22 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso118560511fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 08:06:22 -0700 (PDT)
X-Received: by 2002:a2e:9ad0:0:b0:2b9:e623:c2d8 with SMTP id
 p16-20020a2e9ad0000000b002b9e623c2d8mr4525544ljj.44.1692284365734; Thu, 17
 Aug 2023 07:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
 <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com> <27B358DC-D32E-46F5-B611-A179C6AB2B90@oracle.com>
In-Reply-To: <27B358DC-D32E-46F5-B611-A179C6AB2B90@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:59:08 +0200
X-Gmail-Original-Message-ID: <CAHk-=whqj8mRjZWCriZnbUyvtnNwwUJE1Zbg8eandWjk059rkw@mail.gmail.com>
Message-ID: <CAHk-=whqj8mRjZWCriZnbUyvtnNwwUJE1Zbg8eandWjk059rkw@mail.gmail.com>
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Aug 2023 at 16:55, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Aug 17, 2023, at 10:49 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > I'm sure it's right, but it really smells odd to set that initial
> > offset not when the bvec is created, but long afterwards, just before
> > it is used.
> >
> > Is there some reason why 'bv_offset' isn't initialized when the bvec is created?
>
> Yes:
>
> https://lore.kernel.org/linux-nfs/7c9421cc4b92dee76cc7560c50a4a0ab3fb1ef0d.camel@kernel.org/T/#t

Ugh, how ugly.

> But also note that this fix will get replaced in v6.6
>
> I just wanted to ensure that v6.5 wasn't broken. It's a little late in the
> cycle to apply 383bc8bbc.

Sounds good to me. Thanks for the explanation.

              Linus
