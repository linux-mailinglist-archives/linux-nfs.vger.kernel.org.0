Return-Path: <linux-nfs+bounces-22129-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIOCv0kHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22129-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:09:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DC615FBC
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF1893021B1B
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AC3876A1;
	Sun, 31 May 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq82Z7Wk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B5386576;
	Sun, 31 May 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229231; cv=none; b=KqdwuUBdiiRRFz+98LkYoOO4pAmsO2djtIObyoirq4g/C9cJVfEwOhTiIExdDRaYOrq7ACuIiB0jLSFF/TgEn4WkMN9jbgyZ2RxbZYK+9wPGD8xqNT9pxU8PxXg3vqTvKPe6p0C4PDKbDu3PhMmzi95yddaVxiTL40oFdh6MWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229231; c=relaxed/simple;
	bh=64u5Ul+xqTSb5rRj1hmUXpte0cuXwsv1Env2BJhxpn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gisp9VRSOmeBI6z93BDDwVIbaLfZOPzGI/DBEsMTiCGqbrp6fWwIVSHxrUsdOaZsEnvxmQLls6m5sQKZT6bbAnsglR5Seb4QxvttGiOuDVYwY63+41A1eo3jiCfguuZLytWSmpGaFQyt9WY3m0bI91CkqkFyN7LxmpHdwkuvps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq82Z7Wk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5A71F00898;
	Sun, 31 May 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229230;
	bh=kZNbxB7wKYlevcJJobkWbc4vfQxHHhzun3nc92sGqM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lq82Z7WksVaFNhPcOaEEZjmNYIymItxaXVPUeq26BAuYs6eu0cWplXO1hEnljZe+N
	 ZR6Tyo5ErTVWuyUaijDCyCQYMQO/JvOXMRe0aPfFZRBoAXt7vI+pPaiCZLZ0YcHPa0
	 lmPEfT89ENwWjcUaOcOb9OEiVAynEt8b/ETeZQlpt/KqxhwIBG7P4o+ow41U4AXmjD
	 uQcO9wBMMpb0fL7wMqW841Y6gzNdEKm7RWAx+43pHr6ehg2F/weOSxj+GdhEkten2M
	 d7yZ6t7mt1joVoTX1sUTcfmEIZ4+EyHxQxibDcKZZiwf6rUgppu6LbBjQfKk6/XnUr
	 biWGcUaPlZgtA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:06:58 -0400
Subject: [PATCH 1/6] nfsd: size fh_verify server sockaddr slot by
 xpt_locallen
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-1-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DaEpCa5QFYyJa/GWwlqRdWIspy4HMPc365Q8vph+iXE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHCRqideoPPwp9ZgCO2ZqBCx9JHgea5jEcvO+q
 j9ZuSpIVxGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahwkagAKCRAADmhBGVaC
 Fb6TEADRwsCcMHDF8qo3BpNJyHaV5kVibgcPcBMOmY0LxSB9gn639quiU8bHC4v1D4KjCmq8pMc
 pB9OuxS1G9qDU/oFD6QwwExKORZqhc3pDoURI66B4UOu8j0Ap1cwOidftKERK1p4JnPzp2OSV85
 7U7PagdJUbg6pC25p8f8uT2a4XFl2SFoosUptG8xs4cGLZrxSfU5mGqScHQnrP191QCqf6VP/SU
 rTnmSfIGRZsBgS50zzW0nFV2sOB5a9Ja/PMC/WxPm7y0nBBvAM52TvLeTIJ1Uqvaif0HXOP48D8
 s8Rat0flsPQlMq3mcu0yihKnpvcDt6fwBfMuUjx+CSziGMHAFW6xu6/sqgF6RboJbXZ7R1O8OsE
 DLutRqRz0r25bb4xLzXVpZkChWqjpl2veNUUaEeZE5tf0ugqrayqrN/za9L5CoYeEysfHnYPa6g
 lgHnnxKa5rI7ldttsen6JwRpwwbEpC7EW9bnuidNsvdyTHThU3a6XG4DHub4Bdzr0Ci7CmzCKi/
 1eLDJi/2vHzMrRxdmJ5baMpb0lI3VECJQ5Fg3QhWTD5uXqRpCxmAKYzATecfqW0YG3utjZFERoM
 XiIOVf04udHa9hL4vsmOU4OV4o3gfvqlhqF0/VMEWd1PbmthJYiDpLURlQRc1H6Se+1PlUEFm9y
 YyUNlM/xULKIoCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22129-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 838DC615FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

The nfsd_fh_verify and nfsd_fh_verify_err tracepoints declare the
server sockaddr slot sized by xpt_remotelen but fill it from
xpt_local using xpt_locallen:

    TP_STRUCT__entry(
            ...
            __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
            ...
    )
    TP_fast_assign(
            ...
            __assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
                              rqstp->rq_xprt->xpt_locallen);
            ...
    )

When xpt_locallen exceeds xpt_remotelen, __assign_sockaddr's memcpy
writes past the reserved ring-buffer slot. In the reverse direction
(xpt_locallen < xpt_remotelen) the slot is oversized and the
unwritten tail leaks prior ring-buffer contents to trace consumers.

The write-past-end case is reachable on NFS/UDP. svc_xprt_set_remote()
is only called from svc_tcp_accept() (net/sunrpc/svcsock.c) and from
the RDMA connect path; svc_create_socket() for UDP calls only
svc_xprt_set_local(), so xpt_remotelen stays 0 for the xprt's
lifetime. Every fh_verify trace for an NFSv2/v3-over-UDP request
then copies 16 or 28 bytes from xpt_local into a zero-byte slot.

The other NFSD tracepoints that record the server address
(NFSD_TRACE_PROC_CALL_FIELDS, NFSD_TRACE_PROC_RES_FIELDS,
SVC_RQST_ENDPOINT_FIELDS) already size the server slot by
xpt_locallen; nfsd_fh_verify and nfsd_fh_verify_err were the only
exceptions.

Fix by sizing the server slot with xpt_locallen so the declared slot
matches the copy length. The client slot and its assignment already
agree on xpt_remotelen and are left untouched.

Fixes: 051382885552 ("NFSD: Instrument fh_verify()")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9917c0440522..db0a0dc70660 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -272,7 +272,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify,
 	TP_CONDITION(rqstp != NULL),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
@@ -311,7 +311,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_CONDITION(rqstp != NULL && error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)

-- 
2.54.0


