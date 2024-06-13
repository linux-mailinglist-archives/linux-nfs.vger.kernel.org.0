Return-Path: <linux-nfs+bounces-3782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F521907B86
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E822B1F25790
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068614B09C;
	Thu, 13 Jun 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgGpK4MK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661014B061;
	Thu, 13 Jun 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303681; cv=none; b=G+zBhe1BsuxP/Wp3OO5sUT9kRVVR/Eo3fqx11Q7Yy2VqIUAnfEkKylyyaQG/voKf4mTZpsB6I+KC94bS3Y0MKharbg9/e7M/ZOUfSO2BH2ajdoJCDIV3JdpFk1cUEzuUtuHVtXBBRUYA/Pa4D7AjnXdEmGNUqqh+gdNEtP3LDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303681; c=relaxed/simple;
	bh=uvgmmyR+kmgvJw5v805l711JAOX3oUJc9TWRVrpFuW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ljYDcB2s1CaLfwbi1tzSxjYGqryD2luEchI+11Ky+fjizQvhsZsHdEyoYil6JAH2bhLuSsLvLMtJxSgPm4gUqX8ds9AkdPEwUT/p3PG8YMab/Eo2Jd8FRWK9K0MgwZeT5N/9Gd8UTIL33r4ANih9i+uV6GgVkOG3hVGbglv5ftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgGpK4MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46D1C2BBFC;
	Thu, 13 Jun 2024 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303681;
	bh=uvgmmyR+kmgvJw5v805l711JAOX3oUJc9TWRVrpFuW8=;
	h=From:Subject:Date:To:Cc:From;
	b=PgGpK4MKWB/jrcZPWF36YsvhTYSpWg9fst87pwnrp0beKCt22pstbAlgxvVhZALbc
	 9liq4bBTYUIDqcUphUIEUVfo5VBA8HI2cg+ZuGDVqYSPCZLvpYB8s+HgxsEvzcuCsW
	 cnAlc3A/fkwjKX0mq4og5wRfj93UBOOb0AKiSVTCmX11aFCU4iQhUxn7AKWAU7po8g
	 aisSIz5DzyI79ZKHmIaQuOVuCrBVsBbNW7TyYGkrc0xYSGdIq3w1UvBkToRJWSEo2n
	 Jiva2tnH2y6sLdu8Yf6GuUxT7iNCd65Db+LpPmmmSedz66KFi2qotKfY7dcITYAfyt
	 Iut9aH5+kIVxA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/5] nfsd/sunrpc: allow starting/stopping pooled NFS
 server via netlink
Date: Thu, 13 Jun 2024 14:34:29 -0400
Message-Id: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALU7a2YC/22MQQ6CMBBFr0Jmbc201AZceQ/jApgpNJpiWtJgC
 He3sMLE5fv57y0QOTiOcC0WCJxcdKPPUJ4K6IbG9ywcZQaFSqNBLbyNJDzPk2hRd0iKqrqpIf/
 fga2b99b9kXlwcRrDZ08nua3/KkkKFBVZU5mGjSS+PTl4fp3H0MOWSeqgyvKoqqwqbK2pkczFt
 j/quq5fvBkStd4AAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uvgmmyR+kmgvJw5v805l711JAOX3oUJc9TWRVrpFuW8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmazu+Msjh7p6JJ/Jz07l7Fdd5VzsY8TlusIJvv
 DJ66xycKxuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZms7vgAKCRAADmhBGVaC
 FcsNEADSICTirj26t+OTNid+5BS22e0mtDNPFyN5ZSGKFjRGGWCEhoy+WcIOUF2rcFBv9TA2ybN
 TIXdAezVdrjoITvCbnC1zguyT57KeJNEFjg5VbFGU6xw5vnsRA5Gbc0y3NOLO0iObcA60yaKaGn
 adYQJP141mL8q5Q0sG/F26IFhPSZtWkOZ0QHTQVnKwCjYwfUxbAao94/owl5ogAyOseh+M7Rqfk
 HAJnmQVmnBp5+YT2d2fnGt863dWk95+60qFftc/d0snGG3o7kw1/pcShkW6xZp1EO6a6HbBgFV+
 HN4zqBJtESy4bD5gwob/1jtHCN4X0JW8YViGlFc7asG1YEukwImnyRYvq7AtiCsqazM56gkpC8R
 3zXlQzRv1G0URm4/3OO2uZ1S9BHxDcKsHmUAr/pe61JQ4wjKCKqF/Idh2mzx8p1wRZYraprD8Ew
 Jvz+1pEbC68ckGRMrzS+vtNFe7GlNwWqT5csvTCTcxaz3ORTmCEudLfrzxdJX0hj2SnljFxrob/
 ttux9re5Jf1oZoJx51ozQvyRTDF/7dM3SIbCg/1IC/8FXl4hdH9OrQup7nLYLGU4u6IC1NhoyDC
 vqG82jyTmdFvf2JYhE1a0KJXCh0D2gGp66xZDgMezr6TPjNmcQf0TPthdcL7z73JAQO0tycJBPB
 IGfpkDtQd9MMHFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a resend of the patchset I sent a little over a week ago, with
a couple of new patches that allow setting the pool-mode via netlink.

This patchset first attempts to detangle the pooled/non-pooled service
handling in the sunrpc layer, unifies the codepaths that start the
pooled vs. non-pooled nfsd, and then wires up the new netlink threads
interface to allow you to start a pooled server by specifying an
array of thread counts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- better announce the subtle change to the /sys/module interface
- add more kerneldoc comments
- Link to v2: https://lore.kernel.org/r/20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org

Changes in v2:
- add new pool-mode set/get netlink calls

---
Jeff Layton (5):
      sunrpc: fix up the special handling of sv_nrpools == 1
      nfsd: make nfsd_svc take an array of thread counts
      nfsd: allow passing in array of thread counts via netlink
      sunrpc: refactor pool_mode setting code
      nfsd: new netlink ops to get/set server pool_mode

 Documentation/netlink/specs/nfsd.yaml |  27 +++++++++
 fs/nfsd/netlink.c                     |  17 ++++++
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfsctl.c                      | 100 ++++++++++++++++++++++++++----
 fs/nfsd/nfsd.h                        |   3 +-
 fs/nfsd/nfssvc.c                      |  59 +++++++++++-------
 include/linux/sunrpc/svc.h            |   3 +
 include/uapi/linux/nfsd_netlink.h     |  10 +++
 net/sunrpc/svc.c                      | 111 ++++++++++++++++++++++------------
 9 files changed, 256 insertions(+), 76 deletions(-)
---
base-commit: fec4124bac55ad92c47585fe537e646fe108b8fa
change-id: 20240604-nfsd-next-b04c0d2d89a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


