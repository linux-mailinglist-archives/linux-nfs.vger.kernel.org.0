Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978786FBB7C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjEHXmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEHXmB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 19:42:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A63AB2
        for <linux-nfs@vger.kernel.org>; Mon,  8 May 2023 16:41:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37141202D8;
        Mon,  8 May 2023 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683589314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wy82XfNBO0CzoEXZAbSG/MGYQLOGhiSGZZQrT93CcV8=;
        b=cJkCZnc4+39YtBqDIgPRMESOCLPR6Lldqr4PH4eiKELE6YI8SOGEvAb8ZxhRmRT/at5HKD
        /SLd9nBYGeBA/AUenpDAr1hnQWM6/3FajxvPJsSm0eiJGu7jTTEkG7VTU0of2XY4ka9mQy
        ctohMAXyKxonh6jGK5qCHjHD14yOsgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683589314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wy82XfNBO0CzoEXZAbSG/MGYQLOGhiSGZZQrT93CcV8=;
        b=tO1PtZMm2zMh/1+i4PPPhn3374+qpQH3X1HNPWaFT6vvu9kkqryuEga81ummJRwT389m4U
        ATajK9cTXhJM4GBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03BA71346B;
        Mon,  8 May 2023 23:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VrTjKsCIWWSpdgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 08 May 2023 23:41:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: double free xprt_ctxt while still in use
Date:   Tue, 09 May 2023 09:41:49 +1000
Message-id: <168358930939.26026.4067210924697967164@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When an RPC request is deferred, the rq_xprt_ctxt pointer is moved out
of the svc_rqst into the svc_deferred_req.
When the deferred request is revisited, the pointer is copied into
the new svc_rqst - and also remains in the svc_deferred_req.

In the (rare?) case that the request is deferred a second time, the old
svc_deferred_req is reused - it still has all the correct content.
However in that case the rq_xprt_ctxt pointer is NOT cleared so that
when xpo_release_xprt is called, the ctxt is freed (UDP) or possible
added to a free list (RDMA).
When the deferred request is revisited for a second time, it will
reference this ctxt which may be invalid, and the free the object a
second time which is likely to oops.

So change svc_defer() to *always* clear rq_xprt_ctxt, and assert that
the value is now stored in the svc_deferred_req.

Fixes: 773f91b2cf3f ("SUNRPC: Fix NFSD's request deferral on RDMA transports")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 84e5d7d31481..5fd94f6bdc75 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1223,13 +1223,14 @@ static struct cache_deferred_req *svc_defer(struct ca=
che_req *req)
 		dr->daddr =3D rqstp->rq_daddr;
 		dr->argslen =3D rqstp->rq_arg.len >> 2;
 		dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
-		rqstp->rq_xprt_ctxt =3D NULL;
=20
 		/* back up head to the start of the buffer and copy */
 		skip =3D rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
 		       dr->argslen << 2);
 	}
+	WARN_ON_ONCE(rqstp->rq_xprt_ctxt !=3D dr->xprt_ctxt);
+	rqstp->rq_xprt_ctxt =3D NULL;
 	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt =3D rqstp->rq_xprt;
--=20
2.40.1

