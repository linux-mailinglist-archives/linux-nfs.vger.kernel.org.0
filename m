Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446993954E1
	for <lists+linux-nfs@lfdr.de>; Mon, 31 May 2021 06:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEaFBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 May 2021 01:01:31 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:37088 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhEaFBa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 May 2021 01:01:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.181439-0.000926598-0.817634;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.KLBorA._1622437186;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KLBorA._1622437186)
          by smtp.aliyun-inc.com(10.147.42.202);
          Mon, 31 May 2021 12:59:49 +0800
Date:   Mon, 31 May 2021 12:59:51 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: nfsd dead loop when xfstests generic/531
Message-Id: <20210531125948.2D37.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

nfsd dead loop when xfstests generic/531

linux kernel of nfs server: 5.10.41
linux kernel of nfs client: 5.10.41


nfsd dead loop when xfstests generic/531

linux kernel of nfs server: 5.10.41
linux kernel of nfs client: 5.10.41

1) nfs client: waiting at unlink () 

# pstack 2962
#0  0x00007fd6c7eec1d7 in unlink () from /lib64/libc.so.6
#1  0x0000000000400c66 in leak_tmpfile () at t_open_tmpfiles.c:143
#2  0x000000000040092d in main (argc=2, argv=<optimized out>) at t_open_tmpfiles.c:174
# pstack 2964
#0  0x00007effca5cf1d7 in unlink () from /lib64/libc.so.6
#1  0x0000000000400c66 in leak_tmpfile () at t_open_tmpfiles.c:143
#2  0x000000000040092d in main (argc=2, argv=<optimized out>) at t_open_tmpfiles.c:174

2) nfs server

# top -b
top - 12:40:07 up  1:45,  1 user,  load average: 9.09, 9.22, 8.41
Tasks: 468 total,  11 running, 457 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us, 20.3 sy,  0.0 ni, 79.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem : 193368.3 total, 189105.4 free,   1403.8 used,   2859.1 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used. 188471.0 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   5329 root      20   0       0      0      0 R 100.0   0.0  39:52.13 nfsd
   5330 root      20   0       0      0      0 R 100.0   0.0  39:58.48 nfsd
   5331 root      20   0       0      0      0 R 100.0   0.0  40:10.84 nfsd
   5332 root      20   0       0      0      0 R 100.0   0.0  40:30.13 nfsd
   5333 root      20   0       0      0      0 R 100.0   0.0  41:28.05 nfsd
   5334 root      20   0       0      0      0 R 100.0   0.0  42:50.70 nfsd
   5335 root      20   0       0      0      0 R 100.0   0.0  45:34.08 nfsd
   5336 root      20   0       0      0      0 R 100.0   0.0  50:30.75 nfsd
     15 root      20   0       0      0      0 I   6.2   0.0   0:08.95 rcu_sched
   9868 root      20   0       0      0      0 I   6.2   0.0   0:00.04 kworker/33:0-mm_percpu_wq

# echo 't' > /proc/sysrq-trigger

