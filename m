Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0275AC451
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiIDMs5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIDMsy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 08:48:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC33DBCF;
        Sun,  4 Sep 2022 05:48:52 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-97.corp.google.com [104.133.160.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 284CmkFC028819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 4 Sep 2022 08:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662295728; bh=wJJ2xk6KJ1yVceSY2TU4J8PUoHuCxZ0ytCiEr+dN1K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JuDyiahJtXDJgOvnzRxWPlNyJiB0eXxs1+urVEQlvgawDSbakRAIzQDaxI9oSJnRz
         JPe/T/fCLloxD61B3ddlR0wO5jz7hvD7I8H4BuM9ks2F2QI8nPHo4MvmR1slV3PA2v
         2DXHhdtNHVWgyb+4Uwcdaftff8GmdG7GaVdVBvszJ4NxsHBVQz8RECYK7jmiozSuOp
         QuTndUFazxxpFpgphkfVE77h9y/7pIsY70Q00o6pjd4ypcmZ5zVRSMv+vJpMW9kxMC
         NHHye+34geNEJf9U3buEm/cq2iuFYEX9HtdcjZ3mZHIVQGZ0UmxreFdvPLgiiMuyyR
         /iez4QRkPVr1Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 0A9F78C2D14; Sun,  4 Sep 2022 08:48:42 -0400 (EDT)
Date:   Sun, 4 Sep 2022 08:48:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Message-ID: <YxSeqjkKvz+Y2AcP@mit.edu>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> While investigating some of the other issues that have been
> reported lately, I've found that my v6.0-rc3 NFS/TCP client
> goes off the rails often (but not always) during generic/650.
> 
> This is the test that runs a workload while offlining and
> onlining CPUs. My test client has 12 physical cores.
> 
> The test appears to start normally, but then after a bit
> the NFS server workload drops to zero and the NFS mount
> disappears. I can't run programs (sudo, for example) on
> the client. Can't log in, even on the console. The console
> has a constant stream of "can't rotate log: Input/Output
> error" type messages.

I've noticed problems with generic/650 for quite a while, but only
when running tests on GCE (but not KVM).  I noted this not when
running xfstests on ext4; IIRC, it was was causing the VM to reboot
when testing any file system.

							- Ted

commit 6e7867469bd3b135125a76e633e0bb50045ccb3c
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Oct 22 23:24:31 2021 -0400

    test-appliance: allow tests to be excluded based on the appliance flavor
    
    The generic/650 test causes an instant reboot on GCE, so add
    infrastructure to exclude a test based on the test appliance flavor
    (i.e., android, gce, or kvm).
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
