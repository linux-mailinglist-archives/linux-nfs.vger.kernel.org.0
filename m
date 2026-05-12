Return-Path: <linux-nfs+bounces-21546-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKA0Fw1wA2qI5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21546-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E052775E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E01DE31176E8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016F36CE06;
	Tue, 12 May 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMR3bRiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD129364959
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609645; cv=none; b=hNNZWAfTgC4NDYFYvcck/Tu0y51O5p0TuV1XVLLbvxZn5AFW4bxeecabNnSVAGL6+Pv5WpSauJPgCSz6cPRXZDtzaFd+XRwAxivP0HAjsoSpTFRiKtSnZkLvYUyLODhO3Q4fdXg0cEZYXV4M6PW4y6GwUzCrybghsqzfxTHy1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609645; c=relaxed/simple;
	bh=odQ8kB0xHHlRKkseB0lLNCwIshetqgca4C4X6uZAwMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrH8gIM82o3W6kkUDcSPZMwmALDbMtPGywfchgbVcWXDqFmQOz5A517Ktahpceb4C/MYOwhUOGYEPy21hxm1aB/fOW4y0aAmktA1inAg9RxRtHoQgbxPafchSVlcfMU1FaVP2m5vo7Mdnm/cbHD/6dogOAC88delgW7N+vyN4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMR3bRiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D01C2BCC7;
	Tue, 12 May 2026 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609645;
	bh=odQ8kB0xHHlRKkseB0lLNCwIshetqgca4C4X6uZAwMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qMR3bRiy3jsHJxv7rANp/eFClfaRhN/5RtBX22aHRt8tnUBRHCLESVGsi3+KFfnev
	 vLyGnWsOVN/S9EpEZskGgcahXXBLY1N42jyQ7chczyy1inpMgUWI4szJRCev0+bx39
	 X2p6lZW/ZzZunBhy0u5YqewVdWSnpmluOoQk/27L0GvH6GueE2wQnrluv0beGVZtcG
	 LfYGBAowjI0j1LV4GffgcSCl7+wvcrs64ZpchCTM+MCzVh57MaBvUnIlRfJFTzm4iy
	 eSeF58dxw2HWzBGFd2XmGwCizBAksi0SOIQS8/zsKNyRbKBhwEgLitBpj7prT6ccPq
	 4Mv+oAas4Xaxw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:41 -0400
Subject: [PATCH 06/38] Documentation: Add the RPC language description of
 NLM version 3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-6-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=33804;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ilWcbezwae1VWjYwdPaWtLeSXBVo9nliflhgCI9y8BI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23k6PNdiojVSCrTGEI3eIoL1q6WsEQMAYi1A
 UX1vO4RoViJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l0E7D/495q7YDIyhXFeufXh67GVd1qMtlW6r9+HMSPBjqWB+pEDNs4S4J4rJf17eexd9zjxiywr
 e9HeimAdn7i8pkV1E9lYScLkwkj1ZlwqjrydzEy3BpOQ9oLL/mt6uzxT2e0J1JkcSsZ7W/X5xLf
 oXCNMNRVja54D6fV6eKEjuRBAZlT/3+A1uxRPH+eqlsq3Cr78luMs3UqMp+qLg/RKZTrnWjndS7
 rzClHPS1h5f+RuLhpInmarZG/GQ4mN9m5HwloPTF/viNvPhVrA3lHYmJ7Yb8PYkcOyqmsFUm9iG
 RoyZQwssDUgmWfq6NqrU/Pln2j8OWFhXo6w9xGrMtC8yBlDfdsfEoKZkV3X9jkDAWBR98db44sp
 DE5BmLMEc4GiQod9+pDWHeNIMWwytTy7dA3Y77d1fs96KfoL1tQren3i/e/iQ7oXGB6+AlJcSSy
 0Gdxj5AATmh4Y55GsmKemmSdvfKpP+z2gwt3Lq1thjci9E6/iFtjEtsEUihdx9Wi2ywRIYTGs0h
 tWK4ttL2F4FCf3KHns4Sw8QIie2YxxdsWjmgvpyRxb7ou5LS25S9QjIrjVV4dlUuquU1fg5X0Nd
 kCavFRh2jmhbITT0PsmVIKrSpgPtwcs/xGVD8AusQBAXZxXw7cDeZDRcyy/LiPEFZiMQYae78NJ
 QbX85rXbQxamCMw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: C92E052775E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21546-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,opengroup.org:url]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

