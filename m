Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33AF3F5EF5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhHXN0C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 09:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237603AbhHXNZ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 09:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629811511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2Qta3tolraxtrizV7nWCzmHIjkmwUURhMGBy2rmL/A=;
        b=PSj7GBUJLqahCA6qs7z1cNPSvoh7IAUHpuWnMOnPQ6IazvR4/Ckd4AMXMBpzAUA1Tr3f4n
        j3r+6/Q1ndaDqJu540KIjsJvowXqXzgFVCTlry8SrdYzfSkrnDgJMiI5ZAVNF6pFdCkvu5
        vaF3G7cZfWH2Cr3qeo9McRFBRBHv/UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-Y926XhEaO66XEOrzBoN50Q-1; Tue, 24 Aug 2021 09:25:08 -0400
X-MC-Unique: Y926XhEaO66XEOrzBoN50Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 505201082921;
        Tue, 24 Aug 2021 13:25:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E6D60C05;
        Tue, 24 Aug 2021 13:24:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] folio: Add a function to change the private data attached
 to a folio
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:24:59 +0100
Message-ID: <162981149911.1901565.17776700811659843340.stgit@warthog.procyon.org.uk>
In-Reply-To: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
References: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a function, folio_change_private(), that will change the private data
attached to a folio, without the need to twiddle the private bit or the
refcount.  It assumes that folio_add_private() has already been called on
the page.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 include/linux/pagemap.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f55d8d9001a9..c8d336e62177 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -229,6 +229,25 @@ static inline void folio_attach_private(struct folio *folio, void *data)
 	folio_set_private(folio);
 }
 
+/**
+ * folio_change_private - Change private data on a folio.
+ * @folio: Folio to change the data on.
+ * @data: Data to set on the folio.
+ *
+ * Change the private data attached to a folio and return the old
+ * data.  The page must previously have had data attached and the data
+ * must be detached before the folio will be freed.
+ *
+ * Return: Data that was previously attached to the folio.
+ */
+static inline void *folio_change_private(struct folio *folio, void *data)
+{
+	void *old = folio_get_private(folio);
+
+	folio->private = data;
+	return old;
+}
+
 /**
  * folio_detach_private - Detach private data from a folio.
  * @folio: Folio to detach data from.


