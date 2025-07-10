Return-Path: <linux-nfs+bounces-12976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC6AFFF95
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2652F1C2810E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311F2DFF22;
	Thu, 10 Jul 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6pQqkVU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7842E4244
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144446; cv=none; b=L5NZMaAmv8bNBUgK2k9v3lb2kSDFpn5Y55zDssU5QdGcuxl8NUasewtpKK+4JBhgIg9ZNj+hb6+oCqRGmnCPmVYBIM82og5PKZp7DVdYHZm9mYSfbgUixNVM1iXAVTJpVVzLcAiE3D1UjWZ9f5DVMLtAMnvRbWjE9SiNwg2XlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144446; c=relaxed/simple;
	bh=SOep39LCruQJ5eUJmcxYU0zPt7Rxb5VZwOl88D+y7tQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mZI45nM/x2lWvsSUJCX+o0bAonupiNFEEneGDzLet9MTrJynFMNb294YvTeeRC1Wnybi2AHd4D9pdsyzE9R7SCW3+xO6xVyjB6XRO/CoY0bC6HX8nbM57Idc2EOhxToRtuIbOU82Ygkss1wm0wDPduq6Dj4R7Ek5e5sueAYEBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6pQqkVU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752144441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0u3HIoTZyqgg631O8XZeTrysi+dlK3ZJXgoQ/uYQ84=;
	b=M6pQqkVUjXLt8jAm1W1xwtsgv9dDSkLO2XCIiyPHeT6kquZor1gtjqIDr8w4n6fV197Qws
	ILZzU/mDzvqI2prN4tUIVmQWVyBVFW+LWjWx78GCXrav+0+G7jogYv0e+EdO2gLJYYEUth
	QR5AsgFUfZZvJDKJ+6RQxPv0yD7eNv0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-Qs5apeF0MfKwPreNiR2KRQ-1; Thu,
 10 Jul 2025 06:47:16 -0400
X-MC-Unique: Qs5apeF0MfKwPreNiR2KRQ-1
X-Mimecast-MFC-AGG-ID: Qs5apeF0MfKwPreNiR2KRQ_1752144434
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D985519560B0;
	Thu, 10 Jul 2025 10:47:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 488C719373D8;
	Thu, 10 Jul 2025 10:47:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
References: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com> <2738562.1752092552@warthog.procyon.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2807749.1752144428.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 11:47:08 +0100
Message-ID: <2807750.1752144428@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Max,

I managed to reproduce it on my test machine with ceph + fscache.

Does this fix the problem for you?

David
---
netfs: Fix copy-to-cache so that it performs collection with ceph+fscache

The netfs copy-to-cache that is used by Ceph with local caching sets up a
new request to write data just read to the cache.  The request is started
and then left to look after itself whilst the app continues.  The request
gets notified by the backing fs upon completion of the async DIO write, bu=
t
then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
set - but the app isn't waiting there, and so the request just hangs.

Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
notification from the backing filesystem to put the collection onto a work
queue instead.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use =
one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=3DshxyGLwfe-L=
7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/read_pgpriv2.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 5bbe906a551d..080d2a6a51d9 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -110,6 +110,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_co=
py_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 =

+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache =3D creq;


