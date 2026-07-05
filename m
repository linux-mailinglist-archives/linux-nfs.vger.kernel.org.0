Return-Path: <linux-nfs+bounces-23003-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kg6SAvjYSmpeIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23003-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377B70B9C3
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="atQ/tpYf";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=L7fyz+vP;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23003-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23003-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9F8300E27A
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162534DCC8;
	Sun,  5 Jul 2026 22:21:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C13253958
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:21:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290080; cv=none; b=RhTPQYSSDMi6ZDbdDSdXhe7R7G9WxET0KPu+KsYJ/xTlksTMUiWA1e+XVuzIlQoEMBnwGmwJHCtmcFkIWjUWG90nkEZtD0UDQpnsYJwIJozyxAgWpMILkzH6lqNtqdX55eKatZvySxsliqq9AQlKerzrxz9jbuIVM54EA9DRyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290080; c=relaxed/simple;
	bh=HS5UifU6gExpM1wNbtsuhxZsqU0JYpBOT4M4AysYeNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww0/9KpEttPFxFhjZcJeLPXSVp9LQeIPmln++PTHxczGPwQ4ZyEpmx3s0hpMVPwuh7NpxJO0vPIEKJF06G56wO6teSGl4TDCRH3H0B4/vaEUCVEaxEr7zqCxynRLY0ShObIjzZFZYvbX5EaQo3e/oz5kQSYPSdwI5aOMMnHBxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=atQ/tpYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7fyz+vP; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E06B1EC00A3;
	Sun,  5 Jul 2026 18:21:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290078;
	 x=1783376478; bh=HAfnHQARH0Gfbq7UQfWHKg0sL34551RZN6ePThQkTSA=; b=
	atQ/tpYfIhymtT2r/0QYt8NTvoxV7u49fbxHu0STlzGC3K5iCOFUlHmNRiToLG5P
	8IU/yHLUWjuCSeYkBo3fvMVc8TT0p+83wt2RTgUc4QW5DF6kUGVTFeI9KhA7ai7Y
	3+gFtkFhN6Knfu9zPhS5fbozBvLtB57WIcU1mDRYdCoqasErufRA+cn+y3BWOYc+
	0JJbdnjiSCX7YzG0G8If8sHZsk000Mz4FkPM+3p5H2TkiOtJkoNfHMvS2zubzwJw
	F0BP8UMrCMwL/ldprMlXoUgJpl5Q5TTSCiuMR3wP8O135i8tsqWGdcJS4cOsjMH9
	hpdkwbGfgv/WT2VgK9tuGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290078; x=1783376478; bh=H
	AfnHQARH0Gfbq7UQfWHKg0sL34551RZN6ePThQkTSA=; b=L7fyz+vP49NTkec4s
	flwBXKkkZAlcqMcbmd4DuswHKb/5GYr9r5TxnuE1A6ZR0y1nI3BMzka2oEQKdfm1
	Y5DpHGhdxQfIrWVOtMe1MRvzl7e+iWGjdWZZiX41A9G1M+NV7w8nhvEOB7wJHHoL
	SjC65Y4GzRkBLOUoTysfDWj2hlhxag0GUmwskATAW3uqNz40GxxYpV5JQOZtCxKi
	dlOxQq+QqYxm7Cq8b3Yc8Y8jX+u5F4qQrhSGM6bvlwb5gsNEyV+E/vFxBrpqoyHw
	Nz3ZbKOZ+9o6LszOAa0QNPIIOCSg7wxfZ/GdfpzzbNmjZY0N6SAnPMJe15ztcFJR
	0+wSw==
X-ME-Sender: <xms:3thKavzaNEOJm2ZKbmSrEvMIVpNVjZ4nyblYuEUbMEexqvAsAR7X0w>
    <xme:3thKaq_mAHrfk0gzY_LqU66zw1R6_LPnEhjvuf3wz6LmEVwH9MyikRJgC81Qbs4Q1
    52OmMNCWlUOOgu9x5LTDI76krX8mF5hHoQ6BZZDA6pTyeIf3g>
