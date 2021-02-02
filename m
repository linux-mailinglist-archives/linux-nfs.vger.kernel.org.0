Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2EA30CC58
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhBBTwq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhBBTwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:52:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76DC0613D6
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 11:51:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y18so6977561edw.13
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqcgATepHmmGYbzYcK9PQZ2znioa7Os39Bw7CSQ1pFE=;
        b=Zetp/qn+7Z2Qag+lg3puuSoufUuRjL4FbjqVEpbcWby7xUQO0YtWkPf0vFOLEYy0HK
         A7HbzHsYRDbVJmb/Aeu0x2k8DtEL/5L+qcPC2FqPaUZdCgz87DpQOiu/vK1XAdgqzsCt
         JVeU5tc3w54/JcTT7U3T0lsYyAuwzmVqq7zU9cvFgXIvD06Bc6c9XT1rBDetuCRZe5d6
         ELQddKV58RxHlZyliE5Y1F45m93IMrgfZZgldaN67ZL2ukz9ufyEsx2mwPuR2IonovrM
         JwJ90SX38DQ9l0vInyTzfAt9uZkmyXiyr0fF28vXGYYzlh/GmOmFXpoT0izOwByJfpqi
         XUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqcgATepHmmGYbzYcK9PQZ2znioa7Os39Bw7CSQ1pFE=;
        b=e/yNTjeWuMyRCKd5Sck0JkKjcaZXJ8gpDock8cYbq5Vrmicylmt0089yGp3iPPG818
         Gs1UD9PnvNprUb8bej1YFFSOzM2tkjhJR3NMCALFtL0zcsO2ZrAl7KyiRbPPf8Dc2OMm
         xYUrOwxgk25SdD/f7Z5vpNrWH4yN8q5H2DyvQ7KQ2lvQXy7LTpukU/3qBk+SnNpblk9g
         JmVPXmVWQ9r3F7pC/CJ7wMnIKQr25NEK8fLVxbXDaArOZaEymBbj+iUC2ieTBM939xlD
         N/lErxg2o02vHh+851h4JXlV8OPE51KrydBMug8jhgfqPMzbFYmd2K0MQahcl1NK3161
         WSaQ==
X-Gm-Message-State: AOAM53061CV9rYNH3+Ect3TnxZsdQmon9hc8z/8BIkQHV57BQEXBrX/c
        BXCFjFkaj3NpUFaKJCEW/+RPkSNFgR2kNNVHPuQZnrcGs6U=
X-Google-Smtp-Source: ABdhPJx78yV5C9XPk+ruc1NlYnL8vftPgoKsoYBNsGkpXhHSL34lYaejbEqyacCXBKzNgLPIVH6vKmvgV/Hne2UM+DQ=
X-Received: by 2002:a05:6402:5193:: with SMTP id q19mr534656edd.264.1612295480612;
 Tue, 02 Feb 2021 11:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com> <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com> <FAFE2F11-5A48-4FD1-A475-F137616A4A03@oracle.com>
In-Reply-To: <FAFE2F11-5A48-4FD1-A475-F137616A4A03@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 2 Feb 2021 14:51:04 -0500
Message-ID: <CAFX2JfnbjQdqPvFfno-iJz0u7W5+Zae4GS3awwiYsncC=aw=NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dan Aloni <dan@kernelim.com>, David Howells <dhowells@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 2, 2021 at 2:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Feb 2, 2021, at 2:24 PM, Dan Aloni <dan@kernelim.com> wrote:
> >
> > On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
> >> You're welcome! I'll try to remember to CC him on future versions
> >> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>
> >>> I want to ensure Dan is aware of this work. Thanks for posting, Anna!
> >
> > Thanks Anna and Chuck. I'm accessing and monitoring the mailing list via
> > NNTP and I'm also on #linux-nfs for chatting (da-x).
> >
> > I see srcaddr was already discussed, so the patches I'm planning to send
> > next will be based on the latest version of your patchset and concern
> > multipath.
> >
> > What I'm going for is the following:
> >
> > - Expose transports that are reachable from xprtmultipath. Each in its
> >  own sub-directory, with an interface and status representation similar
> >  to the top directory.
> > - A way to add/remove transports.
> > - Inspiration for coding this is various other things in the kernel that
> >  use configfs, perhaps it can be used here too.

Sounds good! I'm looking forward to seeing them

> >
> > Also, what do you think would be a straightforward way for a userspace
> > program to find what sunrpc client id serves a mountpoint? If we add an
> > ioctl for the mountdir AFAIK it would be the first one that the NFS
> > client supports, so I wonder if there's a better interface that can work
> > for that.
>
> Has the new mount API been merged? That provides a way to open
> a mountpoint and get a file descriptor for it, and then write
> commands to it.

I'm pretty sure it was merged a release or two ago (at least, that's
when the fs_context patches went in)

Anna
>
>
> --
> Chuck Lever
>
>
>
