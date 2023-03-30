Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74536D0D8E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC3SPi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC3SPe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 14:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5AD516
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 11:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273B16215E
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 18:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7E8C4339B;
        Thu, 30 Mar 2023 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680200103;
        bh=0OrWXcbPKMAF4lmWnYLRuGIeSBQFRJkWcF3YWkHn15c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ARQ1Wr6EhD3AjlWCwCyjihqxgEpeS9UAMFkD8fKfkKk2uqfPg4lPmuXegqFTpsv7s
         Ezx8VUlCuyIZ1jq+u9kcgoWFwHUNHw61IxYB00I5VG0l8B+ER+v1hM3dgye4eax2A6
         AQ9CLc0gt5uRV8W9TcsErKe5zGgStq/cZSlc3dsbBSCnco99U5FHp2sn3ReLI5xBAm
         QkyjN0DUr0ntFodkR3CwPK+aTJLF2XTw3UX7Ft8U4WGN9TpzD+4Io8wOTO2PW4nDf7
         Jy7BNA7Mc49y/c8z3pQYPS3kLLbXqsG3aYuzMQd+vSaDN5YOZqRSRW01tWxHM4cGKm
         I7NfxRBfv5B5w==
Message-ID: <c4c64bc500a795462c299a44c45a923005ed7993.camel@kernel.org>
Subject: Re: [PATCH] nfsd: call op_release, even when op_func returns an
 error
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Zhi Li <yieli@redhat.com>
Date:   Thu, 30 Mar 2023 14:15:01 -0400
In-Reply-To: <C871117E-1591-4F1C-94DE-3854F88FF8FF@oracle.com>
References: <20230327102137.15412-1-jlayton@kernel.org>
         <C871117E-1591-4F1C-94DE-3854F88FF8FF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-27 at 13:14 +0000, Chuck Lever III wrote:
>=20
> > On Mar 27, 2023, at 6:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > For ops with "trivial" replies, nfsd4_encode_operation will shortcut
> > most of the encoding work and skip to just marshalling up the status.
> > One of the things it skips is calling op_release. This could cause a
> > memory leak in the layoutget codepath if there is an error at an
> > inopportune time.
> >=20
> > Have the compound processing engine always call op_release, even when
> > op_func sets an error in op->status. With this change, we also need
> > nfsd4_block_get_device_info_scsi to set the gd_device pointer to NULL
> > on error to avoid a double free.
> >=20
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2181403
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Thanks, Jeff.
>=20
> May I add: Fixes: 34b1744c91cc ("nfsd4: define ->op_release for
> compound ops") ?
>=20

I've seen some problems with this patch in testing and I have a fix
forthcoming (once I finish testing it):

The root cause is the OPDESC() function which can walk off the end of
the nfsd4_ops array when passed a large value (like OP_ILLEGAL). I think
we'll want to fix that to do something more sane before merging this
patch.

>=20
> > ---
> > fs/nfsd/blocklayout.c |  1 +
> > fs/nfsd/nfs4xdr.c     | 13 +++++++------
> > 2 files changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > index 04697f8dc37d..01d7fd108cf3 100644
> > --- a/fs/nfsd/blocklayout.c
> > +++ b/fs/nfsd/blocklayout.c
> > @@ -297,6 +297,7 @@ nfsd4_block_get_device_info_scsi(struct super_block=
 *sb,
> >=20
> > out_free_dev:
> > 	kfree(dev);
> > +	gdp->gd_device =3D NULL;
> > 	return ret;
> > }
> >=20
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index e12e5a4ad502..6b675fbdabd0 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -5402,7 +5402,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
> > 	p =3D xdr_reserve_space(xdr, 8);
> > 	if (!p) {
> > 		WARN_ON_ONCE(1);
> > -		return;
> > +		goto release;
> > 	}
> > 	*p++ =3D cpu_to_be32(op->opnum);
> > 	post_err_offset =3D xdr->buf->len;
> > @@ -5418,8 +5418,6 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
> > 	op->status =3D encoder(resp, op->status, &op->u);
> > 	if (op->status)
> > 		trace_nfsd_compound_encode_err(rqstp, op->opnum, op->status);
> > -	if (opdesc && opdesc->op_release)
> > -		opdesc->op_release(&op->u);
> > 	xdr_commit_encode(xdr);
> >=20
> > 	/* nfsd4_check_resp_size guarantees enough room for error status */
> > @@ -5460,11 +5458,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres=
 *resp, struct nfsd4_op *op)
> > 	}
> > status:
> > 	*p =3D op->status;
> > +release:
> > +	if (opdesc && opdesc->op_release)
> > +		opdesc->op_release(&op->u);
> > }
> >=20
> > -/*=20
> > - * Encode the reply stored in the stateowner reply cache=20
> > - *=20
> > +/*
> > + * Encode the reply stored in the stateowner reply cache
> > + *
> >  * XDR note: do not encode rp->rp_buflen: the buffer contains the
> >  * previously sent already encoded operation.
> >  */
> > --=20
> > 2.39.2
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
