Return-Path: <linux-nfs+bounces-21540-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENvyJrtxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21540-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD07527A81
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50F432EED76
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B336A378;
	Tue, 12 May 2026 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTwT34pY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5934405B
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609640; cv=none; b=RVN1yD4S9SO0/mQRbx9q3EOpgGyIMJ4i2yBsGt3xS6V6kW6muJwBaicdptH3UktUh0hGINQHoK5clfqHpnX0EOOVsgoSWgfpwvUshCws2FHqlMG+h7qlFDFo2fTvtZZvCpOV1r2fC0Clc5Ll40E4n/IyI5Vx9RWMEvtrGWji3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609640; c=relaxed/simple;
	bh=Stp72zT2qaW1Ui4IweP5nrAhysoLuoPEAKTz1CJrR7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LhKPqRqdmEjZvP1ImXf2Pja+s4pI6U6mBvLzAsdg9bzUpiZfFMg8gVyx32U67dqhA77zh+ddJCgwIEb/p3fjYUiArGG5jpYd4sNIDECsu7kXg5uMJh39W0zSamZMpClNOK0lq9H/aIcwoRvgsaTXiuz4537jyHIPmlCVuvY77aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTwT34pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D056C2BCC7;
	Tue, 12 May 2026 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609640;
	bh=Stp72zT2qaW1Ui4IweP5nrAhysoLuoPEAKTz1CJrR7w=;
	h=From:Subject:Date:To:Cc:From;
	b=gTwT34pYfanIVQjxFs/kfkrSP+8/3MuN/59ABQ7jZxNcrJT/La5k1ZyWatqMY/pQA
	 IYmqKtdt6VDztUsbeFuGzsxCE7O1Y1Bzd/hWyI23lBkfc+DNBG0S1JcALPsgVWrXXU
	 GML89I37FSWXiNNtvf6KgRhbRfCZ3HCTN32aKmM7S5oda+kbV7YK7KrcZAYB/IP80X
	 NbT3YRJ1/wPy8gpE5b1NCHDcCMxCDI4ipejCvZ7Wpax6ylmQxeUqyZ3t3GIfLrONnh
	 MvntJtmq0TDdew1Y4mnWu9lmYAizDOx+pqJCXhaU1kaJw91h7SPRHjdIFV7XPtEKOn
	 51VrfL3HMM/Ew==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 00/38] lockd: Convert NLMv3 server-side procedures to
 xdrgen
Date: Tue, 12 May 2026 14:13:35 -0400
Message-Id: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5TUQbSihcBbHIx0mNikFxQZWq3
 p0ElvP0ZlYQzIQCl2aFjB8SenKBbteAHy0nVBQKg261aXt9Ujw9erWEnJDV4ehi581gzm6AYrw
 yRlp+tevtz/J2d/RzTdSHs4LKZct+rJPHac9RgppRZuIE2/YFDCSKXpIAAAA=
X-Change-ID: 20260427-nlm4-xdrgen-35bf1c6869b8
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5685;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Stp72zT2qaW1Ui4IweP5nrAhysoLuoPEAKTz1CJrR7w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23aEyeksK6iP/0Zu/a9VzjKLOFAeAzxzXu36
 O4ZteZqo3OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt2gAKCRAzarMzb2Z/
 l2zyD/9iznQ6+WNjCelES1bvB0Xa8qctKmYnnJr4jZVZMzVihPO3702LZWHZblELXU79YrqcuD7
 0EAZkaU7mvg+NLySJmgQ29y27ekHqFHWkqkwNRx0ibzgYh4CV64Ir0buhd5x3yo2Pufxf9Bnt+l
 bu+n2+7WhsKYpOo52HvHFSbWa4f7Kome/au6qwhDeOD8R1ekHHp6VLBuI5FnvgeuR9g5FNXKBeV
 79NFV+KLj6VZkbr95ztdIKeMTXsvZxeHDL7eM/kfjSJjLlJ2595paNtRZyJxavuAbqLxGvg1vT0
 XwUxN9lVG2Z7xrNoHVks396W62RBi5TZaFS91wM1wfsJZ6qVbHMYyT4imNXGJM7pAilAgJtheaG
 aXCmaNKk88qkc/LhDMl/dCfooESqxSYG9pNsWwU9//sxVe91dhkNPcnwlSBy6BxdjZrb45jl6xj
 OVj2UNgmGVgu8VO4pPRqIY0DNnw6WIXFsVDtsY+ueOHRYxn+ZuzDHm8xVXCivCI5adE+BSWQtzo
 4d05ngXHobiTcz8jNtaD9I/454ZvB+DvU+majAlBBeEUfy5WAQAlUFNkZLUaZbCaNClCs+2oxS7
 ryBjIl9FMHBZEXEG+fcHFF/KkDcmkjo510PEe0Jbpthof+eqYXtwW6v0l7N9n0MaeCrHI1kILYv
 NYg9wencfaxYWhw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 1AD07527A81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21540-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series finishes the xdrgen migration of lockd's server-side
