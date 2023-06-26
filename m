Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4173DC3A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZK2x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFZK2w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 06:28:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6919F
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 03:28:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso14650591fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jun 2023 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775329; x=1690367329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lz572HnALEln44pBSUu4MqGMZOi0QKj/j0OdazQnpuo=;
        b=XaY/8jZMyZCvA+jUc+Ujzz/gcGiKtgbQ3XPQZ7u5VRDqniGVNMWSO4lNPPrKWVWUof
         p/TugdgrmqH31AM7dztYUyfWfIq1+LOn2uLUFrOOjobwqDlnt+HlZJa9y/yGpfeQh87h
         1tO2o7LGvBGX640Iwe7gvQmhQM5I9dYUWmyOzmvjb4+CUsu2k5qG+DHh1Nxz5U+roGkU
         +fm+DVVaAcGUppB+99dDZ13z1MIHeKbhBlfO4zV18vWR8eaXl5bMWUkRhOafjVcT+4QX
         bQ/hvx+wavAo5oiAnvXolhOVbTMpyxErq4l52Abj6mYtiIBTTzLASItFjMFXTHfIsOOM
         8ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775329; x=1690367329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lz572HnALEln44pBSUu4MqGMZOi0QKj/j0OdazQnpuo=;
        b=XXJ5l3wdoht83lm/UWI5iPE1otYfLvfV4WpxhFWG0bVKb9GJz0ojOmzzRthPItkAQg
         xjfbLzNqn425f4HhqJ6l/GODCp92lojeoPeYS4fs+WvE6gEzZl0PFtfZot8V36IncV+X
         FX2pu9u2Ets1cmSHxi3s6vHDGUDoBYRrtw3p6Jb69Z20u8rhZAviT8sGRrgbi948WlAD
         QEp/h7UfjAKGnkzaXyVn+67X+i68qBsxGttbMzek3A3ylqXP2SiyP0GJC3th9ZWas0XW
         Ug9MW4qPTby0vqSNxpo3P/6+wW3eSp2taJq3n/yB9JR9pOckq7Ks8jp6gF14f/wVhwjq
         UDEQ==
X-Gm-Message-State: AC+VfDw/kly3XWv+10F/6glQTK/xcTfgkhEvkPmcEjAF/qpgUCfc4OJa
        iyWZfsZbBkLDq9BYBND17ODl2w==
X-Google-Smtp-Source: ACHHUZ41+/NuNyArXTiyJZD922WPa1lau7U9mJkUVsJTlvqE9gRJDNwvAnPeTA2ORBLB2ZNMSo55AQ==
X-Received: by 2002:a2e:a0d7:0:b0:2b5:947f:50b with SMTP id f23-20020a2ea0d7000000b002b5947f050bmr6420899ljm.39.1687775328770;
        Mon, 26 Jun 2023 03:28:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i23-20020a50fc17000000b0051c7b5692easm2668322edr.7.2023.06.26.03.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 03:28:48 -0700 (PDT)
Message-ID: <74b0dcc4-a061-715e-93c1-e010fbaa85fb@linaro.org>
Date:   Mon, 26 Jun 2023 12:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
 <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
 <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org>
 <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
 <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
 <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com>
 <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org>
 <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
 <dfcc114f-56f1-e4ab-7b36-f9a4ce3e8c8c@linaro.org>
 <CAFX2Jf=uaOC2oDceShnNNJdSeW-MNwh7N=Jh=S9zYjP_Ci-DuQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2Jf=uaOC2oDceShnNNJdSeW-MNwh7N=Jh=S9zYjP_Ci-DuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23/06/2023 19:59, Anna Schumaker wrote:
>>>>>>>
>>>>>>> Can you swap out yesterday's patch with this patch? I've adjusted what
>>>>>>> gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
>>>>>>> starting to think that the xdr scratch buffer is fine, and that it's
>>>>>>> the other pointer passed to memcpy() in that function that's the
>>>>>>> problem, and the output from this patch will confirm for me.
>>>>>>
>>>>>> Oh, and can you add this one on top of the v2 patch as well?
>>>>>
>>>>> Sorry about the noise today. Can you use this patch instead of the two
>>>>> I attached earlier? I cleaned up the output and cut down on extra
>>>>> output..
>>>>>
>>>>
>>>> Here you have - attached.
>>>
>>> This is good, thanks! I was finally able to figure out how to hit the
>>> bug using a 32bit x86 VM, so hopefully the next thing you hear from me
>>> is a patch fixing the bug!
> 
> I'm really hopeful that the attached patch finally fixes the issue.
> Can you try it and let me know?

