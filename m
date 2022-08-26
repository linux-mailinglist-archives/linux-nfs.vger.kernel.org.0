Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54235A2FA1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiHZTHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 15:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiHZTHT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 15:07:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267D74CEA
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 12:07:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id og21so4871518ejc.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aJkU6Tw7lia/3fgViQwrDtqNox+Rn1U1Hy6LHUh3+HM=;
        b=fSOJmaEFNqjnYOBtaHBouRojuL3zc6UQFhGTIYAAh4BBEymNlxvhiYwPhuICwcq3Ni
         6BrZiyCtbCl8U1vndqostbcNYqBeQKUa2AEVVNl97vfuZ2kw8umuaoV3G49D7I4AjCL9
         3BsIZ8lQhnXW6XsS8BFedJtEq0JOe7R2FFde4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aJkU6Tw7lia/3fgViQwrDtqNox+Rn1U1Hy6LHUh3+HM=;
        b=OjXxnxORBciNbwLyVpyZmV4Z4vEZvY8YzNw0q32AARv8fj83OVvdERrUQmne1TOmR8
         0I4978eKLOXDtZDLMvw1YBPkh5x7+aSiEk8kLNZQe4wA62/OdVQ28V+iXjzo/IS5mH5M
         L/fue8lH2aDtqHnybkiUaGIFoIn5FClCEB3lRO9G8YBGfnWUmQRF+9BjRUv92tzOUEXC
         W+CFWAD3fX4Ib7nH8EQNligmhEIq5l3mj5xGiWkgM807TE+ZV7AkEVbXNGP7otrxkZ3k
         EUbLs1CCQab6eJWGuWctVDauS76yaSUeBby9ZRGxzwUYkQGYhOSlfXqBrvL0Wey5KXmx
         JCzQ==
X-Gm-Message-State: ACgBeo0uhb2Aa3qgMIv7hu9wwIuZMaom9A5WNY6YOkSFfJ2zkQzazJjS
        /TSpFTHsmRReodNb0jVO25drQCKcv+AH6xgrY/s=
X-Google-Smtp-Source: AA6agR4aTw8C9hRGG3BHn4P8wlB0CRk/6SH8Y7G5mbrDuHNjnNepB+UXVP8NXpH3YeNGwF3mSklT3w==
X-Received: by 2002:a17:907:868f:b0:730:bc1f:a8d8 with SMTP id qa15-20020a170907868f00b00730bc1fa8d8mr6693517ejc.106.1661540833311;
        Fri, 26 Aug 2022 12:07:13 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id g30-20020a056402321e00b00445bda73fbesm1676778eda.33.2022.08.26.12.07.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 12:07:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id bq11so2821832wrb.12
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 12:07:11 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr549561wrp.281.1661540831542; Fri, 26
 Aug 2022 12:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <166147828344.25420.13834885828450967910.stgit@noble.brown> <166147984370.25420.13019217727422217511.stgit@noble.brown>
In-Reply-To: <166147984370.25420.13019217727422217511.stgit@noble.brown>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 12:06:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
Message-ID: <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 25, 2022 at 7:16 PM NeilBrown <neilb@suse.de> wrote:
>
> If a filesystem supports parallel modification in directories, it sets
> FS_PAR_DIR_UPDATE on the file_system_type.  lookup_open() and the new
> lookup_hash_update() notice the flag and take a shared lock on the
> directory, and rely on a lock-bit in d_flags, much like parallel lookup
> relies on DCACHE_PAR_LOOKUP.

Ugh.

I absolutely believe in the DCACHE_PAR_LOOKUP model, and in "parallel
updates" being important, but I *despise* locking code like this

+       if (wq && IS_PAR_UPDATE(dir))
+               inode_lock_shared_nested(dir, I_MUTEX_PARENT);
+       else
+               inode_lock_nested(dir, I_MUTEX_PARENT);

and I really really hope there's some better model for this.

That "wq" test in particular is just absolutely disgusting. So now it
doesn't just depend on whether the directory supports parallel
updates, now the caller can choose whether to do the parallel thing or
not, and that's how "create" is different from "rename".

And that last difference is, I think, the one that makes me go "No. HELL NO".

Instead of it being up to the filesystem to say "I can do parallel
creates, but I need to serialize renames", this whole thing has been
set up to be about the caller making that decision.

That's just feels horribly horribly wrong.

Yes, I realize that to you that's just a "later patches will do
renames", but what if it really is a filesystem issue where the
filesystem can easily handle new names, but needs something else for
renames because it has various cross-directory issues, perhaps?

So I feel this is fundamentally wrong, and this ugliness is a small
effect of that wrongness.

I think we should strive for

 (a) make that 'wq' and DCACHE_PAR_LOOKUP bit be unconditional

 (b) aim for the inode lock being taken *after* the _lookup_hash(),
since the VFS layer side has to be able to handle the concurrency on
the dcache side anyway

 (c) at that point, the serialization really ends up being about the
call into the filesystem, and aim to simply move the
inode_lock{_shared]_nested() into the filesystem so that there's no
need for a flag and related conditional locking at all.

Because right now I think the main reason we cannot move the lock into
the filesystem is literally that we've made the lock cover not just
the filesystem part, but the "lookup and create dentry" part too.

But once you have that "DCACHE_PAR_LOOKUP" bit and the
d_alloc_parallel() logic to serialize a _particular_ dentry being
created (as opposed to serializing all the sleeping ops to that
directly), I really think we should strive to move the locking - that
no longer helps the VFS dcache layer - closer to the filesystem call
and eventually into it.

Please? I think these patches are "mostly going in the right
direction", but at the same time I feel like there's some serious
mis-design going on.

                Linus
