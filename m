Return-Path: <linux-nfs+bounces-10063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C407EA3312E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5256D1883430
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC61EE013;
	Wed, 12 Feb 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="koeuZ6nR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qlc50NQD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="koeuZ6nR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qlc50NQD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB401E260C
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394109; cv=none; b=CyQi8Md9zRH+btb+HlvWEVvpMtplx87Rb4NnAnHufx3KY/CS88SAj0x2rnhXgML1/bkQQlXuU1z5ZZst5omK/0FYWj7y9aVKcDM9lioR8wwDp9I69dT0MHcShDkeeE1bDWkdUKQAh+YiLJIwB5S6dQLROOsysIuWDJzKDymfqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394109; c=relaxed/simple;
	bh=+YwEX86hmukfUVcNZShrTD4sURDIU4AxNcKgt/UtqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQHqtVTM/5pbycu17BAyPVqnF21xXuxGswvmjUEYi4KALWYZRA4o1EMfx22kT11ljAYtdfU8ueuKXcPoK4D5Gy5hB5rUkkN/VvIN3EUO8Fnxt9TA2UXqLoBokIRFGr/XaRioYNkLl9Z0p7JPe7v5CgCH461ZENVMmPVtZDtkdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=koeuZ6nR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qlc50NQD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=koeuZ6nR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qlc50NQD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 81FB61F44E;
	Wed, 12 Feb 2025 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739394105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dXY0nUFSoulcgkTrF6eAsrE94yuNkAxQiu7oX+6HNU=;
	b=koeuZ6nRl7Wpt8H75MKVid6Wt+eZMC9CkIEL4MvLMzR+hcDvVJbTXMbd2Mc4yy4Q69K57A
	aKZGZ5VkQX+bZ+RdSmzs3VVojwFHv+/rNYA6M0RyLrQ8HUqYa4+F4udpwGPHRc1ZXerjud
	xV5tIh5hqtaG/Es+9U6+ILN2M8IZhQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739394105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dXY0nUFSoulcgkTrF6eAsrE94yuNkAxQiu7oX+6HNU=;
	b=Qlc50NQDYHfJMpSG4+tTrvdFMEobBu2fZcpK9aveSq5EDRp9HBZzer/xk2GhR69OBYyUMO
	EOmrruDb/Jn5k6CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=koeuZ6nR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qlc50NQD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739394105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dXY0nUFSoulcgkTrF6eAsrE94yuNkAxQiu7oX+6HNU=;
	b=koeuZ6nRl7Wpt8H75MKVid6Wt+eZMC9CkIEL4MvLMzR+hcDvVJbTXMbd2Mc4yy4Q69K57A
	aKZGZ5VkQX+bZ+RdSmzs3VVojwFHv+/rNYA6M0RyLrQ8HUqYa4+F4udpwGPHRc1ZXerjud
	xV5tIh5hqtaG/Es+9U6+ILN2M8IZhQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739394105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dXY0nUFSoulcgkTrF6eAsrE94yuNkAxQiu7oX+6HNU=;
	b=Qlc50NQDYHfJMpSG4+tTrvdFMEobBu2fZcpK9aveSq5EDRp9HBZzer/xk2GhR69OBYyUMO
	EOmrruDb/Jn5k6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 459B013874;
	Wed, 12 Feb 2025 21:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0UjvDzkMrWeHMgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 21:01:45 +0000
Date: Wed, 12 Feb 2025 22:01:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Michael Moese <mmoese@suse.com>
Subject: Re: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
Message-ID: <20250212210135.GA2141194@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250212132346.2043091-1-pvorel@suse.cz>
 <0b73e27f-9b1f-4840-af10-b687c90759ad@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b73e27f-9b1f-4840-af10-b687c90759ad@oracle.com>
X-Spam-Level: *
X-Spamd-Result: default: False [1.09 / 50.00];
	RSPAMD_URIBL(4.50)[logging.info:url];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: 1.09
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 81FB61F44E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO

> On 12/02/2025 1:23 pm, Petr Vorel wrote:
> > On certain environments it might be difficult to install xdrlib3 via pip
> > (e.g. python 3.11, which is a default on current Tumbleweed).

> > Fixes: dfb0b07 ("Move to xdrlib3")
> > Suggested-by: Michael Moese <mmoese@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > I admit it would be safer to check if python is really < 3.13.

> > Kind regards,
> > Petr

> >   README                                | 2 ++
> >   nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
> >   nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
> >   nfs4.0/nfs4lib.py                     | 6 +++++-
> >   nfs4.0/nfs4server.py                  | 6 +++++-
> >   rpc/security.py                       | 6 +++++-
> >   xdr/xdrgen.py                         | 9 +++++++--
> >   7 files changed, 35 insertions(+), 7 deletions(-)