In order to generate source code to encode and decode NLMv3 protocol
elements, include a copy of the RPC language description of NLMv3
for xdrgen to process. The language description is derived from the
Open Group's XNFS specification:

  https://pubs.opengroup.org/onlinepubs/9629799/chap10.htm#tagcjh_11_03

The C code committed here was generated from the new nlm3.x file
using tools/net/sunrpc/xdrgen/xdrgen.

The goals of replacing hand-written XDR functions with ones that
are tool-generated are to improve memory safety and make XDR
encoding and decoding less brittle to maintain. Parts of the
NFSv4 protocol are still being extended actively. Tool-generated
XDR code reduces the time it takes to get a working implementation
of new protocol elements.

The xdrgen utility derives both the type definitions and the
encode/decode functions directly from protocol specifications,
using names and symbols familiar to anyone who knows those specs.
Unlike hand-written code that can inadvertently diverge from the
specification, xdrgen guarantees that the generated code matches
the specification exactly.

We would eventually like xdrgen to generate Rust code as well,
making the conversion of the kernel's NFS stacks to use Rust just
a little easier for us.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/sunrpc/xdr/nlm3.x    | 168 +++++++++
 fs/lockd/Makefile                  |  19 +-
 fs/lockd/nlm3xdr_gen.c             | 714 +++++++++++++++++++++++++++++++++++++
 fs/lockd/nlm3xdr_gen.h             |  32 ++
 include/linux/sunrpc/xdrgen/nlm3.h | 210 +++++++++++
 5 files changed, 1139 insertions(+), 4 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nlm3.x b/Documentation/sunrpc/xdr/nlm3.x
