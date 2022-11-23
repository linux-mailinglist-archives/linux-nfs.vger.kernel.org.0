Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E155636B4C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiKWUjG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 15:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbiKWUhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 15:37:11 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F89BF595
        for <linux-nfs@vger.kernel.org>; Wed, 23 Nov 2022 12:34:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l2so11985492qtq.11
        for <linux-nfs@vger.kernel.org>; Wed, 23 Nov 2022 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqmvkkESPfhDMe/qDmW4BJUOiTicPIv5an9zs8Gyv18=;
        b=H05YjYlWatbzx/wYDWLZlWtlE1KBwjnnlgWrAS57YeODNFQbfnbqnkGjrw+7lnDaor
         oScBBYPzE4yA/do2o0oXxJV/7PAgcLDU8MGXopXi7Hyz2CY8RYXjIOxuZIHXCxSyrV4d
         4jeZ+ngrXKdb0oQJMIfkShcljtHyJ8LXyw7yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqmvkkESPfhDMe/qDmW4BJUOiTicPIv5an9zs8Gyv18=;
        b=HiV7cWLNywFUH18h9BAB1xGqke8m7N47ZS9nZCSB5cLX3MNASsRu/kIuCW3T8L7KXU
         nlrY6bycpTLe7YmWKh5k0ZNrvBm3dMeNINLRQXx6GL7tZuYQjEXZ5VkO1Nyp99huDpSA
         Fy/esonBpB8I7m8vYqUhKauy0qR+IXLgiu10CrHzhQOPiHAcgLqBUQWJ5t5vwZ9YoPGL
         7s+Thkn64AY19bNuzldgpoikgkM2GxsFG+fJYDjMN/sgKZgI/bLIpD5KHdNr08C7sN9v
         f7Bkak9zs5u0AftEWT8U0g862wjbAQxg307cWiY3qN6DE7fJuBgW/SFnxdMqyw6Uosk9
         q3JA==
X-Gm-Message-State: ANoB5plv9pZP+exrSP+00VR8gzc+R7BUE/VkMcEgtIl3/8TaPoe8t67Q
        ydj+N27GkNWxCd2zv+txUsF4EQHoXjz4/Q==
X-Google-Smtp-Source: AA0mqf5Xsj1yotm9juri0Fa2DSM6WrZKIOndcvNJcpQPlfuSFDTQR9NalhyLuzEwzuWWRkmxHFLFeg==
X-Received: by 2002:ac8:53da:0:b0:3a5:c1e:d8b with SMTP id c26-20020ac853da000000b003a50c1e0d8bmr27395369qtq.537.1669235640625;
        Wed, 23 Nov 2022 12:34:00 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fb8239db65sm11955082qkp.43.2022.11.23.12.34.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 12:34:00 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id h7so12332231qvs.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Nov 2022 12:34:00 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr10112261qvp.129.1669235172559; Wed, 23
 Nov 2022 12:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1459152.1669208550@warthog.procyon.org.uk> <CAHk-=wghJtq-952e_8jd=vtV68y_HsDJ8=e0=C3-AsU2WL-8YA@mail.gmail.com>
 <1619343.1669233783@warthog.procyon.org.uk>
In-Reply-To: <1619343.1669233783@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 12:25:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJBOAOqB8wWxeAtKy3b9r4rn2Y48+zsuDDhKJ3D3D4cw@mail.gmail.com>
Message-ID: <CAHk-=whJBOAOqB8wWxeAtKy3b9r4rn2Y48+zsuDDhKJ3D3D4cw@mail.gmail.com>
Subject: Re: [PATCH v3] mm, netfs, fscache: Stop read optimisation when folio
 removed from pagecache
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 23, 2022 at 12:03 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > But I also think it's strange in another way, with that odd placement of
> >
> >         mapping_clear_release_always(inode->i_mapping);
> >
> > at inode eviction time. That just feels very random.
>
> I was under the impression that a warning got splashed if unexpected
> address_space flags were set when ->evict_inode() returned.  I may be thinking
> of page flags.  If it doesn't, fine, this isn't required.

I don't know if the warning happens or not, but the thing I reacted to
was just how *random* this was. There was no logic to it, nor any
explanation.

I *suspect* that if we add this kind of new generic address space
flag, then that flag should just be cleared by generic code when the
address space is released.

But I'm not saying it has to be done that way - I'm just saying that
however it is done, please don't make it this random mess with no
explanation.

The *setting* of the flag was at least fairly obvious. I didn't find
code like this odd:

+       if (v9inode->netfs.cache)
+               mapping_set_release_always(inode->i_mapping);

and it makes all kinds of sense (ie I can read it as a "if I use netfs
caching for this inode, then I want to be informed when a folio is
released from this mapping").

It's just the clearing that looked very random to me.

Maybe just a comment would have helped, but I get the feeling that it
migth as well just be cleared in "clear_inode()" or something like
that.

> > That code makes no sense what-so-ever. Why isn't it using
> > "folio_has_private()"?
>
> It should be, yes.
>
> > Why is this done as an open-coded - and *badly* so - version of
> > !folio_needs_release() that you for some reason made private to mm/vmscan.c?
>
> Yeah, in retrospect, I should have put that in mm/internal.h.

So if folio_needs_release() is in mm/internal.h, and then mm/filemap.c
uses it in filemap_release_folio() instead of the odd open-coding, I
think that would clear up my worries about both mm/filemap.c and
mm/vmscan.c.

                Linus
