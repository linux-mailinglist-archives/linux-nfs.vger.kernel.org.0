Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC12F37E2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 19:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbhALSEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 13:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhALSEH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 13:04:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0FC061795
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 10:03:27 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 351B26EAF; Tue, 12 Jan 2021 13:03:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 351B26EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610474606;
        bh=hEKb+s7MpdRj7XbR/1cCvb2HUrovupZLosphnISlG/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXk9HJGAiPVmQFCEFqiwXyyLC0xlItTxOljRO3l2ELSyCcXBel3mE+i5Fp/S63ajx
         SO6e+nL7lQfUPsrV3Onx44NtIaA7X6wnm8yyrQcOvZ+uB4ug5XRhi3ZLl38sf9Ro0w
         fUp1h+zNBKoB6apiQJzNutvxF4XqcMvmCS0NbbrI=
Date:   Tue, 12 Jan 2021 13:03:26 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210112180326.GI9248@fieldses.org>
References: <20210108152017.GA4183@fieldses.org>
 <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org>
 <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 12, 2021 at 11:20:28AM -0600, Patrick Goetz wrote:
> I was under the impression that the best practice is to create
> something along the lines of
> 
>   /srv/nfs
> 
> and then bind mount everything you plan to export into that folder; e.g.
>
> /etc/fstab:
> /data2/xray      /srv/nfs/xray        none    defaults,bind    0

You can do that if you'd like.  I doesn't make much difference here.

You can think of a filehandle as just a (device number, inode number)
pair.  (It's actually more complicated, but ignore that for now.)

So if the server's given a filehandle, it can easily determine the
filehandle is for an object on /dev/sda2.  It *cannot* easily determine
whether that object is somewhere underneath /some/directory.

So in your example, if /data2/xray is on the same filesystem as /data2,
then the server will happily allow operations on filehandles anywhere in
/data2.

Every export point should be the root of a filesystem.

--b.

> 
> Presumably this becomes a non-issue under these circumstances? Not
> sure it's a good idea to attempt to accommodate every wacky use case
> someone attempts to implement.
> 
> 
> On 1/12/21 10:53 AM, Trond Myklebust wrote:
> >On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
> >>On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
> >>>Telling users how to configure the exported file system in the most
> >>>secure
> >>>way does
> >>>mitigate the problem to some extent, but this does not seem to
> >>>address the
> >>>security risks posed by no_ subtree_ check in the code. In my
> >>>opinion,when
> >>>the generated filehandle does not contain the inode information of
> >>>the
> >>>parent directory,the nfsd_acceptable function can also recursively
> >>>determine whether the request file exceeds the export path
> >>>dentry.Enabling
> >>>subtree_check to add parent directory information only brings some
> >>>troubles.
> >>
> >>Filesystems don't necessarily provide us with an efficient way to
> >>find
> >>parent directories from any given file.  (And note a single file may
> >>have multiple parent directories.)
> >>
> >>(I do wonder if we could do better in the directory case, though.  We
> >>already reconnect directories all the way back up to the root.)
> >>
> >>>I have a bold idea, why not directly remove the file handle
> >>>modification in
> >>>subtree_check, and then normalize the judgment of whether dentry
> >>>exceeds
> >>>the export point directory in nfsd_acceptable (line 38 to 54 in
> >>>/fs/nfsd/nfsfh.c) .
> >>>
> >>>As far as I understand it, the reason why subtree_check is not
> >>>turned on by
> >>>default is that it will cause problems when reading and writing
> >>>files,
> >>>rather than it wastes more time when nfsd_acceptable.
> >>>
> >>>In short,I think it's open to question whether the security of the
> >>>system
> >>>depends on the user's complete correct configuration(the system
> >>>does not
> >>>prohibit the export of a subdirectory).
> >>
> >>>Enabling subtree_check to add parent directoryinformation only
> >>>brings
> >>>some troubles.
> >>>
> >>>In short,I think it's open to question whether the security of the
> >>>system depends on the user's complete correct configuration(the
> >>>system
> >>>does not prohibit the export of a subdirectory).
> >>
> >>I'd love to replace the export interface by one that prohibited
> >>subdirectory exports (or at least made it more obvious where they're
> >>being used.)
> >>
> >>But given the interface we already have, that would be a disruptive
> >>and
> >>time-consuming change.
> >>
> >>Another approach is to add more entropy to filehandles so they're
> >>harder
> >>to guess; see e.g.:
> >>
> >>         https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html
> >>
> >>In the end none of these change the fact that a filehandle has an
> >>infinite lifetime, so once it's leaked, there's nothing you can do.
> >>The
> >>authors suggest NFSv4 volatile filehandles as a solution to that
> >>problem, but I don't think they've thought through the obstacles to
> >>making volatile filehandles work.
> >>
> >>--b.
> >
> >The point is that there is no good solution to the 'I want to export a
> >subtree of a filesystem' problem, and so it is plainly wrong to try to
> >make a default of those solutions, which break the one sane case of
> >exporting the whole filesystem.
> >
> >Just a reminder that we kicked out subtree_check not only because a
> >trivial rename of a file breaks the client's ability to perform I/O by
> >invalidating the filehandle. In addition, that option causes filehandle
> >aliasing (i.e. multiple filehandles pointing to the same file) which is
> >a major PITA for clients to try to manage for more or less the same
> >reason that it is a major PITA to try to manage these files using
> >paths.
> >
> >The discussion on volatile filehandles in RFC5661 does try to address
> >some of the above issues, but ends up concluding that you need to
> >introduce POSIX-incompatible restrictions, such as trying to ban
> >renames and deletions of open files in order to make it work.
> >
> >None of these compromises are necessary if you export a whole
> >filesystem (or a hierarchy of whole filesystems). That's the sane case.
> >That's the one that people should default to using.
> >
