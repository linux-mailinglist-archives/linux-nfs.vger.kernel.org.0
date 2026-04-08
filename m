Return-Path: <linux-nfs+bounces-20728-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPuRLvBJ1mkFDQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20728-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:28:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2723BC0B3
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E18FF302882A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7A38E137;
	Wed,  8 Apr 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b="PYhuN698"
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-195.mimecast.com (eu-smtp-delivery-195.mimecast.com [185.58.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBD3B2FF4
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651141; cv=none; b=YfGIXjnnOgw2q6T+dQiAat9UXhcvKKh0YO6glW0hRSs4lOpcYgenNE+Vq4IIixjXNTEpDWnB1vJNvn1zg6O+lRLBNMelrV/z9ndsDMU0y01slDTrMGReOuK5/mH8LxQtHbDVMd2a4ksOa8gFBCM79HfcslId7sYFYe//+ShAlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651141; c=relaxed/simple;
	bh=KgkHDIasxTeXcn7HRDJqn85eeKrkI/LPrh8KerUyjo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=m0gGfrNzPYk05GyG4kqvSHGMe7jem3hnq+mFUZPa6sQmUtfWX1swGPSFaYkOTcSPk9ivpnanpjTFBvGQWYL3VOD9713QkegnYuxt4CSGWLJh+hFP68rg8sOOYA0opOjxndin0HQ9R+YrWgLjbqu4GekswORnSsWOd2O0Oa0Pdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com; spf=pass smtp.mailfrom=gsacapital.com; dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b=PYhuN698; arc=none smtp.client-ip=185.58.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gsacapital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gsacapital.com;
	s=mimecast20170115; t=1775651138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pA6JSSXruoG86BKvfFrK8RVyO5q3iZzBKQFZTViRdek=;
	b=PYhuN6984VyGVtXL82agMMn19Vor6MBQN41xiBop0kDZ3l5Yd7dFkOKPjbeEV12FRlWFdE
	TOfbzQyFq8bE92bwl3n6VA3DVdAR4L7g24HacAcPUN/WzzcaGb9A5j02whEfXa3Vmmvjkk
	b4pWbIhNqDnQATeFiKspc9XQmsIQF74=
Received: from mailrelay.gsacapital.com (185.137.2.10 [185.137.2.10]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-232-6vlBw8mSN4Gwbroja8tsug-1; Wed,
 08 Apr 2026 13:25:36 +0100
X-MC-Unique: 6vlBw8mSN4Gwbroja8tsug-1
X-Mimecast-MFC-AGG-ID: 6vlBw8mSN4Gwbroja8tsug_1775651136
From: Ben Roberts <ben.roberts@gsacapital.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Roberts <ben.roberts@gsacapital.com>
Subject: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Date: Wed,  8 Apr 2026 13:25:34 +0100
Message-ID: <20260408122534.537816-1-ben.roberts@gsacapital.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PcumioIKYcRumdFcVYKzqsxgcRbLWHRZpzCVtYsDkLM_1775651136
X-Mimecast-Originator: gsacapital.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gsacapital.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gsacapital.com:s=mimecast20170115];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20728-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C2723BC0B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On a HPC cluster running 5.14.0-611.9.1.el9.x86_64, regular deadlocks were
seen within pnfs_send_layoutreturn leading to userspace processes stuck in
uninterruptible sleep, ultimately requiring reboots to clear. This was
occurring frequently, sometimes multiple times per day on specific hosts
with heavy load.  Claude code was tasked with hunting down any potential
deadlocks within pnfs_send_layoutreturn, and identified the following
condition. This patch has been running in production on top of the EL9
kernel for over three months without any reoccurrence of the deadlock.

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

v2 fixes a syntax error introduced while composing the original mail.

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
+=09=09pnfs_clear_layoutreturn_info(lo);
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


