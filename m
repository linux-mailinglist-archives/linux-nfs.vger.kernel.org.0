Return-Path: <linux-nfs+bounces-7169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E399D87C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35981C2115E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7CD1CFED2;
	Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtCnBlLR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA221CB330
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939037; cv=none; b=Uk4u6ZAwJfserBkQN7TO/PRD8BLr1SruVwLpevRZ0OaSQP+1S7NadmFvrw2jhUVIbIwh2vru9Zw6PT6UIb8ixRx+eLW6ttHBj0Z7pIT+828gsrhyWdEC/NoR7ZQDONFkJwjHxzpjU1KKY+ZiL0PvgxlW1a4Tld/71+jbzjm2ytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939037; c=relaxed/simple;
	bh=olCRQyLo/MrJ+Q/mVqgnaFg57B+do6R2/NzP2wNiKGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bbbn0AKRa+35DiEY7zF6xPu/8DTiayRg9SNUioSeZDycSOLzOYxZVTNbzZ7R2//edQV3StglThvy7V4WhvMOaB3fWlcP0cBYHKPKUGGwIGPSyddcMJOqGY1BUzUpWq10hG8owfcb1TPx9IUL59jAxNcXnmWoIxGDUucIOBu66YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtCnBlLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBEAC4CEC6;
	Mon, 14 Oct 2024 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939037;
	bh=olCRQyLo/MrJ+Q/mVqgnaFg57B+do6R2/NzP2wNiKGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RtCnBlLR+/JzwKLchfOVUHvei3Br6+OFq8yEi5Sv7bYILy4/M8xjz1EX5TeDsOM4b
	 +Pazo53zTVDye6ERNsF5PGTU4K49q7DyGi7UPgcfW6uCAguYYt+pLpaUvpEmXYJTT9
	 jFmBzDS2hia7hC3OjdV4N01/CzoPrBwyrxCeDhmsuq5FEtH7WJFZzoWx5GUMTGcZyt
	 33zTz1B4sXphLBQPkrysQQYXN8T+HIvs9LrygyUYz43aOGuQl1wVLF09nN55q936Zu
	 OkeWBz4PweJTxSrAmbrKcNwHAmJtI13jwGGWc0G/C5aNK2vEY9jWtVN6tlPrjXGFfJ
	 a4BU2WadlfbmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:21 -0400
Subject: [PATCH pynfs v2 1/7] WRT18: have it also check the ctime between
 writes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-1-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=olCRQyLo/MrJ+Q/mVqgnaFg57B+do6R2/NzP2wNiKGQ=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGcNhBujLJzZb/nfltUG2aYd640VPshBc5HAnD1dlmo7ejSnw
 YkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJnDYQbAAoJEAAOaEEZVoIV7UsP/R5e
 tOKQqZZuEqdkTbltrSs+aFgulbgCXUSzxbJylVyKKNQQwc7BaV5BtWY4Vp7kMzzo4e2zV8VeqIC
 L+UzmHAbnVo/R7WCRytUh33TUeqYrx6xX2m3xOsUXECLf9/Qda39PTlB3PkNzr07v7KJVDLKOn/
 1Or8hEm3bKHqJSV5eB9utgi3DtQFUfm8/TfV90Ra5oAf7/dqhaYmXcxXpH54SVxprbZ0xv8HZCC
 ZwZANyNHK5L41lPVjr4VC9+QC1oOYz4S/GJgjvnN7znypz+IzbVlZPhmWKHpuCD9J+cpm7GxSsr
 8ksF1BMFJfcN9ocXKeRiBUiQ7D0kk4fBt95GkdCbGkf3DOO8s8bdw04Kwagqq6/aOigU8XH7/lN
 jQTk8Nc+jn4Raird1TS1lP91t3HtjLOT5Qz7NtqRmVyE1YQnFk6m2XKqiLoxeGI9jTY7AsFZu5T
 /Tic/VvKFOg/Fffl/C5iq0ykbxEpbpNLr//WS6dY95YCJ7mPSyIKwminZEVmxe9eUi7A4qihlVt
 OY2iyOK7W/MnpEmpUx5+RqWu1+Cty2Ga177a4msUTCL9zdT5pdXwNwWxxZ4O03afFLuWodWqT8U
 /iBnf9xyvOU09us/vrdJlPi1jxazf+35DZo3rl47yUmlLAuhjUEdKK5schiclw5v+9k2Bths7WK
 MISGU
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

On many servers, the ctime doesn't have sufficient granularity to show
an apparent change between rapid writes, but some are able to do so.
Have the test also check the ctimes here and pass_warn if it doesn't
change after every write.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.0/servertests/st_write.py | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/nfs4.0/servertests/st_write.py b/nfs4.0/servertests/st_write.py
index db1b1e585fdbf7169400ba676dd86b46e6c61750..e635717f76c93fc186521688717e25a377de7207 100644
--- a/nfs4.0/servertests/st_write.py
+++ b/nfs4.0/servertests/st_write.py
@@ -497,19 +497,27 @@ def testChangeGranularityWrite(t, env):
     c = env.c1
     c.init_connection()
     fh, stateid = c.create_confirm(t.word())
-    ops = c.use_obj(fh) + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 0,  UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 10, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 20, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])] \
-        + [op.write(stateid, 30, UNSTABLE4, _text)] + [c.getattr([FATTR4_CHANGE])]
+    attrlist = [FATTR4_CHANGE, FATTR4_TIME_METADATA]
+    ops = c.use_obj(fh) + [c.getattr(attrlist)] \
+        + [op.write(stateid, 0,  UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 10, UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 20, UNSTABLE4, _text)] + [c.getattr(attrlist)] \
+        + [op.write(stateid, 30, UNSTABLE4, _text)] + [c.getattr(attrlist)]
     res = c.compound(ops)
     check(res)
-    chattr1 = res.resarray[1].obj_attributes
-    chattr2 = res.resarray[3].obj_attributes
-    chattr3 = res.resarray[5].obj_attributes
-    chattr4 = res.resarray[7].obj_attributes
+    chattr1 = res.resarray[1].obj_attributes[FATTR4_CHANGE]
+    chattr2 = res.resarray[3].obj_attributes[FATTR4_CHANGE]
+    chattr3 = res.resarray[5].obj_attributes[FATTR4_CHANGE]
+    chattr4 = res.resarray[7].obj_attributes[FATTR4_CHANGE]
     if chattr1 == chattr2 or chattr2 == chattr3 or chattr3 == chattr4:
-        t.fail("consecutive SETATTR(mode)'s don't all change change attribute")
+        t.fail("consecutive WRITE's don't change change attribute")
+
+    ctime1 = res.resarray[1].obj_attributes[FATTR4_TIME_METADATA]
+    ctime2 = res.resarray[3].obj_attributes[FATTR4_TIME_METADATA]
+    ctime3 = res.resarray[5].obj_attributes[FATTR4_TIME_METADATA]
+    ctime4 = res.resarray[7].obj_attributes[FATTR4_TIME_METADATA]
+    if compareTimes(ctime1, ctime2) == 0 or compareTimes(ctime2, ctime3) == 0 or compareTimes(ctime3, ctime4) == 0:
+        t.pass_warn("consecutive WRITE's don't all change time_metadata")
 
 def testStolenStateid(t, env):
     """WRITE with incorrect permissions and somebody else's stateid

-- 
2.47.0


