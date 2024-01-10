Return-Path: <linux-nfs+bounces-1023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7E82A320
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 22:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6AF1C22A6E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723294F61D;
	Wed, 10 Jan 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GD1Qp3dz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23F4F5EA
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704921111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gbbBO9lNpJR0MfDA9zvC1wgSIs185cCcwjZiJnDa0wI=;
	b=GD1Qp3dz0kSWpPMIFetsuV5rG5JPGfCrbNIXV1IssPkXuKjkTsVVv+3Sh38GsNQmGQ2lAi
	ziO2zS8/lJ/iGQaw8XiUhOCXor7h4P9E/lpcw+cMbD/ftIgfWnbb0dNu8YNgaLOXoCdXiG
	YfWcoGyv6VxjEIRrp/e59MHSd+zC3+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-OxrgtCRHNg-my24eDO2Ukg-1; Wed, 10 Jan 2024 16:11:45 -0500
X-MC-Unique: OxrgtCRHNg-my24eDO2Ukg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 421108371C0;
	Wed, 10 Jan 2024 21:11:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 795C61121306;
	Wed, 10 Jan 2024 21:11:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
    Edward Adam Davis <eadavis@qq.com>,
    Pengfei Xu <pengfei.xu@intel.com>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Jeffrey E Altman <jaltman@auristor.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
    Steve French <smfrench@gmail.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] keys, dns: Fix size check of V1 server-list header
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1850030.1704921100.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2024 21:11:40 +0000
Message-ID: <1850031.1704921100@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

    =

Fix the size check added to dns_resolver_preparse() for the V1 server-list
header so that it doesn't give EINVAL if the size supplied is the same as
the size of the header struct (which should be valid).

This can be tested with:

        echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p

which will give "add_key: Invalid argument" without this fix.

Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list =
header")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Edward Adam Davis <eadavis@qq.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Simon Horman <horms@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jeffrey E Altman <jaltman@auristor.com>
Cc: Wang Lei <wang840925@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: Steve French <sfrench@us.ibm.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/dns_resolver/dns_key.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index f18ca02aa95a..c42ddd85ff1f 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *pr=
ep)
 		const struct dns_server_list_v1_header *v1;
 =

 		/* It may be a server list. */
-		if (datalen <=3D sizeof(*v1))
+		if (datalen < sizeof(*v1))
 			return -EINVAL;
 =

 		v1 =3D (const struct dns_server_list_v1_header *)data;


