Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5317267EC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjFGSEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 14:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjFGSEu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 14:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22F1FC2
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 11:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0E36397F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 18:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B079C433EF;
        Wed,  7 Jun 2023 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686161088;
        bh=IyQ+gPo3Kc9zOP8I9PAE7KasHd5dnHvWgv9zNekzAgk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Oark1lOFXxSTnKP6FekzUOVK104PLRghpOdwgFgcC7lN5rjnbs7YAbILy97hRURTI
         I1CbdoxhwMaeOlcVAq+pOqJvcgRAL8myY74+UzgehpDJuszP9j7p0D0g/9HaTxq0La
         h0iP6zjz15t8vAWstiHqbsphog77207TeFcuW1rXVs9VmbWVRNHPRfxMSAXURPPOfQ
         LDW/dP10Q9geFyLEDKcXZNn8kbXz+Z/kfpN/qvzOjtO+NTZ9PNKzaIZSiaZzBR1xqf
         5RJuFEKRGcuGXmUIVOKTsNPvSVzCyk0zjeK0poZbMNWEKXUFa3dlr+xMq+lSlX+Kgl
         RmlZ91wrvvDuA==
Message-ID: <66837f03e0f3499cab9786e26c4525109ec074db.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: add encoding of op_recall flag for write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 07 Jun 2023 14:04:47 -0400
In-Reply-To: <1686094862-13108-1-git-send-email-dai.ngo@oracle.com>
References: <1686094862-13108-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Tue, 2023-06-06 at 16:41 -0700, Dai Ngo wrote:
> Modified nfsd4_encode_open to encode the op_recall flag properly
> for OPEN result with write delegation granted.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 4590b893dbc8..d7e46b940cce 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3975,7 +3975,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>  		p =3D xdr_reserve_space(xdr, 32);
>  		if (!p)
>  			return nfserr_resource;
> -		*p++ =3D cpu_to_be32(0);
> +		*p++ =3D cpu_to_be32(open->op_recall);
> =20
>  		/*
>  		 * TODO: space_limit's in delegations

Nice catch!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
