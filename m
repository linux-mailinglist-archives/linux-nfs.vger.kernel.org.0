Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2348D5B6164
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiILTAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiILTAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 15:00:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC715A3F
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 12:00:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lc7so22483343ejb.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=2nAFhPHWLFQesnPFDF3CpXw3RQ3QP2pO779JO4xcEcM=;
        b=ZCBgimwBTnrlBpq5NaFkGQ9o+sAIu1y968c+Jk/k/o6UlMXQ1/MqoFPQcujQVlAJQb
         zjJPQmFHyMFpom58NGT75fKO9p1f0uT06xAFsOEJG4+wslNOSW5GXFEGK5pOi2iwjuIe
         CJ4UBkgeANULCcvVQaDx2OAGzrzDizgsvSiZwHJWJgZJ2kKe0ikpNTzy2U6BYAj4efy2
         E4+AiM1WzGRkUO8biaHFXeZPlw/HfRgKfOxyw5gsMBW4Vm2mmCvJzFPhWvlyDjDQH/4J
         nPsqLy4q2qKznrHxv4LHBsSeKbpvi3uKdkp7XDB8eUVgm+kzmzTgjhDIHwft+nJEm6dG
         NweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2nAFhPHWLFQesnPFDF3CpXw3RQ3QP2pO779JO4xcEcM=;
        b=FT6tzstpPaC1jurvZFDIHPKIXntwL+Qpg2Eq+ZZ5Ulg2B42L/VqMeF/oXQhQLgIqad
         P/B/fvcuAwLwqwYtj9S9/1TvljnFXt05vT+ZBiQMDYMopecXyVAO7g9DkupmkVxhPQrO
         vXXoALzQjblSYJKNvWtrn3/BOA9eO7Q+X/wc48VXJD6cXfne26aFZSP3Lt8dZ1nv2WkB
         Ksr8IceroAMRyTzWdcs5whkbkO28r99hZJt09x1oGl2vdRnL9+trS+pJBv8oDekGRFIz
         522xDt92cssSXPeAY3iCAqmiy4CZ5mQejPcOFgV+HEK4/btE8Tb+ofdaR5iMrWcL46Wu
         4Qag==
X-Gm-Message-State: ACgBeo1oRgn7KNOYjgnigLEs9Hbg4NYym7W9JSP2spmUCjyrZ5nDxUIU
        W1Ojm/xicc0vTQQf5vUTFV2ug9Iv1+NZku1PtHPY3hsDMBg=
X-Google-Smtp-Source: AA6agR707j7cHSi0vkXQCbx3xedWyoyYJJ4anXIGly0diPx3TvNhxJz+l2GGhQDncqRxxfYyXhfCvc1jfyrGlPLVH20=
X-Received: by 2002:a17:907:6e14:b0:730:a229:f747 with SMTP id
 sd20-20020a1709076e1400b00730a229f747mr20349822ejc.202.1663009227790; Mon, 12
 Sep 2022 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
 <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
In-Reply-To: <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
From:   Isak <netamego@gmail.com>
Date:   Mon, 12 Sep 2022 21:00:15 +0200
Message-ID: <CAALSs0bxqODBzN0V67ExMCnOJFi_+9vZ0_zK1DTGOomb+H-D7Q@mail.gmail.com>
Subject: Re: nfs client strange behavior with cpuwait and memory writeback
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

