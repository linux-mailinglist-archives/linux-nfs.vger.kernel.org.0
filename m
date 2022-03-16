Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF24DB9CA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 21:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiCPU4r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbiCPU4q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 16:56:46 -0400
Received: from smtpout-3.cvg.de (smtpout-3.cvg.de [IPv6:2003:49:a034:1067:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D991D338
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 13:55:30 -0700 (PDT)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
        by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 22GKtSPQ262244
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 21:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1647464128;
        bh=LlSJ7alKcJr08/SyBfp6L3HGPJ94XSr0s4DRqkjkzu0=; l=4130;
        h=From:To:Subject:References:Date;
        b=SjMJ1XKf3P6hxWvD8IuMyka8lkSnAr4kKQcQU7BsUbvyId1Gi/yl2fW2o6GbpvhVL
         nngREq4c6rlsbjsNKpps26Y3eOjkdw6qs5jP0Tu6Czyo0r3nuW/gZoG/dcmU/f6ICJ
         DDhe22AK2UgPjfk/O+mFuR6ETUtBUmhzi/Wgf5h8=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
        by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 22GKtP4u001156
        for <linux-nfs@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Wed, 16 Mar 2022 21:55:26 +0100
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.73]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 65EE3859A7; Wed, 16 Mar 2022 21:55:23 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 22GKtM0i260512
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-nfs@vger.kernel.org> from ensc@sigma-chemnitz.de; Wed, 16 Mar 2022 21:55:23 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1nUafx-0002aK-At
        for linux-nfs@vger.kernel.org; Wed, 16 Mar 2022 21:55:21 +0100
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     linux-nfs@vger.kernel.org
Subject: Re: Random NFS client lockups
References: <lyr172gl1t.fsf@ensc-virt.intern.sigma-chemnitz.de>
Date:   Wed, 16 Mar 2022 21:55:21 +0100
Message-ID: <lysfrhr51i.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:

> I am experiencing random NFS client lockups after 1-2 days.
> ...
> The full log is available at https://pastebin.pl/view/7d0b345b

Filtering only RPC messages[1] shows

-----
Mar 16 04:48:58.345357: RPC:       worker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 2049)
Mar 16 04:48:58.345487: RPC:       0000000022aecad1 connect status 115 connected 0 sock state 2
Mar 16 04:48:58.345705: RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
Mar 16 05:02:40.037783: RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
Mar 16 05:02:40.037921: RPC:       xs_close xprt 0000000022aecad1
Mar 16 05:02:40.038076: RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.038211: RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.038293: RPC:       xs_error_report client 0000000022aecad1, error=104...
Mar 16 05:02:40.038449: RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.039134: RPC:       xs_connect scheduled xprt 0000000022aecad1
Mar 16 05:02:40.042991: RPC:       xs_bind 0000:0000:0000:0000:0000:0000:0000:0000:883: ok (0)
Mar 16 05:02:40.043072: RPC:       worker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 2049)
Mar 16 05:02:40.043159: RPC:       0000000022aecad1 connect status 115 connected 0 sock state 2
Mar 16 05:02:40.043308: RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
Mar 16 05:02:40.045883: RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
Mar 16 05:02:40.046163: RPC:       xs_close xprt 0000000022aecad1
Mar 16 05:02:40.046410: RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.046625: RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.047428: RPC:       xs_connect scheduled xprt 0000000022aecad1
Mar 16 05:02:40.050387: RPC:       xs_bind 0000:0000:0000:0000:0000:0000:0000:0000:822: ok (0)
Mar 16 05:02:40.050614: RPC:       worker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 2049)
Mar 16 05:02:40.050662: RPC:       0000000022aecad1 connect status 115 connected 0 sock state 2
Mar 16 05:02:40.050788: RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
Mar 16 05:02:40.051969: RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
Mar 16 05:02:40.052067: RPC:       xs_close xprt 0000000022aecad1
Mar 16 05:02:40.052189: RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.052243: RPC:       xs_error_report client 0000000022aecad1, error=32...
Mar 16 05:02:40.052367: RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.052503: RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:02:40.053201: RPC:       xs_connect scheduled xprt 0000000022aecad1
Mar 16 05:02:40.055886: RPC:       xs_bind 0000:0000:0000:0000:0000:0000:0000:0000:875: ok (0)
__A__  05:02:40.055947: RPC:       worker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 2049)
Mar 16 05:02:40.055995: RPC:       0000000022aecad1 connect status 115 connected 0 sock state 2
Mar 16 05:02:40.056125: RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
Mar 16 05:07:28.326605: RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
Mar 16 05:07:28.326679: RPC:       xs_connect scheduled xprt 0000000022aecad1
__B__  05:07:28.326978: RPC:       worker connecting xprt 0000000022aecad1 via tcp to XXXXX:2001:1022:: (port 2049)
Mar 16 05:07:28.327050: RPC:       0000000022aecad1 connect status 0 connected 0 sock state 8
__C__  05:07:28.327113: RPC:       xs_close xprt 0000000022aecad1
Mar 16 05:07:28.327229: RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
Mar 16 05:07:28.327446: RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
-----

For me, it seems that 'xs_close' at position __C__ belongs to the
connection at __A__ but is applied to the newly created connection
__B__.

Because the close did not happened yet, __B__ operated on the old socket
which is in state 8 (CLOSE_WAIT) and connect returned with 0 instead of
-EINPROGRESS hence.  There will not be generated a new connection in
this case.


It seems to be some race where 'xs_connect()' is executed before a
delayed 'xs_error_handle()'.  Both functions are called in reaction of
a 'CLOSE_WAIT'.




Enrico
