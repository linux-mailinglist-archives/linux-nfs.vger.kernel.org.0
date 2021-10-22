Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79747437F4C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhJVU1T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhJVU1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:27:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F1C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:25:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u5so1488038ljo.8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=Xm2NbmUwKJoW+515TkyEWt2nuCvePzoqxLYJAFPnOe+lbdK5JzMmyaBBRaBeBIIVr6
         5Y2Ltv7T1OVUR3yQVc1hEpZ4faavbhalIte0tSbwN89GggYecoOBuJphVvusUfCFdqxX
         UgjPbDpPnxZpf2xYUJtsUcqxyBe+gW6XgMyZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=E7RjpJ4SggNXZ863kSdkmeGcK9TOED34nitqHwwWd/katWOtXTtKWTgUNeAGFhXk+R
         Z3QiZg1zzqLx9tFEJAuyjhBm6B+mkCeLHon6+qJHBLcQcxd/eOcofZVnqqedddW/05cY
         5FwgZ6MSkPU+6BXlr8YPzYs8iAxCMcnragWP6FMELJKnSL3CVPcmLSP4qnML3/QKz2DQ
         hm9iIJYv0LDR4GBXHOsRoB8lNvpHa3ZSxIcy6Y4TB4VSaJV8rSkr+je5WAknrnTvZCcY
         mb8IePGviKrABZBOG+yVZ+9xyliZSU+7/wmNeg6WWfwDE/5Iik4sp+MOvO4GYyMJKNA5
         JLtg==
X-Gm-Message-State: AOAM532tVlo4/s44pihsE5lYNBv0nK1nSV15rdQkAfvAsUCrkayD/oq+
        7G2PjKYq2Y+hylXnP9dgHkZssvpCIaz+zfnj1hk=
X-Google-Smtp-Source: ABdhPJwY4jnFkOXCxSeiFU5zbDX+oJCeXB2LTCQUJrGzWsj9I2DnSNlKiEsAR/9XLN47FxW58VV5TA==
X-Received: by 2002:a05:651c:1799:: with SMTP id bn25mr1659903ljb.514.1634934299101;
        Fri, 22 Oct 2021 13:24:59 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q6sm141644lfa.267.2021.10.22.13.24.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 13:24:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w23so3459848lje.7
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:24:57 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr2174611ljj.249.1634934297582;
 Fri, 22 Oct 2021 13:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
 <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
 <1041557.1634931616@warthog.procyon.org.uk> <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 10:24:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 22, 2021 at 9:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and if (c) is the thing that all the network filesystem people want,
> then what the heck is the point in keeping dead code around? At that
> point, all the rename crap is just extra work, extra noise, and only a
> distraction. There's no upside that I can see.

Again, I'm not a fan of (c) as an option, but if done, then the
simplest model would appear to be:

 - remove the old fscache code, obviously disabling the Kconfig for it
for each filesystem, all in one fell swoop.

 - add the new fscache code (possibly preferably in sane chunks that
explains the parts).

 - then do a "convert to new world order and enable" commit
individually for each filesystem

but as mentioned, there's no sane way to bisect things, or have a sane
development history in this kind of situation.

                Linus
