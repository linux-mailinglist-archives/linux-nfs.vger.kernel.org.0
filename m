Return-Path: <linux-nfs+bounces-9261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC683A12C97
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE041653AD
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC81D9A60;
	Wed, 15 Jan 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeNyk9/P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C11D968E
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973001; cv=none; b=uy9OduNwrXonOUTVb37Q4jFkx0zZz786RFUJrwWPm2kdVY6MSG4mxNPfdPRH1qVcTmcF3pLYiu0DFnA7tS9q0hBqYv1S+GTDFDPGerwH+zU9C9bZRzwKm5P1FjNsL0W7ICet3PruP+t4AKkvmIcKkDEJrib/zWDrxn7EuVWp4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973001; c=relaxed/simple;
	bh=W6qK0Ba520y4HCa8GGP6e6N7kAmdoqUl7Q5Czvi8mmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoK+seoIYsy9HLFhCvZHbquZlvK1HpMqQ1zD0RVQamUW16vqKuCSeH7KU++O/MpNlS46IV7Aacl7wPB7JG3Aa9AqIJp27GvMLLFmZji2uOrc9wF7/DhDceqF0H+qVS+If85E18MFQy0ZRFBQfGQh3nK8mWztbH9Fg7TS7T2huL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeNyk9/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5E7C4CEE2;
	Wed, 15 Jan 2025 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736973001;
	bh=W6qK0Ba520y4HCa8GGP6e6N7kAmdoqUl7Q5Czvi8mmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeNyk9/PMMiG4eOv9KMplonF9YR2e/tPHVl41Krunxo/DXq1FkNIRItQakSNpHbjI
	 vZSCrQtKuSwx8cm/X/rbAmsgpV6T74XC9uGJJC/oOfHMG0YGSgTSr8G4/1yKl675De
	 gOrv0zacmxuDmKRWOe4U+sU6Ro2kVI0E8GLMZ5eiTc2Ulq8tkWP6oBHYpm/tRXRRjD
	 3Y+wtrHC0aOOF6kPW9V+dj44oa5cGc4LNNpozRmcx+gUwfuS4CvAlHcbcW0C0rLl1w
	 1h+ColbEEmHVQKsioEakegQQZP3v0kLCARCxNQWubFNvNsxX1U1byzedCV/uqVvQk1
	 I2osS+Gm/PoFA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v3 6/7] rpcctl: Add missing docstrings to the XprtSwitch class
Date: Wed, 15 Jan 2025 15:29:55 -0500
Message-ID: <20250115202957.113352-7-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115202957.113352-1-anna@kernel.org>
References: <20250115202957.113352-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index b8808787b51d..adeb26d51f0e 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -177,7 +177,10 @@ class Xprt:
 
 
 class XprtSwitch:
+    """Represents a group of xprt connections."""
+
     def __init__(self, path, sep=":"):
+        """Read in xprt switch information from sysfs."""
         self.path = path
         self.name = path.stem
         self.info = read_info_file(path / "xprt_switch_info")
@@ -186,9 +189,11 @@ class XprtSwitch:
         self.sep = sep
 
     def __lt__(self, rhs):
+        """Compare the name of two xprt switch instances."""
         return self.name < rhs.name
 
     def __str__(self):
+        """Return a string representation of an xprt switch."""
         switch = f"{self.name}{self.sep} " \
                  f"xprts {self.info['num_xprts']}, " \
                  f"active {self.info['num_active']}, " \
@@ -197,6 +202,7 @@ class XprtSwitch:
         return "\n".join([switch] + xprts)
 
     def add_command(subparser):
+        """Add parser options for the `rpcctl switch` command."""
         parser = subparser.add_parser("switch",
                                       help="Commands for xprt switches")
         parser.set_defaults(func=XprtSwitch.show, switch=None)
@@ -219,16 +225,19 @@ class XprtSwitch:
         dstaddr.set_defaults(func=XprtSwitch.set_property, property="dstaddr")
 
     def get_by_name(name):
+        """Find a (sorted) list of XprtSwitches matching the given name."""
         xprt_switches = sunrpc / "xprt-switches"
         if name:
             return [XprtSwitch(xprt_switches / name)]
         return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
 
     def show(args):
+        """Handle the `rpcctl switch show` command."""
         for switch in XprtSwitch.get_by_name(args.switch):
             print(switch)
 
     def set_property(args):
+        """Handle the `rpcctl switch set` command."""
         for switch in XprtSwitch.get_by_name(args.switch[0]):
             resolved = socket.gethostbyname(args.newaddr[0])
             for xprt in switch.xprts:
-- 
2.48.1


