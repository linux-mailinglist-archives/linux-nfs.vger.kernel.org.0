Return-Path: <linux-nfs+bounces-10051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A71A326E0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1F2164FD8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1320ED;
	Wed, 12 Feb 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nk8BnrcK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SGeYHgTp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nk8BnrcK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SGeYHgTp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD646209F58
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366644; cv=none; b=Uv8H5FnEqiJXTBAquwhLf3G3tgFcw05QqUetTLwVWFZ9PPrOKzHqbnN8/vcSNVbQJ6J8owAk5P/AB4vx2zWs8Af+Wk9wWrBFs3zn6LOSaTdKHFl3quVxco1BvvIj66dAgv+0vTyYrgZb1lid8zv1xXHVwoQ+93xeQW6eChjjg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366644; c=relaxed/simple;
	bh=OzBWtOcaAguL7XUeNlAlO0mAoLU6lIpQNqnQMpZvn+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUEzEfadF7nVD6fZhUm38B1XwTpocN+oPZg4nAXN/pnhjaFwpRjyZzn2JaVSd7m+r5gcLzDbdrYdhXsE2AEu7fxCgr+UkSVARsTGJ8//uGygwalq16sG0uoDrHShfTCLIGAJC0jEc1jeBcQQHjZywTbUMVGbomdakq/agE/XahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nk8BnrcK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SGeYHgTp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nk8BnrcK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SGeYHgTp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EB823370C;
	Wed, 12 Feb 2025 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UYq3T4qK5Hafq12htuskV/pBljetV216IHPuNc0piyc=;
	b=Nk8BnrcKdcJqZgTcfm8ZL7j9xgauqeMEWYyjdvZIXqi9aIVUAmp6Zd5NIgj4YSUFHUY7m5
	Vix+p0KVdFmmurYoMsmfSnLQ1fFaucK7GfG/mNnYRZ8Jw3UlnkOpnZZV6DyJq8abuaWoK8
	rx+IGQVpwDFDiEs3QTXni/ZiA+pGV9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UYq3T4qK5Hafq12htuskV/pBljetV216IHPuNc0piyc=;
	b=SGeYHgTpS7Qlv8iY8pRirLoIJIByPMdS3991J17D91bFBTB0vhnNKUxlYFCoH/QLLeDNGy
	DACLPr06f3cKz1BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nk8BnrcK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SGeYHgTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739366635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UYq3T4qK5Hafq12htuskV/pBljetV216IHPuNc0piyc=;
	b=Nk8BnrcKdcJqZgTcfm8ZL7j9xgauqeMEWYyjdvZIXqi9aIVUAmp6Zd5NIgj4YSUFHUY7m5
	Vix+p0KVdFmmurYoMsmfSnLQ1fFaucK7GfG/mNnYRZ8Jw3UlnkOpnZZV6DyJq8abuaWoK8
	rx+IGQVpwDFDiEs3QTXni/ZiA+pGV9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739366635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UYq3T4qK5Hafq12htuskV/pBljetV216IHPuNc0piyc=;
	b=SGeYHgTpS7Qlv8iY8pRirLoIJIByPMdS3991J17D91bFBTB0vhnNKUxlYFCoH/QLLeDNGy
	DACLPr06f3cKz1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 259BF13AEF;
	Wed, 12 Feb 2025 13:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqqqB+ugrGecGgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 13:23:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Calum Mackay <calum.mackay@oracle.com>,
	Michael Moese <mmoese@suse.com>
Subject: [PATCH 1/1] Allow to fallback to xdrlib if xdrlib3 not available
Date: Wed, 12 Feb 2025 14:23:46 +0100
Message-ID: <20250212132346.2043091-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Result: default: False [1.79 / 50.00];
	RSPAMD_URIBL(4.50)[logging.info:url];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Spam-Score: 1.79
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 4EB823370C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO

On certain environments it might be difficult to install xdrlib3 via pip
(e.g. python 3.11, which is a default on current Tumbleweed).

Fixes: dfb0b07 ("Move to xdrlib3")
Suggested-by: Michael Moese <mmoese@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I admit it would be safer to check if python is really < 3.13.

