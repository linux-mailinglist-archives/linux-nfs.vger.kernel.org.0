Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC72A8931
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKEVnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 16:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKEVnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 16:43:14 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F67C0613CF;
        Thu,  5 Nov 2020 13:43:13 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so4829108ejm.0;
        Thu, 05 Nov 2020 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPGYMg/dNtOYhsJ8Y2LOGYr0zqsPQ9NBCPtUAnJLJss=;
        b=QhFMVwyYgcwO3sARxmCu/c+x5VNBi7xucdjjX+uzvAVS0OTiutqQEMUmew/9P4pSSY
         UjNrL7rBlDVLFPp11sEy+GMUWb+UnbkOMbzdUmwN5rlP+7clCDZ8aejR5mTveHhZBcRZ
         Q9eaeDjKDHqdjxWnOPfk4dMnS1GzKIi4cFeb6nnMVXJ4yh8MjiioiAfVQl63Ghv7E5Sw
         ELcODDhV2J4QgKQPE2qEq97XVwJrURIqx6lzZSPQIu3iy0CsXfuRWpLjTMhJoVbTSl7S
         xUmBmmcGEkfA82lggGwG1ZDpd6NsV3YKZCYk+JqhACxMtXhMx5oH1ADpTRtCy+0YhDEv
         0VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPGYMg/dNtOYhsJ8Y2LOGYr0zqsPQ9NBCPtUAnJLJss=;
        b=NyfwWvmjhpAisdEJsn5Db5i06kfUIkTjg0K/MnzmbRh+1WZ0VFzLo7v97yketWI0Cn
         yxl7ptKAmq5BNYiIX6BJtdJO67vA8XpDxkxH8VIYaA9M85En0+MEhJQP6SU5IYMvla5a
         vuhl0IbgXKQ96wuZcOel9qtwt1qMWkjG/gDhGY0QYQELqJL6R+dPZ2rjJ22MXdj1nFKc
         5sjs5Cvgq6Qzi/bxpnNgZohCdH3NjEE24Lyw04mEtgFQRIIx+HJqDS9Y/fMFj1tJkFJe
         mCN1S692fxOkNeTQAJfof7jbHRWBldKuvkbdB2CZPqRPUg8CyPwP4yNW44R50D8LuT5b
         ZUUA==
X-Gm-Message-State: AOAM532CIwHNuZ1LZwGfX/m7voS8lCKI0Gz+QqHti0vt2Ga+dA8h5HOm
        NDLPNABT/zkWGKUl1ufUTpwr3U/xnoslqnN2KM0=
X-Google-Smtp-Source: ABdhPJzltyf8CPElPCLMwuwmycOx1254Gp1ZADrMApmWzRcAP32lvqjGLwuOYainjvsoVtqBs4MrhH7FXdyTIL2pYDw=
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr4579325ejb.248.1604612592456;
 Thu, 05 Nov 2020 13:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
 <20201105173328.2539-2-olga.kornievskaia@gmail.com> <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
 <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com> <a96c14c0f86ec274d5bdc255050ae71238bb43fe.camel@hammerspace.com>
In-Reply-To: <a96c14c0f86ec274d5bdc255050ae71238bb43fe.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 5 Nov 2020 16:43:01 -0500
Message-ID: <CAN-5tyHc_fjDXwUngqVshB0Z7SzhAqjkXP7E=-k4sAPbfRwMmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 4:18 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2020-11-05 at 14:51 -0500, Olga Kornievskaia wrote:
> > On Thu, Nov 5, 2020 at 1:55 PM Ondrej Mosnacek <omosnace@redhat.com>
> > wrote:
> > >
> > > On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
> > > <olga.kornievskaia@gmail.com> wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > Currently, the client will always ask for security_labels if the
> > > > server
> > > > returns that it supports that feature regardless of any LSM
> > > > modules
> > > > (such as Selinux) enforcing security policy. This adds
> > > > performance
> > > > penalty to the READDIR operation.
> > > >
> > > > Instead, query the LSM module to find if anything is enabled and
> > > > if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
> > >
> > > Having spent some time staring at some of the NFS code very
> > > recently,
> > > I can't help but suggest: Would it perhaps be enough to decide
> > > whether
> > > to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
> > > NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some
> > > LSM
> > > confirms via the security_sb_*_mnt_opts() hook that it wants the
> > > filesystem to give it labels (or at least that's how I interpret
> > > the
> > > cryptic name) [1]. It's just a shot in the dark, but it seems to
> > > fit
> > > this use case.
> > >
> > > [1]
> > > https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148
> >
> > Very interesting. I was not aware of something like that nor was it
> > mentioned when I asked on the selinux mailing list. I wonder if this
> > is a supported feature that will always stay? In that case, NFS
> > wouldn't need the extra hook that was added for this series. I will
> > try this out and report back.
>
> NFS_CAP_SECURITY_LABEL is just the NFS server capability flag. It tells
> you whether or not the client believes that the server might support
> NFSv4.2 requests for labelled NFS metadata.
>
> My understanding of Olga's requirement is that she needs to be able to
> ignore that flag and simply not query for labelled NFS metadata if the
> NFS client is not configured to enforce the LSM policy. The objective
> is to avoid unnecessary RPC traffic to the server to query for data
> that is unused.

Actually that seems to be working. I think it's because while the
server returns that it supports sec_labels, after calling
security_sb_set_mnt_opts() the kflags_out don't have this
SECURITY_LSM_NATIVE_LABELS set (assuming this happens because selinux
isn't enabled) then we turned server's sec_labl cap off.

I'm about to send v2 without relying on modifications to selinux.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
