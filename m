Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5591824C9ED
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 04:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHUCPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHUCP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 22:15:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585AC061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 19:15:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so153907pjx.5
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 19:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbPoIC+Wx/EHwweH2HBqKJfj2wNXDKq4qYySIjVEr5Q=;
        b=npsYwotq1eh7OCCDUuysMCK/Ho5QcQg57T7wsP21AKQYwjdPq0nTGQrHm06McN4yTr
         gN1iMabB5mPZ7E1EU10zq9giN8FVm/Uwy1TY1y9dFA+7LMW13qOcCPJGpLPNf/Tme68I
         D4CcKzW9RmXFxptuQTgqP3HMzkf5flCxrH0Qmx6GtUU94uxivxeN2s9N2EY1DuomgoGy
         Ng3c05SV0M/Bx+wxXluZ3+L9sFDl8cOe3n0XUSoWva/QUHHR0qcO6ZSVTbUHNDXg1o+8
         UGD6WMgjM74atQXMs++D3KqTHlKZtLeLqzcct/kyUBIEDQUCnp9I8QzgkxPsVzXMxvp8
         TJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbPoIC+Wx/EHwweH2HBqKJfj2wNXDKq4qYySIjVEr5Q=;
        b=e+a+IYVsWS3S4dPAA0yLz2dDt5fzsxmCehxlWdeY+oq7N3Yvuu4kSXFNm6REcdIFjl
         8sqzRONrgboVMwBSRbfATKFioLrJthUFNSOitTTXTEV86Fn4L+pzfce+PMj8TKWcnJ9X
         cywPd7Phuo0S/ubi3IUXy/NSRW5r37R0/BtbDz+nq59tkFchSV5jA8bNvKmlVzs3z368
         zJzcI3i8whxLtPJUpIfsW5Moiq6Pcrosox61jS3EGV4vZ41qgGYQk1tSxdr4JxNByzqw
         2CBfowIsnDP57TkqlIAhtuzLjl2jglS2fptyHpIYGnzx295iyEFN8OikMovar/8kRDrS
         nHmw==
X-Gm-Message-State: AOAM532rjvB4yrNaQnkLR9UBSYrDrtuWon0hmJJJ2QNsakqjZ3CgXoFi
        ws8yOFnNMmXPodG+pEowZRo=
X-Google-Smtp-Source: ABdhPJy3CMC9vDiEUxTUnP4hVLQmNcX50jrNcLZyiXt05Hh772gb0aScNrVQaC6AAVwu9NuOH3GCxg==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr693803pjq.52.1597976127964;
        Thu, 20 Aug 2020 19:15:27 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u62sm450886pfb.4.2020.08.20.19.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 19:15:27 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:15:20 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: 5.9 nfsd update breaks v4.2 copy_file_range
Message-ID: <20200821021520.xjvnllir77oduybj@xzhoux.usersys.redhat.com>
References: <20200821015036.bn3yqiiuvunfxb42@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821015036.bn3yqiiuvunfxb42@xzhoux.usersys.redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also, generic/013 and generic/464 starts to triger WARN since
this update:

[11205.653858] run fstests generic/464 at 2020-08-09 23:31:06
[11207.046292] ------------[ cut here ]------------
[11207.070326] WARNING: CPU: 8 PID: 116965 at fs/nfsd/nfs4state.c:4955 nfsd4_check_conflicting_opens+0x94/0xa0 [nfsd]
[11207.120635] Modules linked in: loop dm_mod rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache nfsd auth_rpcgss nfs_acl lockd grace rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp sunrpc kvm_intel kvm irqbypass ipmi_ssif iTCO_wdt crct10dif_pclmul mgag200 crc32_pclmul iTCO_vendor_support drm_kms_helper ghash_clmulni_intel syscopyarea sysfillrect sysimgblt fb_sys_fops rapl acpi_ipmi intel_cstate drm intel_uncore ext4 ipmi_si pcspkr hpwdt i2c_i801 ipmi_devintf lpc_ich i2c_smbus hpilo ioatdma mbcache ipmi_msghandler acpi_power_meter jbd2 acpi_tad vfat fat ip_tables xfs libcrc32c sd_mod t10_pi sg ahci libahci igb i2c_algo_bit libata crc32c_intel hpsa dca tg3 scsi_transport_sas wmi
[11207.406976] CPU: 8 PID: 116965 Comm: nfsd Tainted: G S      W         5.8.0+ #1
[11207.439863] Hardware name: HP ProLiant DL120 Gen9, BIOS P86 07/20/2015
[11207.468889] RIP: 0010:nfsd4_check_conflicting_opens+0x94/0xa0 [nfsd]
[11207.497390] Code: 48 39 d6 75 ed 4c 89 e7 c6 07 00 0f 1f 40 00 31 c0 5b 5d 41 5c c3 4c 89 e7 c6 07 00 0f 1f 40 00 b8 f5 ff ff ff 5b 5d 41 5c c3 <0f> 0b eb 99 b8 f5 ff ff ff eb dc 90 0f 1f 44 00 00 48 8b 56 48 48
[11207.583426] RSP: 0018:ffffc2c701b13ca0 EFLAGS: 00010286
[11207.610286] RAX: 00000000ffffffff RBX: ffff9fc12a5511e0 RCX: 0000000000000000
[11207.644050] RDX: ffff9fc16acd7700 RSI: ffff9fc11ade5c20 RDI: ffff9fc14fa7e540
[11207.676164] RBP: ffffc2c701b13d98 R08: ffff9fc14fa7e540 R09: ffff9fc1ad873838
[11207.708299] R10: 0000000000000000 R11: ffff9fc11ade5c48 R12: ffff9fc11ade5c20
[11207.741271] R13: ffff9fc11ade5c24 R14: ffff9fc11ade5c20 R15: ffff9fc16cb9a0b8
[11207.773353] FS:  0000000000000000(0000) GS:ffff9fc1afc00000(0000) knlGS:0000000000000000
[11207.809572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11207.835344] CR2: 000055c329644c58 CR3: 00000001a9c0e001 CR4: 00000000001706e0
[11207.867672] Call Trace:
[11207.878590]  nfsd4_process_open2+0x10a3/0x1420 [nfsd]
[11207.901180]  ? fh_verify+0x15a/0x640 [nfsd]
[11207.919831]  ? nfsd4_process_open1+0x178/0x460 [nfsd]
[11207.942515]  ? write_bytes_to_xdr_buf+0xbc/0xe0 [sunrpc]
[11207.966386]  nfsd4_open+0x3c6/0x710 [nfsd]
[11207.984688]  nfsd4_proc_compound+0x37f/0x700 [nfsd]
[11208.006680]  ? nfsd4_read_rsize+0x20/0x20 [nfsd]
[11208.027457]  nfsd_dispatch+0xa9/0x210 [nfsd]
[11208.046546]  svc_process_common+0x386/0x6f0 [sunrpc]
[11208.068762]  ? svc_sock_secure_port+0x12/0x30 [sunrpc]
[11208.093021]  ? svc_recv+0x3d5/0x8b0 [sunrpc]
[11208.114794]  ? nfsd_svc+0x2e0/0x2e0 [nfsd]
[11208.133618]  ? nfsd_destroy+0x50/0x50 [nfsd]
[11208.153157]  svc_process+0xb7/0xf0 [sunrpc]
[11208.172392]  nfsd+0xe3/0x140 [nfsd]
[11208.188476]  kthread+0x114/0x130
[11208.203033]  ? kthread_park+0x80/0x80
[11208.219513]  ret_from_fork+0x22/0x30
[11208.235620] ---[ end trace a7a6ef3886bf234a ]---

On Fri, Aug 21, 2020 at 09:50:36AM +0800, Murphy Zhou wrote:
> Hi Bruce,
> 
> It's easy to reproduce by running multiple xfstests testcases on localhost
> NFS shares. These testcases are:
>   generic/430 generic/431 generic/432 generic/433 generic/565
> 
> This reproduces only on NFSv4.2.
> 
> Error log diff sample:
> 
> --- /dev/fd/63	2020-08-09 22:46:02.771745606 -0400
> +++ results/generic/431.out.bad	2020-08-09 22:46:02.546745248 -0400
> @@ -1,15 +1,22 @@
>  QA output created by 431
>  Create the original file and then copy
> +cmp: EOF on /mnt/testdir/test-431/copy which is empty
>  Original md5sums:
>  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> -ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/copy
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/copy
>  Small copies from various points in the original file
> +cmp: EOF on /mnt/testdir/test-431/a which is empty
> +cmp: EOF on /mnt/testdir/test-431/b which is empty
> +cmp: EOF on /mnt/testdir/test-431/c which is empty
> +cmp: EOF on /mnt/testdir/test-431/d which is empty
> +cmp: EOF on /mnt/testdir/test-431/e which is empty
> +cmp: EOF on /mnt/testdir/test-431/f which is empty
>  md5sums after small copies
>  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> -0cc175b9c0f1b6a831c399e269772661  TEST_DIR/test-431/a
> -92eb5ffee6ae2fec3ad71c777531578f  TEST_DIR/test-431/b
> -4a8a08f09d37b73795649038408b5f33  TEST_DIR/test-431/c
> -8277e0910d750195b448797616e091ad  TEST_DIR/test-431/d
> -e1671797c52e15f763380b45e841ec32  TEST_DIR/test-431/e
> -2015eb238d706eceefc784742928054f  TEST_DIR/test-431/f
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/a
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/b
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/c
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/d
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/e
> +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/f
>  d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/g
> 
> Bisecting shows the first "bad" commit is:
> 
> commit 94415b06eb8aed13481646026dc995f04a3a534a
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Tue Jul 7 09:28:05 2020 -0400
> 
>     nfsd4: a client's own opens needn't prevent delegations
> 
> I'm wondering if you're already aware of it, this simple report is for
> your info.
> 
> Thanks.
> 
> -- 
> Murphy

-- 
Murphy
