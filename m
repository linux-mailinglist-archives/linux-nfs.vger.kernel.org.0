Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE05340294
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCRJ6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 05:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhCRJ55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 05:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616061477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=BH8P3EYwMkhigavw/TWThSE0zfS9S0sF0ekK5ILeyYM=;
        b=HZ9GiVamlK4cvjtsp7WHEyFHVAA+P+k25pLlOZ2LV467ukb2fqZcxg/JbNWohnbtFcSYg4
        hnyj8R1x+qLgr5JUD+2dd+u8i6IwuA0JXb3da4rf595vvu35mB/3rZIJT23XK62RFmp3Vb
        Z02vlIFs91qSd9O0DbSW3GafYZCr+i8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-YeSmt0bXOsakgqsDUimK_A-1; Thu, 18 Mar 2021 05:57:53 -0400
X-MC-Unique: YeSmt0bXOsakgqsDUimK_A-1
Received: by mail-yb1-f200.google.com with SMTP id j4so47697349ybt.23
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BH8P3EYwMkhigavw/TWThSE0zfS9S0sF0ekK5ILeyYM=;
        b=FHjcerLUftT/CbpSYqsUFr4RDcNNramI4pKWvHxUYHdMT8y7VgajDg02W3kt+pQLzW
         RDMLhKdJPBUPhxBAk1D9cvVx/Xj74TiRyA4SYZvUJWJaFX8wzKdQ4e8/XkdxqShdhZA0
         JomBDoUH3PQuslLWVjZpIsgPAuVKtI0Azqmyjw0Mp3tBIEHk0qPhT//aM4e6Ss4+xzdH
         6Cw6JMn0jt9mYAE0+MUvU5nERk2AJLfW23RgVqxyApEO0npz6SDmvarZM/RzSYeFAVAN
         13Ac6oKVutctRvMAfDn1dki+rzmyrOtFRCM8KGz9tm7h2c2rO0DVxkRSTlUQU1fxdt3R
         J7ww==
X-Gm-Message-State: AOAM531a1M+osxAzjV9uaaN1j7vd4uS4jium7po/54XH7k3yZqJEoGUk
        PXZluULNxoHw5WP/KcUyu7TLzeE+UkRW8x5DnFu7TMPl8/LHk9sM9Z3CJt2lwBRcbW93+dzIlBP
        VkrgFFe7HuoMCiCdG2GCdVZQLXwm4CgBQlS9m
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10724784ybp.436.1616061472517;
        Thu, 18 Mar 2021 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznWNgF+UqmwE0Vr1txYDJ6H9GSN5dwdTDRlHV9zJ2OgaCU49sN0AIkEpEkg4SrDkEi0koa5JJbYSDTwXVPM1c=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10724770ybp.436.1616061472336;
 Thu, 18 Mar 2021 02:57:52 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 10:57:40 +0100
Message-ID: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
Subject: Weird bug in NFS/SELinux
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

While trying to figure out why the NFS tests in the selinux-testsuite
[1] are failing, I ran into this strange bug: When I mount an NFS
filesystem on some directory, and then immediately attempt to create
exactly the same mount on the same directory (fails with -EBUSY as
expected per mount(2)), then all the entries inside the mount (but not
the root node) show up as unlabeled
(system_u:object_r:unlabeled_t:s0). For some reason this doesn't
happen if I list the directory contents between the two mounts.

It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.

Minimal reproducer (assumes an SELinux-enabled system and that nothing
is mounted at /etc):
```
# set up a trivial NFS export
systemctl start nfs-server
exportfs -o rw,no_root_squash,security_label localhost:/

#
# reference scenario - single mount
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct

#
# double mount - BUG
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
ls -lZd /mnt   # label is correct

#
# double mount with ls in between - OK
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct
```

I haven't had time to dig deeper. Hopefully someone who knows the
internals of NFS will be able to find the root cause easier than me...

[1] https://github.com/SELinuxProject/selinux-testsuite/

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

