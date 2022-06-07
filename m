Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22A53F327
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 02:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiFGA7f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 20:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFGA7e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 20:59:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0BD19FA
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 17:59:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A2C81F93C;
        Tue,  7 Jun 2022 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654563570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz8wQbKV/gm1GIrNP0Dj5uHkMvjFg/UoJwX1bi+vEtM=;
        b=z4fs88oUwWu5lWwdOfNr6/fo0v6v0RbPoyK6rCjTyPyTTCkNf46orj8bYgNwGT8j7KqFpT
        2VuiTF9Ggk7BwiTPlBG12nkwnfL8/EBh86LmU1FJRMKZNCkwzreZTyI9Oso53mm1YpN5Xe
        xe/DSGGvxcQ3j9vWRrKQj9utJ+qIJ4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654563570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz8wQbKV/gm1GIrNP0Dj5uHkMvjFg/UoJwX1bi+vEtM=;
        b=3haD5HQwuwJ3UFeXCWo51j+dL10VXSYTJawNzx8zU80eV6LkWcEjk8uyeFUHWd4IbH6AnI
        8LjRzjb3d84O6qCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57EAF13A5F;
        Tue,  7 Jun 2022 00:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8vMFBfGinmLzEwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 00:59:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
In-reply-to: <20220606220938.GE15057@fieldses.org>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445910560.1664.5852151724543272982.stgit@bazille.1015granger.net>,
 <20220606220938.GE15057@fieldses.org>
Date:   Tue, 07 Jun 2022 10:59:25 +1000
Message-id: <165456356541.22243.8883363674329684173@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Jun 2022, J. Bruce Fields wrote:
> On Sun, Jun 05, 2022 at 03:58:25PM -0400, Chuck Lever wrote:
> > I found that NFSD's new NFSv3 READDIRPLUS XDR encoder was screwing up
> > right at the end of the page array. xdr_get_next_encode_buffer() does
> > not compute the value of xdr->end correctly:
> >=20
> >  * The check to see if we're on the final available page in xdr->buf
> >    needs to account for the space consumed by @nbytes.
> >=20
> >  * The new xdr->end value needs to account for the portion of @nbytes
> >    that is to be encoded into the previous buffer.
> >=20
> > Fixes: 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/xdr.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index df194cc07035..b57cf9df4de8 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -979,7 +979,11 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr=
_stream *xdr,
> >  	 */
> >  	xdr->p =3D (void *)p + frag2bytes;
> >  	space_left =3D xdr->buf->buflen - xdr->buf->len;
> > -	xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
> > +	if (space_left - nbytes >=3D PAGE_SIZE)
> > +		xdr->end =3D (void *)p + PAGE_SIZE;
> > +	else
> > +		xdr->end =3D (void *)p + space_left - frag1bytes;
> > +
>=20
> I think that's right.

I think I agree.

>=20
> Couldn't you just make that
>=20
>=20
> -	xdr->end =3D (void *)p + min_t(int, space_left, PAGE_SIZE);
> +	xdr->end =3D (void *)p + min_t(int, space_left - nbytes, PAGE_SIZE);

I don't think that is the same.
When space_left is small, this results in "p + space_left - nbytes" but
the one we both this is right results in  "p + space_left - frag1bytes".

I'm going to suggest a more radical change.
Let's start off with=20

   int space_avail =3D xdr->buf->buflen - xdr->buf->len;

In this function we sometime care about space before we consume any, and
something care about space after we consume some.  "space_left" sounds
more like the latter.  "space_avail" sounds more like the former.
Current space_left is assigned to the former, which I find confused.

Then the second "if" which Bruce highlighted becomes

   if (nbytes > space_avail)
          goto out_overflow;

which is obviously correct.

We then assign frag{1,2}bytes and have another chunk of code that looks
wrong to me.  I'd like

   if (xdr->iov) {
	xdr->iov->iov_len +=3D frag1bytes;
	xdr->iov =3D NULL;
   } else {
        xdr->buf->page_len +=3D frag1bytes;
        xdr->page_ptr++;
   }

Note that this changes the code NOT to increment pagE_ptr if iov was not
NULL.  I cannot see how it would be correct to do that.  Presumably this
code is never called with iov !=3D NULL ???

Now I want to rearrange the assignments at the end:

	xdr->p =3D (void *)p + frag2bytes;
	xdr->buf->page_len +=3D frag2bytes;
	xdr->buf->len +=3D nbytes;
	space_left =3D xdr->buf->buflen - xdr->buf->len;
	xdr->end =3D (void *)xdr->p + min_t(int, space_left, PAGE_SIZE);

Note that the last line "xdr->p" in place of "p".
We still have "space_left", but it now is the space that is left
after we have consumed some.

Possibly the space_left line could be

       space_left -=3D nbytes;

NeilBrown

>=20
> ?
>=20
> (Note we know space_left >=3D nbytes from the second "if" of this
> function.)
>=20
> No strong opinion either way, really, I just wonder if I'm missing
> something.
>=20
> --b.
>=20
> >  	xdr->buf->page_len +=3D frag2bytes;
> >  	xdr->buf->len +=3D nbytes;
> >  	return p;
> >=20
>=20
