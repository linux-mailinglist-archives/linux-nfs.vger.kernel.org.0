Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF767DC1EF
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjJ3VcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJ3VcD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 17:32:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A2F9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 14:31:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507adc3381cso7133479e87.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698701515; x=1699306315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4CDD7gOBgZXjdEejFuqXex8Na0HsuHTt1rp6KKwgU8=;
        b=ROansOKUPsG04fJf8nFGjjL+MStcTPgX/R8iBLVFAww50AVYSS3mNQOUQorG3qebBS
         JzdwzjLprcZkPEW/fktQlz0UG3DuGqGOMsrfBNKFxAD6gVABVkcHmFVV+g7me7u6jman
         9dsDA3MTx4WpJlcOl3hRDEj+N6GfD7xPOaOJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701515; x=1699306315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4CDD7gOBgZXjdEejFuqXex8Na0HsuHTt1rp6KKwgU8=;
        b=j0dFc2dX2cWBNxPDCAjsY/06/MVJQ0G2cNRzOc8FMgbIngny0X0hkK1gnkLvOy52vV
         p0mziWXiKKIGyQ8VDaMQ7FUYKpOEhS/gxgITB2SIJ0JYI5ySSYC/3PK7lEkrFe0TtpoW
         BFZRu0NQDoCuchxcX8DrQfb9Q2p1NB0kjaW/N6s28iAQ1as3bZa+vbQJEzmoqlyfjVIT
         JCuLg/LrrnZyr2pQ1buVS3hstrs5brlv3SZkf+iA9/gXTvEc+f4qnGUCSASU8YzlB7HP
         0ldkszkzj/cnuHYSCAOqDGebGNCuxLGH74NvRw7nu32ZkdehQ0jke3xQuPyAwvxkiu/R
         0UGA==
X-Gm-Message-State: AOJu0YyZ7D4SZo9PjJ4/djsYbEZetK8jLxL6A5q/FBI+s1bNWRSDvPz/
        cz81i8y6WZDZEbolhhlxKrePFdYrixNneOiPWPtl7w==
X-Google-Smtp-Source: AGHT+IGAghggmB5AohWQGRNwmqU4E1OTVzwMQFfHDgGR9gEeb08ImMHNdfq627px7vn4xbf0MQKE7Q==
X-Received: by 2002:a19:650e:0:b0:4fb:8939:d95c with SMTP id z14-20020a19650e000000b004fb8939d95cmr7479449lfb.30.1698701515295;
        Mon, 30 Oct 2023 14:31:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id v21-20020a17090606d500b009ad75d318ffsm6649802ejb.17.2023.10.30.14.31.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:31:54 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso746752066b.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 14:31:53 -0700 (PDT)
X-Received: by 2002:a17:907:7ba1:b0:9b7:37de:601a with SMTP id
 ne33-20020a1709077ba100b009b737de601amr9630560ejc.49.1698701513400; Mon, 30
 Oct 2023 14:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
In-Reply-To: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 11:31:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
Message-ID: <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
To:     Chuck Lever III <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 25 Oct 2023 at 04:24, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> This release completes the SunRPC thread scheduler work that was
> begun in v6.6. The scheduler can now find an svc thread to wake in
> constant time and without a list walk. Thanks again to Neil Brown
> for this overhaul.

Btw, the "help" text for the new Kconfig option that this introduces
is just ridiculously bad.

I react to these things, because I keep telling people that our
Kconfig is one of the nastier parts to people just building and
testing their own kernels. Yes, you can start with whatever distro
default config, and build your own, and install it, but when people
then introduce new options and ask insane and unhelpful questions,
that scares off any sane person.

So Kconfig questions really need to make sense, and they need to have
help messages that are useful..

Honestly, that LWQ_TEST option probably fails both cases.  The
"testing" is a toy, and the Kconfig option is horrific. I literally
think that we would be better off removing that code. Any bug found by
that testv would be so fundamental as to not be worth testing for.

                 Linus
