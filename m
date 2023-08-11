Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E56779B07
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Aug 2023 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHKXHw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 19:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjHKXHm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 19:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857E4231;
        Fri, 11 Aug 2023 16:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1923766423;
        Fri, 11 Aug 2023 23:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D19C433C7;
        Fri, 11 Aug 2023 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691795231;
        bh=Jg6SfSia66ZZ2eZpi8qheHBeAjBxlbz/Vi7O7QuO+As=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HNs5pY/kENsEt3sbDpePBLBbOJUkn7AtQzQ7dQ5XfMadDBEFuTpoT81wv6Ijf8r2G
         teDfswlcaHiehF439uhXRL98rCkPmiK12tRqLrRKUQk3socUV54BcsP6TDAt3W4y3Y
         59FnxP2bNkmiaVHglWRNqcM3niY6axwPUy0U08UlhMWI/HG91WdldeAc3cIrLKrcR5
         5AfkKqhgdCq99gGkJL9gYMyI+tkM8BT/RtpePxDf+S0rpgpSwOeYJXtLKrQP1XUXcP
         sNgPlwQbe3FLuU+pDhSmYbfnRYCzd281W3VQQtl6nTLnPQUeXfwsY6H26MWrQwPaEa
         mLuf1+ShyjD2g==
Message-ID: <ab2bec0ee8ab792b9187248b05d4b2ff5b64acbf.camel@kernel.org>
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
Date:   Fri, 11 Aug 2023 19:07:08 -0400
In-Reply-To: <104f68073d00911668ed6ea38239ef5f1d15567d.camel@kernel.org>
References: <20230609100221.2620633-1-dhowells@redhat.com>
         <20230609100221.2620633-4-dhowells@redhat.com>
         <104f68073d00911668ed6ea38239ef5f1d15567d.camel@kernel.org>
Content-Type: multipart/mixed; boundary="=-nBq/uFlI/d+eUFIfxxcy"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-nBq/uFlI/d+eUFIfxxcy
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-08-11 at 18:50 -0400, Jeff Layton wrote:
> On Fri, 2023-06-09 at 11:02 +0100, David Howells wrote:
> > When transmitting data, call down into TCP using sendmsg with
> > MSG_SPLICE_PAGES to indicate that content should be spliced rather than
> > performing sendpage calls to transmit header, data pages and trailer.
> >=20
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > cc: Anna Schumaker <anna@kernel.org>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: Jens Axboe <axboe@kernel.dk>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: linux-nfs@vger.kernel.org
> > cc: netdev@vger.kernel.org
> > ---
> >  include/linux/sunrpc/svc.h | 11 +++++------
> >  net/sunrpc/svcsock.c       | 38 ++++++++++++--------------------------
> >  2 files changed, 17 insertions(+), 32 deletions(-)
> >=20
>=20
> I'm seeing a regression in pynfs runs with v6.5-rc5. 3 tests are failing
> in a similar fashion. WRT1b is one of them
>=20
> [vagrant@jlayton-kdo-nfsd nfs4.0]$  ./testserver.py --rundeps --maketree =
--uid=3D0 --gid=3D0 localhost:/export/pynfs/4.0/ WRT1b                     =
                               =20
> **************************************************                       =
                                                                           =
                           =20
> WRT1b    st_write.testSimpleWrite2                                : FAILU=
RE                                                                         =
                           =20
>            READ returned                                                 =
                                                                           =
                           =20
>            b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
',                                                                         =
                           =20
>            expected b'\x00\x00\x00\x00\x00write data'                    =
                                                                           =
                           =20
> INIT     st_setclientid.testValid                                 : PASS =
                                                                           =
                           =20
> MKFILE   st_open.testOpen                                         : PASS =
                                                                           =
                           =20
> **************************************************                       =
                                                                           =
                           =20
> Command line asked for 3 of 679 tests                                    =
                                                                           =
                           =20
> Of those: 0 Skipped, 1 Failed, 0 Warned, 2 Passed                        =
                          =20

FWIW, here's a capture that shows the problem. See frames 109-112 in
particular. If no one has thoughts on this one, I'll plan to have a look
early next week.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

--=-nBq/uFlI/d+eUFIfxxcy
Content-Type: application/x-xz; name="nfs.pcap.xz"
Content-Disposition: attachment; filename="nfs.pcap.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==


--=-nBq/uFlI/d+eUFIfxxcy--
