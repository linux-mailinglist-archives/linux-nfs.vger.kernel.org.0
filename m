Return-Path: <linux-nfs+bounces-21871-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EB3Mb7TEWrvqwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21871-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:20:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733A5BFC6D
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D34F3035807
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625C3242D9;
	Sat, 23 May 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt3lXbsH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A952311968;
	Sat, 23 May 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553065; cv=none; b=eQBIgNaZvroxfwZzpSVejyJi+9kyvAnPmWoD6vyaD18LxjCyFKSE7gmtDnikkK0EWhDitU6JsXC3TrZThTrd+eBs8AfcS/LK7cjXv+XRzqSCeTXH1FKCMs8D+e+NupzB+chb08WBSkjv2D4lb/PHYSiEBRWUQhIl7TJcC1jUzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553065; c=relaxed/simple;
	bh=X4x/AvCaoMxutTY6MD1BKDmSKvURH2w1AeSQB5QH6EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfRS1w8Kx8xlTDaWU3FBuxUlBapDedQzqnV0CmbXaKYHuyisI/Sov/RuzBUFjYLPN/ZS2S2M3ybONe7ptDDjOhuJ8lm0B1hClVX59me/7tMeoUggXeI46aWcQr7NxSYQmTMtEQ6LJiGUdFuPqyiI3IGS9fQYXEx49ChTcinrB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt3lXbsH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEDA1F00A3C;
	Sat, 23 May 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553064;
	bh=sxess6041C7VID601A6ElDmI3D6gxpgyrdXxL4Gizk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zt3lXbsHkR4fuPNM04dgjQvcqoTpH9A/aDEfwux8d5DwMhUNHbo27aHSXDY7L9Ore
	 xvjfoeuVf5qB7WrNioZlCMAl23pKji0q9wA+mPT57UeMcvaX6HeZvwDgaU5zcQ3pzX
	 nb32BisoK3JQmhADY8+12FCRHbEEEbdrl9NU1kQdILJa38BfL+LufQTzZAd4TG2yBB
	 HuLpBH71Bvhes6jxfvSJquPQXnBY9MvQl2zcC5rJ/dgZbe7ufTlKuOay7QqR7Vfm1E
	 S9OHuRzvvkcS5j3yK66MhErdZ/d0Uru5jPUcVv/4Wr46YkjXUFp3q0v0tljz0N0Bw7
	 nRwg+ZWb/MwlA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 23 May 2026 12:17:37 -0400
Subject: [PATCH 4/4] nfsd: fix ino_t format specifier in
 nfsd_handle_dir_event tracepoint
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dir-deleg-fixes-v1-4-142c884f85ce@kernel.org>
References: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
In-Reply-To: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X4x/AvCaoMxutTY6MD1BKDmSKvURH2w1AeSQB5QH6EQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEdMj/vsy5EVxJNkdE5X6F/kRFBvpw7Ng8DKq7
 RaLE4BClwiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahHTIwAKCRAADmhBGVaC
 FZoeD/9Fsm6r6QJAyZOe6TZnbmKYlVWNRi8SKiIkMtb+iYDGsT3FRdJIspnp0IRQVSJFlrepv7i
 BcFlzrDB0qT5ikyiBaL7YL/amToPDPS7f8OadLfjkZis7Pce0wOq2yI41EsvmvdFj2w5miCUszg
 io7xXHaZpsCj3+1YA45o2hlvVqgg/47YyQWSDtdcfaVPRo51wHNKNN+6xZ39HVmFWiL7aSD4oVu
 3hEJo88dXZX7g+H/empZfm2+WqFZ/Dil2cBDKAK7qyysjMSnhzziPgOnlwAjmf2loBYvDLIllkI
 aj64ZRa+8HTxGx1NzFGylors0+pND162mYUdjOlMGk9+sC6kA79GN6MzPDs7gbRCceUHzhl/LAw
 rLtWe7cXGRkRg6gHUuYIZlf6pqy2pm1YgWmz8yxCdPv4A8XGa7W3qX/xQ6P6DfxE+OfUgHkJiRx
 9ZzzcCpT1rkLFKw95bqSjJo4Fgyqpo1siyDD+3QDWz29/WYlBN374OyEYjNLEAjVWuYtLf9ql4P
 JLPjhaQX4P9MCxCXJOedRAo+Lfcl/kCEDhE4652aqjZZkZ8JDRqThKHU2P/8BvjV+cQzxJJZ4dF
 qSJjbwGl3YY00C1pGy+BYby+5xQK5KG0MP2NrbQxNYfGp3QalcYa5HUNeCRgvY7oD+t4LhFGuBX
 qcEwwfYJ7zo4kVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21871-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4733A5BFC6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

inode->i_ino is now a u64. Use the same size for the tracepoint.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3d0f0bd30d90..1d5d11f914f2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1384,7 +1384,7 @@ TRACE_EVENT(nfsd_handle_dir_event,
 	TP_STRUCT__entry(
 		__field(u32, mask)
 		__field(dev_t, s_dev)
-		__field(ino_t, i_ino)
+		__field(ino_t, u64)
 		__string_len(name, name ? name->name : NULL,
 				   name ? name->len : 0)
 	),
@@ -1394,7 +1394,7 @@ TRACE_EVENT(nfsd_handle_dir_event,
 		__entry->i_ino = dir ? dir->i_ino : 0;
 		__assign_str(name);
 	),
-	TP_printk("inode=0x%x:0x%x:0x%lx mask=%s name=%s",
+	TP_printk("inode=0x%x:0x%x:0x%llx mask=%s name=%s",
 			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 			__entry->i_ino, show_fsnotify_mask(__entry->mask),
 			__get_str(name))

-- 
2.54.0


