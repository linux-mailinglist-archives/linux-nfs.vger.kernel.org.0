Return-Path: <linux-nfs+bounces-12501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7576EADBCE0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD273B6273
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C619221DA5;
	Mon, 16 Jun 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkGFeU9p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E241A262D;
	Mon, 16 Jun 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113068; cv=none; b=ASUq+k2fselhjHPsdqTq/j9bVxwkn1ac0flZBpLrgBIeh46nkx7rmhI7+6hqc5C663K7Gj9+zRZ1IJJmlxbOp4qCQVckprAbaDXtN2qA/Pv5DeivkFPNGu6zQy9uY43dv4LNxgwD5gOiEIYjk5fpDOGDh61OLxvMXlfJZhd3f+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113068; c=relaxed/simple;
	bh=EkAFJcLPgPbjTKoUMNmizvrwNLp1j6JJOB4wBncDD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h4vlCxgtiHHxTYAlWWb53uJbKHGAWnsMNhOL4uUoT7/8iJKIzqEB888zD41N2nbxx154O/xdGPWMwUKiXhxZGcWrjfR/x9KYhIugxx51GY/UfpFrd44daaGjMPItxgge6lk4mMCOdyrEv1Uzm4IdpuDPKkUztVTql2iGDYOwuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkGFeU9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F033C4CEEA;
	Mon, 16 Jun 2025 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750113068;
	bh=EkAFJcLPgPbjTKoUMNmizvrwNLp1j6JJOB4wBncDD1I=;
	h=Date:From:To:Cc:Subject:From;
	b=TkGFeU9p/O3ay7cUOsigArUqUuE7ZDXE9F74E+EPJFM7VNOea1yKmiZAaAdVcG2hj
	 /j3l7PNx/AGchLGgLyNSLuyNYUrP/FTwEz7M9W8xUr3CAOlj67mFFmM4vWETAPgfnf
	 tr0gRArzeLvszG14SzhINBpderB36IgE/rllkk8Xfa6nYeCUrReAtJfXsI36DgnoYK
	 jSzVIhdO+tznOxHQZ+QEDNUwdWoHEE6r2LefMGQ9L4TCXIECnNHOryg21LB1weTFW3
	 D9XX2aqBR5ZSCRp99GAAfJKk0Lh+Wn/lM0g1/WowKHRb4Q4u5qTo58tGC5pS10r1i0
	 517cI1i4cWAzA==
Date: Mon, 16 Jun 2025 16:31:03 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] NFSD: Avoid multiple -Wflex-array-member-not-at-end
 warnings
Message-ID: <aFCbJ7mKFOzJ8VZ6@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace flexible-array member with a fixed-size array.

With this changes, fix many instances of the following type of
warnings:

fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Replace flexible-array member with a fixed-size array. (NeilBrown)

Changes in v2:
 - Use indices into `fh_raw`. (Christoph)
 - Remove union and flexible-array member `fh_fsid`. (Christoph)
 - Link: https://lore.kernel.org/linux-hardening/aEoKCuQ1YDs2Ivn0@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/aBp37ZXBJM09yAXp@kspp/

 fs/nfsd/nfsfh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5103c2f4d225..760e77f3630b 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -56,7 +56,7 @@ struct knfsd_fh {
 			u8		fh_auth_type;	/* deprecated */
 			u8		fh_fsid_type;
 			u8		fh_fileid_type;
-			u32		fh_fsid[]; /* flexible-array member */
+			u32		fh_fsid[NFS4_FHSIZE / 4 - 1];
 		};
 	};
 };
-- 
2.43.0


