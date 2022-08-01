Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74958586866
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiHALr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHALrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 07:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B64357E3
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 04:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA84612C6
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 11:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F6C433C1;
        Mon,  1 Aug 2022 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659354443;
        bh=LIGL9weSYUePxvV8yw1LKvfBLFSQ2jw7uu6eXTUtDpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fMU2cIclrW+mGEJ+Ty8Vss7RHWzfHQy4jDxttypR9ucvMVdK/dj+jEfe2pVzW4rZF
         3gyjpJNQurPIAYy/KTS6jqpjCk+PL6PsYKP5uaiLfT4I22OEMD2tqALhDNsw3Z6qYe
         LOSJjVCs7l4bAoxiGBU4QIjU9YOAjEEnTSU0XdVcq5zSIvQ3ORDOdN15am7KwjOufb
         m/iC0x49jbsSLT9l8rYCm6R/uI3QTzbF4uoIEuLt1asZoIp1Pv8caUcX1y6f881Z3R
         9kJQCywcivexfxQn9v17QR7kMcJonWdYWZMHGNb4DMte3gqiLP5FnYk5uUidwjZPRv
         Ky5ICzrAScVNA==
Message-ID: <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Aug 2022 07:47:21 -0400
In-Reply-To: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
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
>  fs/nfsd/nfs4state.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..749f51dff5c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
>  	struct nfs4_client *clp =3D s->st_stid.sc_client;
>  	bool unhashed;
>  	LIST_HEAD(reaplist);
> +	struct nfs4_ol_stateid *stp;
> =20
>  	spin_lock(&clp->cl_lock);
>  	unhashed =3D unhash_open_stateid(s, &reaplist);
> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
>  		if (unhashed)
>  			put_ol_stateid_locked(s, &reaplist);
>  		spin_unlock(&clp->cl_lock);
> +		list_for_each_entry(stp, &reaplist, st_locks)
> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>  		free_ol_stateid_reaplist(&reaplist);
>  	} else {
>  		spin_unlock(&clp->cl_lock);

Nice catch.

There are a number of places that call free_ol_stateid_reaplist. Is it
really only in nfsd4_close_open_stateid that we need to do this? I
wonder if it would be better to do this inside free_ol_stateid_reaplist
instead so that all of those callers clean up the copy states as well?
--=20
Jeff Layton <jlayton@kernel.org>
