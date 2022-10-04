Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE345F3C68
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 07:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDFO5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJDFO4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 01:14:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5CFAE8
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 22:14:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7CC321905;
        Tue,  4 Oct 2022 05:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664860492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r6zWbQUYCYfqyVpLXW9Yb5ibgExcKee9t7Ssf+bJRUE=;
        b=y1/11cTB4xUcI18zA7wTqD513mo+0+MX2mJhwkRhYLroJESi/JuUh9DKzh5arZfjXpwkdG
        JSHMk0ODFg95aApVNxCGT0Fu/CB9bcWzBmnjUFbqM2FWMC/vhLjahwABavH1kPwLFKeDle
        fFCXdyCESuAPzpbJCpivZfc9uziOCVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664860492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r6zWbQUYCYfqyVpLXW9Yb5ibgExcKee9t7Ssf+bJRUE=;
        b=AB7g+zQnN9qYqF4WrcUwCZcVWCIrliBhPvXKzAm5OvyuSqxEcqfHFRjyKSVW23ZXcbg5QH
        kGzyS2OUylTupxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 776DE13A8F;
        Tue,  4 Oct 2022 05:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /WaUC0vBO2OoAQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Oct 2022 05:14:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: nfsd: another possible delegation race
Date:   Tue, 04 Oct 2022 16:14:47 +1100
Message-id: <166486048770.14457.133971372966856907@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi,
 I have a customer who experienced a crash in nfsd which appears to be
 related to delegation return.  I cannot completely rule-out
  Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
 as the kernel being used didn't have that commit, but the symptoms are
 quite different, and while exploring I found, I think, a different
 race.  This new race doesn't obviously address all the symptoms, but
 maybe it does...

 The symptoms were:
  1/   WARN_ON(!unhash_delegation_locked(dp));
    in nfs4_laundromat complained (delegation wasn't hashed!)
  2/   refcount_t: saturated; leaking memory
    This came from the refcount_inc in revoke_delegation() called from
    nfs4_laundromat(), a few lines below the above warning
  3/ BUG: kernel NULL pointer dereference, address: 0000000000000028
     This is from the destroy_unhashed_deleg() call at the end of
     that same revoke_delegation() call, which calls
     nfs4_unlock_deleg_lease() and passes fp->fi_deleg_file, which is
     NULL (!!!), to vfs_setlease().
  These three happened in a 200usec window.

 What I imagine might be happening is that the nfsd_break_deleg_cb()
 callback is called after destroy_delegation() has unhashed the deleg,
 but before destroy_unhashed_delegation() gets called.

 If nfsd_break_deleg_cb() is called before the unhash - and particularly
 if nfsd_break_one_deleg()->nfsd4_run_cb() is called before, then the
 unhash will disconnect the delegation from the recall list, and no
 harm can be done.
 Once vfs_setlease(F_UNLCK) is called, the callback can no longer be
 called, so again no harm is possible.

 Between these two is a race window.  The delegation can be put on the
 recall list, but the deleg will be unhashed and put_deleg_file() will
 have set fi_deleg_file to NULL - resulting in first WARNING and the
 BUG.

 I cannot see how the refcount_t warning can be generated ...  so maybe
 I've missed something.

 My proposed solution is to test delegation_hashed() while holding
 fp->fi_lock in nfsd_break_deleg_cb().  If the delegation is locked, we
 can safely schedule the recall.  If it isn't, then the lease is about
 to be unlocked and there is no need to schedule anything.

 I don't know this code at all well, so I thought it safest to ask for
 comments before posting a proper patch.
 I'm particularly curious to know if anyone has ideas about the refcount
 overflow.  Corruption is unlikely as the deleg looked mostly OK and the
 memory has been freed, but not reallocated (though it is possible it
 was freed, reallocated, and freed again).
 This wasn't a refcount_inc on a zero refcount - that gives a different
 error.  I don't know what the refcount value was, it has already been
 changed to the 'saturated' value - 0xc0000000.

Thanks,
NeilBrown


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..e02d638df6be 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4822,8 +4822,10 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	fl->fl_break_time = 0;
 
 	spin_lock(&fp->fi_lock);
-	fp->fi_had_conflict = true;
-	nfsd_break_one_deleg(dp);
+	if (delegation_hashed(dp)) {
+		fp->fi_had_conflict = true;
+		nfsd_break_one_deleg(dp);
+	}
 	spin_unlock(&fp->fi_lock);
 	return ret;
 }


