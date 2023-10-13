Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047F07C83B6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjJMKuy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjJMKux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 06:50:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376EDA;
        Fri, 13 Oct 2023 03:50:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73864C433C7;
        Fri, 13 Oct 2023 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697194250;
        bh=G0w/pjBqGRKdZRG8VaIdtW8Ioqlty+xWHEkwpiG8Pcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Er9v7lTfNlC1TycUGJ4Naag7upz4ME9td+nOkzR8zjwvT5Y9sQWHi/IllzVOaNBOo
         1bLoSL6tVyjBJCd+0FrwoOHQQOV8qh9UJFEkDayXYRCxuVrdmfZKApgos7GGISXDkU
         546vqYCSbUQNUX8q64RBMhvspIEdLfWwWWAZcXtZlIbBzDrbBHimwU1jrp0c7LeKCv
         q906FSS0ZFo4BvLIPckc3d5i/QCioMewkn7PiHBRU7Jhis7k5UBeiaGVNzJITb42bi
         G+WMk+b6GCfwKXVRr4BukntC/wh/oGF5P70vbUVjcjPeIN7NVGEuQiu+B72jZZ+DFH
         PMfc9gXnB4JNw==
Message-ID: <ae78fe72c2ea0bc631d50ef33313b3913d48f396.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Clean up errors in nfs4xdr.c
From:   Jeff Layton <jlayton@kernel.org>
To:     KaiLong Wang <wangkailong@jari.cn>, chuck.lever@oracle.com,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 06:50:48 -0400
In-Reply-To: <116353ed.95a.18b27c347d9.Coremail.wangkailong@jari.cn>
References: <116353ed.95a.18b27c347d9.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-10-13 at 14:39 +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
>=20
> ERROR: spaces required around that '=3D' (ctx:VxV)
> ERROR: else should follow close brace '}'
>=20
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  fs/nfsd/nfs4xdr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1cbd2a392302..8b9707957649 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2432,7 +2432,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *ar=
gp)
>  {
>  	struct nfsd4_op *op;
>  	bool cachethis =3D false;
> -	int auth_slack=3D argp->rqstp->rq_auth_slack;
> +	int auth_slack =3D argp->rqstp->rq_auth_slack;
>  	int max_reply =3D auth_slack + 8; /* opcnt, status */
>  	int readcount =3D 0;
>  	int readbytes =3D 0;
> @@ -2585,7 +2585,7 @@ static __be32 nfsd4_encode_components_esc(struct xd=
r_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=3D0;
> +	int strlen, count =3D 0;
>  	char *str, *end, *next;
> =20
>  	dprintk("nfsd4_encode_components(%s)\n", components);
> @@ -2622,8 +2622,7 @@ static __be32 nfsd4_encode_components_esc(struct xd=
r_stream *xdr, char sep,
>  				return nfserr_resource;
>  			p =3D xdr_encode_opaque(p, str, strlen);
>  			count++;
> -		}
> -		else
> +		} else
>  			end++;
>  		if (found_esc)
>  			end =3D next;

In general, we don't usually take patches that just clean up whitespace
damage or stylistic problems. Doing so makes backporting harder as you
end up having to pull in extra patches to fix up minor differences
before bringing in substantive patches.

If you're fixing a real bug in the same area, then sure, go ahead and
fix up the style in the surrounding code, but if these patches don't
fix real bugs then I'd suggest not taking them.
--=20
Jeff Layton <jlayton@kernel.org>
