Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342A513FAC
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 02:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352668AbiD2Ar4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 20:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiD2Ar4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 20:47:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF9BB906;
        Thu, 28 Apr 2022 17:44:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 250941F37F;
        Fri, 29 Apr 2022 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651193078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BJfveXdsbtj8APvKzD0BIya71Qy3rY7o+Fk5zYeGnnQ=;
        b=RyavaI8lgG76n7q0sPYbSMUMFc9luHJ3GA6SM7c0TWZlGtZJfjrus57ObJtQWEW7Bv73Sg
        fyh+SOo8/yrrSppAY1Z+3S+5hygF41/xIBLaTTGSnBLLnHjyeMm874G7/H9Csz7uHxeU59
        ta+CuX3BPUhe+L5sqOx77OMWWHDDSr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651193078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BJfveXdsbtj8APvKzD0BIya71Qy3rY7o+Fk5zYeGnnQ=;
        b=bzegBzIwDeKakEk4yow335y2vcO5jeRjuzj0Tu7ffed+VoRxFxNkVyOzo5VHpcdeHCgAoD
        ++UYDODtKON52PCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 094D013491;
        Fri, 29 Apr 2022 00:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ty5kLvM0a2IjSgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Apr 2022 00:44:35 +0000
Subject: [PATCH 0/2] Finalising swap-over-NFS patches
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:43:34 +1000
Message-ID: <165119280115.15698.2629172320052218921.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Andrew,
Two patches for current -mm branch.

First fixes an omission pointed out by Miaohe Lin.  Huge pages weren't
handled correctly.

Second changes NFS to use the new ->swap_rw

With this, swap over NFS largely works again.  I think there is a little
more work to do in NFS/SUNRPC code to make allocations on the swap out
path behave optimally.  Any such changes can go through the NFS tree.

Thanks,
NeilBrown

---

NeilBrown (2):
      MM: handle THP in swap_*page_fs()
      NFS: rename nfs_direct_IO and use as ->swap_rw


 fs/nfs/direct.c        | 23 ++++++++++-------------
 fs/nfs/file.c          |  5 +----
 include/linux/nfs_fs.h |  2 +-
 mm/page_io.c           | 23 +++++++++++++----------
 4 files changed, 25 insertions(+), 28 deletions(-)

--
Signature

