Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD74401C2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJ2SUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SUs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 14:20:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A6C061570
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 11:18:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s19so18143924ljj.11
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR8MaXQV2dAoTf7veoG8XVBeAhgdgomPxezXzaQONmo=;
        b=HVDkvGeodIU22X5kjbO7ZR0lTCWWwkScN+820L1CO6Jp/wFHT2URTkNHboM7IjptmB
         YVg/RfMSjgzCpZAxQHFmCUZlYnl5lVQQW/xElvUR6baO9Q4c6uG+lfqCGqGH4kKGh1KE
         qArq9uCu2p9WrvPFJV+b6G0oeDLEt/s/4EqMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR8MaXQV2dAoTf7veoG8XVBeAhgdgomPxezXzaQONmo=;
        b=Nn6HXuxqrGyA/zKPfTS5ZRF17tApYZlyrOwagLUcA7ElCKpWCvTrp0E9lRFM8ExK2j
         ssIvjzt3d9FnrzHGFQAO0Rlx9zKtKZxcB8AlxA/FK3uyYRMqihyZq9JAWj7JS7tPwXtS
         SEbwi35pLLL3k1gjXO8FrtI2lMCU1digj9ZvlH9v0IfjfsT7yXFqllFqAqvr5oR4ufaD
         wPC0ivFs+c3t9sLI9n7ZdQiaNnf5MqrXfCW4LQWkyliiodZ5c3PRcbX0P38Xihfg+qAx
         AGqh8rZXTmdh/T4X97gapW9+J28WYogm840mjTYpLi9SaHV2Y9sx7D9nHIENYvjxEqZ4
         kd5Q==
X-Gm-Message-State: AOAM53375Es+I6UYSuIGWa984X0laBhraGXpV+mdkeIdRhLCzFf6OU/m
        GlWvH23L+ecXAChEj090z9YvGp96gWI8GqnWUrs=
X-Google-Smtp-Source: ABdhPJy5+/Ao8BKikctTobemAjUCXrTUdYZUT7Gv01ffYdKOzRGbtKbprXK50XA1zLbrQ4vrIPb8Zg==
X-Received: by 2002:a2e:a444:: with SMTP id v4mr12924090ljn.33.1635531497196;
        Fri, 29 Oct 2021 11:18:17 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r3sm670455lfc.114.2021.10.29.11.18.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:18:16 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n7so18215308ljp.5
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 11:18:15 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr12949536ljb.56.1635531495482;
 Fri, 29 Oct 2021 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
 <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com> <1889041.1635530124@warthog.procyon.org.uk>
In-Reply-To: <1889041.1635530124@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 11:17:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com>
Message-ID: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 10:55 AM David Howells <dhowells@redhat.com> wrote:
>
> This means bisection is of limited value and why I'm looking at a 'flag day'.

So I'm kind of resigned to that by now, I just wanted to again clarify
that the rest of my comments are about "if we have to deal with a flag
dat anyway, then make it as simple and straightforward as possible,
rather than adding extra steps that are only noise".

> [ Snip explanation of netfslib ]
> This particular patchset is intended to enable removal of the old I/O routines
> by changing nfs and cifs to use a "fallback" method to use the new kiocb-using
> API and thus allow me to get on with the rest of it.

Ok, at least that explains that part.

But:

> However, if you would rather I just removed all of fscache and (most of[*])
> cachefiles, that I can do.

I assume and think that if you just do that part first, then the
"convert to netfslib" of afs and ceph at that later stage will mean
that the fallback code will never be needed?

So I would much prefer that streamlined model over one that adds that
temporary intermediate stage only for it to be deleted.

             Linus
