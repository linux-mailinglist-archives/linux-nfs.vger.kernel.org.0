Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E874580E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jul 2023 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGCJFy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 05:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGCJFu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 05:05:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058810F6
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 02:05:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so1588475f8f.3
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jul 2023 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=visionect.com; s=google; t=1688375136; x=1690967136;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B20YlSwDM2sv0i/s8duTsiZbKOXm9eoXo1flPEIDzBI=;
        b=E0iHPXhujXagtLEeVKV7Tv2PcSSc9YOl8qFH2BOxYxke1Fg5WGlsQomAGRECQd40te
         7Iy+40gfg5CCzqqCvhj7qdQ0KQFvoenrgfJyEjk7ytAW2ZNfz9Eprk5vFGPwi1naS9hM
         FQ8M22YbdRWowJHl9QYQZOzkN9521Eser69tL0Kbt6ZlP/A+Lx6B/z/QemepEDYr/jZR
         NC7qmSColFHtEbEyaHbgA74EkJTjKow9c7s5Eh/bIoOeTtYccYaHoxfelps9eZ/pSL1z
         G/3gu9WMWK51iJxuBvJD9cbfdN9IKFXErA+UZ15yPuJsdcDa/jNQ/Afz3vcIp/rcil//
         PlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375136; x=1690967136;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B20YlSwDM2sv0i/s8duTsiZbKOXm9eoXo1flPEIDzBI=;
        b=Vf4rZfYVOIGNW+WjiIi0q4oM7wNy85zhBT9uZsYhWEkRF2IM1//uG/hIgOBNDQxr/z
         +lBoYRaCAkUPT50PMH/qveo+HE8L+uhlWAbb4Nvkl/VgEflE0VorEMVznKfAXAs0M3D4
         ReB6Jop297nP/qWYht7PJpDueBLqT8OEqkX8xJpAcU6EkuCyhUcx9u5QhqaLUlhbaPLN
         LPEmZKJTXm6HYpsvGMGXncXzYIBQNQP5kfmXUmWBhwgKf98M+vDS69NjyrtgSmW2cJQp
         qPFDJP//wAoRiAPoXoG5FhXQjJ4cPFit/CX1wP+ZEahDZ8M4YrrxgpSdRbflAq/BbjX7
         arnQ==
X-Gm-Message-State: ABy/qLbIvDGVRw5hwfGySk5WFq+wsc2kfo3GuMrC/Wt+u+DzRcmYQu+3
        Ka3nMTuyubz2rghRDI+TyQSqzlqZRD9JZL2N7+bup4ZgPfMBG8XDLmH8Kw==
X-Google-Smtp-Source: APBJJlGWQjizL+SVE7krKpdtlvGOzdv+knyIDW6orsst5lM19735GRCTn7XvV2mS9nKbOop+EPlNYfuyNbxk8bcCZa0=
X-Received: by 2002:adf:f642:0:b0:313:ea84:147a with SMTP id
 x2-20020adff642000000b00313ea84147amr7150563wrp.64.1688375136127; Mon, 03 Jul
 2023 02:05:36 -0700 (PDT)
MIME-Version: 1.0
From:   Miha Vrhovnik <miha.vrhovnik@visionect.com>
Date:   Mon, 3 Jul 2023 11:05:21 +0200
Message-ID: <CANbXbTt=smOsgJZHCkk8O0EzB+nBd=a7a40my9w59UKTtka0fg@mail.gmail.com>
Subject: nfsd in D state, another case
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey everybody,

we are experiencing a similar issue to Dr. Herzog [1]. the details and
our configuration is a bit different than his, but I'd assume that the
same bug is behind this.

It's a single server per region, with NFS is on local storage formatted as ext4.
The servers don't have a swap and have plenty of free memory. 16G-20G
used (without caches) out of 64G.
The amount of data stored is rather small about 1G, with about 100.000
files over 17.000 directories

We've upgraded the servers from Ubuntu 20.04 to Ubuntu 22.04 about a
month ago and we had four outages since than.Our clients are still on
Ubuntu 20.04 if this helps
Our setup is rather small.But the impacts aprox. 10.000 users per region.

And the packages in Ubuntu 22.04 are a bit older than the ones in
Debian 12 (bookworm )

apt list --installed '*nfs*'
Listing... Done
libnfsidmap1/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed,automatic]
nfs-common/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed]
nfs-kernel-server/jammy-updates,now 1:2.6.1-1ubuntu1.2 amd64 [installed]

and the kernel
Linux redacted 5.19.0-1026-gcp #28~22.04.1-Ubuntu SMP Tue Jun 6
07:24:26 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

Stack-trace is a different from the one provided by Dr. Herzog. But
the same between servers.
so only full server restart helps. And once this happened almost
immediately after the server was rebooted.

