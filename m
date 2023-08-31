Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CC78F2D6
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjHaSmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347093AbjHaSmL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:42:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301FE6E
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:42:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso1562266a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693507325; x=1694112125; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cClgS35M8nNKct5YatDcxIYLYTKcfc1XrOU9xzcK1Ls=;
        b=lVGcc5yLSALCBlXbDxSu3I5zFpzEtuU1+RkFzwM0vHCcAejD4tbbFtrfQ0BnhIilEP
         ktTdVIcp2QzahLCa11b4Ok9d5Mwi8r4Dz+dIseVEWZIxcZ3AMVSiVbCyrUwr5sqCtsXj
         bN2J3wdQNxRlz7dCq1AbJWXx2Ftx2br6P4IgpI98eFtw2OiWmfLN9NUYPM3UfG0lZo4G
         sG++7We85tie4BQBNeeCB+hT0qreaXvcMYfGspO+/ZbtA1sbL16CgFTyK8rdCOOvrTPA
         9Qm03GDcPICN+cBJMXkSDKEWLNxNMk4HEI7NKC+s6gHQBgtADMLwhESqhVlvnd/lbo0r
         k4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507325; x=1694112125;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cClgS35M8nNKct5YatDcxIYLYTKcfc1XrOU9xzcK1Ls=;
        b=LqQgy5farFS08mWXJLOyABSAkHyK+OKmqAVtHDllj0+KnCliQPMrmCKAb3h+uOx/9+
         6tlhsiXYRPU7qGPRl3znh2Q/lIZwXseh69hPP0YEv/g9p5ajIc+tyBtxoo2X7UAaqaJl
         VkD65gILlSYH2u/NDQr7UnLiAn8Xk7v9z6/bSqc/Pu68e+1VY/48CCQElTrJ0NkHSEli
         LB2eFePcH/1Qqw+ppQXiccvrmRfOQjBMM12CjYzdtdbi7rKb9LLsj90h90uIwt9DlmpO
         Tn7f7M55SbETfXiz2KBjn8RP9wKmU3FpYPfNPzEKbtkfmeo77gGsOGoRvyBlqtL04O2d
         VmhQ==
X-Gm-Message-State: AOJu0YxOmUu8I1dFxA+PmiJ+MVbMkmGxDJT4pk1aNKe6gRwSP7/7DlQV
        PpO8qlzU0jAKV2p0+q4LyaisZJzJm/gg5sUZ/t/6Fi9JKHqS1Q==
X-Google-Smtp-Source: AGHT+IG9jnTLzQxJSHszgzv7zeHjXawWgKmGbV7FdX6Z5uGfmn06dEVfPZteavFVfP28hnjV1ulre/Oj8JLRE38PAHE=
X-Received: by 2002:a05:6402:12d7:b0:51d:d390:143f with SMTP id
 k23-20020a05640212d700b0051dd390143fmr334436edx.5.1693507325110; Thu, 31 Aug
 2023 11:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
 <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
 <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com> <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
In-Reply-To: <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Thu, 31 Aug 2023 20:41:26 +0200
Message-ID: <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 31 Aug 2023 at 02:17, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2023-08-30 at 20:20 +0000, Trond Myklebust wrote:
> > On Wed, 2023-08-30 at 16:10 -0400, Jeff Layton wrote:
> > > On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> > > > Again we have claimed regressions for walking a directory tree,
> > > > this time
> > > > with the "find" utility which always tries to optimize away asking
> > > > for any
> > > > attributes until it has a complete list of entries.  This behavior
> > > > makes
> > > > the readdir plus heuristic do the wrong thing, which causes a storm
> > > > of
> > > > GETATTRs to determine each entry's type in order to continue the
> > > > walk.
> > > >
> > > > For v4 add the type attribute to each READDIR request to include it
> > > > no
> > > > matter the heuristic.  This allows a simple `find` command to
> > > > proceed
> > > > quickly through a directory tree.
> > > >
> > >
> > > The important bit here is that with v4, we can fill out d_type even
> > > when
> > > "plus" is false, at little cost. The downside is that non-plus
> > > READDIR
> > > replies will now be a bit larger on the wire. I think it's a
> > > worthwhile
> > > tradeoff though.
> >
> > The reason why we never did it before is that for many servers, it
> > forces them to go to the inode in order to retrieve the information.
> >
> > IOW: You might as well just do readdirplus.
> >
>
> That makes total sense, given how this code has evolved.
>
> FWIW, the Linux NFS server already calls vfs_getattr for every dentry in
> a v4 READDIR reply regardless of what the client requests. It has to in
> order to detect junctions, so we're bringing in the inode no matter
> what. Fetching the type is trivial, so I don't see this as costing
> anything extra there.
>
> Mileage could vary on other servers with more synthetic filesystems, but
> one would hope that most of them can also return the type cheaply.

Do you have examples for such synthetic filesystems?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
