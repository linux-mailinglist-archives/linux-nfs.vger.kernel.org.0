Return-Path: <linux-nfs+bounces-9738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5651A21DF8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE41662CA
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985D14830F;
	Wed, 29 Jan 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puzRM5+D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53A143748;
	Wed, 29 Jan 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158012; cv=none; b=sg9AEgycdqMRuiU8xha//1abhI9FHfrCWG497Oy35bh9QRVZpYQdHGTwg6zFthkT+F6+cjCrPA4471uM3e+5NV70JxX0wBrVAvsgaYvyTIuGKL+dkIXKPWkUTLyIMpHC9jLzxCE9+ApU9LaSRua+EuzOWsem+l3mrZLNWBzdFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158012; c=relaxed/simple;
	bh=7OxW7/Wi/bFyhogJ6Ud+oSPLufipYoOYvEZZOvY6Xts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tnyn/ovcGRTNaB+XDqaHT8U7Nj1TRpUYO/QSdW1oGed0xnr3W5IyjVh7/tJy89qDxmaadKMlhDzouHod6/FuiNCF4ZY27j4OL0isWevkyPKCNaM5C7IJh+oVOoOtfHhcVpbdx1sLyTmmUTxd3XcxChDJOu6bPpiOBC+wmJVUM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puzRM5+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED222C4CEDF;
	Wed, 29 Jan 2025 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158012;
	bh=7OxW7/Wi/bFyhogJ6Ud+oSPLufipYoOYvEZZOvY6Xts=;
	h=From:Subject:Date:To:Cc:From;
	b=puzRM5+DH85Xm9cDGQX2xij24V2Wgvf4zrPoF45s5Px+4/o1v0moFmde5SIPbDosb
	 DO+B6UmeLe7n+l7fFL6oaGoF+yfGMwl/GN3hqgR5qRPqD+OURA7EZegstjWCAn8F1J
	 T8rygKVnl3vonKFyzeV3DlI7HaVWzDzSQQElP46I/iFwHTrXOM3zMBpN98Nj3co8lf
	 rBtkiXbIFU6XTYLP4RjL8c7dTRVfy6wiPCNxHlLwVaLgwaylEHyixgxu4DpenJ9ZBm
	 H5K83WMA02nLUyTqCQE5kfXW6Xr9kRZoEpFPciVeBtKdSGZ+/a7f2DvgFVUcuS552s
	 OqTUaubyy6ADQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and cleanups
Date: Wed, 29 Jan 2025 08:39:53 -0500
Message-Id: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkvmmcC/23MQQ7CIBCF4as0s3YMA62oK+9husAytEQDBgzRN
 Nxd7Nrl//LyrZA5ec5w7lZIXHz2MbSQuw6mxYSZ0dvWIIUcBEmFwWWLB6Qeb0KfNKvjYCcB7f9
 M7Px7s65j68XnV0yfjS70W/8phVDgRKS06Z2Rhi93ToEf+5hmGGutX56cZamjAAAA
X-Change-ID: 20250123-nfsd-6-14-b0797e385dc0
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7OxW7/Wi/bFyhogJ6Ud+oSPLufipYoOYvEZZOvY6Xts=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+z3Qtu7IRnKK70YKNMsVOaebNeW0DJsb3dW
 irYbdsTwkWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovswAKCRAADmhBGVaC
 FYR5D/0XI4gjo99tW5F7hUL8yK4p/MeTnf4fokXIBAdewDYz5sOSP6+EzD4u+ChZm/euuWdcWd8
 j79PNrrv0e5kq4FU0gBzYazSYHcCOPG4Y6ujZm8+Q1gyhK4P4gCm/kinS0saEbwqYr/FLqf6mPN
 pthydrSiOsoqtR0XMAxVAEqLfMG/+CecBkXrJNJ7PLHfh1uyBEWEkmfjgqF2c8FZV0jkFgHL/SY
 DD7ivDgLN+x4UrRKBNCKhuXfYtPivgJaae7B7rBts63wDyeGA25bQYk9R0ScnwQ3wDQcRhK93Hf
 Mgq02mm2YbfvRbFGXYEaRVgedj+y0U6PMaOqjDoH2uT4OtHJPp5p9uUkKKXyfOchSM6e++aEDKF
 /fB3iKJuBfVrEaQpy95NPR7Jh8EDFsSB3I+6goEHYoXsyDM/S1VsCy744f9oKXkHRVfgGN/Udvn
 PWIngqItPMn3QI4ED3VuBlhUoTlLgi9WGPPjIDYdC6ShekpwK3ferfBZ4IuNO3LaQkkUTBDiw6q
 lSyEgofBczInbbFErAlgqQi/PG+8vC+vYzn5siqkvjDmU2eZt33g6k6E7fLd3sbyfm8hP4qFYGO
 V3gpuwEMR4GRpZuJbgDUZREfM4XgXK5Y4f1ikLAWJJblCyb8KmzLisOHNCvmXqIngl0VAkmPJJv
 s1KCmH8bGiibELg==
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
Changes in v2:
- make nfsd4_session be RCU-freed
- change code to keep reference to session over callback RPCs
- rework error handling in nfsd4_cb_sequence_done()
- move NFSv4.0 handling out of nfsd4_cb_sequence_done()
- Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org

---
Jeff Layton (7):
      nfsd: add routines to get/put session references for callbacks
      nfsd: make clp->cl_cb_session be an RCU managed pointer
      nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
      nfsd: overhaul CB_SEQUENCE error handling
      nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
      sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return

 fs/nfs/nfs4proc.c           |  12 ++-
 fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
 fs/nfsd/nfs4state.c         |  43 ++++++++-
 fs/nfsd/state.h             |   6 +-
 fs/nfsd/trace.h             |   6 +-
 include/linux/sunrpc/clnt.h |   4 +-
 net/sunrpc/clnt.c           |   7 +-
 7 files changed, 210 insertions(+), 80 deletions(-)
---
base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
change-id: 20250123-nfsd-6-14-b0797e385dc0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


