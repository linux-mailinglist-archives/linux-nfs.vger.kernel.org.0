Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E45E7FC3
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiIWQ24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIWQ2r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 12:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C3139F78
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 09:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B52460BEA
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 16:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7328CC433D6;
        Fri, 23 Sep 2022 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950523;
        bh=OceAtJ4pt2Wn6P+PXGI5MbxptXjjwDOIad/bTXf0tqQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WHby3rQcaReZjb60VPUuxuYVtjJhuTDXvFG9ea/lTy1G/NwS+8P/GL61JtEyZnucI
         DqJ5I/jnarthZOXoqh4tfTILO9F8wN9PxRkrpE3/7o3rQ4PNZGvLkg/arBQ+lGkKc0
         OYwq3OkKsu/pGiZa0Zx9csnN0Pt1ufwLlc44kEKwP3OEukU+US4ChJ6MLMAXG29jJu
         rXoLCDm9LgyUwzNeFuh/X1a+gCoCbxVlnSncMDzsurFr6yDPMz2A/j7NM2U+RRrhlC
         YmyNebECgOxvbpTttyXEfILsO4bauMfsjCaFk7RUfCmV1mEDzyy28Ghysa3x3qoEGU
         viTkwsmfmFC6g==
Message-ID: <442cabb565154a3fe8a1f45192d8c52a24c54e54.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 12:28:42 -0400
In-Reply-To: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
References: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-08-01 at 18:52 -0700, Dai Ngo wrote:
> Use-after-free occurred when the laundromat tried to free expired
> cpntf_state entry on the s2s_cp_stateids list after inter-server
> copy completed. The sc_cp_list that the expired copy state was
> inserted on was already freed.
>=20
> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
> from the s2s_cp_stateids list before freeing the lock state's stid.
>=20
> However, sometimes the CLOSE was sent before the FREE_STATEID request.
> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
> frees all lock states on its st_locks list without cleaning up the copy
> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
> server returns BAD_STATEID since the lock state was freed. This causes
> the use-after-free error to occur when the laundromat tries to free
> the expired cpntf_state.
>=20
> This patch adds a call to nfs4_free_cpntf_statelist in
> nfsd4_close_open_stateid to clean up the copy state before calling
> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..b99c545f93e4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1049,6 +1049,9 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_sta=
teid(struct nfs4_client *clp)
> =20
>  static void nfs4_free_deleg(struct nfs4_stid *stid)
>  {
> +	struct nfs4_ol_stateid *stp =3D openlockstateid(stid);
> +
> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));

You're casting a delegation stateid to an openlockstateid, and then
getting stid back from that. How about this instead, and drop the
openlockstateid weirdness?

      WARN_ON(!list_empty(&stid->sc_cp_list));

>  	kmem_cache_free(deleg_slab, stid);
>  	atomic_long_dec(&num_delegations);
>  }
> @@ -1463,6 +1466,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *=
stid)
>  	release_all_access(stp);
>  	if (stp->st_stateowner)
>  		nfs4_put_stateowner(stp->st_stateowner);
> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>  	kmem_cache_free(stateid_slab, stid);
>  }
> =20
> @@ -6608,6 +6612,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
>  	struct nfs4_client *clp =3D s->st_stid.sc_client;
>  	bool unhashed;
>  	LIST_HEAD(reaplist);
> +	struct nfs4_ol_stateid *stp;
> =20
>  	spin_lock(&clp->cl_lock);
>  	unhashed =3D unhash_open_stateid(s, &reaplist);
> @@ -6616,6 +6621,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
>  		if (unhashed)
>  			put_ol_stateid_locked(s, &reaplist);
>  		spin_unlock(&clp->cl_lock);
> +		list_for_each_entry(stp, &reaplist, st_locks)
> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>  		free_ol_stateid_reaplist(&reaplist);
>  	} else {
>  		spin_unlock(&clp->cl_lock);

--=20
Jeff Layton <jlayton@kernel.org>
