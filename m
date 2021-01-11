Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE42F1F41
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbhAKTZt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 14:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390998AbhAKTZt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 14:25:49 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D2C061794
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 11:25:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7AECB6191; Mon, 11 Jan 2021 14:25:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7AECB6191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610393107;
        bh=CVq5TKNUMdMutquTK9nVmf6UNeyCEK00dP8acpUumvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xN7ew2Zhm38oaU5ESFXI7DelKrTOQMaGHmbWdBvqmhrs2dIz0ulISYBfTvoDSZWGu
         5xMRCU1Bj9EuTO2Lq+rMQKG4wrUz/Rv52T9KF5MLLFfuDqqc+TnBxixTNN7aDOqW5l
         HW2RplLFCQz/I4eyFPuI+CE6STE2K6FkagNjlYus=
Date:   Mon, 11 Jan 2021 14:25:07 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>
Cc:     linux-nfs@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210111192507.GB2600@fieldses.org>
References: <CAHxDmpTKJfnhGY9CVupyVYhNCTDVKBB6KRwh-E6u_XEPJq4WJQ@mail.gmail.com>
 <20210105165633.GC14893@fieldses.org>
 <X/hEB8awvGyMKi6x@kroah.com>
 <20210108152017.GA4183@fieldses.org>
 <CAHxDmpSp1LHzKD5uqbfi+jcnb+nFaAZbc5++E0oOvLsYvyYDpw@mail.gmail.com>
 <20210108164433.GB8699@fieldses.org>
 <CAHxDmpSjwrcr_fqLJa5=Zo=xmbt2Eo9dcy6TQuoU8+F3yVVNhw@mail.gmail.com>
 <20210110201740.GA8789@fieldses.org>
 <20210110202815.GB8789@fieldses.org>
 <CAHxDmpR8S7NR8OU2nWJmWBdFU9a7wDuDnxviQ2E9RDOeW9fExg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHxDmpR8S7NR8OU2nWJmWBdFU9a7wDuDnxviQ2E9RDOeW9fExg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 11, 2021 at 08:55:43PM +0800, 吴异 wrote:
> Yes, the safest way for users is that the first exported file system is on
> a different hard disk with "\", and then does not contain subdirectories,
> so I seem to have nothing to do. However, I did not find these tips in the
> configuration files related and man exports . It is best to recommend the
> best configuration method to users if it is updated in the future.

I agree that the documentation needs improvement.

I also think we should warn by default when a user tries to export
something with no_subtree_check that's not at a mountpoint.

(Really, "at a mountpoint" should be "at the root of a filesystem", but
I don't know how to check for that, at least not from userspace.  I'm
not sure whether the warning belongs in the kernel or elsewhere.)

> Back to the present situation, have you considered removing the following
> piece of code in the nfsd_acceptable function：
>  if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
> return 1;

That would turn on subtree_check unconditionally.  Currently we default
to no_subtree_check, and for good reason: subtree_check causes
unexpected behavior, like ESTALE on attempts to access open files after
cross-directory rename.

> In this way, all problems seem to be solved. Even if an attacker can get or
> guess some file handles, these handles will not actually work.Fix
> compose_entry_fh and nfsd_lookup_dentry functions is actually not that
> urgent.
> 
> One more question, do I need to copy all the previous emails to
> linux-nfs@vger.kernel.org, this is a bit too much, right?

I don't think that's necessary.  To summarize issue you've raised; if a
client exports only a subdirectory of a filesystem:

	- NFSv2/v3 clients can discover the filehandle of the parent of
	  the export point using readdir_plus.  I agree that we should
	  fix this; I'll follow up with a patch.  (It's already not too
	  hard to guess filehandles, though.)

	- Once a single filehandle outside the export directory is
	  found, it's easy to access the rest of the filesystem.  This
	  issue has been known for decades.  But I don't think it's
	  well-enough understood by users.

	- If only a subdirectory of a filesystem is exported, an
	  attacker might be able to gain access to *other* filesystems
	  as well, by replacing some component along the exported path
	  by a symlink and waiting for the server to restart.  (In the
	  v2/v3 case, export path symlinks are followed on the server
	  side.)

