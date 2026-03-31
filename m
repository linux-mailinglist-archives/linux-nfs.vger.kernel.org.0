Return-Path: <linux-nfs+bounces-20569-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CBSA9s4zGn7RQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20569-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE7371740
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864CC30ED715
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6741C2E1;
	Tue, 31 Mar 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTL5AgHc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF043D4E0;
	Tue, 31 Mar 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991230; cv=none; b=jpreAvDnQ2ci0rOHiHO8M2RxATRlKAenh3DyJAGTSvF5IpqQ0ELweQKMRW3dnkQ5TRnwmDB9mzqjGQ4cskBqADQMXnHhnbGwUytobOkUzX/Fw6PG5lspHN1xJpFK3Z77ffogzL5LRxeaUXKmfntrZ9Qt4ucphrSh/IrfKIJ4f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991230; c=relaxed/simple;
	bh=il5/x3ykx+5nnRfT8kfkQDO33GzbY7CCfqP5dLEA2aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+u5O8ii/zg/t18Iot4wIFvUd+MfqpxrYfQynWO8apDwLbWSEjcTuusljzmsl1sUWgw+xSHzNOrhaDYRwQaH1PyswDhgitvqU/2q1Kufe0m0PREl/gzTuXEIqUotURd6YJBwLJ48VqqccDlghKGnwHroQJ/Djzcmg1F2yQKKEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTL5AgHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D165C2BCB2;
	Tue, 31 Mar 2026 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991229;
	bh=il5/x3ykx+5nnRfT8kfkQDO33GzbY7CCfqP5dLEA2aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FTL5AgHchsKHIB4FWDfvN/8ZXqSWdHxR/upcGe0MsK7/Bz+z+sjhGoWdyXqxvGUnp
	 sZMikzEIbV3XI7X6PGU/d3LZMdWiVxan9yHw0eZBshh2DPV7Nzj5eOXT2PDB5dzATr
	 IotWIDx3QaKGr55tPuD1Kj2zc7xp577Bb7M5qSmOIIxWbfWUyYpuzCDVFtNn/nNkA0
	 Bmdb/n/Hr7C7SYc+RxzPZ24/n+cDVLT6fTsIeOLV1CVW/qVQLZnrtu8tTYMR1ryXrF
	 6ok6V4pNmCe65zUAqC5bSX4becH41bmzUTwWah/bUFJlqFufFM9+cetEJPihwjbhVl
	 gdvwbZdh0TZag==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:06:58 -0400
Subject: [PATCH v7 4/7] NFSD: Replace idr_for_each_entry_ul in
 find_one_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-4-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AfX62FgEvlkafx4AOtCAMdyoap+9uGdmZK9an+BSRcU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5mhXKPm/H2/7Id3s9HnWH14z8lTkZEEBCT
 ZX+j9G2uxGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l1bBD/42oWoD4KtMQ5u4KlSWbZ/01Nt8jIdOFOOE/x+OoU23qWhERYNHoWUT1BjbogWCujui2gC
 /OK2uo4h+mHw4kajErqFIagvfpBgRULXP6wIcu4eHqAM8R6Flf1zx/J+JFza/hbY57N6Gf/RXYn
 2D5oAztkJFE7Uh53q4YFluTs9a+NPMlplbwPFrXPR3OY8iqTIqri+z66kxAximc21pqNC4yTiQv
 0E+/0dSQOr/gZkpcQu0IFpgDtrKB88aZ4G6V1fZ5zrQSlu8Cb+ZsFh7eatrxeOn3PKXFh/NWIyB
 ofXMRvG44fZJWaZ6/9Kk0BiH0UIOBhHRdczagH3HmuO60cikgz9OT1WfzHQiPEqqk2GskoqSMoZ
 heY9/5YWepMKLBwUnBHT1IfGEji2jm3ItFAAqZiYG0NjzCodt07uWzWHfxG6fVhvSfKpmrLogJh
 p82ZZftvmPSmnx3mFIsA5xj3or7UxmNrSidstTR26ASbexsQwdLNX97XeAG6f999quY8bIFNUq8
 NFvlpTHsBMsF0GWtrQfErBSrxyPfUbinJBDSp8EEzwAC9oZz35gK85p6ebRib/JXUC2NY5tqySq
 NiNaJXN/OFkM66IY+sNivOM9aVw+XOF2sRR67udoHLsMuwvDKqLLuFE3ENOw0MVv6K57Xt7VBK+
 zABai/cWjwSeytA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20569-lists,linux-nfs=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,oracle.com:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 9BDE7371740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Replace idr_for_each_entry_ul() with a while loop over
idr_get_next_ul() for consistency with find_one_export_stid(),
added in a subsequent commit.

No change in behavior.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 14df5afdb884..518dc74862ad 100644
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