Just test it yourself on 32-bit system... There is absolutely nothing
special in the system I reproduced it on. Nothing.


IP-Config: eth0 hardware address 00:1e:06:30:bf:ac mtu 1500
IP-Config: eth0 guessed broadcast address 192.168.1.255
IP-Config: eth0 complete (from 192.168.1.10):
 address: 192.168.1.12     broadcast: 192.168.1.255    netmask:
255.255.255.0
 gateway: 192.168.1.1      dns0     : 0.0.0.0          dns1   : 0.0.0.0

 rootserver: 192.168.1.10 rootpath:
 filename  :
NFS-Mount: 192.168.1.10:/srv/nfs/odroidhc1
Waiting 10 seconds for device /dev/nfs ...
ERROR: device '/dev/nfs' not found. Skipping fsck.
Mount cmd:
mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
[   21.800626] ------------[ cut here ]------------
[   21.803891] WARNING: CPU: 7 PID: 154 at mm/highmem.c:603
xdr_stream_unmap_current_page+0x18/0x24
[   21.812729] Modules linked in:
[   21.815642] CPU: 7 PID: 154 Comm: mount.nfs4 Not tainted
6.4.0-00001-gfbb103bb8df0 #8
[   21.823444] Hardware name: Samsung Exynos (Flattened Device Tree)
[   21.829525]  unwind_backtrace from show_stack+0x10/0x14
[   21.834698]  show_stack from dump_stack_lvl+0x58/0x70
[   21.839730]  dump_stack_lvl from __warn+0x7c/0x1bc
[   21.844491]  __warn from warn_slowpath_fmt+0xbc/0x1b8
[   21.849518]  warn_slowpath_fmt from
xdr_stream_unmap_current_page+0x18/0x24
[   21.856437]  xdr_stream_unmap_current_page from call_decode+0x210/0x2c8
[   21.863020]  call_decode from __rpc_execute+0xf8/0x764
[   21.868134]  __rpc_execute from rpc_execute+0xc0/0x1d0
[   21.873243]  rpc_execute from rpc_run_task+0x148/0x190
[   21.878348]  rpc_run_task from rpc_create_xprt+0x1a4/0x284
[   21.883805]  rpc_create_xprt from rpc_create+0xf8/0x254
[   21.889004]  rpc_create from nfs_create_rpc_client+0x150/0x17c
[   21.894812]  nfs_create_rpc_client from nfs4_alloc_client+0x360/0x374
[   21.901226]  nfs4_alloc_client from nfs_get_client+0x16c/0x3e8
[   21.907030]  nfs_get_client from nfs4_set_client+0xfc/0x1a4
[   21.912574]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
[   21.918554]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
[   21.924534]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
[   21.929993]  vfs_get_tree from path_mount+0x3e8/0xb04
[   21.935019]  path_mount from sys_mount+0x20c/0x254
[   21.939784]  sys_mount from ret_fast_syscall+0x0/0x1c
[   21.944809] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
[   21.949837] 9fa0:                   0047ebe0 00479c64 0047e960
0047e9b8 0047e9c8 00000000
[   21.957986] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
00000010 00479c64 00466bfc
[   21.966139] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
[   21.971245] irq event stamp: 0
[   21.974188] hardirqs last  enabled at (0): [<00000000>] 0x0
[   21.979736] hardirqs last disabled at (0): [<c012357c>]
copy_process+0x810/0x1ffc
[   21.987227] softirqs last  enabled at (0): [<c012357c>]
copy_process+0x810/0x1ffc
[   21.994679] softirqs last disabled at (0): [<00000000>] 0x0
[   22.000264] ---[ end trace 0000000000000000 ]---
[   22.004781] BUG: sleeping function called from invalid context at
net/sunrpc/sched.c:953
[   22.012876] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
154, name: mount.nfs4
[   22.020936] preempt_count: 1, expected: 0
[   22.024881] RCU nest depth: 0, expected: 0
[   22.028955] INFO: lockdep is turned off.
[   22.032889] CPU: 7 PID: 154 Comm: mount.nfs4 Tainted: G        W
    6.4.0-00001-gfbb103bb8df0 #8
