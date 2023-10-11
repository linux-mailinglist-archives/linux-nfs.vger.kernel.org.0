Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688667C5890
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjJKPvT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjJKPvR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 11:51:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B5AF;
        Wed, 11 Oct 2023 08:51:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4704CC433C8;
        Wed, 11 Oct 2023 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697039470;
        bh=EcD+rqm/NhIn3meIeOkWIty0u746qayQHb6vTOuKoXc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tasefvpz/rppVX080bHBVxOs4v0BRL8iM+w7RqovByYcTsRT5Cq6MLeXhDuhyQvOR
         9jKTZunOWE38w/ld7PQkYcXAZkizyvFrCl5sYGCHgSucNSonyKZIxMXmCa2QvHNkiR
         zvYV7u6IWISBznpT4zfCtaQbSCCCsXuXj4wIt5nNppiDgqxZEKRTchk2wIsR3ew639
         KIqeGp+x6HUegIWrxKNre0qCKO4aTp1MTxGdVwHGpxUweSQ26nGNoKlQN8hAj4U/ZW
         wLCYvb5mXnU1wLJa3MV7D3zADqvQbmOZwBT2YWAu7oMUKfa69eahurYNQDEdGRTbeU
         AmcwcEKE2Vg6A==
Message-ID: <e0599593fcff0eca5c8287b8d09631b5fcb3a7e4.camel@kernel.org>
Subject: Re: [PATCH] xfs: reinstate the old i_version counter as
 STATX_CHANGE_COOKIE
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org
Date:   Wed, 11 Oct 2023 11:51:08 -0400
In-Reply-To: <20231011154938.GL21298@frogsfrogsfrogs>
References: <20230929-xfs-iversion-v1-1-38587d7b5a52@kernel.org>
         <b4136500fe6c49ee689dba139ce25824684719f2.camel@kernel.org>
         <20231011154938.GL21298@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-11 at 08:49 -0700, Darrick J. Wong wrote:
> On Wed, Oct 11, 2023 at 09:09:38AM -0400, Jeff Layton wrote:
> > On Fri, 2023-09-29 at 14:43 -0400, Jeff Layton wrote:
> > > The handling of STATX_CHANGE_COOKIE was moved into generic_fillattr i=
n
> > > commit 0d72b92883c6 (fs: pass the request_mask to generic_fillattr), =
but
> > > we didn't account for the fact that xfs doesn't call generic_fillattr=
 at
> > > all.
> > >=20
> > > Make XFS report its i_version as the STATX_CHANGE_COOKIE.
> > >=20
> > > Fixes: 0d72b92883c6 (fs: pass the request_mask to generic_fillattr)
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > I had hoped to fix this in a better way with the multigrain patches, =
but
> > > it's taking longer than expected (if it even pans out at this point).
> > >=20
> > > Until then, make sure we use XFS's i_version as the STATX_CHANGE_COOK=
IE,
> > > even if it's bumped due to atime updates. Too many invalidations is
> > > preferable to not enough.
> > > ---
> > >  fs/xfs/xfs_iops.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index 1c1e6171209d..2b3b05c28e9e 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -584,6 +584,11 @@ xfs_vn_getattr(
> > >  		}
> > >  	}
> > > =20
> > > +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > > +		stat->change_cookie =3D inode_query_iversion(inode);
> > > +		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > > +	}
> > > +
> > >  	/*
> > >  	 * Note: If you add another clause to set an attribute flag, please
> > >  	 * update attributes_mask below.
> > >=20
> > > ---
> > > base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
> > > change-id: 20230929-xfs-iversion-819fa2c18591
> > >=20
> > > Best regards,
> >=20
> > Ping?
> >=20
> > This patch is needed in v6.6 to prevent a regression when serving XFS
> > via NFSD. I'd prefer this go in via the xfs tree, but let me know if
> > you need me to get this merged this via a different one.
>=20
> Oh!   Right, this is needed because the "hide a state in the high bit of
> tv_nsec" stuff got reverted in -rc3, correct?  So now nfsd needs some
> way to know that something changed in the file, and better to have too
> many client invalidations than not enough?  And I guess bumping
> i_version will keep nfsd sane for now?
>=20
> If the answers are [yes, yes, yes] then:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Yes, yes, and yes. Can you guys shepherd this into mainline?

Thanks for the R-b!
--=20
Jeff Layton <jlayton@kernel.org>
