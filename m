Return-Path: <linux-nfs+bounces-23292-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIx8OF2EVGpjmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23292-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E674780D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=M4PY1hb9;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=oKJeY5hg;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23292-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23292-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCAC930086E1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44589363083;
	Mon, 13 Jul 2026 06:23:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE0361DC3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923802; cv=none; b=kU+cpA2KVAu3bo2zqqBOr++KvM4HMeG3nd1ThkqEHoaTtg2Ne+IA1Ezx8+ezeBazVyz9MqxiDkvnj2A/u0ZGAy1h3e/0S8dl9LWh4krBu8V1ufAfM2zjQPT6KNiLI6NI6u4WcBuymfcLR0w5IqgPmLcMm7HJRelBmTi92k28/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923802; c=relaxed/simple;
	bh=b3DL1SKhHDJkJp/8g4EEctvEd8fOTmwvZ+f0AWn/Kjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYrhVOxbcH7DhYLUSg+eT6xke/mPWWYqdWpY3+p+glKwum+XbIQBmkLVVHlOBgh4SDaObbkD6uHYsqkudwQA7ypKRy3ReX29BGj+Vzrt5KUKEp2wHo5UxE7lv/pujgipK2gM70V7QirKzbStiWx+MidWHnuDrMkLW2w/sGQ9IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=M4PY1hb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKJeY5hg; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B43F1D00071;
	Mon, 13 Jul 2026 02:23:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jul 2026 02:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923799;
	 x=1784010199; bh=HsvtmKOKd4PeyAEaArVVgElyfYlIqeKK7nSsBHFp6Yk=; b=
	M4PY1hb91bKe0NPht6rXjf+zCp/x9LfX9lwmZE04/O/drKmgx8HOje0+4ilEB5VL
	tTgbxMfusAvYxX8dVMpeXAyw5qYzOXeTcT6nzdir1XzHFQjupzcDm8wU35v/soOq
	suaGM07fSiVwjmtl16wivpBksjjoUxaEaD0dFaqMpdtwIS6u3Ipzx13iB8hZ5x2x
	bNKDDWKCd2781N+MFs2azLGYgRG0ZagYLtDs8NA1BLK3iJEd0L2BqmNZG5wccDwj
	ZSfv0ft5evfwdrw9H5n9gkLNlzBdeIQfXP/3guBrkH4LocLGNEetMSYP2ecOi41v
	jEi+vfIBC7ISpGoiqBXxsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923799; x=1784010199; bh=H
	svtmKOKd4PeyAEaArVVgElyfYlIqeKK7nSsBHFp6Yk=; b=oKJeY5hgZB+Lb0HHU
	MLpVfmRkSVW5kHq+YGxouX+an+MILKKlf6z9WgXfD3LaDpt2t8rcJ6565eUuiKlr
	KuMdC3mkQxFWlsVK/IeNCsnhdo+KWlwwiHz2Yc/kbD6yv/rhapicvrySH0XcsNN0
	jX4qL+imfpWygFqNg9EsiPWrzLiaedqsZQJ08u/8zAEY3QIxWg6wPl1sDAVm83ZH
	+keAGa6PIpgEgyptCY7dWJegSSJZeJR72i1jJtNYKvPFPpBeieP17jCBBEX1TX6Z
	JJ5h5jy5cKbpTCpv1DxXpPmkx6tnBMymK8GTfW+EdiyETdTexae4wWbV8bAq+m5w
	DJ09w==
X-ME-Sender: <xms:V4RUaoMIM95c6tNa9gGrhuiF6MDM_slb0CiFo7UymB5TL7QfOR39fQ>
    <xme:V4RUaiqTld_A9385sd5e5bklegzSKHFfs-L7uuW6iDWij0MOYeRfpkvjnE5xRoPbL
    dDrBPikHLNG5U224aw6q9GDdnyLgxXhKP2QJYWlNwEo652Rxw>
X-ME-Received: <xmr:V4RUapG_YvR2lL8aSbhQIwBeW9_UsJ8KMUxlqXQbPQV4ZYGkYVCwzeYnCuvzWZyA2IAXgdMiQ4fLU_DJWvs1Z_URbkL8Uy4>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzJ+
    xMJJN6MxEuEvDfc4rHlqpAhnaUyqdtTbGvgT1wAPMI62/KuGnjL9FaB9ZN2RuM2Do1b66p
    Rp1cxj8niD1f3UGFBU/F5tKuyyFYFCZtViC66oGFIfJam6FueZxn88labaz6IGr7vTBfh7
    Zq2u4YFzYxVMTM8xw4k3rUFv77zIq4En79jLRXwTq+FhqA8pAr40J1mdV2Rur670gwuNip
    Z4BemE2oU+/Mq9KAkB4EnCG55ORaL3RgvTMwc0FAaI+7sWYxTcafV8ChsbNspU9TudM9mx
    uMOIrZkYM+eZxHtBEeNZCcE7yEWiMTvUJr5UswNCY3hFJSpEecCkfKavyXvA
X-ME-Proxy: <xmx:V4RUanpGwQFZ1rLIS7FTUPgGAW2BaSkQKO-DA3GtTk19oRSorF6RyA>
    <xmx:V4RUaiZtio_yG9aYWpt3cdkIu031mP6EgympbcMvBT3_rCG-_5PYkw>
    <xmx:V4RUagW8OJ5HGiQlLGPxCly3Zo0gg8ZVXdxWfY7DjIKi0KpLtST8cw>
    <xmx:V4RUar8CuQ8p9xhZngbtp8UzlYIV0EeFDbcyqT0K28l4x1oGtU94fg>
    <xmx:V4RUalt7JnhTMcbDT4V8F7nbxsXlMqKasemLn7GKkuco6cociPdQo9ZE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/17] nfsd: fh_want_write) failure need not be immediately fatal for  nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:32 +1000
Message-ID: <20260713062219.6399-10-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23292-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 440E674780D

From: NeilBrown <neil@brown.name>

If nfsd4_create_file() is asked to create a file, then failure to get
write access to the mount need not be fatal if the file already exists.
So we can delay handling the error until it is known if creation was
needed, just like with the error from testing for write permission in
parent.

This is similar to want_write error handling in lookup_open() in
fs/namei.c.

Note that getting mnt write access to support O_RDWR is handled
separately in do_dentry_open(), and op_truncate is handled in
do_open_permission(), so  nfsd doesn't need to be concerned
with these.  It only needs to be concerned with creation, and setattr.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 33c112eda4c4..7fb63d1836ba 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -261,7 +261,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status, create_status;
-	int host_err;
+	int want_write_err;
 
 	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -351,11 +351,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	create_status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
 
-	host_err = fh_want_write(fhp);
-	if (host_err) {
-		status = nfserrno(host_err);
-		goto out_free;
-	}
+	want_write_err = fh_want_write(fhp);
+	if (want_write_err)
+		/* Might still succeed if no create is needed */
+		create_status = nfserrno(want_write_err);
 
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
@@ -426,8 +425,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
-	fh_drop_write(fhp);
-out_free:
+	if (!want_write_err)
+		fh_drop_write(fhp);
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.50.0.107.gf914562f5916.dirty


