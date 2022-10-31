Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976EB613B69
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiJaQfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJaQf3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 12:35:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5EBE9E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 935C7B8189E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 16:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F85C433D7;
        Mon, 31 Oct 2022 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667234126;
        bh=0E8GCLwfHmnXXWIeoMXLVSfNNTVKeBRIxH8aQkMdDAE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UmXeGjJ1uFD3rPaoRc7ls/W7Nom5H86ZRCrqbyg4KFxq4vSfmlfflOwm63bat/8/+
         k9tv3a5aljO03GqGbx45sV60Mn9/IPB50bk/Y+c+jZ0MlOQ9l9EoVt0JcW0zVAPMZG
         H5oJWgN1wkULSYxdsVpaFJsBhjSDJ4AzMbQSsK3zH9C3mh/jHvi6WhDKSPBIJCXgxT
         oT01fhUCXi0eGe0+Y5gE0IYV3gEcrEPfoIw1sm+EJoojCkAkpeW7YISwKWso8ZEqm4
         rCgL8crS0jM4IXCtKLJsnwKJNf/FdpLv+RF5Nd/4gwwZf9+rL784KXYe+vNmfpGVGd
         KY4GN22viMvfQ==
Message-ID: <1fd62ecde58ce1071ff644f5b128ae619bc7fd69.camel@kernel.org>
Subject: Re: [PATCH v7 09/14] NFSD: Clean up nfsd4_init_file()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 31 Oct 2022 12:35:24 -0400
In-Reply-To: <166696844871.106044.39412279713347759.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696844871.106044.39412279713347759.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 10:47 -0400, Chuck Lever wrote:
> Name this function more consistently. I'm going to use nfsd4_file_
> and nfsd4_file_hash_ for these helpers.
>=20
> Change the @fh parameter to be const pointer for better type safety.
>=20
> Finally, move the hash insertion operation to the caller. This is
> typical for most other "init_object" type helpers, and it is where
> most of the other nfs4_file hash table operations are located.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 60f1aa2c5442..3132e4844ef8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4262,11 +4262,9 @@ static struct nfs4_file *nfsd4_alloc_file(void)
>  }
> =20
>  /* OPEN Share state helper functions */
> -static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
> -				struct nfs4_file *fp)
> -{
> -	lockdep_assert_held(&state_lock);
> =20
> +static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *f=
p)
> +{
>  	refcount_set(&fp->fi_ref, 1);
>  	spin_lock_init(&fp->fi_lock);
>  	INIT_LIST_HEAD(&fp->fi_stateids);
> @@ -4284,7 +4282,6 @@ static void nfsd4_init_file(struct svc_fh *fh, unsi=
gned int hashval,
>  	INIT_LIST_HEAD(&fp->fi_lo_states);
>  	atomic_set(&fp->fi_lo_recalls, 0);
>  #endif
> -	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
>  }
> =20
>  void
> @@ -4702,7 +4699,8 @@ static struct nfs4_file *insert_file(struct nfs4_fi=
le *new, struct svc_fh *fh,
>  			fp->fi_aliased =3D alias_found =3D true;
>  	}
>  	if (likely(ret =3D=3D NULL)) {
> -		nfsd4_init_file(fh, hashval, new);
> +		nfsd4_file_init(fh, new);
> +		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
>  		new->fi_aliased =3D alias_found;
>  		ret =3D new;
>  	}
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
