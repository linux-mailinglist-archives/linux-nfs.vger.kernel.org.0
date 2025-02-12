Return-Path: <linux-nfs+bounces-10055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1EA32779
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7003A1417
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9427181F;
	Wed, 12 Feb 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oxGdIoYf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NC6JZza7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bMAnVIVI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0h0KsQZJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422520ED
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368043; cv=none; b=g8Nww+ygiJEl0jHEv7uJm9TYnHNouIvfqWUZ602xZ6IHFN1wAQhh6UM3N582+WLUgDRRrBfFjpGg/wG87eT56jO83N0Beltuhuz6eL+iDRjUfx8i9AsjwqrhfZ4pi6eLPa/D5u5TIsB5hCwELANjMI8PWD+WT577NH+eJzUkP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368043; c=relaxed/simple;
	bh=WR7BYjkS7Rl5VZOijKX3G36y7QdFgZp0059lnsg/dXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaqbTIiOVBXk08SdNRYzldqiklQ0EHOcQ5KYYfFRjx5YSEMoSoms7qs8IeGPZ3joWSIxTvhuKlz4G9oAO7XxhZGSqJLmPN8Ns1RyTqoQcSddzSEe1ELx5mEzMAAgy581s+SeJxuoNdOkl0SuaMkC6DI55y8VFhDdluflC/VGf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oxGdIoYf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NC6JZza7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bMAnVIVI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0h0KsQZJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3DF622160;
	Wed, 12 Feb 2025 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739368039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOhaX5hOw86q7djlHKSMUhsU1r3eOLpfu5MMqFUHwFA=;
	b=oxGdIoYfc4GOfQ7l95RCgCUToQc5xE7vL+EUajY/izPDgYiQWmnRrgqijb5SCePOhqhUhH
	fmjT7L/YAbIlXHO7C0n2YTA/1MY34+RkEINPUB7F/KZldhIWeKIfRGtLmBPwSr16qP4qnk
	a+5xRPCHvoOB5b9BaEsNBesVAc7d5/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739368039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOhaX5hOw86q7djlHKSMUhsU1r3eOLpfu5MMqFUHwFA=;
	b=NC6JZza7v4mtkT00U52DEYBJVMdNBfKXWY2ULeqYuT6jhxywnT6L8TdZaJf07I/9XZyAjc
	XFmverpZwX8N4MBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bMAnVIVI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0h0KsQZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739368038;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOhaX5hOw86q7djlHKSMUhsU1r3eOLpfu5MMqFUHwFA=;
	b=bMAnVIVIG95TzjlXZYOkFQE0W1S7hEAYr0NXeipR5sm6sBL7Ft3ALndOMYDnG/4J7LGxLR
	srPVgbEU+aKl992l7CLKRhHvAKUOjSBA5ZWruqZwzbmcQgnKAwJOYhjyLI8LGpkI68DxB2
	twykJmwQUuT7FBXGkYasDPCkS77IQ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739368038;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOhaX5hOw86q7djlHKSMUhsU1r3eOLpfu5MMqFUHwFA=;
	b=0h0KsQZJHqx0N/WjZEDvDhWkHDmthHcDbmkFdphO82mSYp1WguzJt6iY3VTbJ6EXBHc8Ox
	O4aP9hL6V7IYiUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B71613AEF;
	Wed, 12 Feb 2025 13:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OSQxHWamrGcGIwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 13:47:18 +0000
Date: Wed, 12 Feb 2025 14:47:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Calum Mackay <calum.mackay@oracle.com>,
	Michael Moese <mmoese@suse.com>
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
Message-ID: <20250212134713.GA2044610@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250212132346.2043091-1-pvorel@suse.cz>
 <31e2b01ff9b3b4fbd370419f31886cd4a2a933ba.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e2b01ff9b3b4fbd370419f31886cd4a2a933ba.camel@kernel.org>
X-Spamd-Result: default: False [1.09 / 50.00];
	RSPAMD_URIBL(4.50)[logging.info:url];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,logging.info:url,suse.com:email,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.09
