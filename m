Return-Path: <linux-nfs+bounces-13860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592BB307A6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 23:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8618627C61
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140435E4D6;
	Thu, 21 Aug 2025 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlgcIeJK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04D35E4D4
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809018; cv=none; b=U+2X5S/zvQWRU0zX3lQVlG5h3m5L5wzXA4qTKEtJZgttfH8baQ0T8NOUjQVwjrwyBBqOeY1Q3spKYoNgNbbnszuWiYsuZa7dmq4DYCZTeZVjqeBzgccTyjMPhaTc4DPEJN5+5CHPqor+R4gswcmQ9mg8QI3uB1LSFHo/Vya4zqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809018; c=relaxed/simple;
	bh=s0g2BbnQ13Juqq/D1RUfpqvWITz8hhgElV5BIxJkVfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bXvkOE1tvca12x4saKqx97Z21NBrQ1pu74RrYqXscii844L4GdMDsOKTZupQUWCjJvjLrKjZgf+jv5lqby7/fbOA/SEpvZRtuSb+fYeoGSiXJoqMlYjkD3VOvcLo5jzrd4ZgA30m2R1lGaaoT7DacHcLifD3JxB4BcbsSXQvSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlgcIeJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNXSCOfMRdaFEXJJcn10Ligb4AprN+rc4jzlwCUKiKE=;
	b=hlgcIeJKe0huFn2ZvnGNxtcYZAad8bgueok3XTZYrMFhNg6aZnNM89rEsWFAh2oo5LdY76
	s/MT/b4tZQKCIfZpRqFMTm1plSp+vBhOG5nmUrGtFHpCu6auT6ZKl+c5sxicZzIxtkhFcD
	gO19eOLIJ+WdXfl2Vx9JNBKM3kw2LNk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-nFZgoMKIPqOZk0QSHRmNtw-1; Thu,
 21 Aug 2025 16:43:32 -0400
X-MC-Unique: nFZgoMKIPqOZk0QSHRmNtw-1
X-Mimecast-MFC-AGG-ID: nFZgoMKIPqOZk0QSHRmNtw_1755809011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D47571800446;
	Thu, 21 Aug 2025 20:43:30 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.163])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7365519560B0;
	Thu, 21 Aug 2025 20:43:29 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after listener removal
Date: Thu, 21 Aug 2025 16:43:28 -0400
Message-Id: <20250821204328.89218-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch tries to address the following failure:
nfsdctl threads 0
nfsdctl listener +rdma::20049
nfsdctl listener +tcp::2049
nfsdctl listener -tcp::2049
nfsdctl: Error: Cannot assign requested address

The reason for the failure is due to the fact that socket cleanup only
happens in __svc_rdma_free() which is a deferred work triggers when an
rdma transport is destroyed. To remove a listener nfsdctl is forced to
first remove all transports via svc_xprt_destroy_all() and then re-add
the ones that are left. Due to the fact that there isn't a way to
delete a particular entry from a list where permanent sockets are
stored. Going back to the deferred work done in __svc_rdma_free(), the
work might not get to run before nfsd_nl_listener_set_doit() creates
the new transports. As a result, it finds that something is still
listening of the rdma port and rdma_bind_addr() fails.

Proposed solution is to add a delay after svc_xprt_destroy_all() to
allow for the deferred work to run.

--- Is the chosen value of 1s enough to ensure socket goes away?
I can't guarantee that.

--- Alternatives that i can think of:
(1) to go back to listener removal approach that added removal of
entry to the llist api. That would not require a removal of all
transport causing this problem to occur. Earlier it was preferred
not to change llist api.
(2) some method of checking that all deferred work occuring in
svc_xprt_destroy_all() completed.

Fixes: d093c90892607 ("nfsd: fix management of listener transports")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dd3267b4c203..f9f5670abcc3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1998,8 +1998,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 * Since we can't delete an arbitrary llist entry, destroy the
 	 * remaining listeners and recreate the list.
 	 */
-	if (delete)
+	if (delete) {
 		svc_xprt_destroy_all(serv, net, false);
+		ssleep(1);
+	}
 
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-- 
2.47.1


