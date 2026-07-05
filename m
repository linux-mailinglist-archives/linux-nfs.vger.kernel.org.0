Return-Path: <linux-nfs+bounces-23004-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nr/SMfvYSmpfIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23004-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125870B9C6
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=TfXpGbvF;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=fGdyvMXK;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23004-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23004-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D0E3007347
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864A35F193;
	Sun,  5 Jul 2026 22:21:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A508253958
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290085; cv=none; b=tA7UUHVyE9r/iQl6YYJ+Qa5TG+vxOAudbNO26gSulfZjU0aT18ymx5yKSNQXvfpM8qmNryk3aYYkdi6RXhXV/LR2x8f0SvtpuWKAqG2lTcEfO5PvelEESYuganJjqJs/Rw0ZHofOp7A3Wusq0Ydr836zABgLdhHFyP7Rm6S2xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290085; c=relaxed/simple;
	bh=ZVfMP/fvJPxbLDMIVepneGgb4xnwth8Ilqp+9Wz1/mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoBXlZMvGRE0YJ67yOoffNtXZp1hO6Q3BQ0UrA3x5+zwAx8ar6inK2OPtUB9OrzpnyLAwEm+z/ffjmBXCjdb7etQCP3qZXtc81Eky5cjzMz1ZQwpk9DEgrMHoynIQ63Ow9Ydg6Y3vOMJQHBaYbc9JkmPu6Nc2gn/iSnZZm1RN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TfXpGbvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fGdyvMXK; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 515651400022;
	Sun,  5 Jul 2026 18:21:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290083;
	 x=1783376483; bh=CCbEoTJQNfIiFKaaeom8FmWpQjaxZyJkf/6Ucz6CMig=; b=
	TfXpGbvFOtqaulRu5XyEr+bOOiezMvHHns7cdYG+ZKlOLqgRq0kh7FmjaWLxdhy6
	bgAfvb7dEqONr+tVAH+NIf11A3JZaTC0zyZATPaZ74Kaaw8WuucKZIdyGc8Aa2kc
	iEYaKAy7VaI4PNN4MbE9c1fXh/jzW6CNgCGRyDYmS6yFXOYPYF+rGfoU3MKTBNgq
	9sVzAo4Pk7X5F6bAWritYyxyfGqROmOiQEPMu6WqixHizI5LETzuvMMbuBwlox64
	TBgSDliHlArajhdPFZYsgOkTH8VOc7p3J0oykGZir2pm7G+nPGeVg1bMrUXbBE/6
	ev9t6rn65HV93m81fbZF2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290083; x=1783376483; bh=C
	CbEoTJQNfIiFKaaeom8FmWpQjaxZyJkf/6Ucz6CMig=; b=fGdyvMXK00u56jaTm
	pCkh3LDaHI5r7CNFtukEDLoTm+ErcBmuuNp/X2SzOhO+dmhorFewqf/o2XfdS8oZ
	D9OPuBc50Y6105OhSEjpJJVByfh8absgeD0tVUgoJtaZCSCfXPRKIBFIpC2Ko9s1
	8CXJe7k0ANZ6toaRwvMg9t8rJIJKqnK+nSbsmFpJP9q4iFeub33bo1VW3U3SrFTW
	ZcvWa+6s1uaCowAv4w+65izRDM8REpXzOW5GEBgApOe6b6xdsaeIIgIvmpcWkHBz
	VgzslwG8sRSzTm1IgUjOlmiqzu83d7rVJv6Z2Z1gpvx3/Bx3hZqFYzyAIvLzS7NR
	S5ejg==
X-ME-Sender: <xms:49hKakQI6lStuJ5sBbySNt7IT3nUI_N0tdDDrm9F9c4NnBuRF4-6zg>
    <xme:49hKalfeM_kcoTLSVjsG-YhmcVOsowM49G8oqrkignU9hU0CqobqB6KEFBR0oHDIS
    86keRO_g3VsBptJBLkmcZ1UTJLmbCtjMz7ywttroN1eIkyJLA>
