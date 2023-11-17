Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DE7EEB02
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjKQCWZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCWY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:22:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932BCE
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:22:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 137CE218D6;
        Fri, 17 Nov 2023 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oV41bV1FpWgzCyDRy4Ov2XBAKYYe2OYgD54ca60H+Cg=;
        b=IWDk916ysqMafuTt66Byt4VfHs0OwVjbbxy/O1mVQJAEgs0XnKoQtlUtNsQrD44HpXUaTY
        6K5JeX50bd8KdMbwyeoIZ6rLhsb1ZikIEbM+t9SOeuzNXtuResOzkriUQCBfi8tIpo054B
        sdA5bPXWkPunG8Esp7sNkSOW5VWBd3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oV41bV1FpWgzCyDRy4Ov2XBAKYYe2OYgD54ca60H+Cg=;
        b=4wme7eE1QHbmAUDwFZKtfsIgvjzfM4RJnI/aUzkdHo6iX/aLgk/5sOJzVe5XMk1pYwMnMm
        GOeEtm1om3tLTBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EADBA1341F;
        Fri, 17 Nov 2023 02:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7jsRKFnOVmVnEwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:22:17 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 8/9] nfsd: allow open state ids to be revoked and then freed
Date:   Fri, 17 Nov 2023 13:18:54 +1100
Message-ID: <20231117022121.23310-9-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117022121.23310-1-neilb@suse.de>
References: <20231117022121.23310-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.69
X-Spamd-Result: default: False [3.69 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.01)[48.16%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Revoking state through 'unlock_filesystem' now revokes any open states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Possibly the related lock states should be revoked too, but a
subsequent patch will do that for all lock state on the superblock.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9fec3bf69d31..dd454f50383e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1708,7 +1708,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = NFS4_LOCK_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1723,6 +1723,22 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case NFS4_OPEN_STID:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  OPEN_STATEID_MUTEX);
+
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							NFS4_STID_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+						spin_unlock(&clp->cl_lock);
+						release_all_access(stp);
+					} else
+						spin_unlock(&clp->cl_lock);
+					mutex_unlock(&stp->st_mutex);
+					break;
 				case NFS4_LOCK_STID:
 					stp = openlockstateid(stid);
 					mutex_lock_nested(&stp->st_mutex,
@@ -4694,6 +4710,13 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 	bool unhashed;
 
 	switch (s->sc_type) {
+	case NFS4_OPEN_STID:
+		stp = openlockstateid(s);
+		if (unhash_open_stateid(stp, &reaplist))
+			put_ol_stateid_locked(stp, &reaplist);
+		spin_unlock(&cl->cl_lock);
+		free_ol_stateid_reaplist(&reaplist);
+		break;
 	case NFS4_LOCK_STID:
 		stp = openlockstateid(s);
 		unhashed = unhash_lock_stateid(stp);
-- 
2.42.0

