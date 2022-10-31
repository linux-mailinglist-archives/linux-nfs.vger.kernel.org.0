Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF5613BB9
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiJaQum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJaQuk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 12:50:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D88812AB8
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57A33B8189E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B5EC433C1;
        Mon, 31 Oct 2022 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667235037;
        bh=kogLNzaAno84t/ITcOe3D3CLiLNjl+ft9b52Lhc5Fqk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rdA/fYJrN6ZcLHMvf/5AMkEW5q6Rh8FfPtFzkR9P7MKHgbgiF1dYs9a+GNiKNLeoy
         NMuwYRregyvTqsPd4b0nUP57QTEjSeuHnlg23ZX6pihruFWy1XM17FZBA6Ed9HAD8g
         j79oIJK8CNlcG1KeBZ5/N4cck36CnpF0C1GRKgQE6mSr7mE5UBYSLBrrQudVnXrZRW
         gybv4zX4PnLyUAaQgtkcZ6VeGnWq+7udedE8uStyVWphVecNGUNpZsBN2xTl8696zF
         VAZ4pw25BfcK9h6ZqpoApseIBl5Wdl5L1nMUNOKZ5eDnoogHB4Qi8sU73U34T9csb4
         vPqkpKswb93Gg==
Message-ID: <ba83a0ca28a9ee572576a467eb27baa76745c730.camel@kernel.org>
Subject: Re: [PATCH v7 12/14] NFSD: Refactor find_file()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 31 Oct 2022 12:50:35 -0400
In-Reply-To: <166696846760.106044.18334584948493999552.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696846760.106044.18334584948493999552.stgit@klimt.1015granger.net>
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
> find_file() is now the only caller of find_file_locked(), so just
> fold these two together.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c |   36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b1988a46fb9b..2b694d693be5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4667,31 +4667,24 @@ move_to_close_lru(struct nfs4_ol_stateid *s, stru=
ct net *net)
>  		nfs4_put_stid(&last->st_stid);
>  }
> =20
> -/* search file_hashtbl[] for file */
> -static struct nfs4_file *
> -find_file_locked(const struct svc_fh *fh, unsigned int hashval)
> +static noinline_for_stack struct nfs4_file *
> +nfsd4_file_hash_lookup(const struct svc_fh *fhp)
>  {
> -	struct nfs4_file *fp;
> +	unsigned int hashval =3D file_hashval(fhp);
> +	struct nfs4_file *fi;
> =20
> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> -				lockdep_is_held(&state_lock)) {
> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> -			if (refcount_inc_not_zero(&fp->fi_ref))
> -				return fp;
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> +				 lockdep_is_held(&state_lock)) {
> +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
> +			if (refcount_inc_not_zero(&fi->fi_ref)) {
> +				rcu_read_unlock();
> +				return fi;
> +			}
>  		}
>  	}
> -	return NULL;
> -}
> -
> -static struct nfs4_file * find_file(struct svc_fh *fh)
> -{
> -	struct nfs4_file *fp;
> -	unsigned int hashval =3D file_hashval(fh);
> -
> -	rcu_read_lock();
> -	fp =3D find_file_locked(fh, hashval);
>  	rcu_read_unlock();
> -	return fp;
> +	return NULL;
>  }
> =20
>  /*
> @@ -4742,9 +4735,10 @@ nfs4_share_conflict(struct svc_fh *current_fh, uns=
igned int deny_type)
>  	struct nfs4_file *fp;
>  	__be32 ret =3D nfs_ok;
> =20
> -	fp =3D find_file(current_fh);
> +	fp =3D nfsd4_file_hash_lookup(current_fh);
>  	if (!fp)
>  		return ret;
> +
>  	/* Check for conflicting share reservations */
>  	spin_lock(&fp->fi_lock);
>  	if (fp->fi_share_deny & deny_type)
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
