Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED97D8CE7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 03:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjJ0B43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 21:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjJ0B42 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 21:56:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F4111
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 18:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2A851FEBA;
        Fri, 27 Oct 2023 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698371785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VgRrD8kcNH1PVooSLIMoBgqiyNQdw96No2zl9Hc7W1M=;
        b=FvfKxZTDKK+rZjkxq4+hCnY+EB7OK4IMQTFDO8ugz5TduV87YZoDjxhhiupMmnUgnVAKuw
        PpRLnINS5vFWCt950zjUjMmvOIx+QKqg1fnF3vOLDaEPQva2v6C0ug43KtR73ikU7D5QCd
        I2LTMx4MSI2kTNx3s3ExaGRKKqlFx+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698371785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VgRrD8kcNH1PVooSLIMoBgqiyNQdw96No2zl9Hc7W1M=;
        b=I6v2OQwJw7u8hyR1AtoPMnfMY1qvbvvGyY8mr5vEZWRjLzkyrBuzF8jbjq54S0gftnzBT+
        sT8Ueyr/P01wqhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E55F3133F5;
        Fri, 27 Oct 2023 01:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 66dyJcYYO2XlCQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 01:56:22 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6] support admin-revocation of v4 state
Date:   Fri, 27 Oct 2023 12:45:28 +1100
Message-ID: <20231027015613.26247-1-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a revised version of a patch set I sent over a year ago.
It now supports v4.0 and has had more testing.

There are cirsumstances where an admin might need to unmount a
filesystem that is NFS-exported and in active use, but does not want to
stop the NFS server completely.  These are certainly unusual
circumstance and doing this might negatively impact any clients acting
on the filesystem, but the admin should be able to do this.

Currently this is quite possible for for NFSv3.  Unexporting the
filesystem will ensure no new opens happen, and writing the path name to
/proc/fs/nfsd/unlock_filesystem will ensure anly NLM locks held in the
filesystem are released so that NFSD no longer prevents the filesystem
from being unlocked.

It is not currently possible for NFSv4.  Writing to unlock_filesystem
does not affect NFSv4, which is arguably a bug.  This series fixes the bug.

For NFSv4.1 and later code is straight forward.  We add new state types
for admin-revoked state (open, lock, deleg) and change the type of any
state on a filesystem - inavlidating any access and closing files as we
go.  While there are any revoked states we report this to the client in
the response to SEQUENCE requests, and it will check and free any states
that need to be freed.

For NFSv4.0 it isn't quite so easy as there is no mechanism for the
client to explicitly acknowledged admin-revoked states.  The approach
this patchset takes is to discard NFSv4.0 admin-revoked states one
lease-time after they were revoked, or immediately for a state that the
client tryies to use and gets an "ADMIN_REVOKED" error for.  If the
filestystem has been unmounted (as expected), the client will see STATE
errors before it has a chance to see ADMIN_REVOKED errors, so most often
the timeout will be how states are discarded.

NeilBrown

 [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
 [PATCH 2/6] nfsd: allow admin-revoked state to appear in
 [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
 [PATCH 4/6] nfsd: allow lock state ids to be revoked and then freed
 [PATCH 5/6] nfsd: allow open state ids to be revoked and then freed
 [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then