X-Rspamd-Queue-Id: A3DF622160
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +
X-Spam-Level: *

Hi Jeff,

> On Wed, 2025-02-12 at 14:23 +0100, Petr Vorel wrote:
> > On certain environments it might be difficult to install xdrlib3 via pip
> > (e.g. python 3.11, which is a default on current Tumbleweed).


> I did a "pip install xdrlib3" on Fedora 33 just now, and it has python
> 3.9. What's the problem you're seeing with SuSE installing it with
> v3.11?

Yesterday I did not notice missing ply, I saw only missing xdrgen
(xdr/xdrgen.py). Therefore I thought that virtualenv is mangling PYTHONPATH.
Obviously installing ply with pip would be enough.

I also thing using a fallback saves the need to use virtualenv on old distros,
therefore I would prefer this patch to be accepted. If it's not accepted, it
might be worth to extend info about dependencies.

Kind regards,
Petr

$ python3 --version
Python 3.11.11

# pip install xdrlib3

[notice] A new release of pip is available: 24.3.1 -> 25.0.1
[notice] To update, run: pip install --upgrade pip
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try
    zypper install python311-xyz, where xyz is the package
    you are trying to install.
...

=> let's use virtualenv

# python3 -m virtualenv .venv && . .venv/bin/activate
created virtual environment CPython3.11.11.final.0-64 in 1466ms
  creator CPython3Posix(dest=/root/pynfs/.venv, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==24.3.1, setuptools==75.8.0, wheel==0.45.1, xdrlib3==0.1.1
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

# pip install xdrlib3
Requirement already satisfied: xdrlib3 in ./.venv/lib/python3.11/site-packages (0.1.1)

# ./setup.py build
Moving to xdr


Moving to rpc
Traceback (most recent call last):
  File "/root/pynfs/rpc/./setup.py", line 15, in <module>
    import xdrgen
ModuleNotFoundError: No module named 'xdrgen'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/root/pynfs/rpc/./setup.py", line 18, in <module>
    import xdrgen
  File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
    import ply.lex as lex
ModuleNotFoundError: No module named 'ply'

Moving to nfs4.1
Traceback (most recent call last):
  File "/root/pynfs/nfs4.1/./setup.py", line 15, in <module>
    import xdrgen
ModuleNotFoundError: No module named 'xdrgen'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/root/pynfs/nfs4.1/./setup.py", line 18, in <module>
    import xdrgen
  File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
    import ply.lex as lex
ModuleNotFoundError: No module named 'ply'

Moving to nfs4.0
/root/pynfs/nfs4.0/./setup.py:7: DeprecationWarning: dep_util is Deprecated. Use functions from setuptools instead.
  from distutils.dep_util import newer_group
Traceback (most recent call last):
  File "/root/pynfs/nfs4.0/./setup.py", line 11, in <module>
    import xdrgen
ModuleNotFoundError: No module named 'xdrgen'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/root/pynfs/nfs4.0/./setup.py", line 14, in <module>
    import xdrgen
  File "/root/pynfs/xdr/xdrgen.py", line 235, in <module>
    import ply.lex as lex
ModuleNotFoundError: No module named 'ply'

# pip install ply # this fixes it

> BTW, does SuSE have the xdrlib3 module available as a package?

> > Fixes: dfb0b07 ("Move to xdrlib3")
> > Suggested-by: Michael Moese <mmoese@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > I admit it would be safer to check if python is really < 3.13.

> > Kind regards,
> > Petr

> >  README                                | 2 ++
> >  nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
> >  nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
> >  nfs4.0/nfs4lib.py                     | 6 +++++-
> >  nfs4.0/nfs4server.py                  | 6 +++++-
> >  rpc/security.py                       | 6 +++++-
> >  xdr/xdrgen.py                         | 9 +++++++--
> >  7 files changed, 35 insertions(+), 7 deletions(-)

> > diff --git a/README b/README
> > index 8c3ac27..d5214b4 100644
> > --- a/README
> > +++ b/README
> > @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:

> >  	pip install xdrlib3

> > +If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).
> > +
> >  You can prepare both versions for use with

