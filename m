Return-Path: <linux-nfs+bounces-9706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EBA20025
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80747A23CE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 21:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D511DAC97;
	Mon, 27 Jan 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSKa9YE1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31D1DAC95
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014660; cv=none; b=hn7mYclO/bj5xvCa+SeEZwwpV2vnV97eblC9d7qhDUgYJzBkbyHR4WPl5Y3WXl4cuZSTaoF46dwcJimBOWLkqeEPoct78c9rmoPeYtDXkQDVn0DBWJSdUhTij+CCk/35FxwYKXHfPj8cA8w9creOvKuCqpUvOe5ejaB/tMT1r4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014660; c=relaxed/simple;
	bh=ksKlAQbUo2hHW6RukwWHjBNOmHlHjfCf5vZtlAfnkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+v54/Pmaxsdl2LCKivZH5VAroB8pP9xlFSZiyxaL4JYz1dwCYZk8+8FTwN67h054ObA99gNGtxPKU9BuCe15K67du+aMkUtHcmM1h7NLlmhg0U6eeV8g3AtBbnA1dIuc+if9qRjvXWrOi125QmY7itQaw08q0zV/CIIQyd0zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSKa9YE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33C4C4CEE0;
	Mon, 27 Jan 2025 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014660;
	bh=ksKlAQbUo2hHW6RukwWHjBNOmHlHjfCf5vZtlAfnkZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSKa9YE1aresBZRLuGzwFuO1TdJC8b3+YAS8IAH9NOBRpnWJlx09S602R9SL0nlqL
	 qTfg7O2P6IzDVctBm8d6HM3o6iMia0JFSJOhrwasqMRnbbcKARNDRKOUInK9rp0e+m
	 TILgbmKvoH5d+Y86k1erUanfGbydE9qAcu5JghYem3S7lVi5Lkb1TbE8gW1xy8nCG8
	 ZuCDZEqEztfwJs5CYN23oFVRdLcU0+VOnMnFQg4BrgJiuNiFN22KJL2EEIZdcJGeKF
	 AZVLy7FW7ryNr2/YHJShh3uEI4PkHOYK2ncYeheE3ohJuG1Am0Lnpho9sC9WkXsLtz
	 Zc8eP/fCWATVg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 4/4] rpcctl: Add support for `rpcctl switch add-xprt`
Date: Mon, 27 Jan 2025 16:50:56 -0500
Message-ID: <20250127215056.352658-5-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127215056.352658-1-anna@kernel.org>
References: <20250127215056.352658-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This is used to add an xprt to the switch at runtime.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.man |  4 ++++
 tools/rpcctl/rpcctl.py  | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
index b87ba0df41c0..2ee168c8f3c5 100644
--- a/tools/rpcctl/rpcctl.man
+++ b/tools/rpcctl/rpcctl.man
@@ -12,6 +12,7 @@ rpcctl \- Displays SunRPC connection information
 .BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
 .P
 .BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
+.BR "rpcctl switch add-xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
 .BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
 .BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
 .P
@@ -29,6 +30,9 @@ Show detailed information about the RPC clients on this system.
 If \fICLIENT \fRwas provided, then only show information about a single RPC client.
 .P
 .SS rpcctl switch \fR- \fBCommands operating on groups of transports
+.IP "\fBadd-xprt \fISWITCH"
+Add an aditional transport to the \fISWITCH\fR.
+Note that the new transport will take its values from the "main" transport.
 .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
 Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
 \fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 130f245a64e8..29ae7d26f50e 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -213,6 +213,12 @@ class XprtSwitch:
         parser.set_defaults(func=XprtSwitch.show, switch=None)
         subparser = parser.add_subparsers()
 
+        add = subparser.add_parser("add-xprt",
+                                   help="Add an xprt to the switch")
+        add.add_argument("switch", metavar="SWITCH", nargs=1,
+                         help="Name of a specific xprt switch to modify")
+        add.set_defaults(func=XprtSwitch.add_xprt)
+
         show = subparser.add_parser("show", help="Show xprt switches")
         show.add_argument("switch", metavar="SWITCH", nargs='?',
                           help="Name of a specific switch to show")
@@ -236,6 +242,11 @@ class XprtSwitch:
             return [XprtSwitch(xprt_switches / name)]
         return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
 
+    def add_xprt(args):
+        """Handle the `rpcctl switch add-xprt` command."""
+        for switch in XprtSwitch.get_by_name(args.switch[0]):
+            write_sysfs_file(switch.path / "add_xprt", "1")
+
     def show(args):
         """Handle the `rpcctl switch show` command."""
         for switch in XprtSwitch.get_by_name(args.switch):
-- 
2.48.1


