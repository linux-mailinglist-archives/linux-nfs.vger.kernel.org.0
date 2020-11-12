Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899A2B073D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 15:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLOHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 09:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOHf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 09:07:35 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A3C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 06:07:35 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id e18so6333912edy.6
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aLtWF/yWa5C5RFPhU1QrqHMffg8iZpxmwTfYBJoE9M=;
        b=aYu7f0La+NZ41jnce98/5G6/yNntqWkIzHQ9CdhQwxHeF+TuY2nkTprXSJTUF6P38X
         GpeOCJGIQNyg7EkGIEJ8yrvXUPAu8nH/HEjwuE+ZU8Y9jFNbF2jNzIbf11OLlx283lHa
         TTBc35cjSUzwujeAMqjZayZY4tvwp0mgh4vTTP34aa7eay9hoST/bvsoksuAKc9Hkn35
         nHxY4Iz3AMEsHRxSX5OwG1P+eJa0AVFrGCiRR0rPUVUhI4FuVBPEU2RPNm1mP84j82SL
         07FZ4nZIZ+ZQNnIHSw7c8UxJA6qmiG73BeLoWdtsMYoO5xazFtXnQgy+n5F7rc7MLBKX
         f1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aLtWF/yWa5C5RFPhU1QrqHMffg8iZpxmwTfYBJoE9M=;
        b=I0WDIoEp3XywXHpW/U4ewAUfkm6X5LdzXW+E36R20UGxvrgOy3929z2lfK/07hnCtN
         gaZ03l2VmrhA5NSzccPOCKav+cy+g8xGGAL1AY1G7xCC6bzQUOfd8xWzt7C2jiNKSMLj
         m4IGoumzDEX/OYwirVj6nK/KSqMrwqo7YeKfNWpyGzM+ouzGz7aHprew1y1BUh8/GhaZ
         UG2GC1vUH9gV8ImqAdKO5nvt4YddZs3oWe+Nz6iFRo3AnXh7YCUDD41PYR/9KVXVPtyp
         ZuuqkWmq6JsBijuXPRVV/HA2ZG5GCv3m4sFBPPesDe8OZHWeJL3u/+KgzlXitV2yy7BL
         o7+Q==
X-Gm-Message-State: AOAM531zpuFexWop41Egm/OrnjuuksSARFXlJ77UGth3ApS2FOiRdGml
        rLeIKLsLvMo4t8XvI85aM3owap5ixCYk4UYy5nAPqSqE
X-Google-Smtp-Source: ABdhPJxk8elR2Qc4q2RoIQ1mHqnVWsKtsAIMFHAq/HHJ12EK2Cd8t8bOM2ZZXfU0r2HCeRJFmjS037wov59MCprz7S0=
X-Received: by 2002:aa7:d48d:: with SMTP id b13mr5190227edr.264.1605190053898;
 Thu, 12 Nov 2020 06:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20201021143415.GA27122@fieldses.org> <20201112140340.GB9243@fieldses.org>
In-Reply-To: <20201112140340.GB9243@fieldses.org>
From:   Anna Schumaker <schumakeranna@gmail.com>
Date:   Thu, 12 Nov 2020 09:07:17 -0500
Message-ID: <CAFX2JfmNHLyTL+y5yG58AkSEmsXcmP65bk1KLT6NuOsgXd=4Qw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: fix failure to unregister shrinker
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

No need to resend! I'll make sure the fixes & cc line get added to the commit

On Thu, Nov 12, 2020 at 9:03 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Looks like this patch got lost, do you need me to resend?
>
> I should also have added a stable cc and a
>
>         Fixes: 95ad37f90c33 "NFSv4.2: add client side xattr caching."
>
> --b.
>
> On Wed, Oct 21, 2020 at 10:34:15AM -0400, bfields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> >
> > We forgot to unregister the nfs4_xattr_large_entry_shrinker.
> >
> > That leaves the global list of shrinkers corrupted after unload of the
> > nfs module, after which possibly unrelated code that calls
> > register_shrinker() or unregister_shrinker() gets a BUG() with
> > "supervisor write access in kernel mode".
> >
> > And similarly for the nfs4_xattr_large_entry_lru.
> >
> > Reported-by: Kris Karas <bugs-a17@moonlit-rail.com>
> > Tested-By: Kris Karas <bugs-a17@moonlit-rail.com>
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfs/nfs42xattr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> > index 86777996cfec..55b44a42d625 100644
> > --- a/fs/nfs/nfs42xattr.c
> > +++ b/fs/nfs/nfs42xattr.c
> > @@ -1048,8 +1048,10 @@ int __init nfs4_xattr_cache_init(void)
> >
> >  void nfs4_xattr_cache_exit(void)
> >  {
> > +     unregister_shrinker(&nfs4_xattr_large_entry_shrinker);
> >       unregister_shrinker(&nfs4_xattr_entry_shrinker);
> >       unregister_shrinker(&nfs4_xattr_cache_shrinker);
> > +     list_lru_destroy(&nfs4_xattr_large_entry_lru);
> >       list_lru_destroy(&nfs4_xattr_entry_lru);
> >       list_lru_destroy(&nfs4_xattr_cache_lru);
> >       kmem_cache_destroy(nfs4_xattr_cache_cachep);
> > --
> > 2.26.2
> >
