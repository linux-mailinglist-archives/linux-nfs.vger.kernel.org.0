Return-Path: <linux-nfs+bounces-20513-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I9dFGFWymn27gUAu9opvQ
	(envelope-from <linux-nfs+bounces-20513-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 12:54:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B75359BCB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F01973012BF8
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74731FF5E3;
	Mon, 30 Mar 2026 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2IJxvJW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122172623
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867803; cv=none; b=WVin2So7Kr4b3VEoKavOxcqF/Drczz4tGj/A/PrIVjmvBfLtqNPlnVQLJxB01beAgA4fyeLImJGEe00+qwBL15Dcgb+FYEIeU4grVwi2Z+gNp5VEFGZ6Hf6Fpcnsm5Ohc1wRh/0kMSCrfxapjtD2k/oeH6jvvBFDJCPW6DwNMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867803; c=relaxed/simple;
	bh=O5rjj0AsnkbLRLrZU050r9pTFp4OgaTs2V8lxweiJpQ=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=YeuEdJJatcypHKMQScWhvUjAr7osGvlzEf6doHGvyFfpOqNP7nA4sPIZvhR6l3NjWCUNJg+sKfrISWrTf6PgOtqsf9VWsoqVk0+97msTAf18zfQEzvRcCPYOr44C2ZROb2Ll4enHCe7pq+RYuxSpS+dBo0m473lB+7fEbEqM3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2IJxvJW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774867801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOQZbvZuSo6Y8bQBNAYlaEet3lfPqVfW+sXL8vzvXhA=;
	b=b2IJxvJWBvsXSbyERMjuutsmuMCtHm2OQokXV1ZeHjwf1UWobMPN/6ZaAUR3DyxhUQApxg
	+Wn6dWXGuqNQKSHhrRIHwoUL/DqfG3vN/2rf7jfQcb+4Er4Lq21vo6bQRn8VADWXI7Lrab
	VUq5OJDT34na5rOgeWN3OnhFkmBKfRg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-JLNIgM7fPXu4cdrMLHIQ5w-1; Mon,
 30 Mar 2026 06:49:58 -0400
X-MC-Unique: JLNIgM7fPXu4cdrMLHIQ5w-1
X-Mimecast-MFC-AGG-ID: JLNIgM7fPXu4cdrMLHIQ5w_1774867795
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30281944F11;
	Mon, 30 Mar 2026 10:49:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 543211955D84;
	Mon, 30 Mar 2026 10:49:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org>
References: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org> <20260326104544.509518-1-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Christoph Hellwig <hch@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
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
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] netfs: Keep track of folios in a segmented bio_vec[] chain
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1005366.1774861048.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Mar 2026 11:49:41 +0100
Message-ID: <1180465.1774867781@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,gmail.com,kernel.org,manguebit.com,kernel.dk,samba.org,chenxiaosong.com,auristor.com,codewreck.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-20513-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samba.org:email]
X-Rspamd-Queue-Id: 05B75359BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stefan Metzmacher <metze@samba.org> wrote:

> Another possible way would be to skip this for now
> cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_=
rdma()
> and I rebase my changes on top of Davids patches assuming they
> will be stable commits (at least up to
> cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma())

I could certainly split my removal patch.  I want to remove FOLIOQ support=
,
but I can leave KVEC and/or BVEC if they're still needed.

David


