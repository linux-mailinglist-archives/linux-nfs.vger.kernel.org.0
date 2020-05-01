Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4494F1C1C69
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgEAR7o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729918AbgEAR7o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:59:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE4C061A0E
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:59:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so4451586lfa.10
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXn4r+MPXVyQgD4o3lQqxkPpG/DsRtiXml/AiVaSQ7U=;
        b=WDGjF9aBE/SCwrRF0wdMLKxLM+QBOED6GjGnh6yXS7IP9HNxSxs21YXx3b3eIWkRI+
         /iNXc1c8XqN+ZOv5RPZgMGtVWgGn1/M1GJiDFUpCwhOvhhQ2k3vHVaVXg71Yqenb+sMH
         3GKDp4UGgBZCrrhROjcIpyZllnUqK4vi18uQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXn4r+MPXVyQgD4o3lQqxkPpG/DsRtiXml/AiVaSQ7U=;
        b=C8td1MmpuRFfAuqRtW0MntEEh5bqQgwEvdggRujDmpKT8j+kSYR0Lt2AoeIa/IWXcu
         FLq6EN/qCtjxll2gELrQ5hvyOQp19NGVsPnWfTiFLvfkpfaiDvaMH4v3DYDbMabDIN1z
         0lGlzh//bKpxwFccNFKWM1WuLlmOEph3foA+ONJ0GvU0sPRZ2gKCFRXvyon3y6rsksiA
         e3dSQYG5ToSvceTmNGZAm9gNIZxNI6WjQSfG37aR9AuCAqOaISwalzkngJLxoW15R2a7
         bJOuYYMxycYrPSBNOf7nnwcPMauivwD32P1rNp7IHU8qyLy7oB1jmP5a4+xrqlFV/MPo
         Yu6w==
X-Gm-Message-State: AGi0PuZNcmNMIoliblgDSGyttinU8s05KGS0cnQxZmYYcSHLOnF0vqfV
        YlaUQDVbTK5wcFTiJnyXbWc1qkDqSF0=
X-Google-Smtp-Source: APiQypLmYKOcTOxkr5gNYIEB5Ncq0xQriSzrN8FHdJwSinS/ixuuDwNch3gXt5xd52EtfUnsjvJVrQ==
X-Received: by 2002:a19:550a:: with SMTP id n10mr3214327lfe.143.1588355981581;
        Fri, 01 May 2020 10:59:41 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y9sm2349808ljm.11.2020.05.01.10.59.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:59:40 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a21so3301143ljj.11
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:59:40 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2962897ljg.204.1588355980014;
 Fri, 01 May 2020 10:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
In-Reply-To: <1588348912-24781-1-git-send-email-bfields@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 May 2020 10:59:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
Message-ID: <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 1, 2020 at 9:02 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> Anyway, does this multiple kthreadd approach look reasonable?

I don't see anything that looks alarming.

My main reaction was that I don't like the "kthreadd" name, but that's
because for some reason I always read it as "kthre add". That may be
just me. It normally doesn't bother me (this code doesn't get all that
much work on it, it's been very stable), but it was very obvious when
reading your patches.

In fact, I liked _your_ naming better, to the point where I was going
"'kthread_group' is a much better name than 'kthreadd', and that
'kthreadd()' function would read better as 'kthread_group_run()' or
something".

But that may just be a personal quirk of mine, and isn't a big deal.
On the whole the patches looked all sane to me.

> (If so, who should handle the patches?)

We have had _very_ little work in this area, probably because most of
the kthread work has been subsumed by workqueues.

Which kind of makes me want to point a finger at Tejun. But it's been
mostly PeterZ touching this file lately..

                Linus
