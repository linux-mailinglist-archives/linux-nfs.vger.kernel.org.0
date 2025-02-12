Return-Path: <linux-nfs+bounces-10056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7025A3279B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E286F3A4432
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C020E009;
	Wed, 12 Feb 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2bCTYoE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE53D97A
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368420; cv=none; b=h8v6SXhBfpCBLxtbmrlnflbWxr1EOhcuXc6qbgYL97kjIkpa90N5RVcCBEbqHkqFW4G5zkVnrVloUgAz/oIBMoMv5CH7H4bqiseb/bKi/deTGpI4ttK+VFS7erEIJOCw2hGgGEE+klfQqXj8rWxebhp9U4UuALD6KovBlraS004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368420; c=relaxed/simple;
	bh=649pV1ujE5gm0kWAbh9xN3r0KceY7Wa1GUMxw/r397w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjTQAdE6pMMK0EYb/QUiXFZ7TZvrtQJYiUmyLnUISRrgqfuZz6lCket4eE17QOZc0nLIQiLW8psRGIk1EtDSEx7ZSAViJvhUIBewFYY6lUTcOh05QcJX+QqDwLPcrc4ogGwjq86AyyK3hmFiGS8Lp1f0fVS24/NuAFJo+p/DI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2bCTYoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B23C4CEE2;
	Wed, 12 Feb 2025 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739368420;
	bh=649pV1ujE5gm0kWAbh9xN3r0KceY7Wa1GUMxw/r397w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l2bCTYoE5gBN+E23/riOH9q7CMB/4BmL5QRmR2Pcj6QCRldLrqNXvVQAnc9+HcA1A
	 /RSe9bUbSRN1ozQQ/PwIPAZw0WZrEpC9nmziQsmAlZbxcb70l3nzkwsffXUGx5jAuV
	 Bst9e3MV43rLroy8omgpSc9Vq+ZQrCb+nTPhKzAt3RVlR0zxm++n0FycAINI7IcQG1
	 pHqFeVAtbbBl9xMb4fxxPlWls0QIH9RE4kogXd0LISGvx2cEWmnv+xzQk1pwxGOiHV
	 gJoUuZ/a7EL5rkQjgseswHclOpRKaBRq3mYZtKl2JIqUj/9w+VKUXL23xLgFW2RwJQ
	 Aup94GDdBX+mg==
Message-ID: <e5ff0c6ac9ecbf0ebb7a1ecce55e17885eedf543.camel@kernel.org>
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
From: Jeff Layton <jlayton@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-nfs@vger.kernel.org, Calum Mackay <calum.mackay@oracle.com>, 
 Michael Moese <mmoese@suse.com>
Date: Wed, 12 Feb 2025 08:53:38 -0500
In-Reply-To: <20250212134713.GA2044610@pevik>
References: <20250212132346.2043091-1-pvorel@suse.cz>
	 <31e2b01ff9b3b4fbd370419f31886cd4a2a933ba.camel@kernel.org>
	 <20250212134713.GA2044610@pevik>
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

On Wed, 2025-02-12 at 14:47 +0100, Petr Vorel wrote:
> Hi Jeff,
>=20
> > On Wed, 2025-02-12 at 14:23 +0100, Petr Vorel wrote:
> > > On certain environments it might be difficult to install xdrlib3 via =
pip
> > > (e.g. python 3.11, which is a default on current Tumbleweed).
>=20
>=20
> > I did a "pip install xdrlib3" on Fedora 33 just now, and it has python
> > 3.9. What's the problem you're seeing with SuSE installing it with
> > v3.11?
>=20
> Yesterday I did not notice missing ply, I saw only missing xdrgen
> (xdr/xdrgen.py). Therefore I thought that virtualenv is mangling PYTHONPA=
TH.
> Obviously installing ply with pip would be enough.
>=20
> I also thing using a fallback saves the need to use virtualenv on old dis=
tros,
> therefore I would prefer this patch to be accepted. If it's not accepted,=
 it
