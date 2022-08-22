Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65959BB32
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiHVIQZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 04:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiHVIQY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 04:16:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9011C105
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 01:16:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so10923074ejt.6
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=IsLrz65gWVQHAa6Mn3c9cerNUrChm5P+U50JI2d+SIE=;
        b=Hs/pyJA0XeAngz1meQtZojd98p8kg6bmf0xjRzQE1DRatwpEfV3jZ3fr9h+wQEGELC
         sBuFYS78hyQbr7Fj8lY69q5SCl7JMfTdoHpLEYdWEKcFy8qe6niIjb3nvyKtuWX9ZpBe
         WXpizMCcaT+dwx4Dzwpe6+mPg3LNyYVMMHDtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IsLrz65gWVQHAa6Mn3c9cerNUrChm5P+U50JI2d+SIE=;
        b=4nxmKZW28tpNb6xEKWMIRlwrDGeHo4iustwEqjzqnDhBnB+WZBhc4rgtOI3kZVHBpk
         jIVIlouFXzOOV58vlFwdJ8psC9rlmi+BJ3JbNoIcuCUN60RC7c2GdEbLkI2hdzS/fsEM
         FhmXmUfsYgSLNpm1zrLFQ6B+iRyvWZ5o1MPbrPI3jp3hC7ovF3Sfe82KgVZEYVGWk+y+
         CqaRoTlfFWOYz8nsj5+yvFxqawz1I/gvH9j3CQCxvNSdqMRhAfGO5Uc5bb5zeTbnZpzm
         xLry6IirT98vMULvaRyojtHxAiZ4V53f/SLxeWA0hlDfvUsod8eV4SKrMu/WhVQVLQ2F
         AgnA==
X-Gm-Message-State: ACgBeo16G0UjyB4LC327PbXWfmtWcuOv5F2tzTNQzvRjQ1HGZ0dA2cJ3
        cwZ773wfsDHnPCNQ5oT/+YX0T7xMx/Ap6x7zQdgkxB3Cs2SqCw==
X-Google-Smtp-Source: AA6agR566dsQXlVXIeS0jqQFfW0yUkQSVCGR44FEVJO+cDl4l/OmxgLqqYASi2dBD6hSr3no4ijBH037fr3Eln2XSck=
X-Received: by 2002:a17:907:84a:b0:733:735:2b1a with SMTP id
 ww10-20020a170907084a00b0073307352b1amr12198563ejb.290.1661156178228; Mon, 22
 Aug 2022 01:16:18 -0700 (PDT)
MIME-Version: 1.0
From:   Igor Raits <igor@gooddata.com>
Date:   Mon, 22 Aug 2022 10:16:07 +0200
Message-ID: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
Subject: Regression: deadlock in io_schedule / nfs_writepage_locked
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello everyone,

Hopefully I'm sending this to the right place=E2=80=A6
We recently started to see the following stacktrace quite often on our
VMs that are using NFS extensively (I think after upgrading to
5.18.11+, but not sure when exactly. For sure it happens on 5.18.15):

INFO: task kworker/u36:10:377691 blocked for more than 122 seconds.
     Tainted: G            E     5.18.15-1.gdc.el8.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:     2 flags:0x000=
04000
Workqueue: writeback wb_workfn (flush-0:308)
Call Trace:
<TASK>
__schedule+0x38c/0x7d0
schedule+0x41/0xb0
io_schedule+0x12/0x40
__folio_lock+0x110/0x260
? filemap_alloc_folio+0x90/0x90
write_cache_pages+0x1e3/0x4d0
? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
nfs_writepages+0xe1/0x200 [nfs]
do_writepages+0xd2/0x1b0
? check_preempt_curr+0x47/0x70
? ttwu_do_wakeup+0x17/0x180
__writeback_single_inode+0x41/0x360
writeback_sb_inodes+0x1f0/0x460
__writeback_inodes_wb+0x5f/0xd0
wb_writeback+0x235/0x2d0
wb_workfn+0x348/0x4a0
? put_prev_task_fair+0x1b/0x30
? pick_next_task+0x84/0x940
? __update_idle_core+0x1b/0xb0
process_one_work+0x1c5/0x390
worker_thread+0x30/0x360
? process_one_work+0x390/0x390
kthread+0xd7/0x100
? kthread_complete_and_exit+0x20/0x20
ret_from_fork+0x1f/0x30
</TASK>

I see that something very similar was fixed in btrfs
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
but I could not find anything similar for NFS.

Do you happen to know if this is already fixed? If so, would you mind
sharing some commits? If not, could you help getting this addressed?

Thanks in advance!
--=20
Igor Raits