This is the first time that it happened that day.

Jun 26 11:34:07 redacted kernel: [326687.684554] receive_cb_reply: Got
unrecognized reply: calldir 0x1 xpt_bc_xprt 000000000dddae84 xid
bb78d292
Jun 26 11:34:07 redacted kernel: [326687.684634] receive_cb_reply: Got
unrecognized reply: calldir 0x1 xpt_bc_xprt 000000000dddae84 xid
ba78d292
Jun 26 11:41:38 redacted kernel: [327139.472177] receive_cb_reply: Got
unrecognized reply: calldir 0x1 xpt_bc_xprt 000000004df70d45 xid
3bfdc2ea
Jun 26 11:44:30 redacted kernel: [327310.678539] INFO: task nfsd:848
blocked for more than 120 seconds.
Jun 26 11:44:30 redacted kernel: [327310.685086]       Not tainted
5.19.0-1026-gcp #28~22.04.1-Ubuntu
Jun 26 11:44:30 redacted kernel: [327310.691358] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jun 26 11:44:30 redacted kernel: [327310.699442] task:nfsd
state:D stack:    0 pid:  848 ppid:     2 flags:0x00004000
Jun 26 11:44:30 redacted kernel: [327310.699451] Call Trace:
Jun 26 11:44:30 redacted kernel: [327310.699456]  <TASK>
Jun 26 11:44:30 redacted kernel: [327310.699464]  __schedule+0x248/0x5d0
Jun 26 11:44:30 redacted kernel: [327310.699478]  schedule+0x58/0x100
Jun 26 11:44:30 redacted kernel: [327310.699482]  schedule_timeout+0x10d/0x140
Jun 26 11:44:30 redacted kernel: [327310.699489]  __wait_for_common+0x99/0x1b0
Jun 26 11:44:30 redacted kernel: [327310.699493]  ? usleep_range_state+0xa0/0xa0
Jun 26 11:44:30 redacted kernel: [327310.699497]  wait_for_completion+0x24/0x40
Jun 26 11:44:30 redacted kernel: [327310.699501]  __flush_workqueue+0x140/0x3e0
Jun 26 11:44:30 redacted kernel: [327310.699512]
nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699566]
nfsd4_destroy_session+0x184/0x230 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699597]
nfsd4_proc_compound+0x42b/0x770 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699629]
nfsd_dispatch+0x174/0x270 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699670]
svc_process_common+0x2a5/0x610 [sunrpc]
Jun 26 11:44:30 redacted kernel: [327310.699760]  ?
svc_handle_xprt+0x166/0x350 [sunrpc]
Jun 26 11:44:30 redacted kernel: [327310.699807]  ? nfsd_svc+0x1a0/0x1a0 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699835]  ?
nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699863]
svc_process+0xba/0x110 [sunrpc]
Jun 26 11:44:30 redacted kernel: [327310.699906]  nfsd+0xd1/0x1a0 [nfsd]
Jun 26 11:44:30 redacted kernel: [327310.699932]  kthread+0xce/0xf0
Jun 26 11:44:30 redacted kernel: [327310.699937]  ?
kthread_complete_and_exit+0x20/0x20
Jun 26 11:44:30 redacted kernel: [327310.699941]  ret_from_fork+0x1f/0x30
Jun 26 11:44:30 redacted kernel: [327310.699948]  </TASK>



This is about 10 minutes after reboot:

