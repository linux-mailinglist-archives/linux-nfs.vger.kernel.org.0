Return-Path: <linux-nfs+bounces-20526-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFPSHEiAymnX9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20526-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DF35C5E9
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82A4D304FE15
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904C43D47D2;
	Mon, 30 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBd6ySBr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADF3D47BC
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877935; cv=none; b=fbGGSUfwHrGBwtV/RAGvzwtxUZxnYVN7XeAwf0Uq2F8GTQ+L5+zb0TbgNjzLSfobnm/afoujwTkSb8xj6mPo8jJzC32Wgo7Ia8NgxBxZZeq4JiUlZ7jpkJEUSTibY0Bnik/C7XV3BiTOOhMqB7ZaFfSWfIsHgTWzS+jlXSytQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877935; c=relaxed/simple;
	bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W387P2ysAP/ztMpOps/4a12ZulOyXExTDR4P5UFn89FuIlHkw2C12UiRggaKpSQlSAfVSwM6KJEGEKeM0BIGGLj+X4nSYkbKlniilvYIvuvF6+Fkv9xx/VDCcZWzHShExxSPxU0BudFop8J8y7/s8n9K7lV/0OqJ5n0QhgZMp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBd6ySBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5EDC2BCB1;
	Mon, 30 Mar 2026 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877935;
	bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YBd6ySBrbWWvdMs3RTcLYW/61gCwF/o80dWpmZt0IJOLpK/PeNcYyfDeuzPdcAy8D
	 xkY9cseifl/yT0RCHDMxrFit+fNL+D6rs/SUpeuYRSvQe3f8zV+SppER2n4yb65cFW
	 7cOofoBXdo4Zs+BQCp+vTvEUsE1bqHFIrdvtNMCjBe+tD52xoV+MJCoJT8wKZ6Nooi
	 pHv691JQMOYaG39c5IxDpBrFW6gUH+85Q4S8148RVoYS1YH8kJ8oJ6WevnlQLfwRa6
	 QnYu8GUEpiHEdSfY2F9OcbP+yp3Uc+WI+kRU7liJpWLvWORIOx7BSeofdapBoZU2NJ
	 gh30jnc1m7dGQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:31 -0400
Subject: [PATCH nfs-utils v2 11/16] mountd/exportd: only use /proc
 interfaces if netlink setup fails
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-11-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzgVYm0CNaLywNBgFUeXZAhPAV6xHeCZjSoO
 7TGEAtx1feJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp84AAKCRAADmhBGVaC
 Ffc2EACA+BqoMhkriuCKRC1nBe1ayphrWY+patwFejBUv7jpodsN6IP7XJVdvVEK4T2rTVq4qV2
 27AXNvVz2sSRTyA13wpBrmh5DV9UKn+IRmk2oIgAqVRm1AW13gNMZEO7kmZmBezoPix+sGYbnIo
 bGUeVt+4fmC24V9KUgoKutdelNAVAxMek/ystXTcchGaBRHZK8IdBlEniad0E5Wm1l5WYQERiTc
 is5lKtVbtPA3emVvPpbUAPJ992NUGPr1+tAnoDRgisFtmzDXLiT7foaspP6O0g8LDShJJbA+dow
 B+7LHAE3XMrG3RPynYHheTfKxFyrXlhM3RDCXPkSsHbTZDeuetlhSy2PTMP/om523fnE22mSrKN
 aGGoxnxLUeZOQCl4BjOoEQcQO2/UfjYRADvo3UMZrSktsWbgy47aepQ+H6YsLYZUfa0YOjRo05h
 9oZiiv/srKZEv3Us17Cx1FZ4Lg61mEd+JeuvWlnu45q2dIiMMaSxqSqYAsvSCalwWy9doSUCfnC
 ftuDznN+IDQFdQH3d265A8AEQ8CpoH5iJ6lQDocv9PDD/lSBL7AHDYUD6W05E2n+aCPSFF0YFwU
 QY5A945i5sokbglZIcH9BkKOxPV3s7opPK9OSPmfluGw14VTyWr+xcG6KgUBqXoWgX+cVlqmdQM
 PswYCkE49IExgfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20526-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 698DF35C5E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all of the exportd upcalls are converted to use netlink,
don't bother opening /proc channel files if that succeeds.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 43cb16079da867e6633b9cc6436689ab0e156e44..19cfbf6594b0a51d85814460f3153add89aa3a8a 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -3013,6 +3013,16 @@ void cache_open(void)
 {
 	int i;
 
+	if (cache_nfsd_nl_open() == 0) {
+		if (cache_sunrpc_nl_open() == 0)
+			return;
+		xlog(L_NOTICE, "sunrpc netlink family unavailable, falling back to /proc");
+		nl_socket_free(nfsd_nl_notify_sock);
+		nfsd_nl_notify_sock = NULL;
+		nl_socket_free(nfsd_nl_cmd_sock);
+		nfsd_nl_cmd_sock = NULL;
+	}
+
 	for (i=0; cachelist[i].cache_name; i++ ) {
 		char path[100];
 		if (!manage_gids && cachelist[i].cache_handle == auth_unix_gid)
@@ -3020,8 +3030,6 @@ void cache_open(void)
 		sprintf(path, "/proc/net/rpc/%s/channel", cachelist[i].cache_name);
 		cachelist[i].f = open(path, O_RDWR);
 	}
-	cache_nfsd_nl_open();
-	cache_sunrpc_nl_open();
 }
 
 /**

-- 
2.53.0


