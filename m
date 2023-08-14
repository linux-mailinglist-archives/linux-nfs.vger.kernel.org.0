Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F877BD13
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHNPbL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjHNPa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 11:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF9130;
        Mon, 14 Aug 2023 08:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3EE617E6;
        Mon, 14 Aug 2023 15:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72158C433C8;
        Mon, 14 Aug 2023 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692027055;
        bh=2rIEWfvHTOoSstRDPlbGbijXKFOFaVhDleRh7kzY/Nk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oEW0uiYDHaRlmmgqTvVPajItZrcTtOaWeO45t41ZMxtGRw5nYYlBpxSWnvVi23+Fd
         5rJHEPGBPBy011+dagnqxertDN2FutdBw2v6Uuw2CitsPF52hC+4jmkDHkmUMuBlbZ
         dPuZuO3TmNaE2wCJji8lWFZurij1/MiwTj8otDvdPOQ7y+vHBGcFKyHo+7O++fnqPt
         Twyf2WFWF/g+QvI02gIy3XJGoSUc+748XnKTemZEUZkau2U8a7TkEzpkqDRsox7Ckh
         XB05KIifX20S5PatYI2vTT0aAek07SD5GfzVwFMShDDhHuGNNaf+kzk5WawjHOmtxe
         j8mxiUX3//vwQ==
Message-ID: <7c9421cc4b92dee76cc7560c50a4a0ab3fb1ef0d.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: account for xdr->page_base in xdr_alloc_bvec
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Aug 2023 11:30:53 -0400
In-Reply-To: <40adb882f4c809b8a404e167c05bbbc9a1de6fa0.camel@hammerspace.com>
References: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
         <40adb882f4c809b8a404e167c05bbbc9a1de6fa0.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-08-14 at 14:51 +0000, Trond Myklebust wrote:
> On Mon, 2023-08-14 at 10:32 -0400, Jeff Layton wrote:
> > I've been seeing a regression in mainline (v6.5-rc) kernels where
> > unaligned reads were returning corrupt data.
> >=20
> > 9d96acbc7f37 added a routine to allocate and populate a bvec array
> > that
> > can be used to back an iov_iter. When it does this, it always sets
> > the
> > offset in the first bvec to zero, even when the xdr->page_base is
> > non-zero.
> >=20
> > The old code in svc_tcp_sendmsg used to account for this, as it was
> > sending the pages one at a time anyway, but now that we just hand the
> > iov to the network layer, we need to ensure that the bvecs are
> > properly
> > initialized.
> >=20
> > Fix xdr_alloc_bvec to set the offset in the first bvec to the offset
> > indicated by xdr->page_base, and then 0 in all subsequent bvecs.
> >=20
> > Fixes: 9d96acbc7f37 ("SUNRPC: Add a bvec array to struct xdr_buf for
> > use with iovec_iter()")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > NB: This is only lightly tested so far, but it seems to fix the pynfs
> > regressions I've been seeing.
> > ---
> > =A0net/sunrpc/xdr.c | 4 +++-
> > =A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 2a22e78af116..d0f5fc8605b8 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -144,6 +144,7 @@ int
> > =A0xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0size_t i, n =3D xdr_buf_pagecount(buf);
> > +=A0=A0=A0=A0=A0=A0=A0unsigned int offset =3D offset_in_page(buf->page_=
base);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (n !=3D 0 && buf->bvec =3D=3D NULL) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0buf->bvec =3D kmalloc_a=
rray(n, sizeof(buf->bvec[0]),
> > gfp);
> > @@ -151,7 +152,8 @@ xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return -ENOMEM;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < n; i+=
+) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0bvec_set_page(&buf->bvec[i], buf->pages[i],
> > PAGE_SIZE,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0o=
ffset =3D 0;
>=20
> NACK. That's going to break the client.
>=20

<rant>
What's the point of setting up a bvec array that doesn't actually
describe the usable data?
</rant>

Sigh, ok...I suppose we'll need to fix this in the svc callers instead.

> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> >=20
> > ---
> > base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> > change-id: 20230814-sendpage-b04874eed249
> >=20
> > Best regards,
>=20

--=20
Jeff Layton <jlayton@kernel.org>
