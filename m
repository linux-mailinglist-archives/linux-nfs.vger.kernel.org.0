Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2E352B7B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhDBOcT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 10:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235714AbhDBOcS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Apr 2021 10:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617373937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6E+DGN3NJ2bcradoTg4mcZ6ovZ2PZ/Vz7Q9EYkYMI6M=;
        b=K2/UqWsAXAIigTHExf6JR7LEFeulk4RJ56F7hsWbZBfeAjZeMUQBDJEkwXgYJfwJ2kad8X
        6Rh6SN2JwK7wqF6fsGs/BBDrFJgoDm8/XCkhGe+WNa4I872zFulKv3g4AeH1d5Hm6thOWP
        gtu0iv1uQRVRbEnk6vCjFq5DGXqK0bQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-_X0fW7YJPiW0y2IUxSzidw-1; Fri, 02 Apr 2021 10:32:15 -0400
X-MC-Unique: _X0fW7YJPiW0y2IUxSzidw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8547881744F;
        Fri,  2 Apr 2021 14:32:14 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5355D60BF1;
        Fri,  2 Apr 2021 14:32:14 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2F5FF1206A8; Fri,  2 Apr 2021 10:32:13 -0400 (EDT)
Date:   Fri, 2 Apr 2021 10:32:13 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Message-ID: <YGcq7T2wZHJvONHu@pick.fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>
 <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
> On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > According to the RFC 7862, "if the server cannot find a
> > > corresponding sa_what, then the status will still be NFS4_OK,
> > > but sr_eof would be TRUE". If there is a file that ends with
> > > a hole and a SEEK request made for sa_what=SEEK_DATA with
> > > an offset in the middle of the last hole, then the server
> > > has to return OK and set the eof. Currently the linux server
> > > returns ERR_NXIO.
> >
> > Makes sense, but I think you can use the return value from vfs_llseek
> > instead of checking the file size again.  E.g.:
> >
> >         seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
> >         if (seek->seek_pos == -ENXIO)
> >                 seek->seek_eof = true;
> 
> I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
> specified seek_offset was beyond the end of the file the server must
> return ERR_NXIO and not OK.

OK, never mind.

> and (2) for the same reason I need to
> check if the requested type was looking for data but didn't find it
> because the offset is in the middle of the hole but still within the
> file size (thus the need to check if the seek_offset is within the
> file size). But I'm happy to check specifically if the seek_pos was
> ENXIO (and not the generic negative error) and then also check if
> request was for data and request was within file size.
> 
> Also while I'm fixing this and have your attention, Can you tell if
> the "else if" condition in the original code makes sense to you. I
> didn't touch it but I don't think it's correct. "else if
> (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
> believe this can ever happen. How can vfs_llseek() ever return a
> position that is greater than the size of the file (or actually even
> equal to it)?

I agree, I don't get it either.

--b.

> 
> >         else if (seek->seek_pos < 0)
> >                 status = nfserrno(seek->seek_pos);
> >
> > --b.
> >
> > >
> > > Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index e13c4c81fb89..2e7ceb9f1d5d 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >        *        should ever file->f_pos.
> > >        */
> > >       seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> > > -     if (seek->seek_pos < 0)
> > > -             status = nfserrno(seek->seek_pos);
> > > -     else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > > +     if (seek->seek_pos < 0) {
> > > +             if (whence == SEEK_DATA &&
> > > +                 seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> > > +                     seek->seek_eof = true;
> > > +             else
> > > +                     status = nfserrno(seek->seek_pos);
> > > +     } else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > >               seek->seek_eof = true;
> > >
> > >  out:
> > > --
> > > 2.18.2
> > >
> >
> 

