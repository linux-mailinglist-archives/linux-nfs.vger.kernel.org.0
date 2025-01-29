Return-Path: <linux-nfs+bounces-9770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D3A226D4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AA8163631
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8D1E32BD;
	Wed, 29 Jan 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raQoBrb+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F21E0E10;
	Wed, 29 Jan 2025 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192855; cv=none; b=m0oC6CcXNTBnRGWV4LN3JtFvTFJ9PxQMZVJHPa1XBuhxB6u3K9bHIcI5VPWS8L9MagPlNcAYUWwt+Ul3/0qEqPDyGqQkYt29bJU4e/uiEaut0YcPC0gqXVkWEBx2HICpzotU7Ioomrd3SF93Dp11lmS1jNebxXdGubsek6UiygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192855; c=relaxed/simple;
	bh=YEqdYM/eY7W98kpVAcC4ClHn1rdPQ8rtGyxmGyK6PCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uTheE/jMeCRGA0Rt3Z7zrPBpjfnarh78ohXNF59ED/GLw5BG15s9JKgzWON3UaEVRrcxOPOL1FWORtgKDsNOFs+OhvOeAFRrO2pvGXYxKo6Et/Skr79gvV3BUtaHej1TXopqe8bnP+PLF024iBlbF6vmJQ/Zjr5kUZLiO7gD2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raQoBrb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42702C4CED1;
	Wed, 29 Jan 2025 23:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192854;
	bh=YEqdYM/eY7W98kpVAcC4ClHn1rdPQ8rtGyxmGyK6PCA=;
	h=From:Subject:Date:To:Cc:From;
	b=raQoBrb+24rfIMbUIUGs6ryPrV5Cir77b3081LCKTWZZQnmXcu/L+6UZbXu9p6dUM
	 m4TWR5Kn8jmPBHrh2RG5gSxxHRf6CVis+AsDX5ReIJ0Mi424kg7h7I8COIpx8MnBlN
	 T0rXOAwHa/PVMlnJW//2694fkudTN3x9Qjh/mn0+++NKXGtCD480oIzO18H4sSRcwe
	 iPIxp9F5mU8RIdmICqTHCZQVBgS9hE9cX2+jnb3pAJ04s0OgqAjhCjOJhqoNlNucEd
	 wx65S/THVJvHgMy2GKT019PK/HFzDU6qOd1AE3dg2cUuyGA0mRKpJKS5SaHyz8M9oE
	 XCeoUjYjEGCSg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/6] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Wed, 29 Jan 2025 18:20:40 -0500
Message-Id: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMi3mmcC/22MwQ7CIBAFf6Xh7BpYqFhP/ofxgHRpiQYMGKJp+
 u/SnmricV7ezMQyJU+ZnZqJJSo++xgqyF3D7GjCQOD7ygw5tlyghOByDwcQCm5cd5rkse0tZ/X
 /TOT8e21drpVHn18xfdZ0Ecv6r1IEcLBCSG2UM2jofKcU6LGPaWBLpuBW7bYqVhU157ZDJ0mpH
 3We5y87b8/y3gAAAA==
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YEqdYM/eY7W98kpVAcC4ClHn1rdPQ8rtGyxmGyK6PCA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfO9E8UhT6368yrI+kjV5u77o/o7tlWmcQwK
 Ut1hggsmEiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q3zgAKCRAADmhBGVaC
 FSdVD/oCYo8crmE7pDw+UjtZ8H6AaSbkN7+eQ8VsElXez9BC6jzgSkG1QCjBR5xjTSB4zFfl3yt
 +8K8baEHrWAyDKOuhmgD8aJKsjwUm9nd61Y/WykKcmrbRVfhqMX9tnVcsiem/VfBuxkrDe84lkx
 4BzGpb/xnMxMniueMtgZgG5kKdadkoc9V8GK6cVPSgHbLvGtUbbtAvFCxhYS+wKWjjXtQgjBHum
 PWavGch+O76G78WY+0AYExd+YJBNberXPmlKUa5yeYTEN4UeR6kC0qe6O7F+FsoIuKUAYXoyGgc
 3Nqw/ijJtlKmTohRBAO48L51BpadmGJCd5lCCik3baEc4YCgSARDYQeo6rMo4IBxN4qJI8YFoMA
 8UmOtI9BDMTIuhm8xNkOiLroh768tVALb6oTSWiYNXQfJ9G4Sg+8YYTM60kx/oGRIbSFDjW7mtj
 FMlkVjZ8+sPJY887kmjIaBOCJmX6ZgmsNhjwsqB921oeFZwR1r/c5FfOVGs+uVtY/OFB1o2xBd/
 lrVEz2tVgl808pRgD3CnAtP3QfMTNsj14i7bNUlH713m/wHvSzOa14fzapXC2UhOPXYIVYkuc6l
 +rh1ozTZdquKrwgYcgy5OlOffMf4pVllbg0d9Hvvo+ZGxWyYPrtRXT64vePQfyVefCKQJjfz1gj
 p/qASB6wqVKXeMg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While looking over the CB_SEQUENCE error handling, I discovered that
callbacks don't hold a reference to a session, and the
clp->cl_cb_session could easily change between request and response.
If that happens at an inopportune time, there could be UAFs or weird
slot/sequence handling problems.

This series changes the nfsd4_session to be RCU-freed, and then adds a
new method of session refcounting that is compatible with the old.
nfsd4_callback RPCs will now hold a lightweight reference to the session
in addition to the slot. Then, all of the callback handling is switched
to use that session instead of dereferencing clp->cb_cb_session.
I've also reworked the error handling in nfsd4_cb_sequence_done()
based on review comments, and lifted the v4.0 handing out of that
function.

This passes pynfs, nfstests, and fstests for me, but I'm not sure how
much any of that stresses the backchannel's error handling.

These should probably go in via Chuck's tree, but the last patch touches
some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
from Trond and/or Anna on that one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- rename cb_session_changed to nfsd4_cb_session_changed
- rename restart_callback to requeue_callback, and rename need_restart:
  label to requeue:
- don't increment seq_nr on -ESERVERFAULT
- comment cleanups
- drop client-side rpc patch (will send separately)
- Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org

Changes in v2:
- make nfsd4_session be RCU-freed
- change code to keep reference to session over callback RPCs
- rework error handling in nfsd4_cb_sequence_done()
- move NFSv4.0 handling out of nfsd4_cb_sequence_done()
- Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org

---
Jeff Layton (6):
      nfsd: add routines to get/put session references for callbacks
      nfsd: make clp->cl_cb_session be an RCU managed pointer
      nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
      nfsd: overhaul CB_SEQUENCE error handling
      nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()

 fs/nfsd/nfs4callback.c | 217 +++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4state.c    |  45 +++++++++-
 fs/nfsd/state.h        |   6 +-
 fs/nfsd/trace.h        |   6 +-
 4 files changed, 204 insertions(+), 70 deletions(-)
---
base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