X-ME-Received: <xmr:3thKajLNunVB9N3BdyVV3lUW51Ekg19rFI0K9QeeskoNXFaAJt95Gabj1y6lqhYETCjkSJ211Im6EBEhi8CfVPXD0U4czec>
X-ME-Proxy-Cause: dmFkZTEXWwk7I8gAcx7OrRtNSjcnGB47cRbiBDqgtw1WTOs3DuMG9iZhop51+DSdP1tiLD
    yCq7K4DQDhjO6nsk+F2F8II7LJ0utdmOACw+niG7CI11B2zvXCzreuesbdS4vY+aI4fICN
    33J75SdFOj7RZ5AcX4glpqvke7JrcFSl1l3lfiIjodRRR8tYqnxTYR2+eex171+X610ql0
    pwh3Y1hUkrOJ4HxX8l3S4zPrVLt+h0hyXkObswBuRXuRPVy5Gyp8EitKO+FpH8owD6y9Gz
    bsEbqyRQx5HBNkNt4zxvk4tnVA6tsZN5oK6SzyiSWNKjbVqVV+gXdrbGyBDtcahD+RvmcT
    qe1eBDK+CVZwhBowdoSYn0G0yeImUqPzD2+DjPWNjli9NYz+x9ifE7EPrEcqyVaBxY1RQK
    mb/3Z3JsfMQvojaIcao8/QXIYnWe0PWWpzdvsku/XsrXicHo5Hwyvw981GwI+i4xn1pEco
    saN6eoXDhpkxJB9pjjm4g1VEinN0Pi2pVKGO2n07BmY/VYWWXmK3DJ5gVq9XBZqFtm+tP9
    LRXfI9FGwqBNtMG+BZjDMHP4BV1ee9HReg7oqgjwFtvjoyoitPnadrz3uhNdbUGUjkEhUP
    tF+ccTi400wd/93Mi9mSYE96bpdOKrtcpfifLoZlMqptMI8n6V3X1d9owyAQ
X-ME-Proxy: <xmx:3thKage66V5oroHZj2JMbbPf-UlXeDyshhNDc1jUa0wevX2B5FmhhA>
    <xmx:3thKai9OkF3_jwX4OyC9QFUikTmg6bx0Z-G3DSC1wiax3V6l47tmrg>
    <xmx:3thKatqiM-F-NW9-dkWOhB8NQ_YLp1FOPH6w_zEDL6gppjMis58qAg>
    <xmx:3thKanCpTIJu4x44XJgnpfrDLioD76junLlxhqCOUxzPbPXYsBpDCA>
    <xmx:3thKahS_odIcy7vmSvbl3MwwY5hA02e-XL1-OY6hkfAmonUxEPI1JSIg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:21:16 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/14] nfsd: always open file in nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:40 +1000
Message-ID: <20260705222032.1240057-9-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23003-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9377B70B9C3

From: NeilBrown <neil@brown.name>

If the file is found to already exist, open it anyway.  This will
normally be needed eventually anyway, it providing a consistently valid
op_filp will simplify future changes.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 95e46c15c5a3..244d5f3975b7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -336,7 +336,30 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_positive(child)) {
-		/* No creation needed */
+		/*
+		 * open the file so that we consistently have a valid
+		 * op_filp.
+		 */
+		struct path path = {.mnt = fhp->fh_export->ex_path.mnt,
+				    .dentry = child,
+		};
+		unsigned int oflags = O_LARGEFILE;
+
+		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+		case NFS4_SHARE_ACCESS_WRITE:
+			oflags |= O_WRONLY;
+			break;
+		case NFS4_SHARE_ACCESS_BOTH:
+			oflags |= O_RDWR;
+			break;
+		default:
+			oflags |= O_RDONLY;
+		}
+		open->op_filp = dentry_open(&path, oflags, current_cred());
+		if (IS_ERR(open->op_filp)) {
+			status = nfserrno(PTR_ERR(open->op_filp));
+			open->op_filp = NULL;
+		}
 	} else if (create_status) {
 		status = create_status;
 	} else {
-- 
2.50.0.107.gf914562f5916.dirty