Kind regards,
Petr

 README                                | 2 ++
 nfs4.0/lib/rpc/rpc.py                 | 6 +++++-
 nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 7 ++++++-
 nfs4.0/nfs4lib.py                     | 6 +++++-
 nfs4.0/nfs4server.py                  | 6 +++++-
 rpc/security.py                       | 6 +++++-
 xdr/xdrgen.py                         | 9 +++++++--
 7 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 8c3ac27..d5214b4 100644
--- a/README
+++ b/README
@@ -19,6 +19,8 @@ python3-standard-xdrlib) or you may install it via pip:
 
 	pip install xdrlib3
 
+If xdrlib3 is not available fallback to old xdrlib (useful for python < 3.13).
+
 You can prepare both versions for use with
 
 	./setup.py build
diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index 4751790..7a80241 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -9,12 +9,16 @@
 
 from __future__ import absolute_import
 import struct
-import xdrlib3 as xdrlib
 import socket
 import select
 import threading
 import errno
 
+try:
+    import xdrlib3 as xdrlib
+except:
+    import xdrlib
+
 from rpc.rpc_const import *
 from rpc.rpc_type import *
 import rpc.rpc_pack as rpc_pack
diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
index 2581a1e..41c6d54 100644
--- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
+++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
@@ -1,7 +1,12 @@
 from .base import SecFlavor, SecError
 from rpc.rpc_const import AUTH_SYS
 from rpc.rpc_type import opaque_auth
-from xdrlib3 import Packer, Error
+import struct
+
+try:
+    from xdrlib3 import Packer, Error
+except:
+    from xdrlib import Packer, Error
 
 class SecAuthSys(SecFlavor):
     # XXX need better defaults
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 2337d8c..92b3c11 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -41,9 +41,13 @@ import xdrdef.nfs4_const as nfs4_const
 from  xdrdef.nfs4_const import *
 import xdrdef.nfs4_type as nfs4_type
 from xdrdef.nfs4_type import *
-from xdrlib3 import Error as XDRError
 import xdrdef.nfs4_pack as nfs4_pack
 
+try:
+    from xdrlib3 import Error as XDRError
+except:
+    from xdrlib import Error as XDRError
+
 import nfs_ops
 op4 = nfs_ops.NFS4ops()
 
diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
index 10bf28e..e26cecd 100755
--- a/nfs4.0/nfs4server.py
+++ b/nfs4.0/nfs4server.py
@@ -34,7 +34,11 @@ import time, StringIO, random, traceback, codecs
 import StringIO
 import nfs4state
 from nfs4state import NFS4Error, printverf
-from xdrlib3 import Error as XDRError
+
+try:
+    from xdrlib3 import Error as XDRError
+except:
+    from xdrlib import Error as XDRError
 
 unacceptable_names = [ "", ".", ".." ]
 unacceptable_characters = [ "/", "~", "#", ]
diff --git a/rpc/security.py b/rpc/security.py
index 789280c..79e746b 100644
--- a/rpc/security.py
+++ b/rpc/security.py
@@ -3,7 +3,6 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
 from .rpc_type import opaque_auth, authsys_parms
 from .rpc_pack import RPCPacker, RPCUnpacker
 from .gss_pack import GSSPacker, GSSUnpacker
-from xdrlib3 import Packer, Unpacker
 from . import rpclib
 from .gss_const import *
 from . import gss_type
@@ -17,6 +16,11 @@ except ImportError:
 import threading
 import logging
 
+try:
+    from xdrlib3 import Packer, Unpacker
+except:
+    from xdrlib import Packer, Unpacker
+
 log_gss = logging.getLogger("rpc.sec.gss")
 log_gss.setLevel(logging.INFO)
 
diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
index f802ba8..970ae9d 100755
--- a/xdr/xdrgen.py
+++ b/xdr/xdrgen.py
@@ -1357,8 +1357,13 @@ pack_header = """\
 import sys,os
 from . import %s as const
 from . import %s as types
-import xdrlib3 as xdrlib
-from xdrlib3 import Error as XDRError
+
+try:
+    import xdrlib3 as xdrlib
+    from xdrlib3 import Error as XDRError
+except:
+    import xdrlib as xdrlib
+    from xdrlib import Error as XDRError
 
 class nullclass(object):
     pass
-- 
2.47.2


