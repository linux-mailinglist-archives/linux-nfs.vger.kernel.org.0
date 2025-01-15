Return-Path: <linux-nfs+bounces-9247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE70A12C6D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F431888F8B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825CE14B959;
	Wed, 15 Jan 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr3xGQCa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54A1D89FA
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972437; cv=none; b=L5b0N3wlb6umsCC973XUi0w4YMmNA4QE2j9LTSf3M6X2y0mJUyF4qaIT1HjxsU8nVMAwf3In6FxecHG7glqJ0HAogOKAG47VeSsv/iw0Tu9u0AYbk+Gw8dUZr4wEvrYrE8vUoKV4+bpU+FjY/tpwthPORemPYIUh8M+5wGqMEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972437; c=relaxed/simple;
	bh=ons201zd7zgdZGm6nNGtUON1uSf9urm/nC22I0yxNmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK7WmpPNalgvHy4o25+jIyNvxLM6hzwz+eDg54jC1WYZebA4nf5JrYVw/D2MQk/PwBvjxpOTP+ZksmdEFhyAhOMP66hYOTeZ8EumWc8CIGBB7lyjofsNE4ow1mXgattUltp5ABHDcM2AsQGV/i/SJP7u7ojwYOIgfUTwQUqdtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr3xGQCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA9BC4CEE1;
	Wed, 15 Jan 2025 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972437;
	bh=ons201zd7zgdZGm6nNGtUON1uSf9urm/nC22I0yxNmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tr3xGQCa+8vugoq9rvBFa0u7K81gNPLAz+TDVvqZK0aWYztbiqjBdR6Xx4oaMv+M2
	 HJmdV2KGEok29NPVPTYWoiLUi+ReWRiXOqsmz/OvRt6MnhHmWX/VdHmdp64zW3RQC9
	 +3JbtcqGY3APPS1woyz34M3HEUzc8FDDgH/BY3k7HV/Yx5HPtfbPjwuJO5UK3RIWFn
	 ekfxhKGVkpF5cQssuiJjKxm8ZB7p07bOMf6koRzyOd2V1TOJFW7VMt1zhsXaHwQHoZ
	 oBiN6HudEdJdUTr4HiN4hNCy7guE1qW+aT9oazyLQbZMIo7ZQI7amcMubXSuTZjs0w
	 LRJxbNu87E1lQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 1/8] Patch for broken libnfsimapd static and regex plugins.
Date: Wed, 15 Jan 2025 15:20:28 -0500
Message-ID: <20250115202035.112122-2-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202035.112122-1-anna@kernel.org>
References: <20250115202035.112122-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Kaldon <joshua@kaldon.com>

It appears that the makefile does not add nfsidmap_common.c in the
sources. nfs-utils (1:2.8.2-1.1~0.1) UNRELEASED; urgency=medium .
Non-maintainer upload.  Fix issue with static and regex plugins
missing symbol get_grnam_buflen.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/support/nfsidmap/Makefile.am b/support/nfsidmap/Makefile.am
index f5b9de0e1e91..b2db18f1b970 100644
--- a/support/nfsidmap/Makefile.am
+++ b/support/nfsidmap/Makefile.am
@@ -40,15 +40,15 @@ nsswitch_la_SOURCES = nss.c nfsidmap_common.c
 nsswitch_la_LDFLAGS = -module -avoid-version
 nsswitch_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-static_la_SOURCES = static.c
+static_la_SOURCES = static.c nfsidmap_common.c
 static_la_LDFLAGS = -module -avoid-version
 static_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-regex_la_SOURCES = regex.c
+regex_la_SOURCES = regex.c nfsidmap_common.c
 regex_la_LDFLAGS = -module -avoid-version
 regex_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-umich_ldap_la_SOURCES = umich_ldap.c
+umich_ldap_la_SOURCES = umich_ldap.c nfsidmap_common.c
 umich_ldap_la_LDFLAGS = -module -avoid-version
 umich_ldap_la_LIBADD = -lldap $(KRB5_GSS_LIB) ../../support/nfs/libnfsconf.la
 
-- 
2.48.1


