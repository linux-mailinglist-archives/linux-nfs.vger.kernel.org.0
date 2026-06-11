Return-Path: <linux-nfs+bounces-22494-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AlsfKwcUK2oZ2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22494-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E6674E54
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cshZFLVh;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22494-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22494-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C75630EBA30
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056936A004;
	Thu, 11 Jun 2026 20:01:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1F41C6A;
	Thu, 11 Jun 2026 20:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208068; cv=none; b=YMTBEI3Ytxfs+CtcqWEflMPiWbk/y903B8qMeuG2I39uJ/xTmhEos/OzQEjV0w35nyeu2KUDsktZDChnLNM5dfIu82Rc3CuN03QiXuL4B0HQa6b7HiaPQuLmIAi2IQotO9zLFhm2nNrrnarCkCkj7v0F50SxWDjM2SItw/q4Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208068; c=relaxed/simple;
	bh=oBxossIdZf8cETc+99TCwHtwXwT75BqZ4zJfgbPIMqA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kNHVrdDCbJaQl3lR+aGmrAM0LwMlL5PA79yq0KCyDNRpvaNDIL3gtFf3uz8AFGqliyTqBTb02V+om4QGNWvXbx+FcbnSbPo+FBreKgbMqPSZHn28S2rKqyzFOliKcWlIcOwrY74up+EO3AMh3LdzkXKIHq2OPuE0LSyM8MfYvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cshZFLVh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2AB1F000E9;
	Thu, 11 Jun 2026 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208066;
	bh=gAMgw26geIzoB6GFAHYRSogb5jJCM3xYCHORdBNyfrY=;
	h=From:Subject:Date:To:Cc;
	b=cshZFLVh9vamZAYv9QuI6GAKH1NqZEyMQRuQurjPPZVvUWRpcXNxIOa6EE99h3NqR
	 uzcozHCn8jjWADXR+RYaZQzxW3dlAeYL/u6lBDSJm9a2YJDhcql1onhcgx8p5cda0p
	 JQJUTi7IrrRqvuU+6ZgtrZxit5uLbziolw40YPgDMft+JDkki2Rh0GTipxYtngzntF
	 NJV2mYoc5jhiBTshqvcKX3HiCkzPB8F0TrWtvFptMtrhulg9ijBhesguj7DnZ0C7x4
	 7z4osaPgKzt2ww3EM6f1PrjfEWbXsSxe7315ef2Uipx2GeNsVTAsnySg8HdlxN+0cf
	 +mki1TFJ3IYlw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/21] nfsd: more bugfixes
Date: Thu, 11 Jun 2026 16:00:43 -0400
Message-Id: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XMwQoCIRSF4VcZ7jrD0RJrNe8RsxC941wKDRUpB
 t89G2jR8j9wvg0yJsIM12GDhJUyxdBDHAawqwkeGbneILhQXHHNwpIdK5gLBc+U1kaLk5T2zKF
 fngkXeu3cbe69Ui4xvXe9jt/1B13+oToyzlBLY9E4YVBPd0wBH8eYPMyttQ+LFZYLqQAAAA==
X-Change-ID: 20260608-nfsd-testing-688a82433c50
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oBxossIdZf8cETc+99TCwHtwXwT75BqZ4zJfgbPIMqA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP3xrL3SZPYtAIAYsA+uvCpmANwdxTpTcHUD
 QBt/UshIoyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT9wAKCRAADmhBGVaC
 FUkdD/9WPQuCwWCDaos65/Z0+rix9gZ2qA02fr0W8QQEmhGkdj+u5nFNTjCNC2r+bUuRcWsO2yn
 S2w2+7pXhqzd4SlXta6USRaPHX/oz/v8YwKdXvQl/T2lO7HiECJfb35is+69V8Pe7gxTkpr92n7
 ZV02poRzdyqdaDzi4N1F873/dTQYcW3xcWwt14FQ1ul6Z6x15Ec+ciBhfO0Aq3NIM6lL9G/gYNH
 hHia591bwoyU8M3Pf6JPlUsHBVn8shCHhurwDwSX6DwefxNR8wUXodjNhQSN1EcIAie86ZhVPT5
 2eCVEuu1iLcXpm5eyc4ZflYJWoCIC/S4Jv6KV73TrxqGq025DiQa3JbRDrsDd8gip9EMt73dQ8g
 LJKbOO2HXlQXVEwdGxCUxYqi+i7fw6Wis+EnuOalQm0qUOf06nkHgaMNSbK+U2F1AnHYTQ2qy1b
 3+raBXOJ4n2ETBjWwuU7CQQKNIaViWn6k93jU4OPF1BEjGvGbmtbs7LR2rFEO2A0UaP76KsFLH2
 mabX+o7OUR+0aGY6zycT9J1G2A94dpuT3VX1goZrHPhT4o9PHt4f9SnNY5VhqCGtEw6zLqdCNJL
 TODDiFkzrWt4JgmHrgx3mj5hWghg1FwJvskUMyIxYQzMjOSZmtO4ZU2Jxvd3GZFLPDakIGxayBA
 3/dXwt6K6ir3jHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22494-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 221E6674E54

