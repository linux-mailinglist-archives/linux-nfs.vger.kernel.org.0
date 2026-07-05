Return-Path: <linux-nfs+bounces-23000-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSO2CNbYSmpTIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23000-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E26570B9B2
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=P80aPTgb;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=MKn4SDWN;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23000-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23000-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AED5300ECBA
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A1253958;
	Sun,  5 Jul 2026 22:21:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E8371065
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290067; cv=none; b=oKWLV+uj8jhii2k7P1XQZmbaxfWwO6f3l8mr67yhvuQDioDylwQLxhtDZuG4PeYGOQbk4X4muPrvxARnHeKkW+ucucaWUW/3rUXfv20v5B+iPSX0VikV/v8biHJHvpQ0JuFGvO4W9LX54VP6ITZ54G7x8jT1CFUk9+pETOycnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290067; c=relaxed/simple;
	bh=/o0gHi+giBo9bJM9rHZwQvZ/tPf/iPAe2lopVMfTRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwoON5RfsFZ6obsgfgq1QOlkMpBWBkgGT4eKZPUn8LAvlnh1U5b3Iwi8MpiV21HcLYl93ZYW9U8w7C/blLJvEJB8WWiIMdwIlV7B+/zB1IlYRism/1czIGPfXEBFLvvrU9aTnHwOEWEf/R8fj3Pu2x3e87HccpHzmpqHynzVCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=P80aPTgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKn4SDWN; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7F62140009C;
	Sun,  5 Jul 2026 18:21:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290065;
	 x=1783376465; bh=WtoYQCHI1Xanx+W4EeZls5RWyOK+Dl63nSmjIpr59NM=; b=
	P80aPTgbXc6zYyHp3V4UkR5eYYKXdK45HBYF2nPt/3ut/5Zw1QGTJ+Abwb0aUsst
	VLQA9hMQEqbXk85D//fXMkWzHSL+xg22fxXsNdVn3hDqqD59YBtDTAuPdiQ+Fpkd
	8IGHepm61wLXDX6BziVRxKeSlhGyPglO3HAL23L2mCYlO8K8FFA+5ObP13LrMk5G
	k03TxoHN6pn9EdLs5jLM318TNHXiZOzmCyVc56N1XZZJC5AxlmIMsyUr/laaHsKY
	FzgDmAswGeZtoy7aalo711s3gJRAOKpv3iYrjeWhW8O1o+ga4Yoi67jsRVWdFPZI
	xJst5YI6Q6KJMi0slWuQtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290065; x=1783376465; bh=W
	toYQCHI1Xanx+W4EeZls5RWyOK+Dl63nSmjIpr59NM=; b=MKn4SDWNBa/xFECDj
	+f60D6JtoDfX/q72Ar26iXZibEcAqnoBnOSI3fiyLM/aDkIh+heMBqf2pYm867VL
	zz5H0JqOu1B0xzv5LWgbdsWXEgWoXvZjW79Mh1dQmuC2zdUU+j4e6c0yIEZMrrf+
	lg2dZP65opD+YHV9WARawP/eg6Lo5IWF2m+FIUs7/+vEApqxv1rtBgbvKo756z9c
	hVk8xswlIOZE8Tc0KJUYsXcdcFd1MIGOOOb4YB4uj2xu5OsKWt0F/lnj6kMjhaML
	oRtjwK0+UHOINvjr3rTnFg66/KvadWKqym5U/0IjELUsLLNIA6D6UlySwc2Y6LSL
	PwL/g==
X-ME-Sender: <xms:0dhKas2-LJW12BmZazDg8E_dg9EdmpLyn7jKteAoe3LEUR7TrLZKjA>
    <xme:0dhKaqys5lk37tzijkiOrWOnE9JnoV3a4qaavSKcqVzBj-pTaieDQqIri0DNlv9J1
    bgtQGFUQjOemLc3zmg_RWusnqqOL5iYC4o9-2AdR7v4m8-X-U4>
