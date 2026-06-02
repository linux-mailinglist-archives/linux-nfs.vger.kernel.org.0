Return-Path: <linux-nfs+bounces-22208-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rTxVCBUGH2ordgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22208-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209816303BA
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VXST6N4P;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22208-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22208-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FF24302226F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8B3630A5;
	Tue,  2 Jun 2026 16:23:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260E363C64;
	Tue,  2 Jun 2026 16:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417414; cv=none; b=Sr1/dsYHX0FYo12okT+ZGiSmg683ol1uxfHhzlg7ygjdQAfPW0y2a8Ufjr5ACP3w0vd45g/GpasxQPecxhsVFcH35i6IS+VhNxq2Cz8IiZOcUYyKNjaohL8lSshX40uViRcCOq0N+3NfmDYLL8gbzgxVxgVfJv3gPvaP8sm5kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417414; c=relaxed/simple;
	bh=Z4Sa04OPguVVMhb/R/j+wi8hB7rLuPo3U1Pzf+0g9+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBgg2G/L9SUWSOaEUl1lEyKkNyWi7D9U6u8onPW8X/1KqfX/8jXDA4gcLpu42iHjwoMWSuEUqxvFQX8rxjtRF2TUpdsgU/oa+/4HOjzH+6+ZlwCkKZWmSaEAQPswWTHvwKB6VNvKBIWbxqcwsnaC/zWgAufUKeAbcohK+LKaHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXST6N4P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FD1F00893;
	Tue,  2 Jun 2026 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417410;
	bh=guAkVFVqRYjiojYXLWG1CxAWJyMoK1eDqsYRwZSIzfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VXST6N4Pd14NHrtuMnsroOuRUU4QgE4hIWwEYYJz+wgQ7yzzFPsVrzWTNXdb1rSNO
	 Ix2xj/En1YcwEt6QFF1ZPj/H7KbW+FBw2SqvkBGLfIyOGAyl0MD3c8zumKghsFXUH3
	 rZG18zpdM/IIm/VxtbRtHu9gDtcrnVbdyyD4ZPXLXV3uyMj/odN4RoSi8KLG0/ZTpp
	 Y6VVW9nmNrWP5s6bRkC0p/seNzOGui7F3yIDjoB08ApXuApmiQDYqm5DreIyhsAOaO
	 cIbh2OFp4DE4Y9x8yGuc485cKP1jZYxZeDbnAR628A6ToH5pUaCcH6C8Bz68EvIl2U
	 lv8TGW8lbfSNg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:14 -0400
Subject: [PATCH v2 2/9] nfsd: hold rcu across localio cmpxchg retry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-2-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jhosRCdsgV6tnLgxdUeYl40e/QY6nryL/Up0X7W5E1U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN8jYObmlJIuR+vccAF0vTzzCfqI6Aran/9s
 cTqqn1o2TWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfAAKCRAADmhBGVaC
 FTPIEACrXrlwt4vPofjbpQG+LsZmOOIiwKyNX32C8ilD9dR4Fl1oIw6xOwO0WwcPc6jarE2jgOw
 NKHp935GCUNTJuXHXw84fzCEwXJK2UVPQH+SXUmlSXwwWQB02qXCFy669XSvfqQ1uuOKCw4z0Nn
 aAfYpGJC6a1VlLOwQUxhZevTIal9df0hJdxDFQ1RsqdOxSIIDs/z/w03ugv17BesCfE0F7/Xi0D
 xt7UVbj0Pt1u5UJJDSZQ1QZHWiR0MERJAq7n1VSlvkE348ikp99Cp+hQCb0J0ofB4txN/PuQfTc
 QWkb4fiUeIsmgnJrPJsHF4bT5IzEQwu2qF0Zff9v1o2ptLh4JPVnvp2uaQ0rtYr41+NdrnhcAAI
 6GMYi6q7lOR7WSRrFccEBRSpKByntA7MXp3usOcJ1RTKdDwYPrMup03vSnj4e7cfkWk/jaFYWxR
 eY4fl3mvFuvdLu6iGluoTr549BeuBk3yCF98CNqe3Y08YsMMdx2ceJHJZpzERc6AIhm72tE10rC
 RGAseKaUvk+vVmWRY/LgmlBxEBjDOaiioc7rJYEGOvUy6kXSPdGv4Jw+MDqQ0pFJMiWiq5HeXND
 PIYh/hI017+8G1F3eRmnu1K7L3uwtbFTU267L5Cs/bEIwYD55IiDRuJxSe5TxjT5yXutyEruVWS
 3zFIgscVIC41l7A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22208-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209816303BA

From: Chris Mason <clm@meta.com>

nfsd_file objects are freed via call_rcu (filecache.c:296), and
nfsd_file_slab is created without SLAB_TYPESAFE_BY_RCU
(KMEM_CACHE(nfsd_file, 0) at filecache.c:789), so the slab page
backing a freed nfsd_file becomes freely reclaimable once the RCU
grace period elapses.

The again: retry block in nfsd_open_local_fh() loads a pointer with
cmpxchg and then calls nfsd_file_get(new) (which is
refcount_inc_not_zero) without holding rcu_read_lock. The sole caller
nfs_open_local_fh() drops rcu_read_lock before invoking this helper,
so no outer reader-side critical section covers the load.

    CPU 0 (nfsd_open_local_fh)        CPU 1 (nfsd_file_put_local)
    -----                             -----
    new = cmpxchg(pnf, NULL, ...)
                                      nf = xchg(pnf, NULL)
                                      nfsd_file_put(nf)
                                        last ref -> call_rcu()
                                      /* grace period elapses;
                                         slab page recycled */
    nfsd_file_get(new)
      refcount_inc_not_zero(&new->nf_ref)
      /* operates on recycled memory */

A non-zero word at the nf_ref offset of the recycled object makes the
refcount bump appear to succeed, and the caller then dereferences
new->nf_net and new->nf_file out of freed memory.

Fix by taking rcu_read_lock() immediately before the cmpxchg and
releasing it on all three exits of the if (new) block: the goto-again
retry, the lost-race cleanup path, and the install-succeeded path.
nfsd_file_put() and nfsd_net_put() stay outside the RCU section so
they remain free to block.

Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/localio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index be710d809a3b..c3eb0557b3e1 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -97,11 +97,15 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		}
 		nfsd_file_get(localio);
 	again:
+		rcu_read_lock();
 		new = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(localio)));
 		if (new) {
 			/* Some other thread installed an nfsd_file */
-			if (nfsd_file_get(new) == NULL)
+			if (nfsd_file_get(new) == NULL) {
+				rcu_read_unlock();
 				goto again;
+			}
+			rcu_read_unlock();
 			/*
 			 * Drop the ref we were going to install (both file and
 			 * net) and the one we were going to return (only file).
@@ -110,6 +114,8 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 			nfsd_net_put(net);
 			nfsd_file_put(localio);
 			localio = new;
+		} else {
+			rcu_read_unlock();
 		}
 	} else
 		nfsd_net_put(net);

-- 
2.54.0