[ 5690.431287] task:nfsd            state:R  running task     stack:    0 pid: 5329 ppid:     2 flags:0x00004008
[ 5690.431291] Call Trace:
[ 5690.431305]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.431317]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.431333]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.431348]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.431360]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.431372]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.431410]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.431422]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.431434]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.431453]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.431463]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.431468]  ? kthread+0x116/0x130
[ 5690.431470]  ? kthread_park+0x80/0x80
[ 5690.431473]  ? ret_from_fork+0x1f/0x30
[ 5690.431477] task:nfsd            state:R  running task     stack:    0 pid: 5330 ppid:     2 flags:0x00004008
[ 5690.431481] Call Trace:
[ 5690.431484]  ? list_lru_walk_node+0x35/0xc0
[ 5690.431496]  ? nfsd_file_schedule_laundrette+0x40/0x40 [nfsd]
[ 5690.431509]  ? nfsd_file_lru_walk_list+0x164/0x190 [nfsd]
[ 5690.431522]  ? nfsd_file_acquire+0x66b/0x6e0 [nfsd]
[ 5690.431537]  ? nfs4_get_vfs_file+0x2e0/0x330 [nfsd]
[ 5690.431551]  ? find_file_locked+0x6c/0xa0 [nfsd]
[ 5690.431565]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.431578]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.431588]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.431601]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.431614]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.431625]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.431645]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.431666]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.431678]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.431688]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.431707]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.431718]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.431722]  ? kthread+0x116/0x130
[ 5690.431724]  ? kthread_park+0x80/0x80
[ 5690.431727]  ? ret_from_fork+0x1f/0x30
[ 5690.431731] task:nfsd            state:R  running task     stack:    0 pid: 5331 ppid:     2 flags:0x00004000
[ 5690.431734] Call Trace:
[ 5690.431738]  ? security_prepare_creds+0x6f/0xa0
[ 5690.431753]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.431765]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.431776]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.431789]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.431802]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.431813]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.431833]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.431854]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.431865]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.431876]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.431895]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.431906]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.431910]  ? kthread+0x116/0x130
[ 5690.431912]  ? kthread_park+0x80/0x80
[ 5690.431915]  ? ret_from_fork+0x1f/0x30
[ 5690.431919] task:nfsd            state:R  running task     stack:    0 pid: 5332 ppid:     2 flags:0x00004000
[ 5690.431922] Call Trace:
[ 5690.431925]  ? __schedule+0x29e/0x760
[ 5690.431939]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.431952]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.431965]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.431979]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.431994]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.432007]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.432028]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.432051]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.432063]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.432075]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.432095]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.432107]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.432112]  ? kthread+0x116/0x130
[ 5690.432114]  ? kthread_park+0x80/0x80
[ 5690.432117]  ? ret_from_fork+0x1f/0x30
[ 5690.432121] task:nfsd            state:R  running task     stack:    0 pid: 5333 ppid:     2 flags:0x00004000
[ 5690.432125] Call Trace:
[ 5690.432128]  ? __schedule+0x29e/0x760
[ 5690.432144]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.432158]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.432171]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.432185]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.432200]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.432213]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.432234]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.432257]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.432270]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.432281]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.432302]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.432314]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.432318]  ? kthread+0x116/0x130
[ 5690.432320]  ? kthread_park+0x80/0x80
[ 5690.432323]  ? ret_from_fork+0x1f/0x30
[ 5690.432327] task:nfsd            state:R  running task     stack:    0 pid: 5334 ppid:     2 flags:0x00004000
[ 5690.432331] Call Trace:
[ 5690.432361]  ? __btrfs_release_delayed_node+0x7a/0x340 [btrfs]
[ 5690.432375]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.432384]  ? native_queued_spin_lock_slowpath+0x185/0x1b0
[ 5690.432388]  ? _raw_spin_lock+0x1a/0x20
[ 5690.432391]  ? list_lru_add+0x60/0x140
[ 5690.432404]  ? nfsd_file_acquire+0x3e5/0x6e0 [nfsd]
[ 5690.432419]  ? nfs4_get_vfs_file+0x2e0/0x330 [nfsd]
[ 5690.432423]  ? security_prepare_creds+0x6f/0xa0
[ 5690.432439]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.432450]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.432461]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.432474]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.432488]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.432499]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.432518]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.432539]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.432551]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.432562]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.432581]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.432591]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.432596]  ? kthread+0x116/0x130
[ 5690.432598]  ? kthread_park+0x80/0x80
[ 5690.432601]  ? ret_from_fork+0x1f/0x30
[ 5690.432605] task:nfsd            state:R  running task     stack:    0 pid: 5335 ppid:     2 flags:0x00004000
[ 5690.432608] Call Trace:
[ 5690.432611]  ? list_lru_walk_node+0x35/0xc0
[ 5690.432623]  ? nfsd_file_schedule_laundrette+0x40/0x40 [nfsd]
[ 5690.432635]  ? nfsd_file_lru_walk_list+0x164/0x190 [nfsd]
[ 5690.432648]  ? nfsd_file_acquire+0x66b/0x6e0 [nfsd]
[ 5690.432663]  ? nfs4_get_vfs_file+0x2e0/0x330 [nfsd]
[ 5690.432666]  ? security_prepare_creds+0x6f/0xa0
[ 5690.432680]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.432693]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.432703]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.432716]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.432729]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.432740]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.432760]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.432781]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.432792]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.432803]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.432821]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.432832]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.432836]  ? kthread+0x116/0x130
[ 5690.432839]  ? kthread_park+0x80/0x80
[ 5690.432841]  ? ret_from_fork+0x1f/0x30
[ 5690.432845] task:nfsd            state:R  running task     stack:    0 pid: 5336 ppid:     2 flags:0x00004008
[ 5690.432848] Call Trace:
[ 5690.432852]  ? list_lru_walk_node+0x35/0xc0
[ 5690.432863]  ? nfsd_file_schedule_laundrette+0x40/0x40 [nfsd]
[ 5690.432876]  ? nfsd_file_lru_walk_list+0x164/0x190 [nfsd]
[ 5690.432889]  ? nfsd_file_acquire+0x66b/0x6e0 [nfsd]
[ 5690.432903]  ? nfs4_get_vfs_file+0x2e0/0x330 [nfsd]
[ 5690.432907]  ? security_prepare_creds+0x6f/0xa0
[ 5690.432921]  ? nfsd4_process_open2+0x5af/0x1360 [nfsd]
[ 5690.432933]  ? nfsd_permission+0x90/0xe0 [nfsd]
[ 5690.432945]  ? fh_verify+0x17a/0x6a0 [nfsd]
[ 5690.432957]  ? nfsd4_open+0x64a/0x720 [nfsd]
[ 5690.432969]  ? nfsd4_proc_compound+0x3d2/0x700 [nfsd]
[ 5690.432980]  ? nfsd_dispatch+0xd4/0x180 [nfsd]
[ 5690.433000]  ? svc_process_common+0x392/0x6c0 [sunrpc]
[ 5690.433021]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[ 5690.433032]  ? nfsd_svc+0x300/0x300 [nfsd]
[ 5690.433043]  ? nfsd_destroy+0x60/0x60 [nfsd]
[ 5690.433062]  ? svc_process+0xb7/0xf0 [sunrpc]
[ 5690.433072]  ? nfsd+0xe8/0x140 [nfsd]
[ 5690.433077]  ? kthread+0x116/0x130
[ 5690.433079]  ? kthread_park+0x80/0x80
[ 5690.433082]  ? ret_from_fork+0x1f/0x30


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/31


