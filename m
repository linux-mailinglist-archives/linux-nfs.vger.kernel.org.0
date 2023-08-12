Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE597779FC4
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Aug 2023 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjHLLpO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Aug 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjHLLpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Aug 2023 07:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5F1707;
        Sat, 12 Aug 2023 04:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B344611EA;
        Sat, 12 Aug 2023 11:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B10C433CA;
        Sat, 12 Aug 2023 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691840713;
        bh=ROOEmh24vfpoOFBtgUeWYuT6gwjVQp4jttc7XkiPJYw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SFc4VfVVrOPAjE8tTDB+t8KMlWgzVhkpMJAhtPb5wqa5yW9M0DP7sG6CDSGFzLM5C
         KMbwxzjnbaKFv7gir7WYU+wlcI/U3noF+Ta4bbXv/RveJKBSUpRzTKcgk9X79xz9Hr
         ejLXh08WBlHyi2u0WaQKrAMCA/NUEtfGiuv5xszOglUv+xVQPUCbpH6P4yIX49Utf9
         TWtdzIephtODICRAQUNABhHNGtlikMXdgsCiZfkrHX8zVpGgYWqbWiTTd9azVOBhm2
         bW9ioG+JdIxaWGfUCy3vroRnRuciEIaqPJiAd7Z4kiKJnui1avdOA44cfmpioeCBqo
         N1ipE+wnhOZDw==
Message-ID: <f508459473376e0f08e3a147b292aaab1785f320.camel@kernel.org>
Subject: Re: [PATCH net-next 3/6] sunrpc: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date:   Sat, 12 Aug 2023 07:45:11 -0400
In-Reply-To: <ab2bec0ee8ab792b9187248b05d4b2ff5b64acbf.camel@kernel.org>
References: <20230609100221.2620633-1-dhowells@redhat.com>
         <20230609100221.2620633-4-dhowells@redhat.com>
         <104f68073d00911668ed6ea38239ef5f1d15567d.camel@kernel.org>
         <ab2bec0ee8ab792b9187248b05d4b2ff5b64acbf.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-08-11 at 19:07 -0400, Jeff Layton wrote:
> On Fri, 2023-08-11 at 18:50 -0400, Jeff Layton wrote:
> > On Fri, 2023-06-09 at 11:02 +0100, David Howells wrote:
> > > When transmitting data, call down into TCP using sendmsg with
> > > MSG_SPLICE_PAGES to indicate that content should be spliced rather th=
an
> > > performing sendpage calls to transmit header, data pages and trailer.
> > >=20
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > > cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > cc: Anna Schumaker <anna@kernel.org>
> > > cc: Jeff Layton <jlayton@kernel.org>
> > > cc: "David S. Miller" <davem@davemloft.net>
> > > cc: Eric Dumazet <edumazet@google.com>
> > > cc: Jakub Kicinski <kuba@kernel.org>
> > > cc: Paolo Abeni <pabeni@redhat.com>
> > > cc: Jens Axboe <axboe@kernel.dk>
> > > cc: Matthew Wilcox <willy@infradead.org>
> > > cc: linux-nfs@vger.kernel.org
> > > cc: netdev@vger.kernel.org
> > > ---
> > >  include/linux/sunrpc/svc.h | 11 +++++------
> > >  net/sunrpc/svcsock.c       | 38 ++++++++++++------------------------=
--
> > >  2 files changed, 17 insertions(+), 32 deletions(-)
> > >=20
> >=20
> > I'm seeing a regression in pynfs runs with v6.5-rc5. 3 tests are failin=
g
> > in a similar fashion. WRT1b is one of them
> >=20
> > [vagrant@jlayton-kdo-nfsd nfs4.0]$  ./testserver.py --rundeps --maketre=
e --uid=3D0 --gid=3D0 localhost:/export/pynfs/4.0/ WRT1b                   =
                                 =20
> > **************************************************                     =
                                                                           =
                             =20
> > WRT1b    st_write.testSimpleWrite2                                : FAI=
LURE                                                                       =
                             =20
> >            READ returned                                               =
                                                                           =
                             =20
> >            b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x=
00',                                                                       =
                             =20
> >            expected b'\x00\x00\x00\x00\x00write data'                  =
                                                                           =
                             =20
> > INIT     st_setclientid.testValid                                 : PAS=
S                                                                          =
                             =20
> > MKFILE   st_open.testOpen                                         : PAS=
S                                                                          =
                             =20
> > **************************************************                     =
                                                                           =
                             =20
> > Command line asked for 3 of 679 tests                                  =
                                                                           =
                             =20
> > Of those: 0 Skipped, 1 Failed, 0 Warned, 2 Passed                      =
                            =20
>=20
> FWIW, here's a capture that shows the problem. See frames 109-112 in
> particular. If no one has thoughts on this one, I'll plan to have a look
> early next week.

Since Chuck's nfsd-next branch (which is based on v6.5-rc5) wasn't
showing this issue, I ran a bisect to see what fixes it, and it landed
on this patch:

commit ed9cd98404c8ae5d0bdd6e7ce52e458a8e0841bb
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Wed Jul 19 14:31:03 2023 -0400

    SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
   =20
    Add a helper to convert a whole xdr_buf directly into an array of
    bio_vecs, then send this array instead of iterating piecemeal over
    the xdr_buf containing the outbound RPC message.
   =20
    Reviewed-by: David Howells <dhowells@redhat.com>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>


I'll follow up on that thread. I think we may want to pull this patch
into mainline for v6.5.
--=20
Jeff Layton <jlayton@kernel.org>
