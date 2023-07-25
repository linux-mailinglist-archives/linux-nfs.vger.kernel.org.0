Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B68C761E6D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGYQZQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYQZP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 12:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0DBA4
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690302270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bc4bUrycSmnQHhdeTfseBFkL7XVCpvPdW2AxoqqEHPk=;
        b=L61n3ke5MYApBthBeC5EuiMm6eXvkRUdLkwl6lbFCe2m/uoQuNKpNvd+sIjttKA89Isart
        PGKgD0s4U9kzkSizZdoilpHwvneRwJvMeQ0N3w5PsXcwHmJ5MfkiEOX+MYF57Ocl8l7WBk
        Zg9JanAo0UpTP/I8qJ0AitCCGfJqL2M=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-oxIkhdd2Oemb8C5KMMqk0g-1; Tue, 25 Jul 2023 12:24:28 -0400
X-MC-Unique: oxIkhdd2Oemb8C5KMMqk0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 134901C075A5;
        Tue, 25 Jul 2023 16:24:18 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.8.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 049B540C2063;
        Tue, 25 Jul 2023 16:24:17 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
        id 85FF162734; Tue, 25 Jul 2023 12:24:17 -0400 (EDT)
Date:   Tue, 25 Jul 2023 12:24:17 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Message-ID: <ZL/3MZDNGqwlOgPW@aion>
References: <20230725150807.8770-1-smayhew@redhat.com>
 <20230725150807.8770-2-smayhew@redhat.com>
 <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jul 2023, Trond Myklebust wrote:

> On Tue, 2023-07-25 at 11:08 -0400, Scott Mayhew wrote:
> > Once a folio's private data has been cleared, it's possible for
> > another
> > process to clear the folio->mapping (e.g. via
> > invalidate_complete_folio2
> > or evict_mapping_folio), so it wouldn't be safe to call
> > nfs_page_to_inode() after that.
> >=20
> > Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> > =A0fs/nfs/write.c | 4 +++-
> > =A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index f4cca8f00c0c..489c3f9dae23 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -785,6 +785,8 @@ static void nfs_inode_add_request(struct nfs_page
> > *req)
> > =A0 */
> > =A0static void nfs_inode_remove_request(struct nfs_page *req)
> > =A0{
> > +=A0=A0=A0=A0=A0=A0=A0struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inod=
e(req));
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0if (nfs_page_group_sync_on_bit(req, PG_REMOVE))=
 {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct folio *folio =3D=
 nfs_page_to_folio(req-
> > >wb_head);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct address_space *m=
apping =3D
> > folio_file_mapping(folio);
> > @@ -800,7 +802,7 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (test_and_clear_bit(PG_INODE_REF, &req->wb_f=
lags)) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs_release_request(req=
);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&NFS_I(nf=
s_page_to_inode(req))-
> > >nrequests);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&nfsi->nr=
equests);
>=20
> Why not just invert the order of the atomic_long_dec() and the
> nfs_release_request()? That way you are also ensuring that the inode is
> still pinned in memory by the open context.

I'm not following.  How does inverting the order prevent the
folio->mapping from getting clobbered?

-Scott
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0}
> > =A0
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

