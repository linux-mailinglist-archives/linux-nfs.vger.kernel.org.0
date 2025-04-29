Return-Path: <linux-nfs+bounces-11357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05BAA1AB4
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630655A3A8C
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC092252905;
	Tue, 29 Apr 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyaFVqXJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB624E00F
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951599; cv=none; b=PVSndiruHv4QGnSC76CyErY+odDQDuOegzfI5YhI94VzxeRT0wEWS8F6QpdWlTTCh5PQ0La3EXF0e6YmRfNN2hW9sel4iauikjvCoPsETzxNXWD+3o2pkv8sGPsJkDsU9LoJEtbJ+sHWCynZess2Lm/JU1xs3W6N61PaLcNAA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951599; c=relaxed/simple;
	bh=C5gTWLmLweI3a5m95ZKh1Nydn5/qxfD0VIiL+5DFBm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiJXqVR/bgf0zMipSL8dDBZ/aompBE/JgNxXDJy6j7/ihzChJeINGH5msI9liJ5mkkHqdfBBFy18q2WGUa0vst1hIh+TLIZKX7AGbx/QRaDIBa7RONCAyeWXcE3AUGM2U5Hj2MAARPQMkPmDSBzVJX+60l9QdXRvu/zTnZZOttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyaFVqXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED295C4CEE3;
	Tue, 29 Apr 2025 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951599;
	bh=C5gTWLmLweI3a5m95ZKh1Nydn5/qxfD0VIiL+5DFBm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyaFVqXJ/kae/nHGMv25vXTAoBdXFt5DOJedzfRRQ0x2bRfIUbL59aGtIlZzd4k/p
	 wwKLlIra97qBGbg7/u7ykFW6XJ55azQVZJdFrFAouOhls2OD1VZRmqmhlicH9OG4Qv
	 yNZpyHw7SEje+4UoME340KBHREM0dw7yXYCvroxmQwchGu56Ditg6mghRWUFN0sXfW
	 4ixjMLr1uPcoKp8QMpRz6+aS+Sp2qIhe1cC9NI47YfvPAPSYwr2ulNQinbTUye3+22
	 fsE+P5B3c+LDbmGydIGV32GA9Wl0iKbIOyloQmyoHHPCKhBS3MNkMaPwqmMx/k23yN
	 +lOK8VQRlp+cQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH v3 4/4] rpcctl: Add support for `rpcctl switch add-xprt`
Date: Tue, 29 Apr 2025 14:33:15 -0400
Message-ID: <20250429183315.254059-5-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429183315.254059-1-anna@kernel.org>
References: <20250429183315.254059-1-anna@kernel.org>
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
2.49.0


