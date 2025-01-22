Return-Path: <linux-nfs+bounces-9479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F93A19740
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD593AA409
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC131BEF79;
	Wed, 22 Jan 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO9szfVq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EFC74C14
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566041; cv=none; b=BXuQ3Ax8zTqXxZvyKJiGgvgJEDZAEZR9JBJA4jROJ07jWYCFkuIR6ayv4girgW6hgSBppejafe1LnLuzPYDzkHLZ3iwOBllNuoNTXl8oYLAE//9zJUg+VZ396zv92rfHWNS5eVvlPVaUGzJG6uHvQ7arAA+SZGJnYMf1C0LYYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566041; c=relaxed/simple;
	bh=83jz6n7zZ7PM0z70seJ3iIseZ0KsZY3abKHIyLzBlKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q2lamVb6bdyKwWwp404cpAGQ4K5qte84XkztXNREPL/RmlUT46xc7IOiqMQmKFtu/wDOQpDOuigxhiVioNVkRdCaxNd8QP3QHlUX3FUufcTRSyKhECyD7tKwlv7JV8la/ZpnORiUAjQxumF8FGjW6LRc0BubBxo3UFVT+VVF6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO9szfVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA6C4CED2;
	Wed, 22 Jan 2025 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737566041;
	bh=83jz6n7zZ7PM0z70seJ3iIseZ0KsZY3abKHIyLzBlKc=;
	h=From:Date:Subject:To:Cc:From;
	b=cO9szfVqdbahFIbLr7DR3LPXiSCTlONrt9NDF26WKqFmnWf9Bxuh6NbIcr2p4l3U3
	 cdAFt+aJXlODkMqHSJqbDBi7zj7bU0lQqVMSBqj8YYnCCRjLV9V5y1TG+kW5PbDhow
	 2jSO0BVskRTUHnP2v/ImTMaARs2rAZPO0nX3kdWf4x6Trtwj47KNsCL3Hioee/nIAF
	 HKm3lI7VkshwhVsSMpjBO5ZkXiZ4Zkl3Z9u+OHIUvvEs3z2uhnporeXwraNBBJPO+d
	 1rnR0XPNF4uKDpUzNX4DgSFjLGxc/A3WWP5LCgFwnAX2FSTTrccmatmPYrYOC1Ydu8
	 1L43HXwF3XvsQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 22 Jan 2025 12:13:54 -0500
Subject: [PATCH pynfs] Move to xdrlib3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFEnkWcC/x3MMQqAMAxA0auUzBZs0FK8ijgUTTWDVRIRRby7x
 fHB5z+gJEwKnXlA6GTlLRe4ysC4xDyT5akYsMa2doh2jXqQWB8a11BIfmoTlHgXSnz9ox72Oye
 F4X0/v0hqQ18AAAA=
X-Change-ID: 20250122-master-68414e8f6d5f
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=83jz6n7zZ7PM0z70seJ3iIseZ0KsZY3abKHIyLzBlKc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkSdY3P6erHcB2FJNYBgs2tLFZlIauGMehbN3z
 x0iLXIun9CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5EnWAAKCRAADmhBGVaC
 FVRDD/9vqVlxn87VxsqcQGvi/dQWmr0d0bB5/boGPhtSn5v22vBBAkcW4Wgb50khbCVZGDVKhHC
 hsnnk6PuQ+N+QFyE6lCQu7Ek6VuhqtK2HCNwxDhCXdcT71iJBoLi6dDP4WO0apG4geqqkGtKVlt
 ixWnmF46oUeafMubvKCFOonJjZY79/BovmbaZckEYO1BBe5JCX2hbOrVXEPmE7mO+ZVIXs5rL6b
 yG/Kohr90gMtVGyB/X8VuKl0w6NzOzVy5c9inDDlceCgC8G4X8P4v+hL5x1S6dkE1oTWjwRNqs1
 kaIbsieBBkyVavo9P6eQsrVeb51BQ2NfovJ1NzKoeSfPebjObMg6sOpTcfDrCeIRq9J90ccBDOl
 HqRDUNSYHpCkj8cgQVy9iA6RViHK4alG4TPAkq0W3GcDJxjLBAbpPchga0Q6ITQ93h6wnPFhBg5
 yVMY8qLRNLF+MaXwlJRKkSgtWhMFwvdsi9YHv8XkrVgvV/X0E7cHYKFLpZf1+hhuDuuSXH8o/lz
 E2eSrXrAydRPOdW2UCq9X0VhSNeUuOI6bt638lxdqIrv/9AUSe/D5+Ny5TjkYF9RwZSIdCCSDWE
 0vu7D4SqEf0rovgSmzaD8gXIS2+nBNvolmAwfNOmY8GBG5swJ9yuovuLXD46/vMS6/i7rnf2Wjb
 wE+GqGvLK5nFAOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As of python 3.13, the xdrlib module is no longer included. Fortunately