X-ME-Received: <xmr:49hKarovz2cprO2ogTmO7X65pbjIaJ04pa3fi_AfU-86VB71_3wdr1bAht98COU_pMMJ-GPl3po10VP-2nE8ir_4CQzuG3A>
X-ME-Proxy-Cause: dmFkZTF0YcQ5/RatK2cyJlbfE7M9CwaOcSZuP/T/fJ8+XInZaqxHj7aGc2JZlfqxkZ1Qnb
    5pIxU9QzoakZc0IdtOoXKKnpZniKDX0JG+ndb/siPWPBdeP7+Bn5gaTvUxk3c9pDZEOccS
    ZUVnOEXCnNTf4W4kowKgP8JF/eZsbX7BzvByipTtOkrknQQGU91k5ndYz5iApF6SjSjw6P
    Qhi8feNcqKNEbdG0PK5/c4f6xkxJb3xixST9Ou1zT9lF7x0QDR4JasUarp/Jc+/HH1cd2X
    yinvfhvJbnjnUmHJDnMFbUX2AFkaKnzRa+mYJX7LzsktGmf3G5fUjTJc2x4Ao2IjCyM7qw
    vURzkWw+zAsK2ywqnJ+GfKJJe8O6M/x0qJtth+i0F2R6aRvX7QShnf1D6+2H64/GTFQ8Uk
    IsKYfUKtlYv91KFp9SRXrgozO2ph1jbILqsu/UOKcMTktYMJT8NlWlfOPFsIXswfIj637q
    mUBj6Q3gwSV4vnSMWLhm9NTRQIFyU8T6Ak5x/TV96cMlXUHoeZOCSgoNRgn35VUq49aLeX
    +iQ2RVkvA4QPvG+17WdOSsE9sTxQjlltvNv+Z9Eudp8BPD0aBt5FUuF1CpQHFrSlaC7YR3
    vdelDQP/1EbreIahRswAATTM1sduTx5FueWQg2gm+TqaxjfsBW5MDPbhgd0w
X-ME-Proxy: <xmx:49hKau_dfYdL5V9To2tgmB3imAXapOJPchpTl3txOaJGtjaB8bd-Kg>
    <xmx:49hKavcHxgaUctjlrIvIA9dBRUKpp4qkFIyXr-oPXbgWA8kLcygAlA>
    <xmx:49hKagJtXeZwP_xt0pYuI_M0-Nd4LEOqHgJILHKo4ASijkNTXSOtrg>
    <xmx:49hKanisl03qiqD6VZmTDfGx9pAV3dHnZITAQBFsXSUpn1K_MBOVSQ>
    <xmx:49hKalxWUR9mrk96bdlFY9NwUhcnV-Ey7tAIAHjLnn68MMHECrd0vTR6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/14] nfsd: reduce range of directory lock in nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:41 +1000
Message-ID: <20260705222032.1240057-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705222032.1240057-1-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23004-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3125870B9C6

From: NeilBrown <neil@brown.name>

We only need to hold the lock taken by start_creating() until the create
has been attempted.  Holding for longer can serve no purpose.

The lock is currently held across the setattr call.  This might be the
intent but it serves no purpose.  Holding the lock prevents the name
from being removed or renamed, but it doesn't prevent a GETATTR or a
racing SETATTR or an OPEN.

Calling end_creating() puts the reference to 'child', but we can still
use the reference that was stored in open->op_filp.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 244d5f3975b7..973beda7f161 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -367,9 +367,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		if (status == nfs_ok)
 			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
+	end_creating(child);
 	if (status != nfs_ok)
 		goto out;
 
+	child = open->op_filp->f_path.dentry;
+
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
 		goto out;
@@ -419,7 +422,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_paclerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
-	end_creating(child);
 	fh_drop_write(fhp);
 out_free:
 	nfsd_attrs_free(&attrs);
-- 
2.50.0.107.gf914562f5916.dirty