new file mode 100644
index 000000000000..b2e704f7b864
--- /dev/null
+++ b/Documentation/sunrpc/xdr/nlm3.x
@@ -0,0 +1,168 @@
+/*
+ * This file was extracted by hand from
+ * https://pubs.opengroup.org/onlinepubs/9629799/chap10.htm#tagcjh_11_03
+ */
+
+/*
+ * The NLMv3 protocol
+ */
+
+pragma header nlm3;
+
+const LM_MAXSTRLEN = 1024;
+
+const LM_MAXNAMELEN = 1025;
+
+const MAXNETOBJ_SZ = 1024;
+
+typedef opaque netobj<MAXNETOBJ_SZ>;
+
+enum nlm_stats {
+	LCK_GRANTED = 0,
+	LCK_DENIED = 1,
+	LCK_DENIED_NOLOCKS = 2,
+	LCK_BLOCKED = 3,
+	LCK_DENIED_GRACE_PERIOD = 4
+};
+
+pragma big_endian nlm_stats;
+
+struct nlm_stat {
+	nlm_stats	stat;
+};
+
+struct nlm_res {
+	netobj		cookie;
+	nlm_stat	stat;
+};
+
+struct nlm_holder {
+	bool		exclusive;
+	int		uppid;
+	netobj		oh;
+	unsigned int	l_offset;
+	unsigned int	l_len;
+};
+
+union nlm_testrply switch (nlm_stats stat) {
+	case LCK_DENIED:
+		nlm_holder	holder;
+	default:
+		void;
+};
+
+struct nlm_testres {
+	netobj		cookie;
+	nlm_testrply	test_stat;
+};
+
+struct nlm_lock {
+	string		caller_name<LM_MAXSTRLEN>;
+	netobj		fh;
+	netobj		oh;
+	int		uppid;
+	unsigned int	l_offset;
+	unsigned int	l_len;
+};
+
+struct nlm_lockargs {
+	netobj		cookie;
+	bool		block;
+	bool		exclusive;
+	nlm_lock	alock;
+	bool		reclaim;
+	int		state;
+};
+
+struct nlm_cancargs {
+	netobj		cookie;
+	bool		block;
+	bool		exclusive;
+	nlm_lock	alock;
+};
+
+struct nlm_testargs {
+	netobj		cookie;
+	bool		exclusive;
+	nlm_lock	alock;
+};
+
+struct nlm_unlockargs {
+	netobj		cookie;
+	nlm_lock	alock;
+};
+
+enum fsh_mode {
+	fsm_DN = 0,
+	fsm_DR = 1,
+	fsm_DW = 2,
+	fsm_DRW = 3
+};
+
+enum fsh_access {
+	fsa_NONE = 0,
+	fsa_R = 1,
+	fsa_W = 2,
+	fsa_RW = 3
+};
+
+struct nlm_share {
+	string		caller_name<LM_MAXSTRLEN>;
+	netobj		fh;
+	netobj		oh;
+	fsh_mode	mode;
+	fsh_access	access;
+};
+
+struct nlm_shareargs {
+	netobj		cookie;
+	nlm_share	share;
+	bool		reclaim;
+};
+
+struct nlm_shareres {
+	netobj		cookie;
+	nlm_stats	stat;
+	int		sequence;
+};
+
+struct nlm_notify {
+	string		name<LM_MAXNAMELEN>;
+	long		state;
+};
+
+/*
+ * Argument for the Linux-private SM_NOTIFY procedure
+ */
+const SM_PRIV_SIZE = 16;
+
+struct nlm_notifyargs {
+	nlm_notify	notify;
+	opaque		private[SM_PRIV_SIZE];
+};
+
+program NLM_PROG {
+	version NLM_VERS {
+		void		NLM_NULL(void)				= 0;
+		nlm_testres	NLM_TEST(nlm_testargs)			= 1;
+		nlm_res		NLM_LOCK(nlm_lockargs)			= 2;
+		nlm_res		NLM_CANCEL(nlm_cancargs)		= 3;
+		nlm_res		NLM_UNLOCK(nlm_unlockargs)		= 4;
+		nlm_res		NLM_GRANTED(nlm_testargs)		= 5;
+		void		NLM_TEST_MSG(nlm_testargs)		= 6;
+		void		NLM_LOCK_MSG(nlm_lockargs)		= 7;
+		void		NLM_CANCEL_MSG(nlm_cancargs)		= 8;
+		void		NLM_UNLOCK_MSG(nlm_unlockargs)		= 9;
+		void		NLM_GRANTED_MSG(nlm_testargs)		= 10;
+		void		NLM_TEST_RES(nlm_testres)		= 11;
+		void		NLM_LOCK_RES(nlm_res)			= 12;
+		void		NLM_CANCEL_RES(nlm_res)			= 13;
+		void		NLM_UNLOCK_RES(nlm_res)			= 14;
+		void		NLM_GRANTED_RES(nlm_res)		= 15;
+		void		NLM_SM_NOTIFY(nlm_notifyargs)		= 16;
+		nlm_shareres	NLM_SHARE(nlm_shareargs)		= 20;
+		nlm_shareres	NLM_UNSHARE(nlm_shareargs)		= 21;
+		nlm_res		NLM_NM_LOCK(nlm_lockargs)		= 22;
+		void		NLM_FREE_ALL(nlm_notify)		= 23;
+	} = 3;
+} = 100021;
diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 808f0f2a7be1..951a74e4847a 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -8,7 +8,8 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o
+	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o \
+	   nlm3xdr_gen.o
 lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o svc4proc.o nlm4xdr_gen.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
 
@@ -25,17 +26,27 @@ lockd-$(CONFIG_PROC_FS) += procfs.o
 
 XDRGEN			= ../../tools/net/sunrpc/xdrgen/xdrgen
 
-XDRGEN_DEFINITIONS	= ../../include/linux/sunrpc/xdrgen/nlm4.h
-XDRGEN_DECLARATIONS	= nlm4xdr_gen.h
-XDRGEN_SOURCE		= nlm4xdr_gen.c
+XDRGEN_DEFINITIONS	= ../../include/linux/sunrpc/xdrgen/nlm4.h \
+			  ../../include/linux/sunrpc/xdrgen/nlm3.h
+XDRGEN_DECLARATIONS	= nlm4xdr_gen.h nlm3xdr_gen.h
+XDRGEN_SOURCE		= nlm4xdr_gen.c nlm3xdr_gen.c
 
 xdrgen: $(XDRGEN_DEFINITIONS) $(XDRGEN_DECLARATIONS) $(XDRGEN_SOURCE)
 
 ../../include/linux/sunrpc/xdrgen/nlm4.h: ../../Documentation/sunrpc/xdr/nlm4.x
 	$(XDRGEN) definitions $< > $@
 
