Return-Path: <linux-nfs+bounces-23215-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QTscCq3yT2rfqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23215-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C6734CD6
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cJwVqDjU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23215-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23215-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9043163CE3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34744161E;
	Thu,  9 Jul 2026 19:02:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B543F8D2
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623770; cv=none; b=FTVqL1lf2sM8nDVHznJX8SGmHR9m895dFAfowUbpZ5QcRieoMt5TtvIPvpgDQ8Isz89j1DZDdpCpgBP5ntkRCajZD+1NoKnTh7PkusuKO8kv0d8akF1cxZwDBGUQfHwAGiS5fpGMyoJPDBTFkp8NIeVX9wsG7oEyBa/RhV2Ljxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623770; c=relaxed/simple;
	bh=hl5tMB0HvJUzoF1zWiBoiE1lRdGxxavPe0HX2e8yYv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcKQ6f+GNwl/TSHLD/i9ICVBBFE95CYYjhcEqmgKhCCvddAABr3Jh8Z9us5rPga4lay0LzoAzsrlcoc1Zu6y4kHAJDaDE7mWEF3OiL61DB3NhiC0RevMJaxKv4n3lT1cwouNlvy/W+HyWC6ZsM1Pf8wqo0FStsfMiBjF5HJ5x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJwVqDjU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB301F01559;
	Thu,  9 Jul 2026 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623768;
	bh=D45gswM01ehnsftlxsKjS1g5Y535eWWDWaIbPHELRrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cJwVqDjUb243WrM/u5zIml0a0+b7UZG2OTwLbghx48YYlIw3EeP2HMxV4Qk+JLXD0
	 BkFKpNChikyg4YYNxxX/0protDtmhcSZQFEpzRfLQsCNzo8tNhjfYScksBxjnCOQef
	 zP0kUoH9BZsEKx1ipoN3N1zBZKArAauCPDjw4ygIQAmCyIAiSyUA5nUw6AQ3B1rJKb
	 XBl0MGAaUOBeN/cWgJcOrHyU2ZY6A9jq/5lSfmUbU+0Dwn10/p16aAY0AyYfPhF9d2
	 E0aBOrr4M9JUDpS1KJGOI7X9E3VKpC6H0JwvMXER7amAxjsFZ5IsA+c7SAfQ36q9gp
	 Q/F+eHu5xhxXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:30 -0400
Subject: [PATCH pynfs 02/13] server41tests: test COPY with non-zero offsets
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-copy-v1-2-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8500; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hl5tMB0HvJUzoF1zWiBoiE1lRdGxxavPe0HX2e8yYv8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BRQzeoq7Z+ah1AnOsxncWIbBYLxBwZy/0l5
 ulqZSKs0VuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUQAKCRAADmhBGVaC
 FdzjD/9T6rUQnAVgxBdngY/rxVIpCeFI05vt24hGctyeqTUtquXuHiUjVrpXoAfR06xUcz1MJvF
 7khRaFmIYR2h3JAiR7svmN9bAf/oMCAsdj3uQ37KoTXTs4cMBQyD+o3VOy4o7COz4RZ6Zh1aiZq
 dNHYxBGydShyKOSSeHVhbTI1HgdxFj5uvvrd/1P5UQiBGZS3RNC8/kWWLZukFI6RWrj5sl2VTb7
 IB8ogwKLcyTwq2yX2crbjccUwLq1jOHfiFByeZKk/fXS63LYcUDhk/YBjIRTkHn5nZbF5Np4XnX
 EhbNkyyDmijgH0Paxb2uw8xoxL+B1QQHmplGa5G/84NHC8GfXVfPRQ6obsnQR8jXl5tZdqFMR8r
 DYAqsP9gE0KyBO0d2ySayPZaA3Ntl948Dzwc9234GvVCk145Gbq6IWo50MoM9S/B4pBhFCQEO72
 WJcgos5/SiV4kSyQ405WZqZagbD18mUfxGxDajajvVvqRqiY3ov520Oc5xQguOEDQN9Hn/pJPxm
 t4vcb3S9c1BfRNZI5mD5T7NrZa4sAlK42ur5hz3NVS/DIMtY5EOs/HMR+9PJkCk3k4fFXpP2VwZ
 k+NUQ9d2CPQ9bpbMeZokxSO2h73iaVc/Xrn8eH3yD9ZpfiChvrL+zAkRIFwnGzBKE4GMhcp/syI
 Y3egLr1vTw76oPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23215-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,claude.md:url,res.data:url,claude.ai:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A4C6734CD6

