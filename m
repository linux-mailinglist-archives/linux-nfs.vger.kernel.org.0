Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F47E00AB
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbjKCJl2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347156AbjKCJl1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 05:41:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBB1BD
        for <linux-nfs@vger.kernel.org>; Fri,  3 Nov 2023 02:41:21 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c011e113so22522197b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Nov 2023 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1699004480; x=1699609280; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bb+WAsmU3lZ7yuKWHjH5niNuFTepOFprQ1V4XLarmGM=;
        b=GoMdei38gSqCYFoH+wEboi5+YLUWa/Dh23el4PWjQvdjJSjn++yOudf2m1+SYCg66R
         golSu1oRsuvcXclVUX6vaO3MlBTslWKBC/4tP95c1+1aFjfCWbtw+fYwWbz/yOD2Lujr
         AqVsB8HPs7TQaUX35GGXHZlDKXDsDka228JtAjUfyo48M7F4DICK+5sbzKBlII0PQ4rj
         OFpl0878mnUyB1EWQooxfFOyQm+2X7oJrsv52Zc88z5PLvxkn1YaR4T63cVUJ4OJVO87
         9g61awQOfSJdThMUb21jhTK+0++puuFu8TM2Hb6DXr3YE9QRLP00cvfG03pP66P1z/WR
         OpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699004480; x=1699609280;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb+WAsmU3lZ7yuKWHjH5niNuFTepOFprQ1V4XLarmGM=;
        b=F14FzFwg/lFpnHWHC75/7BI5zg1axTk7oXW0s5y4b1VlW9qxPY/5WuRSX++BySY8tB
         eEAueHn6+aLcqqB7ZCm5UvMxSm42CJb1Kz6/NIYRXYAU7dsQKbJJUI/41AozxIk1YGCY
         HHZq31kmOvZLoTsphWngsITT1l3hczDTQxvvxcr0/IMpFUtk726mVFhhnZh0cIzEQjiK
         kgxrZfC4tXJove9maMfHa55XrZtps3FzgLvhBPij/SFwUEHndF3s5PBNdY3w82RkjZvx
         fOWioUNaTE0fxjtqpA3M+9t+pHj4tLaWYJI0AOrkqJ4zdhkC1tSJcqkHxq3aTPcRm8R3
         EqiQ==
X-Gm-Message-State: AOJu0YzOEiKaRTKnDgltBtNeuHM83J9ArMCcTKaUXWfe7Dj/qpswupW9
        O11PSJAZgeK+oV09jCVkvdh+aj03uiSLt3Ck51RdZDGeX/npfCzdM4U=
X-Google-Smtp-Source: AGHT+IFS7e03ds3wiV9jYtdrOzyXtMlbOudf2prR10cbc3YpsDVqKmGAiKExiy40w87a/CxONpItqLaJLOeBIfiXl6o=
X-Received: by 2002:a81:5290:0:b0:59b:f8da:ffdb with SMTP id
 g138-20020a815290000000b0059bf8daffdbmr2224862ywb.29.1699004480205; Fri, 03
 Nov 2023 02:41:20 -0700 (PDT)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 3 Nov 2023 09:40:44 +0000
Message-ID: <CAPt2mGNPSi-+3WdeMsOjkJ2vOqZcRE2S6i=eqi+UA2RmzywAyg@mail.gmail.com>
Subject: autofs mount/umount hangs with recent kernel?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

We have large compute clusters that, amongst other things, spend their
day mounting & unounting lots of Linux NFS servers via autofs. This
has worked fine for many years and client kernel versions and was
working without incident even with our current v6.3.x production
kernels.

During the v6.6-rc cycle while testing that kernel, I noticed that
every now and then, the umount/mount would hang randomly and the
compute host would get stuck and not complete it's work until a
reboot. I thought I'd wait until v6.6 was released and check again -
the issue persists.

I have not had the opportunity to test the v6.4 & v6.5 kernels in
between yet. The stack traces look something like this:

[202752.264187] INFO: task umount.nfs:58118 blocked for more than 245 seconds.
[202752.264237]       Tainted: G            E      6.6.0-1.dneg.x86_64 #1
[202752.264267] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[202752.264296] task:umount.nfs      state:D stack:0     pid:58118
ppid:1      flags:0x00004002
[202752.264304] Call Trace:
[202752.264308]  <TASK>
[202752.264313]  __schedule+0x30b/0xa10
[202752.264327]  schedule+0x68/0xf0
[202752.264332]  io_schedule+0x16/0x40
[202752.264337]  __folio_lock+0xfc/0x220
[202752.264346]  ? srso_alias_return_thunk+0x5/0x7f
[202752.264353]  ? __pfx_wake_page_function+0x10/0x10
[202752.264361]  truncate_inode_pages_range+0x441/0x460
[202752.264411]  truncate_inode_pages_final+0x41/0x50
[202752.264425]  nfs_evict_inode+0x1a/0x40 [nfs]
[202752.264476]  evict+0xdc/0x190
[202752.264485]  dispose_list+0x4d/0x70
[202752.264491]  evict_inodes+0x16b/0x1b0
[202752.264499]  generic_shutdown_super+0x3e/0x160
[202752.264507]  kill_anon_super+0x17/0x50
[202752.264513]  nfs_kill_super+0x27/0x50 [nfs]
[202752.264556]  deactivate_locked_super+0x35/0x90
[202752.264562]  deactivate_super+0x42/0x50
[202752.264568]  cleanup_mnt+0x109/0x170
[202752.264574]  __cleanup_mnt+0x12/0x20
[202752.264580]  task_work_run+0x61/0x90
[202752.264588]  exit_to_user_mode_prepare+0x1d8/0x200
[202752.264596]  syscall_exit_to_user_mode+0x1c/0x40
[202752.264603]  do_syscall_64+0x48/0x90
[202752.264609]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[202752.264617] RIP: 0033:0x7fcb9befeba7
[202752.264622] RSP: 002b:00007ffdd63ef348 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[202752.264628] RAX: 0000000000000000 RBX: 00005561e35da010 RCX:
00007fcb9befeba7
[202752.264632] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
00005561e35da1e0
[202752.264634] RBP: 00005561e35da1e0 R08: 00005561e35dbfa0 R09:
00005561e35db790
[202752.264637] R10: 00007ffdd63eeda0 R11: 0000000000000246 R12:
00007fcb9c442d78
[202752.264640] R13: 0000000000000000 R14: 00005561e35db2c0 R15:
00007ffdd63f0dcb
[202752.264648]  </TASK>

