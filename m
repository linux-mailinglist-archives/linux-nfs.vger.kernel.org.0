Return-Path: <linux-nfs+bounces-2720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551BB89C8FC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53411F22925
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66358144D1C;
	Mon,  8 Apr 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIeF1ebO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C71448DC
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591614; cv=none; b=T8iZQIizeHe3PRA9wXLyoNiKbrHa0gsIi/JSEFFfFVd9SUdee7MSOQqghGrbmKTfFsLN8C7S/t1Yk93HLOfZ2PFCJTzc+98T7ZEmfMqSZrdCrUpIdUeKfIgFullwRqy3WDgAggNfcEmDnJGBgaxWzfY+NjRKQTbeVd8YItTIoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591614; c=relaxed/simple;
	bh=c7hBMA4mXgWP8KpfW/frrWt9OAipSAHQsJKBjgulmnE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rqRRpZyNxsKWWfcRh9oXcs0Wx/NW2XSDNuyypuCDsmiaF+Kd5odbE1xTZ43q8xieORSzo8Aa/GvvuyOHp8Co16rmsxGnq/tHexAeZ7LNJwUEuVtCthJ4aa59d2oJI4v0HV2b0f7Ck+lPrzWDPYG5wb4nLgndg+dNQ6qx9RDoR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIeF1ebO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712591611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFuGX1yyoTN69ecCATsVj4UhORzkDiRUWoktVVAJ3+Q=;
	b=dIeF1ebOegZWiRj/ljFY2YixheQ4VmISq9HTLX90TmNq+gmo2ikIrzQD974z21YnE6oCJk
	XrepgMB6oAgHcMqGP2XPukcNfESDrrw1v3w0MrQnizCpPotRELZK5OOUMDqUTJhxWkSJdr
	voGeBYJxsuHLjOzHSEFKQ3awKNV0bhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-HJAhESVFMaKi_61YaghcgA-1; Mon, 08 Apr 2024 11:53:27 -0400
X-MC-Unique: HJAhESVFMaKi_61YaghcgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEA2C90ACC7;
	Mon,  8 Apr 2024 15:53:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 084C62033AC1;
	Mon,  8 Apr 2024 15:53:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-24-dhowells@redhat.com>
References: <20240328163424.2781320-24-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 23/26] netfs: Cut over to using new writeback code
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <877901.1712591597.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2024 16:53:17 +0100
Message-ID: <877902.1712591597@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

David Howells <dhowells@redhat.com> wrote:

> +		/* Wait for writeback to complete.  The writeback engine owns
> +		 * the info in folio->private and may change it until it
> +		 * removes the WB mark.
> +		 */
> +		if (folio_wait_writeback_killable(folio)) {
> +			ret =3D written ? -EINTR : -ERESTARTSYS;
> +			goto error_folio_unlock;
> +		}
> +

It turns out that this really kills performance with fio with as many jobs=
 as
cpus.  It's taking up to around 8x longer to complete a pwrite() on averag=
e
and perf shows a 30% of the CPU cycles are being spent in contention on th=
e
i_rwsem.

The reason this was added here is that writeback cannot take the folio loc=
k in
order to clean up folio->private without risking deadlock vs the truncatio=
n
routines (IIRC).

I can mitigate this by skipping the wait if folio->private is not set and =
if
we're not going to attach anything there (see attached).  Note that if
writeout is ongoing and there is nothing attached to ->private, then we sh=
ould
not be engaging write-streaming mode and attaching a new netfs_folio (and =
if
we did, we'd flush the page and wait for it anyway).

The other possibility is if we have a writeback group to set.  This only
applies to ceph for the moment and is something that will need dealing wit=
h
if/when ceph is made to use this code.

David
---

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1eff9413eb1b..279b296f8014 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -255,7 +255,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 		 * the info in folio->private and may change it until it
 		 * removes the WB mark.
 		 */
-		if (folio_wait_writeback_killable(folio)) {
+		if (folio_get_private(folio) &&
+		    folio_wait_writeback_killable(folio)) {
 			ret =3D written ? -EINTR : -ERESTARTSYS;
 			goto error_folio_unlock;
 		}


