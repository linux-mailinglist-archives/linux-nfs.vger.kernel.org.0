Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494CB6F4003
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEBJWm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBJWk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 05:22:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52E9D
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 02:22:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00D3D1F381;
        Tue,  2 May 2023 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683019351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlSlKBRy8U4tZdp9g9mjvciVbDmDSq6CApVKyfK0Rhs=;
        b=QU9Caqgn9In4oKCHfIvU1gYuH7GXML8HEkSK80d8BiD+IXh8OpCjygd90ysTmzL97usH5h
        niPs9ZhNcas5g/UqxkYaRqvO5U0NVQXENRIKcGVh/Ei8uZlqM//Dp5ZBlHh8pAxoskdb8w
        oEAuZmszHKlHdyNr4U1QHRHz7tNpgOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683019351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlSlKBRy8U4tZdp9g9mjvciVbDmDSq6CApVKyfK0Rhs=;
        b=KO9E6gWYN5folnmyNWc30iFydA6scrIZEE46mC8rbRCqvMog8rHuSOYRpMeZZePQR6sk3+
        DPYTeiNMO/u5RGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9A88139C3;
        Tue,  2 May 2023 09:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mriOK1bWUGRoUgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 09:22:30 +0000
Date:   Tue, 2 May 2023 11:22:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
Message-ID: <20230502092243.GA3625868@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230502075921.3614794-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502075921.3614794-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> Subject: [LTP] [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP

Obviously, the subject should not contain "on TCP" (first, I removed only TCP
entries in runtest file, but because I expect it would be problematic also on
UDP). Also tst_brk TCONF does not check TCP/UDP either (only NFS v3).

I'll update that before merge (don't send new version).

Kind regards,
Petr

> nfs_flock (run via nfslock01.sh) is known to fail on NFS v3 [1]:

>     not unsharing /var makes AF_UNIX socket for host's rpcbind to become
>     available inside ltp_ns. Then, at NFS v3 mount time, kernel creates
>     an instance of lockd for ltp_ns, and ports for that instance leak to
>     host's rpcbind and overwrite ports for lockd already active for root
>     namespace. This breaks nfs3 file locking.

> Before bd512e733 ("nfs_flock: fail the test if lock/unlock ops fail")
> it run indefinitely with "unhandled error -107":
> [ 2840.099565] lockd: cannot monitor 10.0.0.2
> [ 2840.109353] lockd: cannot monitor 10.0.0.2
> [ 2843.286811] xs_tcp_setup_socket: connect returned unhandled error -107
> [ 2850.198791] xs_tcp_setup_socket: connect returned unhandled error -107

> bd512e733 caused an early abort (therefore only "cannot monitor 10.0.0.2"
> appears).

> Although there is suggestion, how to fix the problem in kernel [2]:

>     > Maybe rpcb_create_local() shall detect that it is not in root
>     > netns, and only try AF_INET connection to > localhost in that case.

>     That would be simple and might be sensible.  IF changing the AF_UNIX
>     path to "/run/rpcbind.sock" isn't sufficient, then testing for the
>     root_ns is probably the best second option.

> Until it's implemented, it's better to:
> * don't test on NFS v3 on both TCP and UDP (remove from the runtest file)
> * skip the test with TCONF in case version 3 is passed on command line

> NOTE: Tested only on TCP (UDP is disabled in kernel by default via
> NFS_DISABLE_UDP_SUPPORT).

> [1] https://lore.kernel.org/ltp/YebcNQg0u5cU1QyQ@pevik/
> [2] https://lore.kernel.org/ltp/164254401568.24166.883582030601071761@noble.neil.brown.name/

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net.nfs                              | 4 ----
>  testcases/network/nfs/nfslock01/nfslock01.sh | 6 ++++++
>  2 files changed, 6 insertions(+), 4 deletions(-)

> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 72cf4b307..a73956015 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -83,13 +83,9 @@ nfs4_ipv6_08 nfs08.sh -6 -v 4 -t tcp
>  nfs41_ipv6_08 nfs08.sh -6 -v 4.1 -t tcp
>  nfs42_ipv6_08 nfs08.sh -6 -v 4.2 -t tcp

> -nfslock3_01 nfslock01.sh -v 3 -t udp
> -nfslock3t_01 nfslock01.sh -v 3 -t tcp
>  nfslock4_01 nfslock01.sh -v 4 -t tcp
>  nfslock41_01 nfslock01.sh -v 4.1 -t tcp
>  nfslock42_01 nfslock01.sh -v 4.2 -t tcp
> -nfslock3_ipv6_01 nfslock01.sh -6 -v 3 -t udp
> -nfslock3t_ipv6_01 nfslock01.sh -6 -v 3 -t tcp
>  nfslock4_ipv6_01 nfslock01.sh -6 -v 4 -t tcp
>  nfslock41_ipv6_01 nfslock01.sh -6 -v 4.1 -t tcp
>  nfslock42_ipv6_01 nfslock01.sh -6 -v 4.2 -t tcp
> diff --git a/testcases/network/nfs/nfslock01/nfslock01.sh b/testcases/network/nfs/nfslock01/nfslock01.sh
> index fbcc3c00f..78904281b 100755
> --- a/testcases/network/nfs/nfslock01/nfslock01.sh
> +++ b/testcases/network/nfs/nfslock01/nfslock01.sh
> @@ -15,6 +15,12 @@ TST_TESTFUNC="do_test"

>  do_setup()
>  {
> +	local i
> +
> +	for i in $VERSION; do
> +		[ "$v" = 3 ] && tst_brk TCONF "Test is known to fail on NFSv3"
> +	done
> +
>  	nfs_setup

>  	tst_res TINFO "creating test files"
