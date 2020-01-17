Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E65140DF2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgAQPcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 17 Jan 2020 10:32:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729210AbgAQPcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 10:32:15 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-DZDUZOR_OCKUlzu7mSXGRA-1; Fri, 17 Jan 2020 10:32:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DACE100551D;
        Fri, 17 Jan 2020 15:32:09 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-126-23.rdu2.redhat.com [10.10.126.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47864675AF;
        Fri, 17 Jan 2020 15:32:09 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 80DC71A00A4; Fri, 17 Jan 2020 10:32:08 -0500 (EST)
Date:   Fri, 17 Jan 2020 10:32:08 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117153208.GB3111@aion.usersys.redhat.com>
References: <20200117144055.GB3215@pi3>
 <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <433863.1579270803@warthog.procyon.org.uk>
 <461540.1579273958@warthog.procyon.org.uk>
 <b31b09abeea4982e038b0e66e45889bb2c9df750.camel@hammerspace.com>
MIME-Version: 1.0
In-Reply-To: <b31b09abeea4982e038b0e66e45889bb2c9df750.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DZDUZOR_OCKUlzu7mSXGRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 17 Jan 2020, Trond Myklebust wrote:

> On Fri, 2020-01-17 at 15:12 +0000, David Howells wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > > mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1
> > > /new_root
> > 
> > Okay, it looks like the mount command makes two attempts at mounting.
> > Firstly, it does this:
> > 
> > > [   22.938314] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
> > > [   22.942638] NFSOP 'nolock=(null)'
> > > [   22.945772] NFSOP 'vers=4.2'
> > > [   22.948660] NFSOP 'addr=192.168.1.10'
> > > [   22.952350] NFSOP 'clientaddr=192.168.1.12'
> > > [   22.956831] NFS4: Couldn't follow remote path
> > 
> > Which accepts the "vers=4.2" parameter as there's no check that that
> > is
> > actually valid given the configuration, but then fails
> > later.  Secondly, it
> > does this:
> > 
> > > [   22.971001] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
> > > [   22.975217] NFSOP 'nolock=(null)'
> > > [   22.978444] NFSOP 'vers=4'
> > > [   22.981265] NFSOP 'minorversion=1'
> > > [   22.984513] NFS: Value for 'minorversion' out of range
> > > mount.nfs4: Numerical result out of range
> > 
> > which fails because of the minorversion=1 specification, where the
> > kernel
> > config didn't enable NFS_V4_1.
> > 
> > It looks like it ought to have failed prior to these patches in the
> > same way:
> > 
> > 		case Opt_minorversion:
> > 			if (nfs_get_option_ul(args, &option))
> > 				goto out_invalid_value;
> > 			if (option > NFS4_MAX_MINOR_VERSION)
> > 				goto out_invalid_value;
> > 			mnt->minorversion = option;
> > 			break;
> > 
> 
> It looks like someone changed the return value from the old EINVAL to
> something else? The "Numerical result out of range" message above
> suggests it has been changed to EOVERFLOW, which probably is not
> supported by 'mount'.

It's returning ERANGE... and nope, mount.nfs doesn't support it (see
nfs_autonegotiate() in utils/mount/stropts.c).  Changing it to return
EINVAL fixes it:

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 429315c011ae..74508ed9aeec 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -769,8 +769,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 out_invalid_address:
        return nfs_invalf(fc, "NFS: Bad IP address specified");
 out_of_bounds:
-       nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
-       return -ERANGE;
+       return nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
 }
 
 /*


I think I may have been running a hacked up version of mount.nfs
before... because as soon as I updated my nfs-utils package it stopped
working for me too.

-Scott
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

