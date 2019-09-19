Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2941B79F9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfISNAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 09:00:25 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45151 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfISNAZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 09:00:25 -0400
Received: by mail-vs1-f53.google.com with SMTP id d204so2158576vsc.12
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MVY1O5dk1SXzLNgRmhqFt+rWU9l14EZcEJKYL99aj9w=;
        b=b44KjkYEwfqgMtP27XJMiAcwIyda1gxASJJyVaHQyGjpF1Op+ZyPSBznx9G+KP4XXD
         XRuiqRmUFSEq3qF99/4kqp+TFlWJ5ZTcSo6taXFCUMkZNxHl41KA+lHNakm68HGs0312
         J9TQZixyiHwKZ6p6JZbtJYH0qOmIip5r6eX5bs767wVg9VHO7TPFQAvfIXjxpzAOioST
         B/TdK+o/ceSru4g+L+c+NngoM95pnHGwfOnGDapOIH3PyLyykggOsApPlvuDwNpc0TgR
         JOqx8QqLCFEy21n4/bqsi7tKpEJAgIcLF/isePKP8krmptS1QyH1QQYMq6Z5yN27m1H9
         SVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MVY1O5dk1SXzLNgRmhqFt+rWU9l14EZcEJKYL99aj9w=;
        b=sEjVAG2DT8MCkqsdSqz/xR8gImQ3YkJCvOdej+NnfOnw5mVzgd1OHgiFoJIPnLH3Fb
         H7I+Nmg5/Kwfp4aKvHOGJBfAXHRTaJd5UAzgRizB0Lm3G2f8YYVN8kkiRgLSF4YGu0g5
         C3hvp6I0wh0Vt8CgCdXSlU702Db4mNW92tcfz6qjGRZTucN4mzO2400mcxBv4JF41ZMg
         BkCRenaa/RCVcl659JN6hbI/NbUpwaMiaK64vUCC1BtPOPf3xhkqI2+wG2FYKj2hRkHq
         ljBKFmFfpew1NVL9StN7XqIuhrtTnb+ORXMjEHYKo2CyEu0XQPmsNksQCZfydycR6Lwn
         a2pQ==
X-Gm-Message-State: APjAAAUsVhEjaidc5+9B+P6H8Sv1AS8Vf5nvazC3S5+U+XokkqgKWvQN
        /uVcbZofV6AOwG7DhQYEIMuuYQzr/DImMFkLyTVD2JzS
X-Google-Smtp-Source: APXvYqxB6oZ8Mdq5ilCz/+dsU+WgIaRRqdH1YNrPOn8IBAGlkTVKHbiMoZevZhhWNkeWhCqTOxlgIsYXbwc0dpG5WYQ=
X-Received: by 2002:a67:ea47:: with SMTP id r7mr5277029vso.100.1568898024494;
 Thu, 19 Sep 2019 06:00:24 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Thu, 19 Sep 2019 09:00:13 -0400
Message-ID: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
Subject: 5.3.0 Regression: rpc.nfsd v4 uninterruptible sleep for 5+ minutes
 w/o rpc-statd/etc
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     bcodding@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For a really long time (years?) if you forced NFS v4 only, you could
mask a lot of unnecessary services.

In /etc/nfs.conf, in "[nfsd] I've been able to set "vers3=n", and then
mask the following services:
* gssproxy
* nfs-blkmap
* rpc-statd
* rpcbind (service & socket)

Upgrading from 5.2.14 to 5.3.0, nfs-server.service (rpc.nfsd) has
exactly a 5 minute delay, and sometimes longer.

nfs-utils 2.4.1 (latest).  Downgrading only linux back to 5.2.14 makes
it work again.

Unmasking the above services/socket is a temporary workaround.

I'll mention I do include "ipv6.disable=1" in my kernel arguments,
since I see in strace it attempts using IPV6 and fails right after the
hang.  Don't think that's related, but just in case.

ALL DIAGNOSTICS BELOW are with everything commented in "/etc/exports",
because it reproduces the problem as well.  They are also with
everything commented in "/etc/nfs.conf" except for in "[nfsd]"
"vers3=n".

In IRC, bcodding said he's been looking at a similar bug, but that
probably isn't exactly like mine.  Potentially having to do with
changes of handling of ENOTCON and EAGAIN in net/sunrpc/clnt.c, not
sure if that refers to mine or his.

The default nfs.conf includes "[nfsd]... # debug=0" which sort of
suggests to get debugging information to set "debug=1".  But, doing
this gave "rpc.nfsd: Invalid debug facility: 1".  I also tried
"debug=0x7FFF" from debug.h for NFSDDBG_ALL, but it doesn't like that
either.  "man rpc.nfsd" shows the --debug option.  I disabled
nfs-server.service and rebooted to manually start it with this option,
and it gave a whopping 3 lines at start, and nothing during or after
the 5 minute delay:

=====
rpc.nfsd: knfsd is currently down
rpc.nfsd: Writing version string to kernel: -2 -3
rpc.nfsd: Created AF_INET TCP socket.
=====

The first time I ran strace, it goes into uninterruptible sleep and shows:

=====
openat(AT_FDCWD, "/proc/fs/nfsd/versions", O_RDONLY) = 3
read(3, <<the massive delay is here>>"-2 -3 +4 +4.1 +4.2\n", 128)    = 19
=====

After re-running it after speaking with bcodding, strace showed:

=====
bind(4, (sa_family=AF_INET, sin_port=htons(2049),
sin_addr=inet_addr("0.0.0.0")), 16) = 0
listen(4, 64) = 0
write(3 "4\n", 2<<the massive delay is here>>) = 2
=====

Not sure why the change in the strace hang spot.

After speaking with bcodding, he gave me a list of events to set,
visible here: http://ix.io/1nTX

I ran "strace rpc.nfsd --debug &> log" (so the strace and the --debug
is mixed) which is viewable here: http://ix.io/1o2s

And, the contents of /sys/kernel/debug/tracing/trace after it finally
completed was 143MB, compared to 5.2.14's 17K!  This trace including
the first and last 1000 lines, skipping the hundreds of thousands of
lines between so it's only 325K is viewable here: http://ix.io/1o2y

This trace only goes from kernel time 990.504680 to 995.938377.  I
think it must have hit a maximum MB or number of lines, because it
didn't come out of that for for 5 minutes.



He also asked to see the trace of it working (which I hope meant on
5.2.14, rather than with services unmasked.)

The 5.2.14 working strace with --debug is viewable here: http://ix.io/1o8V

And the 5.2.14 working trace is viewable here: http://ix.io/1ofY
