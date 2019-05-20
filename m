Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F30237CD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfETNM5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 09:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbfETNM5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 May 2019 09:12:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C7C53086222;
        Mon, 20 May 2019 13:12:51 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92D245DE73;
        Mon, 20 May 2019 13:12:46 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Xuewei Zhang" <xueweiz@google.com>, jlayton@kernel.org
Cc:     bfields@fieldses.org, "Grigor Avagyan" <grigora@google.com>,
        "Trevor Bourget" <bourget@google.com>,
        "Nauman Rafique" <nauman@google.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: Show pid of lockd for remote locks
Date:   Mon, 20 May 2019 09:12:45 -0400
Message-ID: <C5CB1B1E-59BD-4DB6-82D8-CE8E641CAC5A@redhat.com>
In-Reply-To: <CAPtwhKoF0XTuFa5msGB_eiiwRcJA0kK7eu6Rw6-b-5+8Qy0DDw@mail.gmail.com>
References: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
 <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
 <CAPtwhKoF0XTuFa5msGB_eiiwRcJA0kK7eu6Rw6-b-5+8Qy0DDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 20 May 2019 13:12:57 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 May 2019, at 22:15, Xuewei Zhang wrote:

> On Sat, May 18, 2019 at 5:09 AM Benjamin Coddington 
> <bcodding@redhat.com> wrote:
>>
>> On 17 May 2019, at 17:45, Xuewei Zhang wrote:
>>> Seems this patch introduced a bug in how lock protocol handles
>>> GRANTED_MSG in nfs.
>>
>> Yes, you're right: it's broken, and broken badly because we find 
>> conflicting
>> locks based on lockd's fl_pid and lockd's fl_owner, which is 
>> current->files.
>> That means that clients are not differentiated, and that means that 
>> v3 locks
>> are broken.
>
> Thanks a lot for the quick response and confirming the problem!
>
>>
>> I'd really like to see the fl_pid value make sense on the server when 
>> we
>> show it to userspace, so I think that we should stuff the svid in 
>> fl_owner.
>>
>> Clearly I need to be more careful making changes here, so I am going 
>> to take
>> my time fixing this, and I won't get to it until Monday. A revert 
>> would get
>> us back to safe behavior.
>
> From my limited understanding, b8eee0e90f97 ("lockd: Show pid of lockd
> for remote locks")
> exists only for fixing lockd in 9d5b86ac13c5 ("fs/locks: Remove
> fl_nspid and use fs-specific...").
>
> But I don't see anything wrong in 9d5b86ac13c5 ("fs/locks: Remove
> fl_nspid and use fs-specific..."). Could you let me know what's the
> problem? Thanks a lot!
>
> If 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific...")
> is correct, we
> probably don't need to add another fixing patch. Perhaps reverting 
> b8eee0e90f97
> ("lockd: Show pid of lockd for remote locks") would be the best way 
> then.

I think we have an existing problem:  the NLM server is setting fl_owner 
to
current->files and (before the bad patch) fl_pid to svid.

That means that we can't tell the difference between locks from 
different
clients that may have the same svid.  The bad patch just made the 
problem
far more likely to occur, that's what you're now noticing.

What needs to happen is that we generate our own fl_owner_t based on the
nlm_host and svid, so that we end up with unique fl_owner for each
client/svid pair, the same way that nlmclnt does.  That way the nlm 
server
can let the kernel do the lock matching based on unique fl_owner for 
each
client/svid.

The mech in clntproc.c for all this can probably be shared, so I'll try 
to
make that common code.

Jeff, any words of wisdom?

Ben
