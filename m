Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CEF6F43CE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEBMZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjEBMZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 08:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915AAE6A
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 05:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8A6623C3
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04953C433D2;
        Tue,  2 May 2023 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683030348;
        bh=dE0BXw8S2d8Spp83u+tI7KEEZzL1wh2CX5ZK4sGTLOw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M5kkGaSkDkzDAjO6Ti1f+vHWcsQ4FhFpP3fjO1N6kShQJuwSWsdi3fYaCVfAO87IQ
         Fsdkarq6Q/eRYlm6OrS8to6wb1EtX99dv5/4PE5Zy5S65+JLPEl+fJf+kpxDU/cagz
         cT1KBAJMgdS2u4U5kqNSRvruqw+uCOWWpqStSXbGW6qsMv4VllFC3iJszI3hL+BuvA
         C1WTGiOWLsVKJzHr/nNZNZyQLNu+t268zIohUNc/xHlK7Ti0aZCVxzpNTQqLLGv3eE
         pC3o/MIwQL1Q7FD4xVwklXbEIed0xfwbu5Rwc3j1u+BTh/NNaJ2+xRZwOyaUGFVmQb
         km3WrCQ+k3ueQ==
Message-ID: <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
From:   Jeff Layton <jlayton@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org
Date:   Tue, 02 May 2023 08:25:46 -0400
In-Reply-To: <20230502075921.3614794-1-pvorel@suse.cz>
References: <20230502075921.3614794-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-02 at 09:59 +0200, Petr Vorel wrote:
> nfs_flock (run via nfslock01.sh) is known to fail on NFS v3 [1]:
>=20
>     not unsharing /var makes AF_UNIX socket for host's rpcbind to become
>     available inside ltp_ns. Then, at NFS v3 mount time, kernel creates
>     an instance of lockd for ltp_ns, and ports for that instance leak to
>     host's rpcbind and overwrite ports for lockd already active for root
>     namespace. This breaks nfs3 file locking.
>=20

Yeccchhh...that is pretty nasty.

rpcbind was obviously written in a time before namespaces were even a
thought to anyone. I wonder if there is something we can do in rpcbind
itself to guard against these sorts of shenanigans? Probably not, I
guess...

Is /var shared between namespaces in this test for some particular
reason?

> Before bd512e733 ("nfs_flock: fail the test if lock/unlock ops fail")
> it run indefinitely with "unhandled error -107":
> [ 2840.099565] lockd: cannot monitor 10.0.0.2
> [ 2840.109353] lockd: cannot monitor 10.0.0.2
> [ 2843.286811] xs_tcp_setup_socket: connect returned unhandled error -107
> [ 2850.198791] xs_tcp_setup_socket: connect returned unhandled error -107
>=20
> bd512e733 caused an early abort (therefore only "cannot monitor 10.0.0.2"
> appears).
>=20
> Although there is suggestion, how to fix the problem in kernel [2]:
>=20
>     > Maybe rpcb_create_local() shall detect that it is not in root
>     > netns, and only try AF_INET connection to > localhost in that case.
>=20
>     That would be simple and might be sensible.  IF changing the AF_UNIX
>     path to "/run/rpcbind.sock" isn't sufficient, then testing for the
>     root_ns is probably the best second option.
>=20

Was it determined that changing the location of the socket wasn't
sufficient to fix this? FWIW, My Fedora 38 machine seems to listen on
that socket already:

    [Socket]
    ListenStream=3D/run/rpcbind.sock

--=20
Jeff Layton <jlayton@kernel.org>
