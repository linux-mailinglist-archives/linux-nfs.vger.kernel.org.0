Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBF757DB5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGRNfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGRNfX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 09:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7C1E2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2875F6157A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 13:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CB7C433C7;
        Tue, 18 Jul 2023 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689687321;
        bh=JweRxGE1cscNDSmwxvyu9bKbc3nAF3vuAbPMVGPssNA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L/HvOlHKgkN2at8CjWPWY4EYHQADZzGv33vfwZprzp5mYuQ5G6v3oU2mfdd3fijQq
         tCHl2rJwmYXSTlfKSex22JkDauEMd/WfcMftUD1NrnyP7r8e1UvvBf9TUYYgw2Hxz7
         Qob6GoFaN3U2NcTvoR8yr/yAKPERxtHuBe+aY1jPhO/2cQFeNk6kogyG5Iu9s1+zG7
         bTQAgozPEvnk4/WA/jBb23qnN84GOzsGM2TOnsSiQA2/APBwOoLyqdtvaj78PgdQNH
         4RDK1osRJVhnzZkGOoa4Mehdc6rzk0LzL+V5ze5j/tEw9MMDiHjCFoJResgL8I7ktc
         ABX9bgufMggsw==
Message-ID: <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
From:   Jeff Layton <jlayton@kernel.org>
To:     trondmy@kernel.org, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 09:35:20 -0400
In-Reply-To: <20230718123837.124780-1-trondmy@kernel.org>
References: <20230718123837.124780-1-trondmy@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the client is calling TEST_STATEID, then it is because some event
> occurred that requires it to check all the stateids for validity and
> call FREE_STATEID on the ones that have been revoked. In this case,
> either the stateid exists in the list of stateids associated with that
> nfs4_client, in which case it should be tested, or it does not. There
> are no additional conditions to be considered.
>=20
> Reported-by: Frank Ch. Eigler <fche@redhat.com>
> Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids with misma=
tched clientids")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfs4state.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..3aefbad4cc09 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6341,8 +6341,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>  		return status;
> -	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
> -		return status;
>  	spin_lock(&cl->cl_lock);
>  	s =3D find_stateid_locked(cl, stateid);
>  	if (!s)

IDGI. Is this fixing an actual bug? Granted this code does seem
unnecessary, but removing it doesn't seem like it will cause any
user-visible change in behavior. Am I missing something?
--=20
Jeff Layton <jlayton@kernel.org>
