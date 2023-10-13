Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C67C8970
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjJMQAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjJMP76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 11:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62EE100
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697212677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdTOgUT9KIMzQnxrll+Ln7vU3lh7L6xf921vj9gXc+g=;
        b=ZRH2vCG/SCActWU3GPxQr2VQ6vJzWrmMJAjFprzndfBYPhdIMlBlYgen+HRVcsICtD0ml4
        e4iPjWXb0JMTNLGpAkAttftzEVn4D6aB4uOb0xCe4KstFM5h0rH/ZmJn4oq+jjeONMPvmY
        GMmXPkxL23IBSA+dy+zCH8CECCaFbOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-sPJ3XQAXMnmyAp7uFZgrmw-1; Fri, 13 Oct 2023 11:57:43 -0400
X-MC-Unique: sPJ3XQAXMnmyAp7uFZgrmw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 591821029F45;
        Fri, 13 Oct 2023 15:57:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58C2492BD9;
        Fri, 13 Oct 2023 15:57:39 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH 03/53] netfs: Note nonblockingness in the netfs_io_request struct
Date:   Fri, 13 Oct 2023 16:56:36 +0100
Message-ID: <20231013155727.2217781-4-dhowells@redhat.com>
In-Reply-To: <20231013155727.2217781-1-dhowells@redhat.com>
References: <20231013155727.2217781-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Allow O_NONBLOCK to be noted in the netfs_io_request struct.  Also add a
flag, NETFS_RREQ_BLOCKED to record if we did block.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/objects.c    | 2 ++
 include/linux/netfs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 85f428fc52e6..e41f9fc9bdd2 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -37,6 +37,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (file && file->f_flags & O_NONBLOCK)
+		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 282511090ead..b92e982ac4a0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -205,6 +205,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
+#define NETFS_RREQ_NONBLOCK		6	/* Don't block if possible (O_NONBLOCK) */
+#define NETFS_RREQ_BLOCKED		7	/* We blocked */
 	const struct netfs_request_ops *netfs_ops;
 };
 