The main defense against all of this is to *only* export the root of a
filesystem.  If you're exporting "/export/home/", then you should create
a separate filesystem and mount that at "/export/home/".

But this isn't as well understood as it should be, and we should do a
better job of preventing users from choosing dangerous configurations.
And then mitigate the danger where we can.

--b.

> 
> Best regards,
> 
> J. Bruce Fields <bfields@fieldses.org> 于2021年1月11日周一 上午4:28写道：
> 
> > On Sun, Jan 10, 2021 at 03:17:40PM -0500, J. Bruce Fields wrote:
> > > On Sat, Jan 09, 2021 at 10:52:33PM +0800, 吴异 wrote:
> > > > I do try it,because of the default no_subtreecheck in nfsd, I can
> > delete
> > > > /nfs as long as I can get the handle of /fs. This takes advantage of
> > the
> > > > vulnerability I submitted before. I have added my poc and traffic
> > > > information in the attachment.
> > > >
> > > > My server filesystem configuration is as follows：
> > > >
> > > > /dev/sda3 on / type ext4 (rw,relatime,errors=remount-ro)
> > > >
> > > > /dev/sda1 on /fs type ext4 (rw,relatime)
> > > >
> > > > The configuration of /etc/export is
> > > >
> > > > /fs/nfs      *(rw,sync,no_root_squash,insecure)
> > >
> > > Again, you're exporting a subdirectory, which we discourage.  The safe
> > > and recommended configuration would be to mount /dev/sda1 on /fs/nfs and
> > > export /fs/nfs.
> > >
> > > > As you can see, the file system where the shared directory is located
> > has
> > > > been separated from the “\” directory.What I did was to delete the
> > mount
> > > > point directory
> > >
> > > It should not be possible to delete /fs/nfs/ while you had something
> > > mounted there.
> >
> > Whoops, I'm sorry, there's only a mountpoint at /fs/, so, yes, you can
> > probably delete /fs/nfs and replace it by a symlink, got it.
> >
> > Sure, that's interesting.  But, again, we don't recommend exporting
> > filesystem subdirectories.
> >
> > Good to keep the public nfs list (linux-nfs@vger.kernel.org) cc'd on
> > these things, by the way.
> >
> > --b.
> >
> > >
> > > --b.
> > >
> > > > and restart the server-side nfsd service. At this time, the
> > > > server-side shared directory became "/", and the configuration
> > information
> > > > did not change.
> > > >
> > > >
> > > > For the convenience I set no_root_squash on the server, but in fact, as
> > > > long as the server gives the user the permission to write in the /fs
> > > > directory, the above operation can be completed.
> > > >
> > > >
> > > > Best regards,
> > > >
> > > >
> > > >
> > > > J. Bruce Fields <bfields@fieldses.org> 于2021年1月9日周六 上午12:44写道：
> > > >
> > > > > On Sat, Jan 09, 2021 at 12:30:58AM +0800, 吴异 wrote:
> > > > > >  when the shared directory /fs/nfs of the server is mounted on the
> > device
> > > > > > /dev/sda3, and the "/" directory is mounted on the device
> > /dev/sda1, then
> > > > > > the file system of the shared directory and the "/" file system
> > are In
> > > > > > isolation, an attacker can obtain the ability of any file in the
> > > > > /dev/sda3
> > > > > > file system by using a file handle, but cannot access the "/" file
> > system
> > > > > > by using an NFS file handle, even if he already knows the "/"
> > handle is
> > > > > > "0100010000000000", which will return the error code nfserr_stale.
> > > > > >
> > > > > > In this case, the attacker deletes the mount point  directory
> > /fs/nfs in
> > > > > > the file system under its control., and create a symbolic link
> > with the
> > > > > > same name pointing to the "/" directory.
> > > > >
> > > > > Access to the filesystem mounted at /fs/nfs/ should not give you the
> > > > > ability to delete the directory /fs/nfs.
> > > > >
> > > > > Have you actually tried this?
> > > > >
> > > > > Please explain what access you assume the attacker starts with, what
> > > > > they're able to do it, why you think that isn't expected, and please
> > > > > test to make sure your idea works.
> > > > >
> > > > > --b.
> > > > >
> > > > >
> > > > > > After nfsd re-parses the
> > > > > > configuration file /etc/exports, the attacker can remount it to
> > achieve
> > > > > > real file system escape.
> > > > > >
> > > > > > It seems that nfsd should strengthen the restrictions on symbolic
> > link
> > > > > > resolution in configuration files.
> > > > > >
> > > > > > Best regards,
> > > > > >
> > > > > > J. Bruce Fields <bfields@fieldses.org> 于2021年1月8日周五 下午11:20写道：
> > > > > >
> > > > > > > On Fri, Jan 08, 2021 at 12:37:43PM +0100, Greg KH wrote:
> > > > > > > > On Tue, Jan 05, 2021 at 11:56:33AM -0500, J. Bruce Fields
> > wrote:
> > > > > > > > > On Tue, Jan 05, 2021 at 11:37:26PM +0800, 吴异 wrote:
> > > > > > > > > > It is not safe to export only the root of the file system,
> > > > > > > > > > Attacker can use lookup ".." to get the file handle to the
> > ".."
> > > > > > > directory，
> > > > > > > > >
> > > > > > > > > You have claimed the ability to read and write any file on
> > the file
> > > > > > > > > server.  But if you put /fs/nfs/ on a separate filesystem
> > then
> > > > > that is
> > > > > > > > > no longer possible.  Perhaps you can learn the value of the
> > > > > filehandle
> > > > > > > > > /fs/, but you can't use that filehandle to gain additional
> > access
> > > > > > > unless
> > > > > > > > > something on that filesystem is already exported.
> > > > > > > > >
> > > > > > > > > So, there may be some information disclosure here, I agree,
> > but
> > > > > it's
> > > > > > > > > relatively mild, given that filehandles are not well-kept
> > secrets
> > > > > > > > > anyway.
> > > > > > > >
> > > > > > > > Ok, to clarify, you are saying that this really isn't an issue
> > at all
> > > > > > > > with the kernel code, so there's nothing to do here?
> > > > > > > >
> > > > > > > > Just trying to figure out if there's anything to actually work
> > on
> > > > > here
> > > > > > > > or not.
> > > > > > >
> > > > > > > I think there's one possibly interesting issue, but it doesn't
> > require
> > > > > > > special handling.  Reporter has raised a few issues:
> > > > > > >
> > > > > > >         - The one that might be interesting: clients may be able
> > to
> > > > > > >           discover filehandles that they shouldn't be able to
> > using
> > > > > > >           readdir_plus.  On review of the code, I agree it's odd
> > that
> > > > > > >           the logic in compose_entry_fh() is different from that
> > in
> > > > > > >           nfsd_lookup_dentry().  I'd also prefer to take that
> > > > > discussion
> > > > > > >           to linux-nfs@vger.kernel.org, as this seems at most a
> > mild
> > > > > > >           information disclosure.
> > > > > > >
> > > > > > >         - If only part of a filesystem is exported, an attacker
> > can
> > > > > gain
> > > > > > >           access to files outside the exported directory by
> > guessing
> > > > > > >           filehandles.  This issue has been known for decades.
> > If we
> > > > > > >           want to discuss mitigation strategies, I believe the
> > correct
> > > > > > >           forum is again linux-nfs@vger.kernel.org, not
> > > > > > >           security@kernel.org.
> > > > > > >
> > > > > > >         - An attacker might replace an exported mountpoint by a
> > symlink
> > > > > > >           pointing elsewhere.  That seems to assume the attacker
> > > > > already
> > > > > > >           has a lot of access, so I'm not clear what advantage
> > they
> > > > > gain
> > > > > > >           from this.
> > > > > > >
> > > > > > > --b.
> > > > > > >
> > > > >
> > >
> > >
> >
