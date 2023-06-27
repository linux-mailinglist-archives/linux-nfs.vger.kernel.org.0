Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767BE7403CB
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF0TJV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jun 2023 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjF0TJU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jun 2023 15:09:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E819B5;
        Tue, 27 Jun 2023 12:09:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3fde9739e20so41964631cf.2;
        Tue, 27 Jun 2023 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687892956; x=1690484956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvLLHqZXTrbojrvqEUj36AHrcoM+Y/e+RUYE3W0SX50=;
        b=nfPgJq7LHnCyGI0Aq5Wy1QlTBGLgwkSWkvXsj9y/sJHGMXEwoWE98hQz0sCf8UBw4P
         Az9QSr1tXHEaGh3SkK8pQERLb1RXg0nsSlN3Q6QTCNUAx08gGFCtpJf5kasO3Ym1z0n0
         m0AinAtjLV4DmGZ26CqXq2fAo0Ng57G3bzexbQHCK+0tJUKk5DhUBx9sIgoVO0Bb8ja3
         2FbldbVZw0WQgwmf+PsFL7rNsR4vbmZafH08zvRsBG2z/jQyKvzVBEsl5cZn/DCRYcdn
         LTxF+vlQzAc6kH13HgmsnJbR4oOMZaIYJt71lhDRSjG0TQZQErmDdZjWsI3aUE3np0xR
         bPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687892956; x=1690484956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvLLHqZXTrbojrvqEUj36AHrcoM+Y/e+RUYE3W0SX50=;
        b=a/hrH60Xt3z9nv6ON7mFpoaGKTY8GAOb/dUZHnTNCu2hoOc76hZ1WXKwxemvDq4tvb
         6UtEATF1c2ZKJAzif2uwW3CU11ZuKNuwExh9wGKzRcgpkZaQ6s7l2X9hjWzFlHBKfm6Z
         cJZDN2RQgei3NXDqEQqCdAW+ah9aBuNZOlnc1eU2BUjL6VQdMzVHU8M5UoiWmQ/y+AIc
         htkDQvzOldK9Vcx6YA/tbM1dLFfaVLDqwmefx54NweSc+5stcDgiPVTG8HPJPQ2mc8T4
         CeKhmwELCYwjysCmJim2fH8oH5GN18pn12DcPN3GduScMrfDfSc8mhqOrSB2N+jGEL0r
         qx2w==
X-Gm-Message-State: AC+VfDw43eh1bsZ+Aw8/06qmBMuibMeUhYEC6r7bVOYxn7/IQVQx72Zo
        VX77z+GhuwXqoKvIexxkZOY31wnmn6+jZTB7liM=
X-Google-Smtp-Source: ACHHUZ6GIt/yCcrS5IPzilKU5FIToyk4VL+k1G7AhbnA+59ArNQwdXAuXTikZYersIsquyyl/DOrop6XC5ip81QPWE8=
X-Received: by 2002:a05:622a:1745:b0:3f9:c838:d584 with SMTP id
 l5-20020a05622a174500b003f9c838d584mr40634321qtk.0.1687892955716; Tue, 27 Jun
 2023 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org> <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org> <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
 <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
 <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com>
 <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org> <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
 <dfcc114f-56f1-e4ab-7b36-f9a4ce3e8c8c@linaro.org> <CAFX2Jf=uaOC2oDceShnNNJdSeW-MNwh7N=Jh=S9zYjP_Ci-DuQ@mail.gmail.com>
 <74b0dcc4-a061-715e-93c1-e010fbaa85fb@linaro.org>
In-Reply-To: <74b0dcc4-a061-715e-93c1-e010fbaa85fb@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 27 Jun 2023 15:08:59 -0400
Message-ID: <CAFX2JfkZsL=Q7+33BzOKaicFDSw0+PMOV8PqAiC_VLZzjPpvLQ@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="0000000000000c16e605ff21343b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--0000000000000c16e605ff21343b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Jun 26, 2023 at 6:28=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/06/2023 19:59, Anna Schumaker wrote:
> >>>>>>>
> >>>>>>> Can you swap out yesterday's patch with this patch? I've adjusted=
 what
> >>>>>>> gets printed out, and added printk()s to xdr_copy_to_scratch().  =
I'm
> >>>>>>> starting to think that the xdr scratch buffer is fine, and that i=
t's
> >>>>>>> the other pointer passed to memcpy() in that function that's the
> >>>>>>> problem, and the output from this patch will confirm for me.
> >>>>>>
> >>>>>> Oh, and can you add this one on top of the v2 patch as well?
> >>>>>
> >>>>> Sorry about the noise today. Can you use this patch instead of the =
two
> >>>>> I attached earlier? I cleaned up the output and cut down on extra
> >>>>> output..
> >>>>>
> >>>>
> >>>> Here you have - attached.
> >>>
> >>> This is good, thanks! I was finally able to figure out how to hit the
> >>> bug using a 32bit x86 VM, so hopefully the next thing you hear from m=
e
> >>> is a patch fixing the bug!
> >
> > I'm really hopeful that the attached patch finally fixes the issue.
> > Can you try it and let me know?
>
> Just test it yourself on 32-bit system... There is absolutely nothing
> special in the system I reproduced it on. Nothing.
>

I have an updated set of patches for you to try out, hopefully fixing
that last set of warnings from the other day. I gave them the same
amount of testing as my previous patch: connectathon tests, xfstests,
and my own read plus test using x86_64 and i686 VMs mounted with NFS
versions 3, 4.0, 4.1, and 4.2 and sec=3Dsys, sec=3Dkrb5, sec=3Dkrb5i, and
sec=3Dkrb5p. I have not hit any oopses, warnings, or newly-failing
tests.

I would appreciate it if you could try it out on your hardware and let
me know if there is still an issue since trying to compile an
exynos_defconfig for an i686 VM will result in a different set of
Kconfig options getting selected compared to what you have.
Additionally, your odroid-hc1 has a unique CPU setup containing both a
Cortex-A15 and Cortex-A7 which isn't possible to virtualize with
libvirt.

