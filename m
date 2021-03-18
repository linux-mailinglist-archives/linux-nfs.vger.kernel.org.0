Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AC34074F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCRN6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhCRN6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 09:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jgR9P6jXbSYMZFd8LHTG7QkBS3y37YvafT4UHNYN44=;
        b=DqzQ/eJrdE4bDQom7boENqw2UP0oObhMT+vP+IEQfJFpswSJQ0x1jmGx71P7UUErmY4qxV
        RaSINUAy+da+Po5VNNk8K4/kaacvkiDBBYIIKTlIF7xRQQ/+aWapExxc58fQgCryP7xcAI
        f6/JsnAtLuBHV1MXJjvmtnhOpY+QhIk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-4c-AnGOqPpGHgd9FIQBE2g-1; Thu, 18 Mar 2021 09:58:06 -0400
X-MC-Unique: 4c-AnGOqPpGHgd9FIQBE2g-1
Received: by mail-yb1-f199.google.com with SMTP id o9so48249043yba.18
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 06:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jgR9P6jXbSYMZFd8LHTG7QkBS3y37YvafT4UHNYN44=;
        b=NeZUDrYfc5L9QfnAOxXnOypkSZo/kDa4K70RZd90UI868cz+fkQsUEzBanEXhAjDV2
         eoQ3E3/u9gHfM9GsMAftur+qsyeo8NdDS2TpuMbXIxOT2VU3BXjUSfBlzBRnvak85+iv
         cLV1X/KUeN2k05hX2GrMyrhSTuhB4piitU8n4rN9TkZAnOtR6c9YSi3UcHsFKaI7hMsd
         WtniWv36tE8yZcdtSCNOuP+zJQxj6Sr2gAtFDPZGd+WBQN12y0DhGT66rwzwPU8DPSM1
         iQdD0gba6UrqTm+vTH/MEsy4kgjg8fbN9Ao7irJjxDOAMej2SfQGjwfiWsBl49HgrUlW
         zXBg==
X-Gm-Message-State: AOAM532mnFVgsIYl9yeZDJt5q5Y+GsI2wj9eDLSz846/8nvfUvz/4sZW
        kM4sG3gD0vDYdLlRKBqals99lgUvrfKVgGerO8UHfGZqPO2+LDODZ+5JHQR/oKNKPHRirdbYUJF
        AzWS584dJZ9wwZCER8BE2GgiOT4BCnhpMUcO+
X-Received: by 2002:a5b:4a:: with SMTP id e10mr12107228ybp.436.1616075885891;
        Thu, 18 Mar 2021 06:58:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6iENcOP9Iytb2p/EfsHP6bxrvV0bORQGQGChlmVaavuao4Xi0oHqdPx9N2LVgYbrTKoELebDj3q69Pz/ewFY=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr12107202ybp.436.1616075885678;
 Thu, 18 Mar 2021 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
 <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 14:57:53 +0100
Message-ID: <CAFqZXNucLwmqLA1doWp+0hnz1oTCoaNEb-jorAjpUurAu-Jf9Q@mail.gmail.com>
Subject: Re: Weird bug in NFS/SELinux
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 18, 2021 at 2:43 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Thu, Mar 18, 2021 at 5:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hello,
> >
> > While trying to figure out why the NFS tests in the selinux-testsuite
> > [1] are failing, I ran into this strange bug: When I mount an NFS
> > filesystem on some directory, and then immediately attempt to create
> > exactly the same mount on the same directory (fails with -EBUSY as
> > expected per mount(2)), then all the entries inside the mount (but not
> > the root node) show up as unlabeled
> > (system_u:object_r:unlabeled_t:s0). For some reason this doesn't
> > happen if I list the directory contents between the two mounts.
> >
> > It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.
> >
> > Minimal reproducer (assumes an SELinux-enabled system and that nothing
> > is mounted at /etc):
> > ```
> > # set up a trivial NFS export
> > systemctl start nfs-server
> > exportfs -o rw,no_root_squash,security_label localhost:/
> >
> > #
> > # reference scenario - single mount
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
> >
> > #
> > # double mount - BUG
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
> > ls -lZd /mnt   # label is correct
> >
> > #
> > # double mount with ls in between - OK
> > #
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
> > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> >
> > ls -lZ /mnt    # labels are correct
> > ls -lZd /mnt   # label is correct
>
> Hi Ondrej, a couple of questions about the reproducer. (1) are you
> saying that only "mount, mount, ls" sequence is problematic as you
> write "mount, ls, mount, ls" is correct? (2) what is your selinux
> configuration. I can't reproduce it on my setup. I get the same labels
> regardless of how many times I mount.

(1) Yes, exactly.
(2) I reproduced it reliably on clean Fedora VM images (e.g. Fedora 33
or Rawhide, both showed this bug).

>
>
> > ```
> >
> > I haven't had time to dig deeper. Hopefully someone who knows the
> > internals of NFS will be able to find the root cause easier than me...
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> >
> > --
> > Ondrej Mosnacek
> > Software Engineer, Linux Security - SELinux kernel
> > Red Hat, Inc.
> >
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

