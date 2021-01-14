Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE32F690E
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbhANSIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 13:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbhANSIl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jan 2021 13:08:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34530C061757
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:08:01 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F0E286EEC; Thu, 14 Jan 2021 13:07:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F0E286EEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610647678;
        bh=spyouQNOgxoSfYuoj6/BJaAzCZ09QeBThbEeFIwP2vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clslMAzPnwyeJ+dWwK2LpnrpwCJje+fzyVAW1mACXUmkoEbsoLCrz97iH+OhM08y3
         0H78BM2GcZNkqqF9vvQIOabgdelxOsWiZc9zgPXtZkizFky8FesS2cUQ0lMtHxkNhb
         vVk0lKeIQMELBOEYEAYnnyHKyIwQWYGAzr78iuE8=
Date:   Thu, 14 Jan 2021 13:07:58 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210114180758.GB3914@fieldses.org>
References: <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpTEBJ1jd_fr3GJ4k7KgzaBpe1LwKgyZn0AJ0D1ESK12fQ@mail.gmail.com>
 <96aea58bde3fe4c09cccd9ead2a1c85eb887d276.camel@hammerspace.com>
 <CAHxDmpTyrG74hOkzmDK834t+JiQduWHVWxCf_7nrDVa++EK2mA@mail.gmail.com>
 <74269493859fa65a7f594dadd5d86c74bd910e66.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74269493859fa65a7f594dadd5d86c74bd910e66.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 13, 2021 at 02:25:25PM +0000, Trond Myklebust wrote:
> BTW: you just 'disclosed the attack method to the public' since
> linux-nfs@vger.kernel.org is a public archived mailing list. However so
> far, you've said absolutely nothing that hasn't already been known and
> discussed for over 20 years.

I dug around a bit and couldn't find the idea of using filehandle
guessing plus mountd's following of symlinks to get access to other
filesystems.  That's kind of interesting.

It's not a huge surprise either, and doesn't change our basic
recommendation (normally you should only export the roots of
filesystems).  Which is why I asked the reporter to move the discussion
to the public list.

I think we could do better here.

--b.