> >  	./setup.py build
> > diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> > index 4751790..7a80241 100644
> > --- a/nfs4.0/lib/rpc/rpc.py
> > +++ b/nfs4.0/lib/rpc/rpc.py
> > @@ -9,12 +9,16 @@

> >  from __future__ import absolute_import
> >  import struct
> > -import xdrlib3 as xdrlib
> >  import socket
> >  import select
> >  import threading
> >  import errno

> > +try:
> > +    import xdrlib3 as xdrlib
> > +except:
> > +    import xdrlib
> > +
> >  from rpc.rpc_const import *
> >  from rpc.rpc_type import *
> >  import rpc.rpc_pack as rpc_pack
> > diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > index 2581a1e..41c6d54 100644
> > --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > @@ -1,7 +1,12 @@
> >  from .base import SecFlavor, SecError
> >  from rpc.rpc_const import AUTH_SYS
> >  from rpc.rpc_type import opaque_auth
> > -from xdrlib3 import Packer, Error
> > +import struct
> > +
> > +try:
> > +    from xdrlib3 import Packer, Error
> > +except:
> > +    from xdrlib import Packer, Error

> >  class SecAuthSys(SecFlavor):
> >      # XXX need better defaults
> > diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> > index 2337d8c..92b3c11 100644
> > --- a/nfs4.0/nfs4lib.py
> > +++ b/nfs4.0/nfs4lib.py
> > @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
> >  from  xdrdef.nfs4_const import *
> >  import xdrdef.nfs4_type as nfs4_type
> >  from xdrdef.nfs4_type import *
> > -from xdrlib3 import Error as XDRError
> >  import xdrdef.nfs4_pack as nfs4_pack

> > +try:
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    from xdrlib import Error as XDRError
> > +
> >  import nfs_ops
> >  op4 = nfs_ops.NFS4ops()

> > diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> > index 10bf28e..e26cecd 100755
> > --- a/nfs4.0/nfs4server.py
> > +++ b/nfs4.0/nfs4server.py
> > @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
> >  import StringIO
> >  import nfs4state
> >  from nfs4state import NFS4Error, printverf
> > -from xdrlib3 import Error as XDRError
> > +
> > +try:
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    from xdrlib import Error as XDRError

> >  unacceptable_names = [ "", ".", ".." ]
> >  unacceptable_characters = [ "/", "~", "#", ]
> > diff --git a/rpc/security.py b/rpc/security.py
> > index 789280c..79e746b 100644
> > --- a/rpc/security.py
> > +++ b/rpc/security.py
> > @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
> >  from .rpc_type import opaque_auth, authsys_parms
> >  from .rpc_pack import RPCPacker, RPCUnpacker
> >  from .gss_pack import GSSPacker, GSSUnpacker
> > -from xdrlib3 import Packer, Unpacker
> >  from . import rpclib
> >  from .gss_const import *
> >  from . import gss_type
> > @@ -17,6 +16,11 @@ except ImportError:
> >  import threading
> >  import logging

> > +try:
> > +    from xdrlib3 import Packer, Unpacker
> > +except:
> > +    from xdrlib import Packer, Unpacker
> > +
> >  log_gss = logging.getLogger("rpc.sec.gss")
> >  log_gss.setLevel(logging.INFO)

> > diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> > index f802ba8..970ae9d 100755
> > --- a/xdr/xdrgen.py
> > +++ b/xdr/xdrgen.py
> > @@ -1357,8 +1357,13 @@ pack_header = """\
> >  import sys,os
> >  from . import %s as const
> >  from . import %s as types
> > -import xdrlib3 as xdrlib
> > -from xdrlib3 import Error as XDRError
> > +
> > +try:
> > +    import xdrlib3 as xdrlib
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    import xdrlib as xdrlib
> > +    from xdrlib import Error as XDRError

> >  class nullclass(object):
> >      pass

> Acked-by: Jeff Layton <jlayton@kernel.org>

