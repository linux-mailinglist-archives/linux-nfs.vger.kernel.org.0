Return-Path: <linux-nfs+bounces-22477-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ShcfIeb3KmrN0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22477-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE8674406
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PupIT0XG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22477-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22477-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDE7347D49D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9494A2E0A;
	Thu, 11 Jun 2026 17:50:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7F480352;
	Thu, 11 Jun 2026 17:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200241; cv=none; b=uBtRsX0JAY7i5E50cuC9rKLSoOO3u7w90hFGox6TRNRhuxMypYOi2IT/NFWq2+X/J1ZF9YFM9ZBYOa7aVKZHv1wLvqSPqBAiYA+Yj9+xxTVUJVjJlEGvpzjARzFF/wdgqZfqpcSZQhn0fCoY09x0zLAVGV5JXHwwdGBo4oU0eEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200241; c=relaxed/simple;
	bh=9D/1Ecxaoz+pUGRSVNpZO5nIi/SNoL2Xg6pvQtEKUW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDYjsj5tz7QesuB6ZlFwTUUu8BUWhoPrxhsseW7zMobkm23nUPPJcbKooxlhjQMarS5j4BYRPPyGZCSjxTLuSK/E3yWr8Ha/85o1u3y//XDwAENykP16RhgM4vnNkd1gj7SE/SzotcPE/tq510arjzuvf1DyVpGxYo418Wz+zH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PupIT0XG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288E1F00898;
	Thu, 11 Jun 2026 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200239;
	bh=0RsP7KqA+6ek5yn/DNGISIDQXloZMbV5Hp6UvSNf/iA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PupIT0XG0CTHvcnJa34gD6PjYzNoP8c/VlyXvM5hSKP9sBjyibO7lMhcFFGHKDLLQ
	 uud9aNFhfCOYcLIH2Acb3ut3uDwtKRNjKLFl1fOGhz2Nsxqdeq09zXzmB99JOvo8P6
	 UdsLnZ7LrN630Ymy5mnZ9vFBENi8EJRemdAefvm/RwjyXqipnpL4/Cg3AH9PWM3Rna
	 W0WJzU5/68pKW1O605jiWtb+0nw6CyQrilrulhKPjSCd+sunJXtp+ynP7lWBuof4Sw
	 G9UMbhkVWHIwsJv/LRDzL7iVdPrvFTAUjmEJJuZwYzZDKYLrkaE57wKcHFSyNVjTet
	 bU/33GC4bvQBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:10 -0400
Subject: [PATCH v6 04/20] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-4-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
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
 h=from:subject:message-id; bh=9D/1Ecxaoz+pUGRSVNpZO5nIi/SNoL2Xg6pvQtEKUW0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVe5wNrPKB/0xM/0UFgrppj/FHQi7M+2ic7P
 OuNHE8VssKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1XgAKCRAADmhBGVaC
 FTLSD/0SmPbqo3Lx3070lqd1kO0fIiUY7v6ALGoI8EJK6HjvOnZjvq/TVJdG2EtE64TNlrLLfdR
 RJoho89AlNlIyvoO8Kl0/PiINpPrrIAa5nKQ2H5/YKF1bcagNb/FDknJo1LwT0nAw8zFszgeR5H
 mARoWTX5Lh5wIvJh2PBig1hqVAduxO3RnddOLy4MeZGPPhhWn0qMFt4GtA4pvkFwEhZDrWOMuxh
 RUyZrBxmsErD2q0GJgb7sjpsL164s/qprChqT/Dp7ESCGl8SW+KzQbMcIIiPWXhE2Fts6ClopVz
 V8hCgNKoZ9eC+bmoVd8iFMg9VGqcfCEf8nf0V5Thld0CvNkwa0EYrMTYkcJmB3wYxWROlKReetZ
 XTF+H/0z36042LntueINNGI74yCOzoKKST2X0fyDbW55ZI5wsM0RB+MTp7GuIedoxWHrnfpdr0B
 EUT0JIvfDgrnUdt0Mg/84wd7CxLOvWfTkV2+6YKpJ46Dcs5AzG+sO/06yWTdMN4nafOPWWIPa9e
 b45f8HnfIukxq6Yd6x5RwOz9FjCWGo+UEqdqKB5T+qH0zUKWiRM4RmR4Xgd4mMroeGV6YFYPxD8
 RMypH33WtsVF8dlUuw66WR+nORJ7HrFYrZmwAcFzKVfB0nhjObr6UN/78szWjr+bS5VwuHKRgkL
 WKwUMf2MsyOpeuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22477-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1FE8674406

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
index 489558bf124c..ae8505747dc2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6119,7 +6119,22 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
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
 
@@ -6127,7 +6142,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6344,7 +6359,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (stp->st_stid.sc_export)
 		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9771,7 +9786,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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


