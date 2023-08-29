Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38A78CD67
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbjH2UOK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbjH2UNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:13:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DEDB
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5984564C3E
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 20:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1B6C433C8;
        Tue, 29 Aug 2023 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693340030;
        bh=aKXyqy0awqArnGw+cKIqdslafs7nkVemkDx3b7vrewc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=W1NvpRAj3W6fh+iy4yNTXJBImGaoc+2AaKfoWdhZep4iRJSRzjr9rgJNeAOYyCjOT
         VrW7B6Y1jeC8fMVuHeEXjbSBH3zz++vi6zz4+UrhksbITzty0vRqglZqauMfQKmVQX
         432DXHeKBeJ28vthhM+CoBwItc0CFkwxZ+4cW/9P/ILceExeTbiJgZLCqaeuT5TA2p
         WmaAQzwEANoW442gSODq4HodxzQqBpk2wJFnpk2OV5ekDTYOQjGQlXjCRvuR+Ro4Hv
         QIIoTnbB8TmSKaIwWanpUlrg9UGkizHbUx78UeOwsS3ohPYQ3jcWa+XLzuo3TWsBdE
         AIaZ4eU+5gnzQ==
Message-ID: <543eaec0c99605c672e151a5181aa1ddcdb4d6b9.camel@kernel.org>
Subject: Re: [PATCH] nfsd: allow setting SEQ4_STATUS_RECALLABLE_STATE_REVOKED
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Date:   Tue, 29 Aug 2023 16:13:49 -0400
In-Reply-To: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
References: <cd03fb7419f886c8c79bb2ee4889dbc0768a1652.1693326366.git.bcodding@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-29 at 12:26 -0400, Benjamin Coddington wrote:
> This patch sets the SEQ4_STATUS_RECALLABLE_STATE_REVOKED bit for a single
> SEQUENCE response after writing "revoke" to the client's ctl file in proc=
fs.
> It has been generally useful to test various NFS client implementations, =
so
> I'm sending it along for others to find and use.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 19 +++++++++++++++----
>  fs/nfsd/state.h     |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index daf305daa751..f91e2857df65 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2830,18 +2830,28 @@ static ssize_t client_ctl_write(struct file *file=
, const char __user *buf,
>  {
>  	char *data;
>  	struct nfs4_client *clp;
> +	ssize_t rc =3D size;
> =20
>  	data =3D simple_transaction_get(file, buf, size);
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
> -	if (size !=3D 7 || 0 !=3D memcmp(data, "expire\n", 7))
> +
> +	if (size !=3D 7)
>  		return -EINVAL;
> +
>  	clp =3D get_nfsdfs_clp(file_inode(file));
>  	if (!clp)
>  		return -ENXIO;
> -	force_expire_client(clp);
> +
> +	if (!memcmp(data, "revoke\n", 7))
> +		set_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags);
> +	else if (!memcmp(data, "expire\n", 7))
> +		force_expire_client(clp);
> +	else
> +		rc =3D -EINVAL;
> +
>  	drop_client(clp);
> -	return 7;
> +	return rc;
>  }
> =20
>  static const struct file_operations client_ctl_fops =3D {
> @@ -4042,7 +4052,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	default:
>  		seq->status_flags =3D 0;
>  	}
> -	if (!list_empty(&clp->cl_revoked))
> +	if (!list_empty(&clp->cl_revoked) ||
> +			test_and_clear_bit(NFSD4_CLIENT_CL_REVOKED, &clp->cl_flags))
>  		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>  out_no_session:
>  	if (conn)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..a9154b7da022 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -369,6 +369,7 @@ struct nfs4_client {
>  #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>  					 1 << NFSD4_CLIENT_CB_KILL)
>  #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
> +#define NFSD4_CLIENT_CL_REVOKED (7)
>  	unsigned long		cl_flags;
>  	const struct cred	*cl_cb_cred;
>  	struct rpc_clnt		*cl_cb_client;


Seems like a useful knob.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
