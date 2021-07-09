Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961353C2809
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIRML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jul 2021 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jul 2021 13:12:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8ABC0613DD
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jul 2021 10:09:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a6so9116783ljq.3
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jul 2021 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBhcYMUl2xlWqh1FOBf7oxdHmtzU8noyHn56sS3VewQ=;
        b=HiGFi2E15x32PX3njJDWrVvTsLBOSaGOKg60iPGD69rXNs3jRSWIcD68BeSV/F9zVG
         95W1G2I+8fkAiGUajAUSmuF1lboZBUyWzG61Qbu5Q4dg24vCbxRVzEuGHLP/42Lo8gm0
         PqnJmXGQvoVg6B/nG2f2X5sNgX3X+1BgM8M1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBhcYMUl2xlWqh1FOBf7oxdHmtzU8noyHn56sS3VewQ=;
        b=d2VYmf4CN4iiECYNo06+E8yZmHzIepizfaVUeHmD11N6AeDa1sm7V7dp5LFLUbiJsL
         4QNwz2sMEr2BzEt2TsrcqHZzAGbSbS0etPTlP1l+JNZh3uDkSFQyLe6SEKBebaVaPJg0
         MTNIcYwiUrS16i+PbYoXGNcwqzPZlDWzXbqiq7gQxWmiAhJktJ6Yjfhld3wZ4IH+KhE0
         C0djuFX0tyz5vqGJWNjeouJ5KGlr/ZtF4R67VxzYd7mVsAIAs5OKPyYza92oE1JuNzfR
         fGtT5d9eRJxn9xw2WQtNVhkaU055ydcBMeb/pJzMsAI4iuaPyGRloDTzrW/nsh2kgtVe
         e/CQ==
X-Gm-Message-State: AOAM531zAZQ+1YuypTruBthBF/T6io1qlE/ub9o4TcjQmsIALEB7KkZ2
        Yk4Bv9ihHk4FAShBdmqBRSB4uRmGQPuf8CVQu/c=
X-Google-Smtp-Source: ABdhPJxlZKrE2vgIXGHEfhrJSdbH79lC+UfsdKVHNHUwNzpe3GNKpfGFLkPzCky/iT199NFcHzLCLg==
X-Received: by 2002:a2e:9085:: with SMTP id l5mr274130ljg.103.1625850565088;
        Fri, 09 Jul 2021 10:09:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s21sm510302lfi.166.2021.07.09.10.09.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 10:09:24 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f13so24426194lfh.6
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jul 2021 10:09:24 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr1343435lfl.487.1625850564418;
 Fri, 09 Jul 2021 10:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <6809750d3e746fb0732995bb9a0c1fa846bbd486.camel@hammerspace.com>
 <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com> <448e0f2b96b7fa85f1dd520b39a24747ea9487ed.camel@hammerspace.com>
In-Reply-To: <448e0f2b96b7fa85f1dd520b39a24747ea9487ed.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jul 2021 10:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLAQPisWbcoc+YcUdtLp87TMc29bETJrS4f6pjoAAy5Q@mail.gmail.com>
Message-ID: <CAHk-=wjLAQPisWbcoc+YcUdtLp87TMc29bETJrS4f6pjoAAy5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.14
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 9, 2021 at 9:55 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Thanks! It didn't result in any overall code changes or even changes to
> the result of the merges. However if you're OK with the occasional
> duplicate patch then I'll make sure to avoid this in the future.

The occasional duplicate patch is actually completely normal.

Particularly when it is something like an important fix that gets
pushed to mainline late in the -rc series: people often want them in
their development trees as well for testing, and so you end up with
the same fix both in mainline and in the "for next merge window"
branch.

In fact, that "important fix that goes to both branches" can be a very
good thing, exactly because you want to test that -next branch, and
you want to do it without having to worry about old bugs that might
trigger or hide new issues.

And then I very much want to pull that _tested_ development branch,
not some "ok, I removed that fix from the branch before asking Linus
to pull, because it's already in his tree".

See?

And yes, sometimes they happen by mistake, and the duplication is not
intentional, and it's not some "good thing". It happens just because
the same patch was sent two different ways.

That's fine too.

It's a problem if they happen a _lot_ - partly because they do make it
much more likely to cause pointless merge conflicts (and mistakes can
happen during that stage), but even more because it shows that
something is going wrong in the patch management, and people are
stepping on each other's feet.

So then the duplicate patches is not necessarily a _technical_
problem, but it's indicative that something is wrong with patch flow.

But even then removing the duplicate patches is generally less
important than trying to fix the maintenance issue.

So on the whole, a couple of duplicate patches isn't a big deal, and
not worth rebasing.

Aim to keep rebasing mainly for "oh, keeping that will cause actual
problems" (and sometimes the "actual problems" can be about things
like truly horribly mangled commit messages and wrong attribution
etc).

So rebasing isn't necessarily always "wrong", but it just needs to
have a fairly compelling reason.

              Linus
