Return-Path: <linux-nfs+bounces-20714-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ORUGY4h1WnK1AcAu9opvQ
	(envelope-from <linux-nfs+bounces-20714-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 17:23:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7313B0EB2
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1405C302CD3C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550736CDEC;
	Tue,  7 Apr 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b="OUSMpx5Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-195.mimecast.com (eu-smtp-delivery-195.mimecast.com [185.58.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEEC36BCC0
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575246; cv=none; b=ikX5RsSfia+Iox8n6XtGEE89rgAxdySJyMlnjh7LuebvVVZ7X6ilYP02xgfkgKMuf+1PZ9Uqd4rVQfVDiNl6xeMKWuu2KHDNtNvacLInkXVRZyPu6y+T5WItZlbYllRd/0IA+DkG9tw+xbvgwbyXkVGl8lxUuKyLBoTjgnx/JZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575246; c=relaxed/simple;
	bh=0eL1cnf65TinsP1uE/WwsmI95PT1mCWxkfpiMdnA6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=P9hlZrPRh7pSADLTlrDtaOo7h9kYfB/P6DAjA9UXocYaILZFHMGDlVpIJR4WXw3NEJkSgZlpkjj+2Gw44jlKg5XN9wJ99Qi/YpmFcS4VCfYBpmfPMv6Ya/0mnP8yF5ugkvr6vmBIg/plXLZyfteYbYlhQ6dBzCWcTH9qLvplUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com; spf=pass smtp.mailfrom=gsacapital.com; dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b=OUSMpx5Z; arc=none smtp.client-ip=185.58.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gsacapital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gsacapital.com;
	s=mimecast20170115; t=1775575238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=flQeClaAL5qkomrVB4gXfsAdmOzzoZ+NQ5fJigp5WRA=;
	b=OUSMpx5Zh9bAfvsplXVDQNnQKOJ/kZ2I1zTwGwDTKIftz193gNb9TBYftQ+F/DA48EIUE3
	kWnjH5oRkstgFT7ld4/Uk8t4fiKbssKnM7ydopELtyLUR1jELdVs/4yQfEbgru13hB5pK5
	iek4fet12OZXroT8vFzvmcYjuYnu0CM=
Received: from mailrelay.gsacapital.com (185.137.2.10 [185.137.2.10]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-318-_Eyn6bblPgWgxYcCaUZxmg-1; Tue,
 07 Apr 2026 16:20:37 +0100
X-MC-Unique: _Eyn6bblPgWgxYcCaUZxmg-1
X-Mimecast-MFC-AGG-ID: _Eyn6bblPgWgxYcCaUZxmg_1775575237
From: Ben Roberts <ben.roberts@gsacapital.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Roberts <ben.roberts@gsacapital.com>
Subject: [PATCH] pNFS: deadlock in pnfs_send_layoutreturn
Date: Tue,  7 Apr 2026 16:20:35 +0100
Message-ID: <20260407152035.4034628-1-ben.roberts@gsacapital.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7akriI51wmC0N9VQhAzl01ykcTIZFkdSLNI5w_VavKA_1775575237
X-Mimecast-Originator: gsacapital.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gsacapital.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gsacapital.com:s=mimecast20170115];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20714-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.roberts@gsacapital.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gsacapital.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE7313B0EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies, resending due to improper mail client settings on earlier
attempts.

On a HPC cluster running 5.14.0-611.9.1.el9.x86_64, regular deadlocks were =
seen
within pnfs_send_layoutreturn leading to userspace processes stuck in
uninterruptible sleep, ultimately requiring reboots to clear. This was occu=
rring
frequently, sometimes multiple times per day on specific hosts with heavy l=
oad.
Claude code was tasked with hunting down any potential deadlocks within
pnfs_send_layoutreturn, and identified the following condition. This patch =
has
been running in production on top of the EL9 kernel for over three months
without any reoccurrence of the deadlock.

The pnfs_send_layoutreturn() function can deadlock when memory
allocation fails. The issue occurs in the error path where
pnfs_put_layout_hdr() is called, which may trigger
pnfs_layoutreturn_before_put_layout_hdr(), potentially causing
a recursive call back to pnfs_send_layoutreturn().

Call chain that triggers the deadlock:
1. pnfs_send_layoutreturn() - kzalloc() fails
2. Error path calls pnfs_put_layout_hdr(lo)
3. pnfs_put_layout_hdr() calls pnfs_layoutreturn_before_put_layout_hdr()
4. If NFS_LAYOUT_RETURN_REQUESTED is still set, attempts another
   layoutreturn, creating recursion/deadlock

The fix ensures that NFS_LAYOUT_RETURN_REQUESTED is cleared in the
allocation failure path before calling pnfs_put_layout_hdr(). This
prevents pnfs_layoutreturn_before_put_layout_hdr() from attempting
another layout return, breaking the recursion cycle.

Signed-off-by: Ben Roberts <ben.roberts@gsacapital.com>
Assisted-by: Claude:claude-sonnet-4-5
---
 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index bc13d1e69449..47bda53b2b3a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1361,6 +1361,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 =09if (unlikely(lrp =3D=3D NULL)) {
 =09=09status =3D -ENOMEM;
 =09=09spin_lock(&ino->i_lock);
+=09=09pnfs_clear_layoutreturn_info(lo)
 =09=09pnfs_clear_layoutreturn_waitbit(lo);
 =09=09spin_unlock(&ino->i_lock);
 =09=09put_cred(cred);
--
2.43.0

For details of how GSA uses your personal information, please see our Priva=
cy Notice here: https://www.gsacapital.com/privacy-notice=20

This email and any files transmitted with it contain confidential and propr=
ietary information and is solely for the use of the intended recipient.
If you are not the intended recipient please return the email to the sender=
 and delete it from your computer and you must not use, disclose, distribut=
e, copy, print or rely on this email or its contents.
This communication is for informational purposes only.
It is not intended as an offer or solicitation for the purchase or sale of =
any financial instrument or as an official confirmation of any transaction.
Any comments or statements made herein do not necessarily reflect those of =
GSA Capital.
GSA Capital Partners LLP is authorised and regulated by the Financial Condu=
ct Authority and is registered in England and Wales at Stratton House, 5 St=
ratton Street, London W1J 8LA, number OC309261.
GSA Capital Services Limited is registered in England and Wales at the same=
 address, number 5320529.


