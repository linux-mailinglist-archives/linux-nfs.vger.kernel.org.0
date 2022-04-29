Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE65514071
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiD2CDR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 22:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiD2CDR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 22:03:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F4BF526
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 19:00:00 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqFtg5ThwzCsRD;
        Fri, 29 Apr 2022 09:55:23 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 09:59:58 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 09:59:57 +0800
Message-ID: <56622815-f1f4-0010-08d2-ada7a05c9bc8@huawei.com>
Date:   Fri, 29 Apr 2022 09:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] SUNRPC: Ensure timely close of disconnected AF_LOCAL
 sockets
To:     <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
References: <20220428153001.9545-1-trondmy@kernel.org>
 <20220428153001.9545-2-trondmy@kernel.org>
From:   "wanghai (M)" <wanghai38@huawei.com>
In-Reply-To: <20220428153001.9545-2-trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2022/4/28 23:30, trondmy@kernel.org 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When the rpcbind server closes the socket, we need to ensure that the
> socket is closed by the kernel as soon as feasible, so add a
> sk_state_change callback to trigger this close.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
Apply patches 1 and 2 and execute the following script, the null pointer 
reference problem will occur.

while true
do
         systemctl stop rpcbind.service
         systemctl stop rpc-statd.service
         systemctl stop nfs-server.service

         systemctl restart rpcbind.service
         systemctl restart rpc-statd.service
         systemctl restart nfs-server.service
done

