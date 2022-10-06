Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A715F6BDA
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJFQfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiJFQfo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97FE9B874
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 756F661A11
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C020C433D7;
        Thu,  6 Oct 2022 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665074141;
        bh=yTbk1yzJgPURyBPspfhzDFZJqhqSzXKFfPplKLaoU7M=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=GSoaJqYAhGy6O86tXqzGvQkCvkTLTxsi2O8dbR3fW7+Aoz4OEW+puT2N7h8JbRCzW
         MhOTbIuXRqu/T/sRz/ePNcplSQAy/q2bHHuj889oFDgfJq1qY5l2nRjkw4Feenv/gc
         Whk1c0xHi3/qno/SJzxzmBKfK1exZPOrpRWoma0t7aOUCbQ0G4xlo/FM1OiXe9blwB
         P1bmCqjTBDPoiWo4HiuKuvlhrByeZwYEsmi0Lov3kofFsI7rI5D8qblECzj7241Sku
         D+ClLrIKOoxSzvteQZxRxIU9XAoApBO8FQ5qYr0b/q1LoOcJXHpifrblYs3dmPsyQB
         6ZALE/hgifSWw==
Message-ID: <cb4a93b027f898c53ad1acba59c036d7c9b0d43a.camel@kernel.org>
Subject: Re: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com
Date:   Thu, 06 Oct 2022 12:35:39 -0400
In-Reply-To: <20220913180151.1928363-2-anna@kernel.org>
References: <20220913180151.1928363-1-anna@kernel.org>
         <20220913180151.1928363-2-anna@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-09-13 at 14:01 -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> This was discussed with Chuck as part of this patch set. Returning
> nfserr_resource was decided to not be the best error message here, and
> he suggested changing to nfserr_serverfault instead.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..01dd73ed5720 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3994,7 +3994,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>  	}
>  	if (resp->xdr->buf->page_len && splice_ok) {
>  		WARN_ON_ONCE(1);
> -		return nfserr_resource;
> +		return nfserr_serverfault;
>  	}
>  	xdr_commit_encode(xdr);
> =20


Reviewed-by: Jeff Layton <jlayton@kernel.org>
