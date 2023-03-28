Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E636CC637
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjC1P1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjC1P1R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 11:27:17 -0400
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15FF76F
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=VtSGJnO6dCW+SfAmxp/CTF2W/DkyXXrOsV+4HK
 etbxM=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1680017128;
 x=1680621928; b=U5X8ukYd82lcNxR4889cqunE7wKnUN7fxiR8ve0Gi/hTfqXhS9BR2kS
 kk6cwYbN8mTW+3s5o+1z9A0gT1893S021QiEbHk1GJWQ24Fiu/nLIyiwC3Mmzm43c9ZOjY1
 6eitBhSuqE3zFXTXcoMVSx1T9ILT4awBNtcax0tO1wG6SdeUnOaZCyGV4JWdjroq3BwypW5
 NjcGxYyVe/r5D1lUYTn2Nb9Zd7ecqhPxLMbjfhN1AIJHiGSOBFG44lsK6zDhlJ1se5geK1D
 HQXDPNPAj9AX8WFK/G9KV/mV119udce7P+N76MFfKRLdYjwEEtek9ZLDdGGssuYHtOUt3j9
 MBA==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao02p with ngmta
 id d1e7961c-17509ead44736c66; Tue, 28 Mar 2023 15:25:28 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'NeilBrown'" <neilb@suse.de>,
        "'Bruce Fields'" <bfields@fieldses.org>,
        "'Jeff Layton'" <jlayton@kernel.org>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
In-Reply-To: <167996453785.8106.14290228013263156210@noble.neil.brown.name>
Subject: RE: [PATCH pynfs] rpc.py: Don't try to subscript an exception.
Date:   Tue, 28 Mar 2023 08:25:27 -0700
Message-ID: <011501d96189$86f2e760$94d8b620$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGzsPtoPu+eDxk3wRxvo/A2s6C0fK9bsOMg
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks. I have this patch in my repo and keep not getting around to =
submitting it.

Frank

> -----Original Message-----
> From: NeilBrown [mailto:neilb@suse.de]
> Sent: Monday, March 27, 2023 5:49 PM
> To: Bruce Fields <bfields@fieldses.org>; Jeff Layton =
<jlayton@kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Subject: [PATCH pynfs] rpc.py: Don't try to subscript an exception.
>=20
>=20
> As far as I can tell python3 has never supported subscripting of =
exceptions.
> So don't try to...
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  nfs4.0/lib/rpc/rpc.py | 2 +-
>  rpc/rpc.py            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py index
> 24a7fc72eff0..585db3551f73 100644
> --- a/nfs4.0/lib/rpc/rpc.py
> +++ b/nfs4.0/lib/rpc/rpc.py
> @@ -227,7 +227,7 @@ class RPCClient(object):
>                  sock.bind(('', port))
>                  return
>              except socket.error as why:
> -                if why[0] =3D=3D errno.EADDRINUSE:
> +                if why.errno =3D=3D errno.EADDRINUSE:
>                      port +=3D 1
>                  else:
>                      print("Could not use low port") diff --git =
a/rpc/rpc.py b/rpc/rpc.py
> index 1fe285aa2b5b..814de4e08bc9 100644
> --- a/rpc/rpc.py
> +++ b/rpc/rpc.py
> @@ -846,7 +846,7 @@ class ConnectionHandler(object):
>                  s.bind(('', using))
>                  return
>              except socket.error as why:
> -                if why[0] =3D=3D errno.EADDRINUSE:
> +                if why.errno =3D=3D errno.EADDRINUSE:
>                      using +=3D 1
>                      if port < 1024 <=3D using:
>                          # If we ask for a secure port, make sure we =
don't
> --
> 2.40.0

