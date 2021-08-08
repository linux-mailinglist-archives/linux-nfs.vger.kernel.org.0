Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357743E3D0A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 00:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhHHWiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHHWiU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 18:38:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F8C061760
        for <linux-nfs@vger.kernel.org>; Sun,  8 Aug 2021 15:38:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e19so845732pla.10
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+90glai/oIN+mQa+A7cK2HodA+5Tq3QYPjmnG9JtgOE=;
        b=KbCYHyYC3cuzbK1xnpIDFGCutLPjFecHUAApKWe/qtN8pbBTuV9qxbojDquyLjSLA8
         RKIQAxh1tMGfs56LGTXX07r+lRyYBi4fpxNaTdxAOX116sCKHAc+MlHn1BZ80gtzm9RB
         VjDs5W0P2Q+Did1YIVpvxODCd3Me/nuXJdqxUlDmN8JDIX7nvtTgg4808/iJWNxM+D58
         A1rXEB795hkF3GqW9+RY5MERlroYHxqPJayCcdOLp2JBRLo1V9ZhY19qIMUmlrcd9UcJ
         q8znUwrtYI6cvSPsSBspBTpnd/I9k8lNnaOwDXcLLStysC1wfEHSNnpHRNE+8Za1y35r
         MtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+90glai/oIN+mQa+A7cK2HodA+5Tq3QYPjmnG9JtgOE=;
        b=ZvjTNsJxfvXdvDH01nN5gO1G2b8ovjRbRZYeD1QRUx/M6axZVq+StCVBLfDDuHPouZ
         DJihK+BoVxB2tB5DhNW9LyNQ16CpQDUQI/spjx4Uhmjj4Lm5uXQVJ4qQfXReBv1Hx5C1
         mmPq9fzd/r8zsapf2hs/Sb7EywWdAKHOLCi65N1EVxINx6MHd98MbGtDzl8LPiYv1uAW
         un/VOT5oFfvihA+GRwWRXG8atKTOoncDzafJaV/+YIiqGiefRLYonHt4/7gXVhVdprRa
         epPy6KyP+KNNTHljrfHklQ3Qj+Jqi8t0SeDiSZv1OpGi7+BOJ7X0FLZidfjUsC+p8Ohc
         8Y7g==
X-Gm-Message-State: AOAM533AIqEz7gP8dyzWFY102M0bmdvG74Pb4NN1cgHz56H0wGEWP1Js
        Cho7lQ9YOnraCA59WZxb8JTerCbTZemSoS/qKEUcgtJM1jMhZA==
X-Google-Smtp-Source: ABdhPJxwRE4vZOvDBaEs904TU+KBa2zT7Y6nUhDsW0WF0qrnwCzy6km1Z1E3+p/7nYNNUIKc3kNeyRqRPGO1Z7Ee+s0=
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id
 c6-20020a056a000ac6b0290374a33b0a74mr15581368pfl.51.1628462279449; Sun, 08
 Aug 2021 15:37:59 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sun, 8 Aug 2021 15:37:48 -0700
Message-ID: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
Subject: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have been experiencing nfs file access hangs with multiple release
versions of the 5.13.x linux kernel. In each case, all file transfers
freeze for 5-10 seconds and then resume. This seems worse when reading
through many files sequentially.

My server:
- Archlinux w/ a distribution provided kernel package
- filesystems exported with "rw,sync,no_subtree_check,insecure" options

Client:
- Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writing)
- nfs mounted via /net autofs with "soft,nodev,nosuid" options
(ver=4.2 is indicated in mount)

I have tried the 5.13.x kernel several times since the first arch
release (most recently with 5.13.9-arch1-1), all with similar results.
Each time, I am forced to downgrade the linux package to a 5.12.x
kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
and stabilize performance. No other changes are made between tests. I
have confirmed the freezing behavior using both ext4 and btrfs
filesystems exported from this server.

At this point I would appreciate some guidance in what to provide in
order to diagnose and resolve this issue. I don't have a lot of kernel
debugging experience, so instruction would be helpful.

- mike
