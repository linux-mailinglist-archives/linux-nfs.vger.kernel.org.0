Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1082FE8FA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbhAULim (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 06:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbhAULXP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 06:23:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE7C061757
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 03:22:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o17so2014113lfg.4
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hFUyJXqwbukFsaI+Z+xn6Xv3D3xtO/+AtcCpzqs+Dg=;
        b=q9dasez7anKwI0iSoJj3jd13LrO9P8iq88rm7ICgXz8+yId+iQa7NgxGfr69JyrKcI
         Jins0Yw2JP1B8P6BFf1ZOFQZi8RM6qIUmc8ABWcB89Fw/fAM9yMMDZ9ZAxxRSRWRg8rG
         10eFdpD8acMnleObz4i2ERXzg1maPiDfay7fLmSpZPrTsyjVJr+VCdr69ERR8XtAI58D
         OKUcpea5I4/kw5maCNM2Jy1uZap3Lva+/1nOJBD7HNan6ujEN2f7M0LnRzvGmm9wTFVs
         LXBNsD2SCOjicaBjGFgkMQzA8vsMs+ILDoL1MlbPtaUnE53Iu6tswfzXhPzKzm63dthg
         OOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hFUyJXqwbukFsaI+Z+xn6Xv3D3xtO/+AtcCpzqs+Dg=;
        b=WSvRDR9yly5zJdVA8r3ckUGY8WDhvdQS5tPS+GWTO26T/tKn2wTH14L8/x9Mad8SAi
         rA814vnOcqXlkrD3fh+zrrzJ8ayOIPN713etixTOQ+5d/gh9OuCrpab9DYi6Zv2xkFwu
         nZFTAj88KhZyQSdD1JMxRY20Rk9IH+XT4Q3h4eWmyTOLA646U7jUYTlhkOgPtR8iuW5Z
         STnQb+StL25l5Wpr8BWxr6LFsGwJphypGAsS1rAcrWyw1eaf7balgh8DiYhTUWURKsu1
         t6Qe+PRu/4CVZ0Z94asdwe/0fAL2wmsFi7yGNz4maFerQnM5QcNuYHRFUGxZrtX1MiUx
         5Aiw==
X-Gm-Message-State: AOAM530O6t4kMPXHGgnvEHZo3DkK6n5YbWsS3LwHd3lR5OU2gwwaP/Cs
        GLpOMYYQDXO64lqpGdeQrAe7o2fEcD21EARuqiHjM8CN4qG4TvXu
X-Google-Smtp-Source: ABdhPJzjG7ZAxT6lqAGLTakuB//n/SO3Miy898oEdfWLL4+ykPLxg87xbdabmOfzx3Vp80OqiP4xcs4bpQlZvBbcbZA=
X-Received: by 2002:a19:f016:: with SMTP id p22mr2480742lfc.402.1611228152827;
 Thu, 21 Jan 2021 03:22:32 -0800 (PST)
MIME-Version: 1.0
References: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
 <20210119180204.GA24213@fieldses.org>
In-Reply-To: <20210119180204.GA24213@fieldses.org>
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Thu, 21 Jan 2021 11:21:56 +0000
Message-ID: <CA+QRt4sxwMTTWpropg=O=XdJ42P+2H=jbrwC8E1n=gt+je6iXQ@mail.gmail.com>
Subject: Re: Linux 5.11 Kernel: NFS re-export errors with older nfs-utils
 package versions
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the response. Comments inline below.

On Tue, 19 Jan 2021 at 18:02, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jan 18, 2021 at 05:57:54PM +0000, Benjamin Maynard wrote:
> > Hi,
> >
> > I was recently experimenting with NFS re-exporting using the new patch
> > set that is in the Linux 5.11 kernel
> > (https://patchwork.kernel.org/project/linux-nfs/list/?series=3D393561).
> >
> > After applying these patches, I consistently faced an error when
> > trying to perform a previously working NFS re-export: "exportfs:
> > /files does not support NFS export".
> >
> > I (with help from some other interested parties) began troubleshooting
> > and after stepping through each patch individually we identified that
> > the error only occurred when the following patch was applied:
> > https://patchwork.kernel.org/project/linux-nfs/patch/20201130220319.501=
064-3-trond.myklebust@hammerspace.com/.
>
> That link isn't working for me for some reason.
>
> Looks like we're talking about ba5e8187c555 "nfsd: allow filesystems to
> opt out of subtree checking".
>

Correct, this is the patch I am referencing.

> > This patch prevents re-exporting if subtree checking is enabled on the
> > originating NFS server.
>
> That's not correct.
>
> I'm assuming there are two servers: a reexporting server, which mounts
> the originating NFS server, which is mounting ext4 or xfs or some other
> local filesystem.
>
> It's hard for the reexporting server to even tell if the originating
> server is using subtree checking, so I'm surprised that would make a
> difference in behavior.
>

That is correct, there is an originating NFS Server (Ubuntu 20.04 -
5.4.0-1034-gcp) that is exporting a directory from the local ext4
filesystem. This is exported with the following options:

/files 10.0.0.0/8(rw,no_subtree_check,fsid=3D10)

This is then mounted from the re-exporting server (export from /proc/mounts=
):

10.70.1.2:/files /files nfs
rw,sync,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acreg=
min=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3Dt=
cp,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.70.1.2,mo=
untvers=3D3,mountport=3D20048,mountproto=3Dudp,fsc,local_lock=3Dnone,addr=
=3D10.70.1.2
0 0

We then attempt to re-export the mounted directory from the
re-exporting server with the following entry in /etc/exports:

/files   10.67.0.0/16(rw,wdelay,no_root_squash,no_subtree_check,fsid=3D10,s=
ec=3Dsys,rw,secure,no_root_squash,no_all_squash)

If you perform this set of steps with the 5.10 kernel with nfs-utils
1.3.4 (Ubuntu & Debian default version), the re-export will work. If
you perform the same set of steps with the ba5e8187c555 patch applied
(still on nfs-utils 1.3.4) then the re-export will fail with the error
message "exportfs: /files does not support NFS export". dmesg further
reveals the cause "check_export: nfs does not support subtree
checking!".

This message appears even though we have no_subtree_check set on both
the exports of the originating NFS server, and the re-export server.

If you then upgrade nfs-utils to 2.5.2 on the re-export server, the
re-export works as expected.


> > The strange thing was that no_subtree_check
> > export option was already set on the export from the originating NFS
> > Filer, but the error message persisted.
>
> So, this patch is only checks whether you've got no_subtree_check set on
> the reexporting server.
>

Thanks. I misunderstood and thought it checked the exports on the
originating server. Regardless as detailed above no_subtree_check is
also set on the re-export server and the error persists when using an
older nfs-utils version.

> > After lots of troubleshooting, eventually we tried updating NFS Utils
> > from 1.3.4 to 2.5.2 and we were able to successfully perform
> > re-export. It appears that the old version of the nfs-utils package
> > was the cause of the issue.
>
> I'm a little confused about what happened here.  Which server were you
> applying the above patches on?  Which server did you upgrade NFS utils
> on?
>

The re-exporting server in both cases. The originating server is using
an older, unmodified kernel and version of nfs-utils. See above for a
more detailed overview.


> Could be that you're actually running into some filehandle size limit or
> something.  (Subtree checking can make that problem worse.)  Hard to
> tell.
>
> --b.
>
> > I appreciate that 1.3.4 is a very old version of nfs-utils, but it is
> > the default version that ships with Ubuntu and Debian and the error
> > message does not immediately point to the outdated version being the
> > cause of the problem.
> >
> > I was wondering if it was possible to detail the requirement for a
> > more recent version of nfs-utils in the NFS Re-exporting section of
> > the Wiki (http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export) to
> > help others who may encounter this problem in the future?