Add testCopyWithOffset (COPY2) which copies 4KB from source offset
1024 to destination offset 512, then reads back the destination to
verify the data landed at the correct position.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 CLAUDE.md                                          | 100 +++++++++++++++++++++
 ...ts-add-a-test-for-rename-within-a-dir-wit.patch |  55 ++++++++++++
 nfs4.1/server41tests/st_copy.py                    |  25 ++++++
 3 files changed, 180 insertions(+)

diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 100644
index 000000000000..91a499884990
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1,100 @@
+# CLAUDE.md
+
+This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
+
+## What is pynfs?
+
+pynfs is an NFS protocol conformance testing framework written in Python. It tests NFSv4.0 and NFSv4.1/4.2 servers by sending crafted NFS COMPOUND operations over RPC and verifying responses. Tests require a live NFS server with an exported filesystem.
+
+## Build
+
+```bash
+# Install dependencies (Fedora)
+yum install krb5-devel python3-devel swig python3-gssapi python3-ply
+pip install xdrlib3
+
+# Build (generates XDR code from .x files -- must be done before running tests)
+./setup.py build
+```
+
+Build order matters: xdr → rpc → nfs4.1 → nfs4.0. The top-level setup.py handles this.
+
+## Running Tests
+
+Tests use a **custom test framework** (not pytest). They require a live NFS server.
+
+```bash
+cd nfs4.1
+
+# First run: create test directory tree on server
+./testserver.py SERVER:/export --maketree -v all
+
+# Run all tests
+./testserver.py SERVER:/export -v all
+
+# Run a single test by code
+./testserver.py SERVER:/export OPEN1
+
+# Run a flag group
+./testserver.py SERVER:/export dirdeleg
+
+# Exclude tests: prefix with "no"
+./testserver.py SERVER:/export all nodirdeleg
+./testserver.py SERVER:/export dirdeleg noDIRDELEG3
+
+# Run with dependencies auto-resolved
+./testserver.py SERVER:/export --rundeps DIRDELEG5
+
+# Skip initial tree cleanup (faster for tests that don't need it)
+./testserver.py SERVER:/export --noinit EXID1
+```
+
+NFSv4.0 tests work the same way from the `nfs4.0/` directory.
+
+## Architecture
+
+- **`xdr/`** — XDR parser/code generator (`xdrgen.py` uses PLY). Generates `*_const.py`, `*_type.py`, `*_pack.py` from `.x` definition files. These generated files are gitignored.
+- **`rpc/`** — Shared RPC client library with AUTH_SYS and RPCSEC_GSS support.
+- **`nfs4.1/`** — NFSv4.1/4.2 test suite and utilities. Active development happens here.
+- **`nfs4.0/`** — NFSv4.0 test suite. Older codebase with its own copy of rpc/testmod in `lib/`.
+- **`nfs4.1/testmod.py`** — The custom test framework engine (discovery, dependencies, execution).
+- **`nfs4.1/nfs4client.py`** — NFS4 client implementation built on RPC.
+- **`nfs4.1/nfs_ops.py`** — Operation factory (`op.open()`, `op.putfh()`, `op.rename()`, etc.).
+
+## Writing Tests (NFSv4.1)
+
+Tests live in `nfs4.1/server41tests/st_*.py`. Each test is a function:
+
+```python
+def testMyFeature(t, env):
+    """Describe what this test verifies
+
+    FLAGS: myfeature all
+    CODE: MYFEAT1
+    DEPEND: MYFEAT0
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    res = sess.compound([op.putrootfh()])
+    check(res)
+```
+
+Key conventions:
+- Function name starts with `test`, takes `(t, env)`.
+- **CODE** (required): unique identifier like `OPEN1`, `DIRDELEG5`.
+- **FLAGS**: space-separated group tags. Include `all` for general tests.
+- **DEPEND**: test codes that must pass first.
+- **VERS**: minor version range (e.g., `1-2`).
+- `check(res, NFS4_OK)` is the primary assertion — compares compound result status.
+- `t.fail("msg")` signals failure; `t.pass_warn("msg")` for warnings; `t.fail_support("msg")` for unsupported features.
+- New test modules must be added to `server41tests/__init__.py`'s `__all__` list.
+- Environment helpers in `server41tests/environment.py`: `create_file()`, `open_file()`, `close_file()`, `clean_dir()`, `do_readdir()`, etc.
+
+## Contributing
+
+Patches go to linux-nfs@vger.kernel.org via `git format-patch` / `git send-email`. Commits should be signed off (`git commit -s`). Follow Linux kernel patch submission conventions.
+
+## Notes
+
+- The NFS server under test must allow high-port connections (`insecure` export option on Linux).
+- `use_local.py` in each package manipulates `sys.path` so tests can run directly from the source tree without installation.
+- Test results are not authoritative protocol statements — consult the RFCs if a server fails a test.
diff --git a/nfs4.1/0001-server41tests-add-a-test-for-rename-within-a-dir-wit.patch b/nfs4.1/0001-server41tests-add-a-test-for-rename-within-a-dir-wit.patch
new file mode 100644
index 000000000000..7e855592da85
--- /dev/null
+++ b/nfs4.1/0001-server41tests-add-a-test-for-rename-within-a-dir-wit.patch
@@ -0,0 +1,55 @@
+From 0ce942390b36e00547ea9ea56afdc449a9a50699 Mon Sep 17 00:00:00 2001
+From: Jeff Layton <jlayton@kernel.org>
+Date: Wed, 28 May 2025 12:10:22 -0400
+Subject: [PATCH] server41tests: add a test for rename within a dir with a
+ delegation
+
+Signed-off-by: Jeff Layton <jlayton@kernel.org>
+---
+ nfs4.1/server41tests/st_dir_deleg.py | 33 ++++++++++++++++++++++++++++
+ 1 file changed, 33 insertions(+)
+
+diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
+index 1fbeb6e0efb9..505e46680197 100644
+--- a/nfs4.1/server41tests/st_dir_deleg.py
++++ b/nfs4.1/server41tests/st_dir_deleg.py
+@@ -102,3 +102,36 @@ def testDirDelegRemove(t, env):
+ 
+     if (not completed):
+         fail("I didn't receive a CB_NOTIFY from the server!")
++
++def testDirDelegRename(t, env):
++    """Create a dir_deleg that accepts notification of RENAME events
++
++    FLAGS: dirdeleg all
++    CODE: DIRDELEG2
++    """
++    c = env.c1
++    recall = threading.Event()
++    notify = threading.Event()
++    sess1, fh, deleg = _getDirDeleg(t, env, [NOTIFY4_RENAME_ENTRY], recall, notify)
++
++    claim = open_claim4(CLAIM_NULL, env.testname(t))
++    owner = open_owner4(0, b"owner")
++    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
++    open_op = [ op.putfh(fh), op.open(0, OPEN4_SHARE_ACCESS_WRITE,
++                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
++    res = sess1.compound(open_op)
++    check(res)
++
++    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
++    topdir = c.homedir + [t.code.encode('utf8')]
++    oldpath = b"%s/%s" % (topdir, env.testname(t))
++    newpath = b"%s_2" % oldpath)
++    res = rename_obj(sess2, oldpath, newpath)
++    check(res)
++
++    completed = notify.wait(5)
++    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
++    res = sess1.compound(ops)
++
++    if (not completed):
++        fail("I didn't receive a CB_NOTIFY from the server!")
+-- 
+2.49.0
+
diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index c7e48adf6fbe..bfc64bbe1584 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -97,6 +97,31 @@ def testSyncCopy(t, env):
 
     _verify_data(sess, dst_fh, dst_stateid, data)
 
+def testCopyWithOffset(t, env):
+    """copy with non-zero source and destination offsets
+
+    FLAGS: copy
+    CODE: COPY2
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    data = b"\x00" * 1024 + b"B" * 4096 + b"\x00" * 1024
+    _write_data(sess, src_fh, src_stateid, data)
+
+    dst_fh, dst_stateid = _create_and_open(sess, env.testname(t) + b"_dst")
+
+    res = _do_copy(sess, src_fh, src_stateid, dst_fh, dst_stateid,
+                   src_offset=1024, dst_offset=512, count=4096, synchronous=1)
+    check(res)
+    cr = res.resarray[-1]
+    if cr.cr_response.wr_count != 4096:
+        fail("Expected to copy 4096 bytes, got %d" % cr.cr_response.wr_count)
+
+    res = read_file(sess, dst_fh, 512, 4096, dst_stateid)
+    check(res)
+    if res.data != b"B" * 4096:
+        fail("Destination data at offset 512 does not match expected content")
+
 def testZeroLengthCopy(t, env):
     """test that zero-length copy copies to EOF
 

-- 
2.55.0


