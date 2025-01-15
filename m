Return-Path: <linux-nfs+bounces-9246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA3A12C6C
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955EF1887B24
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819C1D79B3;
	Wed, 15 Jan 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxd2LJiv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411B14B959
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972436; cv=none; b=mg2SU3H5R5hqPPICl/LBJgUdsRO19psXTYq8eI+kkr6tBaPYmVFF+9sQPbxr/q7t2is6TP3Kt+z6on7CL3UdjsCqjXBn/aRfQPeFPXcBIW4UIMwWNIGE8zTBytFej58+iA+N2KdAZe+bhkxq2XG7kjUr2gYDp87EZ2Jq4pgr790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972436; c=relaxed/simple;
	bh=zOSbceTeKC7qw9xvmniEI0oBQi3LGK+l31VEbrFIOHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4AgffK0wUPMEcpK6EtuPLVm2BR18hyjFtzgknpO6XZPJm7KCmabv1BjRRhX59To3Q+R4IFmyCfdtnYmnbNq9LQv0Oyfr/GE8moQ+Iwcy7/7n0nk4xSxYOFJox0phMflqW/1IYx8U18MwIFgA9jUA90sm5mBHl7Sa1ejgwovx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxd2LJiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDA2C4CED1;
	Wed, 15 Jan 2025 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736972436;
	bh=zOSbceTeKC7qw9xvmniEI0oBQi3LGK+l31VEbrFIOHc=;
	h=From:To:Cc:Subject:Date:From;
	b=kxd2LJivJdpayGpVbyJrBR0PA1DZ1NTm/sfinA7AmyYlPTs4m/glbOifQ8aJja5Rt
	 BeuQQMiKTPV9hbxpIRnrNtQpTqWBjkB9qa3y6VrSS/xRc58iePsmqyPPtYaHwdGieP
	 BqzMQUcYehkNEvFBom4/JUeiORNOgjd6hArLHgzp707q6UcIWqOZPPbYu8cbruA9Xm
	 s8y3xEzlDSfjgfdAnlh6BxUf77S47JEQLMAb+nFF9amyDbzSQbAcL/868hwWzD/KsM
	 MHKM7naMGUeO4qu2bDBkl14uJc7sO70crBbPdoLX5aPqS09UT5ZvdtXHF+daDYwIqS
	 P9Y2MwL0d32mw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH nfs-utils v2 0/8] rpcctl: Flake8 cleanups
Date: Wed, 15 Jan 2025 15:20:27 -0500
Message-ID: <20250115202035.112122-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This is a series of cleanups for rpcctl.py to fix up various style
issues after running `flake8` on the code.

Thoughts?
Anna

Anna Schumaker (7):
  rpcctl: Fix flake8 whitespace errors
  rpcctl: Fix flake8 line-too-long errors
  rpcctl: Fix flake8 bare exception error
  rpcctl: Fix flake8 ambiguous-variable-name error
  rpcctl: Add missing docstrings to the Xprt class
  rpcctl: Add missing docstrings to the XprtSwitch class
  rpcctl: Add remaining missing docstrings

Joshua Kaldon (1):
  Patch for broken libnfsimapd static and regex plugins.

 support/nfsidmap/Makefile.am |   6 +-
 tools/rpcctl/rpcctl.py       | 107 ++++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 30 deletions(-)

-- 
2.48.1


