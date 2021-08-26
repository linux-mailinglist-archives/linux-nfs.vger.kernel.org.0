Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836E3F8710
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbhHZMPb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 08:15:31 -0400
Received: from smtp-relay.cendio.se ([46.21.107.49]:53680 "EHLO
        smtp-relay.cendio.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhHZMPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 08:15:30 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 08:15:30 EDT
Received: from mail.cendio.se (hayek.cendio.se [193.12.253.119])
        by smtp-relay.cendio.se (Postfix) with ESMTPS id 1E67F4001B;
        Thu, 26 Aug 2021 14:09:21 +0200 (CEST)
Received: from [IPv6:2a00:801:107:4700:bc78:30c:b9a3:3e88] (unknown [IPv6:2a00:801:107:4700:bc78:30c:b9a3:3e88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.cendio.se (Postfix) with ESMTPSA id E180AC0A4AF3;
        Thu, 26 Aug 2021 14:09:23 +0200 (CEST)
To:     linux-nfs@vger.kernel.org
From:   =?UTF-8?Q?William_Sj=c3=b6blom?= <wilsj@cendio.com>
Subject: [PATCH] pynfs: Avoid changing sys.path in generated code
Cc:     bfields@redhat.com
Message-ID: <4e96b884-1271-e0c6-3231-4d55883b8e62@cendio.com>
Date:   Thu, 26 Aug 2021 14:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Previously importing the rpc module had side effects on sys.path which
is not preferable when using the it in larger projects. This has now
been fixed by removing the code modifying sys.path and using relative
over absolute imports in the impacted files.

Signed-off-by: William Sjöblom <wilsj@cendio.com>
---
  rpc/rpc.py      | 10 +++++-----
  rpc/rpclib.py   |  4 ++--
  rpc/security.py | 16 ++++++++--------
  xdr/xdrgen.py   |  7 +++----
  4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/rpc/rpc.py b/rpc/rpc.py
index 4d1eb09..b7f906c 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -8,12 +8,12 @@ import logging
  from collections import deque as Deque
  from errno import EINPROGRESS, EWOULDBLOCK

-import rpc.rpc_pack as rpc_pack
-from rpc_const import *
-from rpc_type import *
+from . import rpc_pack
+from .rpc_const import *
+from .rpc_type import *

-import security
-import rpclib
+from . import security
+from . import rpclib
  import random

  log_p = logging.getLogger("rpc.poll") # polling loop thread
diff --git a/rpc/rpclib.py b/rpc/rpclib.py
index 0e8e8e5..23458bf 100644
--- a/rpc/rpclib.py
+++ b/rpc/rpclib.py
@@ -1,5 +1,5 @@
-from rpc_const import *
-from rpc_type import *
+from .rpc_const import *
+from .rpc_type import *

  import logging
  log = logging.getLogger("rpc.lib")
diff --git a/rpc/security.py b/rpc/security.py
index 0ebb923..fe4390c 100644
--- a/rpc/security.py
+++ b/rpc/security.py
@@ -1,13 +1,13 @@
-from rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
+from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
      MSG_ACCEPTED
-from rpc_type import opaque_auth, authsys_parms
-from rpc_pack import RPCPacker, RPCUnpacker
-from gss_pack import GSSPacker, GSSUnpacker
+from .rpc_type import opaque_auth, authsys_parms
+from .rpc_pack import RPCPacker, RPCUnpacker
+from .gss_pack import GSSPacker, GSSUnpacker
  from xdrlib import Packer, Unpacker
-import rpclib
-from gss_const import *
-import gss_type
-from gss_type import rpc_gss_init_res
+from . import rpclib
+from .gss_const import *
+from . import gss_type
+from .gss_type import rpc_gss_init_res
  try:
      import gssapi
  except ImportError:
diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
index 6064586..b472e50 100755
--- a/xdr/xdrgen.py
+++ b/xdr/xdrgen.py
@@ -1355,9 +1355,8 @@ allow_attr_passthrough = True # Option which 
allows substructure attrs to
                                # is a unique substructure to search.
  pack_header = """\
  import sys,os
-sys.path.append(os.path.dirname(__file__))
-import %s as const
-import %s as types
+from . import %s as const
+from . import %s as types
  import xdrlib
  from xdrlib import Error as XDRError

@@ -1440,7 +1439,7 @@ def run(infile, filters=True, pass_attrs=True, 
debug=False):
      const_fd.write(comment_string)
      type_fd = open(types_file + ".py", "w")
      type_fd.write(comment_string)
-    type_fd.write("import 
sys,os\nsys.path.append(os.path.dirname(__file__))\nimport %s as 
const\n" % constants_file)
+    type_fd.write("import sys,os\nfrom . import %s as const\n" % 
constants_file)
      pack_fd = open(packer_file + ".py", "w")
      pack_fd.write(comment_string)
      pack_fd.write(pack_header % (constants_file, types_file))
-- 
2.31.1


