Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65E5B50C2
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIKS6s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Sep 2022 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIKS6r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Sep 2022 14:58:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261411A05A
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 11:58:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z97so9830883ede.8
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gBz6fE4n3x2W4y9inBGyZCS2RN2mCtnSW5c1yuOoj/o=;
        b=Y8p2dnj2n250P+A4OCDB9BSrBmxPmQ+1Q2KsGwcqAQL1fYdXKAstG5x8ntJeeIqa24
         zV344pHmElDPItRyp8iVJN3ZznCPuxK60AKc2qVO2SoqpQzRuKChvpQbjz/ATWT83ync
         F7n2B9sRO3v8oZ1V80XfuKbMklNbpQ+RpGOsRcWM1uDnzq0i+lWuSI7atNfLrceXitpg
         fpgJHsm+Y5zYIJuiNokQvUNO8f9Be6GrVBz6HRFhzD34U40GUzX9/m2alN7htF6hEqMk
         nH+/qfXEzQFcLfBBVT4el9Z1z3oFD07fke+Lm1T7BiT30EHEPkQ7BrX2cthRE6Y3S3S4
         Tuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gBz6fE4n3x2W4y9inBGyZCS2RN2mCtnSW5c1yuOoj/o=;
        b=av3MBph904FcKBdJfsyrvqLKuLPa4fT/BVxHxvjlJ65DR1OXCBtVuLwLWNgiqLixn7
         gmdbHApcdyKh2JkvVPbfiRWmaGBSCGNfOfHcGkqgjPJolR82AiiQNTW0gb0d51RwH8f1
         ZS5FtPbxJW6mMOVY5jyIiSwcXwUPR4yo2pxicV8GMmH4WMnQgO6itK9zSqo9yRnXiM+T
         3ofoB3/yxcZHrmF33b2OF2jrYqLZWiaRyQzRBJ00QlT4Ln9V6U0TTD3RQyXnL5ucHP4A
         odwiVnO29LLQWd83weqFWvyJJicySpIBSDXQH3BjIO29gUCXhNsd3bRyn/ZMwYXTXKio
         gurA==
X-Gm-Message-State: ACgBeo118UmZNyHaGl1p9GA1I1neO1D9NlrNHUvaeqeWHQkjqreGOmOV
        qFLsSRnRNn+Uc9UhLR7I5DyB9U5gyd8q2IxJQD7LK3srMlU=
X-Google-Smtp-Source: AA6agR7jkPGB0igDlX0VMAuR6uNZzAC3trzlWPuw0S2k1psWqAW8eP8VFTHDyWeHcgVaApIPAfxLqk2LDF+AQM9ps7I=
X-Received: by 2002:a50:fa8c:0:b0:44e:8557:477a with SMTP id
 w12-20020a50fa8c000000b0044e8557477amr19770545edr.26.1662922724281; Sun, 11
 Sep 2022 11:58:44 -0700 (PDT)
MIME-Version: 1.0
From:   Isak <netamego@gmail.com>
Date:   Sun, 11 Sep 2022 20:58:32 +0200
Message-ID: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
Subject: nfs client strange behavior with cpuwait and memory writeback
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everybody!!!

I am very happy writing my first email to one of the Linux mailing list.

I have read the faq and i know this mailing list is not a user help
desk but i have strange behaviour with memory write back and NFS.
Maybe someone can help me. I am so sorry if this is not the right
"forum".

I did three simple tests writing to the same NFS filesystem and the
behavior of the cpu and memory is extruding my brain.

The Environment:

- Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same behavior
with Red Hat 7.9)

- One nfs filesystem mounted with sync and without sync

1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
(rw,relatime,sync,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=1x.1x.2xx.1xx,mountvers=3,mountport=2050,mountproto=udp,local_lock=none,addr=1x.1x.2xx.1xx)

1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
(rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=1x.1x.2xx.1xx,mountvers=3,mountport=2050,mountproto=udp,local_lock=none,addr=1x.1x.2xx.1xx:)

- Link between nfs client and nfs server is a 10Gb (Fiber) and iperf3
data show the link works at maximum speed. No problems here. I know
there are nfs options like nconnect to improve performance but I am
interested in linux kernel internals.

The test:

1.- dd in /mnt/test_fs_without_sync

dd if=/dev/zero of=test.out bs=1M count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s

* High cpuwait
* High nfs latency
* Writeback in use

Evidences:
https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhntQ0NQzeFF51d9qI0=

https://i.stack.imgur.com/pTong.png



2.- dd in /mnt/test_fs_with_sync

dd if=/dev/zero of=test.out bs=1M count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s

* High cpuwait
* Low nfs latency
* No writeback

Evidences
https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq9rCidAKL8RpKpDJ8=

https://i.stack.imgur.com/Pf1xS.png



3.- dd in /mnt/test_fs_with_sync and oflag=direct

dd if=/dev/zero of=test.out bs=1M oflag=direct count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s

* Low cpuwait
* Low nfs latency
* No writeback

Evidences:
https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/qFt/O+qFyNj5FUs8k=

https://i.stack.imgur.com/Qs6y5.png




The questions:

I know write back is an old issue in linux and seems is the problem
here.I played with vm.dirty_background_bytes/vm.dirty_background_ratio
and vm.dirty_background_ratio/vm.dirty_background_ratio (i know only
one is valid) but whatever value put in this tunables I always have
iowait (except from dd with oflag=direct)

- In test number 2. How is it possible that it has no nfs latency but
has a high cpu wait?

- In test number 2. How is it possible that have almost the same code
path than test number 1? Test number 2 use a nfs filesystem mounted
with sync option but seems to use pagecache codepath (see flame graph)

- In test number 1. Why isn't there a change in cpuwait behavior when
vm.dirty tunables are changed? (i have tested a lot of combinations)

Thank you very much!!

Best regards.
