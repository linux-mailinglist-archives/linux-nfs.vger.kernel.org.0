Return-Path: <linux-nfs+bounces-20425-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BTKC+8VxWnr6QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20425-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:18:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98933448C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35ED630FEFB8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065913CE4B8;
	Thu, 26 Mar 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i63Rbd02"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507B3C5DBB
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523443; cv=none; b=Qgb3134Ezu2kLisIIcxb3GeGrqBYovyhkAaR7/bcM/0j5PAdtebTdDnhhOqA8ZReegAb6XUywtKBziuvdfbqWB9E5L6n1A+RzivBfrmew29YaXzGh7armacIPZwi1WOTK6b9+lxlCbKVHUtkjhEyQY7ylbdIw5OpbcXKz+HNjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523443; c=relaxed/simple;
	bh=jBdoDVkrHo4frDWBxHqqyQ2bl1+2xzRX8rlOxpufM+I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X2T0Tx1YjgBVFAzG0Kxj+/E/ymzIwynTFluuPMy2MjIJOB1jX5DbTQbofAv36nX4rePnfiAWQqYsHkl/21XoEvsHZp9CRMLSKezLJG/kbn6Npye8w2WdJEWbYl8jQRfz8hqpD9oQbIxyx1DN8Ae7fYl3n00OeJX+UqxuPtpj2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i63Rbd02; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774523441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXxdqkbQLA4ehuUOQdRt5Ygk7PCXPrYtxEdT8qB7Hzo=;
	b=i63Rbd02TWSXj+m2WB/KrirfAPMZ4KVew99bNWPNQk7NHkYsxJr0qOzXjC4Hz38iHEwJxj
	h8qZ5jVMkLqGuaZ4TMuX41g5869fpYRf8kKcGzfQmeu9MOaL2kwKM/iD69dbRfGcFxdWsJ
	//CYBFKtlkP6HsAN9c/GgIFsRbjiEYY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-bIDBd2wNPAC8eDxXKK0CqQ-1; Thu,
 26 Mar 2026 07:10:37 -0400
X-MC-Unique: bIDBd2wNPAC8eDxXKK0CqQ-1
X-Mimecast-MFC-AGG-ID: bIDBd2wNPAC8eDxXKK0CqQ_1774523434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DEE71955D5B;
	Thu, 26 Mar 2026 11:10:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E68F18001FE;
	Thu, 26 Mar 2026 11:10:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com>
References: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com> <20260326104544.509518-1-dhowells@redhat.com> <20260326104544.509518-8-dhowells@redhat.com>
To: Aditya <dev@adityakammati.me>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    NeilBrown <neil@brown.name>, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510330.1774523425.1@warthog.procyon.org.uk>
Date: Thu, 26 Mar 2026 11:10:25 +0000
Message-ID: <510331.1774523425@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name,manguebit.org];
	TAGGED_FROM(0.00)[bounces-20425-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,adityakammati.me:email]
X-Rspamd-Queue-Id: 9E98933448C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Aditya <dev@adityakammati.me> wrote:

> Why are this bulk fixes

I'm not sure what you're asking.  Are you wanting to know why the series
begins with a collection of fix patches?  If so, it's because the main patches
(08-26) are dependent on them being applied first.

David


