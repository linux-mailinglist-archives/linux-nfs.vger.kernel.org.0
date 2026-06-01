Return-Path: <linux-nfs+bounces-22149-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELPVJYAwHWqtWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22149-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:10:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE261AB74
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619423087945
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BA35C180;
	Mon,  1 Jun 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AlvpCjfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkvfII7X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6D380FFA;
	Mon,  1 Jun 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297307; cv=none; b=aKpiYov+KK8ldXwG6espqGbn8Q1yUeyhz2ja+x40sNiu2jOqC/DT3UsaLFXpItIfvQOaNePWI6pCc7Jg4tv1alOk0xzJybymHAtgSGRvysv4wRwE+i7TSXG4ceGwscTAjuI4S3tQW47PT2S1c4yHyAOF9XIfC1O3ZfhSfFJJsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297307; c=relaxed/simple;
	bh=GGsLihGoBsJ7+aZ6jp8q3tedZnJz2xSsX3HYTdB0Ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hf3v7DqIV/M3upMyQaj90abDRSx6W04hWPFlQ9nIeHKrfVOCyMZHWsSLaMqdNCynJnMEQN99Z+S3P2zYjQjawWcRqv5Wurl4tgkr3LOHvKTd0xxttFh5rVE0tFZRcs/hZgeUMdyi+EVEXuRJffL4VoWfVcALLjCs9HEVHStdBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AlvpCjfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkvfII7X; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 692FDEC00CA;
	Mon,  1 Jun 2026 03:01:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 03:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297305;
	 x=1780383705; bh=Ea7fsdaRR2gX04E2A8H9S8z436V9D2gKlrlsArCY+K0=; b=
	AlvpCjfrC7jkrJr592AtgauKiod5KEv4cg5GfkPaU1xB0FXkvoWFbgh0nEhZlFsf
	xso/1Sag1YQpdPhIsfgLmNQQwjqot3EOMwi/raxS1jhpBItBwCEg6qhQ2yIlb/2x
	zcUyz5gnZOxtBzuT3EbqNSXkwaRFW3tCepo+tY/emNFhfo/3vOEqC02DZ4KWYX3s
	c3+4I8ZSX87QPsGY/1tD4lgEdbCdmi9ealbho5hC15gV7pIpTxAVfxKloIZIvWJT
	KjzMQU/DEhqzXCKb+72dLgp5iYd7fBQHfre/or++XpPRytt+XZLmhp4cYGl01Ren
	zazS7FusVY5l9Wm5xhih9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297305; x=1780383705; bh=E
	a7fsdaRR2gX04E2A8H9S8z436V9D2gKlrlsArCY+K0=; b=GkvfII7XD9Ch2nqTp
	5uxRoI6SSi0sHDZ9/1rx+rsVSsXBFwSQNSwCOw1P0xmJRFhafgLMnwVoYLhF9wqS
	j/c/fwwXzQKzEuPfYPGCsbkn4gptb8yNUG96IRAFwzo1aVOpLdVnTGnksrz7r8pm
	gu2/6Txko5nxGIvxH6nygV+QNI3TgTcJzXJx6rGeybj+7vTRvQBMCqRotK1HLFva
	UfajdjWyOMfPkghT17Ty5L4YhHE41RlV88nRCL5EeKy9TZCBjvIBnR+oTY5+afRj
	GWx+c1BbGE2cahWMA5mgPRKEdTxaeJ3UaI+MOSreigcmwmLYJTYYL2rJq2oY4lsd
	xb2mA==
X-ME-Sender: <xms:WS4davCAsqLQVzrgVn-sea-cVZOmKpseGTWqG-sGog1b3mD-O87YMQ>
    <xme:WS4datuWimUIedGNG4u2U5W90XWVCtgHtPgPUJJN2h6lqNS9r0Wk2oU4k3ifODNLL
    WtG1F5Xn8kAkaDMXj9ogrngsjmLm_X1HXSPyW80wF09fnM3lQ>
