Return-Path: <linux-nfs+bounces-22546-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ys/uANXWLWp1lAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22546-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B967FE79
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dx7Wfo7F;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22546-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22546-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00C7630028D4
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A94257845;
	Sat, 13 Jun 2026 22:16:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5522F99BD
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2026 22:16:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389008; cv=none; b=sOtAmVRd7+LE9XuPSD+qTwMXR/QsK3RNIw581cfoAokfLtktMFSRzsBuBdmUb3Fmj0ZbZDHRNjp/qRxb1scSS8vdGubTAPF9uP+gNq5ssJmJXKfnBvjRrEzUWCuSbBxyDXPtb0oZp+sStxW00rk1LkZrdPXdNZ0JJFFGsu0kPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389008; c=relaxed/simple;
	bh=BLpvVqZu1iMSBQ9Iw3lCUMDvNrYkgl5eGn8w+HpNM3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BcX/tJHcbapiQpnEI+r+jDLRzi7bQ8lAw+QrMR9r/MQ2WPG8DsdYXmJ6YYRLv3oo8WcCMsvRIyow7VWRL95IX/Ta7T3Rnotw6mT0XrzVMEmvo5Zz2dP1r4FUACoBp36TzwIflDg4JkBODd3IKQQ6ZsB2/1aso+8deLWz9wkLv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx7Wfo7F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597CA1F00A3E;
	Sat, 13 Jun 2026 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781389006;
	bh=/4v7838X4i2RPy3GLpDNQTPuF5WQ1DQb4QX02Ca+iks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dx7Wfo7F6/6eNdP4kDPOHdpr/mRisx1/8tJwWHreh7wQwJxpsxyrF5xVCA3Yru4aL
	 ykl1h4ec9cINK/rL8VAQP7AjR+NpcQ9kO4C++2mbhxBcCzhqFU9ZwPVuEanpVpjTFo
	 mfws+36ykNnvWsx0zCcx0sundz69PvWWv1rnQTy2Y9VllQjq1LnJfJiN1D+5gJeIzp
	 XeKfkla6b4Af0fkXVk0K4XTC0Lrgq59Qv63Gexril4WoH/TylZ85EUHlH64yWu5XmC
	 edzzYfLHkX1qP5UMPgd31lVF7TdPBbM855ZP/m2tfaZhTD0IJskutUwoKPTmMRuJrE
	 xrglUdJm+Vqgg==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 13 Jun 2026 18:16:32 -0400
Subject: [PATCH 1/3] NFSD: Prevent post-shutdown use-after-free in
 unlock_filesystem
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-unlock-filesystem-uaf-v1-1-462b9bec8c84@kernel.org>
References: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
In-Reply-To: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Musaab Khan <musaab.khan@protonmail.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=cel@kernel.org;
 h=from:subject:message-id; bh=BLpvVqZu1iMSBQ9Iw3lCUMDvNrYkgl5eGn8w+HpNM3g=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGot1s2gaH1/1xxB0oevgOg0UryivAYfWKLyexJYLXJ+p+WAu
 okCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJqLdbNAAoJEDNqszNvZn+XL6IP/AuV
 wI9JfulUCD6FHhEU5vQTPz1upWZTBpQ7tqlyCHUrtGu7M/p/nnBRydKzUINZjNBFdJuMhN225vU
 K8MCfvWGi7L4wH62UHNq1GzeWi2nffZwsbdBed+vfJ+5iz1Yxw1ung/9w3BS9WIgh8FVqETV1he
 OoGpxt+0Ec2mdYoDbRY5bKuPu0EayrxuJHSCaBW4tcrWmEToWG4wHONmZr9A9S0VkL4qSfGoEzF
 Pj0lEw90kmFa58lO/i4Q3ZmhttdZOuEYQ9oshVSsRm7JXTYwqMeElNrtMS4LQMuEsl0OK9Ke9Sv
 TsRMDPpW5VK5jSwtgCQ5MqwQ9PHIT5Brcnkgo/xDST+Wv24ePrGbFP2Sxh9A6CCLiIvk8QNo0P8
 PR7ce8Tb9Hy5amNsjc0CQEk0SidMHYwIdV28vGkM4g3OMQsxGDDinR2j7WVSfTdNrzOP1eP47Ok
 D8etFORR9SCsdcylHqN+e0rZxf9HZE58o8RIscfcsD3HBucZL+W6GQsjWXfHOQa05eLfl149Hno
 HaFG2aYQoa0ApSIVhyau9MHcCUy46kaU9R8zJnfdt/Y5RhPBAW/Z1LUcFOVu5+84e5lt1mI73jV
 2wXRgvOz+RMbigLyrMgXKMQ8ff4Hu/NnOOovagiAzNPDPXku1lD9zgA9+v+nCOeu90ydxvn8m4u
 1GQyU
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22546-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:musaab.khan@protonmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,protonmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086B967FE79

Writing a filesystem path to /proc/fs/nfsd/unlock_filesystem runs
nfsd4_cancel_copy_by_sb() before nfsd_mutex is held and before the
handler confirms that nn->nfsd_serv is set. Once nfsd has shut down,
nfs4_state_destroy_net() has freed nn->conf_id_hashtbl but left the
pointer intact, so the cancel helper iterates freed slab memory as an
array of struct list_head and then dereferences a bogus nfs4_client
when it takes clp->async_lock. A local administrator holding
CAP_SYS_ADMIN can reach this use-after-free by stopping the server and
then writing to unlock_filesystem; KASAN reports a slab-use-after-free
read in nfsd4_cancel_copy_by_sb().

nfsd4_revoke_states() walks the same state tables and for that reason
already runs only under nfsd_mutex with nn->nfsd_serv confirmed
present. Move the async COPY cancel into that protected section so
every NFSv4 state-table walker on this path observes a running server.
Async copies exist only while the server runs, so gating the cancel on
nn->nfsd_serv loses nothing.

Reported-by: Musaab Khan <musaab.khan@protonmail.com>
Fixes: 3daab3112f03 ("nfsd: cancel async COPY operations when admin revokes filesystem state")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfsctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 11bbc7e8210c..29d68abfa5c8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -296,14 +296,15 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 2.  Is that directory a mount point, or
 	 * 3.  Is that directory the root of an exported file system?
 	 */
-	nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_serv) {
+		nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
-	else
+	} else {
 		error = -EINVAL;
+	}
 	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);

-- 
2.54.0