X-ME-Received: <xmr:0dhKautnrSV6NzSxS89JzWUqlHGjI_r90RXZFHXerNVRKDCrjTWSGkWy8wrGm4Gaaquf_RBEVACyNL_64QfQGgdCHr7KVPg>
X-ME-Proxy-Cause: dmFkZTEr4hgezBpzDo9mvgkFhPp07FD4gulmHK2M8hjNYZb0ZwuzEQN2S8LW5IG+r/q4Bo
    PILCKdxIkiC4gAaMRT6wyUo8gCr2qweJV/SbvF2SUz2H0GVo6hIY73puwFJFPjP/y0ZROI
    MZRmG5OKrEwMsP9tWyAX3rgRtqBp/dEgAB6N5sjrN+0yp95MtfB/YhzoWx36XSS7TdxxkC
    Xf0Klt1JgbeKHFTa6F+JHDtJcwseTY0c2V5KPxbV0Sw9f91ZaCTgU6lfO+L5YV63m0lD50
    kIq98di206q+gl24JJVpcE/HgoEU4wrgC93li28/M+A3VaNYNVmmxJ3vMOh1pRQcHdHiRQ
    8aO5puqdUXzFdWaXoBBtSPW2VfApQU6PU+IlTKxeogRA6seje6rrW4HIgFyTdP/xnBS2eN
    Kqhbss7MWlvFw06ILaVi0i7/S3Hbgz4mIEZU83ixIRWBBSDnlyOxEym1WWDvEZEat8hY81
    SjFCsCZc0nK4RJW9lLH5GEsQmD27TO/+YoZJ0l8qOzwxSGrvirfB3VUGIyDkjpq7CTRJJ5
    kzA1W1HytVAmQqq2ic5txoIVrryFSY8jR2ynY6KvurgKgjXv8VEhpagsK1U/2nm3GLoXWD
    C0NdbcGukL2lWmunCBlUvNrTrmCkNRvl7JiQ7WlEq/MBhs4/aqGfNIwdMeFw
X-ME-Proxy: <xmx:0dhKaszQw1B58OL_4o_XDl0PWeFGTbtGMUH-50qFtrlT5AICj-L7bQ>
    <xmx:0dhKahD-fBtn1w18Gy04vhb8_OTl1ivjl9a1yYGWhVyF7Cz-jQTU9g>
    <xmx:0dhKaqeraqaI5-_1AqYnXCScTwhriLx_4KHv5p47WuJAradaNW4JYg>
    <xmx:0dhKarmWn8_Rj-ku1mK7tOvj6tWBWlhd4pdHCHGaX3O6Xu5RubKOpQ>
    <xmx:0dhKaiUyfQsoLbFXeFYoMT00gyPB6abRHFDbLxI-O_JCXL0dfnkfxhtO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:03 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/14] nfsd: remove subtlety from nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:37 +1000
Message-ID: <20260705222032.1240057-6-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23000-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E26570B9B2

From: NeilBrown <neil@brown.name>

nfsd4_create_file() has a switch with cases for
NFS4_CREATE_EXCLUSIVE and NFS4_CREATE_EXCLUSIVE4_1 which are identical
except for one line which is marked "subtle" in both cases.

The difference boils down to a "goto".  For the EXCLUSIVE case the
target is "out:" which is after a setattr call.  For EXCLUSIVE4_1
the target is "set_attr:" which is the start of that setattr call.

In the EXCLUSIVE case 'attrs' will only contain the verifier.  Setting
these again is not harmful as discussed in the previous patch.  It will
also call commit_metadata().  In performance terms the cost of an extra
'commit' in the rare case of a replaying exclusive create is negligible.

So we can safely "goto setattr" in both cases and thus simplify the
code.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b723ba08ddaf..69cdbdcde7e9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -363,22 +363,15 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
-- 
2.50.0.107.gf914562f5916.dirty


