Return-Path: <linux-nfs+bounces-22874-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQCxJIIZQmqz0AkAu9opvQ
	(envelope-from <linux-nfs+bounces-22874-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:06:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 442496D6B89
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 09:06:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=DTyF292T;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22874-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22874-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C934E30441FE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A253BCD25;
	Mon, 29 Jun 2026 07:00:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06192389460;
	Mon, 29 Jun 2026 07:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716410; cv=none; b=pHTC4CdadvwDewVekjAGe5qURw18HX25kULuUo05xrU1q+SUdEpuOpaQ+EDH2uxUE3k5/hi9m1Bk+/w/kW2PvrW0hDMIijWgScHX38xgZLRCKDpSHqOl4SDCRwR/XdGyy+RS2ugEx9Dx0kCgtWiFNb7VAdOreYmoWCGmN4+lGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716410; c=relaxed/simple;
	bh=Ac33HgCnYr91FemwbZjRFGPqCefF7mMDUXEXdSEMdMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naY8X7E4UiJ7PmdXKkmgR3aZGLHJmYOy7kbop15JCGBXD5iyrfTM+m3MtE9gUiqdWaFGviuPWzoe7rbbuMXg7k88N4hoKjggmuyRnDo2H8aO6WhjSEd9GupPH9I6uYR5fefFnsfvTq4U+o1/WHP76hnIramTjBwkpvVnboV15qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTyF292T; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 47932138025A;
	Mon, 29 Jun 2026 03:00:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782716404; x=1782723604; bh=B
	5uJyVeqcblYARkckk7EGBGO7z8uqVkv5wZg+3CrurA=; b=DTyF292T6lt//iu4v
	GddKQ1SoxFXICKD7rqXkP04aRI4ZZO3xJHgaUXpqK3ygcmBa2nAsucNbAsdgr4Q1
	BvFKkFtUKlDWdi+N7y5XoKD89wsXGtZswf/mIXCMH+fLC/xxHfnURXSaonHyLh8O
	4ARQRGv4dzsF03TR0BbnR5X/ybaGXB3tLddeWLLnHVC8Aqr3L9XODy6U0QDaXIbO
	frJY5QyQaTz9OvRyBrP9zqzRqv8gB7R8ACeYhjTF85bDvNsON7KvTn9dn+swJ1yt
	6K1/v0qmEZd4EmdkkuwfTvOPzbubdIVFSSyS1C1XXHJiHKcGEj4y69z3w7iQEgrK
	uR1lA==
X-ME-Sender: <xms:8xdCajSeYqRFI3fMMI7W9Dw9JnhmQ8QbJQ80l-g4lFlPixxseBin4A>
    <xme:8xdCanZTBRwM5rLODE3NQXzWCcieWofXIHUmulUNAkNPizn79TRFKiIsot1xyjrMp
    w3_pGJrBYm0qxCCi8vvricjwm4SyAaiY5Ww_upxbPOwLRzEPlfT7p8>
X-ME-Received: <xmr:8xdCaoU7IlbtAgqXp0UVEgo-XUF20aJV8zV19YoC4fRMgugaJkg3IS5cqgSnTlnpOk30GinyA8nwQJD8Y6jXktoRR9smGC3FnnGGUg>
X-ME-Proxy-Cause: dmFkZTFXRXqXXHQig7aOEXscQpb861yO5R1n/JZ6/neobiLJxdwcQzvLtKpg3rAKseaAOK
    QsJhQwi62/No698HcwnilN3sG7YXlAfqWy/lDrcLEbeiS6jMSOcpT8xMw4CYYBtDSPh9ua
    fbkHZ4sq8c9RILgSHAvyMaHp4hjTZcdv0ZCaXt3xRyvWX2TfrkxRsebc3IizW4gRw8G5PK
    egy7dn1PuCGj8lbOqc95xmreGYhBGeCRsZ8NvMQ3TGqmgXLN4na69GZ07y8Q5aNxwOSqVq
    phXG20pRAzX8AuKD1hIURFKnXT3/UUySz0y1LRBFEWGzEXoNvnA32P6m9f2FXjRHKlHnjG
    uVx5FkI9cPsfehdey9xRO2DaZdpaaghmgNhrvhLMbExMmXcQr+XpDngBYIsShmn797DSgd
    ozAaDmFR36lK96s+dqQyxNOVWoNgzO76JdJtjB1d/OZLPYN4+ttsX770KMmT9liWq3ZB51
    GFk8xwIp+t50GZS0OKUX/SJQG/UFvybMB5bwloOA0sVPhc7VCD07Y861sQm+8FNX679nYa
    QSmi4HPsZRQGfFt15LzCxOJLYA7ArfS3XpGs3sJ4BxLiUtTUUsPGWu0xE1xk9qNR/Ztkty
    oRtGvbXI2ly3Gw7OnA8umU4oXr5s4zGWRgjMLv7cXje0Wu7wxh1XDyvxd0JA
X-ME-Proxy: <xmx:8xdCakXJLlJ12iGI76VUv6wieQQUTa7ZmliyJjdwS_71fKtoV8-d7Q>
    <xmx:8xdCaq_WzUt6IO0CA6djgl_cde9bqK_xL-wQ3_Y6qA_VUbNf88d2MA>
    <xmx:8xdCahqkbNpgoB5B722LURmE8WAYm9U5VQSv2IEY4TOuAuzpGCL2tA>
    <xmx:8xdCamfmaft_eUPQiYLE-0XGCjOFR8rFkqLWaficRqjRCXf17bbLnA>
    <xmx:9BdCal7vl_khmTAxqix_MLmz4sKUkBN72BfrMR6C9Uaky6PPR1oJOap9>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:00:00 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "Andy Lutomirski" <luto@kernel.org>,	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,	"Jan Kara" <jack@suse.cz>,
	"David Howells" <dhowells@redhat.com>,	"Chuck Lever" <cel@kernel.org>,
	"Jeff Layton" <jlayton@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"David Laight" <david.laight.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,	"Li Chen" <me@linux.beauty>,
	"Cong Wang" <cwang@multikernel.io>,	"Arnd Bergmann" <arnd@arndb.de>,
	"Thomas Gleixner" <tglx@kernel.org>,	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"Jonathan Corbet" <corbet@lwn.net>,	"Kees Cook" <kees@kernel.org>,
	"Sergei Zimmerman" <sergei@zimmerman.foo>,
	"Farid Zakaria" <farid.m.zakaria@gmail.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-api <linux-api@vger.kernel.org>,	netfs <netfs@lists.linux.dev>,
	linux-nfs <linux-nfs@vger.kernel.org>
Cc: John Ericson <mail@JohnEricson.me>
Subject: [RFC PATCH 3/3] fs: add KUnit tests for tasks with a null root or cwd
Date: Mon, 29 Jun 2026 02:58:22 -0400
Message-ID: <20260629065934.1425479-4-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
References: <20260629065934.1425479-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-22874-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,redhat.com,linuxfoundation.org,gmail.com,zytor.com,linux.beauty,multikernel.io,arndb.de,alien8.de,linux.intel.com,lwn.net,zimmerman.foo,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dhowells@redhat.com,m:cel@kernel.org,m:jlayton@kernel.org,m:skhan@linuxfoundation.org,m:david.laight.linux@gmail.com,m:hpa@zytor.com,m:me@linux.beauty,m:cwang@multikernel.io,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:corbet@lwn.net,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:netfs@lists.linux.dev,m:linux-nfs@vger.kernel.org,m:mail@JohnEricson.me,m:davidlaightlinux@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,johnericson.me:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,Obsidian.Systems:mid,Obsidian.Systems:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 442496D6B89

From: John Ericson <mail@JohnEricson.me>

A KUnit suite (`CONFIG_NULL_ROOT_CWD_KUNIT_TEST`) exercises the previous
patch against a task whose own root and/or cwd it nulls: absolute and
`AT_FDCWD`-relative lookups fail, `..` climbs, and descriptor-anchored
lookups keep working. Each test unshares its `fs_struct` so it only ever
touches a private copy, and restores the original root/cwd afterwards.

It is gated by `CONFIG_NULL_ROOT_CWD_KUNIT_TEST` and `#include`d into
`fs/fs_struct.c`, following the `fs/tests/*_kunit.c` pattern.

Link: https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/
Signed-off-by: John Ericson <mail@JohnEricson.me>
Assisted-by: Claude:claude-opus-4-8
---
 fs/Kconfig                     |  11 +++
 fs/fs_struct.c                 |   4 +
 fs/tests/null_root_cwd_kunit.c | 147 +++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 fs/tests/null_root_cwd_kunit.c

diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..9023597b6e2b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -18,6 +18,17 @@ config VALIDATE_FS_PARSER
 config FS_IOMAP
 	bool
 
+config NULL_ROOT_CWD_KUNIT_TEST
+	bool "KUnit tests for tasks with a null root or cwd" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests that exercise path resolution for tasks whose
+	  fs->root and/or fs->pwd is the NULL path (no root directory and/or
+	  no current working directory).
+
+	  If unsure, say N.
+
 # Stackable filesystems
 config FS_STACK
 	bool
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..bf620bba7f35 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -153,3 +153,7 @@ struct fs_struct init_fs = {
 	.seq		= __SEQLOCK_UNLOCKED(init_fs.seq),
 	.umask		= 0022,
 };
+
+#ifdef CONFIG_NULL_ROOT_CWD_KUNIT_TEST
+#include "tests/null_root_cwd_kunit.c"
+#endif
diff --git a/fs/tests/null_root_cwd_kunit.c b/fs/tests/null_root_cwd_kunit.c
new file mode 100644
index 000000000000..3fb7e63545f8
--- /dev/null
+++ b/fs/tests/null_root_cwd_kunit.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for tasks whose fs->root and/or fs->pwd is the NULL path.
+ * See "fs: support tasks with a null root or cwd".
+ *
+ * Each test runs against this task's own fs_struct. We unshare it first
+ * so we only ever touch a private copy, never the shared one, and we
+ * restore the original root/cwd afterwards.
+ */
+#include <kunit/test.h>
+#include <linux/fs_struct.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+
+/* The NULL path: { .mnt = NULL, .dentry = NULL }. */
+static const struct path null_path;
+
+struct null_fs_ctx {
+	struct path saved_root;
+	struct path saved_pwd;
+	struct path anchor;	/* a real directory, standing in for a dirfd */
+};
+
+static int null_fs_setup(struct null_fs_ctx *ctx)
+{
+	int err;
+
+	err = unshare_fs_struct();
+	if (err)
+		return err;
+	err = kern_path("/", LOOKUP_DIRECTORY, &ctx->anchor);
+	if (err)
+		return err;
+	get_fs_root(current->fs, &ctx->saved_root);
+	get_fs_pwd(current->fs, &ctx->saved_pwd);
+	return 0;
+}
+
+static void null_fs_teardown(struct null_fs_ctx *ctx)
+{
+	set_fs_root(current->fs, &ctx->saved_root);
+	set_fs_pwd(current->fs, &ctx->saved_pwd);
+	path_put(&ctx->saved_root);
+	path_put(&ctx->saved_pwd);
+	path_put(&ctx->anchor);
+}
+
+/* Resolve @name, drop any reference it returns, and yield the errno. */
+static int try_kern_path(const char *name)
+{
+	struct path out;
+	int err = kern_path(name, 0, &out);
+
+	if (!err)
+		path_put(&out);
+	return err;
+}
+
+static int try_fd_relative(struct null_fs_ctx *ctx, const char *name)
+{
+	struct path out;
+	int err = vfs_path_lookup(ctx->anchor.dentry, ctx->anchor.mnt,
+				  name, 0, &out);
+
+	if (!err)
+		path_put(&out);
+	return err;
+}
+
+/* No root: absolute paths fail, but ".." climbs and the cwd still works. */
+static void null_root_test(struct kunit *test)
+{
+	struct null_fs_ctx ctx;
+
+	KUNIT_ASSERT_EQ(test, null_fs_setup(&ctx), 0);
+	set_fs_root(current->fs, &null_path);
+
+	/* A leading '/' has nothing to anchor to. */
+	KUNIT_EXPECT_EQ(test, try_kern_path("/"), -ENOENT);
+
+	/* ".." is unbounded rather than refused (it would have been
+	 * -ENOENT before this feature). It starts from the still-present
+	 * cwd and runs out of parents at the mount root.
+	 */
+	KUNIT_EXPECT_EQ(test, try_kern_path(".."), 0);
+
+	/* The cwd is untouched: AT_FDCWD-relative lookups still resolve. */
+	KUNIT_EXPECT_EQ(test, try_kern_path("."), 0);
+
+	/* A dirfd-anchored lookup never consults fs->root. */
+	KUNIT_EXPECT_EQ(test, try_fd_relative(&ctx, "."), 0);
+
+	null_fs_teardown(&ctx);
+}
+
+/* No cwd: AT_FDCWD-relative paths fail, but absolute and dirfds work. */
+static void null_cwd_test(struct kunit *test)
+{
+	struct null_fs_ctx ctx;
+
+	KUNIT_ASSERT_EQ(test, null_fs_setup(&ctx), 0);
+	set_fs_pwd(current->fs, &null_path);
+
+	/* Relative-to-cwd lookups have no starting point. */
+	KUNIT_EXPECT_EQ(test, try_kern_path("."), -ENOENT);
+	KUNIT_EXPECT_EQ(test, try_kern_path("foo"), -ENOENT);
+
+	/* The root is untouched: absolute lookups still resolve. */
+	KUNIT_EXPECT_EQ(test, try_kern_path("/"), 0);
+
+	/* A dirfd-anchored lookup never consults fs->pwd. */
+	KUNIT_EXPECT_EQ(test, try_fd_relative(&ctx, "."), 0);
+
+	null_fs_teardown(&ctx);
+}
+
+/* Neither root nor cwd: only descriptor-relative lookups remain. */
+static void null_root_and_cwd_test(struct kunit *test)
+{
+	struct null_fs_ctx ctx;
+
+	KUNIT_ASSERT_EQ(test, null_fs_setup(&ctx), 0);
+	set_fs_root(current->fs, &null_path);
+	set_fs_pwd(current->fs, &null_path);
+
+	KUNIT_EXPECT_EQ(test, try_kern_path("/"), -ENOENT);
+	KUNIT_EXPECT_EQ(test, try_kern_path("."), -ENOENT);
+
+	/* The held descriptor still names files. */
+	KUNIT_EXPECT_EQ(test, try_fd_relative(&ctx, "."), 0);
+
+	null_fs_teardown(&ctx);
+}
+
+static struct kunit_case null_root_cwd_test_cases[] = {
+	KUNIT_CASE(null_root_test),
+	KUNIT_CASE(null_cwd_test),
+	KUNIT_CASE(null_root_and_cwd_test),
+	{},
+};
+
+static struct kunit_suite null_root_cwd_test_suite = {
+	.name = "null_root_cwd",
+	.test_cases = null_root_cwd_test_cases,
+};
+
+kunit_test_suite(null_root_cwd_test_suite);
-- 
2.51.2


