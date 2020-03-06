Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFA17C813
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFWBl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 6 Mar 2020 17:01:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbgCFWBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Mar 2020 17:01:41 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-girT2cKGN6qj0ciNYhcecg-1; Fri, 06 Mar 2020 17:01:36 -0500
X-MC-Unique: girT2cKGN6qj0ciNYhcecg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A891A800D54;
        Fri,  6 Mar 2020 22:01:34 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-120-213.rdu2.redhat.com [10.10.120.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAB4F5C28D;
        Fri,  6 Mar 2020 22:01:33 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id F18AF1A0110; Fri,  6 Mar 2020 17:01:32 -0500 (EST)
Date:   Fri, 6 Mar 2020 17:01:32 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
Message-ID: <20200306220132.GD3175@aion.usersys.redhat.com>
References: <20200303225837.1557210-1-smayhew@redhat.com>
 <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
 <20200304143701.GB3175@aion.usersys.redhat.com>
 <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Mar 2020, Stephen Smalley wrote:

> On Wed, Mar 4, 2020 at 9:37 AM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > On Wed, 04 Mar 2020, Richard Haines wrote:
> > > I built and tested this patch on selinux-next (note that the NFS module
> > > is a few patches behind).
> > > The unlabeled problem is solved, however using:
> > >
> > > mount -t nfs -o
> > > vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
> > > localhost:$TESTDIR /mnt/selinux-testsuite
> > >
> > > I get the message:
> > >     mount.nfs: an incorrect mount option was specified
> > > with a log entry:
> > >     SELinux: mount invalid.  Same superblock, different security
> > > settings for (dev 0:42, type nfs)
> > >
> > > If I use "fscontext=" instead then works okay. Using no context option
> > > also works. I guess the rootcontext= option should still work ???
> >
> > Thanks for testing.  It definitely wasn't my intention to break
> > anything, so I'll look into it.
> 
> I'm not sure that rootcontext= should be supported or is supportable
> over labeled NFS.

Should rootcontext= be supported for NFS versions < 4.2?  If not then
maybe it that option should be rejected for nfs and nfs4 fstypes in
selinux_set_mnt_opts().

> It's primary use case is to allow assigning a specific context other
> than the default policy-defined one
> to the root directory for filesystems that support labeling but don't
> have existing labels on their root
> directories, e.g. tmpfs mounts.  Even if we set the rootcontext based
> on rootcontext= during mount(2),
> it would likely get overridden by subsequent attribute fetches from
> the server I would think (e.g. it probably
> already switches to the context from the server after 30 seconds or

Yes, that's what happens.  If we wanted to retain that behavior moving
forward, then we need to avoid calling nfs_setsecurity() for the root
inode when the rootcontext= option was used.  To do that, I think we'd
need to add a flag that could be passed back to NFS via the
set_kern_flags parameter of selinux_set_mnt_opts().

> so?). As long as the separate context= option
> continues to work correctly on NFS, I'm not overly concerned about this.

Yep, the context= option still works.
> 
> I should note that we are getting similar errors though when trying to
> specify any context-related
> mount options on NFS via the new fsconfig(2) system call, see
> https://github.com/SELinuxProject/selinux-kernel/issues/49
> I don't know if this change in when security_sb_set_mnt_opts() will
> alter that situation any.
> 
> Also, FYI, we have recently made it possible to run the
> selinux-testsuite without errors within a labeled NFS
> mount.  If you clone
> https://github.com/SELinuxProject/selinux-testsuite/ and follow the
> README.md
> instructions including the NFS section and run ./tools/nfs.sh, it will
> export and mount the testsuite directory
> via labeled NFS over loopback and run all tests that can be supported
> over NFS, and then runs a few specific
> tests for context= mount options (but not the other mount options at
> present).  It still needs some further
> enhancements as per
> https://github.com/SELinuxProject/selinux-testsuite/issues/32#issuecomment-582992492
> but it at least provides some degree of regression testing.

Thanks.  I ran this a few times and aside from an exportfs bug
everything passed.  I'll be sure to run this in the future too.

-Scott

