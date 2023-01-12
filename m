Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A6666E65
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjALJjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Jan 2023 04:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbjALJid (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Jan 2023 04:38:33 -0500
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CD59D30
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jan 2023 01:30:50 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437592|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0524779-0.00024391-0.947278;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Qqx.XdP_1673515846;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Qqx.XdP_1673515846)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 17:30:47 +0800
Date:   Thu, 12 Jan 2023 17:30:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
In-Reply-To: <20230111173534.82A7.409509F4@e16-tech.com>
References: <20230111165945.7605.409509F4@e16-tech.com> <20230111173534.82A7.409509F4@e16-tech.com>
Message-Id: <20230112173046.82E4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> Hi,
> 
> > Hi,
> > 
> > We noticed a dead lock of 'umount.nfs4 /nfs/scratch -l'
> 
> reproducer:
> 
> mount /dev/sda1 /mnt/test/
> mount /dev/sda2 /mnt/scratch/
> systemctl restart nfs-server.service
> mount.nfs4 127.0.0.1:/mnt/test/ /nfs/test/
> mount.nfs4 127.0.0.1:/mnt/scratch/ /nfs/scratch/
> systemctl stop nfs-server.service
> umount -l /nfs/scratch #OK
> umount -l /nfs/test #dead lock
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/11
> 
> > kernel: 6.1.5-rc1

This problem happen on kernel 6.2.0-rc3+(upstream) too.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/12

> > 
> > The dmesg output of 'sysrq w'
> > 
> > [13493.955032] sysrq: Show Blocked State
> > [13493.959997] task:umount.nfs4     state:D stack:0     pid:3542745 ppid:3542744 flags:0x00004000
> > [13493.969628] Call Trace:
> > [13493.973003]  <TASK>
> > [13493.976018]  __schedule+0x2cb/0x880
> > [13493.980426]  ? __bpf_trace_svc_stats_latency+0x10/0x10 [sunrpc]
> > [13493.987342]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
> > [13493.993637]  schedule+0x50/0xc0
> > [13493.997697]  rpc_wait_bit_killable+0xd/0x60 [sunrpc]
> > [13494.003671]  __wait_on_bit+0x75/0x90
> > [13494.008168]  out_of_line_wait_on_bit+0x91/0xb0
> > [13494.013547]  ? sched_core_clone_cookie+0x90/0x90
> > [13494.019101]  __rpc_execute+0x14b/0x490 [sunrpc]
> > [13494.024603]  ? kmem_cache_alloc+0x41/0x530
> > [13494.029610]  rpc_execute+0xc5/0x100 [sunrpc]
> > [13494.034835]  rpc_run_task+0x14b/0x1b0 [sunrpc]
> > [13494.040252]  rpc_call_sync+0x50/0xa0 [sunrpc]
> > [13494.045566]  nfs4_proc_destroy_session+0x80/0x100 [nfsv4]
> > [13494.051926]  nfs4_destroy_session+0x24/0x90 [nfsv4]
> > [13494.057767]  nfs41_shutdown_client+0xfd/0x120 [nfsv4]
> > [13494.063774]  nfs4_free_client+0x21/0xb0 [nfsv4]
> > [13494.069240]  nfs_free_server+0x44/0xb0 [nfs]
> > [13494.074418]  nfs_kill_super+0x2b/0x40 [nfs]
> > [13494.079490]  deactivate_locked_super+0x2c/0x70
> > [13494.084811]  cleanup_mnt+0xb8/0x140
> > [13494.089147]  task_work_run+0x6a/0xb0
> > [13494.093587]  exit_to_user_mode_prepare+0x1b9/0x1c0
> > [13494.099232]  syscall_exit_to_user_mode+0x12/0x30
> > [13494.104717]  do_syscall_64+0x67/0x80
> > [13494.109125]  ? syscall_exit_to_user_mode+0x12/0x30
> > [13494.114799]  ? do_syscall_64+0x67/0x80
> > [13494.119426]  ? do_syscall_64+0x67/0x80
> > [13494.124042]  ? do_syscall_64+0x67/0x80
> > [13494.128649]  ? exc_page_fault+0x64/0x140
> > [13494.133400]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [13494.139306] RIP: 0033:0x7fc32f839e9b
> > [13494.143726] RSP: 002b:00007ffe670f6018 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> > [13494.152183] RAX: 0000000000000000 RBX: 000055f4aad71920 RCX: 00007fc32f839e9b
> > [13494.160218] RDX: 0000000000000003 RSI: 0000000000000002 RDI: 000055f4aad72600
> > [13494.168237] RBP: 0000000000000002 R08: 0000000000000007 R09: 000055f4aad71010
> > [13494.176277] R10: 00007fc32fbc0bc0 R11: 0000000000000202 R12: 000055f4aad72600
> > [13494.184313] R13: 00007fc33025f244 R14: 000055f4aad71a30 R15: 000055f4aad71b50
> > [13494.192334]  </TASK>
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2023/01/11
> > 
> 


