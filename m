Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD953171AE
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBJUvs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 15:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhBJUvr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Feb 2021 15:51:47 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444CDC061574
        for <linux-nfs@vger.kernel.org>; Wed, 10 Feb 2021 12:51:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f2so4665161ljp.11
        for <linux-nfs@vger.kernel.org>; Wed, 10 Feb 2021 12:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFCBVLmx4m3P8OJ7FexI4xTU+D+dqeOPB5L3zdP1j98=;
        b=OlXMEGE3+YXDW20u82up+ZZJxFuT5KQPVaOZp56fIviL/ca54YrjE5bQPiM0jLbtr5
         JephDlBWc6ihBoJg5k8R1M7+hSbeoGkpREvy/8A8Bsg5/X4GhbjclPWfb060aUds7Xkf
         2bFaMcZ2LOg9RoALDj7udW/xyJ4i9lrqIzZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFCBVLmx4m3P8OJ7FexI4xTU+D+dqeOPB5L3zdP1j98=;
        b=PLH9in743gw/fvEA10WpbMISxewAe3ccJJcBAZxMqlVOhrAwffTntWfc7AeEJuaXZX
         ggK1JijfDR8SFyTTjR9b81a0yaBvLWPRvHliJdRSh5Xncye8z0kYxdjmtFIApCIhCLOl
         v54TgnWvHBCFRCSv4WbxmCWgEBp4IPPLeFYll0YjXq9ooEbjmH6hN2G4+qbqbCmSOLgU
         leJbpZz1erD6Xlt89DSO3OwPugEyPDfc+ntCA9I6pclxlTyfKdgPB1QzOspcklBADXCe
         /Kk7HcmAAZoSAZuvKyPQ6AbHZpWjeFXHrHcL2gj6GkVDs4EiA0jXfQPNJ/4plWD4kTSg
         qJXg==
X-Gm-Message-State: AOAM532psr9X/LINDWFm6/D3Xg3TdNIhYpHXGo/ppLBxwepnEUO4iUuK
        gZe8OcsH0TKNmWPcUpx0eaB6Sr/DiloUqQ==
X-Google-Smtp-Source: ABdhPJzI0wDD1dXhpxkbr0E6iWk+OvL2UuUnN59tKKO1ePABphoWw2V2mqVPYkw/bvWIAOUJzH2Biw==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr2946678ljb.263.1612990264391;
        Wed, 10 Feb 2021 12:51:04 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x11sm637000ljh.69.2021.02.10.12.51.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 12:51:03 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id e17so4693287ljl.8
        for <linux-nfs@vger.kernel.org>; Wed, 10 Feb 2021 12:51:03 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr2551518lfu.253.1612989815438;
 Wed, 10 Feb 2021 12:43:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk>
In-Reply-To: <1330751.1612974783@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Feb 2021 12:43:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
Message-ID: <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 10, 2021 at 8:33 AM David Howells <dhowells@redhat.com> wrote:
>
> Then I could follow it up with this patch here, moving towards dropping the
> PG_fscache alias for the new API.

So I don't mind the alias per se, but I did mind the odd mixing of
names for the same thing.

So I think your change to make it be named "wait_on_page_private_2()"
fixed that mixing, but I also think that it's probably then a good
idea to have aliases in place for filesystems that actually include
the fscache.h header.

Put another way: I think that it would be even better to simply just
have a function like

   static inline void wait_on_page_fscache(struct page *page)
   {
        if (PagePrivate2(page))
                wait_on_page_bit(page, PG_private_2);
  }

and make that be *not* in <linux/pagemap.h>, but simply be in
<linux/fscache.h> under that big comment about how PG_private_2 is
used for the fscache bit. You already have that comment, putting the
above kind of helper function right there would very much explain why
a "wait for fscache bit" function then uses the PagePrivate2 function
to test the bit. Agreed?

Alternatively, since that header file already has

    #define PageFsCache(page)               PagePrivate2((page))

you could also just write the above as

   static inline void wait_on_page_fscache(struct page *page)
   {
        if (PageFsCache(page))
                wait_on_page_bit(page, PG_fscache);
  }

and now it is even more obvious. And there's no odd mixing of
"fscache" and "private_2", it's all consistent.

IOW, I'm not against "wait_on_page_fscache()" as a function, but I
*am* against the odd _mixing_ of things without a big explanation,
where the code itself looks very odd and questionable.

And I think the "fscache" waiting functions should not be visible to
any core VM or filesystem code - it should be limited explicitly to
those filesystems that use fscache, and include that header file.

Wouldn't that make sense?

Also, honestly, I really *REALLY* want your commit messages to talk
about who has been cc'd, who has been part of development, and point
to the PUBLIC MAILING LISTS WHERE THAT DISCUSSION WAS TAKING PLACE, so
that I can actually see that "yes, other people were involved"

No, I don't require this in general, but exactly because of the
history we have, I really really want to see that. I want to see a

   Link: https://lore.kernel.org/r/....

and the Cc's - or better yet, the Reviewed-by's etc - so that when I
get a pull request, it really is very obvious to me when I look at it
that others really have been involved.

So if I continue to see just

    Signed-off-by: David Howells <dhowells@redhat.com>

at the end of the commit messages, I will not pull.

Yes, in this thread a couple of people have piped up and said that
they were part of the discussion and that they are interested, but if
I have to start asking around just to see that, then it's too little,
too late.

No more of this "it looks like David Howells did things in private". I
want links I can follow to see the discussion, and I really want to
see that others really have been involved.

Ok?

                  Linus