there is an xdrlib3 module, which is a fork of the bundled module:

    https://pypi.org/project/xdrlib3/

Change pynfs to use that instead and revise the documentation to include
a step to install that module.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 README                                | 8 +++++++-
 nfs4.0/lib/rpc/rpc.py                 | 2 +-
 nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 2 +-
 nfs4.0/nfs4lib.py                     | 2 +-
 nfs4.0/nfs4server.py                  | 2 +-
 rpc/security.py                       | 2 +-
 xdr/xdrgen.py                         | 4 ++--
 7 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/README b/README
index b8b4e775f7766086f870f2dda4a60b3e9f9bac6f..efdc23807e8107b8fcd575e8a4c80b9c73e3cd07 100644
--- a/README
+++ b/README
@@ -14,8 +14,14 @@ Install dependent modules:
 * openSUSE
 	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
 
-You can prepare both for use with
+Install the xdrlib3 module:
+
+	pip install xdrlib3
+
+You can prepare both versions for use with
+
 	./setup.py build
+
 which will create auto-generated files and compile any shared libraries
 in place.
 
diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index 243ef9e31aa83eb6be18800065b63cf78d99f833..475179042530a8d602a51e7bad1af7958ff5dd56 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -9,7 +9,7 @@
 
 from __future__ import absolute_import
 import struct
-import xdrlib
+import xdrlib3 as xdrlib
 import socket
 import select
 import threading
diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
index 1e990a369e6588f24dff75e9569c104d775ff710..2581a1e1dca22f637dc32144a05c88c66c57665e 100644
--- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
+++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
@@ -1,7 +1,7 @@
 from .base import SecFlavor, SecError
 from rpc.rpc_const import AUTH_SYS
 from rpc.rpc_type import opaque_auth
-from xdrlib import Packer, Error
+from xdrlib3 import Packer, Error
 
 class SecAuthSys(SecFlavor):
     # XXX need better defaults
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index eddcd862bc2fe2061414fb4de61e52aed93495ae..2337d8cd190de90e4d158b3ef9e3dfd6a61027c5 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -41,7 +41,7 @@ import xdrdef.nfs4_const as nfs4_const
 from  xdrdef.nfs4_const import *
 import xdrdef.nfs4_type as nfs4_type
 from xdrdef.nfs4_type import *
-from xdrlib import Error as XDRError
+from xdrlib3 import Error as XDRError
 import xdrdef.nfs4_pack as nfs4_pack
 
 import nfs_ops
diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
index 2dbad3046709ea57c1503a36649d85c25e6301a8..10bf28ee5794684912fa8e6d19406e06bf88b742 100755
--- a/nfs4.0/nfs4server.py
+++ b/nfs4.0/nfs4server.py
@@ -34,7 +34,7 @@ import time, StringIO, random, traceback, codecs
 import StringIO
 import nfs4state
 from nfs4state import NFS4Error, printverf
-from xdrlib import Error as XDRError
+from xdrlib3 import Error as XDRError
 
 unacceptable_names = [ "", ".", ".." ]
 unacceptable_characters = [ "/", "~", "#", ]
diff --git a/rpc/security.py b/rpc/security.py
index 0682f438cd6237334c59e7cb280c8b192e7c8a76..789280c5d7328a928b2f6c1af95397d17180eff9 100644
--- a/rpc/security.py
+++ b/rpc/security.py
@@ -3,7 +3,7 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
 from .rpc_type import opaque_auth, authsys_parms
 from .rpc_pack import RPCPacker, RPCUnpacker
 from .gss_pack import GSSPacker, GSSUnpacker
-from xdrlib import Packer, Unpacker
+from xdrlib3 import Packer, Unpacker
 from . import rpclib
 from .gss_const import *
 from . import gss_type
diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
index b472e50676799915ea3b6a14f6686a5973484fb2..f802ba80045e79716a71fa7a64d72f1b8831128d 100755
--- a/xdr/xdrgen.py
+++ b/xdr/xdrgen.py
@@ -1357,8 +1357,8 @@ pack_header = """\
 import sys,os
 from . import %s as const
 from . import %s as types
-import xdrlib
-from xdrlib import Error as XDRError
+import xdrlib3 as xdrlib
+from xdrlib3 import Error as XDRError
 
 class nullclass(object):
     pass

---
base-commit: d042a1f6421985b7c9d17edf8eb0d59bcf7f5908
change-id: 20250122-master-68414e8f6d5f

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


