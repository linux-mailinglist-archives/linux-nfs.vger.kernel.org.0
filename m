Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2658777546D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHIHuE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjHIHuD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 03:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364961BE1
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 00:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE8962FE5
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 07:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D871C433C9;
        Wed,  9 Aug 2023 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691567401;
        bh=r27cmLOI3IzusRSPeMFr57FgoSRL4NUYNCtUmjFEWxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJ8tU80IXn9kcXpT0JgkZKY5IX+a+DdOok4CBuaKnJNr7SKMjDcxk6W81MPQdNhV9
         RHIJx5p8Bh+66N5bBu8Ep9jR12T42ZDdm5S6SpXaPn5OOhbeui37GrFYJ0IrIxkbp/
         hf4jC62h3IdV16mio92Cj9NJgEze0okcVWUkghjE9/izuIPGsnHOHXltAPMiEUGJKw
         Dq2FdjGjzW4/50hVzOIlO6NDmqVBX0+bXt7GciwOQQORxK5JSVVVygVBdHch1cdKRB
         Uh2FR8P8Mulzj1E1TEesVq2Jgn8cNlAawefIXEdDj9DWxVstMuj8OB+it/CSll5bFd
         z1jc9MbIJ/k7g==
Date:   Wed, 9 Aug 2023 09:49:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNNFI7baJW+XGTJS@lore-rh-laptop>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
 <ZNKBvgAMnOsDiaKQ@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZJEOpuJxZ9Bix7h"
Content-Disposition: inline
In-Reply-To: <ZNKBvgAMnOsDiaKQ@tissot.1015granger.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--7ZJEOpuJxZ9Bix7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> > On Tue, 2023-08-08 at 10:03 -0400, Chuck Lever wrote:
> > > On Tue, Aug 08, 2023 at 09:48:42AM -0400, Jeff Layton wrote:
> > > > On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> > > > > On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > > > > > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > > > > > Introduce version field to nfsd_rpc_status handler in order t=
o help
> > > > > > > the user to maintain backward compatibility.
> > > > > >=20
> > > > > > I wonder if this really helps.  What do I do if I see a version=
 that I
> > > > > > don't understand?  Ignore the whole file?  That doesn't make fo=
r a good
> > > > > > user experience.
> > > > >=20
> > > > > There is no UX consideration here. A user browsing the file direc=
tly
> > > > > will not care about the version.
> > > > >=20
> > > > > This file is intended to be parsable by scripts and they have to
> > > > > keep up with the occasional changes in format. Scripts can handle=
 an
> > > > > unrecogized version however they like.
> > > > >=20
> > > > > This is what we typically get with a made-up format that isn't .i=
ni
> > > > > or JSON or XML. The file format isn't self-documenting. The final
> > > > > field on each row is a variable number of tokens, so it will be
> > > > > nearly impossible to simply add another field without breaking
> > > > > something.
> > > > >=20
> > > >=20
> > > > It shouldn't be a variable number of tokens per line.
> > >=20
> > > That's how NFSv4 COMPOUND operations are displayed. For example:
> > >=20
> > > 0x5d58666f 0x000000d1 0x000186a3 NFSv4 COMPOUND 0000062034739371 192.=
168.103.67 0 192.168.103.56 20049 OP_SEQUENCE OP_PUTFH OP_READ
> > >=20
> > > The list of operations in the displayed compound are currently
> > > blank-separated tokens at the end of each row.
> > >=20
> >=20
> > Oh! That's a bug in missed in my latest review then. The operations
> > field was delimited by ':' chars at one point. Lorenzo, did you mean to
> > change that?
> >=20
> > IMO, the list of operations should be one field, separated by a distinct
> > delimiter (like ':').
> >=20
> > >=20
> > > > If there is, then that's a bug, IMO. We do want it to be simple to
> > > > just add a new field, published version info notwithstanding.
> > >=20
> > > They could be wrapped in curly braces, or separated by commas, to
> > > make them all one token.
> > >=20
> > > I haven't looked at NFSv3 output yet, but I expect those extra
> > > tokens won't even be there in that case.
> > >=20
> >=20
> > That's probably another bug. Anything not a v4 COMPOUND should have
> > something as a placeholder. It could just be a single '-' character.
>=20
> Confirmed, rows reporting NFSv3 procedures have nothing on the end.
>=20
> I'll also note that rq_prog and the "NFSv" string are problematic.
> Is it the case that all RPCs handled in this thread pool are going
> to be NFS requests?
>=20
> If we expect non-NFS requests to be handled in this thread pool
> (like svc_wake_up or NFSACL) then the loop should simply skip
> threads whose rq_prog !=3D NFS_PROGRAM.
>=20
> And, if the rpc_status file is supposed to display only NFS
> requests (and I believe the answer to that is yes), then let's drop
> the rq_prog field, since it will always show the same value.

ack, I will fix it.

>=20
>=20
> > > JSON, yaml, or xml would all address the extensibility problem, just
> > > as an alternative thought.
> > >=20
> >=20
> > It would probably be fairly simple to output well-formed yaml instead.
> > JSON and XML are a bit more of a pain.
> >=20
> > For now, we can change the output. We do need to have this settled
> > before this goes to Linus' tree though.
>=20
> Lorenzo, I'll drop the v5 of this series from nfsd-next. When you're
> ready, please send another version with the discussed changes
> squashed in.

ack, fine to me. Just a couple of questions:
- do we want to expose the output in yaml or is it enough to fix the NFSv4 =
COMPOUND
  parsing using ":" as sub-delimiter (and add a placeholder for non NFSv4 C=
OMPOUND)?
  The yaml approach downside is we will need to add some specific code sinc=
e afaik
  there isn't any yaml code we can rely on in the kernel, right?
- what about netlink? I would say we can have both of them (cat + netlink) =
so
  the user does not need to have a specific userspace tool to decode the in=
fo.

I will work on v6 as soon as we have agreed on the points above.

Regards,
Lorenzo

>=20
>=20
> --=20
> Chuck Lever

--7ZJEOpuJxZ9Bix7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNNFHwAKCRA6cBh0uS2t
rP4PAP9l+fqXJFmsz6PUXGpnmR/yruRVJCuOseEH4E2uAm000QEAxbE1NKvSjSNR
CggdvrMpAB8PZTlhYYdS1Jyg58lDYgk=
=NFPd
-----END PGP SIGNATURE-----

--7ZJEOpuJxZ9Bix7h--
