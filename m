Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619681FD2C6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQQuV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 12:50:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgFQQuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 12:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592412618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OjK8fyHVTJHn0tJmmKvVefEY8khdS+QHcewRe9SW19w=;
        b=WjQcht4Bs0W+wbaYCphakmQGS6iCKa7jkGpvOFOgRwy7LsZ6IfNCVHfARWw7hzvGNTuME6
        xY8BOA0Ay3VfmDmnvBy5hBjMbKKazjqc0UCe0eiLb3d7fKEf5eGJLvGWurumV0fLVz88lM
        sGGFhuVQfUxnK+PWYUaZHniB+flm0mw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-bB3p3yaCMey-Q0HS_csduw-1; Wed, 17 Jun 2020 12:50:16 -0400
X-MC-Unique: bB3p3yaCMey-Q0HS_csduw-1
Received: by mail-oi1-f199.google.com with SMTP id x7so1279823oif.13
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2020 09:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjK8fyHVTJHn0tJmmKvVefEY8khdS+QHcewRe9SW19w=;
        b=eVznZyXrAHRGw2fe4uBnMVjKtZGH3Nfdd2rBSa9KR1pMyZtEDTHU9rfrtVg8zr9eeA
         7Fzy6j3TwiEvnLPnRszaZoE1hbmIuedLIgVo6PPthD/ksmXY572470z7PL+MylnG2Pcw
         OaeOQP9Mwn4NXrcB+dnoxS7uJ7FDryHv0JjUOgjbC6+i0wc1qcjaJ37AP4yy+qRJxGHw
         9KwRGAfYxbq4nV4b6w3vzP3H5ukShjIWtbhDBWhYIbNd+iZ9TCKcNW75dfvvwitRlVt7
         xtLisGXPO23mDkcm0ITB4Oh9POnC0tqyCwKvadWOoBR4d9bYvl6BRLvpv/9dXOzd97QM
         VeiA==
X-Gm-Message-State: AOAM533iOk5NureVRxyDxO+SdEv/zX2BzPP4/zlozOkdER5qzaKARfuC
        oFr7y5HLw19FE5NlTi/zGFU+8tOXakeydofngVhi5d6Fa4RYl31XUF6whgztLDdekoOMzcAdTy5
        EC4Ihq9ADBs6L4N4ofZYKH/dDhELza/W0H9up
X-Received: by 2002:a4a:d1ca:: with SMTP id a10mr262815oos.31.1592412615529;
        Wed, 17 Jun 2020 09:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvBRe1tN454gReGPRfABUY4hEWGQXUAbPkEy82xsY851yjhGMaPBzfCaZ6uEV13m7NtiwW2+yXK6vJIB388qk=
X-Received: by 2002:a4a:d1ca:: with SMTP id a10mr262789oos.31.1592412615270;
 Wed, 17 Jun 2020 09:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200605183631.GA1720057@eldamar.local> <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local> <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org> <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org> <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li> <20200617144256.1028414-1-agruenba@redhat.com>
 <20200617153107.GL266716@pick.fieldses.org>
In-Reply-To: <20200617153107.GL266716@pick.fieldses.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Jun 2020 18:50:04 +0200
Message-ID: <CAHc6FU5-WGL8OwELQvpu8CsQgqW5o2h92UG3d2E3RUTPnBPgog@mail.gmail.com>
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     ecryptfs@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
        Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 17, 2020 at 5:31 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Wed, Jun 17, 2020 at 04:42:56PM +0200, Andreas Gruenbacher wrote:
> > Hi Bruce,
> >
> > On Wed, Jun 17, 2020 at 2:58 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > > I think I'll send the following upstream.
> >
> > looking good, but how about using a little helper for this?
>
> I like it.  And the new comment's helpful too.
>
> >
> > Also I'm not sure if ecryptfs gets this right, so taking the ecryptfs
> > list into the CC.
>
> Yes, questions I had while doing this:
>
>         - cachefiles, ecrypfs, devtmpfs, and unix_mknod skip the check,
>           is that OK for all of them?  (Overlayfs too, I think?--that
>           code's harder to follow.
>
>         - why don't vfs_{create,mknod,mkdir} do the IS_POSIXACL check
>           themselves?  Even if it's unnecessary for some callers, surely
>           it wouldn't be wrong?

That's a good question. The security_path_{mkdir,mknod} hooks would
then probably be passed the original create mode before applying the
umask, but at that point it's not clear what the new inode's final
mode will be, anyway.

> I also wondered why both vfs_{create,mknod,mkdir} and the callers were
> calling security hooks, but now I see that the callers are calling
> security_path_* hooks and the vfs_ functions are calling
> security_inode_* hooks, so I guess they're not redundant.
>
> Though now I wonder why some of the callers (nfsd, overlayfs) are
> skipping the security_path_* hooks.

The path based security hooks are only used by apparmor and tomoyo.
Those hooks basically control who (which process) can do what where in
the filesystem, but nfsd isn't aware of the "who", and overlayfs is a
layer below the "where".

Andreas

