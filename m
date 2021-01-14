Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD62F6990
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhANSa6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbhANSa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jan 2021 13:30:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CCC061575
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:30:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id n8so7582380ljg.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BchT47wA8A8/MNzwX06f7KnYw8kCTPmyqyEJptLgPg=;
        b=W92nAPQ/rqraGSYVKN2y2UoLHCe513pUo7DJq9bG5CwaOo1zjp0LAY4E6GQOK4I3+W
         X4H8tBbhuskKKlvhZgkp9pHMotyUucLw684F2rrtfDUT9qCnzF4ENod/nMi8PBqxN6rm
         FjR7DVssNneOQJvwQmgDSbe5b5FI1O2G+g6kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BchT47wA8A8/MNzwX06f7KnYw8kCTPmyqyEJptLgPg=;
        b=SQro2Ut+Jylm981TgsE5PF2bs6MJ7iOOvJPLpsHUih/5lqgKkK1oa8QvFWUYZEWl31
         LwKCdS67w4zZCIaM64eAXSYQxD1M3DX9i7ch4Aph5fSOtq2ALCSEp2OcfVOYGssdYkGQ
         xBGoYi7d8yQmfY+NwhuT3uSCf5faeizwYF+WuZfDXncWmpFMac58A3EH4j/p9xvJqWRg
         1MIQRABcXbgLPXnJqU1PX8P6peA0PpkIuQs6KYIeEO882uxXYaAL1tfTv3gIicDMZNTd
         SMXE4tYZ9kZ/+51OIUvrPAIXKiLcvFaBl4BxcoQUw9KH26Tcr3AtBrGo25o8CXFfpDXq
         T0OA==
X-Gm-Message-State: AOAM531Twxe5YOPIozJXrwsRAu22pzFmvlJiqGRJlAMl/lWhVdNmCnYC
        zXM0QkqYpB3o1bIhTt6co56AyiR1t7+TnQ==
X-Google-Smtp-Source: ABdhPJzFbrSSw6UPBVZ/BrnCy/jAQmeQLJTGxxdYO9LepBPfAN6RvY39fCb8GFnyvrhSkZQd7I42AQ==
X-Received: by 2002:a2e:804a:: with SMTP id p10mr3897221ljg.295.1610649015592;
        Thu, 14 Jan 2021 10:30:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 186sm536823ljf.21.2021.01.14.10.30.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:30:13 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f17so7539038ljg.12
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:30:13 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr3548352lji.48.1610649013467;
 Thu, 14 Jan 2021 10:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20210108154230.GB950@1wt.eu> <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org> <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpTEBJ1jd_fr3GJ4k7KgzaBpe1LwKgyZn0AJ0D1ESK12fQ@mail.gmail.com>
 <96aea58bde3fe4c09cccd9ead2a1c85eb887d276.camel@hammerspace.com>
 <CAHxDmpTyrG74hOkzmDK834t+JiQduWHVWxCf_7nrDVa++EK2mA@mail.gmail.com>
 <74269493859fa65a7f594dadd5d86c74bd910e66.camel@hammerspace.com> <20210114180758.GB3914@fieldses.org>
In-Reply-To: <20210114180758.GB3914@fieldses.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 14 Jan 2021 10:29:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wic1CEkj_vjf3dUWv41=aKeazSW5ugGOfYsKQZnihQhMw@mail.gmail.com>
Message-ID: <CAHk-=wic1CEkj_vjf3dUWv41=aKeazSW5ugGOfYsKQZnihQhMw@mail.gmail.com>
Subject: Re: nfsd vurlerability submit
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 14, 2021 at 10:08 AM bfields@fieldses.org
<bfields@fieldses.org> wrote:
>
> I dug around a bit and couldn't find the idea of using filehandle
> guessing plus mountd's following of symlinks to get access to other
> filesystems.  That's kind of interesting.

[ Other people removed from cc, this is just a question about nfsd cleanliness ]

I missed if Trond's suggestion to at least fix up ".." to have the
same filehandle as "." for the top export directory was done.

Because honestly, the whole "guessing file handles is easy" argument
doesn't seem to cover the case that the client just does something
wrong _by_mistake_, and this ends up then exposing the server
unnecessarily that way.

It's one thing if you have an actively malicious client that is
controlled by an attacker and that then makes up its own file handles.

It's another thing if you have a (benign) client that can be fooled to
access files on the server that it shouldn't have.

So I think that from a pure cleanliness standpoint, the server
shouldn't give the client a file handle that the client mustn't
actually ever use! It's just a recipe for "oops, I didn't mean to do
something bad, but by mistake..."

Hmm?

               Linus
