Return-Path: <linux-nfs+bounces-2842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE118A71A8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2282D1F21E62
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A347764E;
	Tue, 16 Apr 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJNQ351f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4237165
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286151; cv=none; b=KK94H7F/Jp15kVJ/lqiT605RpZr4YokjaExkOqqoGWVZTKZTq6YgP4idw8EDL9Dh6wakujNefyjVjrwY6aBDwKlbsgLuo9Uzl7WHnDs8gMUpMXzL54r22uKzxxPU9T0Nn8UaZ9l0DcJ8bitZV1v2QaClQF6igyHlxN2KkZq+rKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286151; c=relaxed/simple;
	bh=3ikzOLqxVRX+e/If3yYRg2xaPJ1mZjhrLzvHMW3/1SE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y2Ph2QAZOiAgC/dt1i1XyhnOerZpHBIIEDRDh2cRwkbwQxKwPbXIZ2siAaat5Mcxg518C/9JbIVwirFeptw+GZBFBp7Sxck3agDHi3cPPMZ6DhuZCBm6JIlTuBItinE2dbwnxy+Qz+t4xMIjpRbmT0wqzKfjJgdCabHUzUatM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJNQ351f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE10BC113CE;
	Tue, 16 Apr 2024 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286151;
	bh=3ikzOLqxVRX+e/If3yYRg2xaPJ1mZjhrLzvHMW3/1SE=;
	h=From:Subject:Date:To:Cc:From;
	b=tJNQ351fspSvhHMBDD20f6ze3Wzm84rwXOMj5N0bXJF8GLC7oZbyFBCHO+NtgclEA
	 nsIOI54J9tZWx6d71hii3j6fi9tsnmcMxWPRd33fVvrFFpTblCGL4CCP+ALUSvMfuU
	 TrbZrRTXEgex41EzSnl7pwExl064a2eqqjmYbxzoxzmR2k8Hm+SWW5W8+5s8hIyQ5c
	 qCe0Lnu2yR3UwclJiblUG9gBIAppj9d1tvdRjpqqEmBMbrFAJR/6LGo3k7Z0Xub3SD
	 xBlQiepKqWxX9XJ3xzIYgf3OAwKN0gMay3jtl1Hkn477A5UanXloIMLsnfR5BJwpjw
	 ECO33Qcjm9EFg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v2 0/4] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
Date: Tue, 16 Apr 2024 12:48:46 -0400
Message-Id: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6rHmYC/2WNQQrDIBBFrxJmXYuxUkJXvUfJItExGSpaHCstw
 btX3Hb5+I/3D2BMhAy34YCEhZhiaKBOA5h9CRsKso1BSaWlHpUIjq3JXrhlWu2kL9I4C81+JXT
 06aUHNEm8M3mGuU07cY7p2z/K2IW/XBmFFOjs1RpcjZH6/sQU0J9j2mCutf4Aq+s/fKoAAAA=
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3ikzOLqxVRX+e/If3yYRg2xaPJ1mZjhrLzvHMW3/1SE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmHqwAvE943b1vojb5w6mQuvVygwBDmBXpBXicu
 gFS28RX3XKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZh6sAAAKCRAADmhBGVaC
 Fa39D/9S0HPjeG26kWLLGDfVnwV5LRjBTFKON98zxllQlgTx0kkY657JGqPFk36pN9yqc3aBM6I
 eXfF602k+JiLqdUuyQ7R7/RBhTdCRIy4ExEBpxEWtT6yvHGrdgWG5D+8OrBx24mS8YJdWX/UJ8+
 2DS1qfQzalSzLjMUkzS+4NfQ13P/hNuDxegvSUAiT04qQvn36J3okhofni8AMlPiEvlZFC+A0TQ
 oIEqf0Z8p85FAEbIzSPFgY+i8o/5Qa/nwRogSio0saMdtoPYRUN8LF8JFMSIG1xJHD9la4JU6ZS
 DqnYptdJDWE4+w8PiTxNiNvwD8Sr6FzUc0xrx+1yjlRleIODpJSNFrtLP1lBaxWftt4uwtniXyO
 vDnsWhwrXG+HH3DXkDdbOmaSMlFxswSjLlXWpaMTEJ20zprlhsApPggdb3PN+vtgvmd5WpDHNhD
 G279Ddc51YNtGYxC07EhB0TOk5/3LodaygD5VSR1foiu0PJgfGAExTpC0oywrXFlKtSFzlH5n4p
 hCDputSlpIiFIX3ybA2KE5E7NiRz4DkipRpDVIx9PdHtGidqP3qono/lpG0XrFTVO4j00cSBANq
 tymQuXdYYGFDx5woyjmFXvf4aanlpfPsJ6I7bFcPFBDbScuD/Sjrj3RbUxR/cMpL0N9hZ5kgh8+
 EGubFWxbJ0E7Geg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Lorenzo posted an updated version of his netlink interface patches
yesterday [1]. This is an update to adapt to those changes, and to bring
the tool closer to feature completion for release.

This series first adds Lorenzo's original userland nfsdctl tool to the
nfs-utils tree, and then converts it to a subcommand-based interface, in
the spirit of tools like nmcli or virsh.

This version should be at feature parity with rpc.nfsd. This posting
also includes a manpage and an update to the nfs-server.service to
start using the new interface when possible.

I've also included a patch that adds the manpage source. It's much nicer
to edit that and regenerate it if we have to update it later. We can
drop that patch if you just want to keep the result though.

Assuming we're good with the new kernel interfaces, this should be
pretty close to ready for merge.

[1]: https://lore.kernel.org/linux-nfs/cover.1712853393.git.lorenzo@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Adapt to latest kernel netlink interface changes (in particular, send
  the leastime and gracetime when they are set in the config).
- More help text for different subcommands
- New nfsdctl(8) manpage
- Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
- Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org

---
Jeff Layton (3):
      nfsdctl: convert it to a command-line based interface
      nfsdctl: asciidoc source for the manpage
      systemd: use nfsdctl to start and stop the nfs server

Lorenzo Bianconi (1):
      nfsdctl: add the nfsdctl utility to nfs-utils

 configure.ac               |   13 +
 systemd/nfs-server.service |    4 +-
 utils/Makefile.am          |    4 +
 utils/nfsdctl/Makefile.am  |   13 +
 utils/nfsdctl/nfsdctl.8    |  274 +++++++++
 utils/nfsdctl/nfsdctl.adoc |  140 +++++
 utils/nfsdctl/nfsdctl.c    | 1401 ++++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h    |  186 ++++++
 8 files changed, 2033 insertions(+), 2 deletions(-)
---
base-commit: 117102ee541f38fd7d9274feb8b5586f88d4f655
change-id: 20240412-nfsdctl-fa8bd8430cfd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


