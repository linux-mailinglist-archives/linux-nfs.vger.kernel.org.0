Return-Path: <linux-nfs+bounces-23287-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlePJUmEVGpamwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23287-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5C7477F1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="IeXVOHi/";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=qIOu+i0G;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23287-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23287-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2AD3300AB07
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F540343D7B;
	Mon, 13 Jul 2026 06:22:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96733815F9
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:22:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923777; cv=none; b=G9ygRkhMT9cfY2ImOSOFpJa2/JABKyDWzMLJPedQZrWjkxoKOfjsZXoGOF99OFdJhCW75nElsNyKgZ4/ponkK1oOOYXLrVasnQ18eii02kNqQH5SE2mw28kO7RivewjXmYFmg/xr5rLdHI82+0sC40aekxC5dfxOvcvIuRC5b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923777; c=relaxed/simple;
	bh=op+2Wl1aPikAUcdiWYgc/njInRpQJZvvKte6SES4VcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LogcACBPIUyaX3wVwXr2JXhZyP5xuI3THZ8AoJNljZwiTNcw+dL/UlzxWKxcOxFTEtD3KRaELkDQohgGBq6ab8p8sYOV5QWNeb6ev7H/r1kuDfTwYYTMxhcqy9UlTu3Xc5yA9kmlsC51pu5Dr83qtZ+y74m2gX/iqO4GgRUlrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IeXVOHi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIOu+i0G; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 26A1D1D00037;
	Mon, 13 Jul 2026 02:22:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 02:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923775;
	 x=1784010175; bh=ZeyC/nem1pRuWB+nOmsyjIjSYltljiu/J0jaayAYlb4=; b=
	IeXVOHi/g4deGZcVB554WGbHtM/nFZ73yZcYYqw8l93n2RuJDzRnL+XIUG+g+NUu
	vci21umkjw/Mvwwj4qAjDb28D0abTGiK9EQY7lmv5d1Z5k1wsCQcsZdnvwU3sPqc
	dts/6r7er5Pjc9TvX/VPQx76bvbrXzBLG5cGu/20D1aUvOGFQmj6AngVWmHp6ZuX
	Y1geyX8GesOtZ2xSf29kQ5+OwI2Rf1QMKDqqTjS3pFW78UcVNY2nhTSFITUwHfre
	j4HoJ4osoWHRHT9H22wIySNwMzPzXodpIb6IMMn4fvLGOGgwBopps7AFszXgFETQ
	mkB1444PDXe9cGQBwDT9MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923775; x=1784010175; bh=Z
	eyC/nem1pRuWB+nOmsyjIjSYltljiu/J0jaayAYlb4=; b=qIOu+i0Ga2JKCCaED
	TBAJ+LliLGzeJMuR3zfIz1hw9QXTRX7d8h518b48RSMLwHcLjAEN3whVgUqE+FHv
	6rkDOSrC1qkt5QruHWJcOw/eZXYcw3a/M8pqjUVxiYjNF1YilzSHGN7+HL5h21jX
	wjOEbT27qDAzHJ38DYB2i1oN9xxOsfvxIuPk9haekVMhpd1YG8wwDaC+PyO4li9O
	KGR00D93F+aNUchK0d3xk+Nk78Kw9yaoQdUSx6HaTmaR4hq3KqjvSxiuGCIxeqMn
	snxIpk0SGnbvcXeLheYELn/4FosG6ex8x8XpMbwjE4fmTkM7pYIPXByof3mJWuV+
	Ln3FQ==
X-ME-Sender: <xms:PoRUagT_9i40ZvZgknbtHj4j_F6zCAzIZFkh0T1ts61cDClTmZ7QYA>
    <xme:PoRUamOHu8DevTMx3BA1JyqodGlhXQB4FSW6NzinCcz1QH-RiV8W-VJ7jAHsFaCDg
    FL-UuZw8MfhRq6poQfUsthlJWFeHhOHXAF9Llf1NYuY8XGVSw>
X-ME-Received: <xmr:PoRUauQGrRidnKMOaFP0ALnavA1GSRwoANxYEepeILhfoyrY4gyKjw8OM6PZRJtlmLL9rVx2PTme_Uy-P50ZbQ02O_N6Zo8>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzom
    K+BC2EOMFMiKU/g6Y4yJWGDI+McVsKxvtNg6pzEP/ePPUDgulNE1Oq0v9UMK6zUDttvX0w
    dGho/6qpLpxES2SBD01JCw8BUp9g9RKwdCffuR8taM3zTO74SATaWDfflMFG2TMUqvna7p
    hAttE8bYy/sKinKSQ+fYmgoszeOo0V121sx5ZPbEkuFQz1KFOW9Q25dEfQWpes7XtpT4YQ
    68fsUGlfExPGXa+gPAAZCop0L5eWKdcfxDln8iOvjOO05ZKs/toXE4LgnQQNKwOdssYoxc
    My+qdMxV53ntD5tkK8d9Ul8tDJ583aDu4JAMzaYtaNxQ4UBdieQsrDOjyoig
X-ME-Proxy: <xmx:PoRUakiWgm5JKviRfLSNyUgswSf8j0sO0kzZN5tiBlk3el4ehelZsQ>
    <xmx:PoRUan_LLuqM6Uw_iPLoP8MwXG6y9P0WrXvr0qoPo4pXbbfKEggGJA>
    <xmx:PoRUarE13YlTqNCBs1F7AoXZ_Rl06sqjmoRcHADMAdIUVqyJ65tiJw>
    <xmx:PoRUaqnmZm2JUqeBXgf3Wd0TJVlqw6mIp2SWUnbIoENraw4Do2xoNA>
    <xmx:P4RUalffB0aSu8uDsZ4GPc49KcBnvKCJlGxPgN7gwUJj859RMWpF4rgW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:52 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/17] nfsd: move fh_want_write() after preamble in nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:27 +1000
Message-ID: <20260713062219.6399-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23287-lists,linux-nfs=lfdr.de];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2C5C7477F1

From: NeilBrown <neil@brown.name>

As part of separating the nfsd-specific code from the VFS interaction
code in nfsd4_create_file(), move fh_want_write() to just before we need
it.

Consequently errors in the "if" statement that this code is moved over
can now be returned immediately rather than needing to "goto out".

Also restructure that "if" statement to only test is_create_with_attrs()
once.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3e5c1fdde57b..443ed535e092 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -299,22 +299,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			dput(child);
 	}
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
-
-	if (open->op_acl) {
+	if (!is_create_with_attrs(open)) {
+		/* No attrs to check */
+	} else if (open->op_acl) {
 		if (open->op_dpacl || open->op_pacl) {
-			status = nfserr_inval;
-			goto out;
+			/* Cannot specify both NFSv4 and Posix ACLs */
+			return nfserr_inval;
 		}
-		if (is_create_with_attrs(open)) {
-			status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
+		status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
 						   &attrs);
-			if (status)
-				goto out;
-		}
-	} else if (is_create_with_attrs(open)) {
+		if (status)
+			return status;
+	} else {
 		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
 		attrs.na_dpacl = open->op_dpacl;
 		attrs.na_pacl = open->op_pacl;
@@ -322,6 +318,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
+	host_err = fh_want_write(fhp);
+	if (host_err) {
+		status = nfserrno(host_err);
+		goto out_free;
+	}
+
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
@@ -438,8 +440,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
-	nfsd_attrs_free(&attrs);
 	fh_drop_write(fhp);
+out_free:
+	nfsd_attrs_free(&attrs);
 	return status;
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


