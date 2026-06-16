Return-Path: <linux-nfs+bounces-22606-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nn52EF89MWqGewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22606-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:11:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7268F26E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:11:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IjYaAaBm;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22606-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22606-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3486E31EED4B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AD4418FC;
	Tue, 16 Jun 2026 11:59:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134343E488;
	Tue, 16 Jun 2026 11:59:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611155; cv=none; b=HPOd1e8XyiRLheYxgYXpTDfMOWsnJYz+x6gAse/dLIOPAyfvk8ntkCOAPu75g2VfXZzOBYWOWmEH0owwJw0l6gDfTdUqer/PbY7sK02bUlOYAK8AN49eOM9ynsfIPCDI4a690aVpWoW4i0ezvxWe7hz4rlpcHJ0r6JYXF2V73N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611155; c=relaxed/simple;
	bh=59pvp3eMW0ncvWep9RgryzPLtM4cpqTIK9J1/bhiNKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/eQnpEHW14R29NbxfJVYiWvPjQvr3oWLWVZ3IlDbmtXAvTllzafRtOlvJkzzS+nNwDtTmNAGCw7iO+23VM3iD2fw4vCTWZqRlDXqMx0sQQemSuPegELV4A8hlEngK4a215gJTSE+z9HgbvfDrCM/PBtWNvDlAfDz1skO6fwwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjYaAaBm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFF31F00A3A;
	Tue, 16 Jun 2026 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611154;
	bh=g+zurFce1Cdi3oYxUuirbaeH0WttnUcZ9zjEIVhEaVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IjYaAaBmZbigc8GyHl/ajPg8t7uOUAQ/aieiwHCx6O0zYFjlz1qbbFiptSx7XcUVr
	 dNK+EIhzAVj0HIFqgpxB+8mkYbMFc9qDc6Vpbl9u/UFtewNm7Y927/pQ1SviM7Iazd
	 5ifIIlIvGQutVr8Ue80sY3YTuSYtmK/zhl3MeTdDEo9WQd7Xg3y1veKTU1p/GpBGKm
	 C5N/S+NpK8OIn0mUoY6oSVuusNd50L5P0w8LSNTkBRXz1DLjakjkBZ8WAck8HnuqDb
	 g5BAJlgP92LMljZLW9RWz1hcH99l0v7i32v96J70mf64Y4ShuS2eAwe+ddxklOz3js
	 TLCgt4u4zAlxw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:47 -0400
Subject: [PATCH v7 04/20] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-4-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=59pvp3eMW0ncvWep9RgryzPLtM4cpqTIK9J1/bhiNKc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqE9m4lkuIKsp10vOmArwzK1tFNIpV7Wyz8l
 rQNe/2eeU2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hAAKCRAADmhBGVaC
 FfAmD/9NC5/GUsb93UP2bHxflyGRqaCAYEAZtBPlgYTpsL0YO39TcweXOQqKFyJK7JxxpZzEAvU
 5X3qUjlADWJI02Mp4uH1dtlZdv4Ys3gVcOki+6N2151La4flPCEWqaSAzFCT3wZz6LIkXMb+X8N
 Ymf/xk5R6ww6fyxInI8I9H9pmCCs90041zaZI9UwjiuVg4/+0IkMfs5arSaJhuVM0BfqW/7R1w7
 FTWDx7fxlkTTPHVjxCBhIGbjUUeohNGkIIf+maCMdcrwfFignynhsNAnDTcZ2VNAwRlGKf++9zp
 wruMfmIHUvvbz/ju6E+aqUDSYaN0UUkdl6DfoYbEDmzI3bhafnjtlWqfsqTT5/7XkglzlqqUti6
 XefIkh3/Q5c32ellSlBAr734Bhh42z+COydSSC70zkfNYkXL5tc8nOgAPr7Oy8dpGsVGhWb8FYO
 tHR/NdR5RH2pDen/Zn3fuIEIv6dBFq2Wa/T47PlP7jmVnAleKCVWW0ETcZZAuNEeQhMf8k3KMkb
 e1S5FCCdhGuBd8Oc1kCsImctBYfKLgjdaJD+GH2EMver8cG21HhlK+jtgPq7HYDiuNrhlTDX5Ws
 XJOa7da3VoxFp2xgUzqjYVnKAce7LZMT+xXlOq2t4itIEJmokbUVJaXF2ZzZDWzxRraAsxzB5Zj
 YbEm1suS5eohRrw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22606-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8D7268F26E

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

In nfsd_get_dir_deleg(), gddr_notification[0] will ultimately represent
the notifications that will be provided to the client. For now, that
field is always set to 0. That will change once the upper layers are
ready to start ignoring certain events.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e18f6efbeb95..6921504acc29 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6133,7 +6133,22 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
+static unsigned int
+nfsd_notify_to_ignore(u32 notify)
+{
+	unsigned int mask = 0;
+
+	if (notify & BIT(NOTIFY4_REMOVE_ENTRY))
+		mask |= FL_IGN_DIR_DELETE;
+	if (notify & BIT(NOTIFY4_ADD_ENTRY))
+		mask |= FL_IGN_DIR_CREATE;
+	if (notify & BIT(NOTIFY4_RENAME_ENTRY))
+		mask |= FL_IGN_DIR_RENAME;
+
+	return mask;
+}
+
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32 notify)
 {
 	struct file_lease *fl;
 
@@ -6141,7 +6156,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6358,7 +6373,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (stp->st_stid.sc_export)
 		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9793,7 +9808,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	/*
+	 * NB: gddr_notification[0] represents the notifications that
+	 * will be granted to the client
+	 */
+	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
 

-- 
2.54.0


