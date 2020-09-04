Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55C25E067
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIDQ53 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIDQ52 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 12:57:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2EC061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 09:57:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so7415647wrr.4
        for <linux-nfs@vger.kernel.org>; Fri, 04 Sep 2020 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EHTUIr4MoKP289Vi/TDwsyAsUxfyHh6sVbZgS1JirS8=;
        b=rvRcolFsYqVLxwWkzLU0vYqw8s+GFFG3rqRYufBvgw7XgkEDMIGEw2Pka5nVlL/0OY
         WHLVZSrXCyV9chr32L4yKGgRC/2vneOdRYnvQ1swa/HSpPw+f1WQI9NFHNlz/8vxC8Vo
         1aRn//b1S4wmHdizDICBCaPGdb1edjOz4EZ+vVOMcagkbt9to3s68QYBT3O/HmGDJYz+
         Ox98jNHNuRMvA3xIEA9754tzibssCF74wNSC2INaxEID67uOEH2vUjpKuP0lsWHr7ZnW
         26xpVCdFjsM7YVGaPV1xWqAycuJY+Uzxtz0MrcihNbK4nA/i6xE9G3JvjPi/m2NCOWJ7
         HJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EHTUIr4MoKP289Vi/TDwsyAsUxfyHh6sVbZgS1JirS8=;
        b=NNgMbCWaXKcmyLv8gJKEze2pizrc9ChEOw+kI0TAQmVnFQZdR0f0GoGrS3EPlfnUUU
         Yg/th9a067WzEGg9Qlmx8sOrTuQho2c8tnmFPhPsiiLhvcSobFvhydLhB1vhAIDi7RuZ
         siSgdaSvWK02IyfWsNdGxD7RmVz+mbYlgrMPDRLcZRehzlJB7ifVpE8TQIOhxOiKt8O7
         UVF269P0qNKLutxjpoH/thU3mCU70sSL+sZ7HNh/WXhuMErI7G6p+0z6+S3kx3Y16lFJ
         J/elBOnfZUoTgUOrfOIdj8i7ZBlUwy2EeWQIALbMb915s13poiZSueU7weVgqF2EnK8N
         jLzQ==
X-Gm-Message-State: AOAM532PJJX9QQNFjAJV+UYt8NJTx5WpZICnzW88pJdDywwO7LLxyd6y
        r4G0Ks6pZnU1uNnggVbdQZ2z4c99l/o97NlyREekN7tL
X-Google-Smtp-Source: ABdhPJwpq2QTBZB0TMG6wSgpmlMUo0WG/lhzMOYAQ2m36ordRoRsv5NwgnGfdZYCpxc97UFWcUOZtT9loeEHq/n549U=
X-Received: by 2002:adf:df81:: with SMTP id z1mr8927128wrl.9.1599238644335;
 Fri, 04 Sep 2020 09:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8zhTCZmZTosrtKbBatXo40Lt40OfzsZGw7tzHdcP4xo9rWCg@mail.gmail.com>
 <CAD8zhTDOZyhDnOqqO0uUVfscPFXj391frTEKT3dLu9rNZVNtzQ@mail.gmail.com>
In-Reply-To: <CAD8zhTDOZyhDnOqqO0uUVfscPFXj391frTEKT3dLu9rNZVNtzQ@mail.gmail.com>
From:   Pradeep <pradeepthomas@gmail.com>
Date:   Fri, 4 Sep 2020 09:57:13 -0700
Message-ID: <CAD8zhTAA2c+cSNxDWwHnEa3-DTm8AEZKVMo7Xw9Wwpv8Wfsfzg@mail.gmail.com>
Subject: Re: Wrong mode bits in stat of NFSv4 referral directories.
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just to add, if you look at packet 100 (READDIR response) in tcpdump,
the mode bits are set to 0755. But what is displayed by "ls" is 0555.
I'm trying to figure out where that one bit gets lost.

On Fri, Sep 4, 2020 at 8:55 AM Pradeep <pradeepthomas@gmail.com> wrote:
>
> Hello,
>
> I'm seeing an issue where stat (and ls) reports wrong mode bits on
> referral directories. Actual permissions are 755; but Linux client
> displays 555. This causes some operations like setattr (chmod) to
> fail. Traversing to the directory fixes the issue.
>
> Kernel version : 5.8.6-2.el7.elrepo.x86_64
>
> [nfstest@centos77 ~]$ mkdir /mnt/nfsh1/dir.{1..5}
> [nfstest@centos77 ~]$ ls -l /mnt/nfsh1
> total 3
> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.1
> drwxr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.2
> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.3
> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.4
> dr-xr-xr-x. 2 nfstest wheel 2 Sep  3 17:55 dir.5
> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
>   Size: 2               Blocks: 1          IO Block: 1048576 directory
> Device: 30h/48d Inode: 3940649673949864  Links: 2
> Access: (0555/dr-xr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   wheel)
> Context: system_u:object_r:nfs_t:s0
> Access: 2020-09-03 17:55:59.082327209 -0400
> Modify: 2020-09-03 17:55:59.082327209 -0400
> Change: 2020-09-03 17:55:59.082327209 -0400
>  Birth: -
> [nfstest@centos77 ~]$ ls /mnt/nfsh1/dir.1  <-- Try traversing into the
> dir, see the mode bits in stat after traversal.
> [nfstest@centos77 ~]$ stat /mnt/nfsh1/dir.1
>   File: =E2=80=98/mnt/nfsh1/dir.1=E2=80=99
>   Size: 2               Blocks: 1          IO Block: 32768  directory
> Device: 32h/50d Inode: 3940649673949864  Links: 2
> Access: (0755/drwxr-xr-x)  Uid: ( 2000/ nfstest)   Gid: (   10/   wheel)
> Context: system_u:object_r:nfs_t:s0
> Access: 2020-09-03 17:55:59.082327209 -0400
> Modify: 2020-09-03 17:55:59.082327209 -0400
> Change: 2020-09-03 17:55:59.082327209 -0400
>  Birth: -
>
> Attached is the tcpdump for requests. It looks like the server sends
> back correct attributes; but the client somehow is ignoring it. Any
> ideas why?
>
> Thanks,
> Pradeep
