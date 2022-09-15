Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1F5BA1AE
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Sep 2022 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIOT7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Sep 2022 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOT7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Sep 2022 15:59:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A821828
        for <linux-nfs@vger.kernel.org>; Thu, 15 Sep 2022 12:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50C9AB8223A
        for <linux-nfs@vger.kernel.org>; Thu, 15 Sep 2022 19:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92126C4347C;
        Thu, 15 Sep 2022 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663271985;
        bh=ABCTwZPa7ivz4u0XbV4H8AbQtnSuBmx8hPVzHl2nJoA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=hBsw3wKAsE6keo5psaA+N4caZUvPneXRr2HzAjlhDw6jlR3TySyn6987dTQnbrd3h
         Iq0Ko4girVzZVBDljl38oxlIqPc4DkpNQDkY4QZI+BSt6+nhpmNJuGyjPgKYW8f+xW
         VUctUQuW4Duis1UvTVwClumjIh09F694eL8fchjWoWGLWrgLXRfDSH5+cwdat1j4pJ
         Rgli2POQz8DskHIGRMW/fGQTLjNkj8LnyL0L1M26Cza35aOvxCEuDLOmG+udAg2hwR
         33d1Ti0FPHJGNCdmsDw0MJxAo1MWh4JYA7HyvVcnx0LEgB26kjjRu0yT8gaZX6E2a3
         nQG/iSaSQwEWw==
Message-ID: <9fe0c36d7d846a17aa65ace8df09f66fde96980b.camel@kernel.org>
Subject: Re: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but
 buf->pages have data
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com
Date:   Thu, 15 Sep 2022 15:59:43 -0400
In-Reply-To: <20220913180151.1928363-2-anna@kernel.org>
References: <20220913180151.1928363-1-anna@kernel.org>
         <20220913180151.1928363-2-anna@kernel.org>
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

IIRC the problem is that nfserr_resource is not valid in v4.1+. Do we
also need to change the nfserr_resource return in the if block above
this one?
--=20
Jeff Layton <jlayton@kernel.org>
