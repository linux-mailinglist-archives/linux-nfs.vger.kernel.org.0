Return-Path: <linux-nfs+bounces-21220-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI5nMC9e8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21220-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:13:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283847E8EA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F1B33065A46
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E23B6BEB;
	Tue, 28 Apr 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzj0d7nu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D913B3BE0;
	Tue, 28 Apr 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360256; cv=none; b=fo8jZIFU1253yoJ8yjdAK6NJB38Jmz9XaPtGewtBKcV1Lxi+UUYfGonpf2YfgPJfYCpSzwQ6iYArYx4bGoMk9sxsHQynDt62n+fZYWycAR7cqeBXrjFIR8HIKOEmuAQhL/BKcGCM8SY5ea00Wi2TKBzXfkxipKgJhWOKm3bPbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360256; c=relaxed/simple;
	bh=OETy0KCLvLAu30Na6yWhAPISmDNi71qDpn2jPtWZjZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4cXi98bADdsI9ID8fzVhtk89RuRSVyOrDZT/ZgiIpLjoCrr6oCYrVDvqWrOrTP/ynxzezom64Zt1QYK+dGOzQB/g8Nu/xmK9oEn+j8LcDfchuvWT6DW/+ghGQ1PJGbR2r6146/idwfYtj5rFbrcUx0RxyCNSFm98idTqI6/Ea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzj0d7nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C75C2BCAF;
	Tue, 28 Apr 2026 07:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360255;
	bh=OETy0KCLvLAu30Na6yWhAPISmDNi71qDpn2jPtWZjZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pzj0d7nufi0BP19V9kspVoFmAiGvCJ5Nw/jec3D60EJD1tuvpe+iCIRwINUemGRVW
	 4ggxJt66qKVhKWJvE7UYnf3Ad+MxusAdzzTWt19Rj4Tn63b7RPxKG3suollW61+TjA
	 PTbSHsa18JlI3hRKypYRnPze5t0/TwGh6EaFxWB2RiOUJy1otXUkar9QL/L7+7EFrH
	 xJQ/X20EOX2fPak/QMsum2XIMXF2rOBTsHCZs5KU4sLoyfFbojXibPSf9FOpSvXgbu
	 rGcGqBxHUWT+5naZTzHY49PxiQ4VcOs05y0MjTZRxamQsllVHwzo/X+5bU+YSJRSzg
	 IW+7itUrs+E5g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:52 +0100
Subject: [PATCH v3 08/28] nfsd: check fl_lmops in nfsd_breaker_owns_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-8-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OETy0KCLvLAu30Na6yWhAPISmDNi71qDpn2jPtWZjZk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1PjOnJmRTAu2KWJy7BzeiClqETNyhPye9PR
 qsCgOW9ou2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTwAKCRAADmhBGVaC
 FWI/EADQ42mwD42X4VmnV7An6Q3o7svM7liTb9iKHTXw8+xwfIvWSATZgg0aPKGKafc36d6IPKI
 OPuNr1TQ8Uu7PAP2+UuAf1TvpApq5StomjoGmfsjQ5u83AAnlVoEO2GqVeIvf8HouWYi5PkwbPL
 REdNY46vUaXbEirDqdDi+AeUVDwZiLnKGhjffGiJsjZemmQSd6hP29dhVx6mmtmXqMHyjPbTNQM
 vzNP0so1DCZ3zmg1UY3SDTjWA9KdMV1Gx+TNfuabM+U4fAnnn+HfdSCmQGeHvrH9zTzvKzjsbI5
 rrIWrQxmuxP//L8ngO1/1N16fk7DFar3CM8oce/fuZ+v8UnODHResECgZVYjE1VAJB1KmraLADw
 od3sKfa2LsWz6NgjKhfT+i0DMZW2dyv6OBs2lMVThyYCzf7/EUdH9/a20v0TO4B3aP2XnQjEczc
 bHVXJAzNS9PXB3CZfji56R9pGM1QtZGmoQyUNu4gv3I2unESP1wBuE7bftTX5k+A42eYDDknA7U
 d/ngq8P6Vsht60DBfcmVrqGBBfQvK4LWgPfaZXxM3CHvioYtocS38j2Yq4ghD4YmhSMCBWpv8H+
 nA2Luhyil89nJ/2CwmJ0tlZ8CaS/tP5aK4R+x7TJUAUW7UB9IeGXkjM+0L2TgcMA6AUMqADUZPu
 7g79C3P5py9txww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 3283847E8EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21220-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Any lease created by nfsd will have its fl_lmops set to
nfsd_lease_mng_ops. Do a quick check for that first when testing whether
the lease breaker owns the lease.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c75d3940188c..35f5c098717e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -91,6 +91,8 @@ static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_stat
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
 
+static const struct lease_manager_operations nfsd_lease_mng_ops;
+
 /* Locking: */
 
 enum nfsd4_st_mutex_lock_subclass {
@@ -5655,6 +5657,10 @@ static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	/* Only nfsd leases */
+	if (fl->fl_lmops != &nfsd_lease_mng_ops)
+		return false;
+
 	rqst = nfsd_current_rqst();
 	if (!nfsd_v4client(rqst))
 		return false;

-- 
2.54.0