[   22.042131] Hardware name: Samsung Exynos (Flattened Device Tree)
[   22.048196]  unwind_backtrace from show_stack+0x10/0x14
[   22.053393]  show_stack from dump_stack_lvl+0x58/0x70
[   22.058417]  dump_stack_lvl from __might_resched+0x194/0x260
[   22.064054]  __might_resched from __rpc_execute+0x118/0x764
[   22.069596]  __rpc_execute from rpc_execute+0xc0/0x1d0
[   22.074708]  rpc_execute from rpc_run_task+0x148/0x190
[   22.079821]  rpc_run_task from rpc_create_xprt+0x1a4/0x284
[   22.085281]  rpc_create_xprt from rpc_create+0xf8/0x254
[   22.090483]  rpc_create from nfs_create_rpc_client+0x150/0x17c
[   22.096286]  nfs_create_rpc_client from nfs4_alloc_client+0x360/0x374
[   22.102700]  nfs4_alloc_client from nfs_get_client+0x16c/0x3e8
[   22.108504]  nfs_get_client from nfs4_set_client+0xfc/0x1a4
[   22.114050]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
[   22.120029]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
[   22.126009]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
[   22.131467]  vfs_get_tree from path_mount+0x3e8/0xb04
[   22.136493]  path_mount from sys_mount+0x20c/0x254
[   22.141258]  sys_mount from ret_fast_syscall+0x0/0x1c
[   22.146284] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
[   22.151322] 9fa0:                   0047ebe0 00479c64 0047e960
0047e9b8 0047e9c8 00000000
[   22.159461] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
00000010 00479c64 00466bfc
[   22.167606] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
[   22.172820] BUG: scheduling while atomic: mount.nfs4/154/0x00000002
[   22.178871] INFO: lockdep is turned off.
[   22.182803] Modules linked in:
[   22.185798] CPU: 7 PID: 154 Comm: mount.nfs4 Tainted: G        W
    6.4.0-00001-gfbb103bb8df0 #8
[   22.195076] Hardware name: Samsung Exynos (Flattened Device Tree)
[   22.201139]  unwind_backtrace from show_stack+0x10/0x14
[   22.206337]  show_stack from dump_stack_lvl+0x58/0x70
[   22.211365]  dump_stack_lvl from __schedule_bug+0x70/0x84
[   22.216736]  __schedule_bug from __schedule+0x9c0/0xc80
[   22.221936]  __schedule from schedule+0x58/0xf8
[   22.226439]  schedule from schedule_timeout+0x134/0x200
[   22.231641]  schedule_timeout from __wait_for_common+0xac/0x1f8
[   22.237533]  __wait_for_common from
wait_for_completion_killable+0x18/0x24
[   22.244379]  wait_for_completion_killable from
__kthread_create_on_node+0xe0/0x168
[   22.251923]  __kthread_create_on_node from
kthread_create_on_node+0x30/0x60
[   22.258851]  kthread_create_on_node from svc_set_num_threads+0x1c8/0x420
[   22.265525]  svc_set_num_threads from nfs_callback_up+0x150/0x3c0
[   22.271597]  nfs_callback_up from nfs4_init_client+0x98/0x144
[   22.277306]  nfs4_init_client from nfs4_set_client+0xfc/0x1a4
[   22.283026]  nfs4_set_client from nfs4_create_server+0x11c/0x2fc
[   22.289005]  nfs4_create_server from nfs4_try_get_tree+0x10/0x50
[   22.294985]  nfs4_try_get_tree from vfs_get_tree+0x24/0xe4
[   22.300444]  vfs_get_tree from path_mount+0x3e8/0xb04
[   22.305468]  path_mount from sys_mount+0x20c/0x254
[   22.310249]  sys_mount from ret_fast_syscall+0x0/0x1c
[   22.315261] Exception stack(0xf0cf9fa8 to 0xf0cf9ff0)
[   22.320300] 9fa0:                   0047ebe0 00479c64 0047e960
0047e9b8 0047e9c8 00000000
[   22.328438] 9fc0: 0047ebe0 00479c64 b6f058c8 00000015 00466c08
00000010 00479c64 00466bfc
[   22.336582] 9fe0: 00479e70 befb69b0 0045a708 b6dca610
:: running cleanup hook [udev]
[   26.235349] systemd[1]: System time before build time, advancing clock.
[   26.435536] systemd[1]: systemd 253.4-1-arch running in system mode
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
+LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT
default-hierarchy=unified)
[   26.466749] systemd[1]: Detected architecture arm.



Best regards,
Krzysztof

