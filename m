Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE832E99AD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 17:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbhADQC1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 11:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbhADQC1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 11:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609776059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9xfUF5eayZFFF1hRq1v81sGQbl/LPcx9d10hqzkM50=;
        b=aIO8HJgyez6mxrAaEMgdK6dD+MWT7zMji6qQzVmKQX2/JGJj8kCgLR5oeyFWvG+QRTW5d5
        sW8d0KxXNZMqU3FZBVKM5GNeDjqQbE8LdSsSJBmskS+Bg43kQW6dvQYVwgxEDu1nylNW5a
        ybuQ9akrTINvnPm8Weus+0b7HhZC3Kw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-F0fAamopMZeKPsigqpiFqw-1; Mon, 04 Jan 2021 11:00:54 -0500
X-MC-Unique: F0fAamopMZeKPsigqpiFqw-1
Received: by mail-pl1-f197.google.com with SMTP id ba10so13734135plb.11
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 08:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9xfUF5eayZFFF1hRq1v81sGQbl/LPcx9d10hqzkM50=;
        b=a9Rf+xtBoK83hXNUwqwmxGfRhTkUk2UX8A8T45N/16QVzO4g2wgp+FqUzSXP668YTm
         xap0E5sNv3yMvc+Upov5H6xlJojW/stlAOg7W2anP/+35qINAJ9ZI2/0TwFUTWT1TiEf
         +dcSioClZ3jtG14yttvNbov6ApL0DY9uNKDbmVygHsjtrwPYdF0mJqa3Y28IGKsBPboe
         RjBjCnzGkoP4JVoctrA/VTBYzBXdP9nCY+yCCtZ2BTqz7s2zcVmy/rZ3GBTopyrL5U97
         zXvFOijYCvLH9279ik5+UQiRIyzUFfSojU7vsOkSMVe6SAmQnVwjAgWY7ecVhMNOnzjQ
         X/Fw==
X-Gm-Message-State: AOAM532i9T0fLevq/lrVBLTsvQ4NFw3ZK2QZGLMbOajAgsr7HDh5Xfjd
        rDPMODqu1WoAsfdlDayj78Sfk7vbooAlDDHZta0VN+GzXv8Pn+y3MYpwtAinv8i3AGg0eP1wL0r
        IwA5vacfB/bSRglJEHgkCQMHN9+DMyiJBdHrU
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id a3-20020a170902ee83b02900da34833957mr48810429pld.38.1609776053162;
        Mon, 04 Jan 2021 08:00:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBKAZdaAi5eOEqf2n1LNoMbTyYFUSl+FuslLxzt+4m65BjBgYL1ZR+7IvXoqkErR5+wvcU4bG67cVDwqkSexo=
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id
 a3-20020a170902ee83b02900da34833957mr48810409pld.38.1609776052907; Mon, 04
 Jan 2021 08:00:52 -0800 (PST)
MIME-Version: 1.0
References: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
 <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com>
In-Reply-To: <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com>
From:   Jacob Shivers <jshivers@redhat.com>
Date:   Mon, 4 Jan 2021 11:00:16 -0500
Message-ID: <CALe0_75aeott7xJn0FxSMSANx0AwsxLtjNLC6YZycuE7yN+mGA@mail.gmail.com>
Subject: Re: gssd: set $HOME to prevent recursion when home dirs are on
 kerberized NFS mount revisted
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I completely missed this so please excuse the delay.

> On 11/23/20 1:17 PM, Jacob Shivers wrote:
> > Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
> > behavior to avoid a deadlock for users using Kerberized NFS home dirs.
> >
> > However, this also prevents users leveraging their own k5identity
> > files under their home directory and instead rpc.gssd uses a
> > system-wide /.k5identity file. For users expecting to use their own
> > k5identity file this is certainly unexpected.
> So how is the deadlock not happening when ~/.k5identity is on a NFS
> home directory? What am I missing?
They are not using NFS for home directories. They are accessing
systems with a local fs backing the /home

> > Below is some pseudo code that was proposed and would just add a flag
> > allowing for the behavior prior to
> > 2f682f25c642fcfe7c511d04bc9d67e732282348:
> >
> > /* psudo code snippet starts here */
> >         /*
> >          * Some krb5 routines try to scrape info out of files in the user's
> >          * home directory. This can easily deadlock when that homedir is on a
> > -        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
> > +        * kerberized NFS mount. Some users may not have $HOME on NFS.
> > +        * By default setting $HOME unconditionally to "/", we
> >          * prevent this behavior in routines that use $HOME in preference to
> >          * the results of getpw*.
> > +        * Users who have $HOME on krb5-NFS should set
> > `--home-not-kerberized` in argv
> > +        * Users who have $HOME on krb5-NFS but want to use their
> > $HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
> >          */
> > +       if (argv == '--home-not-kerberized') ||
> > (getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
> > +               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
> > +       }
> > +       else {
> > +               log.debug('Assuming $HOME requires Kerberos, use
> > `--home-not-kerberized` to change this behavior');
> >         if (setenv("HOME", "/", 1)) {
> >                 printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
> >                 exit(1);
> >         }
> > +       }
> > /* psudo code snippet ends here */
> In general I'm pretty reluctant to add flags but what is needed
> to do so is a company single letter flag '-H' and a man page
> entry describing the flag.
Ok.

> >
> > While acknowledging the use of this flag for Kerberized NFS home dirs
> > is undesirable and would cause a deadlock, there should be no issue
> > for users not using Kerberized NFS home dirs.
> What apps are you using that is seeing this problem?
It is just when accessing the Kerberized NFS share. Other Kerberos
aware services/applications check for the existence of ~/.k5identify
before reading /var/kerberos/krb5/user/${EUID}/client.keytab. rpc.gssd
no longer does this and the intent of the patch would be to add
granularity to choose the behavior or rpc.gssd with respect to
scanning for a k5identity file.

If any additional information is required, please inform me.

Thanks,

Jacob Shivers

