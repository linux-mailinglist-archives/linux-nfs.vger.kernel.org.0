Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3E6E9E23
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 23:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDTVwB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 17:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjDTVwB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 17:52:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4640C5
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 14:51:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D03582183A;
        Thu, 20 Apr 2023 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682027514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efOaqnHv69/fuyxGBvR6MhrPsAgoiRU4DgNqKQS6vtg=;
        b=UWexn8ltFu5BnXxu89YeUbvE1PaqeV8lJONVHzVSseJqoM/Kp6iYDtPVXbX2er6ftwBZP1
        MT5ME8DXG3LfQouYSKgoee/HUOkuRheExdp1fm4HISr760GjPSQj1KTtaB5ze/zV8cCA3p
        aXoZLb9GNrYINP3espvTf1kGKKKRagA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682027514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efOaqnHv69/fuyxGBvR6MhrPsAgoiRU4DgNqKQS6vtg=;
        b=lfRXjGa5rInKo29o7UatngKG88kOqTEP5RJYkjU68JlqiFxIzXQ4v+O8buQmZxS3DSxAY6
        UoeISIqapWmJ0tAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 427761333C;
        Thu, 20 Apr 2023 21:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IaWPOfizQWSMDAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Apr 2023 21:51:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Cleanup unused rpc_clnt variable
In-reply-to: <7b299fff0277489fd6f8a12d377fb3edc5fb3a80.1682007300.git.bcodding@redhat.com>
References: <7b299fff0277489fd6f8a12d377fb3edc5fb3a80.1682007300.git.bcodding@redhat.com>
Date:   Fri, 21 Apr 2023 07:51:49 +1000
Message-id: <168202750930.24821.8678139655016357466@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Apr 2023, Benjamin Coddington wrote:
> The root rpc_clnt is not used here, clean it up.

True.  The actions on rpc_clnt happen in nfs4_run_state_manager, not
here.  So this is not needed.  Thanks.

>=20
> Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is en=
abled")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> ---
>  fs/nfs/nfs4state.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 2a0ca5c7f082..f8afd75e520d 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1205,10 +1205,6 @@ void nfs4_schedule_state_manager(struct nfs_client *=
clp)
>  {
>  	struct task_struct *task;
>  	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
> -	struct rpc_clnt *cl =3D clp->cl_rpcclient;
> -
> -	while (cl !=3D cl->cl_parent)
> -		cl =3D cl->cl_parent;
> =20
>  	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
>  	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) !=3D 0) {
> --=20
> 2.39.2
>=20
>=20