Jun 26 12:45:13 redacted kernel: [  373.274344] receive_cb_reply: Got
unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000016b8f89c xid
b4752784
Jun 26 12:49:06 redacted kernel: [  605.568257] INFO: task nfsd:887
blocked for more than 120 seconds.
Jun 26 12:49:06 redacted kernel: [  605.574821]       Not tainted
5.19.0-1026-gcp #28~22.04.1-Ubuntu
Jun 26 12:49:06 redacted kernel: [  605.581432] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jun 26 12:49:06 redacted kernel: [  605.589914] task:nfsd
state:D stack:    0 pid:  887 ppid:     2 flags:0x00004000
Jun 26 12:49:06 redacted kernel: [  605.589926] Call Trace:
Jun 26 12:49:06 redacted kernel: [  605.589931]  <TASK>
Jun 26 12:49:06 redacted kernel: [  605.589937]  __schedule+0x248/0x5d0
Jun 26 12:49:06 redacted kernel: [  605.590112]  schedule+0x58/0x100
Jun 26 12:49:06 redacted kernel: [  605.590117]  schedule_timeout+0x10d/0x140
Jun 26 12:49:06 redacted kernel: [  605.590125]  __wait_for_common+0x99/0x1b0
Jun 26 12:49:06 redacted kernel: [  605.590129]  ? usleep_range_state+0xa0/0xa0
Jun 26 12:49:06 redacted kernel: [  605.590134]  wait_for_completion+0x24/0x40
Jun 26 12:49:06 redacted kernel: [  605.590138]  __flush_workqueue+0x140/0x3e0
Jun 26 12:49:06 redacted kernel: [  605.590147]
nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590199]
nfsd4_destroy_session+0x184/0x230 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590235]
nfsd4_proc_compound+0x42b/0x770 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590270]
nfsd_dispatch+0x174/0x270 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590303]
svc_process_common+0x2a5/0x610 [sunrpc]
Jun 26 12:49:06 redacted kernel: [  605.590392]  ?
svc_handle_xprt+0x166/0x350 [sunrpc]
Jun 26 12:49:06 redacted kernel: [  605.590447]  ? nfsd_svc+0x1a0/0x1a0 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590479]  ?
nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590510]  svc_process+0xba/0x110 [sunrpc]
Jun 26 12:49:06 redacted kernel: [  605.590561]  nfsd+0xd1/0x1a0 [nfsd]
Jun 26 12:49:06 redacted kernel: [  605.590598]  kthread+0xce/0xf0
Jun 26 12:49:06 redacted kernel: [  605.590603]  ?
kthread_complete_and_exit+0x20/0x20
Jun 26 12:49:06 redacted kernel: [  605.590608]  ret_from_fork+0x1f/0x30
Jun 26 12:49:06 redacted kernel: [  605.590616]  </TASK>

when things started to go really bad we gt another stacktrace:
Jun 26 12:53:07 redacted kernel: [  847.232530] INFO: task
kworker/u8:3:5078 blocked for more than 120 seconds.
Jun 26 12:53:07 redacted kernel: [  847.239937]       Not tainted
5.19.0-1026-gcp #28~22.04.1-Ubuntu
Jun 26 12:53:08 redacted kernel: [  847.246163] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jun 26 12:53:08 redacted kernel: [  847.254308] task:kworker/u8:3
state:D stack:    0 pid: 5078 ppid:     2 flags:0x00004000
Jun 26 12:53:08 redacted kernel: [  847.254328] Workqueue: nfsd4
laundromat_main [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254438] Call Trace:
Jun 26 12:53:08 redacted kernel: [  847.254443]  <TASK>
Jun 26 12:53:08 redacted kernel: [  847.254449]  __schedule+0x248/0x5d0
Jun 26 12:53:08 redacted kernel: [  847.254460]  ? available_idle_cpu+0x66/0xa0
Jun 26 12:53:08 redacted kernel: [  847.254467]  schedule+0x58/0x100
Jun 26 12:53:08 redacted kernel: [  847.254472]  schedule_timeout+0x10d/0x140
Jun 26 12:53:08 redacted kernel: [  847.254478]  __wait_for_common+0x99/0x1b0
Jun 26 12:53:08 redacted kernel: [  847.254482]  ? usleep_range_state+0xa0/0xa0
Jun 26 12:53:08 redacted kernel: [  847.254485]  wait_for_completion+0x24/0x40
Jun 26 12:53:08 redacted kernel: [  847.254489]  __flush_workqueue+0x140/0x3e0
Jun 26 12:53:08 redacted kernel: [  847.254494]
nfsd4_shutdown_callback+0x4d/0x130 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254525]  ?
nfsd4_return_all_client_layouts+0xc9/0x160 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254556]  ?
nfsd4_shutdown_copy+0x70/0xb0 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254600]
__destroy_client+0x1a1/0x210 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254630]  expire_client+0x57/0x70 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254659]
nfs4_laundromat+0x26e/0x900 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254690]  ?
finish_task_switch.isra.0+0x82/0x290
Jun 26 12:53:08 redacted kernel: [  847.254697]
laundromat_main+0x19/0x50 [nfsd]
Jun 26 12:53:08 redacted kernel: [  847.254726]  process_one_work+0x222/0x3c0
Jun 26 12:53:08 redacted kernel: [  847.254731]  worker_thread+0x50/0x3f0
Jun 26 12:53:08 redacted kernel: [  847.254734]  ? process_one_work+0x3c0/0x3c0
Jun 26 12:53:08 redacted kernel: [  847.254736]  kthread+0xce/0xf0
Jun 26 12:53:08 redacted kernel: [  847.254742]  ?
kthread_complete_and_exit+0x20/0x20
Jun 26 12:53:08 redacted kernel: [  847.254746]  ret_from_fork+0x1f/0x30
Jun 26 12:53:08 redacted kernel: [  847.254754]  </TASK>


1 - https://marc.info/?l=linux-nfs&m=168258759703478&w=2

Regards,
Miha
