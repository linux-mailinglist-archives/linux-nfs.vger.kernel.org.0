Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE512FF258
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbhAURr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbhAURrt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:47:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3750C061756
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 09:47:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f4so2596478ljo.11
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O++nxsPFLK7V5Gxw1ZmgwJkXU3LgWnp339Gu3Us+ewM=;
        b=ueQB6w7jxmipIDftVIfMgdQTh1mpVpBFYqD98mtpZ9WIXThmfkmgEXTuXIs/mIMMj2
         18RHM2rmYeBOykPgEdmqV/SyMAv+pIg+0eohmJdGum/qtTOPYPQxwfq7QoCAHJBbe0y1
         JuNPTQre7c10l8kWDxK4N/8VXoRlbSrEvM/YiZSc62KfSVnlLpmZudME4QSke39L621W
         OllfP5SbuQACxY74dSql0jQNfjIwwVOp2wcrwAqMG9ye2XyNkBy/5QSgzN3tT+XTMKT1
         cxE9pwAwVQPmsEZ9f25rtuUA5Y6UtSXsBA2LlDMisQ5JontrycPtJJ/QfAtAo2CIzzKU
         0aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O++nxsPFLK7V5Gxw1ZmgwJkXU3LgWnp339Gu3Us+ewM=;
        b=LOVc0bBa+9o78P+DgAl8cDZwQieDRxEgJfrhOcIc4jP0XfHeAiVnkGvIfvoWdT6Koa
         5K1iW+hjOKWSWjaOSIfQEHqYtG4sMpM30WTk4oqJ9SR1MDpNxgXQ9XzCzp+lwNuIBVNF
         WCuqJwTHcFb18s3gq++cS/9BSoy1YQSY8vLv3FhxtAZ0TwpZ8h2SSTYTl0C0JRzfTieW
         0YbPeTYgNjnnIy2YwW3XHnaMRsu+4xNjvNK+89dhIuq6tOPURdzddsVViVaX0K6DXHOk
         7QYS3KXWLLeDOVjjL/N1n9ImifToL58NNtzzhOzHXNIb9I6ipPrHkcQ8RxSDVV3xMLxR
         i3Vg==
X-Gm-Message-State: AOAM5301Rp9WDX53sYqba0bYpNHejx5v4tqb2GGsMNKTyWVQqDpIhAPA
        u7DkeT2KQ2OFJNaUrJ7vRcShx+jiVNgG/Dig/iTUag==
X-Google-Smtp-Source: ABdhPJz29Snw3chthQfSH8BsAXDDCzrAtgd+7qevQHmyy6g1CnXxiU8P3NzCjhWQpRPn39iBHne+6ae1p33S+fhNKaU=
X-Received: by 2002:a2e:b4f1:: with SMTP id s17mr234052ljm.228.1611251226986;
 Thu, 21 Jan 2021 09:47:06 -0800 (PST)
MIME-Version: 1.0
References: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
 <20210119180204.GA24213@fieldses.org> <CA+QRt4sxwMTTWpropg=O=XdJ42P+2H=jbrwC8E1n=gt+je6iXQ@mail.gmail.com>
 <20210121153709.GA18310@fieldses.org>
In-Reply-To: <20210121153709.GA18310@fieldses.org>
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Thu, 21 Jan 2021 17:46:31 +0000
Message-ID: <CA+QRt4u8eAX6F7RuR-yORULCatrEJdorZbKKDnDHZAPx+Y=wUA@mail.gmail.com>
Subject: Re: Linux 5.11 Kernel: NFS re-export errors with older nfs-utils
 package versions
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

That makes sense, and thanks for explaining.

Seeing as the error message does not immediately point to an outdated
nfs-utils version would we be able to add a note to the Wiki
(http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export) to help
others that may come across this issue?

It looks like the Wiki is locked down to registered collaborators
otherwise I would add it myself.

Kind regards
Benjamin Maynard


On Thu, 21 Jan 2021 at 15:37, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Jan 21, 2021 at 11:21:56AM +0000, Benjamin Maynard wrote:
> > That is correct, there is an originating NFS Server (Ubuntu 20.04 -
> > 5.4.0-1034-gcp) that is exporting a directory from the local ext4
> > filesystem. This is exported with the following options:
> >
> > /files 10.0.0.0/8(rw,no_subtree_check,fsid=3D10)
> >
> > This is then mounted from the re-exporting server (export from /proc/mo=
unts):
> >
> > 10.70.1.2:/files /files nfs
> > rw,sync,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,a=
cregmin=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=
=3Dtcp,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.70.1.=
2,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,fsc,local_lock=3Dnone,ad=
dr=3D10.70.1.2
> > 0 0
> >
> > We then attempt to re-export the mounted directory from the
> > re-exporting server with the following entry in /etc/exports:
> >
> > /files   10.67.0.0/16(rw,wdelay,no_root_squash,no_subtree_check,fsid=3D=
10,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)
> >
> > If you perform this set of steps with the 5.10 kernel with nfs-utils
> > 1.3.4 (Ubuntu & Debian default version), the re-export will work. If
> > you perform the same set of steps with the ba5e8187c555 patch applied
> > (still on nfs-utils 1.3.4) then the re-export will fail with the error
> > message "exportfs: /files does not support NFS export". dmesg further
> > reveals the cause "check_export: nfs does not support subtree
> > checking!".
> >
> > This message appears even though we have no_subtree_check set on both
> > the exports of the originating NFS server, and the re-export server.
> >
> > If you then upgrade nfs-utils to 2.5.2 on the re-export server, the
> > re-export works as expected.
>
> Oh, got it, looks like the bug fixed by nfs-utils commit 63f520e8f6f5
> "exportfs: Make sure pass all valid export flags to nfsd".
>
> Rough explanation: export information isn't normally passed down to the
> kernel when exportfs is called.  Instead the kernel waits till it needs
> to know about some new client and/or filesystem and calls up to mountd
> to ask for the relevant export entry.
>
> Anyway, that's fine but it means the user doesn't find about errors
> right away.
>
> So, trying to be helpful, exportfs actually does pass down a dummy
> export to the kernel at exportfs time, just to check for errors like a
> typo'd export path or an unexportable filesystem.
>
> Before that fix, it passed down that dumy export without the
> "no_subtree_check" flag, even when you set that flag.
>
> So, for nfs reexport, you need an nfs-utils new enough to include that
> patch.
>
> We're normally pretty strict about kernel regressions: if something
> stopped working on kernel upgrade, that's a bug.  But I think we really
> do need to fail attempts to re-export NFS with subtree checking, so
> we've got to make an exception here.  Re-export is still a bit of an
> experimental feature, so there may be hiccups like this.
>
> --b.