Thanks.
Anna
>
> IP-Config: eth0 hardware address 00:1e:06:30:bf:ac mtu 1500
> IP-Config: eth0 guessed broadcast address 192.168.1.255
> IP-Config: eth0 complete (from 192.168.1.10):
>  address: 192.168.1.12     broadcast: 192.168.1.255    netmask:
> 255.255.255.0
>  gateway: 192.168.1.1      dns0     : 0.0.0.0          dns1   : 0.0.0.0
>
>  rootserver: 192.168.1.10 rootpath:
>  filename  :
> NFS-Mount: 192.168.1.10:/srv/nfs/odroidhc1
> Waiting 10 seconds for device /dev/nfs ...
> ERROR: device '/dev/nfs' not found. Skipping fsck.
> Mount cmd:
> mount.nfs4 -o vers=3D4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
> [   21.800626] ------------[ cut here ]------------
> [   21.803891] WARNING: CPU: 7 PID: 154 at mm/highmem.c:603
> xdr_stream_unmap_current_page+0x18/0x24
> [   21.812729] Modules linked in:
> [   21.815642] CPU: 7 PID: 154 Comm: mount.nfs4 Not tainted
> 6.4.0-00001-gfbb103bb8df0 #8
> [   21.823444] Hardware name: Samsung Exynos (Flattened Device Tree)
> [   21.829525]  unwind_backtrace from show_stack+0x10/0x14
> [   21.834698]  show_stack from dump_stack_lvl+0x58/0x70
> [   21.839730]  dump_stack_lvl from __warn+0x7c/0x1bc
> [   21.844491]  __warn from warn_slowpath_fmt+0xbc/0x1b8
> [   21.849518]  warn_slowpath_fmt from
> xdr_stream_unmap_current_page+0x18/0x24
> [   21.856437]  xdr_stream_unmap_current_page from call_decode+0x210/0x2c=
8
> [   21.863020]  call_decode from __rpc_execute+0xf8/0x764
> [   21.868134]  __rpc_execute from rpc_execute+0xc0/0x1d0
> [   21.873243]  rpc_execute from rpc_run_task+0x148/0x190
> [   21.878348]  rpc_run_task from rpc_create_xprt+0x1a4/0x284
> [   21.883805]  rpc_create_xprt from rpc_create+0xf8/0x254
> [   21.889004]  rpc_create from nfs_create_rpc_client+0x150/0x17c
> [   21.894812]  nfs_create_rpc_client from nfs4_alloc_client+0x360/0x374
> [   21.901226]  nfs4_alloc_client from nfs_get_client+0x16c/0x3e8
> [   21.907030]  nfs_get_client from nfs4_set_client+0xfc/0x1a4
> [   21.912574]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
> [   21.918554]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
> [   21.924534]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
> [   21.929993]  vfs_get_tree from path_mount+0x3e8/0xb04
> [   21.935019]  path_mount from sys_mount+0x20c/0x254
> [   21.939784]  sys_mount from ret_fast_syscall+0x0/0x1c
> [   21.944809] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
> [   21.949837] 9fa0:                   0047ebe0 00479c64 0047e960
> 0047e9b8 0047e9c8 00000000
> [   21.957986] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
> 00000010 00479c64 00466bfc
> [   21.966139] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
> [   21.971245] irq event stamp: 0
> [   21.974188] hardirqs last  enabled at (0): [<00000000>] 0x0
> [   21.979736] hardirqs last disabled at (0): [<c012357c>]
> copy_process+0x810/0x1ffc
> [   21.987227] softirqs last  enabled at (0): [<c012357c>]
> copy_process+0x810/0x1ffc
> [   21.994679] softirqs last disabled at (0): [<00000000>] 0x0
> [   22.000264] ---[ end trace 0000000000000000 ]---
> [   22.004781] BUG: sleeping function called from invalid context at
> net/sunrpc/sched.c:953
> [   22.012876] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
> 154, name: mount.nfs4
> [   22.020936] preempt_count: 1, expected: 0
> [   22.024881] RCU nest depth: 0, expected: 0
> [   22.028955] INFO: lockdep is turned off.
> [   22.032889] CPU: 7 PID: 154 Comm: mount.nfs4 Tainted: G        W
>     6.4.0-00001-gfbb103bb8df0 #8
> [   22.042131] Hardware name: Samsung Exynos (Flattened Device Tree)
> [   22.048196]  unwind_backtrace from show_stack+0x10/0x14
> [   22.053393]  show_stack from dump_stack_lvl+0x58/0x70
> [   22.058417]  dump_stack_lvl from __might_resched+0x194/0x260
> [   22.064054]  __might_resched from __rpc_execute+0x118/0x764
> [   22.069596]  __rpc_execute from rpc_execute+0xc0/0x1d0
> [   22.074708]  rpc_execute from rpc_run_task+0x148/0x190
> [   22.079821]  rpc_run_task from rpc_create_xprt+0x1a4/0x284
> [   22.085281]  rpc_create_xprt from rpc_create+0xf8/0x254
> [   22.090483]  rpc_create from nfs_create_rpc_client+0x150/0x17c
> [   22.096286]  nfs_create_rpc_client from nfs4_alloc_client+0x360/0x374
> [   22.102700]  nfs4_alloc_client from nfs_get_client+0x16c/0x3e8
> [   22.108504]  nfs_get_client from nfs4_set_client+0xfc/0x1a4
> [   22.114050]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
> [   22.120029]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
> [   22.126009]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
> [   22.131467]  vfs_get_tree from path_mount+0x3e8/0xb04
> [   22.136493]  path_mount from sys_mount+0x20c/0x254
> [   22.141258]  sys_mount from ret_fast_syscall+0x0/0x1c
> [   22.146284] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
> [   22.151322] 9fa0:                   0047ebe0 00479c64 0047e960
> 0047e9b8 0047e9c8 00000000
> [   22.159461] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
> 00000010 00479c64 00466bfc
> [   22.167606] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
> [   22.172820] BUG: scheduling while atomic: mount.nfs4/154/0x00000002
> [   22.178871] INFO: lockdep is turned off.
> [   22.182803] Modules linked in:
> [   22.185798] CPU: 7 PID: 154 Comm: mount.nfs4 Tainted: G        W
>     6.4.0-00001-gfbb103bb8df0 #8
> [   22.195076] Hardware name: Samsung Exynos (Flattened Device Tree)
> [   22.201139]  unwind_backtrace from show_stack+0x10/0x14
> [   22.206337]  show_stack from dump_stack_lvl+0x58/0x70
> [   22.211365]  dump_stack_lvl from __schedule_bug+0x70/0x84
> [   22.216736]  __schedule_bug from __schedule+0x9c0/0xc80
> [   22.221936]  __schedule from schedule+0x58/0xf8
> [   22.226439]  schedule from schedule_timeout+0x134/0x200
> [   22.231641]  schedule_timeout from __wait_for_common+0xac/0x1f8
> [   22.237533]  __wait_for_common from
> wait_for_completion_killable+0x18/0x24
> [   22.244379]  wait_for_completion_killable from
> __kthread_create_on_node+0xe0/0x168
> [   22.251923]  __kthread_create_on_node from
> kthread_create_on_node+0x30/0x60
> [   22.258851]  kthread_create_on_node from svc_set_num_threads+0x1c8/0x4=
20
> [   22.265525]  svc_set_num_threads from nfs_callback_up+0x150/0x3c0
> [   22.271597]  nfs_callback_up from nfs4_init_client+0x98/0x144
> [   22.277306]  nfs4_init_client from nfs4_set_client+0xfc/0x1a4
> [   22.283026]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
> [   22.289005]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
> [   22.294985]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
> [   22.300444]  vfs_get_tree from path_mount+0x3e8/0xb04
> [   22.305468]  path_mount from sys_mount+0x20c/0x254
> [   22.310249]  sys_mount from ret_fast_syscall+0x0/0x1c
> [   22.315261] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
> [   22.320300] 9fa0:                   0047ebe0 00479c64 0047e960
> 0047e9b8 0047e9c8 00000000
> [   22.328438] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
> 00000010 00479c64 00466bfc
> [   22.336582] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
> :: running cleanup hook [udev]
> [   26.235349] systemd[1]: System time before build time, advancing clock=
.
> [   26.435536] systemd[1]: systemd 253.4-1-arch running in system mode
> (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS
> +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
> +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2
> +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT
> default-hierarchy=3Dunified)
> [   26.466749] systemd[1]: Detected architecture arm.
>
>
>
> Best regards,
> Krzysztof
>

