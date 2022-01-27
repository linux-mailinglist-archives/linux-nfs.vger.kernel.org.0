Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745E349D9B8
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 05:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiA0E7k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 23:59:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiA0E7k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 23:59:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 834E91F3AF;
        Thu, 27 Jan 2022 04:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643259578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xszqTo1DyKYonBKGa/iL/nAoqWmCcf8Bz0XHj9p3SN8=;
        b=f2L2F3Vmd7MSETV888ZRO4OhYlmHwaSpuxRHRmdZHuPbSNRpreTCAMn7YLuOHawxaGMBnh
        +nq43BHfjIs9wzdE0YUP5pV1mJgskDhmAZQS+P/NM3laTW6LRFLy2yDC5gaXuQkLg3ozTt
        KqJAB+tTpqv/9Ad2iWHICa3ScZBouGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643259578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xszqTo1DyKYonBKGa/iL/nAoqWmCcf8Bz0XHj9p3SN8=;
        b=qb+RzG9EuwvgV9CfKO72eo2vDRVAAdESXluLKbtH60kxewpmwOV+Khy6MK3fq5ucC7sJdK
        V/vZdkihkM5AG+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A595713BCF;
        Thu, 27 Jan 2022 04:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id leX8GLkm8mErVgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 04:59:37 +0000
Subject: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 15:58:10 +1100
Message-ID: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a filesystem is exported to a client with NFSv4 and that client holds
a file open, the filesystem cannot be unmounted without either stopping the
NFS server completely, or blocking all access from that client
(unexporting all filesystems) and waiting for the lease timeout.

For NFSv3 - and particularly NLM - it is possible to revoke all state by
writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem.

This series extends this functionality to NFSv4.  With this, to unmount
an exported filesystem is it sufficient to disable export of that
filesystem, and then write the path to unlock_filesystem.

I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
yet with NFSv4.0 which has different mechanisms for state management.

If this series is seen as a general acceptable approach, I'll look into
the NFSv4.0 aspects properly and make sure it works there.

Thanks,
NeilBrown


---

NeilBrown (4):
      nfsd: prepare for supporting admin-revocation of state
      nfsd: allow open state ids to be revoked and then freed
      nfsd: allow lock state ids to be revoked and then freed
      nfsd: allow delegation state ids to be revoked and then freed


 fs/nfsd/nfs4state.c | 105 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 9 deletions(-)

--
Signature

