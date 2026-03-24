Return-Path: <linux-nfs+bounces-20347-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDyoHrVEwmktbQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20347-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 09:00:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290A9304487
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 09:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C072318D942
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C7361DAC;
	Tue, 24 Mar 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Deed9SkT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1234E774
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338853; cv=none; b=t3mUp6/MLv38heH6GPMirA0k13gnJRC7Ha+xnv2POccJgCK4ghVRhOXfKbayDoZgt785VTeMx2hQO3QznA+1Ja/VQO1dWz7SMSEjyMzIbDEHM58Hokw1YpX9LHD66efTxhCmjVpqMO7Alm+FEdVMoqPCxSC2LhnVqTn9PDrjPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338853; c=relaxed/simple;
	bh=6blkyTe4IKh1y5rjLHOK//uXmgRh62lCozVVfSykuQM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qFdnjnB5plw3OijlMLwCkoY8lKLNosDIlBZtcq5bHWnFEV8vAUO7U2Pg+iGJaKFYUWAtCXdcK9/zRGPDjytCjJkHJOh8PswgrMkp/6Fc0F3a6+wai6PeQ3gA+NETWcPLMiA0DKtfOdOqSypHSBKsF5IIMR5Wz0UiAoSJjuhfPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Deed9SkT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774338841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw5eFbCUWOTNNMeHHB5r5m5Z9lKiPRYiRNr3rzILlRM=;
	b=Deed9SkT/9Xic8qChNdabITf7K05dBy4bZhw9yqLlHGj7QM5OJ8tg4uttaVvrUPqZQHgpf
	qQcsQkAaC15M2f+qdpmd60EEItV6SjfeK9wtyKFI/oystmz9iaFYON1SjscAZ10/KMpvu5
	KNKHu5iuVqCpGf+ZJtuZoINqLt8aM+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-D6gR2O3ZOmqMBO_yW9bgqQ-1; Tue,
 24 Mar 2026 03:53:58 -0400
X-MC-Unique: D6gR2O3ZOmqMBO_yW9bgqQ-1
X-Mimecast-MFC-AGG-ID: D6gR2O3ZOmqMBO_yW9bgqQ_1774338836
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 635C8195608A;
	Tue, 24 Mar 2026 07:53:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C96219560B1;
	Tue, 24 Mar 2026 07:53:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c456a6ce-c883-4631-a5c7-5d2255205546@chenxiaosong.com>
References: <c456a6ce-c883-4631-a5c7-5d2255205546@chenxiaosong.com> <a1949f85-2e92-429e-83eb-91a7691b9a9b@chenxiaosong.com> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-18-dhowells@redhat.com> <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com> <63655684a778145167a549b4a6251ccf@manguebit.org> <3597849.1774336571@warthog.procyon.org.uk>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <smfrench@gmail.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab the buffers on request
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3677110.1774338827.1@warthog.procyon.org.uk>
Date: Tue, 24 Mar 2026 07:53:47 +0000
Message-ID: <3677111.1774338827@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,infradead.org,kernel.dk,kernel.org,gmail.com,brauner.io,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20347-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[chenxiaosong.chenxiaosong.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,chenxiaosong.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 290A9304487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:

> `netfs_put_request()` only decrements the reference count by one, while
> `netfs_put_failed_request()` (refcout == 2) immediately frees the request by
> calling `netfs_free_request()`.
> 
> Since the `refcount == 2` after `netfs_create_write_req() ->
> netfs_alloc_request()`, on the failure path, calling `netfs_put_request()`
> will not free the request.
> 
> Please let me know if my understanding is incorrect.

Actually, yes.  You're correct.  Anyway, I've made the change and pushed it.

David