--0000000000000c16e605ff21343b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0003-NFSv4.2-Rework-scratch-handling-for-READ_PLUS-aga.patch"
Content-Disposition: attachment; 
	filename="v4-0003-NFSv4.2-Rework-scratch-handling-for-READ_PLUS-aga.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljenf84x1>
X-Attachment-Id: f_ljenf84x1

RnJvbSAxOTQxOTIwMjQyMGVlNDcxODNjNGU4MTExOGQxN2RmYWYwOGJkZWE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogRnJpLCA5IEp1biAyMDIzIDE1OjI2OjI1IC0wNDAwClN1YmplY3Q6IFtQQVRD
SCB2NCAzLzRdIE5GU3Y0LjI6IFJld29yayBzY3JhdGNoIGhhbmRsaW5nIGZvciBSRUFEX1BMVVMg
KGFnYWluKQoKSSBmb3VuZCB0aGF0IHRoZSByZWFkIGNvZGUgbWlnaHQgc2VuZCBtdWx0aXBsZSBy
ZXF1ZXN0cyB1c2luZyB0aGUgc2FtZQpuZnNfcGdpb19oZWFkZXIsIGJ1dCBuZnM0X3Byb2NfcmVh
ZF9zZXR1cCgpIGlzIG9ubHkgY2FsbGVkIG9uY2UuIFRoaXMgaXMKaG93IHdlIGVuZGVkIHVwIG9j
Y2FzaW9uYWxseSBkb3VibGUtZnJlZWluZyB0aGUgc2NyYXRjaCBidWZmZXIsIGJ1dCBhbHNvCm1l
YW5zIHdlIHNldCBhIE5VTEwgcG9pbnRlciBidXQgbm9uLXplcm8gbGVuZ3RoIHRvIHRoZSB4ZHIg
c2NyYXRjaApidWZmZXIuIFRoaXMgcmVzdWx0cyBpbiBhbiBvb3BzIHRoZSBmaXJzdCB0aW1lIGRl
Y29kaW5nIG5lZWRzIHRvIGNvcHkKc29tZXRoaW5nIHRvIHNjcmF0Y2gsIHdoaWNoIGZyZXF1ZW50
bHkgaGFwcGVucyB3aGVuIGRlY29kaW5nIFJFQURfUExVUwpob2xlIHNlZ21lbnRzLgoKSSBmaXgg
dGhpcyBieSBtb3Zpbmcgc2NyYXRjaCBoYW5kbGluZyBpbnRvIHRoZSBwYWdlaW8gcmVhZCBjb2Rl
LiBJCnByb3ZpZGUgYSBmdW5jdGlvbiB0byBhbGxvY2F0ZSBzY3JhdGNoIHNwYWNlIGZvciBkZWNv
ZGluZyByZWFkIHJlcGxpZXMsCmFuZCBmcmVlIHRoZSBzY3JhdGNoIGJ1ZmZlciB3aGVuIHRoZSBu
ZnNfcGdpb19oZWFkZXIgaXMgZnJlZWQuCgpGaXhlczogZmJkMmEwNWYyOWE5IChORlN2NC4yOiBS
ZXdvcmsgc2NyYXRjaCBoYW5kbGluZyBmb3IgUkVBRF9QTFVTKQpTaWduZWQtb2ZmLWJ5OiBBbm5h
IFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNvbT4KLS0tCiBmcy9uZnMvaW50ZXJu
YWwuaCB8ICAxICsKIGZzL25mcy9uZnM0Mi5oICAgIHwgIDEgKwogZnMvbmZzL25mczQyeGRyLmMg
fCAgMiArLQogZnMvbmZzL25mczRwcm9jLmMgfCAxMyArLS0tLS0tLS0tLS0tCiBmcy9uZnMvcmVh
ZC5jICAgICB8IDEwICsrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzL2ludGVybmFsLmggYi9mcy9u
ZnMvaW50ZXJuYWwuaAppbmRleCAzY2MwMjdkM2JkNTguLjE2MDdjMjNmNjhkNCAxMDA2NDQKLS0t
IGEvZnMvbmZzL2ludGVybmFsLmgKKysrIGIvZnMvbmZzL2ludGVybmFsLmgKQEAgLTQ4OSw2ICs0
ODksNyBAQCBleHRlcm4gY29uc3Qgc3RydWN0IG5mc19wZ2lvX2NvbXBsZXRpb25fb3BzIG5mc19h
c3luY19yZWFkX2NvbXBsZXRpb25fb3BzOwogZXh0ZXJuIHZvaWQgbmZzX3BhZ2Vpb19pbml0X3Jl
YWQoc3RydWN0IG5mc19wYWdlaW9fZGVzY3JpcHRvciAqcGdpbywKIAkJCXN0cnVjdCBpbm9kZSAq
aW5vZGUsIGJvb2wgZm9yY2VfbWRzLAogCQkJY29uc3Qgc3RydWN0IG5mc19wZ2lvX2NvbXBsZXRp
b25fb3BzICpjb21wbF9vcHMpOworZXh0ZXJuIGJvb2wgbmZzX3JlYWRfYWxsb2Nfc2NyYXRjaChz
dHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIsIHNpemVfdCBzaXplKTsKIGV4dGVybiBpbnQgbmZz
X3JlYWRfYWRkX2ZvbGlvKHN0cnVjdCBuZnNfcGFnZWlvX2Rlc2NyaXB0b3IgKnBnaW8sCiAJCQkg
ICAgICAgc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKmN0eCwKIAkJCSAgICAgICBzdHJ1Y3QgZm9s
aW8gKmZvbGlvKTsKZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0Mi5oIGIvZnMvbmZzL25mczQyLmgK
aW5kZXggMGZlNWFhY2JjZmRmLi5iNTk4NzZiMDFhMWUgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9uZnM0
Mi5oCisrKyBiL2ZzL25mcy9uZnM0Mi5oCkBAIC0xMyw2ICsxMyw3IEBACiAgKiBtb3JlPyBOZWVk
IHRvIGNvbnNpZGVyIG5vdCB0byBwcmUtYWxsb2MgdG9vIG11Y2ggZm9yIGEgY29tcG91bmQuCiAg
Ki8KICNkZWZpbmUgUE5GU19MQVlPVVRTVEFUU19NQVhERVYgKDQpCisjZGVmaW5lIFJFQURfUExV
U19TQ1JBVENIX1NJWkUgKDE2KQogCiAvKiBuZnM0LjJwcm9jLmMgKi8KICNpZmRlZiBDT05GSUdf
TkZTX1Y0XzIKZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0Mnhkci5jIGIvZnMvbmZzL25mczQyeGRy
LmMKaW5kZXggNzU3NjUzODJjYzBlLi4yMGFhNWU3NDY0OTcgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9u
ZnM0Mnhkci5jCisrKyBiL2ZzL25mcy9uZnM0Mnhkci5jCkBAIC0xMzUxLDcgKzEzNTEsNyBAQCBz
dGF0aWMgaW50IG5mczRfeGRyX2RlY19yZWFkX3BsdXMoc3RydWN0IHJwY19ycXN0ICpycXN0cCwK
IAlzdHJ1Y3QgY29tcG91bmRfaGRyIGhkcjsKIAlpbnQgc3RhdHVzOwogCi0JeGRyX3NldF9zY3Jh
dGNoX2J1ZmZlcih4ZHIsIHJlcy0+c2NyYXRjaCwgc2l6ZW9mKHJlcy0+c2NyYXRjaCkpOworCXhk
cl9zZXRfc2NyYXRjaF9idWZmZXIoeGRyLCByZXMtPnNjcmF0Y2gsIFJFQURfUExVU19TQ1JBVENI
X1NJWkUpOwogCiAJc3RhdHVzID0gZGVjb2RlX2NvbXBvdW5kX2hkcih4ZHIsICZoZHIpOwogCWlm
IChzdGF0dXMpCmRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJv
Yy5jCmluZGV4IGQzNjY1MzkwYzRjYi4uNzNkYzhhNzkzYWU5IDEwMDY0NAotLS0gYS9mcy9uZnMv
bmZzNHByb2MuYworKysgYi9mcy9uZnMvbmZzNHByb2MuYwpAQCAtNTQzNywxOCArNTQzNyw4IEBA
IHN0YXRpYyBib29sIG5mczRfcmVhZF9wbHVzX25vdF9zdXBwb3J0ZWQoc3RydWN0IHJwY190YXNr
ICp0YXNrLAogCXJldHVybiBmYWxzZTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIG5mczRfcmVh
ZF9wbHVzX3NjcmF0Y2hfZnJlZShzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIpCi17Ci0JaWYg
KGhkci0+cmVzLnNjcmF0Y2gpIHsKLQkJa2ZyZWUoaGRyLT5yZXMuc2NyYXRjaCk7Ci0JCWhkci0+
cmVzLnNjcmF0Y2ggPSBOVUxMOwotCX0KLX0KLQogc3RhdGljIGludCBuZnM0X3JlYWRfZG9uZShz
dHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssIHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKmhkcikKIHsKLQlu
ZnM0X3JlYWRfcGx1c19zY3JhdGNoX2ZyZWUoaGRyKTsKLQogCWlmICghbmZzNF9zZXF1ZW5jZV9k
b25lKHRhc2ssICZoZHItPnJlcy5zZXFfcmVzKSkKIAkJcmV0dXJuIC1FQUdBSU47CiAJaWYgKG5m
czRfcmVhZF9zdGF0ZWlkX2NoYW5nZWQodGFzaywgJmhkci0+YXJncykpCkBAIC01NDY4LDggKzU0
NTgsNyBAQCBzdGF0aWMgYm9vbCBuZnM0Ml9yZWFkX3BsdXNfc3VwcG9ydChzdHJ1Y3QgbmZzX3Bn
aW9faGVhZGVyICpoZHIsCiAJLyogTm90ZTogV2UgZG9uJ3QgdXNlIFJFQURfUExVUyB3aXRoIHBO
RlMgeWV0ICovCiAJaWYgKG5mc19zZXJ2ZXJfY2FwYWJsZShoZHItPmlub2RlLCBORlNfQ0FQX1JF
QURfUExVUykgJiYgIWhkci0+ZHNfY2xwKSB7CiAJCW1zZy0+cnBjX3Byb2MgPSAmbmZzNF9wcm9j
ZWR1cmVzW05GU1BST0M0X0NMTlRfUkVBRF9QTFVTXTsKLQkJaGRyLT5yZXMuc2NyYXRjaCA9IGtt
YWxsb2MoMzIsIEdGUF9LRVJORUwpOwotCQlyZXR1cm4gaGRyLT5yZXMuc2NyYXRjaCAhPSBOVUxM
OworCQlyZXR1cm4gbmZzX3JlYWRfYWxsb2Nfc2NyYXRjaChoZHIsIFJFQURfUExVU19TQ1JBVENI
X1NJWkUpOwogCX0KIAlyZXR1cm4gZmFsc2U7CiB9CmRpZmYgLS1naXQgYS9mcy9uZnMvcmVhZC5j
IGIvZnMvbmZzL3JlYWQuYwppbmRleCBmNzFlZWVlNjdlMjAuLjdkYzIxYTQ4ZTNlNyAxMDA2NDQK
LS0tIGEvZnMvbmZzL3JlYWQuYworKysgYi9mcy9uZnMvcmVhZC5jCkBAIC00Nyw2ICs0Nyw4IEBA
IHN0YXRpYyBzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpuZnNfcmVhZGhkcl9hbGxvYyh2b2lkKQog
CiBzdGF0aWMgdm9pZCBuZnNfcmVhZGhkcl9mcmVlKHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKnJo
ZHIpCiB7CisJaWYgKHJoZHItPnJlcy5zY3JhdGNoICE9IE5VTEwpCisJCWtmcmVlKHJoZHItPnJl
cy5zY3JhdGNoKTsKIAlrbWVtX2NhY2hlX2ZyZWUobmZzX3JkYXRhX2NhY2hlcCwgcmhkcik7CiB9
CiAKQEAgLTEwOCw2ICsxMTAsMTQgQEAgdm9pZCBuZnNfcGFnZWlvX3Jlc2V0X3JlYWRfbWRzKHN0
cnVjdCBuZnNfcGFnZWlvX2Rlc2NyaXB0b3IgKnBnaW8pCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChu
ZnNfcGFnZWlvX3Jlc2V0X3JlYWRfbWRzKTsKIAorYm9vbCBuZnNfcmVhZF9hbGxvY19zY3JhdGNo
KHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKmhkciwgc2l6ZV90IHNpemUpCit7CisJV0FSTl9PTiho
ZHItPnJlcy5zY3JhdGNoICE9IE5VTEwpOworCWhkci0+cmVzLnNjcmF0Y2ggPSBrbWFsbG9jKHNp
emUsIEdGUF9LRVJORUwpOworCXJldHVybiBoZHItPnJlcy5zY3JhdGNoICE9IE5VTEw7Cit9CitF
WFBPUlRfU1lNQk9MX0dQTChuZnNfcmVhZF9hbGxvY19zY3JhdGNoKTsKKwogc3RhdGljIHZvaWQg
bmZzX3JlYWRwYWdlX3JlbGVhc2Uoc3RydWN0IG5mc19wYWdlICpyZXEsIGludCBlcnJvcikKIHsK
IAlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gbmZzX3BhZ2VfdG9fZm9saW8ocmVxKTsKLS0gCjIuNDEu
MAoK
--0000000000000c16e605ff21343b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0002-NFSv4.2-Fix-READ_PLUS-size-calculations.patch"
Content-Disposition: attachment; 
	filename="v4-0002-NFSv4.2-Fix-READ_PLUS-size-calculations.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljenf84x2>
