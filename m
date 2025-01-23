Return-Path: <linux-nfs+bounces-9561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1AAA1AB96
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CBB3ACD85
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330018C02E;
	Thu, 23 Jan 2025 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqWuWbyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15A15A843
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665428; cv=none; b=mv0EhA6PoOKhS2MVnCF2V3ehBjJu131yw52h8wxPeNVxl8zjEdbOjkCpirJUN1l2cyCckx6EC+cZ4Xp494zmh6Ft+XS73UqeSDkzk3o83wPOgga0BJcwQr2D5kmmp74J26MaiFxld1Zk4vdSQOj22MWGH7Wt+/KRfUF90ZMQKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665428; c=relaxed/simple;
	bh=JILWKiMuP7VpiFE9DV7hlNrtAOakGPtMqACV2nkCye8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jnjn4W9ehPumk1kCKwTR9P6sdjOC+hNAfWml3+PVeIk4k8v74fSZ0k59NhnpRlUNAuS5ZQBR4GHesi77eFf62qfKrZGI0QKEjhNKPerNlExl8nf0OePLLXrs0/XzFwKO6ABnUzuaeDwziqp/PZpeLYolBujoh2ZJV20Dq+cBseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqWuWbyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84093C4CED3;
	Thu, 23 Jan 2025 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737665427;
	bh=JILWKiMuP7VpiFE9DV7hlNrtAOakGPtMqACV2nkCye8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NqWuWbyho9NgSibUMcNZxrC7LcENILxDr1MzRKDjKzT+kuhyaLc6Zp+OXpRCi93KV
	 UYyulABRy62FDrPjeFvzAQgxsey6pdA+GN3i7A2eYqAS7UDL/KrPgJYb4fvC3W6K37
	 WY7wn3r9L66/4bAlptPWcuSpRB9WwNlf0B52yzxE4lDq1rS1E3skxhaRgwkFhyZ9R8
	 e1D8ByjkCPvJYyVVAkEOW4pt6k2/5ObsB1bVH/gW9QkZYcHx3TaJuki/L9L22o4lVX
	 Qtbe5aSJ3iR89l06pAUBhmuTOabsu/3cJgA1o8qVU8WJCPdtFGHfZ2FRfFApkIXr1G
	 S0iXx0iZlxxjw==
Message-ID: <d409eae2976c25f0121b1011bb2d1aff181aa4fa.camel@kernel.org>
Subject: Re: [PATCH pynfs] Move to xdrlib3
From: Jeff Layton <jlayton@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 23 Jan 2025 15:50:26 -0500
In-Reply-To: <020c8945-51e3-4783-b852-c89bc7917b67@oracle.com>
References: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
	 <020c8945-51e3-4783-b852-c89bc7917b67@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-23 at 19:36 +0000, Calum Mackay wrote:
> On 22/01/2025 5:13 pm, Jeff Layton wrote:
> > As of python 3.13, the xdrlib module is no longer included. Fortunately
> > there is an xdrlib3 module, which is a fork of the bundled module:
> >=20
> >      https://pypi.org/project/xdrlib3/
> >=20
> > Change pynfs to use that instead and revise the documentation to includ=
e
> > a step to install that module.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   README                                | 8 +++++++-
> >   nfs4.0/lib/rpc/rpc.py                 | 2 +-
> >   nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 2 +-
> >   nfs4.0/nfs4lib.py                     | 2 +-
> >   nfs4.0/nfs4server.py                  | 2 +-
> >   rpc/security.py                       | 2 +-
> >   xdr/xdrgen.py                         | 4 ++--
> >   7 files changed, 14 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/README b/README
> > index b8b4e775f7766086f870f2dda4a60b3e9f9bac6f..efdc23807e8107b8fcd575e=
8a4c80b9c73e3cd07 100644
> > --- a/README
> > +++ b/README
> > @@ -14,8 +14,14 @@ Install dependent modules:
> >   * openSUSE
> >   	zypper install krb5-devel python3-devel swig python3-gssapi python3-=
ply
> >  =20
> > -You can prepare both for use with
> > +Install the xdrlib3 module:
> > +
> > +	pip install xdrlib3
>=20
> Thanks Jeff,
>=20
> I see that Debian's unstable & testing suites have a pkg=20
> (python3-standard-xdrlib) to provide this post-removal from standard=20
> Python. Of course, that's not in general release, yet, but then neither=
=20
> is 3.13 itself. Not sure if we should mention it?
>=20
> e.g: your distro may provide xdrlib3 via a pkg (details=E2=80=A6), or you=
 may=20
> install it via pip=E2=80=A6
> or similar?
>=20
> cheers,
> c.
>=20
>=20

