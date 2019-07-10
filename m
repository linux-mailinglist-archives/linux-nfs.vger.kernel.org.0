Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16899644F7
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGJKL7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 06:11:59 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:41527 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJKL6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jul 2019 06:11:58 -0400
Received: by mail-qt1-f182.google.com with SMTP id d17so1753288qtj.8
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 03:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rPC6w2yZfS5kO49QVMiE3aHv0vNI2/1t0uK8dKOd1uc=;
        b=T9uLAnYwMAFCcupJ1KSPoZrP8uWYSrL8cZ9UUM3LTwW97lEAQ8dROZyUgwCobtmC9s
         fBLZ03YKTQJzsMfu8tOFPy4U+6GaQskTgAPzdT15Twt/XJIU09Ts6culaxtuJ2bkm44s
         Dk6Sd52Pw01QF1pzhTaC31Oy0onoOVIw3KcxoPcrUM41LVkwNrIG+eL/FC8dI5v9w2ev
         4Dqzc51jjn1JXgybJf0HY2BNEnvJQmNALHha9Tr3wDgzjs53AuUX+cQKyz9odG0RyghG
         Fej/CAbNOGzlAS1kDfMyQ/NgIAmaOtioFq6WAjFiIOiBN5DE6hOmX/NoUwWrGWQZcBRI
         asjw==
X-Gm-Message-State: APjAAAUFxY0mdoY4AWxkNwxXld3v2sCxJb17Mc0bFPgKlM+BerysUMqN
        lgoJpArcUa7nlI0Ctx3IUg0NVBPW7EbHQ6pCcygkJql1468=
X-Google-Smtp-Source: APXvYqwHc0t2Z8fV+XrMd2J+vMJZz3x/w6RctiAC5Lc5/O8YbfqwYEaiFNP0LliFzmGsA4Cbz4IU5BlNw+8QG7rfcNs=
X-Received: by 2002:a0c:818f:: with SMTP id 15mr22674108qvd.162.1562753517867;
 Wed, 10 Jul 2019 03:11:57 -0700 (PDT)
MIME-Version: 1.0
From:   John Dorminy <jdorminy@redhat.com>
Date:   Wed, 10 Jul 2019 06:11:46 -0400
Message-ID: <CAMeeMh9xmfwo9gY_h_9DMQeobzjXOMnC9iH=Whz=UkJeUSVq6w@mail.gmail.com>
Subject: Request for help debugging readdirplus malfunction on NFS v3
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings;

In the lab for the group I'm in, we have three NFS servers each
serving different parts of our shared filesystem. However, as of
kernel 5.1 or so on the clients, the clients have ceased working: a
'ls' on any directory within one mountpoint (the only one hosted on
one server) fails to show any files.

The mount is:
nfs-02:/nbu1 on /p/not-backed-up type nfs
(rw,noatime,vers=3,rsize=65536,wsize=65536,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.19.119.4,mountvers=3,mountport=4048,mountproto=udp,local_lock=none,addr=10.19.119.4)

Bisection on the client side indicates
be4c2d4723a4a637f0d1b4f7c66447141a4b3564 is the commit at which this
mountpoint ceases to work. `rpcdebug -m nfs -s all` results in the
following going to dmesg:
[10146.723030] NFS call  readdirplus 162
[10146.724908] NFS reply readdirplus: -2
[10146.725429] NFS: readdir(/) returns -2

I'm somewhat out of ideas; are there other tools I should be using to
hunt this down, short of adding print statements? and is this a known
bug already?

Thanks in advance!

John Dorminy