El lun, 12 sept 2022 a las 12:40, Jeff Layton (<jlayton@kernel.org>) escrib=
i=C3=B3:
>
> On Sun, 2022-09-11 at 20:58 +0200, Isak wrote:
> > Hi everybody!!!
> >
> > I am very happy writing my first email to one of the Linux mailing list=
.
> >
> > I have read the faq and i know this mailing list is not a user help
> > desk but i have strange behaviour with memory write back and NFS.
> > Maybe someone can help me. I am so sorry if this is not the right
> > "forum".
> >
> > I did three simple tests writing to the same NFS filesystem and the
> > behavior of the cpu and memory is extruding my brain.
> >
> > The Environment:
> >
> > - Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same behavior
> > with Red Hat 7.9)
> >
> > - One nfs filesystem mounted with sync and without sync
> >
> > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
> > (rw,relatime,sync,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255=
,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1=
xx,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=
=3D1x.1x.2xx.1xx)
> >
> > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
> > (rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1xx,mo=
untvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=3D1x.1=
x.2xx.1xx:)
> >
> > - Link between nfs client and nfs server is a 10Gb (Fiber) and iperf3
> > data show the link works at maximum speed. No problems here. I know
> > there are nfs options like nconnect to improve performance but I am
> > interested in linux kernel internals.
> >
> > The test:
> >
> > 1.- dd in /mnt/test_fs_without_sync
> >
> > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > 5000+0 records in
> > 5000+0 records out
> > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s
> >
> > * High cpuwait
> > * High nfs latency
> > * Writeback in use
> >
> > Evidences:
> > https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhntQ0NQz=
eFF51d9qI0=3D
> >
> > https://i.stack.imgur.com/pTong.png
> >
> >
> >
> > 2.- dd in /mnt/test_fs_with_sync
> >
> > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > 5000+0 records in
> > 5000+0 records out
> > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s
> >
> > * High cpuwait
> > * Low nfs latency
> > * No writeback
> >
> > Evidences
> > https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq9rCidA=
KL8RpKpDJ8=3D
> >
> > https://i.stack.imgur.com/Pf1xS.png
> >
> >
> >
> > 3.- dd in /mnt/test_fs_with_sync and oflag=3Ddirect
> >
> > dd if=3D/dev/zero of=3Dtest.out bs=3D1M oflag=3Ddirect count=3D5000
> > 5000+0 records in
> > 5000+0 records out
> > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s
> >
> > * Low cpuwait
> > * Low nfs latency
> > * No writeback
> >
> > Evidences:
> > https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/qFt/O+q=
FyNj5FUs8k=3D
> >
> > https://i.stack.imgur.com/Qs6y5.png
> >
> >
> >
> >
> > The questions:
> >
> > I know write back is an old issue in linux and seems is the problem
> > here.I played with vm.dirty_background_bytes/vm.dirty_background_ratio
> > and vm.dirty_background_ratio/vm.dirty_background_ratio (i know only
> > one is valid) but whatever value put in this tunables I always have
> > iowait (except from dd with oflag=3Ddirect)
> >
> > - In test number 2. How is it possible that it has no nfs latency but
> > has a high cpu wait?
> >
> > - In test number 2. How is it possible that have almost the same code
> > path than test number 1? Test number 2 use a nfs filesystem mounted
> > with sync option but seems to use pagecache codepath (see flame graph)
> >
>
> "sync" just means that the write codepaths do an implicit fsync of the
> written range after every write. The data still goes through the
> pagecache in that case. It just does a (synchronous) flush of the data
> to the server and a commit after every 1M (in your case).

Thank you very much Jeff. Understood. My mistake. I thought that, with
the nfs sync option, page cache was actually not used. What about test
2 (with Sync) regarding to cpuwait? Seems like a CPU accounting
"problem"? I have high cpuwait and low NFS latency (nfsiostat). If dd
is launched with oflag=3Ddirect in the same NFS filesystem (mounted with
Sync), page cache is not used and there isn't cpuwait.

>
> >
> > - In test number 1. Why isn't there a change in cpuwait behavior when
> > vm.dirty tunables are changed? (i have tested a lot of combinations)
> >
> >
>
> Depends on which tunables you're twiddling, but you have 8G of RAM and
> are writing a 5G file. All of that should fit in the pagecache without
> needing to flush anything before all the writes are done. I imagine the
> vm.dirty tunables don't really come into play in these tests, other than
> maybe the background ones, and those shouldn't really affect your
> buffered write throughput.

My understanding (surely wrong) about page cache in Linux is that we
actually have two caches. One is "read cache" and the other is "write
cache" aka dirty pages so write cache should not exceed the parameter
vm.dirty_bytes or vm.dirty_ratio so I don't think 5gb file in 8gb RAM
with low vm.dirty_ratio does much buffering.

Thanks a lot Jeff for your help. I really appreciate it.

Best regards.

>
> Jeff Layton <jlayton@kernel.org>
