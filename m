Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD225E18E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIDSpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSpv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 14:45:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01CC061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 11:45:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c18so7798729wrm.9
        for <linux-nfs@vger.kernel.org>; Fri, 04 Sep 2020 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8hZ/r1J5FeVhW6NOVUjmmDXeipybW7e+yaxftUWIvSY=;
        b=P2w61KuUaCAinE0raAnCANCz9wKvZ5Iozsra+KJ9RfpK92quyrt+KMzfQW4Pf26P5+
         BsxRNV7P2g0J+oWvpGjlKG0SaUGbgJ1p80Btj/xVXAKdYqKWO3RfA7aTq5OKS7AN7yRK
         x5O5Vqes+xTUgeNczI9Mu4RqGi129bhnthR4dv6SKQAAeyKOPbmzDHgBYpI4n+eqxBq1
         rofeq97TaMRUoMf7nc8x8lclvA5tJ6+JuMzUK5sQBBq61uB2bx1gC3nbBKE4GJTYztFP
         UmEZ8Er2bMHLPoZn1UW4PjUBmB2ZoHWMCEceggXF3v29lk0cuQ0EHB/ASRMTVCr7OGjv
         vARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8hZ/r1J5FeVhW6NOVUjmmDXeipybW7e+yaxftUWIvSY=;
        b=qFYJkBc/cXuaYNkx/51fKORwL1munAAg7FQPVLEJQTTOpj7M7aEcQ1IrA4uf81zOZS
         LHeUG5+M31MvAuOJ+cWeZHR+HNwv0/t6YHZLWv5spCuoadhucE3OeCpX1iD77IAIaJDe
         edyjMcnxmShG+OyAaefCytge9XpJ7Jlgm+0vj8tD6ymFZ7FVuWbVT3Q9Xnt9kEkZ9Vsv
         OPy9swMioaijcqYRRjaCj8oIhvg3upVw2jsTGN2bASzWU3FKcAMy+2n+RIjynWxG7kzx
         3uLPjEeQWAMcoF7LjrxYxlweJhQ1O6Ohb2tIdPjDj2X05eFvsX1Pm6M5W20yCGSKPs+K
         8KxQ==
X-Gm-Message-State: AOAM532I0TTvjRMku6kmUMB6iJGeN3n9oRoGy04xBAeyrDMaSkEMFR4T
        mzvKkndaVrsD60di29CvKBJlvhMblEgP3lLraMdNPVFRbwA=
X-Google-Smtp-Source: ABdhPJzBAmZtM3YbI0UcuN77obO8R3ckaYp4dr7Ijt3Z8uvsNbfwTMtXPj+4gQ3qvSmiHRKb5ne5r7cshyBkX25KpJg=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr8857861wrw.221.1599245149169;
 Fri, 04 Sep 2020 11:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8zhTCZmZTosrtKbBatXo40Lt40OfzsZGw7tzHdcP4xo9rWCg@mail.gmail.com>
 <CAD8zhTDOZyhDnOqqO0uUVfscPFXj391frTEKT3dLu9rNZVNtzQ@mail.gmail.com>
 <CAD8zhTAA2c+cSNxDWwHnEa3-DTm8AEZKVMo7Xw9Wwpv8Wfsfzg@mail.gmail.com>
 <0226355B-58CD-4792-B7B9-B4447CC4FD7F@redhat.com> <CAD8zhTD7mPjiUkRn_crywXDNP2kWGpMc8M4QFTG1T9eihuz9XQ@mail.gmail.com>
 <A1BD3037-ED80-4D52-B6C8-6F837F2522E9@redhat.com> <D3940145-0F4F-4759-A3CF-767DF859F95F@redhat.com>
In-Reply-To: <D3940145-0F4F-4759-A3CF-767DF859F95F@redhat.com>
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Fri, 4 Sep 2020 11:45:37 -0700
Message-ID: <CAD8zhTDD7x78gO_T1UiqnCHuLXLpZPkO8-qok_=Q1dHXUSXpdw@mail.gmail.com>
Subject: Re: Wrong mode bits in stat of NFSv4 referral directories.
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes Benjamin. If the referral mounts already exist, then rsync will
try to chmod to the source. That will not work because of mode bits.
rsync will continue to traverse into the referral mount and create
inner directories and copy other stuff. At the end, it will copy
everything except the attributes for referral mounts and also displays
an error. This is what I see:

[nfstest@centos77 ~]$ mkdir rsync-dataset
[nfstest@centos77 ~]$ mkdir -p rsync-dataset/dir.{1..5}
[nfstest@centos77 ~]$ touch rsync-dataset/dir.{1..5}/file
[nfstest@centos77 ~]$ rsync -avz rsync-dataset/* /mnt/nfsh1/
sending incremental file list
rsync: failed to set times on "/mnt/nfsh1/dir.1": Permission denied (13)
rsync: failed to set times on "/mnt/nfsh1/dir.3": Permission denied (13)
rsync: failed to set times on "/mnt/nfsh1/dir.4": Permission denied (13)
rsync: failed to set times on "/mnt/nfsh1/dir.5": Permission denied (13)
dir.1/
dir.1/file
dir.2/
dir.2/file
dir.3/
dir.3/file
dir.4/
dir.4/file
dir.5/
dir.5/file

sent 432 bytes  received 439 bytes  1,742.00 bytes/sec
total size is 0  speedup is 0.00
rsync error: some files/attrs were not transferred (see previous
errors) (code 23) at main.c(1179) [sender=3D3.1.2]

On Fri, Sep 4, 2020 at 11:30 AM Benjamin Coddington <bcodding@redhat.com> w=
rote:
>
> Ah, maybe you're just trying to copy the NFS namespace and cross the
> referral, not actually create a new referral.  In that case - yes,
> perhaps
> this needs a fixup.  We might look at how rsync crosses other
> mountpoints,
> because I think the same problem would exist.  You'd want rsync to
> create
> the directory with the attributes of the root of the mounted filesystem,
> not
> the mountpoint.
>
> Ben
>
> On 4 Sep 2020, at 14:20, Benjamin Coddington wrote:
>
> > I don't understand how the client can create a directory that can be a
> > referral.  Doesn't the directory have to be a mountpoint on the
> > server?
> >
> > I don't think that rsync can copy a namespace that contains refferal
> > mounts
> > from the client side, but maybe I am really misunderstanding things..
> >
> > Ben
> >
> > On 4 Sep 2020, at 14:09, Pradeep wrote:
> >
> >> Thanks Benjamin. Looks like it is added as part of commit
> >> 72de53ec4bca39c26709122a8f78bfefe7b6bca4 by Bryan Schumaker.
> >>
> >> Given that neither chmod nor readdir traverses the referral mount
> >> points, wouldn't this be an issue to return mode bits as 0555?
> >> The issue I see is with rsync. rsync first creates the directory and
> >> calls chmod. If this directory happens to be a referral mount, then
> >> chmod fails because the user doesn't have write access (0555).
> >>
> >> Thanks
> >>
> >> On Fri, Sep 4, 2020 at 10:15 AM Benjamin Coddington
> >> <bcodding@redhat.com> wrote:
> >>>
> >>> Probably in nfs_fixup_secinfo_attributes(), and looks deliberate.
> >>> I'm not
> >>> sure about the reasoning behind it, though.  Maybe it's to clarify
> >>> that you
> >>> can't traverse this directory.
> >>>
> >>> Ben
> >>>
> >>> On 4 Sep 2020, at 12:57, Pradeep wrote:
> >>>
> >>>> Just to add, if you look at packet 100 (READDIR response) in
> >>>> tcpdump,
> >>>> the mode bits are set to 0755. But what is displayed by "ls" is
> >>>> 0555.
> >>>> I'm trying to figure out where that one bit gets lost.
> >>>>
> >>>> On Fri, Sep 4, 2020 at 8:55 AM Pradeep <pradeepthomas@gmail.com>
> >>>> wrote:
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> I'm seeing an issue where stat (and ls) reports wrong mode bits on
> >>>>> referral directories. Actual permissions are 755; but Linux client
> >>>>> displays 555. This causes some operations like setattr (chmod) to
> >>>>> fail. Traversing to the directory fixes the issue.
> >>>>>
> >>>>> Kernel version : 5.8.6-2.el7.elrepo.x86_64
> >>>>>
> >>>>> [nfstest@centos77 ~]$ mkdir /mnt/nfsh1/dir.{1..5}
> >>>>> [nfstest@centos77 ~]$ ls -l /mnt/nfsh1
> >>>>> total 3
> >>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.1
> >>>>> drwxr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.2
> >>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.3
> >>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.4
> >>>>> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.5
> >>>>> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
> >>>>>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
> >>>>>   Size: 2               Blocks: 1          IO Block: 1048576
> >>>>> directory
> >>>>> Device: 30h/48d Inode: 3940649673949864  Links: 2
> >>>>> Access: (0555/dr-xr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/
> >>>>> wheel)
> >>>>> Context: system_u:object_r:nfs_t:s0
> >>>>> Access: 2020-09-03 17:55:59.082327209 -0400
> >>>>> Modify: 2020-09-03 17:55:59.082327209 -0400
> >>>>> Change: 2020-09-03 17:55:59.082327209 -0400
> >>>>>  Birth: -
> >>>>> [nfstest@centos77 ~]$ ls /mnt/nfsh1/dir.1  <-- Try traversing into
> >>>>> the
> >>>>> dir, see the mode bits in stat after traversal.
> >>>>> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
> >>>>>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
> >>>>>   Size: 2               Blocks: 1          IO Block: 32768
> >>>>> directory
> >>>>> Device: 32h/50d Inode: 3940649673949864  Links: 2
> >>>>> Access: (0755/drwxr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/
> >>>>> wheel)
> >>>>> Context: system_u:object_r:nfs_t:s0
> >>>>> Access: 2020-09-03 17:55:59.082327209 -0400
> >>>>> Modify: 2020-09-03 17:55:59.082327209 -0400
> >>>>> Change: 2020-09-03 17:55:59.082327209 -0400
> >>>>>  Birth: -
> >>>>>
> >>>>> Attached is the tcpdump for requests. It looks like the server
> >>>>> sends
> >>>>> back correct attributes; but the client somehow is ignoring it.
> >>>>> Any
> >>>>> ideas why?
> >>>>>
> >>>>> Thanks,
> >>>>> Pradeep
> >>>
>
