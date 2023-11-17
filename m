Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F67EEAF7
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjKQCVr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCVq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:21:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C60CE
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:21:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00B7822929;
        Fri, 17 Nov 2023 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYcWINIIN7RZWfLZStiPFG9nvRYQyp4o1U1htiKWE/c=;
        b=V6x0Mm1arVL9NqMJDpQNrXgE7D4z8mnH5PhjOMg3RDaKj7XUQ3mEDoelFNCBVnqtXiWpYK
        PHptiPLiEJAs8S+q3UUJX7KmBMZiJ+glKyFg0oit/2TLA3dsqYY5OkTjFtXJ4xKP3xNy3X
        zwplnL/FzsVoZvc4ouU/g6P+ZkIjUoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYcWINIIN7RZWfLZStiPFG9nvRYQyp4o1U1htiKWE/c=;
        b=wApvrzXL5oV6yLc9STnHNQBj8Fppfetm2udFPPy/zapb1YRtgVre5RHtO9CulowJArKX7g
        WMEXvJeXN700p2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE2911341F;
        Fri, 17 Nov 2023 02:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R+EsKTPOVmUgEwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:21:39 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
Date:   Fri, 17 Nov 2023 13:18:47 +1100
Message-ID: <20231117022121.23310-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117022121.23310-1-neilb@suse.de>
References: <20231117022121.23310-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
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
         BAYES_HAM(-0.00)[16.77%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The protocol for creating a new state in nfsd is to allocated the state
leaving it largely uninitialised, add that state to the ->cl_stateids
idr so as to reserve a state id, then complete initialisation of the
state and only set ->sc_type to non-zero once the state is fully
initialised.

If a state is found in the idr with ->sc_type == 0, it is ignored.
The ->cl_lock list is used to avoid races - it is held while checking
sc_type during lookup, and held when a non-zero value is stored in
->sc_type.

... except... hash_delegation_locked() finalises the initialisation of a
delegation state, but does NOT hold ->cl_lock.

So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
and so ensures there are no races (which are extremely unlikely in any
case).

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 65fd5510323a..6368788a7d4e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 
 	lockdep_assert_held(&state_lock);
 	lockdep_assert_held(&fp->fi_lock);
+	lockdep_assert_held(&clp->cl_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
 		return -EAGAIN;
@@ -5609,12 +5610,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		goto out_unlock;
 
 	spin_lock(&state_lock);
+	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_had_conflict)
 		status = -EAGAIN;
 	else
 		status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
+	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
 	if (status)
-- 
2.42.0

