Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9831A951
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 02:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhBMBIC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 20:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhBMBHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 20:07:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3CFC061225
        for <linux-nfs@vger.kernel.org>; Fri, 12 Feb 2021 17:06:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d24so2021438lfs.8
        for <linux-nfs@vger.kernel.org>; Fri, 12 Feb 2021 17:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6jTxP9hlbcUR9+3iPNQ9HmsqF25QNS6zvjTzXBH5E4=;
        b=WUNxTILAYi3Kk+wVUIaUVhIr3oaiaHaDjKr023ekUsCD6VQNr+/uPlhMEL6q29t3EB
         7gNdhrTjI0bG4chV1tfJBSEWmnvTFlDxKHjMtcZld38+fszGfI/ow6zlOY5oPPFVrq11
         U9kc9/PviiJUNwLPvQe5fwcbGhKWs2MNkDWS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6jTxP9hlbcUR9+3iPNQ9HmsqF25QNS6zvjTzXBH5E4=;
        b=XSUP5+iNRy2kr8IET813jcRdVlnWnqG/4XWGgM0uh5sHuaq2GbZ++KRp0aprZk1Z1W
         ASlsl7/VP5WhrCh2C6+5Gaj7r42DFCyhU1SKElKCwjM7iT5isgiNQ7t5CEyiahPnmsW6
         9/AoO3bZm5f71UhZl8JYhT405apEDk9zMqeC9Lnhqa/sL1WnLX1B47IB/M2zDKAn6Cm+
         5kE0omGGgMg4/kPpGvvLYRRCNSQtdxotzNU7mCRgEz+tORFCZKfuA2A8MR0+770FqtuJ
         DKe2Kr6CaYlOLNkLs1Knvf6O6J1wmmctnOsgKDH7ZruaxIY/Btb75xezxY/8JVAfDqtK
         aznw==
X-Gm-Message-State: AOAM530N4Fx2KIEr92Tnh5ck23/TdkwpYDJvaQJYm7rq4hQG8ttoeCW/
        //DnWcGm5uHqRqEllWNssdvareZ8yVr9sg==
X-Google-Smtp-Source: ABdhPJxl8539hc9kkrAno+4cQp/ZWqvZdnI2SivhbEoMNfGaTHgg50RnPxC8w2VV1qFvWaTUl+7lWQ==
X-Received: by 2002:a19:6c3:: with SMTP id 186mr2169028lfg.399.1613178366860;
        Fri, 12 Feb 2021 17:06:06 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 5sm1418214lff.176.2021.02.12.17.06.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 17:06:04 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id j6so1187875ljo.5
        for <linux-nfs@vger.kernel.org>; Fri, 12 Feb 2021 17:06:04 -0800 (PST)
X-Received: by 2002:a2e:8049:: with SMTP id p9mr3052102ljg.411.1613178363694;
 Fri, 12 Feb 2021 17:06:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
 <27816.1613085646@warthog.procyon.org.uk>
In-Reply-To: <27816.1613085646@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Feb 2021 17:05:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
Message-ID: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 3:21 PM David Howells <dhowells@redhat.com> wrote:
>
> Most of the development discussion took place on IRC and waving snippets of
> code about in pastebin rather than email - the latency of email is just too
> high.  There's not a great deal I can do about that now as I haven't kept IRC
> logs.  I can do that in future if you want.

No, I really don't.

IRC is fine for discussing ideas about how to solve things.

But no, it's not a replacement for actual code review after the fact.

If you think email has too long latency for review, and can't use
public mailing lists and cc the people who are maintainers, then I
simply don't want your patches.

You need to fix your development model. This whole "I need to get
feedback from whoever still uses irc and is active RIGHT NOW" is not a
valid model. It's fine for brainstorming for possible approaches, and
getting ideas, sure.

               Linus
