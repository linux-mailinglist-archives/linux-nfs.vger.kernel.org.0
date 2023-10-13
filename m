Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931E7C86B3
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjJMNVb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJMNVZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBA91
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697203239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUcC3/nJHcpydayDlbwMmc/zWgVW1Ax7C/pcg0A0/uA=;
        b=A8MhbfNf/HX4gQI8kxWfXKHbzM4/IydM9CV6fJ/q1HrLBsQnTDWEzyMl+5MP6DmaONykZN
        Hu/LrKzE88jvTWqMnPBqeMGcPpctz1pN6xQK/wgdfQlZByWmNY9uxzT9q5zeS+i9CtPZst
        5JDqwe9y/8xXWjVXdK/SelDt82bzDkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-l8iAXsM0N7-p_6Dd2KzaWA-1; Fri, 13 Oct 2023 09:20:30 -0400
X-MC-Unique: l8iAXsM0N7-p_6Dd2KzaWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 692AF858F19;
        Fri, 13 Oct 2023 13:20:30 +0000 (UTC)
Received: from [10.22.32.24] (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4553A492BFA;
        Fri, 13 Oct 2023 13:20:30 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSD: Remove a layering violation when encoding
 lock_denied
Date:   Fri, 13 Oct 2023 09:20:29 -0400
Message-ID: <EF49AC8F-D046-4C9A-91CA-1D2AC4B1A070@redhat.com>
In-Reply-To: <169720169786.5129.10628552146876100129.stgit@oracle-102.nfsv4bat.org>
References: <169720169786.5129.10628552146876100129.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Oct 2023, at 8:56, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> An XDR encoder is responsible for marshaling results, not releasing
> memory that was allocated by the upper layer. We have .op_release
> for that purpose.
>
> Move the release of the ld_owner.data string to op_release functions
> for LOCK and LOCKT.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  |    2 ++
>  fs/nfsd/nfs4state.c |   16 ++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |   16 ++--------------
>  fs/nfsd/xdr4.h      |   17 +++++------------
>  4 files changed, 25 insertions(+), 26 deletions(-)
>
> Fix for kmemleak found during Bake-a-thon.
>
> I'm planning to insert this fix into nfsd-next just before the
> patches that clean up the lock_denied encoder.
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 60262fd27b15..f288039545e3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -3210,6 +3210,7 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
>  	},
>  	[OP_LOCK] =3D {
>  		.op_func =3D nfsd4_lock,
> +		.op_release =3D nfsd4_lock_release,
>  		.op_flags =3D OP_MODIFIES_SOMETHING |
>  				OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name =3D "OP_LOCK",
> @@ -3218,6 +3219,7 @@ static const struct nfsd4_operation nfsd4_ops[] =3D=
 {
>  	},
>  	[OP_LOCKT] =3D {
>  		.op_func =3D nfsd4_lockt,
> +		.op_release =3D nfsd4_lockt_release,
>  		.op_flags =3D OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name =3D "OP_LOCKT",
>  		.op_rsize_bop =3D nfsd4_lock_rsize,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 07840ee721ef..305c353a416c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7773,6 +7773,14 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  	return status;
>  }
>
> +void nfsd4_lock_release(union nfsd4_op_u *u)
> +{
> +	struct nfsd4_lock *lock =3D &u->lock;
> +	struct nfsd4_lock_denied *deny =3D &lock->lk_denied;
> +
> +	kfree(deny->ld_owner.data);
> +}
> +
>  /*
>   * The NFSv4 spec allows a client to do a LOCKT without holding an OPE=
N,
>   * so we do a temporary open here just to get an open file to pass to
> @@ -7878,6 +7886,14 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	return status;
>  }
>
> +void nfsd4_lockt_release(union nfsd4_op_u *u)
> +{
> +	struct nfsd4_lockt *lockt =3D &u->lockt;
> +	struct nfsd4_lock_denied *deny =3D &lockt->lt_denied;
> +
> +	kfree(deny->ld_owner.data);
> +}
> +
>  __be32
>  nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat=
e,
>  	    union nfsd4_op_u *u)
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index dafb3a91235e..26e7bb6d32ab 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3990,28 +3990,16 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr=
, struct nfsd4_lock_denied *ld)
>  	struct xdr_netobj *conf =3D &ld->ld_owner;
>  	__be32 *p;
>
> -again:
>  	p =3D xdr_reserve_space(xdr, 32 + XDR_LEN(conf->len));
> -	if (!p) {
> -		/*
> -		 * Don't fail to return the result just because we can't
> -		 * return the conflicting open:
> -		 */
> -		if (conf->len) {
> -			kfree(conf->data);
> -			conf->len =3D 0;
> -			conf->data =3D NULL;
> -			goto again;
> -		}
> +	if (!p)
>  		return nfserr_resource;

Should we worry about removing this corner-case fix?  I'm not sure I
understand it.. just wanted to bring it up.  Here's what Bruce originally=

said:

commit 8c7424cff6bd33459945646cfcbf6dc6c899ab24
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 10 12:19:10 2014 -0400

    nfsd4: don't try to encode conflicting owner if low on space

    I ran into this corner case in testing: in theory clients can provide=

    state owners up to 1024 bytes long.  In the sessions case there might=
 be
    a risk of this pushing us over the DRC slot size.

    The conflicting owner isn't really that important, so let's humor a
    client that provides a small maxresponsize_cached by allowing ourselv=
es
    to return without the conflicting owner instead of outright failing t=
he
    operation.

    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Ben