> > diff --git a/README b/README
> > index 8c3ac27..d5214b4 100644
> > --- a/README
> > +++ b/README
> > @@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:
> >   	pip install xdrlib3
> > +If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).

> It sounds a little like the above is an instruction for the user; if you
> don't mind I'll fix this up, adding "the code will fallback…", just to make
> it obvious?

Yes, please, fix it.

> Thanks for the fix Petr, I'll get this in today.

Thanks a lot for accepting this. FYI we test with pynfs also various SLES kernels
(including very old ones), which obviously have older python3. Probably on all
would xdrlib3 installation via pip+virtualenv worked, but safest way is to avoid
it and use python stock xdrlib.

Kind regards,
Petr

> cheers,
> c.



> > +
> >   You can prepare both versions for use with
> >   	./setup.py build
> > diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> > index 4751790..7a80241 100644
> > --- a/nfs4.0/lib/rpc/rpc.py
> > +++ b/nfs4.0/lib/rpc/rpc.py
> > @@ -9,12 +9,16 @@
> >   from __future__ import absolute_import
> >   import struct
> > -import xdrlib3 as xdrlib
> >   import socket
> >   import select
> >   import threading
> >   import errno
> > +try:
> > +    import xdrlib3 as xdrlib
> > +except:
> > +    import xdrlib
> > +
> >   from rpc.rpc_const import *
> >   from rpc.rpc_type import *
> >   import rpc.rpc_pack as rpc_pack
> > diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > index 2581a1e..41c6d54 100644
> > --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> > @@ -1,7 +1,12 @@
> >   from .base import SecFlavor, SecError
> >   from rpc.rpc_const import AUTH_SYS
> >   from rpc.rpc_type import opaque_auth
> > -from xdrlib3 import Packer, Error
> > +import struct
> > +
> > +try:
> > +    from xdrlib3 import Packer, Error
> > +except:
> > +    from xdrlib import Packer, Error
> >   class SecAuthSys(SecFlavor):
> >       # XXX need better defaults
> > diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> > index 2337d8c..92b3c11 100644
> > --- a/nfs4.0/nfs4lib.py
> > +++ b/nfs4.0/nfs4lib.py
> > @@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
> >   from  xdrdef.nfs4_const import *
> >   import xdrdef.nfs4_type as nfs4_type
> >   from xdrdef.nfs4_type import *
> > -from xdrlib3 import Error as XDRError
> >   import xdrdef.nfs4_pack as nfs4_pack
> > +try:
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    from xdrlib import Error as XDRError
> > +
> >   import nfs_ops
> >   op4 = nfs_ops.NFS4ops()
> > diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> > index 10bf28e..e26cecd 100755
> > --- a/nfs4.0/nfs4server.py
> > +++ b/nfs4.0/nfs4server.py
> > @@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
> >   import StringIO
> >   import nfs4state
> >   from nfs4state import NFS4Error, printverf
> > -from xdrlib3 import Error as XDRError
> > +
> > +try:
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    from xdrlib import Error as XDRError
> >   unacceptable_names = [ "", ".", ".." ]
> >   unacceptable_characters = [ "/", "~", "#", ]
> > diff --git a/rpc/security.py b/rpc/security.py
> > index 789280c..79e746b 100644
> > --- a/rpc/security.py
> > +++ b/rpc/security.py
> > @@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
> >   from .rpc_type import opaque_auth, authsys_parms
> >   from .rpc_pack import RPCPacker, RPCUnpacker
> >   from .gss_pack import GSSPacker, GSSUnpacker
> > -from xdrlib3 import Packer, Unpacker
> >   from . import rpclib
> >   from .gss_const import *
> >   from . import gss_type
> > @@ -17,6 +16,11 @@ except ImportError:
> >   import threading
> >   import logging
> > +try:
> > +    from xdrlib3 import Packer, Unpacker
> > +except:
> > +    from xdrlib import Packer, Unpacker
> > +
> >   log_gss = logging.getLogger("rpc.sec.gss")
> >   log_gss.setLevel(logging.INFO)
> > diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> > index f802ba8..970ae9d 100755
> > --- a/xdr/xdrgen.py
> > +++ b/xdr/xdrgen.py
> > @@ -1357,8 +1357,13 @@ pack_header = """\
> >   import sys,os
> >   from . import %s as const
> >   from . import %s as types
> > -import xdrlib3 as xdrlib
> > -from xdrlib3 import Error as XDRError
> > +
> > +try:
> > +    import xdrlib3 as xdrlib
> > +    from xdrlib3 import Error as XDRError
> > +except:
> > +    import xdrlib as xdrlib
> > +    from xdrlib import Error as XDRError
> >   class nullclass(object):
> >       pass



