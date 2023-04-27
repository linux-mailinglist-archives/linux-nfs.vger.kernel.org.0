Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B26F035C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Apr 2023 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbjD0J1j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Apr 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbjD0J1i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Apr 2023 05:27:38 -0400
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316D1FF2
        for <linux-nfs@vger.kernel.org>; Thu, 27 Apr 2023 02:27:35 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4Q6Vkt2SWVz30
        for <linux-nfs@vger.kernel.org>; Thu, 27 Apr 2023 11:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1682587654;
        bh=aL89FJxMgdMiGyH9QcnuEknzdvnTH2Xcq5Tab8Fl0yE=;
        h=Date:From:To:Subject:Reply-To:From;
        b=smYZoX9IBjzLAvbu2iYKcc/CofgWCNlCxH1BR+MW4aDjpupxyMNIR9YW7UVA5tb9n
         jdNLHhG3fdJU2uwnbu/+hjnvF+mfi5PEnD0jDmIIM9sagtOz1Hfvou06zmBpP7tdcw
         dZEShkK5LfOC0EBoLo/R44gWvvo2ESe/JK7CnpCzG/XyEAIppgMmvCm3AUzcRidv5Q
         4/QLa+S6q0KgStbnl8gW6tlJbFg4HQIzuNsm2gxM0CX6NvNt3jl7bmUc9/UHBiIxoH
         w3B2LPdb/mbLVfIeNz6LrrtbWRU2ilhUBLSGh3V5ta8wJ1j3FT9HzzuBOix5l2YWy2
         2y5I6q526eA1Q==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id uW7ErqTvt5uR for <linux-nfs@vger.kernel.org>;
        Thu, 27 Apr 2023 11:27:34 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4Q6Vkt1jnzz9r
        for <linux-nfs@vger.kernel.org>; Thu, 27 Apr 2023 11:27:34 +0200 (CEST)
Date:   Thu, 27 Apr 2023 11:27:33 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     linux-nfs@vger.kernel.org
Subject: re: file server freezes with all nfsds stuck in D state after
 upgrade to Debian
Message-ID: <ZEpABew3i0S/DBL8@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello again

Three weeks ago we reported on nfsd D state-induced freezes on our
bookworm-upgraded files servers [1]. The general consensus at the time seems
to have been that the real issue was deeper in our storage stack, so we headed
over to linux-block but were never able to pinpoint the issue. 
We just had another instance where all our 64 nfsd processes were stuck in D
state. This time the stack traces look different and we have some more hints
in our logs, and this time we're pretty sure it's nfsd and not general block
IO.

All 64 nfds have similiar stack traces:

14 processes:  
[<0>] __flush_workqueue+0x152/0x420
[<0>] nfsd4_shutdown_callback+0x49/0x130 [nfsd]
[<0>] __destroy_client+0x1f3/0x290 [nfsd]
[<0>] nfsd4_exchange_id+0x752/0x760 [nfsd]
[<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
[<0>] nfsd_dispatch+0x167/0x280 [nfsd]
[<0>] svc_process_common+0x286/0x5e0 [sunrpc]
[<0>] svc_process+0xad/0x100 [sunrpc]
[<0>] nfsd+0xd5/0x190 [nfsd]
[<0>] kthread+0xe6/0x110
[<0>] ret_from_fork+0x1f/0x30

9 processes:
[<0>] __flush_workqueue+0x152/0x420
[<0>] nfsd4_shutdown_callback+0x49/0x130 [nfsd]
[<0>] __destroy_client+0x1f3/0x290 [nfsd]
[<0>] nfsd4_exchange_id+0x358/0x760 [nfsd]
[<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
[<0>] nfsd_dispatch+0x167/0x280 [nfsd]
[<0>] svc_process_common+0x286/0x5e0 [sunrpc]
[<0>] svc_process+0xad/0x100 [sunrpc]
[<0>] nfsd+0xd5/0x190 [nfsd]
[<0>] kthread+0xe6/0x110
[<0>] ret_from_fork+0x1f/0x30

41 processes:
[<0>] __flush_workqueue+0x152/0x420
[<0>] nfsd4_destroy_session+0x1b6/0x250 [nfsd]
[<0>] nfsd4_proc_compound+0x352/0x660 [nfsd]
[<0>] nfsd_dispatch+0x167/0x280 [nfsd]
[<0>] svc_process_common+0x286/0x5e0 [sunrpc]
[<0>] svc_process+0xad/0x100 [sunrpc]
[<0>] nfsd+0xd5/0x190 [nfsd]
[<0>] kthread+0xe6/0x110
[<0>] ret_from_fork+0x1f/0x30


20 minutes prior to  the first frozen nfsds, we saw messages similiar to

  receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt
00000000fcdd40ac xid 182df75c

It seems these messages come from receive_cb_reply [2] and it looks like
xprt_lookup_rqst cannot find the  RPC request beloning to a certain
transaction. We  see these messages with different values for xpt_bc_xprt,
which, we think, correspond to the different NFS clients.

All this is on production file servers running Debian bookworm with iSCSI
block devices and XFS file systems.

Does anyone have any suggestions how to further debug this? Unfortunately we
have yet to find a way to trigger it deliberately, for the time being it
happens whenever it happens....


thanks and best regards,
-Christian


[1] https://www.spinics.net/lists/linux-nfs/msg96048.html
[2] https://elixir.bootlin.com/linux/v6.1.20/source/net/sunrpc/svcsock.c#L902




-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/
