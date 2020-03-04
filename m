Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A784A1793A5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgCDPhN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 10:37:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33873 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCDPhN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Mar 2020 10:37:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so2443279otl.1;
        Wed, 04 Mar 2020 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSIkyzu6LT+yZC1iEhGXy/GV05/86RiyGtMKqrUMOPQ=;
        b=ZvgYzyf7HYZwUGHye/JuPAz+yg6j6lCxpDnRVYcK4BSojzfQvvYLYuWwpeFqn+h7Yr
         lBQD/RfLDi5ahp48Wkmq5LEfTgKOshmeKfHuAS1yfJ5r5Sq9uGepbRkqvDNmqZasYnBz
         A5GJODEro1n29KhOu+1ii5IPU9S9/sFX3lgOkeMUzWltcbKrFGJnoSFUvkOw9jY34lvY
         ibevYyNl3EBIdhj5dmrHdE72Q/Yu/hx+B91ExIQgUlY46X5qm16WXH95uxPjBw6eexTL
         vEaD0U1tMgckXL8rsU2sKgCCmzx8rlbd8Fhcf3l2WINAqEXdy/rrZCegwPS0skJAbLUe
         Q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSIkyzu6LT+yZC1iEhGXy/GV05/86RiyGtMKqrUMOPQ=;
        b=CVQQEoJ2Qbek5oeJDhJxhpa3auOQP0zKEicb4mSy7AmQOneuMvIt+GnyCO5MVamPYB
         B/hHAhY6kEhlIDew3+w5qvAguG8V/bq2Uhi1S5NH26bcgovWysgTboomfMgw5+7gIdwD
         k+GQ4iCHUvRKKn+W9W4MurcVorP91l2BYEmNINYSphPIPMIhxuHBHZx0ZBG66gfXG4T1
         jaZdXwq1/5ixla1bJYZDkisSxJ5+j8Fln/p9QTKoK20p3su7EjhaMAz9AA4oN2nnkewN
         QddClGwcMS/97rj6itO3bzLelP4wDaX95RkNeebDrtDXw2zdpd1vxLbWM3qjrNDtLE3Y
         5JKg==
X-Gm-Message-State: ANhLgQ1dCbHtNzZK9T8nVStTkCWABDPbuFUSJmlmIFpJN5VuLd08L4AU
        hsF/vMmXBxggc5XVziSpD/5/pWEOIwvvFUE9A5s=
X-Google-Smtp-Source: ADFU+vuvOCk6OfC0NXimGuihvNMdo69P5BBTXqm/igZCkbWSNcGc3bwxy1CzZtiBEvv1w8fTkyzYfg9yiEcLD59abPk=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr2870056otl.162.1583336230671;
 Wed, 04 Mar 2020 07:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com> <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
 <20200304143701.GB3175@aion.usersys.redhat.com>
In-Reply-To: <20200304143701.GB3175@aion.usersys.redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 10:38:15 -0500
Message-ID: <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 4, 2020 at 9:37 AM Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Wed, 04 Mar 2020, Richard Haines wrote:
> > I built and tested this patch on selinux-next (note that the NFS module
> > is a few patches behind).
> > The unlabeled problem is solved, however using:
> >
> > mount -t nfs -o
> > vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
> > localhost:$TESTDIR /mnt/selinux-testsuite
> >
> > I get the message:
> >     mount.nfs: an incorrect mount option was specified
> > with a log entry:
> >     SELinux: mount invalid.  Same superblock, different security
> > settings for (dev 0:42, type nfs)
> >
> > If I use "fscontext=" instead then works okay. Using no context option
> > also works. I guess the rootcontext= option should still work ???
>
> Thanks for testing.  It definitely wasn't my intention to break
> anything, so I'll look into it.

I'm not sure that rootcontext= should be supported or is supportable
over labeled NFS.
It's primary use case is to allow assigning a specific context other
than the default policy-defined one
to the root directory for filesystems that support labeling but don't
have existing labels on their root
directories, e.g. tmpfs mounts.  Even if we set the rootcontext based
on rootcontext= during mount(2),
it would likely get overridden by subsequent attribute fetches from
the server I would think (e.g. it probably
already switches to the context from the server after 30 seconds or
so?). As long as the separate context= option
continues to work correctly on NFS, I'm not overly concerned about this.

I should note that we are getting similar errors though when trying to
specify any context-related
mount options on NFS via the new fsconfig(2) system call, see
https://github.com/SELinuxProject/selinux-kernel/issues/49
I don't know if this change in when security_sb_set_mnt_opts() will
alter that situation any.

Also, FYI, we have recently made it possible to run the
selinux-testsuite without errors within a labeled NFS
mount.  If you clone
https://github.com/SELinuxProject/selinux-testsuite/ and follow the
README.md
instructions including the NFS section and run ./tools/nfs.sh, it will
export and mount the testsuite directory
via labeled NFS over loopback and run all tests that can be supported
over NFS, and then runs a few specific
tests for context= mount options (but not the other mount options at
present).  It still needs some further
enhancements as per
https://github.com/SELinuxProject/selinux-testsuite/issues/32#issuecomment-582992492
but it at least provides some degree of regression testing.
