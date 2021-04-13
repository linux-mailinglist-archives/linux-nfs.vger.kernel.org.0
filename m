Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50B135E22A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhDMPBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 11:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239913AbhDMPBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 11:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618326088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFVspUNnPBOI6FR3y7k/VyUAVJvYSYLXyzsRgLSWUlQ=;
        b=fq1/i5C0in+BMiuZnn2Zsgo+IjeTM+hV6hzO7ni38iddeUWHyg9/Cp/3MjGCi1Vp5ICayn
        JXp9RP2M3BrrHhUqXKo0jemUVo+NoLCZINOeiHvO/X0RiWXe7EBQIsqQPc2k62YW5h6pcm
        rX5kIZ8KPvYftFrgNRMsJ8fHFoVm/B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-cUySk6MVP-23y37VW74e_Q-1; Tue, 13 Apr 2021 11:01:26 -0400
X-MC-Unique: cUySk6MVP-23y37VW74e_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21EF081747D;
        Tue, 13 Apr 2021 15:01:25 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-118-87.rdu2.redhat.com [10.10.118.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E74DA5C224;
        Tue, 13 Apr 2021 15:01:24 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2374412059B; Tue, 13 Apr 2021 11:01:24 -0400 (EDT)
Date:   Tue, 13 Apr 2021 11:01:24 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Message-ID: <YHWyRNTZ6QyAgcIW@pick.fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YGcq7T2wZHJvONHu@pick.fieldses.org>
 <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
 <2ACF7423-7162-4880-B8B7-4580208925E5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ACF7423-7162-4880-B8B7-4580208925E5@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Apr 11, 2021 at 04:43:22PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 9, 2021, at 2:39 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > 
> > On Fri, Apr 2, 2021 at 10:32 AM J. Bruce Fields <bfields@redhat.com> wrote:
> >> 
> >> On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
> >>> On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >>>> 
> >>>> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> >>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>> 
> >>>>> According to the RFC 7862, "if the server cannot find a
> >>>>> corresponding sa_what, then the status will still be NFS4_OK,
> >>>>> but sr_eof would be TRUE". If there is a file that ends with
> >>>>> a hole and a SEEK request made for sa_what=SEEK_DATA with
> >>>>> an offset in the middle of the last hole, then the server
> >>>>> has to return OK and set the eof. Currently the linux server
> >>>>> returns ERR_NXIO.
> >>>> 
> >>>> Makes sense, but I think you can use the return value from vfs_llseek
> >>>> instead of checking the file size again.  E.g.:
> >>>> 
> >>>>        seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
> >>>>        if (seek->seek_pos == -ENXIO)
> >>>>                seek->seek_eof = true;
> >>> 
> >>> I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
> >>> specified seek_offset was beyond the end of the file the server must
> >>> return ERR_NXIO and not OK.
> >> 
> >> OK, never mind.
> >> 
> >>> and (2) for the same reason I need to
> >>> check if the requested type was looking for data but didn't find it
> >>> because the offset is in the middle of the hole but still within the
> >>> file size (thus the need to check if the seek_offset is within the
> >>> file size). But I'm happy to check specifically if the seek_pos was
> >>> ENXIO (and not the generic negative error) and then also check if
> >>> request was for data and request was within file size.
> >>> 
> >>> Also while I'm fixing this and have your attention, Can you tell if
> >>> the "else if" condition in the original code makes sense to you. I
> >>> didn't touch it but I don't think it's correct. "else if
> >>> (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
> >>> believe this can ever happen. How can vfs_llseek() ever return a
> >>> position that is greater than the size of the file (or actually even
> >>> equal to it)?
> >> 
> >> I agree, I don't get it either.
> > 
> > Any more thoughts about the forward progress of this patch? Are you
> > interested in taking it?
> 
> Bruce and I discussed this privately a few days back. He asked
> that I not merge it until the client compatibility issue is
> resolved. Bruce, please chime in if I misunderstood you.

Honestly, I haven't even looked at what the issue is.  I think Olga
agreed with Rick that there was one, though?

--b.

> 
> 
> >> --b.
> >> 
> >>> 
> >>>>        else if (seek->seek_pos < 0)
> >>>>                status = nfserrno(seek->seek_pos);
> >>>> 
> >>>> --b.
> >>>> 
> >>>>> 
> >>>>> Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> >>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>> ---
> >>>>> fs/nfsd/nfs4proc.c | 10 +++++++---
> >>>>> 1 file changed, 7 insertions(+), 3 deletions(-)
> >>>>> 
> >>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>>>> index e13c4c81fb89..2e7ceb9f1d5d 100644
> >>>>> --- a/fs/nfsd/nfs4proc.c
> >>>>> +++ b/fs/nfsd/nfs4proc.c
> >>>>> @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >>>>>       *        should ever file->f_pos.
> >>>>>       */
> >>>>>      seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> >>>>> -     if (seek->seek_pos < 0)
> >>>>> -             status = nfserrno(seek->seek_pos);
> >>>>> -     else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> >>>>> +     if (seek->seek_pos < 0) {
> >>>>> +             if (whence == SEEK_DATA &&
> >>>>> +                 seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> >>>>> +                     seek->seek_eof = true;
> >>>>> +             else
> >>>>> +                     status = nfserrno(seek->seek_pos);
> >>>>> +     } else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> >>>>>              seek->seek_eof = true;
> >>>>> 
> >>>>> out:
> >>>>> --
> >>>>> 2.18.2
> 
> --
> Chuck Lever
> 
> 
> 

