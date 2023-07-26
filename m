Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2776367E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjGZMkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGZMkg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 08:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3561FC4
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 05:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78ADB61AE3
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 12:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04BC433C7;
        Wed, 26 Jul 2023 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690375234;
        bh=DuPEl4lgt1OdCRsfFFAVBmY2bdsL8s/CkYPgfSNOr3E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uygzKgRDbt1Jp3Zq9ca3TPsYtKDFcI8LOvMkl8iSD7ns6ZJkJKknD80GlfF/H8ltK
         6VECgqaxSg9c+YqNUF6J2YBbpRK3G/u3vXo7yL5BoWdWCJbo9Eme9GK/g84k7Qs7nM
         wTKsgwVFzh43jSVJUW9O0walaL7Ph6uvLaibbmo3XBmAsi4Y0g+D7+Z9LBmwehefJd
         P9El8eKZEEdYOmmR1eJjBypj2AzJsmwJLj2aINezHXsJB51z79qea0nGd651ThrfjJ
         hsQ3NoDVzAZK0JSKuSLwMrGlG4FVQXR2osd3ITkuzYQ5LmKAfqDNm6fqIN5ZxRau/8
         D0bKj5c5hd7jA==
Message-ID: <7b8e81b3ab44b5bc788a024dec6465adcc01d7a3.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in
 nfs_inode_remove_request()
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Wed, 26 Jul 2023 08:40:33 -0400
In-Reply-To: <1a2ee0602cd169a96db29565449e2e6cc7a31912.camel@hammerspace.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
         <20230725150807.8770-2-smayhew@redhat.com>
         <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
         <ZL/3MZDNGqwlOgPW@aion>
         <1a2ee0602cd169a96db29565449e2e6cc7a31912.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-25 at 17:41 +0000, Trond Myklebust wrote:
> On Tue, 2023-07-25 at 12:24 -0400, Scott Mayhew wrote:
> > On Tue, 25 Jul 2023, Trond Myklebust wrote:
> >=20
> > > On Tue, 2023-07-25 at 11:08 -0400, Scott Mayhew wrote:
> > > > Once a folio's private data has been cleared, it's possible for
> > > > another
> > > > process to clear the folio->mapping (e.g. via
> > > > invalidate_complete_folio2
> > > > or evict_mapping_folio), so it wouldn't be safe to call
> > > > nfs_page_to_inode() after that.
> > > >=20
> > > > Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use
> > > > folios")
> > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > ---
> > > > =A0fs/nfs/write.c | 4 +++-
> > > > =A01 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > index f4cca8f00c0c..489c3f9dae23 100644
> > > > --- a/fs/nfs/write.c
> > > > +++ b/fs/nfs/write.c
> > > > @@ -785,6 +785,8 @@ static void nfs_inode_add_request(struct
> > > > nfs_page
> > > > *req)
> > > > =A0 */
> > > > =A0static void nfs_inode_remove_request(struct nfs_page *req)
> > > > =A0{
> > > > +=A0=A0=A0=A0=A0=A0=A0struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_=
inode(req));
> > > > +
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (nfs_page_group_sync_on_bit(req, PG_REMO=
VE)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct folio *folio=
 =3D nfs_page_to_folio(req-
> > > > > wb_head);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct address_spac=
e *mapping =3D
> > > > folio_file_mapping(folio);
> > > > @@ -800,7 +802,7 @@ static void nfs_inode_remove_request(struct
> > > > nfs_page *req)
> > > > =A0
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (test_and_clear_bit(PG_INODE_REF, &req->=
wb_flags)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs_release_request=
(req);
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&NFS_=
I(nfs_page_to_inode(req))-
> > > > > nrequests);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&nfsi=
->nrequests);
> > >=20
> > > Why not just invert the order of the atomic_long_dec() and the
> > > nfs_release_request()? That way you are also ensuring that the
> > > inode is
> > > still pinned in memory by the open context.
> >=20
> > I'm not following.=A0 How does inverting the order prevent the
> > folio->mapping from getting clobbered?
> >=20
>=20
> The open/lock context is refcounted by the nfs_page until the latter is
> released. That's why the inode is guaranteed to remain around at least
> until the  call to nfs_release_request().
>=20

The problem is not that the inode is going away, but rather that we
can't guarantee that the page is still part of the mapping at this
point, and so we can't safely dereference page->mapping there. I do see
that nfs_release_request releases a reference to the page, but I don't
think that's sufficient to ensure that it remains part of the mapping.

AFAICT, once we clear page->private, the page is subject to be removed
from the mapping. So, I *think* it's safe to just move the call to
nfs_page_to_inode prior to the call to nfs_page_group_sync_on_bit.
--=20
Jeff Layton <jlayton@kernel.org>
