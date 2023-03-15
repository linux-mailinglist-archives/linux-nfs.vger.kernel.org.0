Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6496BAF6E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Mar 2023 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCOLkI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Mar 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjCOLkH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Mar 2023 07:40:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0952DE1AF
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 04:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4BC9B81DB5
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 11:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB78C433D2;
        Wed, 15 Mar 2023 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678880403;
        bh=znNRTBiVIdImO4dobppmqItk1hgBj0FGnrb7+ohQJQ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lrtY5mBUWGkQFRZZKiRjE2HSrqKz2D+DzIaa9owj3EJ+fM3QKxd1HZy3buAHWZA6w
         xkkL8eGEe0V+j738g3uEGIdAm3wEQN/mPAXbnKtsDe5PTdCrbLI+LXk/pY2jXR6n8e
         dtZzW6GCkNTk6guyuMmX7PvmSuJst/PU5AmETeGIm/xB0CaLFMDGKn5nNL9b5V0Vor
         B6eOvyrLacviSkXbmMCtKxa4x7e0oz3N9V0uamgq8naVGmHSBibLmoiSMvtO/j48j+
         YZdUvdVaSF96MeeMiNn8jHo/r/LvtWjkDZCk34YMVQzv7m/wWSZvFgS7YKtGwTzuwz
         PlSiCetCoMahw==
Message-ID: <6ac6782b4d3efd8d76b1a590b446631a7f096752.camel@kernel.org>
Subject: Re: nfstest_delegation test can not stop
From:   Jeff Layton <jlayton@kernel.org>
To:     "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
        mora <mora@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Wed, 15 Mar 2023 07:40:01 -0400
In-Reply-To: <d5ed9eec-4bf4-8d70-0960-a30b2ef03938@fujitsu.com>
References: <d5ed9eec-4bf4-8d70-0960-a30b2ef03938@fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-03-14 at 02:28 +0000, zhoujie2011@fujitsu.com wrote:
> hi,
>=20
> I run following test command and stuck at recall12 recall14 recall20=20
> recall22 recall40 recall42 recall48 recall50.
>=20
> ./nfstest_delegation --nfsversion=3D4 -e /nfsroot --server <server ip>=
=20
> --client <client2 ip> --trcdelay 10
> ./nfstest_delegation --nfsversion=3D4.1 -e /nfsroot --server  <server ip>=
=20
> --client <client2 ip> --trcdelay 10
> ./nfstest_delegation --nfsversion=3D4.2 -e /nfsroot --server  <server ip>=
=20
> --client <client2 ip> --trcdelay 10
>=20
> recall12 recall14 recall20 recall22 recall40 recall42 recall48 recall50=
=20
> tests write files after remove.
> After comment out above testcases result is:
> 646 tests (588 passed, 58 failed)
> FAIL: WRITE delegation should be granted
>=20
> run ./nfstest_dio have following messages.
> INFO: 16:19:51.455222 - WRITE delegations are not available -- skipping=
=20
> tests expecting write delegations
>=20
> test OS: RHEL9.2 Nightly Build
> Why do these testcases can not stop?

Are you asking why these testcases don't pass? If you're testing against
the kernel's NFS server then it's because it does not (yet) support
write delegations.
--=20
Jeff Layton <jlayton@kernel.org>