This version is addresses review comments from Sashiko. There wasn't
much in the way of regressions in v1, but it did notice a number of
nearby problems that should also be fixed.

This adds 3 patches to fix those. I also dropped the localio patch from
the series since that should probably go through the NFS client tree.
I'll send it separately.

AFAICT, these are garden-variety bugs. Chuck, please consider these for
v7.3.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add 3 new patches for nearby bugs sashiko noticed while reviewing v1
- Clean up unwinding when server startup fails
- Link to v1: https://lore.kernel.org/r/20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org

---
Jeff Layton (21):
      nfsd: clear opcnt on compound arg release to prevent OOB read
      nfsd: add missing read barrier to rpc_status_get dumpit seqcount retry
      nfsd: fix netlink dumpit error handling for rpc_status_get
      sunrpc: defer rq_argp and rq_resp free until after RCU grace period
      nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()
      nfsd: add filehandle match check to nfsd4_delegreturn()
      nfsd: validate nseconds in TIME_DELEG decode paths
      nfsd: remove premature NFS4_OO_CONFIRMED in CLAIM_PREVIOUS path
      nfsd: fix version mismatch loops in nfsd_acl_init_request()
      nfsd: fix FL_SLEEP being set unconditionally for all LOCK types
      nfsd: add fh_want_write() for early-verified SETATTR in nfsd_proc_setattr()
      nfsd: fix clock domain mismatch in clients_still_reclaiming()
      nfsd: use test_and_clear_bit for somebody_reclaimed to prevent lost update
      nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
      nfsd: validate sockaddr length per family in listener_set
      lockd, nfsd: RCU-protect nlmsvc_ops dispatch
      nfsd: move nfsd_debugfs_init() after nfsd4_init_slabs() in init_nfsd()
      nfsd: initialize DRC hash table before registering shrinker
      nfsd: restore rq_status_counter to even on all nfsd_dispatch() exit paths
      nfsd: reset thread skip index when advancing pools in rpc_status dumpit
      nfsd: drop the stateid, not the stateowner, on seqid_op replay retry

 Documentation/netlink/specs/nfsd.yaml |  4 ++
 fs/lockd/svc.c                        |  4 +-
 fs/lockd/svc4proc.c                   |  4 +-
 fs/lockd/svcproc.c                    |  4 +-
 fs/lockd/svcsubs.c                    | 52 +++++++++++++++++++----
 fs/nfsd/lockd.c                       |  6 ++-
 fs/nfsd/netlink.c                     |  2 +-
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfs4callback.c                |  4 ++
 fs/nfsd/nfs4proc.c                    |  3 +-
 fs/nfsd/nfs4state.c                   | 24 +++++++----
 fs/nfsd/nfs4xdr.c                     |  5 +++
 fs/nfsd/nfscache.c                    |  4 +-
 fs/nfsd/nfsctl.c                      | 77 +++++++++++++++++++++++++++++------
 fs/nfsd/nfsproc.c                     |  7 ++++
 fs/nfsd/nfssvc.c                      | 27 ++++++++----
 include/linux/lockd/bind.h            | 12 ++++--
 net/sunrpc/svc.c                      | 13 ++++--
 18 files changed, 200 insertions(+), 53 deletions(-)
---
base-commit: 8defc3ed26a2b4c8677ce2106c2c92cd26ef1316
change-id: 20260608-nfsd-testing-688a82433c50

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


