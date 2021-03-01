Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F192328CD0
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhCAS7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240200AbhCAS4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614624882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NSCKPShu4V06w478IhF0sOnz0JBZvn4p9Ox8lLEqng=;
        b=Q36O8V8RcjhRpg6aW0WKNdj7IjgGR6pW6TLn44Vey45RyzvIgqbrwRU5KI+6ya4S8Zbotq
        ba1Xpkmzplmd3b+gs4kYllwGU/SWHs3jEQIT/6TZif8RnxZPS++CKn0i0PyZdge1aSYUhd
        rOMKItY2LbCIpw4ZY/Ysm1ot+5COPAw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-sbd_TtYYPfik2201Im_GVA-1; Mon, 01 Mar 2021 13:54:40 -0500
X-MC-Unique: sbd_TtYYPfik2201Im_GVA-1
Received: by mail-ej1-f69.google.com with SMTP id v10so7105510ejh.15
        for <linux-nfs@vger.kernel.org>; Mon, 01 Mar 2021 10:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NSCKPShu4V06w478IhF0sOnz0JBZvn4p9Ox8lLEqng=;
        b=o2aSGCHeX5uyJ2tJI14T3R7vNPbtsoGviaABjBGuZEJKg2WIQpMu12CeiQMVmFWykt
         W3BwHjxWUCCcZ6Y7W8uWYoZrsIAenFBuM0xjWw5J7XYdw2hvrQ33Udz+voofE3p3+t5T
         gcTqgKfSnlNJaTcgNmGMqB2jP2tFqSlBa6Cpwmx+Q+C8C6ASsIiouuLY8KluKlihdzGw
         ZGYBXJ2JqS3HTztF0r8euXsWRn/BWbD8FhhGz25IWTUAEYosLeXYYN5/M/iLQT58PSZ9
         iL+MkFCag2JfF9UIsTKhpC9Wvz/DWt7SpXzX9MWWMd5oqjH2vNvJbUcHXHCtDnJgRjUi
         fFfg==
X-Gm-Message-State: AOAM532+ZXD9+4d1KSKJnram6UqlEHvXbyXx4mMJhoOVb/Kr+XbYNWB+
        SawQ/ouIrlHEUJeV6xT31HrU0R8CputioNvz8xAdzOuSwcCuGFx1BfMpsW7VXmnDlq9hs1E0CQG
        6kSEOSvppitvYQNbiJFbWo+lZcQESp4YySOhC
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr16626794ejw.436.1614624879560;
        Mon, 01 Mar 2021 10:54:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOhcitRgC/5g6NaQChTvOgh2uDjC22LOlfY2oT/ebPPg6xY6bBNCQOTGr8JBTQxv5PlrrStmK1wv/Kb8bPej8=
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr16626781ejw.436.1614624879343;
 Mon, 01 Mar 2021 10:54:39 -0800 (PST)
MIME-Version: 1.0
References: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
 <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com> <CALe0_75aeott7xJn0FxSMSANx0AwsxLtjNLC6YZycuE7yN+mGA@mail.gmail.com>
 <CALe0_74mGBcaNZ_RFZJUzWhG6=4YiP9c9_qBn7RwK0RdjXoa_Q@mail.gmail.com>
In-Reply-To: <CALe0_74mGBcaNZ_RFZJUzWhG6=4YiP9c9_qBn7RwK0RdjXoa_Q@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 1 Mar 2021 13:54:03 -0500
Message-ID: <CALF+zOndUvphHGvvUmJwRaGE8-E6c8zdiGja0WBX1JKt9BCudg@mail.gmail.com>
Subject: Re: gssd: set $HOME to prevent recursion when home dirs are on
 kerberized NFS mount revisted
To:     Jacob Shivers <jshivers@redhat.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I was talking to Jake and I think he will submit this again without
attachments so it's a little easier to review.

On Mon, Mar 1, 2021 at 12:07 PM Jacob Shivers <jshivers@redhat.com> wrote:
>
> Patches that include a '-H' flag and man page entry.
>
> The default is to maintain behavior since
> 2f682f25c642fcfe7c511d04bc9d67e732282348, but passing '-H' avoids
> $HOME being set to '/'.
> Also included a patch for /etc/nfs.conf to add 'set-home=1'. Setting
> it to false is equivalent to passing '-H' to rpc.gssd.
>
> Regards,
>
> Jacob Shivers
>
> On Mon, Jan 4, 2021 at 11:00 AM Jacob Shivers <jshivers@redhat.com> wrote:
> >
> > Hello,
> >
> > I completely missed this so please excuse the delay.
> >
> > > On 11/23/20 1:17 PM, Jacob Shivers wrote:
> > > > Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
> > > > behavior to avoid a deadlock for users using Kerberized NFS home dirs.
> > > >
> > > > However, this also prevents users leveraging their own k5identity
> > > > files under their home directory and instead rpc.gssd uses a
> > > > system-wide /.k5identity file. For users expecting to use their own
> > > > k5identity file this is certainly unexpected.
> > > So how is the deadlock not happening when ~/.k5identity is on a NFS
> > > home directory? What am I missing?
> > They are not using NFS for home directories. They are accessing
> > systems with a local fs backing the /home
> >
> > > > Below is some pseudo code that was proposed and would just add a flag
> > > > allowing for the behavior prior to
> > > > 2f682f25c642fcfe7c511d04bc9d67e732282348:
> > > >
> > > > /* psudo code snippet starts here */
> > > >         /*
> > > >          * Some krb5 routines try to scrape info out of files in the user's
> > > >          * home directory. This can easily deadlock when that homedir is on a
> > > > -        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
> > > > +        * kerberized NFS mount. Some users may not have $HOME on NFS.
> > > > +        * By default setting $HOME unconditionally to "/", we
> > > >          * prevent this behavior in routines that use $HOME in preference to
> > > >          * the results of getpw*.
> > > > +        * Users who have $HOME on krb5-NFS should set
> > > > `--home-not-kerberized` in argv
> > > > +        * Users who have $HOME on krb5-NFS but want to use their
> > > > $HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
> > > >          */
> > > > +       if (argv == '--home-not-kerberized') ||
> > > > (getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
> > > > +               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
> > > > +       }
> > > > +       else {
> > > > +               log.debug('Assuming $HOME requires Kerberos, use
> > > > `--home-not-kerberized` to change this behavior');
> > > >         if (setenv("HOME", "/", 1)) {
> > > >                 printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
> > > >                 exit(1);
> > > >         }
> > > > +       }
> > > > /* psudo code snippet ends here */
> > > In general I'm pretty reluctant to add flags but what is needed
> > > to do so is a company single letter flag '-H' and a man page
> > > entry describing the flag.
> > Ok.
> >
> > > >
> > > > While acknowledging the use of this flag for Kerberized NFS home dirs
> > > > is undesirable and would cause a deadlock, there should be no issue
> > > > for users not using Kerberized NFS home dirs.
> > > What apps are you using that is seeing this problem?
> > It is just when accessing the Kerberized NFS share. Other Kerberos
> > aware services/applications check for the existence of ~/.k5identify
> > before reading /var/kerberos/krb5/user/${EUID}/client.keytab. rpc.gssd
> > no longer does this and the intent of the patch would be to add
> > granularity to choose the behavior or rpc.gssd with respect to
> > scanning for a k5identity file.
> >
> > If any additional information is required, please inform me.
> >
> > Thanks,
> >
> > Jacob Shivers

