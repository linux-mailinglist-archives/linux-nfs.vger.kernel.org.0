Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545171DBAE6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgETROx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETROx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 13:14:53 -0400
X-Greylist: delayed 774 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 May 2020 10:14:53 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F54C061A0E;
        Wed, 20 May 2020 10:14:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 79C801513; Wed, 20 May 2020 13:14:52 -0400 (EDT)
Date:   Wed, 20 May 2020 13:14:52 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Calum Mackay <calum.mackay@oracle.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
Message-ID: <20200520171452.GC19305@fieldses.org>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
 <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
 <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
 <20200520164639.GA19305@fieldses.org>
 <1af614e5-9784-cb5e-52a6-dc13b1d04524@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af614e5-9784-cb5e-52a6-dc13b1d04524@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 20, 2020 at 06:01:27PM +0100, Calum Mackay wrote:
> On 20/05/2020 5:46 pm, Bruce Fields wrote:
> >     Fix comments and version checks that refer to python 2
> >     The minimum required version may actually be greater than 3.0, I'm not
> >     sure.
> 
> for what it's worth, it requires at least v3.2, since it uses
> os.fsencode(), which was introduced in that rev.
> 
> That doesn't contradict your statement, of course, and I've not
> checked the rest of it.

Thanks!  I've updated it to refer to 3.2.

--b.

commit f7234d07ee81
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue May 19 22:58:23 2020 -0400

    Fix comments and version checks that refer to python 2
    
    The minimum required version may actually be greater than 3.2, I'm not
    sure.  I've been testing with 3.8.2.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index cc509965f8e7..6a13e856f3f0 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -1,6 +1,6 @@
 # rpc.py - based on RFC 1831
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
index 5916dcc74139..f67c1e3695d6 100755
--- a/nfs4.0/nfs4client.py
+++ b/nfs4.0/nfs4client.py
@@ -9,8 +9,8 @@
 #
 
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03020000:
+    print("Requires python 3.2 or higher")
     sys.exit(1)
 import os
 # Allow to be run stright from package root
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 9adeb81daa95..a9a65d7a2f10 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4lib.py - NFS4 library for Python
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/servertests/environment.py b/nfs4.0/servertests/environment.py
index e7ef2b052833..fcaa0ebec075 100644
--- a/nfs4.0/servertests/environment.py
+++ b/nfs4.0/servertests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index 4f31f92a1e34..f28ba1bdb6d0 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -26,8 +26,8 @@
 
 
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03020000:
+    print("Requires python 3.2 or higher")
     sys.exit(1)
 import os
 # Allow to be run stright from package root
diff --git a/nfs4.1/client41tests/environment.py b/nfs4.1/client41tests/environment.py
index 25e7cb08ebb1..f84399b4a533 100644
--- a/nfs4.1/client41tests/environment.py
+++ b/nfs4.1/client41tests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index e7bcaa90904c..ef4db762ff08 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
index 19bd148edde2..46b7abc1e0a5 100755
--- a/nfs4.1/testclient.py
+++ b/nfs4.1/testclient.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -23,8 +23,8 @@
 
 import use_local # HACK so don't have to rebuild constantly
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03020000:
+    print("Requires python 3.2 or higher")
     sys.exit(1)
 import os
 
diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 8c4ccdef5afa..6285758fe74d 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -1,6 +1,6 @@
 # testmod.py - run tests from a suite
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index f3fcfe9b8851..0447ccd5da7c 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -27,8 +27,8 @@
 
 import use_local # HACK so don't have to rebuild constantly
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03020000:
+    print("Requires python 3.2 or higher")
     sys.exit(1)
 import os
 
diff --git a/showresults.py b/showresults.py
index 0229a1e4d7b6..a39e1b9f7689 100755
--- a/showresults.py
+++ b/showresults.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # showresults.py - redisplay results from nfsv4 server tester output file
 #
-# Requires python 2.7
+# Requires python 3.2
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
