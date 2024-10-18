Return-Path: <linux-nfs+bounces-7287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317D9A4632
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72AFB23086
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC793204F68;
	Fri, 18 Oct 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjrU2o7O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE820494E;
	Fri, 18 Oct 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277120; cv=none; b=tB+5FkQt+TlEE1nGeYeQNA3EFijizFU88ufrPn/KqlvQSalkQcRxBaLoUKBOuuIvDAjcV1TN8dD2BMGhbc+QxWZ5X7OCwTLX/YfrdEb/CqQ5NXhZYCCS3O7Y2ROaalA/+K3ONqSOX0IVy+jkCMBWbIw41RIwVN95lcysmypiLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277120; c=relaxed/simple;
	bh=9dORPtUtvLZEQpvgCknFm5lI/gMVvJs3Bu66rz+dJmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPGa2kxB+TbaWtnBBRCjQj0IHACHGDDFBkCmj4EesnNuQQhvlyDeoLdVDZc5W77Ge+22P5IFis6ivXP9gI6vO4F7nlkwk4Utzug0D/Jqwn+PZR9DjiWgFLM1C1awtSv1Tg7CpoYBSeTIO2uZw81Jr1TKM5eiGHzHR77ggTWRHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjrU2o7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A83CC4CED0;
	Fri, 18 Oct 2024 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277120;
	bh=9dORPtUtvLZEQpvgCknFm5lI/gMVvJs3Bu66rz+dJmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sjrU2o7O5Tgw7bOHy+u6O/KvAosToH4RlNvUZJjsexDgw4IFvRYbLl9XKFux5lZOF
	 XZYGImtlJYeP3FPyc4htF8BlI913scEQPOD5wGR1wB40AqqlHFexfcXDxQUao3qJNC
	 /bqscCEpKh2PeeRdUUP+SETQiVMeYZM2v8biVhuQBYCIXlqFMUbF2IgVevAsCQox5R
	 TFcCSDE49WhYbkSdQT5mJP/KN/wLBBd12C9se2GRJCN9VUdJuKbgZEUNbV+hp/Vpot
	 3Ot8svQ2lH4Us8s/y3Ix/0zCJuOapCejRjpzg8sMZ+f5lYOtL2424eS7T0sJwq5PyE
	 d/Bxiel00/Kug==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Oct 2024 14:44:59 -0400
Subject: [PATCH 1/3] nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to
 writeable attrs
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-delstid-v1-1-c6021b75ff3e@kernel.org>
References: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
In-Reply-To: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9dORPtUtvLZEQpvgCknFm5lI/gMVvJs3Bu66rz+dJmg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnEqy9sP0b+nozNRoGiEdQ9EHtl/iKXSoEL4IYX
 FShsRGRqMeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZxKsvQAKCRAADmhBGVaC
 FQRYEACr5zpAx4abfOz5v+lVRUrUNumFnZHudNuu4AQ8dD068t48UJYQEWBCGzXLxacJObArR62
 7qdAG3dJkG4X41SdcRMtTt4qcWXi8MNsvj9LonqFxmJ/r+z0Y5hc9Hl2m/28GyZH1w/xshfjEs9
 XvpttS/5A1v3dXrRLovOhfD86RNGaZ8bd7ehh6hhL8m3A//YuI0exiXiF9+TCCeBwB0cmPsauBF
 IGJlNZJuKiZgmmhx+vruycBLtqSZ/j163OEbpGL70TTCJ491wrPSq7X8eQx6Vdjhhid92R3r8mF
 gKkYLDXHWbQ2gLct7YdnOnkfPuWX/8MgrIV6IYZpedPjolWkwF3qt6b5j4kuPSvCqdt/wiIQ55R
 ZRDX2YBWDeL7Y477qIwSOPBP2yGbWTNy7fJPEXDRgwTgfALxqIRmOELiM9ZjJoWKGIVEJvp/Xev
 dPpQ9o8g6R2KQheYaDjOHDEnAdzygzgDfTnQxIZqGq7YsEmhKE4i+IxcwlTQy/ipdPeipfy5wn6
 2p87MIGMbj+XpQ+45zOPxZmjbp2Gng0bSLVKB0KqV+zqA0msq3KL62zIP+5MJQ8g8TRIh6ZS4Z8
 fkOmoIB3ZZZspWK/hIg/k3TTkuS7/XrSsoC51l93Ei5rx8L0d9kfrZ6IEB/UlL+mf8C4vUYFCsc
 6Htt58lplLvq0sQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add FATTR4_WORD2_TIME_DELEG_ACCESS and FATTR4_WORD2_TIME_DELEG_MODIFY to
NFSD_WRITEABLE_ATTRS_WORD2 mask, so that they are settable via SETATTR.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Closes: https://lore.kernel.org/linux-nfs/CAN-5tyF4=JC4gmFvb2tF-k+15=gzB7-gkW6mHuaA_8Gzr4dSrA@mail.gmail.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 #endif
 #define NFSD_WRITEABLE_ATTRS_WORD2 \
 	(FATTR4_WORD2_MODE_UMASK \
-	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
+	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
+	| FATTR4_WORD2_TIME_DELEG_ACCESS \
+	| FATTR4_WORD2_TIME_DELEG_MODIFY \
+	)
 
 #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
 	NFSD_WRITEABLE_ATTRS_WORD0

-- 
2.47.0


