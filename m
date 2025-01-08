Return-Path: <linux-nfs+bounces-8998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2412A0674E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CEB3A63DD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36692046A1;
	Wed,  8 Jan 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd64+a8N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003220469C
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372253; cv=none; b=hNrLDccfcLXu0jlXQwYnSuxIVwJjHUnhKojYbn1BX4lqm83Zf4PdHho18H6h8rueKVpUiTYUnw8E9GeMnfGfe0RbTou4v5n0oTHEpUGQ+vcW4LQucwv1BbhRUwkTrR3NtFusjwgdE71iWmpYLbeXdBnsDKOSIUXWj96qio1YbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372253; c=relaxed/simple;
	bh=flcgskvrmIU/Aqh8316x+t5NHkXN4cH6AcMOVPQ7mGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9Cj9WmHTZ7101gB11ZenSUmSlTyBYlZsah/G7AdgFrmuoIMK3lzc8o3V8QHZ/R9AysoQ/NIgASEICFqUV6T+cpJ/69tAjiZbzAkdPWKZGtWKk30ju+FyMYd8rZEz1Aea2VAL+t9LpmcijOAvRUk9Q++axay8XeT82E0u9YNFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd64+a8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03260C4CEE4;
	Wed,  8 Jan 2025 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372253;
	bh=flcgskvrmIU/Aqh8316x+t5NHkXN4cH6AcMOVPQ7mGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sd64+a8Nt7ycZwUDSxhf0phfmZm4c/BQDM122DdWUM0T9xT3bDwhU2bGqOmwXCsJS
	 7dy/hbvw3vz5uawBBsPjzS9INAvh2nhgi3QcNoFwMQGKC+kWbFqs9+VflZ/EfmPd9P
	 +Ok0Sxfc9PwvK20TTh1Dypc6jiltAYf6XyxEI9MGoWPpRO/5z4N0+sL0mIlrmSGHHS
	 EMWFz/th8o3TQno+UJ3hv5rVfAfcE8IsUXZwrhV4eGJCcW+mLhUVVuU6hCWep9Gk0m
	 AHOISo15umRROq8Ik3gJoqX9AWu9r0U27KSSqv2/iDriXCofoOP1gf9odfL7FXmDzY
	 mA5FkLkDsOwMQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 10/10] rpcctl: Add support for `rpcctl switch add-xprt`
Date: Wed,  8 Jan 2025 16:37:26 -0500
Message-ID: <20250108213726.260664-11-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213726.260664-1-anna@kernel.org>
References: <20250108213726.260664-1-anna@kernel.org>
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
index 20f90d6ca796..8722c259e909 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -223,6 +223,12 @@ class XprtSwitch:
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
@@ -246,6 +252,11 @@ class XprtSwitch:
             return [XprtSwitch(xprt_switches / name)]
         return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
 
+    def add_xprt(args):
+        """Handle the `rpcctl switch add-xprt` command."""
+        for switch in XprtSwitch.get_by_name(args.switch[0]):
+            write_sysfs_file(switch.path / "xprt_switch_add_xprt", "1")
+
     def show(args):
         """Handle the `rpcctl switch show` command."""
         for switch in XprtSwitch.get_by_name(args.switch):
-- 
2.47.1


