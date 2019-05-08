Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0259117FF6
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfEHShP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 14:37:15 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33892 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfEHShP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 May 2019 14:37:15 -0400
Received: by mail-it1-f196.google.com with SMTP id p18so2981565itm.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2019 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DJYKZl8f/0lO8D+ZxuiCd1exEO9RdwB1l/MM5a+p7Xs=;
        b=Np/5F1yzxqfeBlCNAu4jLLW2hVepxayPzaE/q/O0Lk1aKmtA26/i7DzU4eAXxcALvu
         ZSjYjtU4Ns/8hLu6qUiq2tDXwfsNec10tIAEIl+5H7hk/bxv9cy1pRMrrd14YpAwaZzp
         ZsjgTdZBrqbJdsmRt+y5jJKJ9Mi4m07mXCBsfTr9BBDBuu7iamH4ATXy8Y1O7qteGcW5
         np0JEEwQnJ2+6loCeogNKVM05n60dUbzhlu/QR+nmvvJI59QioEegd++N8A+CeQfTIS2
         oWTDoYy3RC1QFoMwnzG5YVM2EW04K2DNsR9FvUxxfEnIalDBb+u1pjaja3/j5gba+DpF
         6dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DJYKZl8f/0lO8D+ZxuiCd1exEO9RdwB1l/MM5a+p7Xs=;
        b=TjNc3zF0x9oYCYjnlDWztLY5tcs4koMb4NkWsiV5m0uMJESRjK32d4s7jB21vjCQ6s
         yKgU19WwqRDsTkBPTdlo00+MyE5yWA0zxaonhEsIK1kxtBFnvAwFnlnQN9yUCr07v6ma
         ReAS9oo1jWn0KlsRK7JvvP58FdMb61p0ycYy/yHh3xA95YutRo89cLZUZCwrehrKjjoS
         O/oFaGPNMm+RYkic/nma4sXxZ6cP6O1Bu6iL1Jg0/c5dr1DiXJNREuPJ2BXY0aNYnkui
         OlJxLzUrMuwlUqwebL5bCptlCXXVPNv3px1yUE5QVVJjsSXmdJ5ddDHX8WbykHRY7yRG
         1MtQ==
X-Gm-Message-State: APjAAAUI2D6lgo8mghO3ZMwnH99kYWx133kL/kTpFQ3RIY8Ow5N+8n3T
        ek1lv8/VxLbls0M44ZAwL3o=
X-Google-Smtp-Source: APXvYqy54E5kWjZ5e1WbZqbdPeBOIfOAd9GAD/dJoMnRtwPCVt9GoSXJIBEpmxTljEMvfbecGb1m/w==
X-Received: by 2002:a02:234b:: with SMTP id u72mr10369004jau.4.1557340634161;
        Wed, 08 May 2019 11:37:14 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.googlemail.com with ESMTPSA id k192sm1362293ite.36.2019.05.08.11.37.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 11:37:13 -0700 (PDT)
Message-ID: <5daaa8ec5c835866313094603b71db330fa28ab2.camel@gmail.com>
Subject: Re: Anna's linux-next (pulled 5/8) seems unstable
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 08 May 2019 14:37:12 -0400
In-Reply-To: <ACF23F78-1162-420D-92F9-3856EA44A323@oracle.com>
References: <ACF23F78-1162-420D-92F9-3856EA44A323@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

What NFS version are you using for testing? And does it happen consistently on
the same xfstest?

Thanks,
Anna

