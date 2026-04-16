Return-Path: <linux-nfs+bounces-20908-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGq9Aion4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20908-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2B413A20
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8775305966F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855DE33554B;
	Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgiJUQ8N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143733509E
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363303; cv=none; b=IVHctTeH0daekoXv+9mN0Qw7ZOQF3KFIhM2sVmwDyLlQqAyKQlVvTEaY+Pc/GpF5af3Kk7Xoru1Llp95dAR9kJTBEO90hQdilwBUHBE0QD9/fByIc2urwyRu4yzWAWAfBGdGIRTFJmIy/gOVkJ2vD6IEI/SiNpccH7ngdd3335I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363303; c=relaxed/simple;
	bh=rBBJkifYGeR2lfaPnS6IoQTHSE3Q9LxtgbHMAnWrrCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN07gPt3ZskCJHAMRAfvd48koBBme/3ph9hV4o0MFgMOwI+6fIh752elSzmmHgtODgOhneGvC0X/stlZgsFOmxnYBKmCK7L4ogZZbqNYDmKLFs9a3mcO9NpLmz70ie5c+UDTpFVuXOwKfg0tAz3w/7sPI6lLcDK1C8KsqVogi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgiJUQ8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85FBC2BCB7;
	Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363303;
	bh=rBBJkifYGeR2lfaPnS6IoQTHSE3Q9LxtgbHMAnWrrCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qgiJUQ8NXIqOrwNu53TOLkZNq89MzpbS3y3es4BtzVRM0uyqGUjGNOJUCgzdO/IPB
	 b6+KvweXAYkWGH7Z/xWib8Tpd8jupqACxdLiaoEg3fr3TKX8aS1x97mkszk3E3tL7T
	 lcsfI6LrEn8jZDLt877bGYf7bgzgxlZNcBuOeSGTxpGnf7AU868W8hVgD+OBLDuTd9
	 NSopzNIQH6jORm89QDDDxeCb/7MvKsgaG6lJN/V7evL8KEuhGDfPrR7QbZxRP9AFS1
	 hSMpa1Yg2OyhZ0NAtGtu8ORxyKG/I5ul1+waDjcKS8lrWl58UcK0VXIE8JufpdWZw5
	 bLuGksTx0BhKA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:38 -0700
Subject: [PATCH pynfs v2 06/25] server41tests: test remove triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-6-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rBBJkifYGeR2lfaPnS6IoQTHSE3Q9LxtgbHMAnWrrCc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScfqdnNjtK/R2GLFueLBqi+aHmxIo09G695z
 cQlDtl7wbiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHwAKCRAADmhBGVaC
 FeY3D/9RPF+I+XJHN8GelpyYz5XWGMu+cD2o7byIfjTbIk6fCFgwP8puDY8+py/xesen0KvKSB5
 /yNwNhMOt8Ctilxnl6DN/BpqDSsSQBa/Wd0rEPbMQheKheTTyE+aU4vWbs5qGx5Uk2qX+iDCS/+
 slNPX4s1qo5ZrP2B2IkL8nplrOzhmlmIpNtVAFQzhptKmph+d+6QhwPXQ9OWWc1MkUYnpAgmFE7
 sz3YXzmtDFwp2E1P0kLvzbAUaH3NO8nC7fZluPiWo9F+0czy1Daxn7DDIffCycBUS//p7ZqD0fC
 14iuts+uiwsbOhH/IsEBNqMzCt1LppK5fHAuhS6EZiepaw8ZbzgzRBNy5DyejnXkIgrKfk3BrkY
 xVN0kg4+tIJghPvHY6JhEHurpyQOWMh7DGRHwMIMmJFYilzwS1GnQ8jRLALuATbD8ImRl0Y7Ja3
 Z33HBsM7U4vQyuksIyvI0enPQCvjVVfeFvS9jHD39tlmiPqj2PlIdwedU2oJQeHI92Gbe+Itv7Y
 C46Pq9VFzydzkW28tZAAsAbdhtRVnKdZZBqihfRfh4M+xlQGcCtzGEfB9YCYEmaCOliXX/a+qWn
 elTmYzR+4h6ffJc4eE9BbGxSUBr3i5Q3v+8r+lGJF2UKr9VIi2820L6mdzHxzdMYuSn8CfHq1RD
 +e5HdsYPlKOxgFA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20908-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97E2B413A20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get a dir delegation with no notification mask, create a file, then
remove it from a second client. Verify that the server issues a
CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index e5de20c52ba4..f5265e8cf0ab 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -3,7 +3,7 @@ from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 from xdrdef.nfs4_pack import NFS4Unpacker
 
-from .environment import check, fail, create_obj, use_obj
+from .environment import check, fail, create_obj, use_obj, close_file, rename_obj
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -141,3 +141,37 @@ def testDirDelegDuplicate(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegRemoveRecall(t, env):
+    """Verify remove triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG3
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a file from sess1
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Remove the file from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    slot = sess2.compound_async(remove_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.53.0


