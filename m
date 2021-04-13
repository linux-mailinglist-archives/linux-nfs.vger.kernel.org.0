Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8935E50A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347175AbhDMRak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhDMRak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 13:30:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F009C061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 10:30:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C0FA724B; Tue, 13 Apr 2021 13:30:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6C0FA724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618335019;
        bh=U8CbN9Ns2AFOjwBzuAG0btWt7g9lyzNdG3iwrv0Qh3U=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=GOduFtzhwp7smdyFXkLsJQdSGFY+mQCAGzpcHsnLQAPnLthVkORRWxLTUqZzR1N9g
         v4Cd5D+ofAq9uXiijajz+CSOlqVhwYjYTqWHcMLYXeOEcHdMVsKPqGaYvdT9fjTWQw
         fYP0LfzgKeHBhtskB8m+lbslLvt41cHynAuc86Rc=
Date:   Tue, 13 Apr 2021 13:30:19 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Message-ID: <20210413173019.GB28230@fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YGcq7T2wZHJvONHu@pick.fieldses.org>
 <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
 <2ACF7423-7162-4880-B8B7-4580208925E5@oracle.com>
 <YHWyRNTZ6QyAgcIW@pick.fieldses.org>
 <CAN-5tyEp5=QEMRsObv9dy7Yi7jd+cqtEv4S5TRkSnb=ix5rf1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEp5=QEMRsObv9dy7Yi7jd+cqtEv4S5TRkSnb=ix5rf1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 11:31:51AM -0400, Olga Kornievskaia wrote:
> On Tue, Apr 13, 2021 at 11:01 AM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Sun, Apr 11, 2021 at 04:43:22PM +0000, Chuck Lever III wrote:
> > >
> > >
> > > > On Apr 9, 2021, at 2:39 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > > >
> > > > On Fri, Apr 2, 2021 at 10:32 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > > >>
> > > >> On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
> > > >>> On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > > >>>>
> > > >>>> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> > > >>>>> From: Olga Kornievskaia <kolga@netapp.com>
> > > >>>>>
> > > >>>>> According to the RFC 7862, "if the server cannot find a
> > > >>>>> corresponding sa_what, then the status will still be NFS4_OK,
> > > >>>>> but sr_eof would be TRUE". If there is a file that ends with
> > > >>>>> a hole and a SEEK request made for sa_what=SEEK_DATA with
> > > >>>>> an offset in the middle of the last hole, then the server
> > > >>>>> has to return OK and set the eof. Currently the linux server
> > > >>>>> returns ERR_NXIO.
> > > >>>>
> > > >>>> Makes sense, but I think you can use the return value from vfs_llseek
> > > >>>> instead of checking the file size again.  E.g.:
> > > >>>>
> > > >>>>        seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
> > > >>>>        if (seek->seek_pos == -ENXIO)
> > > >>>>                seek->seek_eof = true;
> > > >>>
> > > >>> I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
> > > >>> specified seek_offset was beyond the end of the file the server must
> > > >>> return ERR_NXIO and not OK.
> > > >>
> > > >> OK, never mind.
> > > >>
> > > >>> and (2) for the same reason I need to
> > > >>> check if the requested type was looking for data but didn't find it
> > > >>> because the offset is in the middle of the hole but still within the
> > > >>> file size (thus the need to check if the seek_offset is within the
> > > >>> file size). But I'm happy to check specifically if the seek_pos was
> > > >>> ENXIO (and not the generic negative error) and then also check if
> > > >>> request was for data and request was within file size.
> > > >>>
> > > >>> Also while I'm fixing this and have your attention, Can you tell if
> > > >>> the "else if" condition in the original code makes sense to you. I
> > > >>> didn't touch it but I don't think it's correct. "else if
> > > >>> (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
> > > >>> believe this can ever happen. How can vfs_llseek() ever return a
> > > >>> position that is greater than the size of the file (or actually even
> > > >>> equal to it)?
> > > >>
> > > >> I agree, I don't get it either.
> > > >
> > > > Any more thoughts about the forward progress of this patch? Are you
> > > > interested in taking it?
> > >
> > > Bruce and I discussed this privately a few days back. He asked
> > > that I not merge it until the client compatibility issue is
> > > resolved. Bruce, please chime in if I misunderstood you.
> >
> > Honestly, I haven't even looked at what the issue is.  I think Olga
> > agreed with Rick that there was one, though?
> 
> I agree that the client is broken. I have a client side patch that was
> posted alongside the server side patch. I think Trond should be taking
> it for whatever the next push will be. But yes the server side needs
> to worry about the existing broken clients that are out there
> currently. I'm not sure what the implications are. So what happens
> with the fixed server is that for the request for DATA in the last
> hole, the server would return OK, eof and offset that max_int (-1)
> (previously it would be an error). Broken client would return that
> address back in the system call. If the application tries to read from
> it, it would not get anything (0, oef).
> 
> I think I'll repost the v2 and then I'll let you decide when and how
> you want to take it. The client will soon be able to handle both but
> it doesn't require the server to be fixed.

OK.  I don't particularly want to create a situation where a server
upgrade requires a client upgrade, so I don't think we'd want to take it
now, but post it anyway, for posterity's sake--maybe the tradeoffs would
be different in a few years.

--b.
