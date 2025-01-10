Return-Path: <linux-nfs+bounces-9096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD42A09264
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D43A1AEE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600020D4F2;
	Fri, 10 Jan 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbtrsbI1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51720B804
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516803; cv=none; b=Xg2ClkjxI+YJ+uzOOoi8IozBrUleVj0UrdYbxvPTZ0YvRiA6GfQGJdMCxOnbXngFP2DuaNXB2aQoRvgMPM596xE8g3YRSQ5m1TpJNX8O+HPiDYsfDUsBOdQRXiRObAuMakSN8GUp6v/JfVVwdYlCZmFVAsnmqxLR6wPFsGN91wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516803; c=relaxed/simple;
	bh=ZmT68ZG0P5V+4hp4HZ/3Dh/wMEYNYU/5su3wATzv2+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oxH1+RBYA70qxPxjvL5K9knO+ctnU910BbENvUPfUGd3WjlO1o6XfnTxP98GoWNVQ5xmrA4lPbBiniyLOWdEKzQLezu1TDeVpIfY2jZwo0F3wISxijgqrHl6dMiHUc4YRhJKFkci2aWsGbAt/LC82qIaLF0Or4rBZKWwBFsAKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbtrsbI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA0C4CED6;
	Fri, 10 Jan 2025 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516803;
	bh=ZmT68ZG0P5V+4hp4HZ/3Dh/wMEYNYU/5su3wATzv2+s=;
	h=From:Subject:Date:To:Cc:From;
	b=NbtrsbI13E7PWRhZXL8+3QT1/tq1xbXg0uIrfzR4WkqMZq/ovNY/HH3IColDiCRtw
	 oogasAhBjyVsmR7XPVFtn/WbMp49lbDpJmbLq8nrKWwWGTObS1BJoz8n5K8v/w3IXp
	 Qux4M47yCrgurDDP4OcWKm0iNIbFvQsYBpkHTitmihsQRYwaBkXYknYcDSyjqsJ37v
	 7+G/Cd5c9rkyM+DgoOc/NttO4DEPQ0d0bhjfwFhoo3+GSVafrcI5h8XdmbxlYt/W4h
	 XZD7ol2ITijW+EhFjoUSI1BX8PF95eGsaUgfk9EImPzk/2LCUdRtRt3XEogwkUbINI
	 FjKraSvDoaGpg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
Date: Fri, 10 Jan 2025 08:46:20 -0500
Message-Id: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKwkgWcC/23MQQ7CIBCF4as0sxYDRCp15T1MF1Cm7aQEDBiia
 bi72LXL/+Xl2yFjIsxw63ZIWChTDC3kqYNpNWFBRq41SC4VF3xgPk6bY8GzXl7lbAbURjlo92f
 Cmd4H9Rhbr5RfMX0OuYjf+gcpgnEmuFYXbSy3vb1vmAL6c0wLjLXWL/bCqwChAAAA
X-Change-ID: 20250109-lockd-nl-6272fa9e8a5d
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZmT68ZG0P5V+4hp4HZ/3Dh/wMEYNYU/5su3wATzv2+s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngSS8BqaumdNAoewqzSpgOoZcFLQXbU2cth+I5
 jlvUmi3kMWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4EkvAAKCRAADmhBGVaC
 FR74D/wOJUzg7Ab2NMim6yLoL6ULbpuYM3mEwOLv+FTNXPxLUvvQ5/Zqpis1qz9gDLFMIbuaAfi
 zEhd8LbBZheWrmR4j9JBP6kX9hpY05+K1Iy90Tn6nEgHju5pFrqs4pTBeLhOwqV0AtUX9Y5OTIb
 tiwQZFmg0hR6JJaPIVqLGHinBudhcXvJsAbbfkOFw3/7QNgF62kaMf0gf6bsiTK3vByi9s8buWU
 SZovpoy+6ks6ikIYaeZArWrBka/8B6cAvPsL0fVdwXV2xr92dMHB3QXC+Z0zUrsyRH8JDs2NSIW
 qJO7sldF/XU5yYMbyFYylLNpnfsWOO83BOSzvHxqYHn5bzmxxBAEA+9znEK+ed9gHJztmfA45B3
 88FfxUCP0k+21LFLix7RLrh9+NKTrQ2J12iCVwr6eN4ufYCNxeS73iLtoWJPfe/OCvjmLGvV1Sq
 jEBtj1T+yMAwAMjVfba4DyNx3S4qojOI6kyVSP+p2l37tXilwALhsnYB6nw29hApwIlF4eeViW0
 Gtg5bNtls0LFYZYql5HJNejwq88Gr77s39v1JcZ/tdZyxyelr4t0kC0bXLpht0UFAI1DoNxQmnG
 NQB4XgYl7/uPhKq2Mj8wLVAbUkReVunEKNS032YgTmq/7MPG/h7qG7f7WpDsTHmacztOMVMQk88
 h5/7fwVikHA7HUA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

v2 is just a small update to fix the problems that Scott spotted.

This patch series adds support for the new lockd configuration interface
that should fix this RH bug:

    https://issues.redhat.com/browse/RHEL-71698

There are some other improvements here too, notably a switch to xlog.
Only lightly tested, but seems to do the right thing.

Port handling with lockd still needs more work. Currently that is
usually configured by rpc.statd. I think we need to convert it to
use netlink to configure the ports as well, when it's able.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- properly regenerate manpages
- fix up bogus merge conflict
- add D_GENERAL xlog messages when nfsdctl starts and exits
- Link to v1: https://lore.kernel.org/r/20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org

---
Jeff Layton (3):
      nfsdctl: convert to xlog()
      nfsdctl: fix the --version option
      nfsdctl: add necessary bits to configure lockd

 configure.ac                  |   4 +
 utils/nfsdctl/lockd_netlink.h |  29 ++++
 utils/nfsdctl/nfsdctl.8       |  15 +-
 utils/nfsdctl/nfsdctl.adoc    |   8 +
 utils/nfsdctl/nfsdctl.c       | 331 ++++++++++++++++++++++++++++++++++--------
 5 files changed, 321 insertions(+), 66 deletions(-)
---
base-commit: 65f4cc3a6ce1472ee4092c4bbf4b19beb0a8217b
change-id: 20250109-lockd-nl-6272fa9e8a5d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


