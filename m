Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054FD613B6F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiJaQhP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiJaQhN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 12:37:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825012A9F
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A8EDB81905
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 16:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F7FC433C1;
        Mon, 31 Oct 2022 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667234230;
        bh=yrWORAkCmvoDkBQVPyYpPm9M58oafoJAk0okBtPDVyc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mcdhurwXj1ysu47mmsCYYVnhXJkgl0c6ehbVVRFE9hfLxO74cnS4150VC6MHQfoRt
         y4DN32XO4rFV8/YvIS7N14OBycrZ36TDc8y3WWPfMJLr962b3F+c6+l2TvgWbTtoGU
         ZD9Khir5Y0YiSyqIDMjaqOsqhZRjwKcnv6+FrVpgG4yDtj7yZRV/C/YYykedCde0Dd
         Dy/v/3YiHQCQXstDBIXCItkSbz3huS0h/lPRTu2ucYy3FxpfgHYrqlDJBhj+6wy7g/
         X0SRlSC/+GDW2YZHq8mHtlQx4rfjIjVR8Cx2WTXMQnScAWYfSXnUVGj6UB8mZ+luWS
         ExZO1YBYA4E8A==
Message-ID: <e6ec726d8bd7e06629c87e628eb38f71e46524cd.camel@kernel.org>
Subject: Re: [PATCH v7 10/14] NFSD: Add a nfsd4_file_hash_remove() helper
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 31 Oct 2022 12:37:08 -0400
In-Reply-To: <166696845494.106044.16955031104437790108.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696845494.106044.16955031104437790108.stgit@klimt.1015granger.net>
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
> Refactor to relocate hash deletion operation to a helper function
> that is close to most other nfs4_file data structure operations.
>=20
> The "noinline" annotation will become useful in a moment when the
> hlist_del_rcu() is replaced with a more complex rhash remove
> operation. It also guarantees that hash remove operations can be
> traced with "-p function -l remove_nfs4_file_locked".
>=20
> This also simplifies the organization of forward declarations: the
> to-be-added rhashtable and its param structure will be defined
> /after/ put_nfs4_file().
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3132e4844ef8..504455cb80e9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -84,6 +84,7 @@ static bool check_for_locks(struct nfs4_file *fp, struc=
t nfs4_lockowner *lowner)
>  static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>  void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cp=
ntf_state *cps);
> +static void nfsd4_file_hash_remove(struct nfs4_file *fi);
> =20
>  /* Locking: */
> =20
> @@ -591,7 +592,7 @@ put_nfs4_file(struct nfs4_file *fi)
>  	might_lock(&state_lock);
> =20
>  	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> -		hlist_del_rcu(&fi->fi_hash);
> +		nfsd4_file_hash_remove(fi);
>  		spin_unlock(&state_lock);
>  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> @@ -4734,6 +4735,11 @@ find_or_add_file(struct nfs4_file *new, struct svc=
_fh *fh)
>  	return insert_file(new, fh, hashval);
>  }
> =20
> +static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_file *=
fi)
> +{
> +	hlist_del_rcu(&fi->fi_hash);
> +}
> +
>  /*
>   * Called to check deny when READ with all zero stateid or
>   * WRITE with all zero or all one stateid
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
