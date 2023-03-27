Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424756CA7BF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjC0Ocq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0Ocm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 10:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D72B5
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 07:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE4B061295
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 14:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6994C433D2;
        Mon, 27 Mar 2023 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679927552;
        bh=8qASZ1qocBeaLqiqw5NqIi1qKMvQMwyjDALtpIveXiQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SmflCMB6c78piklXhX0Nn1NR3qMUQ9+Yyq75kYG9aIdy7xd+i0H86+bAB2xNhFeCL
         cHwdLWiAOOpgbCArWLtUr20IKLk+Vy0ONuzs9MnbhrMTz5S2zgslhNCl4R+4C7UmDt
         yB+y3boj4bDv7tIADvLV3fjgiKLTfntAzqpldljRhYcC5ZIPxr80IplRZ1riq13cMh
         OgJ6sO6aS8eCew/r/n1VZkHUmKbnNRCKzMfeyaL2pWM/qPk7jVr8Urd+qAfpw8Bn1c
         2TTYDpjhacZ8t8ZIaNM7M58S4vLqPT2EC07+9dWBZXZDLJSlSooviiGb8xa4qwsMl8
         uQsk7ceNUwxfw==
Message-ID: <97ed6d002603347a14b12796808b7aa9d729a13c.camel@kernel.org>
Subject: Re: [PATCH] nfsd: call op_release, even when op_func returns an
 error
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Zhi Li <yieli@redhat.com>
Date:   Mon, 27 Mar 2023 10:32:30 -0400
In-Reply-To: <C871117E-1591-4F1C-94DE-3854F88FF8FF@oracle.com>
References: <20230327102137.15412-1-jlayton@kernel.org>
         <C871117E-1591-4F1C-94DE-3854F88FF8FF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
>=20

Sure. It does look like the leaks stretch back at least that far.
=20
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
