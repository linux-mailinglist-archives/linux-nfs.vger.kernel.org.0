Return-Path: <linux-nfs+bounces-3921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5B90B650
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918E61C21E67
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CB14F9D7;
	Mon, 17 Jun 2024 16:26:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4D14EC61
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641593; cv=none; b=sSGbZKVJLveSQWvhZCDaWWH+HaRh+nluAZHUjO68in9q6qy4duiTamgn0I0lMKLS493tIn5DYTaFEbE5BohR42fynSeTkmqndw+BUt6J2F/Pyxpne8GFNs0Ajp2clzJqLT0/M/COIXk4k/+chY5VZEdrwz4kEdRwntl2DlZMkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641593; c=relaxed/simple;
	bh=qLyEFuA14kR1AkSeqyKqPZnAuUc7zICR4J1TT5bQVpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=X3Ep4w0wLMlD2OYxgE1YwpfQoU5gY0RaEezdTZSOZscfSIHRvXPDtDLS/GoPtN+89vbO2xcvHv0oY1BKXhkpD8Y2JKIR+X3dJnG8AKnkTM9w9gDV7n1ZjypXxewltr0pE4Yf3QzKDG1EwRv13ZEJ9lbIJDolzGbayTfnpXdp8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebf00251b9so424532939f.2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 09:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641591; x=1719246391;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8Llh/+tG69M7DZzRHmCoTFxXiG1AfxNjgtwz5+HayM=;
        b=HjJPSDuAlP3km7rDCBhiC9L0wUNwv/laacVYXeP04aBgl4eFcxBfgA2A/xSpykFUSl
         HiWgHML756MtPt4uLS8HGwMgYjtj8NePakr75Ca2wiM+QBS/7V9X8Btowrb7SVc5Wu14
         Km0QsWU2Lt7y20FoKv593CKBjqYHtW7D56iFh/cv0BIi3kbAfqca7mcfJ+fjm8JqgWKA
         6hrY1CfEH9H5hc41CekUYq36Ba/MUJuDQj10L+t5ovzFBLtorvACJbqKNL72+EwJagXr
         aD+z2hD0LSv3+N8UBYR4NrKNH041COLiyIK4drsRUpyseIK3j3hDTzTF2LgUEZJAmb6x
         9F3g==
X-Forwarded-Encrypted: i=1; AJvYcCVN/UeDhDBlUdhTpaNRLJ4/7Fy+gsARuQ41ZJ85UcqtcBHB7l6xWDRb2fCyyZWw8//vN3gr79pi1VhRQu4LEV8KbxUGtAmC7uky
X-Gm-Message-State: AOJu0YzPmuqmGCA3+/O8YoOObyiU+w78a8Niycki0U7LzS47UpFJ6Jpw
	aZ9ZntA1Mes0ZG8WA2d+WO6zSkeZd5HKkKC78igpON/cPCbhNIB1nYF7jZTBuuHnpZc4v0nXu/l
	zrK4MK4oP6qE86o5khTfNEdPbz9ZE9FuFnIwQh4EsuGmj2IROwDzS+9Q=
X-Google-Smtp-Source: AGHT+IGSGFXoPYBjpHQDgGvN5h3yWz3g3pgtSmkmzIrj9a8mdcN7s3DpohRzw/3ElYVBEcDhQeMM0CF1dFJm16vVO0/SFDPelwVX
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8718:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4b96413cde5mr530754173.6.1718641590823; Mon, 17 Jun 2024
 09:26:30 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:26:30 -0700
