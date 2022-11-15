Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A230962997A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 13:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKOM75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 07:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKOM74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 07:59:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315E63C9
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 04:59:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1384122D1E;
        Tue, 15 Nov 2022 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668517194;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lrMcB4t8i9Gxgu4cEwSzO5bvOizDWow5GkhnBbGgQ6Y=;
        b=RfEo+xVpy78nh/uJvGSlPTpa/yNryndXtkbM4HmF4nfP7PTYdnDm9U1KF1I2AQICVlib8B
        p3ID1HOFZ/hBuJzdoKo7zViy7OurNvj1yI6+rgzPoXResMokSLDz4tqS6G8CkVlHDxb+ds
        XTwb9ZCxCiJx7dEAU/txgwtx1pKxD/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668517194;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lrMcB4t8i9Gxgu4cEwSzO5bvOizDWow5GkhnBbGgQ6Y=;
        b=7DiE56UvdxoAAx6CROfVGTeo7qMjfJuixVd2D5t4HIKsFOQAC2o+hVkLjRjq+Gectxx7D8
        wpXk0Piu6fXWEZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D17F913A91;
        Tue, 15 Nov 2022 12:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y5KnMEmNc2MUVQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 15 Nov 2022 12:59:53 +0000
Date:   Tue, 15 Nov 2022 13:59:52 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: NFS git tree in MAINTAINERS
Message-ID: <Y3ONSNns2y7c7zAL@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna, Trond,

which git tree is valid for "NFS, SUNRPC, AND LOCKD CLIENTS"?

MAINTAINERS file mentions Trond's git tree [1].

But it looks like 6504d82f4440755d6fc1385532f84d0344243d61 in 2022-09-12 was the
latest when Linus pulled from this tree. Linus pulled in
31fc92fc93d54d8bedf0d06c1da0510a89867978 in 2022-11-02 from Anna's tree [2].

Could you please update MAINTAINERS file?
Or is it just a temporary change for 6.1? [3]

Kind regards,
Petr

[1] git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
[2] git://git.linux-nfs.org/projects/anna/linux-nfs.git
[3] https://lore.kernel.org/linux-nfs/35A4B422-29FF-4294-8596-D75FC60E55DE@hammerspace.com/
