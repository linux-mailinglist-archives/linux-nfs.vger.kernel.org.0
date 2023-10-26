Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1E7D8541
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjJZOwR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbjJZOwQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 10:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269651AE
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698331887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TQBD4l/5fg4IXQrIfGCOPl59M/3gquDSBE20dW3+18=;
        b=aYimpSlrqeruibpY11plRLdWNArAhIdeW0SEcYKdRU+I1KlM0Wk7bH7NkL9v0UbYCmuMHk
        v3pQ1PVAMsxSS7TvABtl/V6Uv3DlQzs0hymEjt4qAdfcWe2lUnOfmmY3rCy7vtMzCAXCS6
        DCdehxnkSl+Elz0ldrKRFFvhiM7pqic=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-Fi9T2LYyO2aZ3E8vZX5ciw-1; Thu,
 26 Oct 2023 10:51:22 -0400
X-MC-Unique: Fi9T2LYyO2aZ3E8vZX5ciw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF63628237D1;
        Thu, 26 Oct 2023 14:51:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EF121C060AE;
        Thu, 26 Oct 2023 14:51:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Oct 2023 16:50:21 +0200 (CEST)
Date:   Thu, 26 Oct 2023 16:50:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather than
 read_seqbegin_or_lock()
Message-ID: <20231026145018.GA19598@redhat.com>
References: <20231025163006.GA8279@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025163006.GA8279@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
is wrong. "seq" is always even and thus "or_lock" has no effect,
this code can never take ->writeverf_lock for writing.

I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
and nfsd_reset_write_verifier() is supposed to be very rare operation
so we do not need the adaptive locking in this case.

Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
without changing the behaviour.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/nfsd/nfssvc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..094b765c5397 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
  */
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 {
-	int seq = 0;
+	unsigned seq;
 
 	do {
-		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
+		seq = read_seqbegin(&nn->writeverf_lock);
 		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
-	} while (need_seqretry(&nn->writeverf_lock, seq));
-	done_seqretry(&nn->writeverf_lock, seq);
+	} while (read_seqretry(&nn->writeverf_lock, seq));
 }
 
 static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
-- 
2.25.1.362.g51ebf55


