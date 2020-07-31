Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73817234BB5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGaToF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 15:44:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgGaToE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jul 2020 15:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596224641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+cHcZnFI3LTjGoYiaYlADjcrmOWSPML0BS0dBIVEwc=;
        b=DJn+JcN+ZnS7th7CcS7xID2F024Ivl6oNtyx18SC5m14i7InfWxkcNAu9vAHYG9Yeu7Tsc
        wD4sxjW71KgDPZRQ3Y9QHOAIL1AfsvP8106pjjS2WsU0hydLViff/Y4Vs3sgrqIpOMMyzx
        WGDPkTReIFJvJ5+Py+G9USaQfy7byfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Sy8Q65GoNn6daqiEI8Luew-1; Fri, 31 Jul 2020 15:43:59 -0400
X-MC-Unique: Sy8Q65GoNn6daqiEI8Luew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5B3102C7ED;
        Fri, 31 Jul 2020 19:43:58 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C2B97C0ED;
        Fri, 31 Jul 2020 19:43:58 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 295A81A0006; Fri, 31 Jul 2020 15:43:57 -0400 (EDT)
Date:   Fri, 31 Jul 2020 15:43:57 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfs: ensure correct writeback errors are returned on
 close()
Message-ID: <20200731194357.GJ4452@aion.usersys.redhat.com>
References: <20200731174614.1299346-1-smayhew@redhat.com>
 <20200731174614.1299346-2-smayhew@redhat.com>
 <cbd94bd68cbdefd06591ae7ba4d57fdd8b619ebf.camel@hammerspace.com>
MIME-Version: 1.0
In-Reply-To: <cbd94bd68cbdefd06591ae7ba4d57fdd8b619ebf.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 31 Jul 2020, Trond Myklebust wrote:

> On Fri, 2020-07-31 at 13:46 -0400, Scott Mayhew wrote:
> > nfs_wb_all() calls filemap_write_and_wait(), which uses
> > filemap_check_errors() to determine the error to return.
> > filemap_check_errors() only looks at the mapping->flags and will
> > therefore only return either -ENOSPC or -EIO.  To ensure that the
> > correct error is returned on close(), nfs{,4}_file_flush() should
> > call
> > file_check_and_advance_wb_err() which looks at the errseq value in
> > mapping->wb_err.
> >=20
> > Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism
> > with
> > generic one")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfs/file.c     | 3 ++-
> >  fs/nfs/nfs4file.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > index f96367a2463e..eeef6580052f 100644
> > --- a/fs/nfs/file.c
> > +++ b/fs/nfs/file.c
> > @@ -148,7 +148,8 @@ nfs_file_flush(struct file *file, fl_owner_t id)
> >  =09=09return 0;
> > =20
> >  =09/* Flush writes to the server and return any errors */
> > -=09return nfs_wb_all(inode);
> > +=09nfs_wb_all(inode);
> > +=09return file_check_and_advance_wb_err(file);
> >  }
> > =20
> >  ssize_t
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index 8e5d6223ddd3..77bf9c12734c 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -125,7 +125,8 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
> >  =09=09return filemap_fdatawrite(file->f_mapping);
> > =20
> >  =09/* Flush writes to the server and return any errors */
> > -=09return nfs_wb_all(inode);
> > +=09nfs_wb_all(inode);
> > +=09return file_check_and_advance_wb_err(file);
> >  }
> > =20
> >  #ifdef CONFIG_NFS_V4_2
>=20
> I don't think this one is correct. The contract with POSIX is that we
> always deliver the error on fsync(). If we call
> file_check_and_advance_wb_err() here in nfs_file_flush(), then that
> means we eat the error before it can get delivered to fsync().

I was looking at callers of the flush f_op and the only one I saw was
filp_close(), so I assumed that there wouldn't be any other calls to
fsync() for that struct file... I guess that's not the case if the file
descriptor was duplicated though.

Would a solution using filemap_sample_wb_err() & filemap_check_wb_err()
be acceptable (like in the 2nd patch)?

-Scott
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

