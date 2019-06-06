Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5EF637733
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfFFOym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jun 2019 10:54:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:36108 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfFFOym (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jun 2019 10:54:42 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hYtmX-0000ch-5P; Thu, 06 Jun 2019 17:54:21 +0300
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, bfields@redhat.com,
        chris@chrisdown.name, Daniel Jordan <daniel.m.jordan@oracle.com>,
        guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
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
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com>
Date:   Thu, 6 Jun 2019 17:54:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 06.06.2019 17:40, Dmitry Vyukov wrote:
> On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 06.06.2019 16:13, J. Bruce Fields wrote:
>>> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
>>>> This may be connected with that shrinker unregistering is forgotten on error path.
>>>
>>> I was wondering about that too.  Seems like it would be hard to hit
>>> reproduceably though: one of the later allocations would have to fail,
>>> then later you'd have to create another namespace and this time have a
>>> later module's init fail.
>>
>> Yes, it's had to bump into this in real life.
>>
>> AFAIU, syzbot triggers such the problem by using fault-injections
>> on allocation places should_failslab()->should_fail(). It's possible
>> to configure a specific slab, so the allocations will fail with
>> requested probability.
> 
> No fault injection was involved in triggering of this bug.
> Fault injection is clearly visible in console log as "INJECTING
> FAILURE at this stack track" splats and also for bugs with repros it
> would be noted in the syzkaller repro as "fault_call": N. So somehow
> this bug was triggered as is.
> 
> But overall syzkaller can do better then the old probabilistic
> injection. The probabilistic injection tend to both under-test what we
> want to test and also crash some system services. syzkaller uses the
> new "systematic fault injection" that allows to test specifically each
> failure site separately in each syscall separately.

Oho! Interesting.

> All kernel testing systems should use it. Also in couple with KASAN,
> KMEMLEAK, LOCKDEP. It's indispensable in finding kernel bugs.
