Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9276337909
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfFFQBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 12:01:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33466 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfFFQBq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jun 2019 12:01:46 -0400
Received: by mail-it1-f195.google.com with SMTP id v193so2446449itc.0
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jun 2019 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABCfAmT6WOqIRYUnhdQj6ZE+XlZQB9hg7YCFkgLqi/E=;
        b=m1WSMi7lU2cp4fUhMsxm45BH/s/HZfry3HAFJ49LBn9WkRNv9jAn2IEx61y5EGcSK5
         0vrMmnZwzG6sbMzWD5aaYg7T/7RJW9ISMGX/YcCWjFZFujnl+/E5nF5Br8U5hy05X0Bw
         DE+vJlHtipsIxV5bQ5BQdBWGV1z5Mnr2fWam2PpQXDXwBvt2vPDxikys5WoZiLVcgUmQ
         CL+wqqJr2OnFmy3qio++YmMsBhy4+pxKXk++m4YkyuwAouRStWIIy8dslnWJ1bnz7JOs
         08wDUWy8CJGwp6jM68b7sPq1Dt4LZ4TzrH+z658SZ0gMPO1BinTWsgCvgLqnq9UFd6Oq
         E96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABCfAmT6WOqIRYUnhdQj6ZE+XlZQB9hg7YCFkgLqi/E=;
        b=Etzlcc0lBPYZl3ZUsaOIP6qr3BHxpCrZ+4/8FAHA9EbtBYOb63RZRWTUdJBTYttLmN
         1Jo3gVth+Of8JSwIEjmOMC/jjvIiYrxV/ECDJuqpyNnYnhiTU0Se2ZsHgyYFvgRhiFFn
         GXDfvDClKu4Bg01KAk2/nMID8NzP+IbX3lyYpjvu+azEz6mgm48IH3IZPcwoeY5Ryq5h
         CVBDttG5dhwA6ddBDDe7aEZ7LZoFUz0LJHhZyK6MXSjRLOz8/5M7Od2l/t7pQQ3UgUKA
         mwmOvXchRa7Dpj3eIJV0ffDapSF51/F8IDzoWg8CNtrHx30SKJwDVqebDH1weDKxVR8t
         vzZA==
X-Gm-Message-State: APjAAAV3KKszGzm/Cllibw2JDv7owspk/8/+N2DOJ1UfDyka/8fK8Jl6
        iR/Q77dXxfeLDlDN/qW6YrP8pKtQlpxq8Rm8OseGdA==
X-Google-Smtp-Source: APXvYqwv7h6N6Q2jeZW15aYywh1V3kX0M5425XRJ6kuENcEaAf9CZR15OYA5xBSvMb9jM/sya562GzUw+Koo5ckdANw=
X-Received: by 2002:a24:4417:: with SMTP id o23mr700144ita.88.1559836904841;
 Thu, 06 Jun 2019 09:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a4b99058a97f42e@google.com> <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org> <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
 <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com>
 <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com> <CACT4Y+aZNxZyhJEjZjxYqh34BKz+VnfZPpZO9rDn0B_9Z_gZcw@mail.gmail.com>
 <ae7ccef7-6972-370f-e9df-951771d1e234@virtuozzo.com>
In-Reply-To: <ae7ccef7-6972-370f-e9df-951771d1e234@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 18:01:33 +0200
Message-ID: <CACT4Y+Z_CF8h=enZsmZ1mcnVVKxPam0Xhczyz7zYXGbvEBqHTQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, bfields@redhat.com,
        Chris Down <chris@chrisdown.name>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, guro@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jeff Layton <jlayton@kernel.org>, laoar.shao@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nfs@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yang.shi@linux.alibaba.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 6, 2019 at 5:25 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.06.2019 18:18, Dmitry Vyukov wrote:
> > On Thu, Jun 6, 2019 at 4:54 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 06.06.2019 17:40, Dmitry Vyukov wrote:
> >>> On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>
> >>>> On 06.06.2019 16:13, J. Bruce Fields wrote:
> >>>>> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
> >>>>>> This may be connected with that shrinker unregistering is forgotten on error path.
> >>>>>
> >>>>> I was wondering about that too.  Seems like it would be hard to hit
> >>>>> reproduceably though: one of the later allocations would have to fail,
> >>>>> then later you'd have to create another namespace and this time have a
> >>>>> later module's init fail.
> >>>>
> >>>> Yes, it's had to bump into this in real life.
> >>>>
> >>>> AFAIU, syzbot triggers such the problem by using fault-injections
> >>>> on allocation places should_failslab()->should_fail(). It's possible
> >>>> to configure a specific slab, so the allocations will fail with
> >>>> requested probability.
> >>>
> >>> No fault injection was involved in triggering of this bug.
> >>> Fault injection is clearly visible in console log as "INJECTING
> >>> FAILURE at this stack track" splats and also for bugs with repros it
> >>> would be noted in the syzkaller repro as "fault_call": N. So somehow
> >>> this bug was triggered as is.
> >>>
> >>> But overall syzkaller can do better then the old probabilistic
> >>> injection. The probabilistic injection tend to both under-test what we
> >>> want to test and also crash some system services. syzkaller uses the
> >>> new "systematic fault injection" that allows to test specifically each
> >>> failure site separately in each syscall separately.
> >>
> >> Oho! Interesting.
> >
> > If you are interested. You write N into /proc/thread-self/fail-nth
> > (say, 5) then it will cause failure of the N-th (5-th) failure site in
> > the next syscall in this task only. And by reading it back after the
> > syscall you can figure out if the failure was indeed injected or not
> > (or the syscall had less than 5 failure sites).
> > Then, for each syscall in a test (or only for one syscall of
> > interest), we start by writing "1" into /proc/thread-self/fail-nth; if
> > the failure was injected, write "2" and restart the test; if the
> > failure was injected, write "3" and restart the test; and so on, until
> > the failure wasn't injected (tested all failure sites).
> > This guarantees systematic testing of each error path with minimal
> > number of runs. This has obvious extensions to "each pair of failure
> > sites" (to test failures on error paths), but it's not supported atm.
>
> And what you do in case of a tested syscall has pre-requisites? Say,
> you test close(), which requires open() and some IO before. Are such
> the dependencies statically declared in some configuration file? Or
> you test any repeatable sequence of syscalls?

There are several things at play here.
1. syzkaller has notion of "resources". A resource is something that's
produced by one system call and consumed by another, like a file
descriptor.
E.g. see this for userfault fd:
https://github.com/google/syzkaller/blob/698773cb4fbe8873ee0a2c37b86caef01e2c6159/sys/linux/uffd.txt#L8-L12
This allows syzkaller to understand that there is something called
fd_uffd that is produced by userfaultfd() and then needs to be passed
to ioctl$UFFDIO_API().
So for close it knows that it needs to get the fd somewhere first.

2. For syscalls are not explicitly tied by any resources, it will just
try to combine them randomly.

3. There is coverage-guided reinforcement learning. When it discovers
some sensible combinations of syscalls (as denoted by new kernel code
coverage) it memorizes that program for future mutations to get even
more interesting and more sensible programs. This is allows syzkaller
to build more and more interesting programs by doing small incremental
steps (this is the general idea of coverage-guided fuzzing).
