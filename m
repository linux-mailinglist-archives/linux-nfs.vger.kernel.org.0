Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA03BCB8
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbfFJTO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 15:14:29 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:40440
        "EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387674AbfFJTO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jun 2019 15:14:29 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id aPkQhMMJVj2cpaPkRhihlh; Mon, 10 Jun 2019 12:14:27 -0700
Subject: Re: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
 <9E0019E1-1C1B-465C-B2BF-76372029ABD8@talpey.com>
 <955993A4-0626-4819-BC6F-306A50E2E048@oracle.com>
 <4b05cdf7-2c2d-366f-3a29-1034bfec2941@talpey.com>
 <721DF459-ECAE-4FDD-A016-AFB193BA1C65@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b7ade4dc-272d-2814-4c86-606e56cd1f12@talpey.com>
Date:   Mon, 10 Jun 2019 15:14:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <721DF459-ECAE-4FDD-A016-AFB193BA1C65@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGHKHpve9fa4BIbdUo6/XaP7Ie6EJj38ecN4ohvU7R4R6HsaM36IVxCP7MEaXcndcMB4PP350MX+i2/IVReq5SVQ5Bim+MRy9oR7hBUk/5VDjjm7DOIz
 M2ME7sjkXEdju5kfF/FXAOrKj6fPYbIJXHxFErrUixG9fIoKJkTlEeUj1b963D8a9nPCtCHa+RiWITyhgp9HlTPRfML47Xpr2ZBUt7UKycow1W7QKswo544e
 vjJKkZaUt/pQP1UEEnqZmA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/10/2019 1:50 PM, Chuck Lever wrote:
> Hi Tom-
> 
>> On Jun 10, 2019, at 10:50 AM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/5/2019 1:25 PM, Chuck Lever wrote:
>>> Hi Tom-
>>>> On Jun 5, 2019, at 12:43 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 6/5/2019 8:15 AM, Chuck Lever wrote:
>>>>> The DRC is not working at all after an RPC/RDMA transport reconnect.
>>>>> The problem is that the new connection uses a different source port,
>>>>> which defeats DRC hash.
>>>>>
>>>>> An NFS/RDMA client's source port is meaningless for RDMA transports.
>>>>> The transport layer typically sets the source port value on the
>>>>> connection to a random ephemeral port. The server already ignores it
>>>>> for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
>>>>> client's source port on RDMA transports").
>>>>
>>>> Where does the entropy come from, then, for the server to not
>>>> match other requests from other mount points on this same client?
>>> The first ~200 bytes of each RPC Call message.
>>> [ Note that this has some fun ramifications for calls with small
>>> RPC headers that use Read chunks. ]
>>
>> Ok, good to know. I forgot that the Linux server implemented this.
>> I have some concerns abot it, honestly, and it's important to remember
>> that it's not the same on all servers. But for the problem you're
>> fixing, it's ok I guess and certainly better than today. Still, the
>> errors are goingto be completely silent, and can lead to data being
>> corrupted. Well, welcome to the world of NFSv3.
> 
> I don't see another option.
> 
> Some regard this checksum as more robust than using the client's
> IP source port. After all, the same argument can be made that
> the server cannot depend on clients to reuse their source port.
> That is simply a convention that many clients adopted before
> servers used a stronger DRC hash mechanism.
> 
> 
>>>> And since RDMA is capable of
>>>> such high IOPS, the likelihood seems rather high.
>>> Only when the server's durable storage is slow enough to cause
>>> some RPC requests to have extremely high latency.
>>> And, most clients use an atomic counter for their XIDs, so they
>>> are also likely to wrap that counter over some long-pending RPC
>>> request.
>>> The only real answer here is NFSv4 sessions.
>>>> Missing the cache
>>>> might actually be safer than hitting, in this case.
>>> Remember that _any_ retransmit on RPC/RDMA requires a fresh
>>> connection, that includes NFSv3, to reset credit accounting
>>> due to the lost half of the RPC Call/Reply pair.
>>> I can very quickly reproduce bad (non-deterministic) behavior
>>> by running a software build on an NFSv3 on RDMA mount point
>>> with disconnect injection. If the DRC issue is addressed, the
>>> software build runs to completion.
>>
>> Ok, good. But I have a better test.
>>
>> In the Connectathon suite, there's a "Special" test called "nfsidem".
>> I wrote this test in, like, 1989 so I remember it :-)
>>
>> This test performs all the non-idempotent NFv3 operations in a loop,
>> and each loop element depends on the previous one, so if there's
>> any failure, the test imemdiately bombs.
>>
>> Nobody seems to understand it, usually when it gets run people will
>> run it without injecting errors, and it "passes" so they decide
>> everything is ok.
>>
>> So my suggestion is to run your flakeway packet-drop harness while
>> running nfsidem in a huge loop (nfsidem 10000). The test is slow,
>> owing to the expensive operations it performs, so you'll need to
>> run it for a long time.
>>
>> You'll almost definitely get a failure or two, since the NFSv3
>> protocol is flawed by design. But you can compare the behaviors,
>> and even compute a likelihood. I'd love to see some actual numbers.
> 
> I configured the client to disconnect after 23711 RPCs have completed.
> (I can re-run these with more frequent disconnects if you think that
> would be useful).
> 
> Here's a run with the DRC modification:
> 
> [cel@manet ~]$ sudo mount -o vers=3,proto=rdma,sec=sys klimt.ib:/export/tmp /mnt
> [cel@manet ~]$ (cd /mnt; ~/src/cthon04/special/nfsidem 100000)
> testing 100000 idempotencies in directory "./TEST"
> [cel@manet ~]$ sudo umount /mnt
> 
> 
> Here's a run with the stock v5.1 Linux server:
> 
> [cel@manet ~]$ sudo mount -o vers=3,proto=rdma,sec=sys klimt.ib:/export/tmp /mnt
> [cel@manet ~]$ (cd /mnt; ~/src/cthon04/special/nfsidem 100000)
> testing 100000 idempotencies in directory "./TEST"
> [cel@manet ~]$
> 
> This test reported no errors in either case. We can see that the
> disconnects did trigger retransmits:
> 
> RPC statistics:
>    1888819 RPC requests sent, 1888581 RPC replies received (0 XIDs not found)
>    average backlog queue length: 119

