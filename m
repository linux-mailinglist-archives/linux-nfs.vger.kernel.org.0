Return-Path: <linux-nfs+bounces-11088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA9A84BE5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE881B84C26
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A626A1B3;
	Thu, 10 Apr 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe4iOWwu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FF284B22
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308760; cv=none; b=iJF0A6eGYEqZ7Yxlx9OE5frXC9cSpsiTj3NpEUyFsVnbQPFIn16dhCMa1XLig1DbTrb37oyePfj45dixCozvQaveUaR2N6y4SoGoATSTs67ff4is04V4JlCor7fknYrb8n5mQjNV5vA/zY2OCfBLZrw5Xtxz+JtcLrO9Tz/Ao5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308760; c=relaxed/simple;
	bh=CVFsj5emVxYFMbjWV99FdKD13tBW6XH5vCGELFplQYQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sB0T4U42LRibC425Edf8yaF89P8MLF1IRAHflsAlbxTEcXzoZ0JmSMOtkTf3P3VfA4iLTktXlJL5SlthcIpE3uz1DSB87NZdjjARqoOt0BKDeNUtAc6YUMAVucT04Q5F8FgWuS6QlRmEQB5mQ0ik1+KAI8Psq10zwCX6HQVJdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe4iOWwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91ECC4CEDD;
	Thu, 10 Apr 2025 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744308760;
	bh=CVFsj5emVxYFMbjWV99FdKD13tBW6XH5vCGELFplQYQ=;
	h=From:Subject:Date:To:Cc:From;
	b=fe4iOWwuxaePhFIovGyaBdBwzUrxjAtAGjdyaDviSQDcS2q8cRx8vqdRHGTWJGGgR
	 JGb9OGrJKh4gsKkSzpNiVhOQ4MThuCgUBUQ3n27lzU6PfHdiR62u5ecTIsxpqSVx7x
	 lyybNpBrzb4YEO2PEuIVXrI1AX+h2x4WnMiu85I4kRxwT7n1hiqCafhLojseKtn9ye
	 jZWKaqIfeVC5OZqV0aoA3G412MiBn6zCPo5hi8HWOJFJEAK9FPjsDcvVGXJhvYnZ4v
	 nR550AYJ+Jhn392AR+ZxcMKClpiRuR0nYZP+QNhRGmRv0gdJWlX/PhQQ+LJTAlQ2w4
	 +kilHVDqiwykA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfs: don't share pNFS DS connections between net
 namespaces
Date: Thu, 10 Apr 2025 14:12:17 -0400
Message-Id: <20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEK+GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3by0Yt2UYt281JK8Yl1jI8Nkc4tkQ7NEc0sloJaCotS0zAqwcdG
 xtbUA8kSmDF4AAAA=
X-Change-ID: 20250410-nfs-ds-netns-321c78c16a79
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CVFsj5emVxYFMbjWV99FdKD13tBW6XH5vCGELFplQYQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+AoMcBBqbuJkK5y/AW69wCBZ2s4xbhk3qT6XM
 X9W48AjdOWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/gKDAAKCRAADmhBGVaC
 FZQRD/9n27YYhJbcm0Sffh4Ybs1P2PW1NPUU9+WTWUEDx7Yc4i4yljCEp9q2iyel80eV5sQlWab
 iJh7pzxH1HqrY2K98etmQO2ABJBrvoI+akve2V6weS3ZvtAoAFuaMD7N4kZXc/DRewxNSfAG3g7
 JTqhvn35xcV8vPLjlNy+snY/3O0vwc7ojskuFaEJMhcxzLvuogLSDfYftFGdNmk8Q1pfb272Wq5
 hSPZgb7FAtTD9jMrtWdLz09Sx3LHqtT0z2h5Tc5Ohsjybz1wxtWdOgiFWJYKhcefwKbWrCZCIq4
 XJB8eCvHirohs/JEcJt6+k2QBqZ+/SfYkxQMy3u8ezZovfeC1qJT8lfYfxEuZ5KNawz596NOo/o
 BaCD/1TxoZ3onqZP/UcI9OgubRhvmBkU0Keqo3jC+nnxcxkBaKH0FRcZq42JD/QPIKcvHb09ANq
 RpPx6XodbsYC//eNMmuUTfDlc0CHMVcTuQ/L3XDgygHjIgXtaTtVOGwTBPfNwTxrNfrSt8v+Y4B
 Wx1dCp6+AbohLblKxWIGXva+ZwrU33n90DM8KdHaiZmh8nlvIg6HPBiRZ/3WgwKN7azZYNGB2MQ
 bvwp0kfklgJWMWSz8uL1LhLw3W4UHC7iFMSFCuGLt64SG7u+hDZnln+oQNaJL44onwvLDEIn7aT
 d4cslgc58W4kHIw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sargun noted that he had seen some cases where a dead netns with a stuck
NFS mount in it would affect other containers. Omar took a look last
week and noted that there was a global list of DS connections and there
was no segregation by namespace.

The first patch in the series fixes this in a minimal way by tracking
struct net in the nfs4_pnfs_ds structure and not matching it when the
caller's net is different. The second patch goes the rest of the way,
and makes the nfs4_data_server_cache and lock be per-net.

My thought was that the first patch should be suitable for stable
kernels, and both could go to mainline. If you think the risk is low
though, we could just squash the two together.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfs: don't share pNFS DS connections between net namespaces
      nfs: move the nfs4_data_server_cache into struct nfs_net

 fs/nfs/client.c                           |  4 ++++
 fs/nfs/filelayout/filelayoutdev.c         |  6 +++---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 +++---
 fs/nfs/inode.c                            |  3 +++
 fs/nfs/netns.h                            |  6 +++++-
 fs/nfs/pnfs.h                             |  4 +++-
 fs/nfs/pnfs_nfs.c                         | 32 +++++++++++++++++--------------
 7 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: cf03f570936ac96ed4775eb2e4f1a6ab6a13f143
change-id: 20250410-nfs-ds-netns-321c78c16a79

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