> 
> > 
> > 在 2021年1月13日星期三，Trond Myklebust <trondmy@hammerspace.com> 写道：
> > > On Wed, 2021-01-13 at 01:13 +0800, 吴异 wrote:
> > > > Hello,
> > > > 
> > > > Well,maybe the best method is to prohibit  exporting
> > > > subdirectiries,and I don't know how difficult it will be.
> > > 
> > > 
> > > So, there is a discussion of all this in the 'exports' manpage both
> > in
> > > the description of the 'no_subtree_check' option, and in the
> > section on
> > > 'Subdirectory Exports'.
> > > In particular, the latter section does describe the issue that you
> > are
> > > raising here:
> > > 
> > >    Subdirectory Exports
> > >        Normally you should only export only the root of a
> > filesystem.  The NFS
> > >        server will also allow you to export a subdirectory  of  a 
> > filesystem,
> > >        however, this has drawbacks:
> > > 
> > >        First,  it  may be possible for a malicious user to access
> > files on the
> > >        filesystem outside of the exported subdirectory, by 
> > guessing  filehan‐
> > >        dles  for  those other files.  The only way to prevent this
> > is by using
> > >        the no_subtree_check option, which can cause other problems.
> > > 
> > >        Second, export options may not be enforced in the way  that 
> > you  would
> > >        expect.  For example, the security_label option will not
> > work on subdi‐
> > >        rectory exports, and if nested subdirectory exports  change 
> > the  secu‐
> > >        rity_label  or  sec=  options, NFSv4 clients will normally
> > see only the
> > >        options on the parent export.  Also, where security options 
> > differ,  a
> > >        malicious  client  may  use  filehandle-guessing  attacks to
> > access the
> > >        files from one subdirectory using the options from another.
> > > 
> > > 
> > > Why do we need to go further than this, when there are clearly also
> > a
> > > load of scenarios where the clients are all trusted, and the
> > security
> > > issue is moot?
> > > 
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > 在 2021年1月13日星期三，Trond Myklebust <trondmy@hammerspace.com> 写道：
> > > > > On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
> > > > > > On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
> > > > > > > Telling users how to configure the exported file system in
> > the
> > > > most
> > > > > > > secure
> > > > > > > way does
> > > > > > > mitigate the problem to some extent, but this does not seem
> > to
> > > > > > > address the
> > > > > > > security risks posed by no_ subtree_ check in the code. In
> > my
> > > > > > > opinion,when
> > > > > > > the generated filehandle does not contain the inode
> > information
> > > > of
> > > > > > > the
> > > > > > > parent directory,the nfsd_acceptable function can also
> > > > recursively
> > > > > > > determine whether the request file exceeds the export path
> > > > > > > dentry.Enabling
> > > > > > > subtree_check to add parent directory information only
> > brings
> > > > some
> > > > > > > troubles.
> > > > > > 
> > > > > > Filesystems don't necessarily provide us with an efficient
> > > > > > way
> > to
> > > > > > find
> > > > > > parent directories from any given file.  (And note a single
> > file
> > > > may
> > > > > > have multiple parent directories.)
> > > > > > 
> > > > > > (I do wonder if we could do better in the directory case,
> > > > > > though. 
> > > > We
> > > > > > already reconnect directories all the way back up to the
> > root.)
> > > > > > 
> > > > > > > I have a bold idea, why not directly remove the file handle
> > > > > > > modification in
> > > > > > > subtree_check, and then normalize the judgment of whether
> > > > > > > dentry
> > > > > > > exceeds
> > > > > > > the export point directory in nfsd_acceptable (line 38 to
> > > > > > > 54
> > in
> > > > > > > /fs/nfsd/nfsfh.c) .
> > > > > > > 
> > > > > > > As far as I understand it, the reason why subtree_check is
> > not
> > > > > > > turned on by
> > > > > > > default is that it will cause problems when reading and
> > writing
> > > > > > > files,
> > > > > > > rather than it wastes more time when nfsd_acceptable.
> > > > > > > 
> > > > > > > In short,I think it's open to question whether the security
> > of
> > > > the
> > > > > > > system
> > > > > > > depends on the user's complete correct configuration(the
> > system
> > > > > > > does not
> > > > > > > prohibit the export of a subdirectory).
> > > > > > 
> > > > > > > Enabling subtree_check to add parent directoryinformation
> > only
> > > > > > > brings
> > > > > > > some troubles.
> > > > > > > 
> > > > > > > In short,I think it's open to question whether the security
> > of
> > > > the
> > > > > > > system depends on the user's complete correct
> > configuration(the
> > > > > > > system
> > > > > > > does not prohibit the export of a subdirectory).
> > > > > > 
> > > > > > I'd love to replace the export interface by one that
> > prohibited
> > > > > > subdirectory exports (or at least made it more obvious where
> > > > they're
> > > > > > being used.)
> > > > > > 
> > > > > > But given the interface we already have, that would be a
> > > > disruptive
> > > > > > and
> > > > > > time-consuming change.
> > > > > > 
> > > > > > Another approach is to add more entropy to filehandles so
> > they're
> > > > > > harder
> > > > > > to guess; see e.g.:
> > > > > > 
> > > > > > 
> > > > 
> >         https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html
> > > > > > 
> > > > > > In the end none of these change the fact that a filehandle
> > > > > > has
> > an
> > > > > > infinite lifetime, so once it's leaked, there's nothing you
> > can
> > > > do. 
> > > > > > The
> > > > > > authors suggest NFSv4 volatile filehandles as a solution to
> > that
> > > > > > problem, but I don't think they've thought through the
> > obstacles
> > > > to
> > > > > > making volatile filehandles work.
> > > > > > 
> > > > > > --b.
> > > > > 
> > > > > The point is that there is no good solution to the 'I want to
> > > > export a
> > > > > subtree of a filesystem' problem, and so it is plainly wrong to
> > try
> > > > to
> > > > > make a default of those solutions, which break the one sane
> > > > > case
> > of
> > > > > exporting the whole filesystem.
> > > > > 
> > > > > Just a reminder that we kicked out subtree_check not only
> > because a
> > > > > trivial rename of a file breaks the client's ability to perform
> > I/O
> > > > by
> > > > > invalidating the filehandle. In addition, that option causes
> > > > filehandle
> > > > > aliasing (i.e. multiple filehandles pointing to the same file)
> > > > which is
> > > > > a major PITA for clients to try to manage for more or less the
> > same
> > > > > reason that it is a major PITA to try to manage these files
> > using
> > > > > paths.
> > > > > 
> > > > > The discussion on volatile filehandles in RFC5661 does try to
> > > > address
> > > > > some of the above issues, but ends up concluding that you need
> > to
> > > > > introduce POSIX-incompatible restrictions, such as trying to
> > > > > ban
> > > > > renames and deletions of open files in order to make it work.
> > > > > 
> > > > > None of these compromises are necessary if you export a whole
> > > > > filesystem (or a hierarchy of whole filesystems). That's the
> > sane
> > > > case.
> > > > > That's the one that people should default to using.
> > > > > 
> > > > > --
> > > > > Trond Myklebust
> > > > > Linux NFS client maintainer, Hammerspace
> > > > > trond.myklebust@hammerspace.com
> > > > > 
> > > > > 
> > > > > 
> > > 
> > > --
> > > Trond Myklebust
> > > CTO, Hammerspace Inc
> > > 4984 El Camino Real, Suite 208
> > > Los Altos, CA 94022
> > > 
> > > www.hammer.space
> > > 
> > > 
> 
> -- 
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
> ​
> www.hammer.space
> 