Sure, I'm fine with phrasing it that way. Mind fixing it up when you
merge it?

I'm on Fedora 41 which ships with python 3.13, so I think it is in
general release now. Fedora doesn't have xdrlib3 packaged however, so I
just used pip.

>=20
> > +
> > +You can prepare both versions for use with
> > +
> >   	./setup.py build
> > +
> >   which will create auto-generated files and compile any shared librari=
es
> >   in place.
> >  =20
> > diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> > index 243ef9e31aa83eb6be18800065b63cf78d99f833..475179042530a8d602a51e7=
bad1af7958ff5dd56 100644
> > --- a/nfs4.0/lib/rpc/rpc.py
> > +++ b/nfs4.0/lib/rpc/rpc.py
> > @@ -9,7 +9,7 @@
> >  =20
> >   from __future__ import absolute_import
> >   import struct
> > -import xdrlib
> > +import xdrlib3 as xdrlib
> >   import socket
> >   import select
> >   import threading
> > diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpc=
sec/sec_auth_sys.py
> > index 1e990a369e6588f24dff75e9569c104d775ff710..2581a1e1dca22f637dc3214=
4a05c88c66c57665e 100644
> > --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > @@ -1,7 +1,7 @@
> >   from .base import SecFlavor, SecError
> >   from rpc.rpc_const import AUTH_SYS
> >   from rpc.rpc_type import opaque_auth
> > -from xdrlib import Packer, Error
> > +from xdrlib3 import Packer, Error
> >  =20
> >   class SecAuthSys(SecFlavor):
> >       # XXX need better defaults
> > diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> > index eddcd862bc2fe2061414fb4de61e52aed93495ae..2337d8cd190de90e4d158b3=
ef9e3dfd6a61027c5 100644
> > --- a/nfs4.0/nfs4lib.py
> > +++ b/nfs4.0/nfs4lib.py
> > @@ -41,7 +41,7 @@ import xdrdef.nfs4_const as nfs4_const
> >   from  xdrdef.nfs4_const import *
> >   import xdrdef.nfs4_type as nfs4_type
> >   from xdrdef.nfs4_type import *
> > -from xdrlib import Error as XDRError
> > +from xdrlib3 import Error as XDRError
> >   import xdrdef.nfs4_pack as nfs4_pack
> >  =20
> >   import nfs_ops
> > diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> > index 2dbad3046709ea57c1503a36649d85c25e6301a8..10bf28ee5794684912fa8e6=
d19406e06bf88b742 100755
> > --- a/nfs4.0/nfs4server.py
> > +++ b/nfs4.0/nfs4server.py
> > @@ -34,7 +34,7 @@ import time, StringIO, random, traceback, codecs
> >   import StringIO
> >   import nfs4state
> >   from nfs4state import NFS4Error, printverf
> > -from xdrlib import Error as XDRError
> > +from xdrlib3 import Error as XDRError
> >  =20
> >   unacceptable_names =3D [ "", ".", ".." ]
> >   unacceptable_characters =3D [ "/", "~", "#", ]
> > diff --git a/rpc/security.py b/rpc/security.py
> > index 0682f438cd6237334c59e7cb280c8b192e7c8a76..789280c5d7328a928b2f6c1=
af95397d17180eff9 100644
> > --- a/rpc/security.py
> > +++ b/rpc/security.py
> > @@ -3,7 +3,7 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS,=
 SUCCESS, CALL, \
> >   from .rpc_type import opaque_auth, authsys_parms
> >   from .rpc_pack import RPCPacker, RPCUnpacker
> >   from .gss_pack import GSSPacker, GSSUnpacker
> > -from xdrlib import Packer, Unpacker
> > +from xdrlib3 import Packer, Unpacker
> >   from . import rpclib
> >   from .gss_const import *
> >   from . import gss_type
> > diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> > index b472e50676799915ea3b6a14f6686a5973484fb2..f802ba80045e79716a71fa7=
a64d72f1b8831128d 100755
> > --- a/xdr/xdrgen.py
> > +++ b/xdr/xdrgen.py
> > @@ -1357,8 +1357,8 @@ pack_header =3D """\
> >   import sys,os
> >   from . import %s as const
> >   from . import %s as types
> > -import xdrlib
> > -from xdrlib import Error as XDRError
> > +import xdrlib3 as xdrlib
> > +from xdrlib3 import Error as XDRError
> >  =20
> >   class nullclass(object):
> >       pass
> >=20
> > ---
> > base-commit: d042a1f6421985b7c9d17edf8eb0d59bcf7f5908
> > change-id: 20250122-master-68414e8f6d5f
> >=20
> > Best regards,
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

