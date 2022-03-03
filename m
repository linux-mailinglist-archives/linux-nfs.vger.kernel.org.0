Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084114CB667
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Mar 2022 06:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiCCFah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Mar 2022 00:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCFag (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Mar 2022 00:30:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE25FF1D
        for <linux-nfs@vger.kernel.org>; Wed,  2 Mar 2022 21:29:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 701031F383;
        Thu,  3 Mar 2022 05:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646285389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dMNVq0l+SC3ZVpU1a+BGWQyiC28JMOmjuBo8L6pJWI0=;
        b=pkTzBV+31BqC76sWzTv2beqGi/H0xMYag3xhOJw7GNas57KupRmS/NTqVh1YvIAOXyYv1I
        Ja9ebpMZ28Fh9w2/fc08Z3A21f6cTvxyuiLdCoc07cphbCd/xWE8gi59tETJGru9tvkG1y
        Kcpp1maOfm7BTjCIedHH83bQSR6F+Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646285389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dMNVq0l+SC3ZVpU1a+BGWQyiC28JMOmjuBo8L6pJWI0=;
        b=kIVDZVtyt+U/Y8aM/oI5cKEUPtrEbuR/dBISvvroImEI49AmtO1u676qEdmZ/GgwQ4I/He
        TbRX3/Rwtf9QLeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92850139BD;
        Thu,  3 Mar 2022 05:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EkEE0xSIGIAFAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 03 Mar 2022 05:29:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: NFS access problems when group membership changes on server
Date:   Thu, 03 Mar 2022 16:29:37 +1100
Message-id: <164628537738.17899.2312723585718867242@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Since
 Commit 57b691819ee2 ("NFS: Cache access checks more aggressively")
we do not recheck "ACCESS" tests unless the inode changes (or falls out
of cache).  I recently discovered that this can be problematic.

The ACCESS test checks if a given user has access to a given file.
That is most likely to change if the file changes, but it can change if
the users capabilities change  - e.g. their group memberships change.
With AUTH_SYS the group membership as seen on the client is used (though
with the Linux NFS server, adding the -g option to mountd can change
this).
With AUTH_GSS, the mapping from user to groups must happen on the
server.  IF this mapping changes it might be invisible to the client
for an arbitrary long time.

I don't think this affects files with NFSv4 as there will be a OPEN
request to the server, but it does affect directories.

If a user does "ls -l some-directory", this fails, and they go ask the
server admin "please add me to the group to access the directory", then
they go back and try again, it may well still not work.

With a local filesystem, logging off and back on again might be
required to refresh the groups list, but even this isn't sufficient for
NFS. 

What to do? 

We could simply revert that patch and refresh the access cache similar
to refreshing of other attributes.  We could possibly do it with a
longer timeout or only with a mount option, but I don't really like
those options.

Maybe we could add a 'struct pid *' to the access entry which references
the PIDTYPE_SID of the calling process.  This would be different for
different login sessions, but common throughout one login.
If we did this, then logging out and back in again would resolve the
access problem, which matches that is needed for local access.
I'm not sure if I like this idea or not, but I thought it worth
mentioning.

Any other ideas?

Thanks,
NeilBrown
