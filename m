Return-Path: <linux-nfs+bounces-20731-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBOUEeVL1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20731-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074283BC384
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8073175A2F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636A3C9EDC;
	Wed,  8 Apr 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BerWL2Nn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C473C9ECF;
	Wed,  8 Apr 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651410; cv=none; b=KEpQaDj+y0SFcZNZjLjvPVBTktoWeK69kmzw3yc8reRZZMDKlWsUSLjtlfjPjbH1pGW19/FvFfGk/P71XzNaFJhcEZMcX05AVNOKVdYX4muxiubv3WWIW6mESzJu89FnmpkdgnBW6nVjfXpJb6me8/73ktXDSZ/rRU7lGEMQUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651410; c=relaxed/simple;
	bh=m55klBpWepGYNX/ySIq5sKbX+f4gXOFFZ/my2E5Ew4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMmxdCGGMSvH1zaojIoT0jq9vMpYDdNHnEJGdTc3RXlhH72UBWc7QcPfTjv+ZpoJgZuKOO2PS90r07HeV10xRpjJlXQzl5MuK/s8chraPH94msG5hQ2ogHKSEoG9HjAX1Oo8ffvflmkOQvNzfWt/gLrgjbUamGl83CNVbllHvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BerWL2Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72EFC19421;
	Wed,  8 Apr 2026 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651410;
	bh=m55klBpWepGYNX/ySIq5sKbX+f4gXOFFZ/my2E5Ew4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BerWL2Nnz8oDgAeq/hb/E2YsKjdBwlumSB/ZWeOdBszY3LEJ6UTH/SmLt9ukMS1y2
	 eJNa4PTgn9fXxXY7GTo4LKFctW3E4Zhp0bIsGZxl4DABO2BbFn8FW1lbuGQhf4IoQV
	 zb31rUslve78+S9djvWqMRXj0aGiyIVyqcb+kOsmGirXgonz0Gn7qUsVhgHSqVoV6W
	 Thu5a0Mbmh6SE532/NCyvwdmP2qZdYNApJZMGCjAUU1yXzfcyspFRkTfgXDrKMZXKX
	 xxU2oZxhu1yLfTWDSeCEGrjnqtbXQoqtukFxDD4TKad1EP1UncARUx183lzWNR9sLU
	 gLuWFus3IAzdA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:52 -0400
Subject: [PATCH v8 2/9] NFSD: Handle layout stid in
 nfsd4_drop_revoked_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-2-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VFZzM4b70QL9NfjrBwUeg3hfegKPs1VQ1Ib7+4dQt60=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPRWFzf8gZZC6hZ7zzPUjBJOGO+EOnbHzOa
 B9uXgLo6+CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 lyXVEADAM2NSbFMFEu/DWnQJ23kU/odMJbIH3UMc3NyAe4UyHTZB5RKa1oc2YUnyT8lOqR41ZHz
 N6EYHrugu6EagFGmKO2Fy7MaVizC6orBNCLbeVaEnGQIPjO/7kbL6vOU5ikv2TC5YrNfNiEjX+7
 AlwVhZQQ9IkP8Jl0oWerR1L/UjBls7wfOMLkb2Axlv9c9q3QZxZQoe6zntyJcdNqe1mKEKdosIk
 ffeTSXyVGyv1AB4+XyffB8/4243KYPvuzxz5rsCi2jyPpbtjcyActiG/z2RzoLKt7nSA6NO1AWY
 Ble1vbpjiRm1OijA3qJIqCSjJ7urkweAANpzRgqiJxKFGZoJpAMAio5sCS2FAqVnExkR8ns1P9u
 sWLobq7Uzh9gHo2x6SowvPlNyR5niQjV6Z077QXojdqzdS7bw+npULuOo7EHwPBcaNsjzZ7eL28
 RsFMNdIPeAh+3DZi6dsIOz2GUj+eW5jFqmLxf9F5rzw+IHWmcnWqkYkuCOxBGCA9Yj/nhmMkSPo
 R5BJYmfIoPCiD6U8vLcL9PI/3T3sqBWvPQxS3miIjPMHo/x3B8aZs83BCNRYNPPbkyTDCWvrDan
 RGp0Xhqe/mKmoj0W6FypOPugggdtNd8KCEn8FFWgT6FUcy/9uLyT+Z7uDKyT0XF7NaR4MdI6WeM
 wIp4EW0pxo9AD2Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20731-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 074283BC384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_drop_revoked_stid() has no SC_TYPE_LAYOUT case, so when a
client sends FREE_STATEID for an admin-revoked layout stid, the
default branch releases cl_lock and returns without unhashing or
releasing the stid.  The stid remains in the IDR and on the
per-client list until the client is destroyed.

Remove the layout stid from the per-client list and call
nfs4_put_stid() to drop the creation reference.  When the
refcount reaches zero, nfsd4_free_layout_stateid() handles the
remaining cleanup: cancelling the fence worker, removing from
the per-file list, and freeing the slab object.

Fixes: 1e33e1414bec ("nfsd: allow layout state to be admin-revoked.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c6cb67cf02ad..ae5e1a20197c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5070,6 +5070,7 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 {
 	struct nfs4_client *cl = s->sc_client;
 	LIST_HEAD(reaplist);
+	struct nfs4_layout_stateid *ls;
 	struct nfs4_ol_stateid *stp;
 	struct nfs4_delegation *dp;
 	bool unhashed;
@@ -5095,6 +5096,12 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 		spin_unlock(&cl->cl_lock);
 		nfs4_put_stid(s);
 		break;
+	case SC_TYPE_LAYOUT:
+		ls = layoutstateid(s);
+		list_del_init(&ls->ls_perclnt);
+		spin_unlock(&cl->cl_lock);
+		nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}

-- 
2.53.0


