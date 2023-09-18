Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84557A3F2A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 03:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjIRBR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjIRBRr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 21:17:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871A124
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 18:17:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BFFF21986;
        Mon, 18 Sep 2023 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694999860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0waZ0nR0XXD2llSLXQNPTlEoYAJTFuE8L0T9U76V940=;
        b=t/E0wyv16S8buaZPh0zVnyOYfZgPyWj1Hj79JmbI24jCoff7P2fIdvx5/No9t1L4aEpz2W
        uqbMCoO0BIzy8+ftNkk6eH/HRGPFG4rBiwC827C20Lm1LgZ4hc5F8qxq6f+VitNKI+1jYp
        XR9I70wlOvGw1k8YWTcOTeo1m5VemHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694999860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0waZ0nR0XXD2llSLXQNPTlEoYAJTFuE8L0T9U76V940=;
        b=B2s0abvbADTBmbMZuqC1fPEB0HN5fr1OUYVJ4wxRPquWBvehKAo9JxFG8yI0HQBbUzzKi4
        7FqM3EryFnLoZHDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A40A134F3;
        Mon, 18 Sep 2023 01:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o1uaAzOlB2XeSQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 18 Sep 2023 01:17:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     trondmy@kernel.org
Cc:     "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSv4: Fix a nfs4_state_manager() race
In-reply-to: <20230917230551.30483-1-trondmy@kernel.org>
References: <20230917230551.30483-1-trondmy@kernel.org>
Date:   Mon, 18 Sep 2023 11:17:35 +1000
Message-id: <169499985553.8274.16707412085976640956@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 18 Sep 2023, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the NFS4CLNT_RUN_MANAGER flag got set just before we cleared
> NFS4CLNT_MANAGER_RUNNING, then we might have won the race against
> nfs4_schedule_state_manager(), and are responsible for handling the
> recovery situation.
>=20
> Fixes: aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index e079987af4a3..0bc160fbabec 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2703,6 +2703,13 @@ static void nfs4_state_manager(struct nfs_client *cl=
p)
>  		nfs4_end_drain_session(clp);
>  		nfs4_clear_state_manager_bit(clp);
> =20
> +		if (test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
> +		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING,
> +				      &clp->cl_state)) {
> +			memflags =3D memalloc_nofs_save();
> +			continue;
> +		}
> +

I cannot see what race this closes.
When we cleared MANAGER_RUNNING, the only possible consequence is that
nfs4_wait_clnt_recover could have woken up.  This leads to
nfs4_schedule_state_manager() being run, which sets RUN_MANAGER whether
it was set or not.

I understand that there are problems with MANAGER_AVAILABLE which your
next patch addresses, but I cannot see what this one actually fixes.
Can you help me?

Thanks,
NeilBrown



>  		if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
>  			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
>  				nfs_client_return_marked_delegations(clp);
> --=20
> 2.41.0
>=20
>=20