[202752.264658] INFO: task mount.nfs:60827 blocked for more than 122 seconds.
[202752.264686]       Tainted: G            E      6.6.0-1.dneg.x86_64 #1
[202752.264713] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[202752.264743] task:mount.nfs       state:D stack:0     pid:60827
ppid:60826  flags:0x00004000
[202752.264751] Call Trace:
[202752.264753]  <TASK>
[202752.264757]  __schedule+0x30b/0xa10
[202752.264763]  ? srso_alias_return_thunk+0x5/0x7f
[202752.264771]  schedule+0x68/0xf0
[202752.264776]  schedule_preempt_disabled+0x15/0x30
[202752.264782]  rwsem_down_write_slowpath+0x2b3/0x640
[202752.264788]  ? try_to_wake_up+0x242/0x5f0
[202752.264797]  ? __x86_indirect_jump_thunk_r15+0x20/0x20
[202752.264803]  ? wake_up_q+0x50/0x90
[202752.264809]  down_write+0x55/0x70
[202752.264815]  super_lock+0x44/0x130
[202752.264821]  ? kernfs_activate+0x54/0x60
[202752.264828]  ? srso_alias_return_thunk+0x5/0x7f
[202752.264833]  ? kernfs_add_one+0x11f/0x160
[202752.264841]  grab_super+0x2e/0x80
[202752.264847]  grab_super_dead+0x31/0xe0
[202752.264855]  ? srso_alias_return_thunk+0x5/0x7f
[202752.264860]  ? sysfs_create_link_nowarn+0x22/0x40
[202752.264865]  ? srso_alias_return_thunk+0x5/0x7f
[202752.264871]  ? __pfx_nfs_compare_super+0x10/0x10 [nfs]
[202752.264915]  sget_fc+0xd4/0x280
[202752.264921]  ? __pfx_nfs_set_super+0x10/0x10 [nfs]
[202752.264965]  nfs_get_tree_common+0x86/0x520 [nfs]
[202752.265009]  nfs_try_get_tree+0x5c/0x2e0 [nfs]
[202752.265052]  ? srso_alias_return_thunk+0x5/0x7f
[202752.265058]  ? try_module_get+0x1d/0x30
[202752.265064]  ? srso_alias_return_thunk+0x5/0x7f
[202752.265068]  ? get_nfs_version+0x29/0x90 [nfs]
[202752.265111]  ? srso_alias_return_thunk+0x5/0x7f
[202752.265116]  ? nfs_fs_context_validate+0x4fe/0x710 [nfs]
[202752.265163]  nfs_get_tree+0x38/0x60 [nfs]
[202752.265202]  vfs_get_tree+0x2a/0xe0
[202752.265207]  ? capable+0x19/0x20
[202752.265213]  path_mount+0x2fe/0xa90
[202752.265219]  ? putname+0x55/0x70
[202752.265226]  do_mount+0x80/0xa0
[202752.265233]  __x64_sys_mount+0x8b/0xe0
[202752.265240]  do_syscall_64+0x3b/0x90
[202752.265245]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[202752.265250] RIP: 0033:0x7fbf5d4ff26a
[202752.265253] RSP: 002b:00007ffeb24fdd98 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[202752.265258] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fbf5d4ff26a
[202752.265261] RDX: 000055c814e78100 RSI: 000055c814e771e0 RDI:
000055c814e77320
[202752.265264] RBP: 00007ffeb24fdfb0 R08: 000055c814e85510 R09:
000000000000006d
[202752.265266] R10: 0000000000000004 R11: 0000000000000202 R12:
00007fbf5e2307e0
[202752.265269] R13: 00007ffeb24fdfb0 R14: 00007ffeb24fde90 R15:
000055c814e855a0
[202752.265277]  </TASK>

And like I said, the mount/umount against the server hangs
indefinitely on the client. It is somewhat interesting that autofs
still tries to trigger a subsequent mount even though the umount has
not completed.

The NFS servers are running RHEL8.5 and we are using NFSv3. I also
reproduced it with a fairly recent nfs-utils-2.6.2 on the client
compute hosts.

Because these happen quite rarely, it takes time and many clients and
mount/umount cycles to reproduce, so I thought I'd post here before
working through the bisect testing. If you think this is better as a
kernel.org bugzilla ticket, I'm happy to do that too.

Cheers,

Daire
