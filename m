Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70A55B36E
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jun 2022 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiFZSPg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jun 2022 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiFZSPg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jun 2022 14:15:36 -0400
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Jun 2022 11:15:34 PDT
Received: from chicago.messinet.com (chicago.messinet.com [IPv6:2603:300a:134:5000::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F7A449;
        Sun, 26 Jun 2022 11:15:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id 4E167D2595;
        Sun, 26 Jun 2022 13:05:47 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id nC7nt1ivNx2G; Sun, 26 Jun 2022 13:05:43 -0500 (CDT)
Received: from linux-ws1.messinet.com (linux-ws1.messinet.com [IPv6:fd00:a::b77f:7627:2cd7:8886])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id 23725D2575;
        Sun, 26 Jun 2022 13:05:43 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com 23725D2575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1656266743;
        bh=z+cMCyy66Fxc4jfGReBh9VvTdWhAqkGc6T/Pcw3ki2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XiarEllA8NbJcSvCICw4kBLaijCfmbiOEd5hd1I4U8IVBzuF2ideARV2OcWbHeTN
         TQMYAPlYuE29LuUF7aHDgg2TwyGyJ/JmhjNKe/zmiF8ismUDSX284l6KS5vdh68/yH
         XPekPCXkPzBTnSNyWmcF08hdfPRkJHgvWlgP+FaBw4Yvip7bPgW4lpZBuV1gsl6lZp
         vr9b/Xm6PXyKHXlZvOGkH2Kqyhm/Z2aLJG/esMvMjICJSe+z8v9BtJwu/6BEiFLykO
         DryDFYLrlT+VZ8vqL4YE3UsvAlhESx1JuJiFIdoCdq244xfKIyKuozj8M23UipQQnd
         7x3mmuzJ6ogig==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     linux-nfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Bug report] fstests g/465 panic on NFS over XFS (linux v5.19-rc2+)
Date:   Sun, 26 Jun 2022 13:05:42 -0500
Message-ID: <12005337.O9o76ZdvQC@linux-ws1.messinet.com>
In-Reply-To: <20220626111539.svanuahguaeqsvve@zlang-mailbox>
References: <20220620062114.ixfkp7sr6rjd4ush@zlang-mailbox> <20220626111539.svanuahguaeqsvve@zlang-mailbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sunday, June 26, 2022 6:15:39 AM CDT Zorro Lang wrote:
> On Mon, Jun 20, 2022 at 02:21:14PM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > I hit kernel panic and KASAN BUG [1] on NFS over XFS, I've left more
> > details in bugzilla, refer to:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216151
> > 
> > The kernel commit HEAD is 05c6ca8512f2722f57743d653bb68cf2a273a55a, which
> > contains xfs-5.19-fixes-1.
> > 
> > Not sure if it's NFS or XFS issue, so cc both mail list.
> 
> It's still reproducible on my regression test of this week, on linux
> 5.19.0-rc3+ (HEAD=92f20ff72066d8d7e2ffb655c2236259ac9d1c5d).
> 
> And the feedback from Dave (XFS side) said it doesn't like a XFS issue:
>   https://bugzilla.kernel.org/show_bug.cgi?id=216151#c3
> 
> Can NFS devel help to take a look?
> 
> Thanks,
> Zorro

Not being a developer, I can't be sure it's directly related, but in the 
5.18.x series (Fedora 36) kernels, I experience NFSD/XFS failures (with 
associated data loss) reported here:

https://bugzilla.redhat.com/show_bug.cgi?id=2100859


> > [1]
> > [26844.323108] run fstests generic/465 at 2022-06-20 00:24:32
> > [26847.872804]
> > ==================================================================
> > [26847.872854] BUG: KASAN: use-after-free in _copy_to_iter+0x694/0xd0c
> > [26847.872992] Write of size 16 at addr ffff2fb1d4013000 by task
> > nfsd/45920 [26847.872999]
> > [26847.873083] CPU: 0 PID: 45920 Comm: nfsd Kdump: loaded Not tainted
> > 5.19.0-rc2+ #1 [26847.873090] Hardware name: QEMU KVM Virtual Machine,
> > BIOS 0.0.0 02/06/2015 [26847.873094] Call trace:
> > [26847.873174]  dump_backtrace+0x1e0/0x26c
> > [26847.873198]  show_stack+0x1c/0x70
> > [26847.873203]  dump_stack_lvl+0x98/0xd0
> > [26847.873262]  print_address_description.constprop.0+0x74/0x420
> > [26847.873285]  print_report+0xc8/0x234
> > [26847.873290]  kasan_report+0xb0/0xf0
> > [26847.873294]  kasan_check_range+0xf4/0x1a0
> > [26847.873298]  memcpy+0xdc/0x100
> > [26847.873303]  _copy_to_iter+0x694/0xd0c
> > [26847.873307]  copy_page_to_iter+0x3f0/0xb30
> > [26847.873311]  filemap_read+0x3e8/0x7e0
> > [26847.873319]  generic_file_read_iter+0x2b0/0x404
> > [26847.873324]  xfs_file_buffered_read+0x18c/0x4e0 [xfs]
> > [26847.873854]  xfs_file_read_iter+0x260/0x514 [xfs]
> > [26847.874168]  do_iter_readv_writev+0x338/0x4b0
> > [26847.874176]  do_iter_read+0x120/0x374
> > [26847.874180]  vfs_iter_read+0x5c/0xa0
> > [26847.874185]  nfsd_readv+0x1a0/0x9ac [nfsd]
> > [26847.874308]  nfsd4_encode_read_plus_data+0x2f0/0x690 [nfsd]
> > [26847.874387]  nfsd4_encode_read_plus+0x344/0x924 [nfsd]
> > [26847.874468]  nfsd4_encode_operation+0x1fc/0x800 [nfsd]
> > [26847.874544]  nfsd4_proc_compound+0x9c4/0x2364 [nfsd]
> > [26847.874620]  nfsd_dispatch+0x3a4/0x67c [nfsd]
> > [26847.874697]  svc_process_common+0xd54/0x1be0 [sunrpc]
> > [26847.874921]  svc_process+0x298/0x484 [sunrpc]
> > [26847.875063]  nfsd+0x2b0/0x580 [nfsd]
> > [26847.875143]  kthread+0x230/0x294
> > [26847.875170]  ret_from_fork+0x10/0x20
> > [26847.875178]
> > [26847.875180] Allocated by task 602477:
> > [26847.875185]  kasan_save_stack+0x28/0x50
> > [26847.875191]  __kasan_slab_alloc+0x68/0x90
> > [26847.875195]  kmem_cache_alloc+0x180/0x394
> > [26847.875199]  security_inode_alloc+0x30/0x120
> > [26847.875221]  inode_init_always+0x49c/0xb1c
> > [26847.875228]  alloc_inode+0x70/0x1c0
> > [26847.875232]  new_inode+0x20/0x230
> > [26847.875236]  debugfs_create_dir+0x74/0x48c
> > [26847.875243]  rpc_clnt_debugfs_register+0xd0/0x174 [sunrpc]
> > [26847.875384]  rpc_client_register+0x90/0x4c4 [sunrpc]
> > [26847.875526]  rpc_new_client+0x6e0/0x1260 [sunrpc]
> > [26847.875666]  __rpc_clone_client+0x158/0x7d4 [sunrpc]
> > [26847.875831]  rpc_clone_client+0x168/0x1dc [sunrpc]
> > [26847.875972]  nfs4_proc_lookup_mountpoint+0x180/0x1f0 [nfsv4]
> > [26847.876149]  nfs4_submount+0xcc/0x6cc [nfsv4]
> > [26847.876251]  nfs_d_automount+0x4b4/0x7bc [nfs]
> > [26847.876389]  __traverse_mounts+0x180/0x4a0
> > [26847.876396]  step_into+0x510/0x940
> > [26847.876400]  walk_component+0xf0/0x510
> > [26847.876405]  link_path_walk.part.0.constprop.0+0x4c0/0xa3c
> > [26847.876410]  path_lookupat+0x6c/0x57c
> > [26847.876436]  filename_lookup+0x13c/0x400
> > [26847.876440]  vfs_path_lookup+0xa0/0xec
> > [26847.876445]  mount_subtree+0x1c4/0x380
> > [26847.876451]  do_nfs4_mount+0x3c0/0x770 [nfsv4]
> > [26847.876554]  nfs4_try_get_tree+0xc0/0x24c [nfsv4]
> > [26847.876653]  nfs_get_tree+0xc0/0x110 [nfs]
> > [26847.876742]  vfs_get_tree+0x78/0x2a0
> > [26847.876748]  do_new_mount+0x228/0x4fc
> > [26847.876753]  path_mount+0x268/0x16d4
> > [26847.876757]  __arm64_sys_mount+0x1dc/0x240
> > [26847.876762]  invoke_syscall.constprop.0+0xd8/0x1d0
> > [26847.876769]  el0_svc_common.constprop.0+0x224/0x2bc
> > [26847.876774]  do_el0_svc+0x4c/0x90
> > [26847.876778]  el0_svc+0x5c/0x140
> > [26847.876785]  el0t_64_sync_handler+0xb4/0x130
> > [26847.876789]  el0t_64_sync+0x174/0x178
> > [26847.876793]
> > [26847.876794] Last potentially related work creation:
> > [26847.876797]  kasan_save_stack+0x28/0x50
> > [26847.876802]  __kasan_record_aux_stack+0x9c/0xc0
> > [26847.876806]  kasan_record_aux_stack_noalloc+0x10/0x20
> > [26847.876811]  call_rcu+0xf8/0x6c0
> > [26847.876818]  security_inode_free+0x94/0xc0
> > [26847.876823]  __destroy_inode+0xb0/0x420
> > [26847.876828]  destroy_inode+0x80/0x170
> > [26847.876832]  evict+0x334/0x4c0
> > [26847.876836]  iput_final+0x138/0x364
> > [26847.876841]  iput.part.0+0x330/0x47c
> > [26847.876845]  iput+0x44/0x60
> > [26847.876849]  dentry_unlink_inode+0x200/0x43c
> > [26847.876853]  __dentry_kill+0x29c/0x56c
> > [26847.876857]  dput+0x41c/0x870
> > [26847.876860]  simple_recursive_removal+0x4ac/0x630
> > [26847.876865]  debugfs_remove+0x5c/0x80
> > [26847.876870]  rpc_clnt_debugfs_unregister+0x3c/0x7c [sunrpc]
> > [26847.877011]  rpc_free_client_work+0xdc/0x480 [sunrpc]
> > [26847.877154]  process_one_work+0x794/0x184c
> > [26847.877161]  worker_thread+0x3d4/0xc40
> > [26847.877165]  kthread+0x230/0x294
> > [26847.877168]  ret_from_fork+0x10/0x20
> > [26847.877172]
> > [26847.877174] Second to last potentially related work creation:
> > [26847.877177]  kasan_save_stack+0x28/0x50
> > [26847.877181]  __kasan_record_aux_stack+0x9c/0xc0
> > [26847.877185]  kasan_record_aux_stack_noalloc+0x10/0x20
> > [26847.877190]  call_rcu+0xf8/0x6c0
> > [26847.877195]  security_inode_free+0x94/0xc0
> > [26847.877200]  __destroy_inode+0xb0/0x420
> > [26847.877205]  destroy_inode+0x80/0x170
> > [26847.877209]  evict+0x334/0x4c0
> > [26847.877213]  iput_final+0x138/0x364
> > [26847.877217]  iput.part.0+0x330/0x47c
> > [26847.877221]  iput+0x44/0x60
> > [26847.877226]  dentry_unlink_inode+0x200/0x43c
> > [26847.877229]  __dentry_kill+0x29c/0x56c
> > [26847.877233]  dput+0x44c/0x870
> > [26847.877237]  __fput+0x244/0x730
> > [26847.877241]  ____fput+0x14/0x20
> > [26847.877245]  task_work_run+0xd0/0x240
> > [26847.877250]  do_exit+0x3a0/0xaac
> > [26847.877256]  do_group_exit+0xac/0x244
> > [26847.877260]  __arm64_sys_exit_group+0x40/0x4c
> > [26847.877264]  invoke_syscall.constprop.0+0xd8/0x1d0
> > [26847.877270]  el0_svc_common.constprop.0+0x224/0x2bc
> > [26847.877275]  do_el0_svc+0x4c/0x90
> > [26847.877280]  el0_svc+0x5c/0x140
> > [26847.877284]  el0t_64_sync_handler+0xb4/0x130
> > [26847.877288]  el0t_64_sync+0x174/0x178
> > [26847.877292]
> > [26847.877293] The buggy address belongs to the object at ffff2fb1d4013000
> > [26847.877293]  which belongs to the cache lsm_inode_cache of size 128
> > [26847.877298] The buggy address is located 0 bytes inside of
> > [26847.877298]  128-byte region [ffff2fb1d4013000, ffff2fb1d4013080)
> > [26847.877302]
> > [26847.877304] The buggy address belongs to the physical page:
> > [26847.877308] page:000000007bc4a504 refcount:1 mapcount:0
> > mapping:0000000000000000 index:0xffff2fb1d4013000 pfn:0x154013
> > [26847.877363] flags:
> > 0x17ffff800000200(slab|node=0|zone=2|lastcpupid=0xfffff) [26847.877375]
> > raw: 017ffff800000200 fffffcbec6646688 fffffcbec750d708 ffff2fb1808dfe00
> > [26847.877379] raw: ffff2fb1d4013000 0000000000150010 00000001ffffffff
> > 0000000000000000 [26847.877382] page dumped because: kasan: bad access
> > detected
> > [26847.877384]
> > [26847.877385] Memory state around the buggy address:
> > [26847.877389]  ffff2fb1d4012f00: 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 [26847.877392]  ffff2fb1d4012f80: 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 [26847.877395] >ffff2fb1d4013000: fb fb fb fb fb fb fb
> > fb fb fb fb fb fb fb fb fb [26847.877397]                    ^
> > [26847.877400]  ffff2fb1d4013080: fc fc fc fc fc fc fc fc fa fb fb fb fb
> > fb fb fb [26847.877402]  ffff2fb1d4013100: fb fb fb fb fb fb fb fb fc fc
> > fc fc fc fc fc fc [26847.877405]
> > ==================================================================
> > [26847.877570] Disabling lock debugging due to kernel taint
> > [26848.391268] Unable to handle kernel write to read-only memory at
> > virtual address ffff2fb197f76000 [26848.393628] KASAN: maybe
> > wild-memory-access in range [0xfffd7d8cbfbb0000-0xfffd7d8cbfbb0007]
> > [26848.395572] Mem abort info:
> > [26848.396408]   ESR = 0x000000009600004f
> > [26848.397314]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [26848.398520]   SET = 0, FnV = 0
> > [26848.506889]   EA = 0, S1PTW = 0
> > [26848.507633]   FSC = 0x0f: level 3 permission fault
> > [26848.508802] Data abort info:
> > [26848.509480]   ISV = 0, ISS = 0x0000004f
> > [26848.510347]   CM = 0, WnR = 1
> > [26848.511032] swapper pgtable: 4k pages, 48-bit VAs,
> > pgdp=00000000b22dd000
> > [26848.512543] [ffff2fb197f76000] pgd=18000001bfff8003,
> > p4d=18000001bfff8003, pud=18000001bfa08003, pmd=18000001bf948003,
> > pte=0060000117f76f87 [26848.515600] Internal error: Oops: 9600004f [#1]
> > SMP
> > [26848.516870] Modules linked in: loop dm_mod tls rpcsec_gss_krb5 nfsv4
> > dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd
> > auth_rpcgss nfs_acl lockd grace rfkill sunrpc vfat fat drm fuse xfs
> > libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_blk
> > virtio_net virtio_console net_failover failover virtio_mmio ipmi_devintf
> > ipmi_msghandler [26848.525472] CPU: 1 PID: 45919 Comm: nfsd Kdump: loaded
> > Tainted: G    B             5.19.0-rc2+ #1 [26848.527934] Hardware name:
> > QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015 [26848.529819] pstate:
> > 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--) [26848.531625] pc
> > : __memcpy+0x2c/0x230
> > [26848.532583] lr : memcpy+0xa8/0x100
> > [26848.533497] sp : ffff80000bbb6f00
> > [26848.534444] x29: ffff80000bbb6f00 x28: 0000000000000000 x27:
> > ffff2fb18a4bd5b8 [26848.536435] x26: 0000000000000000 x25:
> > ffff80000bbb7740 x24: ffff2fb18a4bd5b0 [26848.538283] x23:
> > ffff2fb1ee80bff0 x22: ffffa83e4692e000 x21: ffffa83e434ae3e8
> > [26848.540181] x20: ffff2fb197f76000 x19: 0000000000000010 x18:
> > ffff2fb1d3c34530 [26848.542071] x17: 0000000000000000 x16:
> > ffffa83e42d01a30 x15: 6161616161616161 [26848.543840] x14:
> > 6161616161616161 x13: 6161616161616161 x12: 6161616161616161
> > [26848.545614] x11: 1fffe5f632feec01 x10: ffff65f632feec01 x9 :
> > dfff800000000000 [26848.547387] x8 : ffff2fb197f7600f x7 :
> > 6161616161616161 x6 : 6161616161616161 [26848.549156] x5 :
> > ffff2fb197f76010 x4 : ffff2fb1ee80c000 x3 : ffffa83e434ae3e8
> > [26848.550924] x2 : 0000000000000010 x1 : ffff2fb1ee80bff0 x0 :
> > ffff2fb197f76000 [26848.552694] Call trace:
> > [26848.553314]  __memcpy+0x2c/0x230
> > [26848.554123]  _copy_to_iter+0x694/0xd0c
> > [26848.555084]  copy_page_to_iter+0x3f0/0xb30
> > [26848.556104]  filemap_read+0x3e8/0x7e0
> > [26848.557020]  generic_file_read_iter+0x2b0/0x404
> > [26848.558152]  xfs_file_buffered_read+0x18c/0x4e0 [xfs]
> > [26848.559795]  xfs_file_read_iter+0x260/0x514 [xfs]
> > [26848.561265]  do_iter_readv_writev+0x338/0x4b0
> > [26848.562346]  do_iter_read+0x120/0x374
> > [26848.563263]  vfs_iter_read+0x5c/0xa0
> > [26848.564162]  nfsd_readv+0x1a0/0x9ac [nfsd]
> > [26848.565415]  nfsd4_encode_read_plus_data+0x2f0/0x690 [nfsd]
> > [26848.566869]  nfsd4_encode_read_plus+0x344/0x924 [nfsd]
> > [26848.568231]  nfsd4_encode_operation+0x1fc/0x800 [nfsd]
> > [26848.569596]  nfsd4_proc_compound+0x9c4/0x2364 [nfsd]
> > [26848.570908]  nfsd_dispatch+0x3a4/0x67c [nfsd]
> > [26848.572067]  svc_process_common+0xd54/0x1be0 [sunrpc]
> > [26848.573508]  svc_process+0x298/0x484 [sunrpc]
> > [26848.574743]  nfsd+0x2b0/0x580 [nfsd]
> > [26848.575718]  kthread+0x230/0x294
> > [26848.576528]  ret_from_fork+0x10/0x20
> > [26848.577421] Code: f100405f 540000c3 a9401c26 a97f348c (a9001c06)
> > [26848.578934] SMP: stopping secondary CPUs
> > [26848.582664] Starting crashdump kernel...
> > [26848.583602] Bye!




