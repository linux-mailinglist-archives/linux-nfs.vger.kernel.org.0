Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E778135D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 21:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379613AbjHRTcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379617AbjHRTbx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 15:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA71B421C;
        Fri, 18 Aug 2023 12:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48DB3612E7;
        Fri, 18 Aug 2023 19:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4EC433C7;
        Fri, 18 Aug 2023 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692387111;
        bh=uh51fKDWUGz5RlUKsAx0lMoUB8sMNSymJzbCiuP6hPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d77MsN0ra2ujWVxyT+5nZLZanrBh+hIwlraWSyVTQL5hw2QqTqld7DGC55I1oHIYc
         mPnLA6xHxGer4Xz12vnrpRZjL4C5oj5zEaSV8b21xBoCmjZgqO/L6l4yaVSOqIvWPc
         pfv8h66dJQI2piFjndcXZN2VOnN4qJOdl5cgZDN8=
Date:   Fri, 18 Aug 2023 12:31:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-Id: <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
In-Reply-To: <202308181146.465B4F85@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
        <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
        <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
        <202308181146.465B4F85@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Aug 2023 11:48:16 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> > On Fri, Aug 18, 2023 at 7:56 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> > >
> > > > From: Elena Reshetova <elena.reshetova@intel.com>
> > > >
> > > > atomic_t variables are currently used to implement reference counters
> > > > with the following properties:
> > > >  - counter is initialized to 1 using atomic_set()
> > > >  - a resource is freed upon counter reaching zero
> > > >  - once counter reaches zero, its further
> > > >    increments aren't allowed
> > > >  - counter schema uses basic atomic operations
> > > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > > >
> > > > Such atomic variables should be converted to a newly provided
> > > > refcount_t type and API that prevents accidental counter overflows and
> > > > underflows. This is important since overflows and underflows can lead
> > > > to use-after-free situation and be exploitable.
> > >
> > > ie, if we have bugs which we have no reason to believe presently exist,
> > > let's bloat and slow down the kernel just in case we add some in the
> > > future?
> > 
> > Yeah. Or in case we currently have some that we missed.
> 
> Right, or to protect us against the _introduction_ of flaws.

We could cheerfully add vast amounts of code to the kernel to check for
the future addition of bugs.  But we don't do that, because it would be
insane.

> > Though really we don't *just* need refcount_t to catch bugs; on a
> > system with enough RAM you can also overflow many 32-bit refcounts by
> > simply creating 2^32 actual references to an object. Depending on the
> > structure of objects that hold such refcounts, that can start
> > happening at around 2^32 * 8 bytes = 32 GiB memory usage, and it
> > becomes increasingly practical to do this with more objects if you
> > have significantly more RAM. I suppose you could avoid such issues by
> > putting a hard limit of 32 GiB on the amount of slab memory and
> > requiring that kernel object references are stored as pointers in slab
> > memory, or by making all the refcounts 64-bit.
> 
> These problems are a different issue, and yes, the path out of it would
> be to crank the size of refcount_t, etc.

Is it possible for such overflows to occur in the cred code?  If so,
that's a bug.  Can we fix that cred bug without all this overhead? 
With a cc:stable backport.  If not then, again, what is the non
handwavy, non cargoculty justification for adding this overhead to
the kernel?
