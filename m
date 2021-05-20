Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7554E38B63A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhETSlX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 14:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232681AbhETSlX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 May 2021 14:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621536001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgOCpWIR9+1trApvA3xxZfQUVOmAo0vZiUl8LgDWsaQ=;
        b=E2llSuaEtUUHrsKqi2/wL2NByWpu+x6CEmX36RcniCWL4j5gRENosbfIBNPZOspY+EyiZ3
        8hlpbMODggR0ihtcTKDrZPEwIqRFoRXTLuq/jiAG2hGAnCQ3wmvtEp6a31NTq/ZFZr4Isb
        dfewixuSKlUos36HVc9+adR1JlTI5Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-VvEO1oKtOkeepO5Ul57pJg-1; Thu, 20 May 2021 14:39:55 -0400
X-MC-Unique: VvEO1oKtOkeepO5Ul57pJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D74BF80EDA3;
        Thu, 20 May 2021 18:39:54 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-61.phx2.redhat.com [10.3.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18D2F1B480;
        Thu, 20 May 2021 18:39:54 +0000 (UTC)
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Olga Kornievskaia <aglo@umich.edu>,
        Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
Date:   Thu, 20 May 2021 14:42:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey.

On 5/19/21 3:15 PM, Olga Kornievskaia wrote:
> On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
> <mwakabayashi@vmware.com> wrote:
>>
>> Hi,
>>
>> We're seeing what looks like an NFSv4 issue.
>>
>> Mounting an NFS server that is down (ping to this NFS server's IP address does not respond) will block _all_ other NFS mount attempts even if the NFS servers are available and working properly (these subsequent mounts hang).
>>
>> If I kill the NFS mount process that's trying to mount the dead NFS server, the NFS mounts that were blocked will immediately unblock and mount successfully, which suggests the first mount command is blocking the other mount commands.
>>
>>
>> I verified this behavior using a newly built mount.nfs command from the recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cloud Image 21.04:
>> * https://sourceforge.net/projects/nfs/files/nfs-utils/2.5.3/
>> * https://cloud-images.ubuntu.com/releases/hirsute/release-20210513/ubuntu-21.04-server-cloudimg-amd64.ova
>>
>>
>> The reason this looks like it is specific to NFSv4 is from the following output showing "vers=4.2":
>>> $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
>>> [ ... cut ... ]
>>> mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=4.2,addr=<unreachable-IP-address>,clien"...^C^Z
>>
>> Also, if I try the same mount.nfs commands but specifying NFSv3, the mount to the dead NFS server hangs, but the mounts to the operational NFS servers do not block and mount successfully; this bug doesn't happen when using NFSv3.
>>
>>
>> We reported this issue under util-linux here:
>> https://github.com/karelzak/util-linux/issues/1309
>> [mounting nfs server which is down blocks all other nfs mounts on same machine #1309]
>>
>> I also found an older bug on this mailing list that had similar symptoms (but could not tell if it was the same problem or not):
>> https://patchwork.kernel.org/project/linux-nfs/patch/87vaori26c.fsf@notabene.neil.brown.name/
>> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
>>
>> Thanks, Mike
> 
> Hi Mike,
> 
> This is not a helpful reply but I was curious if I could reproduce
> your issue but was not successful. I'm able to initiate a mount to an
> unreachable-IP-address which hangs and then do another mount to an
> existing server without issues. Ubuntu 21.04 seems to be 5.11 based so
> I tried upstream 5.11 and I tried the latest upstream nfs-utils
> (instead of what my distro has which was an older version).
> 
> To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
> Or also get output from dmesg after doing “echo t >
> /proc/sysrq-trigger” to see where the mounts are hanging.
> 
It looks like Mike is correct... The first process (mount 1.1.1.1:/mnt) is
hung in trying the connection:

PID: 3394   TASK: ffff9da8c42734c0  CPU: 0   COMMAND: "mount.nfs"
 #0 [ffffb44780f638c8] __schedule at ffffffff82d7959d
 #1 [ffffb44780f63950] schedule at ffffffff82d79f2b
 #2 [ffffb44780f63968] rpc_wait_bit_killable at ffffffffc05265ce [sunrpc]
 #3 [ffffb44780f63980] __wait_on_bit at ffffffff82d7a4ba
 #4 [ffffb44780f639b8] out_of_line_wait_on_bit at ffffffff82d7a5a6
 #5 [ffffb44780f63a00] __rpc_execute at ffffffffc052fc8a [sunrpc]
 #6 [ffffb44780f63a48] rpc_execute at ffffffffc05305a2 [sunrpc]
 #7 [ffffb44780f63a68] rpc_run_task at ffffffffc05164e4 [sunrpc]
 #8 [ffffb44780f63aa8] rpc_call_sync at ffffffffc0516573 [sunrpc]
 #9 [ffffb44780f63b00] rpc_create_xprt at ffffffffc051672e [sunrpc]
#10 [ffffb44780f63b40] rpc_create at ffffffffc0516881 [sunrpc]
#11 [ffffb44780f63be8] nfs_create_rpc_client at ffffffffc0972319 [nfs]
#12 [ffffb44780f63c80] nfs4_init_client at ffffffffc0a17882 [nfsv4]
#13 [ffffb44780f63d70] nfs4_set_client at ffffffffc0a16ef8 [nfsv4]
#14 [ffffb44780f63de8] nfs4_create_server at ffffffffc0a188d8 [nfsv4]
#15 [ffffb44780f63e60] nfs4_try_get_tree at ffffffffc0a0bf69 [nfsv4]
#16 [ffffb44780f63e80] vfs_get_tree at ffffffff823b6068
#17 [ffffb44780f63ea0] path_mount at ffffffff823e3d8f
#18 [ffffb44780f63ef8] __x64_sys_mount at ffffffff823e45a3
#19 [ffffb44780f63f38] do_syscall_64 at ffffffff82d6aa50
#20 [ffffb44780f63f50] entry_SYSCALL_64_after_hwframe at ffffffff82e0007c

The second mount is hung up in nfs_match_client()/nfs_wait_client_init_complete
waiting for the first process to compile 
nfs_match_client:

       /* If a client is still initializing then we need to wait */
        if (clp->cl_cons_state > NFS_CS_READY) {
            refcount_inc(&clp->cl_count);
            spin_unlock(&nn->nfs_client_lock);
            error = nfs_wait_client_init_complete(clp);
            nfs_put_client(clp);
            spin_lock(&nn->nfs_client_lock);
            if (error < 0)
                return ERR_PTR(error);
            goto again;
        }

This code came in with commit c156618e15101 which fixed
a deadlock in nfs client initialization. 

steved.