Ok, well, that's 1.2% error rate, which IMO could be cranked up much
higher for testing purposes. I'd also be sure the server was serving
other workloads during the same time, putting at least some pressure
on the DRC. The op rate of a single nfsidem test is pretty low so I
doubt it's ever evicting anything.

Ideally, it would be best to
1) increase the error probability
2) run several concurrent nfsidem tests, on different connections
3) apply some other load to the server, e.g. several cthon basics

The idea being to actually get the needle off of zero and measure some
kind of difference. Otherwise it really isn't giving any information
apart from a slight didn't-break-it confidence. Honestly, I'm surprised
you couldn't evince a failure from stock. On paper, these results don't
actually tell us the patch is doing anything.

Tom.

> 
> ACCESS:
>          300001 ops (15%)        44 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 132	avg bytes received per op: 120
>          backlog wait: 0.591118  RTT: 0.017463   total execute time: 0.614795 (milliseconds)
> REMOVE:
>         	300000 ops (15%)        40 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 136	avg bytes received per op: 144
>          backlog wait: 0.531667  RTT: 0.018973   total execute time: 0.556927 (milliseconds)
> MKDIR:
>       	200000 ops (10%)        26 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 158      avg bytes received per op: 272
>          backlog wait: 0.518940  RTT: 0.019755   total execute time: 0.545230 (milliseconds)
> RMDIR:
> 	200000 ops (10%)        24 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 130	avg bytes received per op: 144
>          backlog wait: 0.512320  RTT: 0.018580   total execute time: 0.537095 (milliseconds)
> LOOKUP:
>         	188533 ops (9%)         21 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 136	avg bytes received per op: 174
>          backlog wait: 0.455925  RTT: 0.017721   total execute time: 0.480011 (milliseconds)
> SETATTR:
>          100000 ops (5%)         11 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 160	avg bytes received per op: 144
>          backlog wait: 0.371960  RTT: 0.019470   total execute time: 0.398330 (milliseconds)
> WRITE:
>        	100000 ops (5%)         9 retrans (0%)  0 major timeouts
>          avg bytes sent per op: 180	avg bytes received per op: 136
>          backlog wait: 0.399190  RTT: 0.022860   total execute time: 0.436610 (milliseconds)
> CREATE:
>         	100000 ops (5%)         9 retrans (0%)  0 major timeouts
>          avg bytes sent per op: 168	avg bytes received per op: 272
>          backlog wait: 0.365290  RTT: 0.019560   total execute time: 0.391140 (milliseconds)
> SYMLINK:
>       	100000 ops (5%)         18 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 188	avg bytes received per op: 272
>          backlog wait: 0.750470  RTT: 0.020150   total execute time: 0.786410 (milliseconds)
> RENAME:
>       	100000 ops (5%)         14 retrans (0%)         0 major timeouts
>          avg bytes sent per op: 180	avg bytes received per op: 260
>          backlog wait: 0.461650  RTT: 0.020710   total execute time: 0.489670 (milliseconds)
> 
> 
> --
> Chuck Lever
> 
> 
> 
> 
> 