In-Reply-To: <ZnBjsQazkJK0MyNk@lore-desk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000847d65061b186d5f@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
From: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>
To: lorenzo@kernel.org
Cc: chuck.lever@oracle.com, dai.ngo@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	lorenzo@kernel.org, neilb@suse.de, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=169fd8ee980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/1f7ce933512f/disk-cea2a265.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinux-cea2a265.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/19e24094ea37/bzImage-cea2a265.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com
>> 
>> INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
>>       Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5408 [inline]
>>  __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
>>  __schedule_loop kernel/sched/core.c:6822 [inline]
>>  schedule+0x14b/0x320 kernel/sched/core.c:6837
>>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
>>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>>  nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
>>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>>  genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
>>  netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
>>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>>  netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
>>  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg+0x223/0x270 net/socket.c:745
>>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>>  ___sys_sendmsg net/socket.c:2639 [inline]
>>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f24ed27cea9
>> RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
>> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
>> RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>> 
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git 4ddfda417a50

This crash does not have a reproducer. I cannot test it.

>
> From be9676fba16c0b8769c3b6094f35da39b1ba3953 Mon Sep 17 00:00:00 2001
> Message-ID: <be9676fba16c0b8769c3b6094f35da39b1ba3953.1718640518.git.lorenzo@kernel.org>
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, 17 Jun 2024 16:26:26 +0200
> Subject: [PATCH] NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit()
>
> Grab nfsd_mutex lock in nfsd_nl_rpc_status_get_dumpit routine and remove
> nfsd_nl_rpc_status_get_start() and nfsd_nl_rpc_status_get_done(). This
> patch fix the syzbot log reported below:
>
> INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
>       Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5408 [inline]
>  __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
>  __schedule_loop kernel/sched/core.c:6822 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6837
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x223/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f24ed27cea9
> RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>
> Fixes: 1bd773b4f0c9 ("nfsd: hold nfsd_mutex across entire netlink operation")
> Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  2 --
>  fs/nfsd/netlink.c                     |  2 --
>  fs/nfsd/netlink.h                     |  3 --
>  fs/nfsd/nfsctl.c                      | 48 ++++++---------------------
>  4 files changed, 11 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 5a98e5a06c68..c87658114852 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -132,8 +132,6 @@ operations:
>        doc: dump pending nfsd rpc
>        attribute-set: rpc-status
>        dump:
> -        pre: nfsd-nl-rpc-status-get-start
> -        post: nfsd-nl-rpc-status-get-done
>          reply:
>            attributes:
>              - xid
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 137701153c9e..ca54aa583530 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -49,9 +49,7 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
>  static const struct genl_split_ops nfsd_nl_ops[] = {
>  	{
>  		.cmd	= NFSD_CMD_RPC_STATUS_GET,
> -		.start	= nfsd_nl_rpc_status_get_start,
>  		.dumpit	= nfsd_nl_rpc_status_get_dumpit,
> -		.done	= nfsd_nl_rpc_status_get_done,
>  		.flags	= GENL_CMD_CAP_DUMP,
>  	},
>  	{
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 9459547de04e..8eb903f24c41 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -15,9 +15,6 @@
>  extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
>  extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
>  
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> -
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e5d2cc74ef77..78091a73b33b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1468,28 +1468,6 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> -/**
> - * nfsd_nl_rpc_status_get_start - Prepare rpc_status_get dumpit
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *   %0: The rpc_status_get command may proceed
> - *   %-ENODEV: There is no NFSD running in this namespace
> - */
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
> -{
> -	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
> -	int ret = -ENODEV;
> -
> -	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv)
> -		ret = 0;
> -	else
> -		mutex_unlock(&nfsd_mutex);
> -
> -	return ret;
> -}
> -
>  static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
>  					    struct netlink_callback *cb,
>  					    struct nfsd_genl_rqstp *rqstp)
> @@ -1566,8 +1544,16 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb)
>  {
> -	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
>  	int i, ret, rqstp_index = 0;
> +	struct nfsd_net *nn;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
> +	if (!nn->nfsd_serv) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  
>  	rcu_read_lock();
>  
> @@ -1644,22 +1630,10 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  	ret = skb->len;
>  out:
>  	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
> -/**
> - * nfsd_nl_rpc_status_get_done - rpc_status_get dumpit post-processing
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *   %0: Success
> - */
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> -{
> +out_unlock:
>  	mutex_unlock(&nfsd_mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.45.1
>
>

