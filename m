Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA37216E6C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGGOL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 10:11:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25012C061755
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2020 07:11:57 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6F943153E; Tue,  7 Jul 2020 10:11:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6F943153E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594131116;
        bh=Mxk9AMD2/Gv3AHrQKosjwLL7kTGy9E1KcrBnYzS5O6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wBCz2MKAKHlL2gs9uV6/ZthMl5N/GIZby+KJ9SvVVkMi9W6ll+56JvBfHhNGbinm0
         GJ7U/Pv0C8JVARQW6Hl1H7nt4euZIR7TBdJSJ8CkUcz7w81FRlpkPN01Wcg2k9vQEn
         SuhVTIEF5wD2XIDc2Ln4GfeRLSDh4Kqo7SEaVwpo=
Date:   Tue, 7 Jul 2020 10:11:56 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd4: a client's own opens needn't prevent delegations
Message-ID: <20200707141156.GB25846@fieldses.org>
References: <20200707132805.GA25846@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707132805.GA25846@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 07, 2020 at 09:28:05AM -0400, bfields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> We recently fixed lease breaking so that a client's actions won't break
> its own delegations.
> 
> But we still have an unnecessary self-conflict when granting
> delegations: a client's own write opens will prevent us from handing out
> a read delegation even when no other client has the file open for write.
> 
> Fix that by turning off the checks for conflicting opens under
> vfs_setlease, and instead performing those checks in the nfsd code.

I'm testing this with pynfs.

--b.

commit f9f2b68d2f17
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Tue Jul 7 10:03:24 2020 -0400

    DELEG22: grant delegs on write opens too
    
    Even when the client has write opens, the server can still grant
    delegations.
    
    (Didn't add the "all" flag since this behavior is optional.  Then again,
    so is most delegation-granting behavior.  Some day we should think about
    how to report optional behavior so that we can still for example
    identify regressions in a given implementation even when the behavior
    we're regressing to isn't strictly incorrect.)
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index e7ebcc5a2c67..875dbc94ded1 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -745,3 +745,32 @@ def testServerSelfConflict(t, env):
     newcount = c.cb_server.opcounts[OP_CB_RECALL]
     if newcount > count:
         t.fail("Unnecessary delegation recall")
+
+def testServerSelfConflict2(t,env):
+    """DELEGATION test
+
+    Test that we can still get a delegation even when we have the
+    file open for write from the same client.
+
+    FLAGS: delegations
+    CODE: DELEG22
+    """
+    c = env.c1
+    c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
+    time.sleep(0.5)
+    res = c.create_file(t.word(), c.homedir+[t.word()],
+                        access = OPEN4_SHARE_ACCESS_BOTH,
+                        deny = OPEN4_SHARE_DENY_NONE)
+    check(res)
+    fh, stateid = c.confirm(t.word(), res)
+    deleg_info = res.resarray[-2].switch.switch.delegation
+    if deleg_info.delegation_type != OPEN_DELEGATE_NONE:
+        return
+    res = c.open_file(t.word(), c.homedir+[t.word()],
+                        access=OPEN4_SHARE_ACCESS_BOTH,
+                        deny = OPEN4_SHARE_DENY_NONE)
+    check(res)
+    fh, stateid = c.confirm(t.word(), res)
+    deleg_info = res.resarray[-2].switch.switch.delegation
+    if deleg_info.delegation_type == OPEN_DELEGATE_NONE:
+        t.fail("Could not get delegation")
