Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09453F336
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 03:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiFGBHU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiFGBHU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 21:07:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2EAF5A9
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 18:07:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37AC11F995;
        Tue,  7 Jun 2022 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654564038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g619Vf0VHpcAxy414jyj9QsdidRWcJrQpWcX3OGfz+8=;
        b=RVz/7eMqavAPGK5pV7MvEqchiyPIyzcHpLGuNxxzNnRtV9sCD0xR15kwDXnCRut00pxyvG
        DrDKlSzorW9HKptIQyxFMiK6qsNpkqYUhjS8u7JD5Ro9uI363NW5mLz4XZa5yOMZZ4S3zN
        33z6IABdlKcm+8xqZrlj4VQBGL6KhPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654564038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g619Vf0VHpcAxy414jyj9QsdidRWcJrQpWcX3OGfz+8=;
        b=3aBg6XUvWhZHfNdx57kz9AEFidzeXzkX0T++H1QTG8Icjy1SG6yt1CM4gMLWpQ/GttqQ+2
        50OfT0Uw2KUcPCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 567CB13A5F;
        Tue,  7 Jun 2022 01:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JxRpBMWknmLdFQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 01:07:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 4/5] SUNRPC: Clean up xdr_get_next_encode_buffer()
In-reply-to: <165445912444.1664.7733109680322574177.stgit@bazille.1015granger.net>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445912444.1664.7733109680322574177.stgit@bazille.1015granger.net>
Date:   Tue, 07 Jun 2022 11:07:13 +1000
Message-id: <165456403303.22243.14012939379410947473@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 06 Jun 2022, Chuck Lever wrote:
> The value of @p is not used until the "location of the next item" is
> computed. Help human readers by moving its initial assignment to the
> paragraph where that value is used and by clarifying the antecedents
> in the documenting comment.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: NeilBrown <neilb@suse.com>


> ---
>  net/sunrpc/xdr.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index de8f71468637..89cb48931a1f 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -971,6 +971,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(stru=
ct xdr_stream *xdr,
>  		xdr->buf->page_len +=3D frag1bytes;
>  	xdr->page_ptr++;
>  	xdr->iov =3D NULL;
> +
>  	/*
>  	 * If the last encode didn't end exactly on a page boundary, the
>  	 * next one will straddle boundaries.  Encode into the next
> @@ -979,11 +980,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(st=
ruct xdr_stream *xdr,
>  	 * space at the end of the previous buffer:
>  	 */
>  	xdr_set_scratch_buffer(xdr, xdr->p, frag1bytes);
> -	p =3D page_address(*xdr->page_ptr);
> +
>  	/*
> -	 * Note this is where the next encode will start after we've
> -	 * shifted this one back:
> +	 * xdr->p is where the next encode will start after
> +	 * xdr_commit_encode() has shifted this one back:
>  	 */
> +	p =3D page_address(*xdr->page_ptr);
>  	xdr->p =3D (void *)p + frag2bytes;
>  	space_left =3D xdr->buf->buflen - xdr->buf->len;
>  	if (space_left - nbytes >=3D PAGE_SIZE)
>=20
>=20
>=20