X-Attachment-Id: f_ljenf84x2

RnJvbSBlYzk3ZjQ2OWNlNjU2MGFlNjk1YTk0YWRkZmJhZWI2ZDQ2ODkxM2JiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogV2VkLCAzMSBNYXkgMjAyMyAxNzowMjo1NCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggdjQgMi80XSBORlN2NC4yOiBGaXggUkVBRF9QTFVTIHNpemUgY2FsY3VsYXRpb25zCgpJIGJ1
bXAgdGhlIGRlY29kZV9yZWFkX3BsdXNfbWF4c3ogdG8gYWNjb3VudCBmb3IgaG9sZSBzZWdtZW50
cywgYnV0IEkKbmVlZCB0byBzdWJ0cmFjdCBvdXQgdGhpcyBpbmNyZWFzZSB3aGVuIGNhbGxpbmcK
cnBjX3ByZXBhcmVfcmVwbHlfcGFnZXMoKSBzbyB0aGUgY29tbW9uIGNhc2Ugb2Ygc2luZ2xlIGRh
dGEgc2VnbWVudApyZXBsaWVzIGNhbiBiZSBkaXJlY3RseSBwbGFjZWQgaW50byB0aGUgeGRyIHBh
Z2VzIHdpdGhvdXQgbmVlZGluZyB0byBiZQpzaGlmdGVkIGFyb3VuZC4KClJlcG9ydGVkLWJ5OiBD
aHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4KRml4ZXM6IGQzYjAwYTgwMmM4NDUg
KCJORlM6IFJlcGxhY2UgdGhlIFJFQURfUExVUyBkZWNvZGluZyBjb2RlIikKU2lnbmVkLW9mZi1i
eTogQW5uYSBTY2h1bWFrZXIgPEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+Ci0tLQogZnMvbmZz
L25mczQyeGRyLmMgfCAxMiArKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczQyeGRyLmMgYi9m
cy9uZnMvbmZzNDJ4ZHIuYwppbmRleCBlZjNiMTUwOTcwZmYuLjc1NzY1MzgyY2MwZSAxMDA2NDQK
LS0tIGEvZnMvbmZzL25mczQyeGRyLmMKKysrIGIvZnMvbmZzL25mczQyeGRyLmMKQEAgLTUxLDEw
ICs1MSwxNiBAQAogCQkJCQkoMSAvKiBkYXRhX2NvbnRlbnQ0ICovICsgXAogCQkJCQkgMiAvKiBk
YXRhX2luZm80LmRpX29mZnNldCAqLyArIFwKIAkJCQkJIDEgLyogZGF0YV9pbmZvNC5kaV9sZW5n
dGggKi8pCisjZGVmaW5lIE5GUzQyX1JFQURfUExVU19IT0xFX1NFR01FTlRfU0laRSBcCisJCQkJ
CSgxIC8qIGRhdGFfY29udGVudDQgKi8gKyBcCisJCQkJCSAyIC8qIGRhdGFfaW5mbzQuZGlfb2Zm
c2V0ICovICsgXAorCQkJCQkgMiAvKiBkYXRhX2luZm80LmRpX2xlbmd0aCAqLykKKyNkZWZpbmUg
UkVBRF9QTFVTX1NFR01FTlRfU0laRV9ESUZGCShORlM0Ml9SRUFEX1BMVVNfSE9MRV9TRUdNRU5U
X1NJWkUgLSBcCisJCQkJCSBORlM0Ml9SRUFEX1BMVVNfREFUQV9TRUdNRU5UX1NJWkUpCiAjZGVm
aW5lIGRlY29kZV9yZWFkX3BsdXNfbWF4c3oJCShvcF9kZWNvZGVfaGRyX21heHN6ICsgXAogCQkJ
CQkgMSAvKiBycHJfZW9mICovICsgXAogCQkJCQkgMSAvKiBycHJfY29udGVudHMgY291bnQgKi8g
KyBcCi0JCQkJCSBORlM0Ml9SRUFEX1BMVVNfREFUQV9TRUdNRU5UX1NJWkUpCisJCQkJCSBORlM0
Ml9SRUFEX1BMVVNfSE9MRV9TRUdNRU5UX1NJWkUpCiAjZGVmaW5lIGVuY29kZV9zZWVrX21heHN6
CQkob3BfZW5jb2RlX2hkcl9tYXhzeiArIFwKIAkJCQkJIGVuY29kZV9zdGF0ZWlkX21heHN6ICsg
XAogCQkJCQkgMiAvKiBvZmZzZXQgKi8gKyBcCkBAIC03ODEsOCArNzg3LDggQEAgc3RhdGljIHZv
aWQgbmZzNF94ZHJfZW5jX3JlYWRfcGx1cyhzdHJ1Y3QgcnBjX3Jxc3QgKnJlcSwKIAllbmNvZGVf
cHV0ZmgoeGRyLCBhcmdzLT5maCwgJmhkcik7CiAJZW5jb2RlX3JlYWRfcGx1cyh4ZHIsIGFyZ3Ms
ICZoZHIpOwogCi0JcnBjX3ByZXBhcmVfcmVwbHlfcGFnZXMocmVxLCBhcmdzLT5wYWdlcywgYXJn
cy0+cGdiYXNlLAotCQkJCWFyZ3MtPmNvdW50LCBoZHIucmVwbGVuKTsKKwlycGNfcHJlcGFyZV9y
ZXBseV9wYWdlcyhyZXEsIGFyZ3MtPnBhZ2VzLCBhcmdzLT5wZ2Jhc2UsIGFyZ3MtPmNvdW50LAor
CQkJCWhkci5yZXBsZW4gLSBSRUFEX1BMVVNfU0VHTUVOVF9TSVpFX0RJRkYpOwogCWVuY29kZV9u
b3BzKCZoZHIpOwogfQogCi0tIAoyLjQxLjAKCg==
--0000000000000c16e605ff21343b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0001-NFSv4.2-Fix-READ_PLUS-smatch-warnings.patch"
Content-Disposition: attachment; 
	filename="v4-0001-NFSv4.2-Fix-READ_PLUS-smatch-warnings.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljenf84y3>
