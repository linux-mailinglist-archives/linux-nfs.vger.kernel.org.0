Return-Path: <linux-nfs+bounces-22575-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fXTuOC4hMWq7cAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22575-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:10:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B88FC68DFCE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:10:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JxKEo+HE;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22575-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22575-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8216301E59C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22B42E018;
	Tue, 16 Jun 2026 10:09:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729942885F
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 10:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604570; cv=none; b=V3a+KK2vI4r6xa8aizgwBWmkUqfA0KEM0MnpCkV3jDTxVGmGMsWwTzOVfuLxnDu070sWBy31iqai5OAtyN/OithZ1ahY3eS1tbAWiQCDEznzkLSGyTzOBapiA8lg96dx3yqm7wRy6+GBqK8A1dgqjPLYkeBC345AwRy7CeIm3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604570; c=relaxed/simple;
	bh=LlyerzgyX+5L/7rCJl1ktSyZ72E37ZcqdGfNCyxOLPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyPB2vxFgpStpkR/ydzbMgTl8psPUYDFCkUT/BHlneZsQFQu5+Xtz+LFIZb15B3/Q1PiW/gaetNQxmy/9KijlDCaqmt/yOvweJDCJa4SJmvd/uIARaTLn1sADFN+yG8AY/qtgmCBVOb+1Exn0mwYLt1iosqsD2mdsVcUW686IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxKEo+HE; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSa5TnPIcX9KUvKuQ/n5zPtisGuhCJFsXdMJvHXniA=;
	b=JxKEo+HEFATCINZastzVWHNhQ5fvWFCwEyqF/VUN3ikVJ+AT6lJ7g1pC63ZLgXAapb5+F4
	S+L6GOlc5iqWPfiFgpj2qcq1GjUQDcfRooZ8ZBjktJMgvNxjqalE4Gj5bIWgOrABXDzqXg
	2ZWcDV3Sa2bBwTqL+SNGup9E9+dasNI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-Fc04VauUNHK95WnDhQ22vQ-1; Tue,
 16 Jun 2026 06:09:20 -0400
X-MC-Unique: Fc04VauUNHK95WnDhQ22vQ-1
X-Mimecast-MFC-AGG-ID: Fc04VauUNHK95WnDhQ22vQ_1781604558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C6BB19560BB;
	Tue, 16 Jun 2026 10:09:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C8421800586;
	Tue, 16 Jun 2026 10:09:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 05/30] iov_iter: Remove unused variable in kunit_iov_iter.c
Date: Tue, 16 Jun 2026 11:07:54 +0100
Message-ID: <20260616100821.2062304-6-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22575-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.lei@redhat.com,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,manguebit.org:email,infradead.org:email,linux.dev:email,kernel.dk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B88FC68DFCE

Remove the no longer used variable 'b' from iov_kunit_copy_to_bvec().  The
variable is initialised and incremented, but nothing now makes use of the
value.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ming Lei <ming.lei@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/tests/kunit_iov_iter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index f02f7b7aa796..e7e154f94f66 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -275,7 +275,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, b, patt;
+	int i, patt;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -298,10 +298,9 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
 	/* Build the expected image in the scratch buffer. */
-	b = 0;
 	patt = 0;
 	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
+	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
 		u8 *p = scratch + pr->page * PAGE_SIZE;
 
 		for (i = pr->from; i < pr->to; i++)


