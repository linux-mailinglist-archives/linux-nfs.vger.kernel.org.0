Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D47B7A4C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbfISNRR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 09:17:17 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40741 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfISNRQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 09:17:16 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so453504uaq.7
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2BInpvKFKDFOGOJpMmOPL7Neo2o2sHGJ9/Vor5jNpc=;
        b=cBF+1GgIYMIlEMFbIUlChS1rQ2URSCivlcrDaWHLvBct//x6pmvjSgnqjKTT+rMnOt
         rwN9AleAZT+aZFKCIYNEy+zOZldjraRuyhi9UczlMl+0c420/7T69vAvfYOoLeM8E8TK
         B6gE9/h85DoxZypsH/Rl2atn2sSrHexymxcCq3EfcPP+2j/MNNh4H7U+/+VkwNae9VKO
         YoLeUoIdOmhyrhbXXeZDpwftY0mt/fv+0McrVSwr+0RanHOqYVRARkgZiCgu1b614Jx0
         slGbcls4W3Cuanss44U4h4lnHRjWsKtwq1ppeXkZXizAlBFtAMO0V+rVG78iCFwGJ2g/
         jvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2BInpvKFKDFOGOJpMmOPL7Neo2o2sHGJ9/Vor5jNpc=;
        b=mdlVGqQSXEANU1Ucf9tBiaQI8yMQjtPjQ2LALVga9j332mvRQi9GwBQTBrTZOIWP/Q
         O2xx9I28LYYedPKQL/tX4BU4BF2K/03VeNxZrAkzRM+CvibGutQkaYqppo94HeNYKDFc
         iPUqYSnwOJd0NFo3ld4ZytYOnbxnRHPNCw/hsrwSELnaKxUSbr1WADPEE96Q9xArEL5R
         Wbkus59OT5UqnaZB9+W2syHsRSzg66JEtOBGulBG7USZf4EEmb84B2Jsj8h+NIf81wqJ
         5nODnKU9/o3agLaS1bLU4tu8VRRpnzXkpMhtAWuVruTUuS35IAbp4MQ6GGPtBphhwwA1
         +RhQ==
X-Gm-Message-State: APjAAAVuuaJHY5MV3Juafu5b9k3/tVjtl4Q7fXVP4ZJ0ORZdrLITj8xD
        PtEzg4+mxVpUiDRF6J8OJV80Dlc5mlKsNMJfrLO9lnjt
X-Google-Smtp-Source: APXvYqydQARTmzErDW/+tJcJnyhHK53JtIORCBJ6ZaCorVGmrLf4rd9q++08HgvPQwBNTET37d+rqwVdNt0RZr0eu30=
X-Received: by 2002:ab0:ed:: with SMTP id 100mr5481881uaj.48.1568899035117;
 Thu, 19 Sep 2019 06:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
In-Reply-To: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Thu, 19 Sep 2019 09:17:03 -0400
Message-ID: <CA+X5Wn6Yj6752BMxpXB-wa92QQD7xv3uOp=rzJn5qP-_RxL41g@mail.gmail.com>
Subject: Re: 5.3.0 Regression: rpc.nfsd v4 uninterruptible sleep for 5+
 minutes w/o rpc-statd/etc
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     bcodding@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 9:00 AM James Harvey <jamespharvey20@gmail.com> wrote:
>
> For a really long time (years?) if you forced NFS v4 only, you could
> mask a lot of unnecessary services.
>
> In /etc/nfs.conf, in "[nfsd] I've been able to set "vers3=n", and then
> mask the following services:
> * gssproxy
> * nfs-blkmap
> * rpc-statd
> * rpcbind (service & socket)
>
> Upgrading from 5.2.14 to 5.3.0, nfs-server.service (rpc.nfsd) has
> exactly a 5 minute delay, and sometimes longer.
>
> ...

P.S.  During a few of the earlier boots where I was seeing strace show
the delay was reading "/proc/fs/nfsd/versions", I do have this in
journalctl, when I tried in another term cat'ing it during the
rpc.nfsd delay: (it repeats a few times during the 5 minute delay)

INFO: task cat:3400 blocked for more than 122 seconds.
      Not tainted 5.3.0-arch1-1-ARCH #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
cat             D    0  3400   3029 0x00000080
Call Trace:
 ? __schedule+0x27f/0x6d0
 schedule+0x43/0xd0
 schedule_preempt_disabled+0x14/0x20
 __mutex_lock.isra.0+0x27d/0x530
 write_versions+0x38/0x3c0 [nfsd]
 ? _copy_from_user+0x37/0x60
 ? write_ports+0x320/0x320 [nfsd]
 nfsctl_transaction_write+0x45/0x70 [nfsd]
 nfsctl_transaction_read+0x3b/0x60 [nfsd]
 vfs_read+0x9d/0x150
 ksys_read+0x67/0xe0
 do_syscall_64+0x5f/0x1c0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f47286fa155
Code: Bad RIP value.
RSP: 002b:00007ffcd2a74438 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f47286fa155
RDX: 0000000000020000 RSI: 00007f47282ba000 RDI: 0000000000000003
RBP: 00007f47282ba000 R08: 00007f47282b9010 R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 00007f47282ba000
R13: 0000000000000003 R14: 0000000000000fff R15: 0000000000020000
svc: failed to register lockdv1 RPC service (errno 110).
lockd_up: makesock failed, error=-110
