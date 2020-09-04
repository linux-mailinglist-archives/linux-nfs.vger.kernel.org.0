Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3F25E15B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgIDSJU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgIDSJN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 14:09:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53FC061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 11:09:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so6873131wmh.4
        for <linux-nfs@vger.kernel.org>; Fri, 04 Sep 2020 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+lakTHwbGntjsC/kDUMwo5UMnQ5GSDBrqPuhv74rPk=;
        b=KGKpwekwlmwiVIitwFrxOImPcoDsLHx3TbVhgQiNOy4z1KAzMcwLIEGwQ3O1yg3ElD
         vo9rfqy99iMSxw3IiYfv6rumH89fnleR8NPkhk3FUnIzesUZjcQW399coWQlPHh412Pq
         lAh5vsulo5pk328TR5BAvXUUzXIGX4Ao0mCa4gEQLdu7sePFKzLepaoJdjGZGLe51DEI
         GSu8iX5nVCOOqke7oWtcASMKJxl+/8QORdI6Dj5FAtU0niBAVxQUe7eu4COtssZxHwZp
         E5PcNx1+RJ6Yj0JqOvKQwRdQVM8JC3zFl7u/m0Bw0q+jG33N4IF5a97DTYjw3XBFQzGy
         +THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+lakTHwbGntjsC/kDUMwo5UMnQ5GSDBrqPuhv74rPk=;
        b=SLdqA5cONOxcf9s4TLvEGh9iARudDg4f2DK3GBsI2eKSOjoj2qZR1/Kl/CSUL/HhvQ
         cnDKQ8Ks6eWw/d2X/88+bG133fU9mnyqsPoQ/rjvd/vmNXoZbIVOeOek7+k7dObrU6z3
         HrhswBQ6Akzl/yEmDl59xrEFmxtFs5lZZWTYTvYSeQ3KdpSB9IOEDGZehfexBfbz1sLx
         J64Ro5BfGneprK1UDmJWfF/qaTtQDClo1Z2DVRJUVWDBhQAFOzYssWV5z4TQB8uLKjBV
         h3w+sn+bOIugHmkp3V96UynXNRQBrffKioCUiHGTC17likaNuf4ZkwgK8p5rxXcWK5Gs
         QwCQ==
X-Gm-Message-State: AOAM533xBMNfMu0eVomUbDU7BHZeK44Da8zIOnp3go0docffPiYEQAoO
        41m3ay2eFnUnVbv79rDPLF8x08AHU75COMqApZ0=
X-Google-Smtp-Source: ABdhPJztqaUnPkUcSUHNHrXdeAtuXI1k6yVDDRe273S9ZLm6DsaLYT6tE0fKb3ju2ntC+cPvWVWSlKxZRyianw+AIXc=
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr8655958wmg.120.1599242951719;
 Fri, 04 Sep 2020 11:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8zhTCZmZTosrtKbBatXo40Lt40OfzsZGw7tzHdcP4xo9rWCg@mail.gmail.com>
 <CAD8zhTDOZyhDnOqqO0uUVfscPFXj391frTEKT3dLu9rNZVNtzQ@mail.gmail.com>
 <CAD8zhTAA2c+cSNxDWwHnEa3-DTm8AEZKVMo7Xw9Wwpv8Wfsfzg@mail.gmail.com> <0226355B-58CD-4792-B7B9-B4447CC4FD7F@redhat.com>
In-Reply-To: <0226355B-58CD-4792-B7B9-B4447CC4FD7F@redhat.com>
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Fri, 4 Sep 2020 11:09:00 -0700
Message-ID: <CAD8zhTD7mPjiUkRn_crywXDNP2kWGpMc8M4QFTG1T9eihuz9XQ@mail.gmail.com>
Subject: Re: Wrong mode bits in stat of NFSv4 referral directories.
To:     Benjamin Coddington <bcodding@redhat.com>, bjschuma@netapp.com,
        Trond.Myklebust@netapp.com
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Benjamin. Looks like it is added as part of commit
72de53ec4bca39c26709122a8f78bfefe7b6bca4 by Bryan Schumaker.

Given that neither chmod nor readdir traverses the referral mount
points, wouldn't this be an issue to return mode bits as 0555?
The issue I see is with rsync. rsync first creates the directory and
calls chmod. If this directory happens to be a referral mount, then
chmod fails because the user doesn't have write access (0555).

Thanks

On Fri, Sep 4, 2020 at 10:15 AM Benjamin Coddington <bcodding@redhat.com> w=
rote:
>
> Probably in nfs_fixup_secinfo_attributes(), and looks deliberate.  I'm no=
t
> sure about the reasoning behind it, though.  Maybe it's to clarify that y=
ou
> can't traverse this directory.
>
> Ben
>
> On 4 Sep 2020, at 12:57, Pradeep wrote:
>
> > Just to add, if you look at packet 100 (READDIR response) in tcpdump,
> > the mode bits are set to 0755. But what is displayed by "ls" is 0555.
> > I'm trying to figure out where that one bit gets lost.
> >
> > On Fri, Sep 4, 2020 at 8:55 AM Pradeep <pradeepthomas@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> I'm seeing an issue where stat (and ls) reports wrong mode bits on
> >> referral directories. Actual permissions are 755; but Linux client
> >> displays 555. This causes some operations like setattr (chmod) to
> >> fail. Traversing to the directory fixes the issue.
> >>
> >> Kernel version : 5.8.6-2.el7.elrepo.x86_64
> >>
> >> [nfstest@centos77 ~]$ mkdir /mnt/nfsh1/dir.{1..5}
> >> [nfstest@centos77 ~]$ ls -l /mnt/nfsh1
> >> total 3
> >> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.1
> >> drwxr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.2
> >> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.3
> >> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.4
> >> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.5
> >> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
> >>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
> >>   Size: 2               Blocks: 1          IO Block: 1048576 directory
> >> Device: 30h/48d Inode: 3940649673949864  Links: 2
> >> Access: (0555/dr-xr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   whee=
l)
> >> Context: system_u:object_r:nfs_t:s0
> >> Access: 2020-09-03 17:55:59.082327209 -0400
> >> Modify: 2020-09-03 17:55:59.082327209 -0400
> >> Change: 2020-09-03 17:55:59.082327209 -0400
> >>  Birth: -
> >> [nfstest@centos77 ~]$ ls /mnt/nfsh1/dir.1  <-- Try traversing into the
> >> dir, see the mode bits in stat after traversal.
> >> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
> >>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
> >>   Size: 2               Blocks: 1          IO Block: 32768  directory
> >> Device: 32h/50d Inode: 3940649673949864  Links: 2
> >> Access: (0755/drwxr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   whee=
l)
> >> Context: system_u:object_r:nfs_t:s0
> >> Access: 2020-09-03 17:55:59.082327209 -0400
> >> Modify: 2020-09-03 17:55:59.082327209 -0400
> >> Change: 2020-09-03 17:55:59.082327209 -0400
> >>  Birth: -
> >>
> >> Attached is the tcpdump for requests. It looks like the server sends
> >> back correct attributes; but the client somehow is ignoring it. Any
> >> ideas why?
> >>
> >> Thanks,
> >> Pradeep
>
