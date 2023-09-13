Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D079E56D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbjIMK4G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjIMK4G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 06:56:06 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 03:56:01 PDT
Received: from mail.cendio.se (dns.cendio.se [IPv6:2a00:801:107:f000::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989219AD
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 03:56:00 -0700 (PDT)
Received: from aleze.com (unknown [IPv6:2a00:801:107:4700:cb36:7a86:495f:465b])
        by mail.cendio.se (Postfix) with ESMTPSA id 9EE091835C22;
        Wed, 13 Sep 2023 12:47:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se 9EE091835C22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
        s=20230315; t=1694602073;
        bh=qlBwQbRxlDw3WUtH8jbMSS5wTBGu4pml8r5c9pkGoAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gvLceu3LVbIRQnk2sc07U3dBYWz2Wa/U/q3WJeMLszNy8YoeHxEEG+blsNluAoPxc
         W6GJlR60XON1/tPIaWwnK5blqpjH+pLe+5vmch7GOGSuXUV226UGSymf4Xxe5kXE6E
         jVfr5PWM8+Su+jSCMYjvQyq7yrYle8PR4C63ionR0GE5ocZ0kmAM35JJrmeSRiBRwv
         xfhs+FgAUpqw8gL/6I0J+Y2BMwNQrASgS5gOSzpeE8LZ5V8/Gw3RlIy/I1OO9OEhzg
         06pSslBiPuYxkfVN7yevI+/k/cbavb+NRS9Nni8/oZzXRmEjrAfz72a4lYeXNrO8E7
         9rh4uwauvLy/g==
From:   Alexander Zeijlon <alexander.zeijlon@cendio.se>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org,
        Alexander Zeijlon <alexander.zeijlon@cendio.se>
Subject: [PATCH] Stop using deprecated thread.setDaemon
Date:   Wed, 13 Sep 2023 12:46:36 +0200
Message-ID: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The thread.setDaemon method is deprecated since Python version 3.10, the
daemon property should now be set directly.

Signed-off-by: Alexander Zeijlon <alexander.zeijlon@cendio.se>
---
 nfs4.0/nfs4lib.py                   | 2 +-
 nfs4.0/servertests/st_delegation.py | 4 ++--
 nfs4.1/nfs4state.py                 | 2 +-
 rpc/rpc.py                          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 9b074f0..9a72ec9 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -297,7 +297,7 @@ class NFS4Client(rpc.RPCClient):
         # Start up callback server associated with this client
         self.cb_server = CBServer(self)
         self.thread = threading.Thread(target=self.cb_server.run, name=name)
-        self.thread.setDaemon(True)
+        self.thread.daemon = True
         self.thread.start()
         # Establish callback control socket
         self.cb_control = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index ba49cf9..bcc768a 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -40,7 +40,7 @@ def _recall(c, thisop, cbid):
     if res is not None and res.status != NFS4_OK:
         t_error = _handle_error(c, res, ops)
         t = threading.Thread(target=t_error.run)
-        t.setDaemon(1)
+        t.daemon = True
         t.start()
     return res
 
@@ -409,7 +409,7 @@ def testChangeDeleg(t, env, funct=_recall):
     new_server = CBServer(c)
     new_server.set_cb_recall(c.cbid, funct, NFS4_OK);
     cb_thread = threading.Thread(target=new_server.run)
-    cb_thread.setDaemon(1)
+    cb_thread.daemon = True
     cb_thread.start()
     c.cb_server = new_server
     env.sleep(3)
diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
index e57b90a..6b4cc81 100644
--- a/nfs4.1/nfs4state.py
+++ b/nfs4.1/nfs4state.py
@@ -308,7 +308,7 @@ class DelegState(FileStateTyped):
                 e.status = CB_INIT
                 t = threading.Thread(target=e.initiate_recall,
                                      args=(dispatcher,))
-                t.setDaemon(True)
+                t.daemon = True
                 t.start()
         # We need to release the lock so that delegations can be recalled,
         # which can involve operations like WRITE, LOCK, OPEN, etc,
diff --git a/rpc/rpc.py b/rpc/rpc.py
index 1fe285a..3621c8e 100644
--- a/rpc/rpc.py
+++ b/rpc/rpc.py
@@ -598,7 +598,7 @@ class ConnectionHandler(object):
             log_p.log(5, "Received record from %i" % fd)
             log_p.log(2, repr(r))
             t = threading.Thread(target=self._event_rpc_record, args=(r, s))
-            t.setDaemon(True)
+            t.daemon = True
             t.start()
 
     def _event_rpc_record(self, record, pipe):
@@ -935,7 +935,7 @@ class Client(ConnectionHandler):
 
         # Start polling
         t = threading.Thread(target=self.start, name="PollingThread")
-        t.setDaemon(True)
+        t.daemon = True
         t.start()
 
     def send_call(self, pipe, procedure, data=b'', credinfo=None,
-- 
2.41.0

