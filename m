Return-Path: <linux-nfs+bounces-10058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B77A32B95
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 17:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293163A6FDA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239121772B;
	Wed, 12 Feb 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRvi8RCj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A1212B31;
	Wed, 12 Feb 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377806; cv=none; b=oxk/ppt3hEFsmAafhga5YNRHxrGYic1irzcPlyhpfqMVvG8whF/etmqz1npevLuBHzdEt4QjUEJEKduad06lNNQ1A/BAyMWTBhmG0/t2/zINf8nbN+jOxPtK3ChFtJE9JCSBrLBvvgwAXBate9wkDfJhzaWmW6ZjklbxYygWydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377806; c=relaxed/simple;
	bh=iay9SaV00OpX9FTGUNAnx6gDTej3qK5HuPqkJKbVSfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s7stN+nRomANGFaEsGHYLHnjzivf+9uRtvftXsMkvxQoEGaQq5EjZVezVyCQtYgbr12ftoZYHUc80SbZ5POrEkyqqLoC94VSm+9bvDyC4XkoD5hkj7nk32ggkALNRRJh9IBzvYC5BDr7qwJTY9iM4BbHYSTcIlTM86vGSuWOWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRvi8RCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E964EC4CEDF;
	Wed, 12 Feb 2025 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739377805;
	bh=iay9SaV00OpX9FTGUNAnx6gDTej3qK5HuPqkJKbVSfY=;
	h=From:Date:Subject:To:Cc:From;
	b=RRvi8RCjTjUADi5pbqjuFUv9FyPvMIA98oLc7WfCgy+vlBtqFpSkz5I4XYIoQDFv3
	 sBsIAwgjpYWtZn4MsBaqQNe84DMLW7FP9qrbF0OLeajIPwDTwjEo0ewHjttEm0s4Y7
	 QN7ESMYbDqwetxchV/pGoIpQupq2STm6R1M0vaejaCXyws9umSDuKGu9Cw6JtSBqt2
	 GzAw7u9dzY+u0mKauXsE5WtBsz5+wKM0kXtQbx80V0Cte8ySdZxfPFG7MWON7ENn9W
	 8+5DwLyanmFEGiHmbu3s7AY809cqjnFIse0KmCvVEWke3EJqurkeFqpuHb4fI+Nqsb
	 1lsvkF2alXb5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 12 Feb 2025 11:29:55 -0500
Subject: [PATCH] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAILMrGcC/x2LQQqAIBAAvyJ7TtA1SfpKdJBcay8WLkQg/T3pO
 MxMA6HKJDCrBpVuFj5LBzso2I5YdtKcOgMa9AYt6pIl6cwPic4xmHEyAZ3z0Ier0i96v6zv+wF
 pc6sPXAAAAA==
X-Change-ID: 20250212-nfsd-fixes-fa8047082335
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iay9SaV00OpX9FTGUNAnx6gDTej3qK5HuPqkJKbVSfY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnrMyICbQ7mrrJRdWHTUyPgxx60ScRPf5X55TYx
 +OCRX7zEo+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6zMiAAKCRAADmhBGVaC
 FZ43EADF1YItS0gSPwRJY9vGpuLBvvZfeH5ZfWl8y2+IMQt3I/bKgTN7JccRTyPbkfcPWj0I4BZ
 jqThQ5cXqxSlEiLKBsZI9CCQSZjOH3DXHXKGH3pEOpvOLZxToBBHoeDhxxpiIWgvRPVrMWi492Z
 DFhBYJwOkO5yEw/J/h5mKFExdcHPaSySPOrQDV30BIXSgyvdH5GnhIYixQhslX1b2EId9rBRhR0
 CpxG8LerQ8MmbbH30vLxqYxL6PusOPBtA+YvR/h/4j8WFHiqDyIqDOkZRfudgl5HwK39tFb30eF
 pjPkBjYg2NRKgUwy+mFd8AQKJbhRy7m9WFWesW0DjFrYg+mYvTRDnUbf9VpYAq+wakHFcQ5qWAj
 IhqTUKXxAXu0vbt64Q2GGHIZKaHKR/6PhwEcMUNY3unV2PCE9Qm6Kjy1/ECc9WycunXjKVhvzZP
 811nXwchP+6iZwiysvAUvIaL8PGKonFb28lvvqiMWy6BMaP+A4RFanYAjPawRD7goFc5k3metxO
 baaA8HWi8ngfiUqQxiHRW0a1L+D4nWKJkbLpNAEN6pksIpsphMLTfzx3qUrnGjIcfoI5oajJSp2
 G1jeAHs3yKdJTkipjRW7PzDkPS+NOxa2VHtUU0xY0FymoJXhcJZi6hejHTDbZ2BArnEavNRh0hC
 X1R7MMVTG0sOH2A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When a delegation is revoked, it's initially marked with
SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
s FREE_STATEID call.

nfs4_lookup_stateid() accepts a statusmask that includes the status
flags that a found stateid is allowed to have. Currently, that mask
never includes SC_STATUS_FREEABLE, which means that revoked delegations
are (almost) never found.

Add SC_STATUS_FREEABLE to the always-allowed status flags.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This fixes the pynfs DELEG8 test.
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 153eeea2c7c999d003cd1f36cecb0dd4f6e049b8..56bf07d623d085589823f3fba18afa62c0b3dbd2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
-	statusmask |= SC_STATUS_ADMIN_REVOKED;
+	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))

---
base-commit: 4990d098433db18c854e75fb0f90d941eb7d479e
change-id: 20250212-nfsd-fixes-fa8047082335

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


