Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37DF377A2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfFFPSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 11:18:31 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38451 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfFFPSb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jun 2019 11:18:31 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so542998itk.3
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jun 2019 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Czz2YJ7892NSsTQIUl/eIZo5zHlJk+9baf2OTNB6U0=;
        b=g9cYwVyeaSTJ4J3DPXQfg7qNzmOZHt86bELF+Z9EwhydQbsHg68LqzYVRluTpmW4hn
         lcSV0N7uV+jNQm0/Cbc12coiRdBCPFmmwPh9MUw7M5DX/C37GJ9bF7olW7lMtzvQ7MqD
         4DnOx8YLETBZePvU2bW7nAHhb6VeAuQz7Som64e2OWsA/heLTuuxzjH0l3PweWblnAUo
         1u4mts1yPfrl9NdEsx6qEa5iohK0qPO3/9k+s0VtMNXX0lhHer5/LtJwmJcs1OtBhyly
         lCta6YwqJnjE/LxvVBHppNI3SnOAQhi5EyKs0SyY7tQPnKFhC+pXb5/YsGwzmEjDrcmM
         qc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Czz2YJ7892NSsTQIUl/eIZo5zHlJk+9baf2OTNB6U0=;
        b=b0Pok5UOzEgexLvA4hgeqciLsThJdzFRY5QSt7X96sLCZZdmBsxyVloxHwLMrMlQjv
         wHe4MeXyLCy1cZ7vnvR80GDeP1IotO2COHDzYdwe+FDpI9euGXG8V8RuQLNhD5u07wpc
         BpM27hWSMvN1RP7LXnpUEKmasW6uYNikSm4vaAssV5RFWwYeCwrufcoWiGyEFb8UYfAJ
         qfhDzoZ1z5HOGOCM9JRl6I5bhSJ6nfS9kUjmPCeZphpQWI2HaLXMNTK9QjpQ25dpUrvX
         gynuPV+Wn8VKG+VuylQq8BZYphA/wfLVcACJzBgT+f0kBaJ90sL3zm7d2t5R553FdkZ5
         TOmQ==
X-Gm-Message-State: APjAAAX9uwsY4s2aVxpSnKn8vOO2LVwVoXESDxc9OrLNK4WVFlLXlZ0k
        08HIZWvyYniumae4ikQcgAwN8vYKQm5plvvuUpxVfQ==
X-Google-Smtp-Source: APXvYqwD2/luGyw6rZrr4tRLwqYRE9SKSMYafHefhObPoppO7e8fH0bBzADF2n3XhHPwe3aohkyZGQ4yMO925zAA7W0=
X-Received: by 2002:a02:1384:: with SMTP id 126mr29101248jaz.72.1559834310297;
 Thu, 06 Jun 2019 08:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a4b99058a97f42e@google.com> <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org> <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
 <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com> <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com>
In-Reply-To: <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 17:18:19 +0200
Message-ID: <CACT4Y+aZNxZyhJEjZjxYqh34BKz+VnfZPpZO9rDn0B_9Z_gZcw@mail.gmail.com>
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
        yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 6, 2019 at 4:54 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.06.2019 17:40, Dmitry Vyukov wrote:
> > On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 06.06.2019 16:13, J. Bruce Fields wrote:
> >>> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
> >>>> This may be connected with that shrinker unregistering is forgotten on error path.
> >>>
> >>> I was wondering about that too.  Seems like it would be hard to hit
> >>> reproduceably though: one of the later allocations would have to fail,
> >>> then later you'd have to create another namespace and this time have a
> >>> later module's init fail.
> >>
> >> Yes, it's had to bump into this in real life.
> >>
> >> AFAIU, syzbot triggers such the problem by using fault-injections
> >> on allocation places should_failslab()->should_fail(). It's possible
> >> to configure a specific slab, so the allocations will fail with
> >> requested probability.
> >
> > No fault injection was involved in triggering of this bug.
> > Fault injection is clearly visible in console log as "INJECTING
> > FAILURE at this stack track" splats and also for bugs with repros it
> > would be noted in the syzkaller repro as "fault_call": N. So somehow
> > this bug was triggered as is.
> >
> > But overall syzkaller can do better then the old probabilistic
> > injection. The probabilistic injection tend to both under-test what we
> > want to test and also crash some system services. syzkaller uses the
> > new "systematic fault injection" that allows to test specifically each
> > failure site separately in each syscall separately.
>
> Oho! Interesting.

If you are interested. You write N into /proc/thread-self/fail-nth
(say, 5) then it will cause failure of the N-th (5-th) failure site in
the next syscall in this task only. And by reading it back after the
syscall you can figure out if the failure was indeed injected or not
(or the syscall had less than 5 failure sites).
Then, for each syscall in a test (or only for one syscall of
interest), we start by writing "1" into /proc/thread-self/fail-nth; if
the failure was injected, write "2" and restart the test; if the
failure was injected, write "3" and restart the test; and so on, until
the failure wasn't injected (tested all failure sites).
This guarantees systematic testing of each error path with minimal
number of runs. This has obvious extensions to "each pair of failure
sites" (to test failures on error paths), but it's not supported atm.
