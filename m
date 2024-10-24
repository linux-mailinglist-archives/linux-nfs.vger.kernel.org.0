Return-Path: <linux-nfs+bounces-7426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1389AE6E5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26F4284C10
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738D1D9A6C;
	Thu, 24 Oct 2024 13:40:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B41189914;
	Thu, 24 Oct 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777225; cv=none; b=WjRdC7fA22YyFcJul+kWedxEmUjTd6mTypjnZDze+Bn8wDZEDy400Q/pTr/3WTjLoMwbvPhn/5W+/QXosEXPOAu9vbm9BXS4ixJNfig2QFH35o7eNCAxePVseZaJ1LPDdsEXuGYXw1ch4kyke8mKLEH4hCQMgjIxixMNYeKhRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777225; c=relaxed/simple;
	bh=BbdQCkawhHZbk/gT+G69MRMXJCM5i8NOR8t4wfNt3nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TvpwHacVS5UMrqgiWwBPg47cUDLJWIUOXOcJvd8Ew7foL90grq9tYUk6kTndvaJMsYYvULP3NEG8s4cW0Y1jS12MNUqD8N8Lqzy7mZ8gmQMGYgUD66tPPxdnK7RZzdRRr6jX/7ogTClFFrTUrNYFL9F2/xNg/+uhMozxglbnS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XZ6S54vB2z10Nrl;
	Thu, 24 Oct 2024 21:38:13 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 18EAC1800DB;
	Thu, 24 Oct 2024 21:40:17 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 21:40:15 +0800
Message-ID: <abf1ac13-ee4f-4549-b313-36259cf0d411@huawei.com>
Date: Thu, 24 Oct 2024 21:40:14 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
To: Trond Myklebust <trondmy@hammerspace.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "tom@talpey.com" <tom@talpey.com>,
	"edumazet@google.com" <edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20241024015543.568476-1-liujian56@huawei.com>
 <65b652e60d8681b0898efcd6e020f69447b6e606.camel@hammerspace.com>
 <1d5a4a4f728b0cd44f006d5f5b0a90cecec1271c.camel@hammerspace.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <1d5a4a4f728b0cd44f006d5f5b0a90cecec1271c.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/10/24 20:57, Trond Myklebust 写道:
> On Thu, 2024-10-24 at 02:20 +0000, Trond Myklebust wrote:
>> On Thu, 2024-10-24 at 09:55 +0800, Liu Jian wrote:
>>> BUG: KASAN: slab-use-after-free in
>>> tcp_write_timer_handler+0x156/0x3e0
>>> Read of size 1 at addr ffff888111f322cd by task swapper/0/0
>>>
>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc4-dirty
>>> #7
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-
>>> 1
>>> Call Trace:
>>>   <IRQ>
>>>   dump_stack_lvl+0x68/0xa0
>>>   print_address_description.constprop.0+0x2c/0x3d0
>>>   print_report+0xb4/0x270
>>>   kasan_report+0xbd/0xf0
>>>   tcp_write_timer_handler+0x156/0x3e0
>>>   tcp_write_timer+0x66/0x170
>>>   call_timer_fn+0xfb/0x1d0
>>>   __run_timers+0x3f8/0x480
>>>   run_timer_softirq+0x9b/0x100
>>>   handle_softirqs+0x153/0x390
>>>   __irq_exit_rcu+0x103/0x120
>>>   irq_exit_rcu+0xe/0x20
>>>   sysvec_apic_timer_interrupt+0x76/0x90
>>>   </IRQ>
>>>   <TASK>
>>>   asm_sysvec_apic_timer_interrupt+0x1a/0x20
>>> RIP: 0010:default_idle+0xf/0x20
>>> Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90
>>> 90
>>> 90 90
>>>   90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f8 25 00 fb f4 <fa> c3
>>> cc
>>> cc cc
>>>   cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
>>> RSP: 0018:ffffffffa2007e28 EFLAGS: 00000242
>>> RAX: 00000000000f3b31 RBX: 1ffffffff4400fc7 RCX: ffffffffa09c3196
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9f00590f
>>> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102360835d
>>> R10: ffff88811b041aeb R11: 0000000000000001 R12: 0000000000000000
>>> R13: ffffffffa202d7c0 R14: 0000000000000000 R15: 00000000000147d0
>>>   default_idle_call+0x6b/0xa0
>>>   cpuidle_idle_call+0x1af/0x1f0
>>>   do_idle+0xbc/0x130
>>>   cpu_startup_entry+0x33/0x40
>>>   rest_init+0x11f/0x210
>>>   start_kernel+0x39a/0x420
>>>   x86_64_start_reservations+0x18/0x30
>>>   x86_64_start_kernel+0x97/0xa0
>>>   common_startup_64+0x13e/0x141
>>>   </TASK>
>>>
>>> Allocated by task 595:
>>>   kasan_save_stack+0x24/0x50
>>>   kasan_save_track+0x14/0x30
>>>   __kasan_slab_alloc+0x87/0x90
>>>   kmem_cache_alloc_noprof+0x12b/0x3f0
>>>   copy_net_ns+0x94/0x380
>>>   create_new_namespaces+0x24c/0x500
>>>   unshare_nsproxy_namespaces+0x75/0xf0
>>>   ksys_unshare+0x24e/0x4f0
>>>   __x64_sys_unshare+0x1f/0x30
>>>   do_syscall_64+0x70/0x180
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Freed by task 100:
>>>   kasan_save_stack+0x24/0x50
>>>   kasan_save_track+0x14/0x30
>>>   kasan_save_free_info+0x3b/0x60
>>>   __kasan_slab_free+0x54/0x70
>>>   kmem_cache_free+0x156/0x5d0
>>>   cleanup_net+0x5d3/0x670
>>>   process_one_work+0x776/0xa90
>>>   worker_thread+0x2e2/0x560
>>>   kthread+0x1a8/0x1f0
>>>   ret_from_fork+0x34/0x60
>>>   ret_from_fork_asm+0x1a/0x30
>>>
>>> Reproduction script:
>>>
>>> mkdir -p /mnt/nfsshare
>>> mkdir -p /mnt/nfs/netns_1
>>> mkfs.ext4 /dev/sdb
>>> mount /dev/sdb /mnt/nfsshare
>>> systemctl restart nfs-server
>>> chmod 777 /mnt/nfsshare
>>> exportfs -i -o rw,no_root_squash *:/mnt/nfsshare
>>>
>>> ip netns add netns_1
>>> ip link add name veth_1_peer type veth peer veth_1
>>> ifconfig veth_1_peer 11.11.0.254 up
>>> ip link set veth_1 netns netns_1
>>> ip netns exec netns_1 ifconfig veth_1 11.11.0.1
>>>
>>> ip netns exec netns_1 /root/iptables -A OUTPUT -d 11.11.0.254 -p
>>> tcp
>>> \
>>> 	--tcp-flags FIN FIN  -j DROP
>>>
>>> (note: In my environment, a DESTROY_CLIENTID operation is always
>>> sent
>>>   immediately, breaking the nfs tcp connection.)
>>> ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o
>>> proto=tcp,vers=4.1 \
>>> 	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1
>>>
>>> ip netns del netns_1
>>>
>>> The reason here is that the tcp socket in netns_1 (nfs side) has
>>> been
>>> shutdown and closed (done in xs_destroy), but the FIN message (with
>>> ack)
>>> is discarded, and the nfsd side keeps sending retransmission
>>> messages.
>>> As a result, when the tcp sock in netns_1 processes the received
>>> message,
>>> it sends the message (FIN message) in the sending queue, and the
>>> tcp
>>> timer
>>> is re-established. When the network namespace is deleted, the net
>>> structure
>>> accessed by tcp's timer handler function causes problems.
>>>
>>> The modification here aborts the TCP connection directly in
>>> xs_destroy().
>>>
>>> Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count
>>> the
>>> netns of kernel sockets.")
>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>>> ---
>>>   net/sunrpc/xprtsock.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>>> index 0e1691316f42..91ee3484155a 100644
>>> --- a/net/sunrpc/xprtsock.c
>>> +++ b/net/sunrpc/xprtsock.c
>>> @@ -1287,6 +1287,9 @@ static void xs_reset_transport(struct
>>> sock_xprt
>>> *transport)
>>>   	release_sock(sk);
>>>   	mutex_unlock(&transport->recv_mutex);
>>>   
>>> +	if (sk->sk_prot == &tcp_prot)
>>> +		tcp_abort(sk, ECONNABORTED);
>> We've already called kernel_sock_shutdown(sock, SHUT_RDWR), and we're
>> about to close the socket. Why on earth should we need a hack like
>> the
>> above in order to abort the connection at this point?
>>
>> This would appear to be a networking layer bug, and not an RPC level
>> problem.
>>
> To put this differently: if a use after free can occur in the kernel
> when the RPC layer closes a TCP socket and then exits the network
> namespace, then can't that occur when a userland application does the
> same?
>
> If not, then what prevents it from happening?
The socket created by the userspace program obtains the reference 
counting of the namespace, but the kernel socket does not.

There's some discussion here:
https://lore.kernel.org/all/CANn89iJE5anTbyLJ0TdGAqGsE+GichY3YzQECjNUVMz=G3bcQg@mail.gmail.com/
>>> +
>>>   	trace_rpc_socket_close(xprt, sock);
>>>   	__fput_sync(filp);
>>>   


