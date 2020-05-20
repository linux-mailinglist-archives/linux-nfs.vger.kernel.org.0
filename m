Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAD1DBA0E
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETQqk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 12:46:40 -0400
Received: from fieldses.org ([173.255.197.46]:47276 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETQqk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 12:46:40 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C4F3B1BE7; Wed, 20 May 2020 12:46:39 -0400 (EDT)
Date:   Wed, 20 May 2020 12:46:39 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
Message-ID: <20200520164639.GA19305@fieldses.org>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
 <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
 <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 19, 2020 at 07:32:37PM -0400, Chuck Lever wrote:
> Looks like python3 is now a requirement for pynfs, despite the comments
> and code in nfs4.0/testserver.py.
> 
> Also, the README should explain that the server under test has to permit
> access from insecure source ports (this still might not be the default
> for some NFS servers).

Both done, thanks for the feedback.--b.

commit e4379b69becd
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Wed May 20 12:43:33 2020 -0400

    Document high-port requirement for server testing
    
    Some NFS servers by default require the client to connect from a
    low-numbered port.  But pynfs is meant to be runnable as a non-root
    user, and as such can't necessarily get low-numbered ports.
    
    It might be useful to at least try to get a low-numbered port, or to
    give a better error message.  For now, at least warn about this in the
    README.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/README b/README
index 79cac62cb75e..a0236fb6b209 100644
--- a/README
+++ b/README
@@ -18,6 +18,10 @@ For more details about 4.0 and 4.1 testing, see nfs4.0/README and
 nfs4.1/README, respectively.  For information about automatic code
 generation from an XDR file, see xdr/README.
 
+Note that any server under test must permit connections from high port
+numbers.  (In the case of the NFS server, you can do this by adding
+"insecure" to the export options.)
+
 Note that test results should *not* be considered authoritative
 statements about the protocol--if you find that a server fails a test,
 you should consult the rfc's and think carefully before assuming that

commit 39b62e990d84
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue May 19 22:58:23 2020 -0400

    Fix comments and version checks that refer to python 2
    
    The minimum required version may actually be greater than 3.0, I'm not
    sure.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
index cc509965f8e7..8f5ce26226d3 100644
--- a/nfs4.0/lib/rpc/rpc.py
+++ b/nfs4.0/lib/rpc/rpc.py
@@ -1,6 +1,6 @@
 # rpc.py - based on RFC 1831
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
index 5916dcc74139..37fbcbec9132 100755
--- a/nfs4.0/nfs4client.py
+++ b/nfs4.0/nfs4client.py
@@ -9,8 +9,8 @@
 #
 
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03000000:
+    print("Requires python 3.0 or higher")
     sys.exit(1)
 import os
 # Allow to be run stright from package root
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 9adeb81daa95..82cec4b68cee 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4lib.py - NFS4 library for Python
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/servertests/environment.py b/nfs4.0/servertests/environment.py
index e7ef2b052833..edbd37a638a5 100644
--- a/nfs4.0/servertests/environment.py
+++ b/nfs4.0/servertests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index 4f31f92a1e34..d380f2d5fe83 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -26,8 +26,8 @@
 
 
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03000000:
+    print("Requires python 3.0 or higher")
     sys.exit(1)
 import os
 # Allow to be run stright from package root
diff --git a/nfs4.1/client41tests/environment.py b/nfs4.1/client41tests/environment.py
index 25e7cb08ebb1..26d7368ebcb0 100644
--- a/nfs4.1/client41tests/environment.py
+++ b/nfs4.1/client41tests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index e7bcaa90904c..b24862b61f08 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -1,7 +1,7 @@
 #
 # environment.py
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
index 19bd148edde2..3027419babd2 100755
--- a/nfs4.1/testclient.py
+++ b/nfs4.1/testclient.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -23,8 +23,8 @@
 
 import use_local # HACK so don't have to rebuild constantly
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03000000:
+    print("Requires python 3.0 or higher")
     sys.exit(1)
 import os
 
diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 8c4ccdef5afa..0bf6bfc80fdc 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -1,6 +1,6 @@
 # testmod.py - run tests from a suite
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index f3fcfe9b8851..6b1157985be9 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # nfs4stest.py - nfsv4 server tester
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
@@ -27,8 +27,8 @@
 
 import use_local # HACK so don't have to rebuild constantly
 import sys
-if sys.hexversion < 0x02070000:
-    print("Requires python 2.7 or higher")
+if sys.hexversion < 0x03000000:
+    print("Requires python 3.0 or higher")
     sys.exit(1)
 import os
 
diff --git a/showresults.py b/showresults.py
index 0229a1e4d7b6..41d1c851721c 100755
--- a/showresults.py
+++ b/showresults.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 # showresults.py - redisplay results from nfsv4 server tester output file
 #
-# Requires python 2.7
+# Requires python 3
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
 # Copyright (C) 2004 University of Michigan, Center for 