[   86.376682][ T6613] BUG: kernel NULL pointer dereference, address: 
0000000000000990
[   86.379818][ T6613] #PF: supervisor write access in kernel mode
[   86.381865][ T6613] #PF: error_code(0x0002) - not-present page
[   86.383071][ T6613] PGD 0 P4D 0
[   86.383071][ T6613] Oops: 0002 [#1] PREEMPT SMP
[   86.383071][ T6613] CPU: 3 PID: 6613 Comm: gssproxy Not tainted 
5.18.0-rc4+ #15
[   86.383071][ T6613] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[   86.383071][ T6613] RIP: 0010:xs_run_error_worker+0x17/0x40
[   86.383071][ T6613] Code: d4 b6 84 e8 6f 2c 47 00 e8 c6 c9 48 00 66 
0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 41 89 f4 53 48 89 fb e8 
59 3e ae fd <f0> 4c 0f ab a3 90 09 00 00 48 8b 35 b1 22 df 01 48 8d 93 
40 0a 00
[   86.383071][ T6613] RSP: 0018:ffffc90003c33cc8 EFLAGS: 00010293
[   86.383071][ T6613] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   86.383071][ T6613] RDX: ffff88824c588040 RSI: ffffffff837cdf27 RDI: 
0000000000000000
[   86.383071][ T6613] RBP: ffffc90003c33cd8 R08: 0000000000000001 R09: 
0000000000000000
[   86.383071][ T6613] R10: 000000000000452c R11: 0000000000000001 R12: 
0000000000000007
[   86.383071][ T6613] R13: ffff8882627781d8 R14: 0000000000000001 R15: 
0000000000000000
[   86.383071][ T6613] FS:  00007f69a87abc40(0000) 
GS:ffff888437c80000(0000) knlGS:0000000000000000
[   86.383071][ T6613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.383071][ T6613] CR2: 0000000000000990 CR3: 0000000256697000 CR4: 
00000000000006e0
[   86.383071][ T6613] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   86.383071][ T6613] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   86.383071][ T6613] Call Trace:
[   86.383071][ T6613]  <TASK>
[   86.383071][ T6613]  xs_local_state_change+0x53/0x60
[   86.383071][ T6613]  unix_release_sock+0x308/0x540
[   86.383071][ T6613]  ? __sock_release+0x100/0x100
[   86.383071][ T6613]  unix_release+0x38/0x50
[   86.383071][ T6613]  __sock_release+0x50/0x100
[   86.383071][ T6613]  sock_close+0x21/0x30
[   86.383071][ T6613]  __fput+0xe1/0x390
[   86.383071][ T6613]  ? lockdep_hardirqs_on+0x84/0x110
[   86.383071][ T6613]  ____fput+0x1a/0x20
[   86.383071][ T6613]  task_work_run+0x88/0xd0
[   86.383071][ T6613]  do_exit+0x4a1/0x1170
[   86.383071][ T6613]  ? __this_cpu_preempt_check+0x1c/0x20
[   86.383071][ T6613]  do_group_exit+0x4c/0xf0
[   86.383071][ T6613]  __x64_sys_exit_group+0x21/0x30
[   86.383071][ T6613]  do_syscall_64+0x34/0x80
[   86.383071][ T6613]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   86.383071][ T6613] RIP: 0033:0x7f69a4cd4ff8
[   86.383071][ T6613] Code: Unable to access opcode bytes at RIP 
0x7f69a4cd4fce.
[   86.383071][ T6613] RSP: 002b:00007ffc9b51b518 EFLAGS: 00000246 
ORIG_RAX: 00000000000000e7
[   86.383071][ T6613] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f69a4cd4ff8
[   86.463441][ T6613] RDX: 0000000000000000 RSI: 000000000000003c RDI: 
0000000000000000
[   86.463441][ T6613] RBP: 00007f69a4fcb8a0 R08: 00000000000000e7 R09: 
fffffffffffffa68
[   86.463441][ T6613] R10: 00007f6999215dd8 R11: 0000000000000246 R12: 
00007f69a4fcb8a0
[   86.463441][ T6613] R13: 00007f69a4fd0c00 R14: 0000000000000000 R15: 
0000000000000000
[   86.463441][ T6613]  </TASK>
[   86.463441][ T6613] Modules linked in:
[   86.473274][ T6613] CR2: 0000000000000990
[   86.473274][ T6613] ---[ end trace 0000000000000000 ]---
[   86.473274][ T6613] RIP: 0010:xs_run_error_worker+0x17/0x40
[   86.473274][ T6613] Code: d4 b6 84 e8 6f 2c 47 00 e8 c6 c9 48 00 66 
0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 41 89 f4 53 48 89 fb e8 
59 3e ae fd <f0> 4c 0f ab a3 90 09 00 00 48 8b 35 b1 22 df 01 48 8d 93 
40 0a 00
[   86.473274][ T6613] RSP: 0018:ffffc90003c33cc8 EFLAGS: 00010293
[   86.473274][ T6613] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   86.473274][ T6613] RDX: ffff88824c588040 RSI: ffffffff837cdf27 RDI: 
0000000000000000
[   86.473274][ T6613] RBP: ffffc90003c33cd8 R08: 0000000000000001 R09: 
0000000000000000
[   86.473274][ T6613] R10: 000000000000452c R11: 0000000000000001 R12: 
0000000000000007
[   86.473274][ T6613] R13: ffff8882627781d8 R14: 0000000000000001 R15: 
0000000000000000
[   86.473274][ T6613] FS:  00007f69a87abc40(0000) 
GS:ffff888437c80000(0000) knlGS:0000000000000000
[   86.473274][ T6613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.473274][ T6613] CR2: 0000000000000990 CR3: 0000000256697000 CR4: 
00000000000006e0
[   86.473274][ T6613] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   86.473274][ T6613] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   86.473274][ T6613] Kernel panic - not syncing: Fatal exception
[   86.473274][ T6613] Kernel Offset: disabled
[   86.473274][ T6613] Rebooting in 86400 seconds..
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index f9849b297ea3..cf91f7c4bdf9 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1418,6 +1418,25 @@ static size_t xs_tcp_bc_maxpayload(struct rpc_xprt *xprt)
>   }
>   #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>   
> +/**
> + * xs_local_state_change - callback to handle AF_LOCAL socket state changes
> + * @sk: socket whose state has changed
> + *
> + */
> +static void xs_local_state_change(struct sock *sk)
> +{
> +	struct rpc_xprt *xprt;
> +	struct sock_xprt *transport;
> +
> +	if (!(xprt = xprt_from_sock(sk)))
> +		return;
> +	if (sk->sk_shutdown & SHUTDOWN_MASK) {
> +		clear_bit(XPRT_CONNECTED, &xprt->state);
> +		/* Trigger the socket release */
> +		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
> +	}
> +}
> +
>   /**
>    * xs_tcp_state_change - callback to handle TCP socket state changes
>    * @sk: socket whose state has changed
> @@ -1866,6 +1885,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
>   		sk->sk_user_data = xprt;
>   		sk->sk_data_ready = xs_data_ready;
>   		sk->sk_write_space = xs_udp_write_space;
> +		sk->sk_state_change = xs_local_state_change;
>   		sk->sk_error_report = xs_error_report;
>   
>   		xprt_clear_connected(xprt);

-- 
Wang Hai

