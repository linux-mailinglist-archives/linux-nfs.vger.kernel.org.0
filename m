Return-Path: <linux-nfs+bounces-20910-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKl0J+sn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20910-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B17E413A97
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2349430F8DFB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4C2F9D85;
	Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mliAS2aX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C521331A46
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363304; cv=none; b=jMfL11bxGMh0zkopRcDYgId/U2BsTqzxpBe84dZAMexXOZPr1AbLYlcBxvMlMbV5yMkn6wBzs0UWjNJXXYlN5JnHYHJkE11OvqaHZQswi3t6hBQksBqT66GVKXV1Bx04drsg0L65J7k751mvWQPzQmmq5eIIHxtH8E+5WfXlFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363304; c=relaxed/simple;
	bh=5pO+ZbJBiKF+8HzvvZrb0HsfINUvdJ8Wqgm3JNb3NAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svhWT6tP1+c+/KgowtmArbfl4goVnjc329sRzNQUkM7CuqCgQvBd/+d5WwmSf9J70yIDRhyL0opaHqbmPI8s6niwi82WG9MkS0BjULnNdIq9CC31EWkcc9mUSzrx/0tQhHh/b4NtuzDH2apIK0KXWd2/VeD5rYsIjlJdF+HfmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mliAS2aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF18C2BCB7;
	Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363304;
	bh=5pO+ZbJBiKF+8HzvvZrb0HsfINUvdJ8Wqgm3JNb3NAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mliAS2aXbTtYu3kPlMbNKuOSVqiyT8lI9Okr6nFdgrT7BZtxuRI9mAe4Njc6B5AoS
	 /sxTD93xoV+0KxZxiF58zUOvREPb9PBBHXzvteBS0pD8k6CtCJ5IbZjfWZPMG8b4M/
	 mfYJNjclmW53vfdsKbOYmimneTrovhJj9gDs7W3UJT271OY4l2dLGRf99HR+L5ygtK
	 4yD1AkJWiuF514hlXjb7GejiCpmq8Vg+bWUh3rbOV5+ZOLqiG/xLAbPcQD69Tdf6MY
	 M32iBccn8J4kLdyU6zusby5ZWfXFd/K+C8LavViL4hk14NyQGMUzGChMTuEjteUIRL
	 JfFBfaet5/dNw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:40 -0700
Subject: [PATCH pynfs v2 08/25] server41tests: test mkdir triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-8-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5pO+ZbJBiKF+8HzvvZrb0HsfINUvdJ8Wqgm3JNb3NAI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScgaUjepv3d3gHmQ3jhlsy1l6cQS1eHjkxE5
 ikaG5F4tbGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIAAKCRAADmhBGVaC
 FSj+D/oCr95UxgqRM+43Sw/QerTpcrYUS3LH3DMt9nS6ZYPqceW9N/Htjw9iSrHHVzzoZ8JQLHg
 Fqp+r0K36kQJf8hER4iS3qLvNpIqQLy2ckCFLQ3vCfKwN8nTBlMwG67oeC0yfZuKY9B6rTupeks
 hibjalYoO3WecdgfRfF7qiYRDwcI9GfwfspL5IG9Zufd0NR0fghIvQOY/BVthKhM9O8uHA3yKfK
 Q+KMn8XvrjMCJw3xe6BhiZy23CgdKdlCHJj+yEkZ3vKavieHrhJOdH2vvnXfn1oMIHJ9tW+8OOQ
 1BRxXez4s05l98UVOr2Z6I1BBDEw8MydD+WDDsp35kHX/vMQsTBTzWWZZxZ6pLYdVdfMfIL+1pi
 9u/+BLGNK9q3cbHuP5a1eC/WWLBFGHkKYfK1xxFFcVNySnJNwGgNoTo4Z4lRSZsxejjXVUBtdhA
 plXsbGHcUsnTaeiz8mkNYDsvVmAN9pUzTsR99N5yN/Mdv80Hnr1EtFytLTDJRitAfqv0peZ3fet
 pBvQLSvA1bx7AvfcsuGBd2KE6SyGbJ+lzm8em4Y2AJOt7G75wK0FqQUjpR0HPGDB39WbG3dy1aS
 6ANFnVBd+AmKxphHIrH+5xHFj5aA9eTNXAI267YOuF6tBe/MZcG+sClbokmx2SytbXRPK6ow3no
 /8Ce/t3oamLjnYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20910-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B17E413A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get a dir delegation with no notification mask, then create a
subdirectory from a second client. Verify that the server issues
a CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index d8d09cd4bf7e..4c483950fd4a 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -208,3 +208,26 @@ def testDirDelegRenameRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegMkdirRecall(t, env):
+    """Verify mkdir triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG5
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a subdirectory from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    create_op = [ op.putfh(fh),
+                  op.create(createtype4(NF4DIR), env.testname(t),
+                            {FATTR4_MODE: 0o755}) ]
+    slot = sess2.compound_async(create_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.53.0


