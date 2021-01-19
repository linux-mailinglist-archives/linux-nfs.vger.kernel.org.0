Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27DA2FAF3B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 04:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhASDs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jan 2021 22:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbhASDrN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jan 2021 22:47:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB3C061573
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jan 2021 19:46:32 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B03A36EAF; Mon, 18 Jan 2021 22:46:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B03A36EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611027991;
        bh=PAHaAQKR/+/nVVIU1f3bGZ05TVx26wIC3skB22g0isQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWek5Yry5q/DoHXX/ELQigxvNiYYTXhiOoZ9UOrYmC6L7jtvmTwNhb6U1/19qke3Q
         zuTABjsMXJD6dYr6SDsvpvT0vR6UwqOas+yeKHhEF3+OXDwD1eEFjqYtie43NktVPe
         iJ+3fBRzHS4va5oPIT6Sj4rAa2P+tzu8o9NXNSJg=
Date:   Mon, 18 Jan 2021 22:46:31 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     =?utf-8?B?5ZC05byC?= <wangzhibei1999@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210119034631.GC23934@fieldses.org>
References: <20210108153237.GB4183@fieldses.org>
 <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpQVxOPmA6o535yEC34fNrA2Of=_W-f49L6gDvxVC3FH6w@mail.gmail.com>
 <20210118225557.GB23934@fieldses.org>
 <CAHxDmpQdYHrL8_voEMRJ6kNUuWApz3a_KxD_88LTrJviivTkpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHxDmpQdYHrL8_voEMRJ6kNUuWApz3a_KxD_88LTrJviivTkpQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 19, 2021 at 10:48:22AM +0800, 吴异 wrote:
