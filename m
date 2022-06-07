Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1B53F3F3
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiFGCfq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiFGCfp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 22:35:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F628B0A3
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 19:35:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F182221ACE;
        Tue,  7 Jun 2022 02:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654569342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tQHcPh1M62ARJMexNCI9Zi2sgoNKZiM1Rf6+GxK5t8=;
        b=smPmhVoZtjiM0FvUbl3D2XyL+3rvWMtaIGg+GwcwX/VVzmv/UvJf3KEqlDB0rHDuZQv5n1
        NKpM94OUetDEa5TxWL2e8gyhIXXji9koRscOvVnKxDAbv4zm09On9Iz1fhP0Mut2jHAnJ0
        tYVKYEefpM7nFMqAC6/TBglT7V3aoy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654569342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tQHcPh1M62ARJMexNCI9Zi2sgoNKZiM1Rf6+GxK5t8=;
        b=b+p1yPx3kSBctSSakJCAbbSNp30r56BZf0rTZrcNgBg9xn72TEnxaQcqtZVzxrURrmhNWu
        CAWM+6ceOOBYUhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC46D13A15;
        Tue,  7 Jun 2022 02:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l8Q/HXq5nmJKKgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 02:35:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] SUNRPC: Optimize xdr_reserve_space()
In-reply-to: <0F620E33-2490-411B-B934-F8C379C05F74@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445911199.1664.12318094116152634589.stgit@bazille.1015granger.net>,
 <165456379661.22243.4266686429763691053@noble.neil.brown.name>,
 <0F620E33-2490-411B-B934-F8C379C05F74@oracle.com>
Date:   Tue, 07 Jun 2022 12:35:33 +1000
Message-id: <165456933371.22243.16789450002389550272@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Jun 2022, Chuck Lever III wrote:
>=20
> > On Jun 6, 2022, at 9:03 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Mon, 06 Jun 2022, Chuck Lever wrote:
> >> The xdr_get_next_encode_buffer() function is called infrequently.
> >> On a typical build/test workload, it's called about 1 time in 400
> >> calls to xdr_reserve_space() (measured on NFSD).
> >>=20
> >> Force the compiler to remove it from xdr_reserve_space(), which is
> >> a hot path. This change reduces the size of xdr_reserve_space() from
> >> 10 cache lines to 4 on my test system.
> >=20
> > Does this really help at all?  Are the instructions that are executed in
> > the common case distributed over those 10 cache line, or are they all in
> > the first 4?
> >=20
> > I would have thought the "unlikely" in xdr_reserve_space() would have
> > pushed all the code from xdr_get_next_encode_buffer() to the end of the
> > function leaving the remainder in a small contiguous chunk.
>=20
> Well, granted that I'm compiling with -Os, not -O2. The compiler inlines
> xdr_get_next_encode_buffer() right in the middle of xdr_reserve_space().

Interesting.  I tried with -O2 and it move xdr_get_next_encode_buffer()
to the end, but inlined xdr_commit_encode() in the middle.
I changed xdr_commit_encode() to wrap the "shift=3D=3D0" test in likely(),
and then it produced a more reasonable result.

With your noinline patch, the "return xdr_get_next_encode_buffer()"
becomes a jump, not a jump-to-subroutine, so there is little cost in it.

Might I suggest:
  Move the "xdr->scratch.iov_len" test out of xdr_commit_encode() and
  put it in both callers as "unlikely".
  Mark both xdr_commit_encode and xdr_get_next_encode_buffer() as
  noinline
  mention in the commit message that with -Os the "unlikely" in
  xdr_reserve_space() doesn't help
??

Thanks,
NeilBrown


>=20
>=20
> > NeilBrown
> >=20
> >=20
> >>=20
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> net/sunrpc/xdr.c |    9 +++++++--
> >> 1 file changed, 7 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> >> index b57cf9df4de8..08a85375b311 100644
> >> --- a/net/sunrpc/xdr.c
> >> +++ b/net/sunrpc/xdr.c
> >> @@ -945,8 +945,13 @@ inline void xdr_commit_encode(struct xdr_stream *xd=
r)
> >> }
> >> EXPORT_SYMBOL_GPL(xdr_commit_encode);
> >>=20
> >> -static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
> >> -		size_t nbytes)
> >> +/*
> >> + * The buffer space to be reserved crosses the boundary between
> >> + * xdr->buf->head and xdr->buf->pages, or between two pages
> >> + * in xdr->buf->pages.
> >> + */
> >> +static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *x=
dr,
> >> +						   size_t nbytes)
> >> {
> >> 	__be32 *p;
> >> 	int space_left;
> >>=20
> >>=20
> >>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