X-ME-Received: <xmr:WS4damK_6USHW19AEiDVMtd7L1y7Xfyk5LBmkez7XN2e1YYyS-bAQbpgR75EnDlzxvbr7o5OYx4w1aGtrFoMP1TzK4zmLgg>
X-ME-Proxy-Cause: dmFkZTF/0v9QLWqKGcDzcPcERvNp2OuvpaLQnhg1kVCZ737817GhipXMBb0AeZ6JBhuU4x
    GJrqzBUJbWPaZjirZQ5Vg29YWKz7XvSof4yGflEzDHc/NhOtmChI7M3NC+sT51Q2HtjBGA
    Ox0luTlKNNxokRBhJ+iYrXPeMs1uw5hg7ApCBnw81P6jLjTjx+DLUI462DuvIzBep4eqUb
    kcu9GFFH1pkG2Mz0R9MDbHL4NVZuF7K1GyrsyBBUmwhVfQ9DU0KmxDI1vM0MJ9YttzwuX9
    8bZMaqp0pRg8egOeVEhrVJC7lgaMNtMxPQ7Kv7qmvLuuQopt9LMKtybKT/rZx6hjH7WBiv
    dfRmcS9KW1yS72h7DfVNMgZ3TfbIqMuaVsA1cOdzWrJjTkr20gyOOLny+M1u/Wu9HEV7BW
    tjzluTL4dRrDKVucQc9FEuewvY9nlFeaXGPKpOxbqQQqE4V+jENfVRn98et3JtuSzTDSRZ
    kSooZwaGI0uA8fEFIcjlJqpvI0TEYnJfnH6g3pAsk4jpE6BR7/eAvMRR9KvtB4LH/5yWTt
    QUWQOJKLrGHRb7jwvyqHGt5jQYGnC9J3FKu8LPU+jo2PMRx5GDXZP/ZB85YB51fHci80BV
    eR6DQzSyGmw9Swpse+Hwv9GystZLA6joR1Yd2zelBq98mxgGxgxfzG2UytcA
X-ME-Proxy: <xmx:WS4dasYOSSZNRg5COvjxMcffcbc-nCFLv25od_YV47ZG5lF0nhqdTw>
    <xmx:WS4dagByNzobE9U5F6ia7SqL3eEaz3ZzY_KAdFVFsJ33a9w0oIjUjw>
    <xmx:WS4dauZc7KiV9aOO88U8O7zrysKneHrwYuZaQZ9qLBoIP2KeVeHrUw>
    <xmx:WS4daglN7S-RFnFFgAXCEctICVIBKvt2iYhutW-p_uccRKEBz7CAKw>
    <xmx:WS4daoE2Ei_DPuTIHSzl0wa2UgfmIFlzcB1KG8TdCCF4CyfOI0NtdDlo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:42 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 09/18] nfsd: remove subtlety from nfsd4_create_file()
Date: Mon,  1 Jun 2026 16:37:57 +1000
Message-ID: <20260601070042.249432-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22149-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 07CE261AB74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

nfsd4_create_file() has a switch with cases for
NFS4_CREATE_EXCLUSIVE and NFS4_CREATE_EXCLUSIVE4_1 which are identical
except for one line which is marked "subtle" in both cases.

The difference boils down to a "goto".  For the EXCLUSIVE case the
target is "out:" which is after a setattr call.  For EXCLUSIVE4_1
the target is "set_attr:" which is the start of that setattr call.

We already have a function is_create_with_attrs() which determines if
the setattr is needed, and differentiates between these two cases.  So
if we guard the setattr with "is_create_with_attrs()", then we can "goto
setattr" for both cases and so unify the two cases in the switch.  This,
I think, make the code clearer and less subtle.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b798939821d2..3446f9b43bf8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -365,22 +365,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
-			    inode_get_atime_sec(d_inode(child)) == v_atime &&
-			    d_inode(child)->i_size == 0) {
-				open->op_created = true;
-				break;		/* subtle */
-			}
-			status = nfserr_exist;
-			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
 			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
 			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
-				goto set_attr;	/* subtle */
+				goto set_attr;
 			}
 			status = nfserr_exist;
+			break;
 		}
 		goto out;
 	}
@@ -396,16 +389,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
-
-	if (attrs.na_labelerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-	if (attrs.na_paclerr || attrs.na_dpaclerr)
-		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
-	if (attrs.na_dpaclerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
-	if (attrs.na_paclerr)
-		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
+	if (is_create_with_attrs(open)) {
+		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+
+		if (attrs.na_labelerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+		if (attrs.na_paclerr || attrs.na_dpaclerr)
+			open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
+		if (attrs.na_dpaclerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+		if (attrs.na_paclerr)
+			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
+	}
 out:
 	end_creating(child);
 	nfsd_attrs_free(&attrs);
-- 
2.50.0.107.gf914562f5916.dirty


