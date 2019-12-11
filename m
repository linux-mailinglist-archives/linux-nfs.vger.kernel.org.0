Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66FF11A025
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 01:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfLKApF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 19:45:05 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42694 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLKApF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 19:45:05 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so9480543vsd.9
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eM/5Met6YAukF6BJqzk+MWuWB5U2uk0hiLg2CMskQz4=;
        b=D6MrBrsoU5Tnho4ONHpewzFvPJT/G3EjUchmenIMKLZ3pBrQLCIrCSruWqiZVrD8PL
         3ARSP/fLIE+9u8jM0L9/ICv7zuO8rk1ztPFL0YIZCczIc3nE8cJdduvpmfxZJdx+g9cG
         A+eBDG11O8Rbzi60AW4MBi3WkRljMFY1g8PpL1eWysSPfFUTb9FpcICQjwHwRMR0eg9c
         2BT3vnyc3w4WI+GOguWumGMOZmjz42pXCul5w4D/cdU9opU2OUjCf8TtJ4GtQdrKQwy5
         HtwZtBRh+Eu1V4H/Wcagr0hav6fvkhvT3IVSiZNFLNN/98qcR8jd/Xigdi/go5k2S/1d
         c+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eM/5Met6YAukF6BJqzk+MWuWB5U2uk0hiLg2CMskQz4=;
        b=WCPYUsF2a9OV4g4XPMq8KmC4MFSKBfKupQ7vZHCnF6BMSOkL6Uc5Ya1Ok1OPJwFEfc
         XLMUi9UmQK/RuFLrOKk9+kVL8jF3i6hBeygc5Ku7I5T828A1lj768SfKImiRz8CFbzlH
         b5xrWYPT7HINbUoUVu6mUbSeX2KkK8pXs+k7lhttwIxu9Hr3W4qVccKI24C8LwTeDuPu
         1OlVxSOrMiaaesGrN81WLc88pBs6ZcnLdAifR6Lc78a9Rfb2Pof1rCxnsn0cUpHR/u3u
         mnTX9X6U+9EyhjPIga1QuSrPk4mRpJAhuZsNhBhCEZVukmDeY+ow+R4yqTfZzhN9EflA
         pRZw==
X-Gm-Message-State: APjAAAXHtlhPz3Px4k/lqUYxr5aUiyTxOQ+6rFqZr3FzMOWXIS2OWUza
        wyc8dtz1NL5YafzXuAIgIvJt14yVxh6QqYBo5/s=
X-Google-Smtp-Source: APXvYqycS4QyMXa7jelGt37omojfZmhJVTHZlEB40NxKcPzYI0k7Gcp4mTz2RCbrVo87qgP3u+11Weni3Tf3jZQ6F9k=
X-Received: by 2002:a67:d592:: with SMTP id m18mr399774vsj.85.1576025104550;
 Tue, 10 Dec 2019 16:45:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
 <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com> <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
 <47f12fef-bf43-62d8-adda-303e3e551f36@RedHat.com> <CAN-5tyEjwEm7TohcHGPtub=DAM0=J9K0mN+epaNQu+E3+OB_FQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEjwEm7TohcHGPtub=DAM0=J9K0mN+epaNQu+E3+OB_FQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Dec 2019 19:44:53 -0500
Message-ID: <CAN-5tyH_6tyxk2_eY4=K1E2tDB88usDt5ipg-wX+0AwPb_FY_A@mail.gmail.com>
Subject: Re: gssd question/patch
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 9, 2019 at 3:20 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Mon, Dec 9, 2019 at 3:06 PM Steve Dickson <SteveD@redhat.com> wrote:
> >
> >
> >
> > On 12/9/19 11:49 AM, Olga Kornievskaia wrote:
> > > Hi Steve,
> > >
> > > On Mon, Dec 9, 2019 at 11:10 AM Steve Dickson <SteveD@redhat.com> wrote:
> > >>
> > >> Hey,
> > >>
> > >> On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
> > >>> Hi Steve,
> > >>>
> > >>> Question: Is this an interesting failure scenario (bug) that should be
> > >>> fixed: client did a mount which acquired gss creds and stored in the
> > >>> credential cache. Then say it umounts at some point. Then for some
> > >>> reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
> > >>> mounts again. This currently fails. Because gssd uses internal cache
> > >>> to store creds lifetimes and thinks that tgt is still valid but then
> > >>> trying to acquire a service ticket it fails (since there is no tgt).
> > >> I'm unable reproduce the scenario....
> > >>
> > >> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> > >> (as kuser) kinit kuser
> > >> (as kuser) touch /mnt/tmp/foobar
> > >> (as root) umount /mnt/tmp/
> > >> (as root) rm -f /tmp/krb5cc*
> > >> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> > >> (as kuser) touch /mnt/tmp/foobar # which succeeds
> > >>
> > >> Where am I going wrong?
> > >
> > > Not sure. Can you please post gssd verbose output?
> > >
> > > Set up. Client kernel somewhat recent though the latest, but in
> > > reality doesn't matter i think
> > > gssd from nfs-utils commit 5a004c161ff6c671f73a92d818a502264367a896
> > > "gssd: daemonize earlier"
> > >
> > > [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> > > 192.168.1.72:/nfsshare /mnt
> > > [aglo@localhost nfs-utils]$ touch /mnt/kerberos
> > Is there a kinit before this?
>
> yep.
>
> > > [aglo@localhost nfs-utils]$ sudo umount /mnt
> > > [aglo@localhost nfs-utils]$ sudo rm -fr /tmp/krb5cc*
> > > [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> > > 192.168.1.72:/nfsshare /mnt
> > > mount.nfs: access denied by server while mounting 192.168.1.72:/nfsshare
> > >
> > > Here's the gssd error output: If you look at 1st "INFO: Credentials in
> > > CC .... are good until..." is a lie as there isn't even a file there.
> > Here is what I'm seeing:
> >    https://paste.centos.org/view/9473f4a3
>
> Well, can't see anything there (well I'm seeing the same double INFO
> which according to the code pass would not try to get the tgt and it
> should fail).
>
> I'm not using gss_proxy. Are  you?

Any luck reproducing? I asked Jorge to try and he sees the same problem.

>
> >
> > steved.
> >
