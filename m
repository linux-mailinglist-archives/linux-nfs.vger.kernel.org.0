Return-Path: <linux-nfs+bounces-2780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4FF8A2FF4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 15:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB1285961
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740883CC8;
	Fri, 12 Apr 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtC/CHZu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A145BEF
	for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930108; cv=none; b=iPkNRfM+sqEtO1eu3UE1XSwTPygEUMnBupqtGbnRgkidkk5JHoeSta2uBMCLSnA6wpQDVAw+3QDWD3BhSg1Yr07pmH6OjQMrN67jI+LoSF+d2OcrboodmYG+UmAPXMTl4T/ZsxtLOkriIyHVm3BJhdf+uSD6t64ObZTkWMMKFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930108; c=relaxed/simple;
	bh=h5R/r7uSbd/vsvQ2p3eHn/2f/YsjyEX9CYtOknkEqx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfgoGFQdJX3u34XISjTanEBK5bkZye9+EVOOzoUko555rjcKUmsagPwxyBdQI9yqSaV42wzZDPvn2nwNpPF0cNDyJp8uABg/tgU27/vIIseW2aX4nwHrmMSnkKeq++fJGq896/Rk5Bb0SSPTj6W4J9TLXS9pYn0ty7ViQif6unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtC/CHZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B85C113CC;
	Fri, 12 Apr 2024 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712930108;
	bh=h5R/r7uSbd/vsvQ2p3eHn/2f/YsjyEX9CYtOknkEqx4=;
	h=From:Subject:Date:To:Cc:From;
	b=rtC/CHZuuImwaEJD2njJ5yWG0+yf9pyJVf+DaJpjtwYxDfUn/9h7xW0gq7uPEg16g
	 /tt1Mnibguhj3ZB3C72/80a2QE5mKWgV8L+vY/B5OXLcvQ4Re/aoZ1ywCISvIzx2RU
	 ipyJ+zoTBqMp7DX+Ci8tUdfm02FE2OkuK/1C2OQXZ/OqWLLYniVL2qtYbZvNW0jIjf
	 p2JNYPu/iH68PB1lVu3qTAmPQzC/iFrbV8IHzzdVHU0aVkxfhgDhkHpvFG/N8CPjvF
	 9Alw/0quXKNj9Fgiw5i+VYmgzS0jolb/T22NcS1Pl78squNTam97nCFYQcQnJFC9j7
	 tR/UgMCiYNgbQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/2] nfsdctl: new nfs-utils tool for managing the
 kernel NFS server
Date: Fri, 12 Apr 2024 09:54:53 -0400
Message-Id: <20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC09GWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Mj3by04pTkkhzdtESLpBQLE2OD5LQUJaDqgqLUtMwKsEnRSkFuzkq
 xtbUApqqMeV4AAAA=
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=h5R/r7uSbd/vsvQ2p3eHn/2f/YsjyEX9CYtOknkEqx4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmGT029h3UewD7vv4Fjq6trWGIC0riJbgL8BIAt
 y+YpvliawaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhk9NgAKCRAADmhBGVaC
 FXq0EACsF6gDVcNMg65DxT9o66IjxH7fwyChb3cGU4n1RduASku/dvwDTBL82uSGPBApF+tlZlu
 HWsY4QGqJDAJoEWPYehHbiF6S0fMIB7ANEuDSKS1miblFlUcoq14XzbkOp/1iQZx0cL68SjlTXP
 FDMwLvOyVmVeKfyifytwN2KcusiK4EU301XSC3DOcxMxD2PUm5oaYuxnJYzBdPAfVQisp/LhwkE
 IY9rEq97oCHWIpNYsSWNWACvK/dGU0BoAZer3Ds45u0qyFearYX5N9PrFS1hxVDd81Qi1EwFPpO
 O+WjmxxttbPxrE+Rnm2OgKWOk4iWOe1N/pWhpXUpo6chSu6mEe6NeKDCLVVB6yPw6d8mDZRdVY7
 tUv6f1D+/kcRN1MOyEjguBPN7wU3m2F7R+SZgHCNMW3xlLaQdd+SkLjT+3gc8rFZNPuujblp9QT
 IAB8U0j0AjsYKfysOrnXRTnGm2oByCG4N1ARd99iCq8rPDQI0YfUnHrAyBtJmZjDxqhbmLJwEm4
 2Vv12Lio9A7pTWTfa/UivMlQw0PfZpka20FxYAzpQ9x0FeL7G4GNvEyZG8YJBXHeJRsqIpIMEBq
 vAftPAnKABSMMUO3joITUaYe/M8FBSmUX2bKvfeID5/yuUHiFjJ1vugzIU+HHyKDFEs7L0lf+ng
 vM8bWiCr/+Ki1JQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With Lorenzo's addition [1] of new kernel netlink interfaces, it's a
good time to revisit how the kernel server is managed from userland.

This series first adds Lorenzo's original userland nfsdctl tool to the
nfs-utils tree, and then converts it to a subcommand-based interface, in
the spirit of tools like nmcli or virsh.

This is not quite at feature parity with rpc.nfsd(8) yet, at least as
far as autostart supporting options in /etc/nfs.conf. We need a way to
set the grace-time and lease-time. This also lacks a manpage and a lot
of needed --help text, so it's not ready for merge yet.

Consider this a request for early feedback: Does this seem like a
reasonable approach for managing the server?

[1]: https://lore.kernel.org/linux-nfs/cover.1712853393.git.lorenzo@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (1):
      nfsdctl: convert it to a command-line based interface

Lorenzo Bianconi (1):
      nfsdctl: add the nfsdctl utility to nfs-utils

 configure.ac              |   13 +
 utils/Makefile.am         |    4 +
 utils/nfsdctl/Makefile.am |   10 +
 utils/nfsdctl/nfsdctl.c   | 1321 +++++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h   |  184 +++++++
 5 files changed, 1532 insertions(+)
---
base-commit: 4aaa812366170c5671a99eaca4d814cbf310cfd1
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