> My patch is below:
> /fs/nfsd/nfsfh.c
> 
> nfsd_acceptable(void expv,struct dentry *dentry)
> {
> -     if(exp->ex_flags & NFSEXP_NOSUBTREEXHECK)
> -     return 1;
> 
> +     if(is_root_export(exp))
> +       return 1;

So you end up doing the SUBTREECHECK checks in cases where the
filehandle doesn't actually have any parent information.  That means we
may be stuck with no way to connect the file back up the export point,
so this check will fail even though the file may be under the export
point.  So users probably get spurious ESTALE errors.

To reproduce you probably need to do something like open a file on the
client, reboot the server, then try to access the open file again.  The
dentry cache will no longer know how to look up the parents after the
reboot.

--b.

> 
> +    /* If not subdirectory export, accept anything*/
> 
> }
> 
> 
> 
> 
> 在 2021年1月19日星期二，bfields@fieldses.org <bfields@fieldses.org> 写道：
> > On Tue, Jan 19, 2021 at 12:29:28AM +0800, 吴异 wrote:
> >> I want to consult you on what is the original intention of designing
> >> subtree_check and whether it is to solve the  'I want to export a
> >> subtree of a filesystem' problem.
> >>
> >> As far as I know, when opening subtree_check, the folder's  file
> >> handle does not contain the inode information of its parent directory
> >> and
> >> 'while (tdentry != exp->ex_path.dentry && !IS_ROOT(tdentry))' in
> >> nfsd_acceptable can work well to Intercept handles beyond the export
> >> point.
> >>
> >> This seems to delete code as follows in nfsfh.c could solve the  'I
> >> want to export a subtree of a filesystem' problem and ensure safety:
> >> if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
> >> return 1;
> >>
> >> Or replace by follow:
> >> if (exp->ex_path.dentry == exp->vfs_mount->mnt_root)
> >> return 1;
> >>
> >> When I was reading the nfsd code, I was confused about whether the
> >> designer used the file system as a security boundary or an export
> >> point.Since exporting a complete file system is the safest, why not
> >> directly prohibit unsafe practices, but add code like subtree_check to
> >> try to verify the file handle.
> >
> > Sorry, I honestly don't understand the question.
> >
> > If you have a specific proposal, perhaps you could send a patch.
> >
> > --b.
> >
> >>
> >> I may not understand your design ideas.
> >>
> >> Yours sincerely,
> >>
> >> Trond Myklebust <trondmy@hammerspace.com> 于2021年1月13日周三 上午12:53写道：
> >> >
> >> > On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
> >> > > On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
> >> > > > Telling users how to configure the exported file system in the most
> >> > > > secure
> >> > > > way does
> >> > > > mitigate the problem to some extent, but this does not seem to
> >> > > > address the
> >> > > > security risks posed by no_ subtree_ check in the code. In my
> >> > > > opinion,when
> >> > > > the generated filehandle does not contain the inode information of
> >> > > > the
> >> > > > parent directory,the nfsd_acceptable function can also recursively
> >> > > > determine whether the request file exceeds the export path
> >> > > > dentry.Enabling
> >> > > > subtree_check to add parent directory information only brings some
> >> > > > troubles.
> >> > >
> >> > > Filesystems don't necessarily provide us with an efficient way to
> >> > > find
> >> > > parent directories from any given file.  (And note a single file may
> >> > > have multiple parent directories.)
> >> > >
> >> > > (I do wonder if we could do better in the directory case, though.  We
> >> > > already reconnect directories all the way back up to the root.)
> >> > >
> >> > > > I have a bold idea, why not directly remove the file handle
> >> > > > modification in
> >> > > > subtree_check, and then normalize the judgment of whether dentry
> >> > > > exceeds
> >> > > > the export point directory in nfsd_acceptable (line 38 to 54 in
> >> > > > /fs/nfsd/nfsfh.c) .
> >> > > >
> >> > > > As far as I understand it, the reason why subtree_check is not
> >> > > > turned on by
> >> > > > default is that it will cause problems when reading and writing
> >> > > > files,
> >> > > > rather than it wastes more time when nfsd_acceptable.
> >> > > >
> >> > > > In short,I think it's open to question whether the security of the
> >> > > > system
> >> > > > depends on the user's complete correct configuration(the system
> >> > > > does not
> >> > > > prohibit the export of a subdirectory).
> >> > >
> >> > > > Enabling subtree_check to add parent directoryinformation only
> >> > > > brings
> >> > > > some troubles.
> >> > > >
> >> > > > In short,I think it's open to question whether the security of the
> >> > > > system depends on the user's complete correct configuration(the
> >> > > > system
> >> > > > does not prohibit the export of a subdirectory).
> >> > >
> >> > > I'd love to replace the export interface by one that prohibited
> >> > > subdirectory exports (or at least made it more obvious where they're
> >> > > being used.)
> >> > >
> >> > > But given the interface we already have, that would be a disruptive
> >> > > and
> >> > > time-consuming change.
> >> > >
> >> > > Another approach is to add more entropy to filehandles so they're
> >> > > harder
> >> > > to guess; see e.g.:
> >> > >
> >> > >         https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html
> >> > >
> >> > > In the end none of these change the fact that a filehandle has an
> >> > > infinite lifetime, so once it's leaked, there's nothing you can do.
> >> > > The
> >> > > authors suggest NFSv4 volatile filehandles as a solution to that
> >> > > problem, but I don't think they've thought through the obstacles to
> >> > > making volatile filehandles work.
> >> > >
> >> > > --b.
> >> >
> >> > The point is that there is no good solution to the 'I want to export a
> >> > subtree of a filesystem' problem, and so it is plainly wrong to try to
> >> > make a default of those solutions, which break the one sane case of
> >> > exporting the whole filesystem.
> >> >
> >> > Just a reminder that we kicked out subtree_check not only because a
> >> > trivial rename of a file breaks the client's ability to perform I/O by
> >> > invalidating the filehandle. In addition, that option causes filehandle
> >> > aliasing (i.e. multiple filehandles pointing to the same file) which is
> >> > a major PITA for clients to try to manage for more or less the same
> >> > reason that it is a major PITA to try to manage these files using
> >> > paths.
> >> >
> >> > The discussion on volatile filehandles in RFC5661 does try to address
> >> > some of the above issues, but ends up concluding that you need to
> >> > introduce POSIX-incompatible restrictions, such as trying to ban
> >> > renames and deletions of open files in order to make it work.
> >> >
> >> > None of these compromises are necessary if you export a whole
> >> > filesystem (or a hierarchy of whole filesystems). That's the sane case.
> >> > That's the one that people should default to using.
> >> >
> >> > --
> >> > Trond Myklebust
> >> > Linux NFS client maintainer, Hammerspace
> >> > trond.myklebust@hammerspace.com
> >> >
> >> >
> >
