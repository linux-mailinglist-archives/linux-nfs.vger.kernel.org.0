Return-Path: <linux-nfs+bounces-20435-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FT5Msx0xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20435-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:02:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 726AA339C0D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2FC3083353
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64038E5CF;
	Thu, 26 Mar 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAxsRgc1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A141B345;
	Thu, 26 Mar 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547741; cv=none; b=UZKCtCVnWos9Zi43gvsoSJ7QI0CzkUeSJ/HutzMgP6NY43IMAddzmPlBrK7h0i8nud0MNIq4u6O05TV/ZUnLvS+4B/rxGbfuP3TJatlwdi7bZ0iTvJPYWEk2ev0wViVexDAhosAw/YfgJw8Lt5xzKklAGPV9cnK9foY1WulMTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547741; c=relaxed/simple;
	bh=9RK8pitkWP+Y6SqSLYKPueeQHdHD7//Tz8r7KF034sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRRAC1vyHDiVCluY8XYpFgauKpXsm4v8t1IfGCTsTqFMQbkiN+mNUKdhRoBN6qCT0/jjhSiqQB2MV6mDR8LpByRPR6KLRSJ8meYftsgnOEVD7oDSxK+bkAeWF5L0iR4S3XIxwg37+Z9ZAIqE/9uo1Ec1R7misWCjuF1iRwymW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAxsRgc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA5FC2BCB6;
	Thu, 26 Mar 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547741;
	bh=9RK8pitkWP+Y6SqSLYKPueeQHdHD7//Tz8r7KF034sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XAxsRgc1BLiShcaPFq9rya5HOdklOFyYH62k6AJvwXrccyLyQQG0F90KgEg01GeAQ
	 OV+3aylCAYkHM2y42RygvSudJ1tTKaNh+Qp4mAHES5Lo0gIAI3FZqatdkgFOykPZlE
	 Ad2itlji/vujFqXjva1qjgh06u0/zOcGeyC0HFigCOsjHBVldoW81NWlcA/8BT69Ax
	 kBYuiBCoK1iWYT8J8abKc89bGbopT5+NGwHz7N55MOFHh+wE1Ir3OLBH+zb4E5eaKc
	 DQ8YYM9SbvSxI4Ry920J7Je4O0FVDzdsnKs6/osmqW+a5/V16mQpEoyxuEKlrhMKVE
	 u5rt4kmmeJGzg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:23 -0400
Subject: [PATCH v5 4/7] NFSD: Replace idr_for_each_entry_ul in
 find_one_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-4-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4D3NCNeDvxw+pDdnQLr461XqpXkpaxoswssFZr2pQV8=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGnFcxjI7nU583l3y7W9/1DtuQz4pLxuSnpvZDC9JK/sBAfol
 YkCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJpxXMYAAoJEDNqszNvZn+X+CAP/iCw
 x6xdQ6uCcofnEIgWPzCVa5176BcCFMLSXApGPEFoOX0cHQ+wMPsbHEXkWaLkavbMXaG6BxXe2/M
 saOqkWb12u1vnUC2sgy+yHpr2j/5KGaZkfs1TKJmO01q+j293p+X/JMXxKyJ/tuJ7b8vtcXH/gu
 xVyyMkwz6TgrIP3KbroavGA7CYWcnaZck2ixbRSLOPl+XAPw78PZYm/3QX0iYGtXZQd/8mhp3PT
 E+CDaOKdO/p8poVXQzVsIlNQEpGsRnSx4Zpk+wgr8csYekeHq2w/k20U37wgUUgZ3Q0XGtso4zj
 h6FFVbkzs0VamO8Vu/KXFBlMF94KAwv3LZNCXI/AHflF90RX1RkqE1sGhbEyXb9UUgS756gMalS
 7PD9//cMHIJhXbj03MH/SKjnEa3NzP588sO3yTWz/pVzrbDymJbIYPaN3n+WV0BV+hEqlrBTlc2
 cGLvFJBR3hnh8RyllvINXQWuRlJZYIh7lFWrM9VijIppwwvcwfn2PwEzPCmJpg81YtJmna9ZGLh
 XDjAkd43mxqD4n4f1F0HtCQMYqVhVNCcI8A8B/DQJO4K/K4X7v9xP0qAL3GNeNYfajA+i+LnvRn
 eH+qoovf10Q3LSAWsj5iW4R9vfW1FGXg7+JUzX5fxHbG2IT3aqlON6k1bCFtZq3gBm5AFthGY3A
 ya/VP
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20435-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 726AA339C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Replace idr_for_each_entry_ul() with a while loop over
idr_get_next_ul() for consistency with find_one_export_stid(),
added in a subsequent commit.

No change in behavior.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eb1bd1aae8f5..62ebc7243c4f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1760,17 +1760,19 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
 					  struct super_block *sb,
 					  unsigned int sc_types)
 {
-	unsigned long id, tmp;
+	unsigned long id = 0;
 	struct nfs4_stid *stid;
 
 	spin_lock(&clp->cl_lock);
-	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+	while ((stid = idr_get_next_ul(&clp->cl_stateids, &id)) != NULL) {
 		if ((stid->sc_type & sc_types) &&
 		    stid->sc_status == 0 &&
 		    stid->sc_file->fi_inode->i_sb == sb) {
 			refcount_inc(&stid->sc_count);
 			break;
 		}
+		id++;
+	}
 	spin_unlock(&clp->cl_lock);
 	return stid;
 }

-- 
2.53.0


