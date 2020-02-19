Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC6164B4B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2020 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSRAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Feb 2020 12:00:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41663 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBSRAn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Feb 2020 12:00:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so1115250ljc.8
        for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2020 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5MHK2yWJoKDFDgFN/xoudtHEVHOYHcak3UXICAOE48=;
        b=QIshA1U9KR9JH3ePvLT5ZY3Vx07hTFRKDbl+K9mKTvwZGUJgQmsNDzQNHyD8IIWR2d
         Q0yRg6+HxDrXEGdXe9VGj4GRg91S0SZg3nykCIODKvhX+L/Jppo0cyFJQEhwA9V8JwEk
         yE0AI/4FI83Suua0qMGWnvqbFXRE2hRE7jPY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5MHK2yWJoKDFDgFN/xoudtHEVHOYHcak3UXICAOE48=;
        b=EUrAB7IGrBM8+taNUpeWx0B/ZUa0+9uSX1uMgCyamTWSrPkws54xWcuTWB29Pu0s4+
         EyB2xHuTy1GdTSrz7CgCNdevGTyFkcqSe8QkXyLtj3IvrnHVLk8fNJs8r1r6k1bpds5P
         owkrBYGpUqGpeNvBim58G714ctAiV43V+4AuUnHwKDUxkP4ZxIVEENHb3z4oOnKa+AHC
         9pMU+MD72WNp7SpKx64tuRgj6CG0yfLNMIHj/2pDzDbxjP0uy/c3JdcQYqa7X5LT3NMF
         nR+EAL2WiQksDl9BX3VGS4W9VxIjs/E9u+R4blPDTw9tHPGN0AXopSCvNqmHStbEZtqI
         Zg+g==
X-Gm-Message-State: APjAAAVEnVypdRQ6PAT+YJUtB9egvyVvq42ecz0CcPDpD43d+GI/f4J9
        yuvynFzY39QaF1OutfwtoYP14krSe9I=
X-Google-Smtp-Source: APXvYqzV8V7CZVTqZNoxk19OlU1sKf3wA8hJrJcFJyKASlz3TLmSWGQ5yhPLM8mvXHm0nfaLHGzqow==
X-Received: by 2002:a2e:e12:: with SMTP id 18mr16847727ljo.123.1582131640767;
        Wed, 19 Feb 2020 09:00:40 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b20sm162111ljp.20.2020.02.19.09.00.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:00:39 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q23so1135788ljm.4
        for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2020 09:00:39 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr16681270ljk.201.1582131638422;
 Wed, 19 Feb 2020 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <227117.1582124888@warthog.procyon.org.uk>
In-Reply-To: <227117.1582124888@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 09:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
Message-ID: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 19, 2020 at 7:08 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > The above nicely explains what the patch does.
> > However, unless I'm missing something, this fails to explain the "why"
> > (except for the vague "[...] is something that AFS needs ...".
>
> I'm not allowed to implement pioctl() for Linux, so I have to find some other
> 'structured' (to quote Linus) way to implement the extra functions for the
> in-kernel AFS client.

Honestly, the "create_mountpoint()" thing isn't any better. It's worse
and exposes an interface that makes no sense.

What are the insane pioctl semantics you want?

If you can't even open a file on the filesystem, you damn well
shouldn't be able to to "pioctl" on it.

And if you *can* open a file on the filesystem, why can't you just use
ioctl on it?

So no, the new system calls make no sense, and your explanation for
them is lacking too.

Give a very concrete example of what you want to do, and why AFS would
be so super-duper-magical, and why you can't just use ioctl on an
existing directory.

And no, "maybe the directories aren't readable" isn't an excuse, as
mentioned. Why the hell would you want to do pioctl on a non-readable
path in the first place?

                Linus
