Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710B67D72B1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJYR4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJYR4f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 13:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789813D
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698256546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIO20jbXgSOplV2THMhTgaUzTr5RKxotR9SQLHD8dEQ=;
        b=WFWe8HHHUfF89QzEwthouoVPE3goPNdL82v57o1Uu7/6EuvsATPXaEdij+nHkrWtmy9HWY
        GVEjGEoEuFIjJ1RafFDWUt/O6OEeTXTd17rPDcsgBoxP5KbPBQRfTp5sUx6bFmQNyHrAQQ
        ZhX4mZL8+z0Rp3z1YeSeLz3Rl/blndo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-lk94h8FOMO-3VJ9NB-6cXA-1; Wed,
 25 Oct 2023 13:55:40 -0400
X-MC-Unique: lk94h8FOMO-3VJ9NB-6cXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8038729ABA0F;
        Wed, 25 Oct 2023 17:55:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 73480C1596D;
        Wed, 25 Oct 2023 17:55:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Oct 2023 19:54:38 +0200 (CEST)
Date:   Wed, 25 Oct 2023 19:54:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <20231025175435.GC29779@redhat.com>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/25, Chuck Lever wrote:
>
> > Another question is why we can't simply turn nn->writeverf into seqcount_t.
> > I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> > serialise with itself, right?
>
> "reset" is supposed to be very rare operation. Using a lock in that
> case is probably quite acceptable, as long as reading the verifier
> is wait-free and guaranteed to be untorn.
>
> But a seqcount_t is only 32 bits.

Again, I don't understand you.

Once again, we can turn writeverf into seqcount_t, see the patch below.

But this way nfsd_reset_write_verifier() can race with itself, no?

Oleg
---

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..3e2adf3eb15f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -110,7 +110,7 @@ struct nfsd_net {
 	bool nfsd_net_up;
 	bool lockd_up;
 
-	seqlock_t writeverf_lock;
+	seqcount_t writeverf_lock;
 	unsigned char writeverf[8];
 
 	/*
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a36..6320491018f8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1523,7 +1523,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
-	seqlock_init(&nn->writeverf_lock);
+	seqcount_init(&nn->writeverf_lock);
 
 	return 0;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..fc4e31411508 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
  */
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 {
-	int seq = 0;
+	int seq;
 
 	do {
-		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
+		seq = read_seqcount_begin(&nn->writeverf_lock);
 		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
-	} while (need_seqretry(&nn->writeverf_lock, seq));
-	done_seqretry(&nn->writeverf_lock, seq);
+	} while (read_seqcount_retry(&nn->writeverf_lock, seq));
 }
 
 static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
@@ -397,9 +396,9 @@ static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
  */
 void nfsd_reset_write_verifier(struct nfsd_net *nn)
 {
-	write_seqlock(&nn->writeverf_lock);
+	write_seqcount_begin(&nn->writeverf_lock);
 	nfsd_reset_write_verifier_locked(nn);
-	write_sequnlock(&nn->writeverf_lock);
+	write_seqcount_end(&nn->writeverf_lock);
 }
 
 /*