> might be worth to extend info about dependencies.
>=20
> Kind regards,
> Petr
>=20
> $ python3 --version
> Python 3.11.11
>=20
> # pip install xdrlib3
>=20
> [notice] A new release of pip is available: 24.3.1 -> 25.0.1
> [notice] To update, run: pip install --upgrade pip
> error: externally-managed-environment
>=20
> =C3=97 This environment is externally managed
> =E2=95=B0=E2=94=80> To install Python packages system-wide, try
>     zypper install python311-xyz, where xyz is the package
>     you are trying to install.
> ...
>=20
> =3D> let's use virtualenv
>=20
> # python3 -m virtualenv .venv && . .venv/bin/activate
> created virtual environment CPython3.11.11.final.0-64 in 1466ms
>   creator CPython3Posix(dest=3D/root/pynfs/.venv, clear=3DFalse, no_vcs_i=
gnore=3DFalse, global=3DFalse)
>   seeder FromAppData(download=3DFalse, pip=3Dbundle, setuptools=3Dbundle,=
 wheel=3Dbundle, via=3Dcopy, app_data_dir=3D/root/.local/share/virtualenv)
>     added seed packages: pip=3D=3D24.3.1, setuptools=3D=3D75.8.0, wheel=
=3D=3D0.45.1, xdrlib3=3D=3D0.1.1
>   activators BashActivator,CShellActivator,FishActivator,NushellActivator=
,PowerShellActivator,PythonActivator
>=20
> # pip install xdrlib3
> Requirement already satisfied: xdrlib3 in ./.venv/lib/python3.11/site-pac=
kages (0.1.1)
>=20
> # ./setup.py build
> Moving to xdr
>=20
>=20
> Moving to rpc
> Traceback (most recent call last):
>   File "/root/pynfs/rpc/./setup.py", line 15, in <module>
>     import xdrgen
> ModuleNotFoundError: No module named 'xdrgen'
>=20
> During handling of the above exception, another exception occurred:
>=20
> Traceback (most recent call last):
>   File "/root/pynfs/rpc/./setup.py", line 18, in <module>
>     import xdrgen
>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>     import ply.lex as lex
> ModuleNotFoundError: No module named 'ply'
>=20
> Moving to nfs4.1
> Traceback (most recent call last):
>   File "/root/pynfs/nfs4.1/./setup.py", line 15, in <module>
>     import xdrgen
> ModuleNotFoundError: No module named 'xdrgen'
>=20
> During handling of the above exception, another exception occurred:
>=20
> Traceback (most recent call last):
>   File "/root/pynfs/nfs4.1/./setup.py", line 18, in <module>
>     import xdrgen
>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>     import ply.lex as lex
> ModuleNotFoundError: No module named 'ply'
>=20
> Moving to nfs4.0
> /root/pynfs/nfs4.0/./setup.py:7: DeprecationWarning: dep_util is Deprecat=
ed. Use functions from setuptools instead.
>   from distutils.dep_util import newer_group
> Traceback (most recent call last):
>   File "/root/pynfs/nfs4.0/./setup.py", line 11, in <module>
>     import xdrgen
> ModuleNotFoundError: No module named 'xdrgen'
>=20
> During handling of the above exception, another exception occurred:
>=20
> Traceback (most recent call last):
>   File "/root/pynfs/nfs4.0/./setup.py", line 14, in <module>
>     import xdrgen
>   File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
>     import ply.lex as lex
> ModuleNotFoundError: No module named 'ply'
>=20
> # pip install ply # this fixes it
>=20
> > BTW, does SuSE have the xdrlib3 module available as a package?
>=20
> > > Fixes: dfb0b07 ("Move to xdrlib3")
> > > Suggested-by: Michael Moese <mmoese@suse.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi,
>=20
> > > I admit it would be safer to check if python is really < 3.13.
>=20
> > > Kind regards,
> > > Petr
>=20
> > >  README                                | 2 ++
> > >  nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
> > >  nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
> > >  nfs4.0/nfs4lib.py                     | 6 +++++-
> > >  nfs4.0/nfs4server.py                  | 6 +++++-
> > >  rpc/security.py                       | 6 +++++-
> > >  xdr/xdrgen.py                         | 9 +++++++--
> > >  7 files changed, 35 insertions(+), 7 deletions(-)
>=20
> > > diff --git a/README b/README
> > > index 8c3ac27..d5214b4 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via =
pip:
>=20
> > >  	pip install xdrlib3
>=20
> > > +If xdrlib3 is not available fallback to old xdrlib (useful for pytho=
n < 3.13).
> > > +
> > >  You can prepare both versions for use with
>=20
> > >  	./setup.py build
> > > diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> > > index 4751790..7a80241 100644
> > > --- a/nfs4.0/lib/rpc/rpc.py
> > > +++ b/nfs4.0/lib/rpc/rpc.py
> > > @@ -9,12 +9,16 @@
>=20
> > >  from __future__ import absolute_import
> > >  import struct
> > > -import xdrlib3 as xdrlib
> > >  import socket
> > >  import select
> > >  import threading
> > >  import errno
>=20
> > > +try:
> > > +    import xdrlib3 as xdrlib
> > > +except:
> > > +    import xdrlib
> > > +
> > >  from rpc.rpc_const import *
> > >  from rpc.rpc_type import *
> > >  import rpc.rpc_pack as rpc_pack
> > > diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/r=
pcsec/sec_auth_sys.py
> > > index 2581a1e..41c6d54 100644
> > > --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > > +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > > @@ -1,7 +1,12 @@
> > >  from .base import SecFlavor, SecError
> > >  from rpc.rpc_const import AUTH_SYS
> > >  from rpc.rpc_type import opaque_auth
> > > -from xdrlib3 import Packer, Error
> > > +import struct
> > > +
> > > +try:
> > > +    from xdrlib3 import Packer, Error
> > > +except:
> > > +    from xdrlib import Packer, Error
>=20
> > >  class SecAuthSys(SecFlavor):
> > >      # XXX need better defaults
> > > diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> > > index 2337d8c..92b3c11 100644
> > > --- a/nfs4.0/nfs4lib.py
> > > +++ b/nfs4.0/nfs4lib.py
> > > @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
> > >  from  xdrdef.nfs4_const import *
> > >  import xdrdef.nfs4_type as nfs4_type
> > >  from xdrdef.nfs4_type import *
> > > -from xdrlib3 import Error as XDRError
> > >  import xdrdef.nfs4_pack as nfs4_pack
>=20
> > > +try:
> > > +    from xdrlib3 import Error as XDRError
> > > +except:
> > > +    from xdrlib import Error as XDRError
> > > +
> > >  import nfs_ops
> > >  op4 =3D nfs_ops.NFS4ops()
>=20
> > > diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> > > index 10bf28e..e26cecd 100755
> > > --- a/nfs4.0/nfs4server.py
> > > +++ b/nfs4.0/nfs4server.py
> > > @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
> > >  import StringIO
> > >  import nfs4state
> > >  from nfs4state import NFS4Error, printverf
> > > -from xdrlib3 import Error as XDRError
> > > +
> > > +try:
> > > +    from xdrlib3 import Error as XDRError
> > > +except:
> > > +    from xdrlib import Error as XDRError
>=20
> > >  unacceptable_names =3D [ "", ".", ".." ]
> > >  unacceptable_characters =3D [ "/", "~", "#", ]
> > > diff --git a/rpc/security.py b/rpc/security.py
> > > index 789280c..79e746b 100644
> > > --- a/rpc/security.py
> > > +++ b/rpc/security.py
> > > @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GS=
S, SUCCESS, CALL, \
> > >  from .rpc_type import opaque_auth, authsys_parms
> > >  from .rpc_pack import RPCPacker, RPCUnpacker
> > >  from .gss_pack import GSSPacker, GSSUnpacker
> > > -from xdrlib3 import Packer, Unpacker
> > >  from . import rpclib
> > >  from .gss_const import *
> > >  from . import gss_type
> > > @@ -17,6 +16,11 @@ except ImportError:
> > >  import threading
> > >  import logging
>=20
> > > +try:
> > > +    from xdrlib3 import Packer, Unpacker
> > > +except:
> > > +    from xdrlib import Packer, Unpacker
> > > +
> > >  log_gss =3D logging.getLogger("rpc.sec.gss")
> > >  log_gss.setLevel(logging.INFO)
>=20
> > > diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> > > index f802ba8..970ae9d 100755
> > > --- a/xdr/xdrgen.py
> > > +++ b/xdr/xdrgen.py
> > > @@ -1357,8 +1357,13 @@ pack_header =3D """\
> > >  import sys,os
> > >  from . import %s as const
> > >  from . import %s as types
> > > -import xdrlib3 as xdrlib
> > > -from xdrlib3 import Error as XDRError
> > > +
> > > +try:
> > > +    import xdrlib3 as xdrlib
> > > +    from xdrlib3 import Error as XDRError
> > > +except:
> > > +    import xdrlib as xdrlib
> > > +    from xdrlib import Error as XDRError
>=20
> > >  class nullclass(object):
> > >      pass
>=20
> > Acked-by: Jeff Layton <jlayton@kernel.org>

Ok, I don't have any objection to the patch. I was just curious as to
whether SuSE had some problem using pip for this.

Acked-by: Jeff Layton <jlayton@kernel.org>