+../../include/linux/sunrpc/xdrgen/nlm3.h: ../../Documentation/sunrpc/xdr/nlm3.x
+	$(XDRGEN) definitions $< > $@
+
 nlm4xdr_gen.h: ../../Documentation/sunrpc/xdr/nlm4.x
 	$(XDRGEN) declarations $< > $@
 
+nlm3xdr_gen.h: ../../Documentation/sunrpc/xdr/nlm3.x
+	$(XDRGEN) declarations $< > $@
+
 nlm4xdr_gen.c: ../../Documentation/sunrpc/xdr/nlm4.x
 	$(XDRGEN) source --peer server $< > $@
+
+nlm3xdr_gen.c: ../../Documentation/sunrpc/xdr/nlm3.x
+	$(XDRGEN) source --peer server $< > $@
diff --git a/fs/lockd/nlm3xdr_gen.c b/fs/lockd/nlm3xdr_gen.c
new file mode 100644
index 000000000000..9ed5a41b5daf
--- /dev/null
+++ b/fs/lockd/nlm3xdr_gen.c
@@ -0,0 +1,714 @@
+// SPDX-License-Identifier: GPL-2.0
+// Generated by xdrgen. Manual edits will be lost.
+// XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x
+// XDR specification modification time: Thu Apr 23 10:56:34 2026
+
+#include <linux/sunrpc/svc.h>
+
+#include "nlm3xdr_gen.h"
+
+static bool __maybe_unused
+xdrgen_decode_netobj(struct xdr_stream *xdr, netobj *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, MAXNETOBJ_SZ);
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_stats(struct xdr_stream *xdr, nlm_stats *ptr)
+{
+	__be32 raw;
+	u32 val;
+
+	if (xdr_stream_decode_be32(xdr, &raw) < 0)
+		return false;
+	val = be32_to_cpu(raw);
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case LCK_GRANTED:
+	case LCK_DENIED:
+	case LCK_DENIED_NOLOCKS:
+	case LCK_BLOCKED:
+	case LCK_DENIED_GRACE_PERIOD:
+		break;
+	default:
+		return false;
+	}
+	*ptr = raw;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_stat(struct xdr_stream *xdr, struct nlm_stat *ptr)
+{
+	if (!xdrgen_decode_nlm_stats(xdr, &ptr->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_res(struct xdr_stream *xdr, struct nlm_res *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm_stat(xdr, &ptr->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_holder(struct xdr_stream *xdr, struct nlm_holder *ptr)
+{
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_int(xdr, &ptr->uppid))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_unsigned_int(xdr, &ptr->l_offset))
+		return false;
+	if (!xdrgen_decode_unsigned_int(xdr, &ptr->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_testrply(struct xdr_stream *xdr, struct nlm_testrply *ptr)
+{
+	if (!xdrgen_decode_nlm_stats(xdr, &ptr->stat))
+		return false;
+	switch (ptr->stat) {
+	case __constant_cpu_to_be32(LCK_DENIED):
+		if (!xdrgen_decode_nlm_holder(xdr, &ptr->u.holder))
+			return false;
+		break;
+	default:
+		break;
+	}
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_testres(struct xdr_stream *xdr, struct nlm_testres *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm_testrply(xdr, &ptr->test_stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_lock(struct xdr_stream *xdr, struct nlm_lock *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXSTRLEN))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->fh))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_int(xdr, &ptr->uppid))
+		return false;
+	if (!xdrgen_decode_unsigned_int(xdr, &ptr->l_offset))
+		return false;
+	if (!xdrgen_decode_unsigned_int(xdr, &ptr->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_lockargs(struct xdr_stream *xdr, struct nlm_lockargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->block))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm_lock(xdr, &ptr->alock))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->reclaim))
+		return false;
+	if (!xdrgen_decode_int(xdr, &ptr->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_cancargs(struct xdr_stream *xdr, struct nlm_cancargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->block))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_testargs(struct xdr_stream *xdr, struct nlm_testargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->exclusive))
+		return false;
+	if (!xdrgen_decode_nlm_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_unlockargs(struct xdr_stream *xdr, struct nlm_unlockargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm_lock(xdr, &ptr->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fsh_mode(struct xdr_stream *xdr, fsh_mode *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case fsm_DN:
+	case fsm_DR:
+	case fsm_DW:
+	case fsm_DRW:
+		break;
+	default:
+		return false;
+	}
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_fsh_access(struct xdr_stream *xdr, fsh_access *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case fsa_NONE:
+	case fsa_R:
+	case fsa_W:
+	case fsa_RW:
+		break;
+	default:
+		return false;
+	}
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_share(struct xdr_stream *xdr, struct nlm_share *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXSTRLEN))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->fh))
+		return false;
+	if (!xdrgen_decode_netobj(xdr, &ptr->oh))
+		return false;
+	if (!xdrgen_decode_fsh_mode(xdr, &ptr->mode))
+		return false;
+	if (!xdrgen_decode_fsh_access(xdr, &ptr->access))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_shareargs(struct xdr_stream *xdr, struct nlm_shareargs *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm_share(xdr, &ptr->share))
+		return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->reclaim))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_shareres(struct xdr_stream *xdr, struct nlm_shareres *ptr)
+{
+	if (!xdrgen_decode_netobj(xdr, &ptr->cookie))
+		return false;
+	if (!xdrgen_decode_nlm_stats(xdr, &ptr->stat))
+		return false;
+	if (!xdrgen_decode_int(xdr, &ptr->sequence))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_notify(struct xdr_stream *xdr, struct nlm_notify *ptr)
+{
+	if (!xdrgen_decode_string(xdr, (string *)ptr, LM_MAXNAMELEN))
+		return false;
+	if (!xdrgen_decode_long(xdr, &ptr->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_nlm_notifyargs(struct xdr_stream *xdr, struct nlm_notifyargs *ptr)
+{
+	if (!xdrgen_decode_nlm_notify(xdr, &ptr->notify))
+		return false;
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->private, SM_PRIV_SIZE) < 0)
+		return false;
+	return true;
+}
+
+/**
+ * nlm_svc_decode_void - Decode a void argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_decode_void(xdr);
+}
+
+/**
+ * nlm_svc_decode_nlm_testargs - Decode a nlm_testargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_testargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_testargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_lockargs - Decode a nlm_lockargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_lockargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_lockargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_cancargs - Decode a nlm_cancargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_cancargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_cancargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_unlockargs - Decode a nlm_unlockargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_unlockargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_unlockargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_testres - Decode a nlm_testres argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_testres *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_testres(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_res - Decode a nlm_res argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_res *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_res(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_notifyargs - Decode a nlm_notifyargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_notifyargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_notifyargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_shareargs - Decode a nlm_shareargs argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_shareargs *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_shareargs(xdr, argp);
+}
+
+/**
+ * nlm_svc_decode_nlm_notify - Decode a nlm_notify argument
+ * @rqstp: RPC transaction context
+ * @xdr: source XDR data stream
+ *
+ * Return values:
+ *   %true: procedure arguments decoded successfully
+ *   %false: decode failed
+ */
+bool nlm_svc_decode_nlm_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_notify *argp = rqstp->rq_argp;
+
+	return xdrgen_decode_nlm_notify(xdr, argp);
+}
+
+static bool __maybe_unused
+xdrgen_encode_netobj(struct xdr_stream *xdr, const netobj value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_stats(struct xdr_stream *xdr, nlm_stats value)
+{
+	return xdr_stream_encode_be32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_stat(struct xdr_stream *xdr, const struct nlm_stat *value)
+{
+	if (!xdrgen_encode_nlm_stats(xdr, value->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_res(struct xdr_stream *xdr, const struct nlm_res *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm_stat(xdr, &value->stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_holder(struct xdr_stream *xdr, const struct nlm_holder *value)
+{
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_int(xdr, value->uppid))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_unsigned_int(xdr, value->l_offset))
+		return false;
+	if (!xdrgen_encode_unsigned_int(xdr, value->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_testrply(struct xdr_stream *xdr, const struct nlm_testrply *ptr)
+{
+	if (!xdrgen_encode_nlm_stats(xdr, ptr->stat))
+		return false;
+	switch (ptr->stat) {
+	case __constant_cpu_to_be32(LCK_DENIED):
+		if (!xdrgen_encode_nlm_holder(xdr, &ptr->u.holder))
+			return false;
+		break;
+	default:
+		break;
+	}
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_testres(struct xdr_stream *xdr, const struct nlm_testres *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm_testrply(xdr, &value->test_stat))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_lock(struct xdr_stream *xdr, const struct nlm_lock *value)
+{
+	if (value->caller_name.len > LM_MAXSTRLEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->caller_name.data, value->caller_name.len) < 0)
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->fh))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_int(xdr, value->uppid))
+		return false;
+	if (!xdrgen_encode_unsigned_int(xdr, value->l_offset))
+		return false;
+	if (!xdrgen_encode_unsigned_int(xdr, value->l_len))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_lockargs(struct xdr_stream *xdr, const struct nlm_lockargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->block))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm_lock(xdr, &value->alock))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->reclaim))
+		return false;
+	if (!xdrgen_encode_int(xdr, value->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_cancargs(struct xdr_stream *xdr, const struct nlm_cancargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->block))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_testargs(struct xdr_stream *xdr, const struct nlm_testargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->exclusive))
+		return false;
+	if (!xdrgen_encode_nlm_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_unlockargs(struct xdr_stream *xdr, const struct nlm_unlockargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm_lock(xdr, &value->alock))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fsh_mode(struct xdr_stream *xdr, fsh_mode value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_fsh_access(struct xdr_stream *xdr, fsh_access value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_share(struct xdr_stream *xdr, const struct nlm_share *value)
+{
+	if (value->caller_name.len > LM_MAXSTRLEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->caller_name.data, value->caller_name.len) < 0)
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->fh))
+		return false;
+	if (!xdrgen_encode_netobj(xdr, value->oh))
+		return false;
+	if (!xdrgen_encode_fsh_mode(xdr, value->mode))
+		return false;
+	if (!xdrgen_encode_fsh_access(xdr, value->access))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_shareargs(struct xdr_stream *xdr, const struct nlm_shareargs *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm_share(xdr, &value->share))
+		return false;
+	if (!xdrgen_encode_bool(xdr, value->reclaim))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_shareres(struct xdr_stream *xdr, const struct nlm_shareres *value)
+{
+	if (!xdrgen_encode_netobj(xdr, value->cookie))
+		return false;
+	if (!xdrgen_encode_nlm_stats(xdr, value->stat))
+		return false;
+	if (!xdrgen_encode_int(xdr, value->sequence))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_notify(struct xdr_stream *xdr, const struct nlm_notify *value)
+{
+	if (value->name.len > LM_MAXNAMELEN)
+		return false;
+	if (xdr_stream_encode_opaque(xdr, value->name.data, value->name.len) < 0)
+		return false;
+	if (!xdrgen_encode_long(xdr, value->state))
+		return false;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_encode_nlm_notifyargs(struct xdr_stream *xdr, const struct nlm_notifyargs *value)
+{
+	if (!xdrgen_encode_nlm_notify(xdr, &value->notify))
+		return false;
+	if (xdr_stream_encode_opaque_fixed(xdr, value->private, SM_PRIV_SIZE) < 0)
+		return false;
+	return true;
+}
+
+/**
+ * nlm_svc_encode_void - Encode a void result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	return xdrgen_encode_void(xdr);
+}
+
+/**
+ * nlm_svc_encode_nlm_testres - Encode a nlm_testres result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm_svc_encode_nlm_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_testres *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm_testres(xdr, resp);
+}
+
+/**
+ * nlm_svc_encode_nlm_res - Encode a nlm_res result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm_svc_encode_nlm_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_res *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm_res(xdr, resp);
+}
+
+/**
+ * nlm_svc_encode_nlm_shareres - Encode a nlm_shareres result
+ * @rqstp: RPC transaction context
+ * @xdr: target XDR data stream
+ *
+ * Return values:
+ *   %true: procedure results encoded successfully
+ *   %false: encode failed
+ */
+bool nlm_svc_encode_nlm_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+{
+	struct nlm_shareres *resp = rqstp->rq_resp;
+
+	return xdrgen_encode_nlm_shareres(xdr, resp);
+}
diff --git a/fs/lockd/nlm3xdr_gen.h b/fs/lockd/nlm3xdr_gen.h
new file mode 100644
index 000000000000..c99038e99805
--- /dev/null
+++ b/fs/lockd/nlm3xdr_gen.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
+/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
+
+#ifndef _LINUX_XDRGEN_NLM3_DECL_H
+#define _LINUX_XDRGEN_NLM3_DECL_H
+
+#include <linux/types.h>
+
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+#include <linux/sunrpc/xdrgen/_builtins.h>
+#include <linux/sunrpc/xdrgen/nlm3.h>
+
+bool nlm_svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_notifyargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_decode_nlm_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
+bool nlm_svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_encode_nlm_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_encode_nlm_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nlm_svc_encode_nlm_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
+#endif /* _LINUX_XDRGEN_NLM3_DECL_H */
diff --git a/include/linux/sunrpc/xdrgen/nlm3.h b/include/linux/sunrpc/xdrgen/nlm3.h
new file mode 100644
index 000000000000..897e7d91807c
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen/nlm3.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
+/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
+
+#ifndef _LINUX_XDRGEN_NLM3_DEF_H
+#define _LINUX_XDRGEN_NLM3_DEF_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+
+enum { LM_MAXSTRLEN = 1024 };
+
+enum { LM_MAXNAMELEN = 1025 };
+
+enum { MAXNETOBJ_SZ = 1024 };
+
+typedef opaque netobj;
+
+enum nlm_stats {
+	LCK_GRANTED = 0,
+	LCK_DENIED = 1,
+	LCK_DENIED_NOLOCKS = 2,
+	LCK_BLOCKED = 3,
+	LCK_DENIED_GRACE_PERIOD = 4,
+};
+
+typedef __be32 nlm_stats;
+
+struct nlm_stat {
+	nlm_stats stat;
+};
+
+struct nlm_res {
+	netobj cookie;
+	struct nlm_stat stat;
+};
+
+struct nlm_holder {
+	bool exclusive;
+	s32 uppid;
+	netobj oh;
+	u32 l_offset;
+	u32 l_len;
+};
+
+struct nlm_testrply {
+	nlm_stats stat;
+	union {
+		struct nlm_holder holder;
+	} u;
+};
+
+struct nlm_testres {
+	netobj cookie;
+	struct nlm_testrply test_stat;
+};
+
+struct nlm_lock {
+	string caller_name;
+	netobj fh;
+	netobj oh;
+	s32 uppid;
+	u32 l_offset;
+	u32 l_len;
+};
+
+struct nlm_lockargs {
+	netobj cookie;
+	bool block;
+	bool exclusive;
+	struct nlm_lock alock;
+	bool reclaim;
+	s32 state;
+};
+
+struct nlm_cancargs {
+	netobj cookie;
+	bool block;
+	bool exclusive;
+	struct nlm_lock alock;
+};
+
+struct nlm_testargs {
+	netobj cookie;
+	bool exclusive;
+	struct nlm_lock alock;
+};
+
+struct nlm_unlockargs {
+	netobj cookie;
+	struct nlm_lock alock;
+};
+
+enum fsh_mode {
+	fsm_DN = 0,
+	fsm_DR = 1,
+	fsm_DW = 2,
+	fsm_DRW = 3,
+};
+
+typedef enum fsh_mode fsh_mode;
+
+enum fsh_access {
+	fsa_NONE = 0,
+	fsa_R = 1,
+	fsa_W = 2,
+	fsa_RW = 3,
+};
+
+typedef enum fsh_access fsh_access;
+
+struct nlm_share {
+	string caller_name;
+	netobj fh;
+	netobj oh;
+	fsh_mode mode;
+	fsh_access access;
+};
+
+struct nlm_shareargs {
+	netobj cookie;
+	struct nlm_share share;
+	bool reclaim;
+};
+
+struct nlm_shareres {
+	netobj cookie;
+	nlm_stats stat;
+	s32 sequence;
+};
+
+struct nlm_notify {
+	string name;
+	s32 state;
+};
+
+enum { SM_PRIV_SIZE = 16 };
+
+struct nlm_notifyargs {
+	struct nlm_notify notify;
+	u8 private[SM_PRIV_SIZE];
+};
+
+enum {
+	NLM_NULL = 0,
+	NLM_TEST = 1,
+	NLM_LOCK = 2,
+	NLM_CANCEL = 3,
+	NLM_UNLOCK = 4,
+	NLM_GRANTED = 5,
+	NLM_TEST_MSG = 6,
+	NLM_LOCK_MSG = 7,
+	NLM_CANCEL_MSG = 8,
+	NLM_UNLOCK_MSG = 9,
+	NLM_GRANTED_MSG = 10,
+	NLM_TEST_RES = 11,
+	NLM_LOCK_RES = 12,
+	NLM_CANCEL_RES = 13,
+	NLM_UNLOCK_RES = 14,
+	NLM_GRANTED_RES = 15,
+	NLM_SM_NOTIFY = 16,
+	NLM_SHARE = 20,
+	NLM_UNSHARE = 21,
+	NLM_NM_LOCK = 22,
+	NLM_FREE_ALL = 23,
+};
+
+#ifndef NLM_PROG
+#define NLM_PROG (100021)
+#endif
+
+#define NLM3_netobj_sz                  (XDR_unsigned_int + XDR_QUADLEN(MAXNETOBJ_SZ))
+#define NLM3_nlm_stats_sz               (XDR_int)
+#define NLM3_nlm_stat_sz                \
+	(NLM3_nlm_stats_sz)
+#define NLM3_nlm_res_sz                 \
+	(NLM3_netobj_sz + NLM3_nlm_stat_sz)
+#define NLM3_nlm_holder_sz              \
+	(XDR_bool + XDR_int + NLM3_netobj_sz + XDR_unsigned_int + XDR_unsigned_int)
+#define NLM3_nlm_testrply_sz            \
+	(NLM3_nlm_stats_sz + NLM3_nlm_holder_sz)
+#define NLM3_nlm_testres_sz             \
+	(NLM3_netobj_sz + NLM3_nlm_testrply_sz)
+#define NLM3_nlm_lock_sz                \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXSTRLEN) + NLM3_netobj_sz + NLM3_netobj_sz + XDR_int + XDR_unsigned_int + XDR_unsigned_int)
+#define NLM3_nlm_lockargs_sz            \
+	(NLM3_netobj_sz + XDR_bool + XDR_bool + NLM3_nlm_lock_sz + XDR_bool + XDR_int)
+#define NLM3_nlm_cancargs_sz            \
+	(NLM3_netobj_sz + XDR_bool + XDR_bool + NLM3_nlm_lock_sz)
+#define NLM3_nlm_testargs_sz            \
+	(NLM3_netobj_sz + XDR_bool + NLM3_nlm_lock_sz)
+#define NLM3_nlm_unlockargs_sz          \
+	(NLM3_netobj_sz + NLM3_nlm_lock_sz)
+#define NLM3_fsh_mode_sz                (XDR_int)
+#define NLM3_fsh_access_sz              (XDR_int)
+#define NLM3_nlm_share_sz               \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXSTRLEN) + NLM3_netobj_sz + NLM3_netobj_sz + NLM3_fsh_mode_sz + NLM3_fsh_access_sz)
+#define NLM3_nlm_shareargs_sz           \
+	(NLM3_netobj_sz + NLM3_nlm_share_sz + XDR_bool)
+#define NLM3_nlm_shareres_sz            \
+	(NLM3_netobj_sz + NLM3_nlm_stats_sz + XDR_int)
+#define NLM3_nlm_notify_sz              \
+	(XDR_unsigned_int + XDR_QUADLEN(LM_MAXNAMELEN) + XDR_long)
+#define NLM3_nlm_notifyargs_sz          \
+	(NLM3_nlm_notify_sz + XDR_QUADLEN(SM_PRIV_SIZE))
+#define NLM3_MAX_ARGS_SZ                \
+	(NLM3_nlm_lockargs_sz)
+
+#endif /* _LINUX_XDRGEN_NLM3_DEF_H */

-- 
2.54.0


