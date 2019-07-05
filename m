Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A641560E0B
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGEW7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jul 2019 18:59:16 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:38466 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGEW7Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jul 2019 18:59:16 -0400
Received: by mail-io1-f51.google.com with SMTP id j6so22259031ioa.5
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jul 2019 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xq7BB+bsSEWd0N0pJFZrd5Ww5QbCsUBYzVS0nSKu2vE=;
        b=fJnqdd4u+GvLvDY6tnKFc7omMg09VgM7smCVuL/5OH9wGjcgwMtNGbyoX7Svc2BIim
         Eepl0qSYzRiSPMlCzJwlcl0FHPGIuKojvWt7kvjuMi2Mujg/j4fjm19tM9e4flEyDSXm
         941BM73VIG67zblg5/81rE4IlYG2xfwyefONWop7PjWgAcU70uGWO8wYPoFk2fjuj4NC
         X5M6Srzn5Hqm10my9Eoj7VZeBMiOdFHHAuX/uP1vXDFRAkpMA0UT2Ytd+x04QVUpZVjV
         JW50I0Lcd6gSovyIxU7qU6AEdWS/b76ACwmWmV3YSQcdSFzRsqG20GredEBUe2upGCnK
         puKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xq7BB+bsSEWd0N0pJFZrd5Ww5QbCsUBYzVS0nSKu2vE=;
        b=jSaWR24p8AqThSCg1Hwjj9QeAcR9wJVN7o8zl3AqIaeNriwTHoIabmx6NLgsowoTtU
         6KeACeyniMRM/aU1+hyfukFwncSbILZiG+6YmbNaeqNPvgMIo7PmLbsU83oh9/ULvsBY
         kkh/fWyb3R9MOIIebQuIB6XvrvpXBuuKjTr6gSwdqYYn3GgE3CVRy58YYDhtHXdUIDeC
         2ebZDuvzHN2z6+lrawlYGJkoAP47bc2hUgb8ggK0EbEkWy+Sl0MFtsU6qurtsn7d4uX6
         f2XnM++BgIa2epe8UG4nATrnODRD11LeCRNL5CnM54GU03YfcYUtqsRSVEYI0dXynzb2
         Vg7w==
X-Gm-Message-State: APjAAAU68pnqFNtgGo836/pS0SqXh/yB1s330nWLXWoDvrFN3ExoiITe
        UwlqPvO0QwKGnFecjH+z9bTefYtwpsMYoW6UCaDjIGbllu4=
X-Google-Smtp-Source: APXvYqxaS8KiH7d5xtSoasV9AEbhBcoMwhD00B1t4yPeQ6ncM/oXb+ix6lJVaV6qb7i4jRthOIeA0LY0NVcaQr8y/LQ=
X-Received: by 2002:a6b:7602:: with SMTP id g2mr330402iom.82.1562367555467;
 Fri, 05 Jul 2019 15:59:15 -0700 (PDT)
MIME-Version: 1.0
From:   John Bartoszewski <john.bartoszewski@gmail.com>
Date:   Fri, 5 Jul 2019 16:59:02 -0600
Message-ID: <CAMttjSSQibhZ4ekSMVRF0jeREA9n9s6puAJcOTR2vyn=W2W5sg@mail.gmail.com>
Subject: zfs server slow mounting ( mtab ?)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I'm trying to setup a nfs server with over 3500+ zfs datasets
being exported. Only NFSv3 is needed.

The OS had a 4.4.172 kernel and nfs-utils 1.30. With these versions
when a client tried to mount an exported dataset, rpc.mountd spiked to
100% for several minutes, the kernel produced a bug and a trace
output, and the client never finished.

I have built a 4.19.56 kernel, libevent 2.1.10, util-linux 2.34 (for
libblkid), and nfs-utils 2.4.1. With this setup rpc.mountd does spike
to 100%, but at least a mount finishes, but it takes about 5 minutes.

nfs-utils was configured with:
./configure --disable-tirpc  --disable-nfsv4 --disable-nfsv41
--disable-gss --disable-ipv6

Stracing the new rpc.mountd it appears all the time is spent reading
the mtab.

Below is some of the output from:
/sbin/rpc.mountd --foreground --debug all

rpc.mountd: nfsd_fh: found 0x6173d50 path /
rpc.mountd: auth_unix_ip: inbuf 'nfsd 10.222.33.24'
rpc.mountd: auth_unix_ip: client 0x1d5bbb0 '10.222.33.0/24'
rpc.mountd: auth_unix_ip: inbuf 'nfsd 10.222.33.254'
rpc.mountd: auth_unix_ip: client 0x1d5bbb0 '10.222.33.0/24'
rpc.mountd: nfsd_export: inbuf '10.222.33.0/24 /nfsexport'
rpc.mountd: nfsd_export: found 0x6174260 path /nfsexport
rpc.mountd: nfsd_fh: inbuf '10.222.33.0/24 7
\x43000a00000000001ce354a654a34fd4a09f9b59f6aebb11'
rpc.mountd: nfsd_fh: found 0x6174270 path /nfsexport
rpc.mountd: nfsd_export: inbuf '10.222.33.0/24 /nfsexport/home'
rpc.mountd: nfsd_export: found 0x4cf8bc0 path /nfsexport/home
rpc.mountd: Received NULL request from 10.222.33.254
rpc.mountd: Received NULL request from 10.222.33.254
rpc.mountd: Received MNT3(/nfsexport/home/timmy) request from 10.222.33.254
rpc.mountd: authenticated mount request from 10.222.33.254:694 for
/nfsexport/home/timmy (/nfsexport/home/timmy)
rpc.mountd: nfsd_fh: inbuf '10.222.33.0/24 6 \x947e3e1400c9c79b0000000000000000'
rpc.mountd: nfsd_fh: found 0x4e54390 path /nfsexport/home/timmy

As you can see it searches for /, then /nfsexport, then /nfsexport/home,
and finally /nfsexport/home/timmy

But when zfs populates the mtab, the top level of the datasets
( /nfsexport ) is at the bottom of the mtab, 3500 lines down.
The next level is also at the bottom. So getmntent has to
read the mtab stream through several times. Actually:
open("/etc/mtab", O_RDONLY|O_CLOEXEC)   = 10
is called 50000 times during this one mount attempt.

Are they any suggestions anyone can make to help out?

More extensive output can be made available.

Thanks,
John
