Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD16131B3D7
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 02:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBOBID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 20:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBOBIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 20:08:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B14C061756
        for <linux-nfs@vger.kernel.org>; Sun, 14 Feb 2021 17:07:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y26so8563555eju.13
        for <linux-nfs@vger.kernel.org>; Sun, 14 Feb 2021 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oLEqXUvdqy1QH/cRggvF58640ngzAUjBT8Tfk3Wjwg=;
        b=eb+VDAyVwB6RZ6vXNDSIXjjY5/KGJonBZpcw4InpSNpoqcKC9wCYBknhMsgf9sPklg
         GzCvnbIRKgTg7gtA7teRfKAGGFk9BR9qw3HHsG7GJ3+trFjsmHXqEUXRQMhyaGXIHFPG
         +BYG0bBsO6r2Y7DOTssLQQLnPqsDN5e1ysQAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oLEqXUvdqy1QH/cRggvF58640ngzAUjBT8Tfk3Wjwg=;
        b=agOkB5PiwlUYtGmtzs7ovVKwjjg7JZQVFQSubFI3Pmg8dE7Nt/d5WBInBwx8LPV5SD
         kYbQxWt0G8fitTPtaRi3BGgowdgSzKpaK6FQbeJl1Yc4jYizq7wR0sWreV2NUaffu6wL
         KHhTGUWBT0Vqwl5X5K7tjqvJeB7hhyFsxwTtMdodLGjrddGfG9z6Zb8Ph2Mun6FDtW33
         qlU5Cet3t7yu33iky96DnidIUgR9TmlXTLhIGEFH2P94578rJBNjVOiBaO/57a+20B9T
         v7OgBV9A4h7xHXkGqft2xonuXWk7DvzIm1aE5Hg3pdRFOrKZCBHCQg64doa790QkWX60
         dfVA==
X-Gm-Message-State: AOAM5304fHeO6tZWAFLkyNX6Eui8oA2DJk3yfZ0tiWw6TvQoipNkONJ/
        W4yX0nvh3v8mla+x9GLu6gmnxVlE8OEKxA==
X-Google-Smtp-Source: ABdhPJzpncvT63Oo056zhWqxmL3Dn529DQiDi2szpsbPEeYQco8xmrpYtF5Y9yv9afpiomDpd1PXWQ==
X-Received: by 2002:a17:906:d10c:: with SMTP id b12mr3959985ejz.477.1613351240328;
        Sun, 14 Feb 2021 17:07:20 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id z2sm9655930ejd.44.2021.02.14.17.07.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 17:07:20 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id q10so6252917edt.7
        for <linux-nfs@vger.kernel.org>; Sun, 14 Feb 2021 17:07:19 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr8181174ljb.465.1613350911576;
 Sun, 14 Feb 2021 17:01:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
 <27816.1613085646@warthog.procyon.org.uk> <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
 <860729.1613348577@warthog.procyon.org.uk>
In-Reply-To: <860729.1613348577@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 17:01:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7xY3UF7zEc0BNVNjOox59jYBW-Gfi7=emm+BXPWc6nQ@mail.gmail.com>
Message-ID: <CAHk-=wh7xY3UF7zEc0BNVNjOox59jYBW-Gfi7=emm+BXPWc6nQ@mail.gmail.com>
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

On Sun, Feb 14, 2021 at 4:23 PM David Howells <dhowells@redhat.com> wrote:
>
> Anyway, I have posted my fscache modernisation patches multiple times for
> public review, I have tried to involve the wider community in aspects of the
> development on public mailing lists and I have been including the maintainers
> in to/cc.

So then add those links and the cc's to the commit logs, so that I can
*see* them.

I'm done with this discussion.

If I see a pull request from you, I DO NOT WANT TO HAVE TO HAVE A
WEEK-LONG EMAIL THREAD ABOUT HOW I CANNOT SEE THAT IT HAS EVER SEEN
ANY REVIEW.

So if all I see is "Signed-off-by:" from you, I will promptly throw
that pull request into the garbage, because it's just not worth my
time to try to have to get you kicking and screaming to show that
others have been involved.

Can you not understand that?

When I get that pull request, I need to see that yes, this has been
reviewed, people have been involved, and yes, it's been in linux-next.

I want to see "reviewed-by" and "tested-by", I want to see "cc", and I
want to see links to submission threads with discussion showing that
others actually were involved.

I do *not* want to see just a single signed-off-by line from you, and
then have to ask for "has anybody else actually seen this and reviewed
it".

Look, here's an entirely unrelated example from a single fairly recent
trivial one-liner memory leak fix:

    Fixes: 87c715dcde63 ("scsi: scsi_debug: Add per_host_store option")
    Link: https://lore.kernel.org/r/20210208111734.34034-1-mlombard@redhat.com
    Acked-by: Douglas Gilbert <dgilbert@interlog.com>
    Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

that's from a quite a trivial commit. Yes, it's trivial, but it could
still be wrong, of course. And if somebody ever reports that it causes
problems despite how simple it was, look at what I have: I have three
people to contact, and I have a pointer to the actual original
submission of the patch.

Do we have that for all our commits? No. But it's also not at all
unusual any more, and in fact many commits have even more, with
testing etc.

And yes, sometimes the test results and acks come back later after
you've already pushed the changes out etc, and no, it's generally not
worth rebasing for that - maybe others have now started to rely on
whatever public branch you have. Which is why the "Link:" is useful,
so that if things come in later, the discussion can still be found.
But quite often, you shouldn't have pushed out some final branch
before you've gotten at least *some* positive response from people, so
I do kind of expect some "Acked-by" etc in the commit itself.

THAT is what you need to aim for.

And yes, I'm picking on you. Because we've had this problem before.
I've complained when you've sent me pull requests that don't even
build, that you in fact had been told by linux-next didn't build, and
you still sent them to me.

And as a result, I've asked for more involvement from other people before.

So now I'm clarifying that requirement - I  absolutely need to see
that it has actually seen testing, that it has seen other people being
involved, and that it isn't just you throwing spaghetti at the wall to
see what sticks.

And I'm not going to do that for every pull request. I want to see
that data *in* the pull request itself.

            Linus
