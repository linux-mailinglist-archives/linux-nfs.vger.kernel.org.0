Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F133D5E90EE
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Sep 2022 06:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIYEKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Sep 2022 00:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIYEKU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Sep 2022 00:10:20 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D52D28713
        for <linux-nfs@vger.kernel.org>; Sat, 24 Sep 2022 21:10:17 -0700 (PDT)
From:   Sam James <sam@gentoo.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_73A87A0E-FB2F-4921-8A05-7B92B0E1681E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2] Fix more function prototypes
Date:   Sun, 25 Sep 2022 05:10:11 +0100
References: <20220916214300.2820117-1-sam@gentoo.org>
To:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
In-Reply-To: <20220916214300.2820117-1-sam@gentoo.org>
Message-Id: <5C0273D4-1BC4-4B1A-BB6E-D16BA30113C3@gentoo.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_73A87A0E-FB2F-4921-8A05-7B92B0E1681E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 16 Sep 2022, at 22:43, Sam James <sam@gentoo.org> wrote:
>=20
> ```
> regex.c:545:43: error: a function declaration without a prototype is =
deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> struct trans_func *libnfsidmap_plugin_init()
>                                          ^
>                                           void
> 1 error generated.
> ```
>=20
> See: 167f2336b06e1bcbf26f45f2ddc4a535fed4d393
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> support/nfsidmap/regex.c | 2 +-
> utils/idmapd/idmapd.c    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

ping


--Apple-Mail=_73A87A0E-FB2F-4921-8A05-7B92B0E1681E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCYy/Uo18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kGqEAQDtdXHjqDFFxgN8L8GPUaCWv/Kl9qm7VoaUeowtbUhh2AEAxD1m7a5EQ5rw
Psh5cEWWm89z4yxBFY6NwHnWCbwPiA4=
=338e
-----END PGP SIGNATURE-----

--Apple-Mail=_73A87A0E-FB2F-4921-8A05-7B92B0E1681E--
