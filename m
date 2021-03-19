Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F5341859
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 10:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCSJb2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 05:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhCSJbI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616146268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWPYl+scBvanEZlNPOls+Aq3GI5Pv240j8HlXxWUWlg=;
        b=JsEs76wFW6RLbGa1ayytu55Bft/y0rIagkYI5K1qEFx2rd8VdLiROlcrFyMdgPXZ7+h6qZ
        aYjg5DlF19s9MYESIru5d4WUPvCJiB/AVt1P3VolUkYqizc30hHu7x6HoVOeDyv6BpZgcL
        1oC6vmgoueaqDEmFgn/Sbdy37uQhVqk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-la8XvjsnP2Wn98FVrhfokQ-1; Fri, 19 Mar 2021 05:31:06 -0400
X-MC-Unique: la8XvjsnP2Wn98FVrhfokQ-1
Received: by mail-yb1-f198.google.com with SMTP id a63so51629032yba.2
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 02:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWPYl+scBvanEZlNPOls+Aq3GI5Pv240j8HlXxWUWlg=;
        b=P766sjc8Jpvk94YDZBkeguSmxN08ajMpfCZwUqa54FUoXLv91GVo4DYqoIVFHw8pXS
         EdqyIuIvKelIeo9KHo+uFTnEue2C/BkscrAUEBdDvgUVJnXzpNx3cHdRNXnTsZG/t7iO
         nq63XI25VVpcp3oNdtbTEvWY1O90DR8YH20Syt9jO1TVgKHxYCjoR81ATdUgBWLoAEyr
         SnyC+kuvvMI8ZfZJgJXVpAiZOEczvc13ODf3Vd7ccQtwa1tRZOt4KDTITDj5Tn4jazfY
         uEAFDlU6tKzkAkL1ssQhcBckVD/DnGU3cFcX/XzXc3SOvEec+J2VlSvGGGPjBpqhveNU
         1caA==
X-Gm-Message-State: AOAM5332RoqIdmI0mumFlhJJMOyyzgq5CAoVbetAbVHEZd7r2KAFPvWR
        /DjV2Zrm5oOSz4+5PwFAhXvJ/530eUDS6AR7YxX50bFlgrK2Wuo7MsMeppD+Wj0OKaQh9xyjY3O
        RmTOASvR43zQJ/g/C61XNoGGMNyxlfnOiw/c3
X-Received: by 2002:a5b:d43:: with SMTP id f3mr5186032ybr.81.1616146265858;
        Fri, 19 Mar 2021 02:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDppFo8vSEmUFgrFmiHiXu1JlZwnIrVJYqN77n7RIDRHmo/1KHxeAq7W2sJEhhWSsmWvEqQu9sieiW2yieISI=
X-Received: by 2002:a5b:d43:: with SMTP id f3mr5186011ybr.81.1616146265623;
 Fri, 19 Mar 2021 02:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
 <CAN-5tyGz2HRq9Y7OcBDLQ4K+=d_oPe4nOQ+VM7QGU27ksJi6EQ@mail.gmail.com> <CAFqZXNucLwmqLA1doWp+0hnz1oTCoaNEb-jorAjpUurAu-Jf9Q@mail.gmail.com>
In-Reply-To: <CAFqZXNucLwmqLA1doWp+0hnz1oTCoaNEb-jorAjpUurAu-Jf9Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Mar 2021 10:30:53 +0100
Message-ID: <CAFqZXNsg=OKTrfmj3_JxevJ7nzCkNBBHHcxR6bQJDP2L4qhWvw@mail.gmail.com>
Subject: Re: Weird bug in NFS/SELinux
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 18, 2021 at 2:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Mar 18, 2021 at 2:43 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > On Thu, Mar 18, 2021 at 5:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Hello,
> > >
> > > While trying to figure out why the NFS tests in the selinux-testsuite
> > > [1] are failing, I ran into this strange bug: When I mount an NFS
> > > filesystem on some directory, and then immediately attempt to create
> > > exactly the same mount on the same directory (fails with -EBUSY as
> > > expected per mount(2)), then all the entries inside the mount (but not
> > > the root node) show up as unlabeled
> > > (system_u:object_r:unlabeled_t:s0). For some reason this doesn't
> > > happen if I list the directory contents between the two mounts.
> > >
> > > It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.
> > >
> > > Minimal reproducer (assumes an SELinux-enabled system and that nothing
> > > is mounted at /etc):
> > > ```
> > > # set up a trivial NFS export
> > > systemctl start nfs-server
> > > exportfs -o rw,no_root_squash,security_label localhost:/
> > >
> > > #
> > > # reference scenario - single mount
> > > #
> > > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > >
> > > ls -lZ /mnt    # labels are correct
> > > ls -lZd /mnt   # label is correct
> > >
> > > #
> > > # double mount - BUG
> > > #
> > > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > >
> > > ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
> > > ls -lZd /mnt   # label is correct
> > >
> > > #
> > > # double mount with ls in between - OK
> > > #
> > > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > > ls -lZ /mnt    # labels are correct
> > > ls -lZd /mnt   # label is correct
> > > mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
> > >
> > > ls -lZ /mnt    # labels are correct
> > > ls -lZd /mnt   # label is correct
> >
> > Hi Ondrej, a couple of questions about the reproducer. (1) are you
> > saying that only "mount, mount, ls" sequence is problematic as you
> > write "mount, ls, mount, ls" is correct? (2) what is your selinux
> > configuration. I can't reproduce it on my setup. I get the same labels
> > regardless of how many times I mount.
>
> (1) Yes, exactly.
> (2) I reproduced it reliably on clean Fedora VM images (e.g. Fedora 33
> or Rawhide, both showed this bug).

(Adding also linux-security-module@, since this affects the LSM interface.)

After some off-list exchange trying to get the bug to reproduce on
Olga's side, we have made some progress, so let me summarize our
findings here.

First, the issue only appears when you export the root directory, not
just some path underneath. I suspect that it could be any directory
with a mount on it rather than just the root dir, but I haven't
verified that...

Second, as Olga found out, the issue stems from the call to
security_sb_set_mnt_opts() (from nfs_get_root()) on an already
initialized superblock (AFAIK it is needed so that the LSM can check
if the security mount options match (and error out the mount if they
don't), where NFS processes the SECURITY_LSM_NATIVE_LABELS flag the
same way as on the first mount, but SELinux ignores it on the repeated
mount. Thus NFS turns off the NFS_CAP_SECURITY_LABEL flag and stops
fetching labels from the server, so fresh inodes then show up as
unlabeled.

So I think there are two options how to fix it:
1) Require filesystems to always pass (0, NULL) as kern_flags when
calling it on already initialized superblock - turning the labeling
support on/off for an existing superblock wouldn't work with SELinux
anyway.
2) When selinux_set_mnt_opts() is called again on a superblock,
validate that the passed kern_flags match the expected value (i.e. the
FS isn't trying to set an incompatible SECURITY_LSM_NATIVE_LABELS
setting) and also return back the same flags as on the first call.

It seems doing 1) would make the code in nfs_get_root() a bit ugly
(and it might require some changes in VFS, too), so I think I like 2)
more... SELinux/LSM folks, any thoughts?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

