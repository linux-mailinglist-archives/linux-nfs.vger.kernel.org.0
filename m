Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38D2740068
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jun 2023 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjF0QJe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jun 2023 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjF0QJa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jun 2023 12:09:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A330FF;
        Tue, 27 Jun 2023 09:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED9F611DB;
        Tue, 27 Jun 2023 16:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A45C433C9;
        Tue, 27 Jun 2023 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687882162;
        bh=Um+DixtcgknExk4fdb8G9FQbeYY8JUWWPfgk6fKF9l0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cOYMBjBpm7gUvHE2Pbq4Kuz7r8aYq+lg35XxwCdxypDT/OaWWh6qLqMQ2xAZiX140
         At+0qagxeACIV29B11Q2Od2ee4mySvlUEZ9PRu3nAN7RRRhj4LFl991ib5Jm/dwNHJ
         Tf4kBNaR6ktGacrUM3gjFvaXlI6mN+h7VwgdC/NO6HCmSswqEtz5Fykp3J6KADxBja
         QjHJ0t7I7k3BA57hxz09ZI6gqRpiiCu1Y8h3hoTSvwy4t5gKppk22DliiNfzTvDiCa
         jh4JMDVrOrEa5fYZS3ElIqHq52Vol8TfAt3QT783iNoVGYD8DawLZfhFHRYlHwPyO0
         YgtepU4+bfYiQ==
Message-ID: <a640835f172acabfc24b10f526d5186b3f98621f.camel@kernel.org>
Subject: Re: [PATCH] fs/nfsd: Fix creation time serialization order
From:   Jeff Layton <jlayton@kernel.org>
To:     tavianator@tavianator.com, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Jun 2023 12:09:20 -0400
In-Reply-To: <4154eb6503988c2096f5d30af26d06863fb5d973.1687554467.git.tavianator@tavianator.com>
References: <4154eb6503988c2096f5d30af26d06863fb5d973.1687554467.git.tavianator@tavianator.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-06-23 at 17:09 -0400, tavianator@tavianator.com wrote:
> From: Tavian Barnes <tavianator@tavianator.com>
>=20
> In nfsd4_encode_fattr(), TIME_CREATE was being written out after all
> other times.  However, they should be written out in an order that
> matches the bit flags in bmval1, which in this case are
>=20
>     #define FATTR4_WORD1_TIME_ACCESS        (1UL << 15)
>     #define FATTR4_WORD1_TIME_CREATE        (1UL << 18)
>     #define FATTR4_WORD1_TIME_DELTA         (1UL << 19)
>     #define FATTR4_WORD1_TIME_METADATA      (1UL << 20)
>     #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
>=20
> so TIME_CREATE should come second.
>=20
> I noticed this on a FreeBSD NFSv4.2 client, which supports creation
> times.  On this client, file times were weirdly permuted.  With this
> patch applied on the server, times looked normal on the client.
>=20
> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
> Link: https://unix.stackexchange.com/q/749605/56202
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
> ---
>  fs/nfsd/nfs4xdr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..3037c5b0623e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3354,6 +3354,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>  		p =3D xdr_encode_hyper(p, (s64)stat.atime.tv_sec);
>  		*p++ =3D cpu_to_be32(stat.atime.tv_nsec);
>  	}
> +	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> +		p =3D xdr_reserve_space(xdr, 12);
> +		if (!p)
> +			goto out_resource;
> +		p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> +		*p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> +	}
>  	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
>  		p =3D xdr_reserve_space(xdr, 12);
>  		if (!p)
> @@ -3374,13 +3381,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>  		p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
>  		*p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
>  	}
> -	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> -		p =3D xdr_reserve_space(xdr, 12);
> -		if (!p)
> -			goto out_resource;
> -		p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> -		*p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> -	}
>  	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
>  		u64 ino =3D stat.ino;
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