X-Attachment-Id: f_ljenf84y3

RnJvbSBlMzNmMjIwMjA1NWI1MDgxNTk5MDEzNGM4MGI0NjgwYmI4MGY4MTllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogV2VkLCAyNCBNYXkgMjAyMyAxNzoyNzowOCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggdjQgMS80XSBORlN2NC4yOiBGaXggUkVBRF9QTFVTIHNtYXRjaCB3YXJuaW5ncwoKU21hdGNo
IHJlcG9ydHM6CiAgZnMvbmZzL25mczQyeGRyLmM6MTEzMSBkZWNvZGVfcmVhZF9wbHVzKCkgd2Fy
bjogbWlzc2luZyBlcnJvciBjb2RlPyAnc3RhdHVzJwoKV2hpY2ggRGFuIHN1Z2dlc3RzIHRvIGZp
eCBieSBkb2luZyBhIGhhcmRjb2RlZCAicmV0dXJuIDAiIGZyb20gdGhlCiJpZiAoc2VnbWVudHMg
PT0gMCkiIGNoZWNrLgoKQWRkaXRpb25hbGx5LCBzbWF0Y2ggcmVwb3J0cyB0aGF0IHRoZSAic3Rh
dHVzID0gLUVJTyIgYXNzaWdubWVudCBpcyBub3QKdXNlZC4gVGhpcyBwYXRjaCBhZGRyZXNzZXMg
Ym90aCB0aGVzZSBpc3N1ZXMuCgpSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+ClJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxlcnJvcjI3QGdtYWlsLmNvbT4K
Q2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNTIyMjIwOS42bDVWTTJsTC1s
a3BAaW50ZWwuY29tLwpGaXhlczogZDNiMDBhODAyYzg0NSAoIk5GUzogUmVwbGFjZSB0aGUgUkVB
RF9QTFVTIGRlY29kaW5nIGNvZGUiKQpTaWduZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5u
YS5TY2h1bWFrZXJATmV0YXBwLmNvbT4KLS0tCiBmcy9uZnMvbmZzNDJ4ZHIuYyB8IDMgKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvbmZzL25mczQyeGRyLmMgYi9mcy9uZnMvbmZzNDJ4ZHIuYwppbmRleCBhNmRmODE1YTE0
MGMuLmVmM2IxNTA5NzBmZiAxMDA2NDQKLS0tIGEvZnMvbmZzL25mczQyeGRyLmMKKysrIGIvZnMv
bmZzL25mczQyeGRyLmMKQEAgLTExMzYsMTMgKzExMzYsMTIgQEAgc3RhdGljIGludCBkZWNvZGVf
cmVhZF9wbHVzKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHN0cnVjdCBuZnNfcGdpb19yZXMgKnJl
cykKIAlyZXMtPmVvZiA9IGJlMzJfdG9fY3B1cChwKyspOwogCXNlZ21lbnRzID0gYmUzMl90b19j
cHVwKHArKyk7CiAJaWYgKHNlZ21lbnRzID09IDApCi0JCXJldHVybiBzdGF0dXM7CisJCXJldHVy
biAwOwogCiAJc2VncyA9IGttYWxsb2NfYXJyYXkoc2VnbWVudHMsIHNpemVvZigqc2VncyksIEdG
UF9LRVJORUwpOwogCWlmICghc2VncykKIAkJcmV0dXJuIC1FTk9NRU07CiAKLQlzdGF0dXMgPSAt
RUlPOwogCWZvciAoaSA9IDA7IGkgPCBzZWdtZW50czsgaSsrKSB7CiAJCXN0YXR1cyA9IGRlY29k
ZV9yZWFkX3BsdXNfc2VnbWVudCh4ZHIsICZzZWdzW2ldKTsKIAkJaWYgKHN0YXR1cyA8IDApCi0t
IAoyLjQxLjAKCg==
--0000000000000c16e605ff21343b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v4-0004-SUNRPC-kmap-the-xdr-pages-during-decode.patch"
Content-Disposition: attachment; 
	filename="v4-0004-SUNRPC-kmap-the-xdr-pages-during-decode.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljenf84r0>
