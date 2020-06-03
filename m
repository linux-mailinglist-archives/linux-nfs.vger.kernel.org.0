Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A381ED3D7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2020 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCP6N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jun 2020 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgFCP6M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jun 2020 11:58:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F9C08C5C0
        for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2020 08:58:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so3438145ljo.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2020 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thefrys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=fXVqToZYdu4EuzctN893foddhQZu1iCokT8f8h1tPSc=;
        b=kaNvM8yBZtt99FyhAtC8b5Pxv4469O/sSs+hdwtGPptkAbo7AjcnzmgK7R8xGgJYYx
         RfqU1280519r8ORIaQM42u/CP8phXLxf3HNZi5tQWRnIzk24sk8gMGztlWH9x88FVtM0
         FxvD1i73fRrBJCtNCkagMrP5Dx4k+U6pj+YdG/vI4APuAsAXrOpxEfBG59X3wkqTY9o/
         gQ0breoXXmqtL0bKx1Opjv2+rZgQbiE68gQ0RcvUgugwbnrHkSA6grV74oqD9rTJ8xb1
         iLy3S34iD0FZhKR911iwXfwK33bA4+TQuPKk1xkpliPBIJptQNQ1hbmF2cem0qqtxrtc
         jBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fXVqToZYdu4EuzctN893foddhQZu1iCokT8f8h1tPSc=;
        b=TBIhq7hCK7WjBJ+wDCK/P7/thNplQE/u8wjdwAu6Ru+kbEArup5NqjN0kvHhbViodk
         pHGenXiiXpbCwuPQZjw60TZzaDNBzsEeGMhltaXuZ/RvMKEE/kmKZZKDZFoRxoLj1i+J
         ooyFuBlzhy9aBfIwBVZAYSaYY48U/b9rivbehXEnyFXXukLeCbCUoKvkveDYcZGg9FfU
         Mp8Mhnli0RFH0rmrRDMx2eRnXwCMBPK33mE8PjFuEn4hh1abVm+4A7DcNQLKSqY7rLl+
         r2JcVsk35nkFcAoPx/LqayxUB6K9qdSBFd6Mbxaf+QaCOHixp2151N4FTqS6GAavwk2R
         VJEw==
X-Gm-Message-State: AOAM531KQNp9cCOwMYPDVsqPLPfcJTXn4TROYYZqZYR852z7fpmKYdNL
        JlKMBSoBG9EZEsmC8ZtCVRF/IcYsHK+Of7Y3zYFc3J5Gwl4=
X-Google-Smtp-Source: ABdhPJxzQlsMNTPxhiNvS3kFvEr+41AenS2VB51amuMnXyDRBx5OXkWKTbDjM2C9C4PoRH18s5bk2GNDxXxTKZYx/h0=
X-Received: by 2002:a2e:8107:: with SMTP id d7mr759839ljg.363.1591199890122;
 Wed, 03 Jun 2020 08:58:10 -0700 (PDT)
MIME-Version: 1.0
From:   Joseph Fry <joe@thefrys.com>
Date:   Wed, 3 Jun 2020 11:57:34 -0400
Message-ID: <CAAJE3SsYvmL3qq=+Ay0PZqsg0XAQKcVJMpJ1QHpyLrDaWaUWyg@mail.gmail.com>
Subject: Delay before NFS list/create file operations
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry if this is not the correct way to ask for help, however I want
to avoid people trying to help me "tune" my nfs mount settings and
figured that taking my problem to the actual devs may get to the heart
of my issue faster.

Running a custom Linux 4.14.132 kernel and nfs-common 1.3.4-2.1 on a
Debian Stretch VCenter VM using NFSv3 over UDP to connect to a NetApp
filer via a 10Gbps link.  We have several identical servers, all
accessing the same NFS export/qtree, all showing the same symptoms.
There are 1.8M files in that directory (a lot, but everything works
fine, until it doesn't).

Essentially, the issue is that after a few hours of moderate to heavy
use we begin to notice a delay prior to most NFS operations that don't
target a specific file.  It literally appears that every call to
create or list files on NFS is being delayed, and that delay grows to
>30s over a few hours and never goes away until we umount+mount or
reboot.

To show the difference, I mounted the same NFS export a second time
from an affected server and timed writing a 1GB file to each of the
mounts.  On the fresh mount (/mnt/nfs) I see about what you would
expect (dd says it wrote everything in 9.65s and the total execution
time was 9.7s):

# time dd if=/dev/zero of=/mnt/nfs/testfile1 bs=1G count=1

1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.65657 s, 111 MB/s

real    0m9.719s
user    0m0.000s
sys     0m1.284s

However when performing the same operation from the affected mount, we
see that the total execution time was almost 6X longer (54s) than the
actual write operation (still only ~9s).  It literally sat there doing
nothing for 45 seconds before any writing occurred:

# time dd if=/dev/zero of=/opt/rpath/testfile2 bs=1G count=1

1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.17179 s, 117 MB/s

 real    0m54.226s
user    0m0.001s
sys     0m1.238s

In addition to creating files, a simple "ls -1f" will wait 30+ seconds
before displaying the first ~500 filenames, then waits 30+ seconds
again before then next ~500 and so on.

Any operation that targets an explicit filename does not seem to be
affected and all operations on a fresh mount perform exactly as you
would expect.

The mountstats and nfsiostat commands also show that NFS is behaving
normally; all statistics are normal, fast and timely... yet every
affected operation has a delay before it actually starts
reading/writing from NFS.

I have spent hours on the phone with netapp and we are planning to do
packet captures, but we are fairly confident that the issue is client
side.

I don't believe that the issue is in NFS, or I should see an impact to
the statistics, which leaves something in the kernel feeding the
requests to it, but I have no idea where to look to pinpoint the
delay.  Unfortunately these systems do not have strace or many other
tools installed, so I am fairly limited in what I can do to
troubleshoot client side issues.

I hoped that someone on this list may have seen this issue before or
otherwise have a good place to start looking.

I am not a member of the mailing list, so I would appreciate responses
to be sent directly to me joe@thefrys.com.  http://vger.kernel.org
appears to be down, so I am not sure how to join.

Thanks for any direction you can provide!


Joe