stack. The companion NLMv4 work landed earlier; here the
remaining hand-written XDR in fs/lockd/xdr.c is retired in
favour of code generated from a new
Documentation/sunrpc/xdr/nlm3.x.

XDR helpers now do wire-format conversion only. NLMv3's
32-bit range limit on TEST conflict-holder byte ranges is
clamped at the proc function rather than inside loff_t_to_s32()
in the encoder. The HP-UX zero-length cookie rewrite that
svcxdr_decode_cookie() has carried since the original kernel
import is dropped on the server side; the generated decoder
reproduces the cookie verbatim, and neither NLM_TEST reply
matching nor CANCEL_MSG depends on the substitution.

A wrapper struct bridges each generated argument type with
lockd's legacy lockd_lock/lockd_cookie/lockd_res internals.
Each handler reaches xdrgen-decoded fields through argp->xdrgen
and the legacy layout through a wrapper member that the handler
populates explicitly, typically in nlm3svc_lookup_file(). The
core lockd helpers and the async callback path operate on the
legacy types unchanged, which is what keeps the conversion
incremental.

.pc_argzero is cleared for every converted procedure: the
generated decoders fill the substructure they own, so the
dispatch layer's zero-memset is no longer needed. The
trade-off is that any wrapper field a handler reads must be
initialized explicitly. lock members are populated by
nlm3svc_lookup_file(), or on the GRANTED path by the new
nlm_lock_to_lockd_lock() helper.

Five NLMv4 fixes at the head of the series and three cleanup
patches at the tail bracket the conversion. The six lockd_
struct renames between them are split out so that each
conversion patch reads as a single concern.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

---
Chuck Lever (38):
      lockd: Stop warning on nlm__int__drop_reply in !V4 cast_status
      lockd: Correct kernel-doc status descriptions for NLMv4 GRANTED
      lockd: Drop locks_init_lock() from nlm4_lock_to_lockd_lock()
      lockd: Translate nlm__int__deadlock in __nlm4svc_proc_lock_msg()
      lockd: Do not monitor when looking up the LOCK_MSG callback host
      Documentation: Add the RPC language description of NLM version 3
      lockd: Rename struct nlm_cookie to lockd_cookie
      lockd: Rename struct nlm_lock to lockd_lock
      lockd: Rename struct nlm_args to lockd_args
      lockd: Rename struct nlm_res to lockd_res
      lockd: Rename struct nlm_reboot to lockd_reboot
      lockd: Rename struct nlm_share to lockd_share
      lockd: Use xdrgen XDR functions for the NLMv3 NULL procedure
      lockd: Use xdrgen XDR functions for the NLMv3 TEST procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED procedure
      lockd: Refactor nlmsvc_callback()
      lockd: Use xdrgen XDR functions for the NLMv3 TEST_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv3 TEST_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 LOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 CANCEL_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 GRANTED_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv3 SM_NOTIFY procedure
      lockd: Convert NLMv3 server-side undefined procedures to xdrgen
      lockd: Use xdrgen XDR functions for the NLMv3 SHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv3 UNSHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv3 NM_LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv3 FREE_ALL procedure
      lockd: Remove C macros that are no longer used
      lockd: Remove dead code from fs/lockd/xdr.c
      lockd: Unify cast_status

 Documentation/sunrpc/xdr/nlm3.x    |  168 ++++
 fs/lockd/Makefile                  |   19 +-
 fs/lockd/clnt4xdr.c                |   42 +-
 fs/lockd/clntlock.c                |    2 +-
 fs/lockd/clntproc.c                |   14 +-
 fs/lockd/clntxdr.c                 |   44 +-
 fs/lockd/host.c                    |    4 +-
 fs/lockd/lockd.h                   |   57 +-
 fs/lockd/mon.c                     |    2 +-
 fs/lockd/nlm3xdr_gen.c             |  714 ++++++++++++++
 fs/lockd/nlm3xdr_gen.h             |   32 +
 fs/lockd/share.h                   |    4 +-
 fs/lockd/svc4proc.c                |   69 +-
 fs/lockd/svclock.c                 |   38 +-
 fs/lockd/svcproc.c                 | 1844 ++++++++++++++++++++++++------------
 fs/lockd/svcshare.c                |    8 +-
 fs/lockd/svcsubs.c                 |    2 +-
 fs/lockd/svcxdr.h                  |  142 ---
 fs/lockd/trace.h                   |   16 +-
 fs/lockd/xdr.c                     |  354 -------
 fs/lockd/xdr.h                     |   39 +-
 include/linux/sunrpc/xdrgen/nlm3.h |  210 ++++
 22 files changed, 2538 insertions(+), 1286 deletions(-)
---
base-commit: b26490baad0b7318d763b5ad6e5ca2addb20b314
change-id: 20260427-nlm4-xdrgen-35bf1c6869b8

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


