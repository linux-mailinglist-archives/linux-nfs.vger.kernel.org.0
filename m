Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A058D6D6
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2019 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHNPFj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Aug 2019 11:05:39 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34294 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNPFj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Aug 2019 11:05:39 -0400
Received: by mail-vs1-f66.google.com with SMTP id b20so9261086vso.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2019 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRwWNn9o4WZ6EwbxoyDVY9KLhC75r1TZOaUMMjB/hFY=;
        b=TwsPsB1I4mai5PTGQDrWqIyrq+FA4V1iLcmnqt8JOiHDhibjGdTvXhFje24mbGxg16
         ZmDsJFV40Llm5Jn8zYJZBa7oND9LGYKNTIvkERI3EE+RRERnu1NM6EsiZkYdw/nDSw40
         Wpuls1h38N7ZheAQ+cd5+7Uxl6hAQ+yW8M+TPYDdwsBz14OxcjkyLY6jYlKJVf3hIGj/
         Eq1LAGPWX2Zx+ra+gJr5beJG40S/h1YJiUAXS7nwAJwc6KzZdve2KU580xemoiGlXw7A
         3nN6RSIUQJX90hsQS8H67nQ+nCDQET3Wn2+inDrlvk13ShKosiTmZcqWzTh3b7xRImMo
         A9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRwWNn9o4WZ6EwbxoyDVY9KLhC75r1TZOaUMMjB/hFY=;
        b=iT5vC6vA5UDhdJ5lbYkxQQRVo5py6wEcIkIcheLTYoletlwsHZFj7cYH9fD1I+aQoB
         GRFZRmuRD0dzgPSrnkrRyVs8V2inpss9OXHxTY7MslFuS9kR+eBi2py5bT9Kt5NQoPpL
         SN8Sh8qkmjSRNmBPOrHKGVOqNphQogll2BMPjCVBxLJ8OhRkl+IWDLBvCG6cdplFF9W1
         ztsnLfX+HnXkXrD31GHH9rhZVP9VFzkF5NUh2/Q0oPguNdDe+UhxJoHudYGKinrs8197
         avJSkDdfcaUcbsuMmldtjhFsxrWOUq0nMdmsvq/bp0eEaqijV0BIb3QtszgPfM5wBD5u
         BOmA==
X-Gm-Message-State: APjAAAUJ+mBLbdrhELt+7kxK3QKr0/oPZHR4uj4m9K9beFniBUIpUdih
        DXISakpM6MVLB10xv3vGCjGo+M/xhNUFQb5CJJ0=
X-Google-Smtp-Source: APXvYqxepsSu4W7LUIuJppFVkNlv6Zt+sZmzBjeO0MbAyTM0kUDgT4m7xoxFLELIqLnZ68CEgpvqBmasGZ14UxXrKWs=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr30599385vsd.215.1565795137972;
 Wed, 14 Aug 2019 08:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190808201848.36640-6-olga.kornievskaia@gmail.com> <CAN-5tyF6ZMf_jiKycK1rk9v7xATDb=j_e5d0QBp9LOgdvn-utA@mail.gmail.com>
 <CAN-5tyEyvjJB+4_bKZmEYhv2KrVvk7dDvF27i6mx4naDt33Nww@mail.gmail.com>
 <20190812200019.GB29812@parsley.fieldses.org> <CAN-5tyFpHHsH3n8u+qGyp7POdSRHesiKgd3-YQoE9jJSPBVYRw@mail.gmail.com>
In-Reply-To: <CAN-5tyFpHHsH3n8u+qGyp7POdSRHesiKgd3-YQoE9jJSPBVYRw@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 14 Aug 2019 11:05:23 -0400
Message-ID: <CAN-5tyEX=4pfntZudpfkN9Pr9OpZfpvKj+NyT-bBD9YJ5fsg7Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 13, 2019 at 1:57 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 4:00 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 03:16:47PM -0400, Olga Kornievskaia wrote:
> > > On Mon, Aug 12, 2019 at 12:19 PM Olga Kornievskaia
> > > <olga.kornievskaia@gmail.com> wrote:
> > > > While this passes my testing, in theory this allows for the race that
> > > > we get the copy notify size but then offload_cancel arrive and change
> > > > the value. Then refcount_sub_and test_check would have an incorrect
> > > > value (can subtract larger than an actual reference count). I have no
> > > > solution for that as there is no refcount_sub_and_lock() that will
> > > > allow to decrement by a multiple under a lock. Thoughts?
> > >
> > > I tried not to use the client's cl_lock but instead use a specific
> > > lock to protect the copy notifies stateid on the stateid list. But
> > > since stateid's reference counter (sc_count) is protected by it, I
> > > think by getting rid of the special lock and using cl_lock will solve
> > > the problem of coordinating access between the sc_count and the
> > > copy_notify stateid list. Are the any problems with using such a big
> > > lock?
> >
> > Probably not.  But it can be confusing when a single lock is used for
> > several different things.  A comment explaining why you need it might
> > help.
>
> While holding the client's cl_lock to manipulate the list of copy
> notify stateids solves the refcount problem. It generates a different
> problem for the laundromat thread. There, client list is traversed
> already holding the cl_lock, so I can't call routines to free
> copy_notify stateid because in turn it calls nfs4_put_stid() which
> wants to take the cl_lock. Putting the copy_notify stateid on the
> reaplist and then I lose a pointer to the client structure that I need
> to take the lock. Then it seems the nfs4_cpntf_state structure would
> need to keep a pointer to the client structure but then I get a
> problem of making sure the nfs4_client structure isn't going away and
> because it even a bigger mess.
>
> I think I need to remove the code in the laundromat that looks for the
> not referenced copy_notifies stateid and just rely on cleaning on the
> removal of the stateid (basically what I originally had). Or I need to
> rely on the client to always send FREE_STATEID. I don't see other
> options, do you?

Ignore this Bruce. Trond gave me a good idea and gets me unstuck.

>
> >
> > --b.