X-Attachment-Id: f_ljenf84r0

RnJvbSA0ZjMyMjAyOTQ4OGY5NzIxODM2ZGUzYTQ3ODg4OWM3YzUyM2UxZjk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogRnJpLCAyMyBKdW4gMjAyMyAxMTo0MzoxNCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggdjQgNC80XSBTVU5SUEM6IGttYXAoKSB0aGUgeGRyIHBhZ2VzIGR1cmluZyBkZWNvZGUKCklm
IHRoZSBwYWdlcyBhcmUgaW4gSElHSE1FTSB0aGVuIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoZXkn
cmUgbWFwcGVkCmJlZm9yZSB0cnlpbmcgdG8gcmVhZCBkYXRhIG9mZiBvZiB0aGVtLCBvdGhlcndp
c2Ugd2UgY291bGQgZW5kIHVwIHdpdGggYQpOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuCgpSZXBv
cnRlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8u
b3JnPgpTaWduZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3N1bnJwYy94ZHIuaCB8ICAyICsrCiBuZXQvc3VucnBj
L2NsbnQuYyAgICAgICAgICB8ICAxICsKIG5ldC9zdW5ycGMveGRyLmMgICAgICAgICAgIHwgMTcg
KysrKysrKysrKysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIGIvaW5j
bHVkZS9saW51eC9zdW5ycGMveGRyLmgKaW5kZXggZDkxNzYxOGEzMDU4Li5mNTYyYWFiNDY4ZjUg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvc3VucnBjL3hkci5oCkBAIC0yMjgsNiArMjI4LDcgQEAgc3RydWN0IHhkcl9zdHJlYW0gewog
CXN0cnVjdCBrdmVjICppb3Y7CS8qIHBvaW50ZXIgdG8gdGhlIGN1cnJlbnQga3ZlYyAqLwogCXN0
cnVjdCBrdmVjIHNjcmF0Y2g7CS8qIFNjcmF0Y2ggYnVmZmVyICovCiAJc3RydWN0IHBhZ2UgKipw
YWdlX3B0cjsJLyogcG9pbnRlciB0byB0aGUgY3VycmVudCBwYWdlICovCisJdm9pZCAqcGFnZV9r
YWRkcjsJLyoga21hcHBlZCBhZGRyZXNzIG9mIHRoZSBjdXJyZW50IHBhZ2UgKi8KIAl1bnNpZ25l
ZCBpbnQgbndvcmRzOwkvKiBSZW1haW5pbmcgZGVjb2RlIGJ1ZmZlciBsZW5ndGggKi8KIAogCXN0
cnVjdCBycGNfcnFzdCAqcnFzdDsJLyogRm9yIGRlYnVnZ2luZyAqLwpAQCAtMjU0LDYgKzI1NSw3
IEBAIGV4dGVybiB2b2lkIHhkcl90cnVuY2F0ZV9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhk
ciwgc2l6ZV90IGxlbik7CiBleHRlcm4gaW50IHhkcl9yZXN0cmljdF9idWZsZW4oc3RydWN0IHhk
cl9zdHJlYW0gKnhkciwgaW50IG5ld2J1Zmxlbik7CiBleHRlcm4gdm9pZCB4ZHJfd3JpdGVfcGFn
ZXMoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IHBhZ2UgKipwYWdlcywKIAkJdW5zaWdu
ZWQgaW50IGJhc2UsIHVuc2lnbmVkIGludCBsZW4pOworZXh0ZXJuIHZvaWQgeGRyX3N0cmVhbV91
bm1hcF9jdXJyZW50X3BhZ2Uoc3RydWN0IHhkcl9zdHJlYW0gKnhkcik7CiBleHRlcm4gdW5zaWdu
ZWQgaW50IHhkcl9zdHJlYW1fcG9zKGNvbnN0IHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIpOwogZXh0
ZXJuIHVuc2lnbmVkIGludCB4ZHJfcGFnZV9wb3MoY29uc3Qgc3RydWN0IHhkcl9zdHJlYW0gKnhk
cik7CiBleHRlcm4gdm9pZCB4ZHJfaW5pdF9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwg
c3RydWN0IHhkcl9idWYgKmJ1ZiwKZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0
L3N1bnJwYy9jbG50LmMKaW5kZXggZDJlZTU2NjM0MzA4Li4zYjdlNjc2ZDg5MzUgMTAwNjQ0Ci0t
LSBhL25ldC9zdW5ycGMvY2xudC5jCisrKyBiL25ldC9zdW5ycGMvY2xudC5jCkBAIC0yNTkwLDYg
KzI1OTAsNyBAQCBjYWxsX2RlY29kZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spCiAJY2FzZSAwOgog
CQl0YXNrLT50a19hY3Rpb24gPSBycGNfZXhpdF90YXNrOwogCQl0YXNrLT50a19zdGF0dXMgPSBy
cGNhdXRoX3Vud3JhcF9yZXNwKHRhc2ssICZ4ZHIpOworCQl4ZHJfc3RyZWFtX3VubWFwX2N1cnJl
bnRfcGFnZSgmeGRyKTsKIAkJcmV0dXJuOwogCWNhc2UgLUVBR0FJTjoKIAkJdGFzay0+dGtfc3Rh
dHVzID0gMDsKZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveGRyLmMgYi9uZXQvc3VucnBjL3hkci5j
CmluZGV4IDM5MWIzMzZkOTdkZS4uZmI1MjAzMzM3NjA4IDEwMDY0NAotLS0gYS9uZXQvc3VucnBj
L3hkci5jCisrKyBiL25ldC9zdW5ycGMveGRyLmMKQEAgLTEzMDgsNiArMTMwOCwxNCBAQCBzdGF0
aWMgdW5zaWduZWQgaW50IHhkcl9zZXRfdGFpbF9iYXNlKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIs
CiAJcmV0dXJuIHhkcl9zZXRfaW92KHhkciwgYnVmLT50YWlsLCBiYXNlLCBsZW4pOwogfQogCit2
b2lkIHhkcl9zdHJlYW1fdW5tYXBfY3VycmVudF9wYWdlKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIp
Cit7CisJaWYgKHhkci0+cGFnZV9rYWRkcikgeworCQlrdW5tYXBfbG9jYWwoeGRyLT5wYWdlX2th
ZGRyKTsKKwkJeGRyLT5wYWdlX2thZGRyID0gTlVMTDsKKwl9Cit9CisKIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgeGRyX3NldF9wYWdlX2Jhc2Uoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwKIAkJCQkgICAg
ICB1bnNpZ25lZCBpbnQgYmFzZSwgdW5zaWduZWQgaW50IGxlbikKIHsKQEAgLTEzMjUsMTIgKzEz
MzMsMTggQEAgc3RhdGljIHVuc2lnbmVkIGludCB4ZHJfc2V0X3BhZ2VfYmFzZShzdHJ1Y3QgeGRy
X3N0cmVhbSAqeGRyLAogCWlmIChsZW4gPiBtYXhsZW4pCiAJCWxlbiA9IG1heGxlbjsKIAorCXhk
cl9zdHJlYW1fdW5tYXBfY3VycmVudF9wYWdlKHhkcik7CiAJeGRyX3N0cmVhbV9wYWdlX3NldF9w
b3MoeGRyLCBiYXNlKTsKIAliYXNlICs9IHhkci0+YnVmLT5wYWdlX2Jhc2U7CiAKIAlwZ25yID0g
YmFzZSA+PiBQQUdFX1NISUZUOwogCXhkci0+cGFnZV9wdHIgPSAmeGRyLT5idWYtPnBhZ2VzW3Bn
bnJdOwotCWthZGRyID0gcGFnZV9hZGRyZXNzKCp4ZHItPnBhZ2VfcHRyKTsKKworCWlmIChQYWdl
SGlnaE1lbSgqeGRyLT5wYWdlX3B0cikpIHsKKwkJeGRyLT5wYWdlX2thZGRyID0ga21hcF9sb2Nh
bF9wYWdlKCp4ZHItPnBhZ2VfcHRyKTsKKwkJa2FkZHIgPSB4ZHItPnBhZ2Vfa2FkZHI7CisJfSBl
bHNlCisJCWthZGRyID0gcGFnZV9hZGRyZXNzKCp4ZHItPnBhZ2VfcHRyKTsKIAogCXBnb2ZmID0g
YmFzZSAmIH5QQUdFX01BU0s7CiAJeGRyLT5wID0gKF9fYmUzMiopKGthZGRyICsgcGdvZmYpOwpA
QCAtMTM4NCw2ICsxMzk4LDcgQEAgdm9pZCB4ZHJfaW5pdF9kZWNvZGUoc3RydWN0IHhkcl9zdHJl
YW0gKnhkciwgc3RydWN0IHhkcl9idWYgKmJ1ZiwgX19iZTMyICpwLAogCQkgICAgIHN0cnVjdCBy
cGNfcnFzdCAqcnFzdCkKIHsKIAl4ZHItPmJ1ZiA9IGJ1ZjsKKwl4ZHItPnBhZ2Vfa2FkZHIgPSBO
VUxMOwogCXhkcl9yZXNldF9zY3JhdGNoX2J1ZmZlcih4ZHIpOwogCXhkci0+bndvcmRzID0gWERS
X1FVQURMRU4oYnVmLT5sZW4pOwogCWlmICh4ZHJfc2V0X2lvdih4ZHIsIGJ1Zi0+aGVhZCwgMCwg
YnVmLT5sZW4pID09IDAgJiYKLS0gCjIuNDEuMAoK
--0000000000000c16e605ff21343b--
