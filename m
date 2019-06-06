Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16436377C9
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfFFPZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 11:25:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:37420 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfFFPZ3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jun 2019 11:25:29 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hYuGS-0000sH-Cr; Thu, 06 Jun 2019 18:25:16 +0300
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     Dmitry Vyukov <dvyukov@google.com>
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
References: <0000000000005a4b99058a97f42e@google.com>
 <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org>
 <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
 <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com>
 <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com>
 <CACT4Y+aZNxZyhJEjZjxYqh34BKz+VnfZPpZO9rDn0B_9Z_gZcw@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ae7ccef7-6972-370f-e9df-951771d1e234@virtuozzo.com>
Date:   Thu, 6 Jun 2019 18:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aZNxZyhJEjZjxYqh34BKz+VnfZPpZO9rDn0B_9Z_gZcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 06.06.2019 18:18, Dmitry Vyukov wrote:
> On Thu, Jun 6, 2019 at 4:54 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 06.06.2019 17:40, Dmitry Vyukov wrote:
>>> On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> On 06.06.2019 16:13, J. Bruce Fields wrote:
>>>>> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
>>>>>> This may be connected with that shrinker unregistering is forgotten on error path.
>>>>>
>>>>> I was wondering about that too.  Seems like it would be hard to hit
>>>>> reproduceably though: one of the later allocations would have to fail,
>>>>> then later you'd have to create another namespace and this time have a
>>>>> later module's init fail.
>>>>
>>>> Yes, it's had to bump into this in real life.
>>>>
>>>> AFAIU, syzbot triggers such the problem by using fault-injections
>>>> on allocation places should_failslab()->should_fail(). It's possible
>>>> to configure a specific slab, so the allocations will fail with
>>>> requested probability.
>>>
>>> No fault injection was involved in triggering of this bug.
>>> Fault injection is clearly visible in console log as "INJECTING
>>> FAILURE at this stack track" splats and also for bugs with repros it
>>> would be noted in the syzkaller repro as "fault_call": N. So somehow
>>> this bug was triggered as is.
>>>
>>> But overall syzkaller can do better then the old probabilistic
>>> injection. The probabilistic injection tend to both under-test what we
>>> want to test and also crash some system services. syzkaller uses the
>>> new "systematic fault injection" that allows to test specifically each
>>> failure site separately in each syscall separately.
>>
>> Oho! Interesting.
> 
> If you are interested. You write N into /proc/thread-self/fail-nth
> (say, 5) then it will cause failure of the N-th (5-th) failure site in
> the next syscall in this task only. And by reading it back after the
> syscall you can figure out if the failure was indeed injected or not
> (or the syscall had less than 5 failure sites).
> Then, for each syscall in a test (or only for one syscall of
> interest), we start by writing "1" into /proc/thread-self/fail-nth; if
> the failure was injected, write "2" and restart the test; if the
> failure was injected, write "3" and restart the test; and so on, until
> the failure wasn't injected (tested all failure sites).
> This guarantees systematic testing of each error path with minimal
> number of runs. This has obvious extensions to "each pair of failure
> sites" (to test failures on error paths), but it's not supported atm.

And what you do in case of a tested syscall has pre-requisites? Say,
you test close(), which requires open() and some IO before. Are such
the dependencies statically declared in some configuration file? Or
you test any repeatable sequence of syscalls?

Kirill
