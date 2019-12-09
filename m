Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1133B117752
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIUU7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 15:20:59 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:39502 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIUU6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 15:20:58 -0500
Received: by mail-vk1-f181.google.com with SMTP id x199so4860639vke.6
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2019 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1PuVdJdvS84oqJPt6SXRJ95urD4uweK0Ujl/q957e4=;
        b=J3MGw1OYYzRpEekU0s7rTs9n+VWbcvZNa69fmL6OJ4FOycgppbWc6L1uPH9YgvLwdb
         au2mMPpQTnkkaU3aWscmMU/y+jGjiEo8L4IY+j+GOAqdUDeayOMNaVFjgcZMwNi7H4mu
         HhojHH/FwsUxfv9bQZWMhqkgP4CafKqbIIRXqFkqlfjg0iq+VM+0OakpkPoqiJ61QZhB
         OCaeGOFPvjZHCnkqXSQj8qfxOY4S6MdBy8srIMrnhO85cshLzADdsPXcP8wjlOsXSq4P
         ZiF7KsSfypTi7Wg9GOaIYB7AHL+qARz344QITgFQvaEFqGYr/HlnIsglhsDqdd3Xn0p3
         zExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1PuVdJdvS84oqJPt6SXRJ95urD4uweK0Ujl/q957e4=;
        b=jD2h4q6fY15NMVvOb2pfy5lushbpLTz/2iQpzivnZbYjWnMPP43uePqLGhIuWhLDjR
         hpwgVcE3eohUrs2hJKpW2D0jGoQ+Chcc9qgv5dObxIGHmawCNK2h67nCsIJBO/v12E6y
         Ydn+AKm+hSxb1Sz1T1VGp8+XWJKIBdjXuBcVd4Dtzw2PRieIEBFRq8crTl8TIoSEQDu4
         lZYvgI7xL8+gbGFhXDHpU1LOE/aE8XqG+dqClF1xi2QesMdxk7T97H7w6hPCGE6Ja3Pq
         INgU2OAg9O5IDL11Tt8BrG1oixkRwK73yaHLGLApAF8Om5Y27tQARXnW8vB4LBDT0hdR
         UI7A==
X-Gm-Message-State: APjAAAXFwiTXSgMQNXd1rVY0/s8izaNw5jEHf8z8zGdh5mgAZZC0ckbo
        mOeGJENFXogkpUfFxy5eMoQCCXdKLqcuOTqcCdcEWw==
X-Google-Smtp-Source: APXvYqya+3ZaIo1XeeTUP8tRzRQ6gtoDfocqXZ/FEW+71rKWvHmWlxevK/g8dBZMdi6MY9rugu3SmDVcZpMYZx6ASZo=
X-Received: by 2002:ac5:c7d6:: with SMTP id e22mr19097567vkn.99.1575922857515;
 Mon, 09 Dec 2019 12:20:57 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
 <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com> <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
 <47f12fef-bf43-62d8-adda-303e3e551f36@RedHat.com>
In-Reply-To: <47f12fef-bf43-62d8-adda-303e3e551f36@RedHat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Dec 2019 15:20:46 -0500
Message-ID: <CAN-5tyEjwEm7TohcHGPtub=DAM0=J9K0mN+epaNQu+E3+OB_FQ@mail.gmail.com>
Subject: Re: gssd question/patch
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 9, 2019 at 3:06 PM Steve Dickson <SteveD@redhat.com> wrote:
>
>
>
> On 12/9/19 11:49 AM, Olga Kornievskaia wrote:
> > Hi Steve,
> >
> > On Mon, Dec 9, 2019 at 11:10 AM Steve Dickson <SteveD@redhat.com> wrote:
> >>
> >> Hey,
> >>
> >> On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
> >>> Hi Steve,
> >>>
> >>> Question: Is this an interesting failure scenario (bug) that should be
> >>> fixed: client did a mount which acquired gss creds and stored in the
> >>> credential cache. Then say it umounts at some point. Then for some
> >>> reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
> >>> mounts again. This currently fails. Because gssd uses internal cache
> >>> to store creds lifetimes and thinks that tgt is still valid but then
> >>> trying to acquire a service ticket it fails (since there is no tgt).
> >> I'm unable reproduce the scenario....
> >>
> >> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> >> (as kuser) kinit kuser
> >> (as kuser) touch /mnt/tmp/foobar
> >> (as root) umount /mnt/tmp/
> >> (as root) rm -f /tmp/krb5cc*
> >> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> >> (as kuser) touch /mnt/tmp/foobar # which succeeds
> >>
> >> Where am I going wrong?
> >
> > Not sure. Can you please post gssd verbose output?
> >
> > Set up. Client kernel somewhat recent though the latest, but in
> > reality doesn't matter i think
> > gssd from nfs-utils commit 5a004c161ff6c671f73a92d818a502264367a896
> > "gssd: daemonize earlier"
> >
> > [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> > 192.168.1.72:/nfsshare /mnt
> > [aglo@localhost nfs-utils]$ touch /mnt/kerberos
> Is there a kinit before this?

yep.

> > [aglo@localhost nfs-utils]$ sudo umount /mnt
> > [aglo@localhost nfs-utils]$ sudo rm -fr /tmp/krb5cc*
> > [aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
> > 192.168.1.72:/nfsshare /mnt
> > mount.nfs: access denied by server while mounting 192.168.1.72:/nfsshare
> >
> > Here's the gssd error output: If you look at 1st "INFO: Credentials in
> > CC .... are good until..." is a lie as there isn't even a file there.
> Here is what I'm seeing:
>    https://paste.centos.org/view/9473f4a3

Well, can't see anything there (well I'm seeing the same double INFO
which according to the code pass would not try to get the tgt and it
should fail).

I'm not using gss_proxy. Are  you?

>
> steved.
>
