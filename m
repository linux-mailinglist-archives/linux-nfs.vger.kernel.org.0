Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F231D1A9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBPUio (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 15:38:44 -0500
Received: from btbn.de ([5.9.118.179]:40822 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhBPUin (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Feb 2021 15:38:43 -0500
Received: from [IPv6:2001:16b8:6438:e900:a961:1270:f348:83d1] (200116b86438e900a9611270f34883d1.dip.versatel-1u1.de [IPv6:2001:16b8:6438:e900:a961:1270:f348:83d1])
        by btbn.de (Postfix) with ESMTPSA id 2836211A802;
        Tue, 16 Feb 2021 21:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613507876;
        bh=R3ZnxGd/+qQlCoQYG5NQzZqsTod/ZGq6ypActaZMsQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UKOCFJ3FtUEhVC4Nop0MFxqn0R+9KMiFLdo7W0KPI0P7MrHyeUEA2VgxqrL7z9OEu
         95yMLI6H2TAROMK0yOFX15Be5cPgycg6KrUCtteyBED3nK+wKhoInxyCclRkLrVXoO
         54TAy9rY+9cWqwUYFUyBB2w27zACMu26eqGsVxOat7Pt6aj4nLb5JFjfq5kU4cib+v
         KtL0qrop4n2Bh8+1DAbOPtxCtnH7RuHC/HrH8fkgliTvNAiFe3y42zTsv1s00A5w5I
         uQg7H4sPjBK8l3y3QvDFP5Jqz2N87usOAfuwbCQbxS/Fw0ebm9W36TPQH9ZLOHwccP
         7tTGw0Epbzrig==
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org>
Date:   Tue, 16 Feb 2021 21:37:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I can't get a network (I assume just TCP/20049 is fine, and not also 
some RDMA trace?) right now, but I will once a user has finished their 
work on the machine.

The stack of the stuck process looks as follows:

> task:xfs_io          state:S stack:    0 pid:841684 ppid:841677 flags:0x00004001
> Call Trace:
>  __schedule+0x3e9/0x660
>  ? rpc_task_release_transport+0x42/0x60
>  schedule+0x46/0xb0
>  schedule_timeout+0x20e/0x2a0
>  ? nfs4_call_sync_custom+0x23/0x30
>  wait_for_completion_interruptible+0x80/0x120
>  nfs42_proc_copy+0x505/0xb00
>  ? find_get_pages_range_tag+0x211/0x270
>  ? enqueue_task_fair+0xb5/0x500
>  ? __filemap_fdatawait_range+0x66/0xf0
>  nfs4_copy_file_range+0x198/0x240
>  vfs_copy_file_range+0x39a/0x470
>  ? ptrace_do_notify+0x82/0xb0
>  __x64_sys_copy_file_range+0xd6/0x210
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f8eead1e259
> RSP: 002b:00007ffcb1bb5778 EFLAGS: 00000206 ORIG_RAX: 0000000000000146
> RAX: ffffffffffffffda RBX: 00007ffcb1bb5790 RCX: 00007f8eead1e259
> RDX: 0000000000000003 RSI: 00007ffcb1bb5790 RDI: 0000000000000004
> RBP: 0000000020000000 R08: 0000000020000000 R09: 0000000000000000
> R10: 00007ffcb1bb5798 R11: 0000000000000206 R12: 00007ffcb1bb5798
> R13: 0000000000000004 R14: 0000000000000001 R15: 0000000000000000






On 16.02.2021 21:12, Olga Kornievskaia wrote:
> Hi Timo,
> 
> Can you get a network trace? Also, you say that the copy_file_range()
> (after what looks like a successful copy) never returns (and
> application hangs), can you get a sysrq output of what the process's
> stack (echo t > /proc/sysrq-trigger  and see what gets dumped into the
> var log messages and locate your application and report what the stack
> says)?
> 
> On Sat, Feb 13, 2021 at 10:41 PM Timo Rothenpieler
> <timo@rothenpieler.org> wrote:
>>
>> On our Fileserver, running a few weeks old 5.10, we are running into a
>> weird issue with NFS 4.2 Server-Side Copy and RDMA (and ZFS, though I'm
>> not sure how relevant that is to the issue).
>> The servers are connected via InfiniBand, on a Mellanox ConnectX-4 card,
>> using the mlx5 driver.
>>
>> Anything using the copy_file_range() syscall to copy stuff just hangs.
>> In strace, the syscall never returns.
>>
>> Simple way to reproduce on the client:
>>   > xfs_io -fc "pwrite 0 1M" testfile
>>   > xfs_io -fc "copy_range testfile" testfile.copy
>>
>> The second call just never exits. It sits in S+ state, with no CPU
>> usage, and can easily be killed via Ctrl+C.
>> I let it sit for a couple hours as well, it does not seem to ever complete.
>>
>> Some more observations about it:
>>
>> If I do a fresh reboot of the client, the operation works fine for a
>> short while (like, 10~15 minutes). No load is on the system during that
>> time, it's effectively idle.
>>
>> The operation actually does successfully copy all data. The size and
>> checksum of the target file is as expected. It just never returns.
>>
>> This only happens when mounting via RDMA. Mounting the same NFS share
>> via plain TCP has the operation work reliably.
>>
>> Had this issue with Kernel 5.4 already, and had hoped that 5.10 might
>> have fixed it, but unfortunately it didn't.
>>
>> I tried two server and 30 different client machines, they all exhibit
>> the exact same behaviour. So I'd carefully rule out a hardware issue.
>>
>>
>> Any pointers on how to debug or maybe even fix this?
>>
>>
>>
>> Thanks,
>> Timo
