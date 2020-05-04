Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05E1C41E2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgEDROn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 13:14:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730560AbgEDROm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 13:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXoRvADW59uS/gK1qR8SvIanK/aj5hYdLyqR/uzhDKM=;
        b=OEfUXtRb3dyKwMttefNH7XCgZWHhPnnV+NFDN1UjMd4f5kmk9iTjqNmsHFDLiCbJdKsxwo
        mC6DTVAGWee4VT5j0j74HBjo/R8GDH27h+a5sQuajOimehOFTlXS10FokuXceknweyd4kS
        pEOMIAogFXk5u4WPFIjb8pOpvZMbE3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-5TO57NPjPNCvBOk26NFs-g-1; Mon, 04 May 2020 13:14:40 -0400
X-MC-Unique: 5TO57NPjPNCvBOk26NFs-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28102460;
        Mon,  4 May 2020 17:14:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2DB41000322;
        Mon,  4 May 2020 17:14:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 47/61] afs: Remove afs_zero_fid as it's not used
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:14:35 +0100
Message-ID: <158861247513.340223.16370838447904994269.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove afs_zero_fid as it's not used.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/yfsclient.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index b5b45c57e1b1..7f419f8bb943 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -15,8 +15,6 @@
 #include "xdr_fs.h"
 #include "protocol_yfs.h"
 
-static const struct afs_fid afs_zero_fid;
-
 static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
 {
 	call->cbi = afs_get_cb_interest(cbi);