On Wed, 2019-05-08 at 14:30 -0400, Chuck Lever wrote:
> Hit a few oddities, so I enabled memory debugging.
> 
> This happens over and over during xfstests:
> 
> May  8 11:19:42 manet kernel:
> =============================================================================
> May  8 11:19:42 manet kernel: BUG kmalloc-128 (Tainted: G    B            ):
> Poison overwritten
> May  8 11:19:42 manet kernel: ------------------------------------------------
> -----------------------------
> May  8 11:19:42 manet kernel: INFO: 0x000000004ca7d9fd-0x000000003fa83627.
> First byte 0x6a instead of 0x6b
> May  8 11:19:42 manet kernel: INFO: Allocated in gss_create+0x8b/0x32f
> [auth_rpcgss] age=9633 cpu=11 pid=21120
> 
> This is the first field in struct gss_auth, which is a kref object.
> 
> I also see this:
> 
> May  8 14:21:16 manet kernel: WARNING: CPU: 10 PID: 45 at
> /home/cel/src/linux/anna/mm/page_alloc.c:4584
> __alloc_pages_nodemask+0x3f/0x2c2
> May  8 14:21:16 manet kernel: Modules linked in: cts rpcsec_gss_krb5 ib_umad
> ib_ipoib mlx4_ib dm_mirror dm_region_hash dm_log dm_mod dax sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm iTCO_wdt
> iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel rpcrdma aesni_intel rdma_ucm crypto_simd cryptd ib_iser
> glue_helper rdma_cm iw_cm pcspkr ib_cm libiscsi scsi_transport_iscsi lpc_ich
> i2c_i801 mfd_core mei_me sg mei ioatdma wmi ipmi_si ipmi_devintf
> ipmi_msghandler acpi_power_meter acpi_pad pcc_cpufreq auth_rpcgss ip_tables
> xfs libcrc32c mlx4_en sr_mod cdrom qedr sd_mod ast drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops ttm drm mlx4_core crc32c_intel qede igb ahci
> libahci qed libata dca i2c_algo_bit i2c_core crc8 ib_uverbs ib_core nfsv4
> dns_resolver nfsv3 nfs_acl nfs lockd grace sunrpc fscache
> May  8 14:21:16 manet kernel: CPU: 10 PID: 45 Comm: kworker/u26:0 Not tainted
> 5.1.0-rc6-00066-g3be130e #286
> May  8 14:21:16 manet kernel: Hardware name: Supermicro SYS-6028R-T/X10DRi,
> BIOS 1.1a 10/16/2015
> May  8 14:21:16 manet kernel: Workqueue: rpciod rpc_async_schedule [sunrpc]
> May  8 14:21:16 manet kernel: RIP: 0010:__alloc_pages_nodemask+0x3f/0x2c2
> May  8 14:21:16 manet kernel: Code: f4 55 53 89 fb 48 83 ec 30 65 48 8b 04 25
> 28 00 00 00 48 89 44 24 28 31 c0 48 89 e7 83 fe 0a f3 ab 76 10 80 e7 20 74 02
> eb 02 <0f> 0b 31 c0 e9 38 02 00 00 23 1d e5 9b 0d 01 b8 22 01 32 01 48 63
> May  8 14:21:16 manet kernel: RSP: 0018:ffffc9000332fc98 EFLAGS: 00010246
> May  8 14:21:16 manet kernel: RAX: 0000000000000000 RBX: 0000000000040040 RCX:
> 0000000000000000
> May  8 14:21:16 manet kernel: RDX: 0000000000000001 RSI: 0000000000000017 RDI:
> ffffc9000332fcc0
> May  8 14:21:16 manet kernel: RBP: 0000000000000c40 R08: 0000000000000001 R09:
> 0000000000000000
> May  8 14:21:16 manet kernel: R10: 8080808080808080 R11: fefefefefefefeff R12:
> 0000000000000017
> May  8 14:21:16 manet kernel: R13: 000000050909093c R14: 0000000000000000 R15:
> 0000000000004291
> May  8 14:21:16 manet kernel: FS:  0000000000000000(0000)
> GS:ffff88886fb00000(0000) knlGS:0000000000000000
> May  8 14:21:16 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> May  8 14:21:16 manet kernel: CR2: 00007fe2167d1e94 CR3: 0000000002013001 CR4:
> 00000000001606e0
> May  8 14:21:16 manet kernel: Call Trace:
> May  8 14:21:16 manet kernel: kmalloc_order+0x1d/0x62
> May  8 14:21:16 manet kernel: kmalloc_order_trace+0x21/0x10d
> May  8 14:21:16 manet kernel: __kmalloc+0x42/0x14a
> May  8 14:21:16 manet kernel: ? xprt_do_reserve+0x6f/0x173 [sunrpc]
> May  8 14:21:16 manet kernel: rpc_malloc+0x61/0xba [sunrpc]
> May  8 14:21:16 manet kernel: call_allocate+0xdd/0x1af [sunrpc]
> May  8 14:21:16 manet kernel: ? rpc_clnt_add_xprt+0x153/0x153 [sunrpc]
> May  8 14:21:16 manet kernel: __rpc_execute+0x135/0x42c [sunrpc]
> May  8 14:21:16 manet kernel: rpc_async_schedule+0x29/0x39 [sunrpc]
> May  8 14:21:16 manet kernel: process_one_work+0x285/0x4be
> May  8 14:21:16 manet kernel: worker_thread+0x1b0/0x26f
> May  8 14:21:16 manet kernel: ? cancel_delayed_work_sync+0xf/0xf
> May  8 14:21:16 manet kernel: kthread+0xf6/0xfb
> May  8 14:21:16 manet kernel: ? kthread_flush_work+0xc6/0xc6
> May  8 14:21:16 manet kernel: ret_from_fork+0x24/0x30
> 
> And just now, the xfstests got stock and this appeared in v/l/m:
> 
> May  8 14:22:52 manet kernel: BUG: unable to handle kernel paging request at
> ffffffffc0000000
> May  8 14:22:52 manet kernel: #PF error: [INSTR]
> May  8 14:22:52 manet kernel: PGD 2016067 P4D 2016067 PUD 2018067 PMD 0 
> May  8 14:22:52 manet kernel: Oops: 0010 [#1] SMP
> May  8 14:22:52 manet kernel: CPU: 4 PID: 14848 Comm: rpc.gssd Tainted:
> G    B   W         5.1.0-rc6-00066-g3be130e #286
> May  8 14:22:52 manet kernel: Hardware name: Supermicro SYS-6028R-T/X10DRi,
> BIOS 1.1a 10/16/2015
> May  8 14:22:52 manet kernel: RIP: 0010:0xffffffffc0000000
> May  8 14:22:52 manet kernel: Code: Bad RIP value.
> May  8 14:22:52 manet kernel: RSP: 0018:ffffc9000cc57cd8 EFLAGS: 00010287
> May  8 14:22:52 manet kernel: RAX: ffff8884618641d8 RBX: ffffc9000cc57da0 RCX:
> ffff88886b9f0050
> May  8 14:22:52 manet kernel: RDX: 0000000000000020 RSI: ffff88846847b550 RDI:
> ffff8884618641d8
> May  8 14:22:52 manet kernel: RBP: ffffffffa04b22a0 R08: 0000000000000dc0 R09:
> 0000000000180011
> May  8 14:22:52 manet kernel: R10: ffffc9000cc57b30 R11: 0000000000000002 R12:
> ffff8884618641d8
> May  8 14:22:52 manet kernel: R13: 0000000000000c40 R14: 0000000000000010 R15:
> ffffc9000cc57d90
> May  8 14:22:52 manet kernel: FS:  00007febec152700(0000)
> GS:ffff88846fb00000(0000) knlGS:0000000000000000
> May  8 14:22:52 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> May  8 14:22:52 manet kernel: CR2: ffffffffbfffffd6 CR3: 0000000469fea003 CR4:
> 00000000001606e0
> May  8 14:22:52 manet kernel: Call Trace:
> May  8 14:22:52 manet kernel: ? krb5_derive_key+0x83/0x365 [rpcsec_gss_krb5]
> May  8 14:22:52 manet kernel: ? crypto_cts_setkey+0x2c/0x3b [cts]
> May  8 14:22:52 manet kernel: ? gss_import_sec_context_kerberos+0x823/0xa6d
> [rpcsec_gss_krb5]
> May  8 14:22:52 manet kernel: ? kmem_cache_alloc_trace+0xe4/0x10b
> May  8 14:22:52 manet kernel: ? gss_import_sec_context+0x6c/0xa9 [auth_rpcgss]
> May  8 14:22:52 manet kernel: ? gss_pipe_downcall+0x2cc/0x5b4 [auth_rpcgss]
> May  8 14:22:52 manet kernel: ? rpc_pipe_write+0x56/0x6d [sunrpc]
> May  8 14:22:52 manet kernel: ? vfs_write+0xa3/0xfa
> May  8 14:22:52 manet kernel: ? ksys_write+0x60/0xb3
> May  8 14:22:52 manet kernel: ? do_syscall_64+0x5a/0x68
> May  8 14:22:52 manet kernel: ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> May  8 14:22:52 manet kernel: Modules linked in: cts rpcsec_gss_krb5 ib_umad
> ib_ipoib mlx4_ib dm_mirror dm_region_hash dm_log dm_mod dax sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm iTCO_wdt
> iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel rpcrdma aesni_intel rdma_ucm crypto_simd cryptd ib_iser
> glue_helper rdma_cm iw_cm pcspkr ib_cm libiscsi scsi_transport_iscsi lpc_ich
> i2c_i801 mfd_core mei_me sg mei ioatdma wmi ipmi_si ipmi_devintf
> ipmi_msghandler acpi_power_meter acpi_pad pcc_cpufreq auth_rpcgss ip_tables
> xfs libcrc32c mlx4_en sr_mod cdrom qedr sd_mod ast drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops ttm drm mlx4_core crc32c_intel qede igb ahci
> libahci qed libata dca i2c_algo_bit i2c_core crc8 ib_uverbs ib_core nfsv4
> dns_resolver nfsv3 nfs_acl nfs lockd grace sunrpc fscache
> May  8 14:22:52 manet kernel: CR2: ffffffffc0000000
> May  8 14:22:52 manet kernel: ---[ end trace 3c526e4155ae084b ]---
> May  8 14:22:52 manet kernel: RIP: 0010:0xffffffffc0000000
> May  8 14:22:52 manet kernel: Code: Bad RIP value.
> May  8 14:22:52 manet kernel: RSP: 0018:ffffc9000cc57cd8 EFLAGS: 00010287
> May  8 14:22:52 manet kernel: RAX: ffff8884618641d8 RBX: ffffc9000cc57da0 RCX:
> ffff88886b9f0050
> May  8 14:22:52 manet kernel: RDX: 0000000000000020 RSI: ffff88846847b550 RDI:
> ffff8884618641d8
> May  8 14:22:52 manet kernel: RBP: ffffffffa04b22a0 R08: 0000000000000dc0 R09:
> 0000000000180011
> May  8 14:22:52 manet kernel: R10: ffffc9000cc57b30 R11: 0000000000000002 R12:
> ffff8884618641d8
> May  8 14:22:52 manet kernel: R13: 0000000000000c40 R14: 0000000000000010 R15:
> ffffc9000cc57d90
> May  8 14:22:52 manet kernel: FS:  00007febec152700(0000)
> GS:ffff88846fb00000(0000) knlGS:0000000000000000
> May  8 14:22:52 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> May  8 14:22:52 manet kernel: CR2: ffffffffbfffffd6 CR3: 0000000469fea003 CR4:
> 00000000001606e0
> May  8 14:22:52 manet kernel: BUG: sleeping function called from invalid
> context at /home/cel/src/linux/anna/include/linux/percpu-rwsem.h:34
> May  8 14:22:52 manet kernel: in_atomic(): 0, irqs_disabled(): 1, pid: 14848,
> name: rpc.gssd
> May  8 14:22:52 manet kernel: INFO: lockdep is turned off.
> May  8 14:22:52 manet kernel: irq event stamp: 0
> May  8 14:22:52 manet kernel: hardirqs last  enabled at (0):
> [<0000000000000000>]           (null)
> May  8 14:22:52 manet kernel: hardirqs last disabled at (0):
> [<ffffffff8106e944>] copy_process+0x774/0x1e24
> May  8 14:22:52 manet kernel: softirqs last  enabled at (0):
> [<ffffffff8106e944>] copy_process+0x774/0x1e24
> May  8 14:22:52 manet kernel: softirqs last disabled at (0):
> [<0000000000000000>]           (null)
> May  8 14:22:52 manet kernel: CPU: 4 PID: 14848 Comm: rpc.gssd Tainted: G    B
> D W         5.1.0-rc6-00066-g3be130e #286
> May  8 14:22:52 manet kernel: Hardware name: Supermicro SYS-6028R-T/X10DRi,
> BIOS 1.1a 10/16/2015
> May  8 14:22:52 manet kernel: Call Trace:
> May  8 14:22:52 manet kernel: dump_stack+0x78/0xa9
> May  8 14:22:52 manet kernel: ___might_sleep+0x1b8/0x1cd
> May  8 14:22:52 manet kernel: exit_signals+0x35/0x195
> May  8 14:22:52 manet kernel: do_exit+0x122/0xa61
> May  8 14:22:52 manet kernel: ? ksys_write+0x60/0xb3
> May  8 14:22:52 manet kernel: rewind_stack_do_exit+0x17/0x20
> 
> 
> --
> Chuck Lever
> 
> 
> 

