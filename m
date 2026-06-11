Return-Path: <linux-nfs+bounces-22515-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F8tjAJAVK2qC2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22515-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:07:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A128674F4A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AfZHgF1b;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22515-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22515-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A17B31C81CC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E63AB28C;
	Thu, 11 Jun 2026 20:01:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3A3A9D94;
	Thu, 11 Jun 2026 20:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208089; cv=none; b=qVE2KbR41LXehLllB/aygpIhlzdeFu84J97S1OvxH2dvYxMpIj1Kg66dSiEX9WzLFlfUGD2ol598df2B6YkYQSwlcd1kH33fIZZvyI5MwVxIc6N0O3KH8tHWlc5wMbdKgufY/ey0vVlaKuI9qJzhOctAxwJelZaH4fIRmJMKQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208089; c=relaxed/simple;
	bh=MKfgDq13ke8Wu2qHntxm/D7MHBjxMwEbDJ6JyeIvFik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWKeBc2Bjd2JiLo85wlV/HwkPB7giSkwTwiYQUPinpFhgwdiSLsSylbh0+hd2s23bmyYiMzeKCZMR/VBzhFKoDTnFxtwUsGjPDhseeeMqJBlgzgbc31GELJB/vSdZgsST7vpdZiPr4pnbJn0O+zdI1jPudhGywAtV2zsIVvuCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfZHgF1b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108231F000E9;
	Thu, 11 Jun 2026 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208087;
	bh=hz5ss9K8T9aK1nbeqNXGQtgZu3c6/r7hz/vXN5W/mOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AfZHgF1bHdYaPkCt6BXG+bq+sFQD5shdIucO3wA4N43cmpb1+Se2mdzN8EGZBBjIO
	 cGoJIXfeGRAmWLCrdAiRclZryTyuVzmshsHNkBqCFNiKbW/OMNHD/zaiztYRsIKI6/
	 T7OlXGdpoQgmFGc1tCAf6YN1hRyhps/m5qCnjBinWQj4sVweqEy6x5K5XpJPyVbet/
	 VOgFBDQnPle66afrtclSckGooqyTJ+dGXK0g+QSQWHAoiQ6tjKr/uqCvTwmCMX7h56
	 NyWHEuvsyurW7VnAlLLDuOzTI8c05c+bKu4ndvHXux5WA5QS8FatD5S+4WSe+mDEm+
	 1KSmigYXBsVzA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:01:04 -0400
Subject: [PATCH v2 21/21] nfsd: drop the stateid, not the stateowner, on
 seqid_op replay retry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-21-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MKfgDq13ke8Wu2qHntxm/D7MHBjxMwEbDJ6JyeIvFik=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxQBZySnf/qbvn2NYWNlT7PgmNONv9KyBGlkC
 /npapdmuHSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisUAQAKCRAADmhBGVaC
 Fd/CD/9hNEANf93lZwH1EES46mVdUA3BGEM0xmeiZsWmbMMX5rrPB0GaeMi5mVjY/2Yd3zoqqS0
 rnvae/GaTUaW01avrg2lb4x2FuNUBzSFB3aO8EHzY/Y6oGeEOoutKIM+CFdeRKVu+KsIcbhqwPV
 tSEWd/LwQ1XFGM5AHGmd78xQJ3wO8zLLeKXw1+Y18qHsboFuIvv/EX/bSMd++ahS2UAbeYjsziN
 7ixHYpTs4qAgT6eSN5A9ZYXsii0NQusNFwDt4zEF/JNDP2PreET8c5rfYt5iamxNNjUMe0MIc70
 GWRgUKmx3VUgq8moJdn2qDnoGaljPWU8el4iOjeeFEBWpgwfjfNWgMdZ60D+lbXrgoXnLWmYtg7
 MEFNQt1B3hcti0nNxzlHNmhdeTXJAv/R3jhQCQriCmVPvzvKQjEAaXkJaHOjczZPW1iEVsHbFm7
 bJxZkDfkobTJLThHOHULB0JsfF8TJANbcIIzTOCB+0+wFotLgdpBlp00bcH9slfoC+xKydVIUMt
 adSFJeAErNXN2P2n+1gGrpFRCvCmdhhZt/wBdgfHUt8FtH+4kGRAkOj9VgbvsHzQXUhLszppor1
 8PMof34tQ4Z2MQthzXBBrpx9lAFvULB1S/UINMCkB8asa+yGZwkrFT5m+cM30DvAhiQcpTrBeyY
 7yTUvJbg84JWeeA==
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
	TAGGED_FROM(0.00)[bounces-22515-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A128674F4A

In nfs4_preprocess_seqid_op() the stateid is obtained from
nfsd4_lookup_stateid(), which holds a reference on the nfs4_stid
(sc_count) but takes no reference on the stateowner. openlockstateid()
merely casts that stid and likewise takes no reference.

When nfsd4_cstate_assign_replay() returns -EAGAIN (the replay owner is
being torn down, RP_UNHASHED) it has not taken a stateowner reference on
that path. The error handling nevertheless called
nfs4_put_stateowner(stp->st_stateowner), dropping an so_count reference
the function never acquired -- risking a stateowner refcount underflow and
use-after-free -- while leaking the sc_count reference held on the stid.
The leaked stid reference can also stall a concurrent
nfsd4_close_open_stateid() waiting for sc_count to drop.

Drop the reference actually held -- the stid -- before retrying. The
stateowner stays alive through the reference held by the stid. This mirrors
the open path in nfsd4_process_open2(), where the put balances a reference
that path explicitly holds on the stateowner.

Fixes: eec762080008 ("nfsd: replace rp_mutex to avoid deadlock in move_to_close_lru()")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a0c97bff3cff..bef0ec9be459 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7876,7 +7876,7 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 		return status;
 	stp = openlockstateid(s);
 	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) == -EAGAIN) {
-		nfs4_put_stateowner(stp->st_stateowner);
+		nfs4_put_stid(&stp->st_stid);
 		goto retry;
 	}
 

-- 
2.54.0


