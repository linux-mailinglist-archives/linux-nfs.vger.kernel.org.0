Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF8440719
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Oct 2021 05:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJ3DiD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 23:38:03 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:45394 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJ3DiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 23:38:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04513815|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00946988-5.73216e-05-0.990473;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.LkQ9Ak8_1635564931;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LkQ9Ak8_1635564931)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sat, 30 Oct 2021 11:35:32 +0800
Date:   Sat, 30 Oct 2021 11:35:39 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: nfs dead lock on linux 5.10.76
Message-Id: <20211030113538.92AF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I noticed some nfs dead lock on linux 5.10.76


[  514.916512] sysrq: Show Blocked State
[  514.921552] task:bash            state:D stack:    0 pid: 2674 ppid:     1 flags:0x00004004
[  514.930900] Call Trace:
[  514.933645]  __schedule+0x278/0x730
[  514.937554]  ? add_timer+0x146/0x200
[  514.941604]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[  514.948326]  schedule+0x3c/0xa0
[  514.951855]  rpc_wait_bit_killable+0x1e/0x90 [sunrpc]
[  514.957511]  __wait_on_bit+0x2c/0x90
[  514.961525]  ? rpc_wake_up_task_on_wq_queue_action_locked+0x230/0x230 [sunrpc]
[  514.969608]  out_of_line_wait_on_bit+0x91/0xb0
[  514.974584]  ? var_wake_function+0x20/0x20
[  514.979182]  __rpc_execute+0x101/0x3e0 [sunrpc]
[  514.984269]  rpc_execute+0xa2/0xc0 [sunrpc]
[  514.988959]  rpc_run_task+0x153/0x170 [sunrpc]
[  514.993955]  nfs4_call_sync_custom+0xb/0x30 [nfsv4]
[  514.999410]  nfs4_do_call_sync+0x69/0x90 [nfsv4]
[  515.004583]  _nfs4_proc_readdir+0x21a/0x290 [nfsv4]
[  515.010053]  ? nfs4_do_check_delegation+0x35/0x40 [nfsv4]
[  515.016102]  nfs4_proc_readdir+0x7f/0x110 [nfsv4]
[  515.021376]  ? nfs4_proc_symlink+0x1d0/0x1d0 [nfsv4]
[  515.027483]  nfs_readdir_xdr_to_array+0x1b4/0x430 [nfs]
[  515.033868]  ? xas_store+0x56/0x610
[  515.038303]  ? __add_to_page_cache_locked+0x1d3/0x4c0
[  515.044488]  nfs_readdir_filler+0x1b/0xa0 [nfs]
[  515.050064]  do_read_cache_page+0x3e3/0x8a0
[  515.055247]  ? nfs_readdir_xdr_to_array+0x430/0x430 [nfs]
[  515.061793]  ? nfs4_do_check_delegation+0x35/0x40 [nfsv4]
[  515.068332]  ? nfs_check_cache_invalid+0x33/0x90 [nfs]
[  515.074585]  nfs_readdir+0x202/0x750 [nfs]
[  515.079679]  iterate_dir+0x15d/0x1a0
[  515.084170]  __x64_sys_getdents+0x81/0x120
[  515.089237]  ? compat_fillonedir+0x150/0x150
[  515.094500]  do_syscall_64+0x33/0x40
[  515.098979]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  515.105101] RIP: 0033:0x7f4131155425
[  515.109565] RSP: 002b:00007ffc60c1e5a0 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
[  515.118486] RAX: ffffffffffffffda RBX: 0000000000a6c4a0 RCX: 00007f4131155425
[  515.126919] RDX: 0000000000008000 RSI: 0000000000a6c4a0 RDI: 0000000000000003
[  515.135350] RBP: 0000000000a6c4a0 R08: 0000000000000000 R09: 0000000000008030
[  515.143765] R10: 0000000000000076 R11: 0000000000000246 R12: ffffffffffffff70
[  515.152172] R13: 0000000000000000 R14: 00000000004bb632 R15: 000000000000004c
[  515.160603] task:bash            state:D stack:    0 pid: 2855 ppid:     1 flags:0x00000004
[  515.170371] Call Trace:
[  515.173539]  __schedule+0x278/0x730
[  515.177870]  schedule+0x3c/0xa0
[  515.181801]  io_schedule+0x12/0x40
[  515.186030]  do_read_cache_page+0x19e/0x8a0
[  515.191141]  ? nfs_readdir_xdr_to_array+0x430/0x430 [nfs]
[  515.197600]  ? generic_file_readonly_mmap+0x70/0x70
[  515.203478]  nfs_readdir+0x202/0x750 [nfs]
[  515.208476]  iterate_dir+0x15d/0x1a0
[  515.212885]  __x64_sys_getdents+0x81/0x120
[  515.217881]  ? compat_fillonedir+0x150/0x150
[  515.223069]  do_syscall_64+0x33/0x40
[  515.227479]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  515.233537] RIP: 0033:0x7f75ad32a425
[  515.237940] RSP: 002b:00007ffed83e0600 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
[  515.246814] RAX: ffffffffffffffda RBX: 000000000199c310 RCX: 00007f75ad32a425
[  515.255205] RDX: 0000000000008000 RSI: 000000000199c310 RDI: 0000000000000003
[  515.263599] RBP: 000000000199c310 R08: 0000000000000000 R09: 0000000000008030
[  515.271991] R10: 0000000000000076 R11: 0000000000000246 R12: ffffffffffffff70
[  515.280384] R13: 0000000000000000 R14: 00000000004bb632 R15: 000000000000004c
[  515.288777] task:bash            state:D stack:    0 pid: 2992 ppid:     1 flags:0x00000004
[  515.298538] Call Trace:
[  515.301698]  __schedule+0x278/0x730
[  515.306021]  schedule+0x3c/0xa0
[  515.309952]  io_schedule+0x12/0x40
[  515.314169]  do_read_cache_page+0x19e/0x8a0
[  515.319267]  ? nfs_readdir_xdr_to_array+0x430/0x430 [nfs]
[  515.325717]  ? generic_file_readonly_mmap+0x70/0x70
[  515.331592]  nfs_readdir+0x202/0x750 [nfs]
[  515.336586]  iterate_dir+0x15d/0x1a0
[  515.340994]  __x64_sys_getdents+0x81/0x120
[  515.345973]  ? compat_fillonedir+0x150/0x150
[  515.351157]  do_syscall_64+0x33/0x40
[  515.355561]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  515.361615] RIP: 0033:0x7fe632c64425
[  515.366021] RSP: 002b:00007fff9f505d90 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
[  515.374904] RAX: ffffffffffffffda RBX: 0000000002348020 RCX: 00007fe632c64425
[  515.383308] RDX: 0000000000008000 RSI: 0000000002348020 RDI: 0000000000000003
[  515.391711] RBP: 0000000002348020 R08: 0000000000000000 R09: 0000000000008030
[  515.400112] R10: 0000000000000076 R11: 0000000000000246 R12: ffffffffffffff70
[  515.408502] R13: 0000000000000000 R14: 00000000004bb632 R15: 000000000000004c


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/30


