Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6C77F4F6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350220AbjHQLWB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 07:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbjHQLVu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 07:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B030C4
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 04:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0E96285C
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 11:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E523C433C8;
        Thu, 17 Aug 2023 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271308;
        bh=vJdTO354M0nVbmxPVgvEHk4Ql7lO9HGl9Q8kO2TqUW8=;
        h=Subject:From:To:Cc:Date:From;
        b=RtnjWKa8URgJ/+8fzSPCMrq/rWd9Q9FvfXChIKDawcamTWhHrNYFIeTDikc+1n4CM
         lCTK44UytNcSads0E8+jLcZOsgJRMUVf2+UcJYL3N4CQTUbh+/5u2QSF93btF+6HpH
         ZmAn2vGPtaLitEv1tJ6kMslkRUkvQ9b2R0tD92g2x7elM6ICgqmV4e1t3qDJXGL01B
         qJ+DEMzVYR2qb4KUJXatbWJ0fpMCinfOFJ0RNbkswmHMeAZRijxfVpkNwJT+qoEx2r
         B5b9Sqts1zh0czFyF8rNLcXJ2x9oIzF35Fv7M8pkDdzxFft7/OZz99kBwxAIyseLxI
         4/MPqNUlFbj2A==
Message-ID: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
Subject: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 07:21:46 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I finally got my kdevops (https://github.com/linux-kdevops/kdevops) test
rig working well enough to get some publishable results. To run fstests,
kdevops will spin up a server and (in this case) 2 clients to run
xfstests' auto group. One client mounts with default options, and the
other uses NFSv3.

I tested 3 kernels:

v6.4.0 (stock release)
6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday morning)

Here are the results summary of all 3:

KERNEL:    6.4.0
CPUS:      8

nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
  Failures: generic/053 generic/099 generic/105 generic/124=20
    generic/193 generic/258 generic/294 generic/318 generic/319=20
    generic/444 generic/528 generic/529=20
nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
  Failures: generic/053 generic/099 generic/105 generic/186=20
    generic/187 generic/193 generic/294 generic/318 generic/319=20
    generic/357 generic/444 generic/486 generic/513 generic/528=20
    generic/529 generic/578 generic/675 generic/688=20
Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s

KERNEL:    6.5.0-rc6-g4853c74bd7ab
CPUS:      8

nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
  Failures: generic/053 generic/099 generic/105 generic/258=20
    generic/294 generic/318 generic/319 generic/444 generic/529=20
nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
  Failures: generic/053 generic/099 generic/105 generic/186=20
    generic/187 generic/294 generic/318 generic/319 generic/357=20
    generic/444 generic/486 generic/513 generic/529 generic/578=20
    generic/675 generic/688=20
Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s

KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
CPUS:      8

nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
  Failures: generic/053 generic/099 generic/105 generic/258=20
    generic/294 generic/318 generic/319 generic/444 generic/529=20
nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
  Failures: generic/053 generic/099 generic/105 generic/186=20
    generic/187 generic/294 generic/318 generic/319 generic/357=20
    generic/444 generic/486 generic/513 generic/529 generic/578=20
    generic/675 generic/683 generic/684 generic/688=20
Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s

With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
kernel doesn't:

    generic/193	(some sort of setattr problem)
    generic/528	(known problem with btime handling in client that has been =
fixed)

While I haven't investigated, I'm assuming the 193 bug is also something
that has been fixed in recent kernels. There are also 3 other NFSv3
tests that started passing since v6.4.0. I haven't looked into those.

With the linux-next kernel there are 2 new regressions:

    generic/683
    generic/684

Both of these look like problems with setuid/setgid stripping, and still
need to be investigated. I have more verbose result info on the test
failures if anyone is interested.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
