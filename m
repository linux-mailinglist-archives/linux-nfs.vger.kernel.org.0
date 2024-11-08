Return-Path: <linux-nfs+bounces-7769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DA9C238B
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 18:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768081C22C04
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDEB20B806;
	Fri,  8 Nov 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5CQPV1l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6D20B802
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087282; cv=none; b=Z4x/WxvZzQwBiRpRGiI5UOStg/nuziVaBUbjtPYwLORQvCAH2sNvIbiQBbnvPC2adYqYQTTQ756J5oktgpOYsaBHB218EYr7K2oWzbF2P67FqP0WfpsdnoJqZMWmCc0DIptRKbAUL/2OH9K03iIxstCgc+6LjgozPY8psE9jdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087282; c=relaxed/simple;
	bh=5o211Bs9aPlGXgBOv9ZEWRYTJwfzYdkVK8vs4FoRbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHM5YRPx/exhCdN7yagy74yJGHC66B0ukTAFu6lfLtQG40LzupexSiEl9SN998YwQoT3yqNwctTz+JHaw0IOsHLb2mQiWNzYnggfHEwGHZWCl2/bYfvDYp017r0+W4te1I/3YR3YdnlQuNNA7CDJ0SyZzuxvs+oMq3AKFgtL1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5CQPV1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO1trrAUxh6ged928OSrE9rZIbGVfYli8k1F5yQtGbY=;
	b=Q5CQPV1lOd6FKp1kModSeIz43fSM9CmeetmNrFaPKZ7rYUASpj8UJeIX5VWMe1uiyJz6cg
	HX6EcBnrXWCwtexrlaVR0nHrUnzFu+ahhJvAiYJWljrNgukb3qlXs3tCblJw0gY6JEfnb8
	Vd+pP4S40Yc6PuuXp9/YAs8zVCgcIZ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-qOuK97hKMEujosWEowMyUg-1; Fri,
 08 Nov 2024 12:34:38 -0500
X-MC-Unique: qOuK97hKMEujosWEowMyUg-1
X-Mimecast-MFC-AGG-ID: qOuK97hKMEujosWEowMyUg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 973B21955F43;
	Fri,  8 Nov 2024 17:34:34 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1545D3003B71;
	Fri,  8 Nov 2024 17:34:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/33] afs: Fix directory format encoding struct
Date: Fri,  8 Nov 2024 17:32:16 +0000
Message-ID: <20241108173236.1382366-16-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The AFS directory format structure, union afs_xdr_dir_block::meta, has too
many alloc counter slots declared and so pushes the hash table along and
over the data.  This doesn't cause a problem at the moment because I'm
currently ignoring the hash table and only using the correct number of
alloc_ctrs in the code anyway.  In future, however, I should start using
the hash table to try and speed up afs_lookup().

Fix this by using the correct constant to declare the counter array.

Fixes: 4ea219a839bf ("afs: Split the directory content defs into a header")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/xdr_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 8ca868164507..cc5f143d21a3 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -88,7 +88,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 


