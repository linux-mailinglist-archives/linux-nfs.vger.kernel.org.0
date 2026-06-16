Return-Path: <linux-nfs+bounces-22613-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1FrMhc8MWp1egUAu9opvQ
	(envelope-from <linux-nfs+bounces-22613-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:05:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EED68F14B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cEHWfTIe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22613-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22613-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50366302D4D6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD24534A5;
	Tue, 16 Jun 2026 11:59:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19344D686;
	Tue, 16 Jun 2026 11:59:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611169; cv=none; b=Wsy2c021KTOe4RrPcviHn9b9W/rLE9miscZW7ppnHXPO4e9RjtScAJaO8CfbMSjU8IVye0ArdKBeUOm1A/O8QqQdjJJ9Zk/sni9CRioeBt0o58jGzuqcAjAVZQwSHndGaiRZeALal6uOVeu4OtJkwe/GG5gRcNSVrmmUHssvZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611169; c=relaxed/simple;
	bh=dzhbe6mUJxXgN4SX7Eyg5Xl7uMQlnFJZNU93EiQBCFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbFWuGuaaDKiEZ6SqjFPCiZV/WWgUoV+K2d7D2u4VxX1XthG/Xu16eE4sZbZrXgFDtQK+WPoI8pYr1LgxBxVO8qJJygPfGNGTiug9DWOB7pLl6HKiQ7BZCfCTAvp54f0veMytQRqnjieizTEkDOv0cgTff0bOgbg9i4tabD0gOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEHWfTIe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA1C1F00A3A;
	Tue, 16 Jun 2026 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611167;
	bh=Db3tXM0PvChLue9Ulw423Nw6xQGvOX9BOAxo1UifGuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cEHWfTIe9Mz/lLrtRTqUSXSU+40rJ6Favw5yQNJDYWbfNGqGgrrEXiZFx/HX/NOTa
	 QL1OY4CiUNg6bP7uMEg48My7Y1K2xVsdatKmRiANDSpCF8tGozAcM1IAkStmsgnPBQ
	 xx3mCkwE+bG+lhRvVfObG5iY3upDC0iWrK6uXvgAmUIOQEImjvQM5Mlm1UPUzGyuGX
	 iGkQ704dBUwZxeV8RpBaWmBe1L6obOCGcSfHKD2RV6gkixCeYKPSiCDJaWn6pcWuUF
	 o9Etg3Hy/qCbqoSS8DwqPnY6UHeKjxS6Ku21Ns8aD1fqzLe3ycy4DKsP9bR8gFUDsr
	 eEkCdIi8EjY9w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:54 -0400
Subject: [PATCH v7 11/20] nfsd: apply the notify mask to the delegation
 when requested
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-11-6cbc7eac0ade@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3568; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dzhbe6mUJxXgN4SX7Eyg5Xl7uMQlnFJZNU93EiQBCFg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqG194yz6rmsaZxbJXv6IJd+5nthWMR8AHEg
 U4Spu20+CWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hgAKCRAADmhBGVaC
 FWvLD/9ZCUL9CXuTGPT6DS+07fQ5AQI5eS+eyBk1lJL3gvSNTorbc4JzzYqWGtOqBnFyUwGh4ys
 kTsRwFtFbMUBPwIAyfX0CFbzR4GZeRtp2ede3T57M+5kfAqOGUdbaJQWP156x8Fm8h3zM5b98zq
 zOEsEcmyz/wpCi8VuHjq0CkH2htERqnGajrxDaGxxFAYaovCD7QOuNm0QqsmME/Trdby0uoSDue
 4DAfbsZiWu6GLpvROH7Rx/QoKyj9s6KQXoVKQ6O2zpzBC8aoy2522LY6y12RUDuMC8lDo5GBTCG
 ETtmabmN0fmsgWHsRLf1knmriskPPMQ4d43SSxqq8vRHW28OSjWGTV+dCDUHQnGYj6SC8YvUy2u
 XI42rCty+jf84HWAAJUZwEsG/K9LOLUwleFFHt1LGP4ALu4Ic8E3Zzu7mcRxWcrBvGQrhPHi7YQ
 iTMqgAh45nZeNaQmW1uMwCSbe03BK5C+K1DZvcuzsKNilqQ5eaOU/+0P0/rH/JWgF8G8bvOUd3B
 m7bAU/3E6YBS6tpQC/HaoS+aCzBs4Bck3UwlNZqDUygL94qXVljD8NP9nYdOXr/ilzy8gvk7CaZ
 QV7SqQnFoPAfTLOnjBmowyHa6KVHys0xm6XQa7DlNUMXZ1cUiIN9v3zzet8aegGfGQ2gM/d8r3Z
 YO8MYF0rX233WwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22613-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98EED68F14B

If the client requests a directory delegation with notifications
enabled, set the appropriate return mask in gddr_notification[0]. This
will ensure the lease acquisition sets the appropriate ignore mask.

Also store the granted mask in the delegation's dl_notify_mask field, so
that the CB_NOTIFY encoder can later tell which notifications the client
was granted.

If the client doesn't set NOTIFY4_GFLAG_EXTEND, then don't offer any
notifications, as nfsd won't provide directory offset information, and
"classic" notifications require them.

Similarly, if the client sets GFLAG_EXTEND | CFLAG_ORDER, then zero out
the notification mask. The Linux server can't provide the necessary
ordering info to those clients.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 21 +++++++++++++++++++++
 fs/nfsd/nfs4state.c |  3 ++-
 fs/nfsd/state.h     |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3e4de45aa360..565bf76c08ed 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2552,12 +2552,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
+				 BIT(NOTIFY4_ADD_ENTRY) |	\
+				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+				 BIT(NOTIFY4_GFLAG_EXTEND))
+
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 			 struct nfsd4_compound_state *cstate,
 			 union nfsd4_op_u *u)
 {
 	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	u32 requested = gdd->gdda_notification_types[0];
 	struct nfs4_delegation *dd;
 	struct nfsd_file *nf;
 	__be32 status;
@@ -2566,6 +2572,21 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	if (status != nfs_ok)
 		return status;
 
+	/*
+	 * Offer no notifications to an order-aware client. RFC8881bis section
+	 * 16.2.13 defines order-aware as NOTIFY4_CFLAG_ORDER being set or
+	 * NOTIFY4_GFLAG_EXTEND being reset. Such a client expects cookie and
+	 * previous-entry information with its notifications (e.g. 27.4.5), and
+	 * nfsd does not track or emit directory offset information. Per
+	 * 16.2.11.3 the alternative would be to recall the delegation, so it's
+	 * simpler to just decline the notifications here.
+	 */
+	if (!(requested & BIT(NOTIFY4_GFLAG_EXTEND)) ||
+	    (requested & BIT(NOTIFY4_CFLAG_ORDER)))
+		requested = 0;
+
+	gdd->gddr_notification[0] = requested & SUPPORTED_NOTIFY_MASK;
+
 	/*
 	 * RFC 8881, section 18.39.3 says:
 	 *
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5a4f0843c2fe..682c00fbd2fb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -10031,7 +10031,8 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	 * NB: gddr_notification[0] represents the notifications that
 	 * will be granted to the client
 	 */
-	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
+	dp->dl_notify_mask = gdd->gddr_notification[0];
+	fl = nfs4_alloc_init_lease(dp, dp->dl_notify_mask);
 	if (!fl)
 		goto out_put_stid;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f8457e0f2b57..7a66048a130c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -297,6 +297,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_atime;
 	struct timespec64	dl_mtime;
 	struct timespec64	dl_ctime;
+
+	/* For dir delegations */
+	u32			dl_notify_mask;
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


