Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0C21FBA1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2020 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgGNTDI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jul 2020 15:03:08 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:51338 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731102AbgGNS5m (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:42 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id B0348E0719
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2020 20:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de B0348E0719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1594753059; bh=eZlt33IH1zYVP68k36qGmcXk3BtX6Jj4BBVnrzFz77I=;
        h=From:To:Cc:Subject:Date:From;
        b=qjeAHwumY6rzedi0RsaNihW45f7Qj72d5Ec1P0f42tM7+eO0HfVtj0sYzFPNv2h7C
         Bp11o87LfldJfb87Mwr8ezVFMfJKLQ9wXLgilzx6MWvBNJNtZ9MiCyxgpDpxMJygEO
         yOG/ZhxxxJZJNELfnS4rrtNPYETmWMvlhaEmSSeQ=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id ABF4D1201D4;
        Tue, 14 Jul 2020 20:57:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 7CB8E80067;
        Tue, 14 Jul 2020 20:57:39 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] change shebang to python3
Date:   Tue, 14 Jul 2020 20:57:34 +0200
Message-Id: <20200714185734.133111-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

as there are still OSes (RHEL7 and clones) that point `python` to `python2`

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 nfs4.0/nfs4client.py  | 2 +-
 nfs4.0/nfs4lib.py     | 2 +-
 nfs4.0/nfs4server.py  | 2 +-
 nfs4.0/setup.py       | 2 +-
 nfs4.0/testserver.py  | 2 +-
 nfs4.1/errorparser.py | 2 +-
 nfs4.1/nfs4proxy.py   | 2 +-
 nfs4.1/nfs4server.py  | 2 +-
 nfs4.1/testclient.py  | 2 +-
 nfs4.1/testserver.py  | 2 +-
 setup.py              | 2 +-
 showresults.py        | 2 +-
 xdr/setup.py          | 2 +-
 xdr/xdrgen.py         | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
index f67c1e3..d3d6e88 100755
--- a/nfs4.0/nfs4client.py
+++ b/nfs4.0/nfs4client.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 #
 # nfs4client.py - NFS4 interactive client in python
diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index a9a65d7..905f8f4 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # nfs4lib.py - NFS4 library for Python
 #
 # Requires python 3.2
diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
index 753372e..3cf6ec2 100755
--- a/nfs4.0/nfs4server.py
+++ b/nfs4.0/nfs4server.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # nfs4server.py - NFS4 server in python
 #
diff --git a/nfs4.0/setup.py b/nfs4.0/setup.py
index fa680e2..58349d9 100755
--- a/nfs4.0/setup.py
+++ b/nfs4.0/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 from __future__ import print_function
 from __future__ import absolute_import
diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index a225077..3ceac3c 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
diff --git a/nfs4.1/errorparser.py b/nfs4.1/errorparser.py
index 328fe8d..9df41d9 100755
--- a/nfs4.1/errorparser.py
+++ b/nfs4.1/errorparser.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 from __future__ import with_statement
 import use_local # HACK so don't have to rebuild constantly
 from xml.dom import minidom
diff --git a/nfs4.1/nfs4proxy.py b/nfs4.1/nfs4proxy.py
index dc8fdd4..dd870d9 100755
--- a/nfs4.1/nfs4proxy.py
+++ b/nfs4.1/nfs4proxy.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 from __future__ import with_statement
 import use_local # HACK so don't have to rebuild constantly
 import nfs4lib
diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
index 4500daf..6f7d10c 100755
--- a/nfs4.1/nfs4server.py
+++ b/nfs4.1/nfs4server.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 from __future__ import with_statement
 import use_local # HACK so don't have to rebuild constantly
 import nfs4lib
diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
index 46b7abc..dd68bda 100755
--- a/nfs4.1/testclient.py
+++ b/nfs4.1/testclient.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index 8b80863..01d600e 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # nfs4stest.py - nfsv4 server tester
 #
 # Requires python 3.2
diff --git a/setup.py b/setup.py
index 3e48346..83dc6b5 100755
--- a/setup.py
+++ b/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 from __future__ import print_function
 
diff --git a/showresults.py b/showresults.py
index a39e1b9..5abd72a 100755
--- a/showresults.py
+++ b/showresults.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # showresults.py - redisplay results from nfsv4 server tester output file
 #
 # Requires python 3.2
diff --git a/xdr/setup.py b/xdr/setup.py
index 1ab9c8d..e8af152 100644
--- a/xdr/setup.py
+++ b/xdr/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 
 from distutils.core import setup
 
diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
index abfc8d7..130f364 100755
--- a/xdr/xdrgen.py
+++ b/xdr/xdrgen.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # rpcgen.py - A Python RPC protocol compiler
 # 
 # Written by Fred Isaman <iisaman@citi.umich.edu>
-- 
2.26.2

