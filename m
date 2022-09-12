Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FC5B5890
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiILKko (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiILKkl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 06:40:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05124BF1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 03:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB06B80C67
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 10:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D707C433C1;
        Mon, 12 Sep 2022 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662979237;
        bh=C0ia97beQmj64otr2GNkJwBIyUq/bGmtAr4yFUWG1pA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=aC9NeaXkcsVAgRsYzOob7bjGewZ9Cqf5L0gNJQd7OLiY5Pc+xaagcBqaBQvBwn1OK
         RcIv1KehEiItWsk7NdzCOOllIfUTpIXSxgbPxWgF0MsyZtJBu2jOncG2fPCQ52x+ZX
         Rm2t6yCvGYC/Ypytv9fPYcR17EBsMLCUdT1rshRzuSZbHUbLC737ZGtN3afxn38an2
         fIuLtAAbc/PvPojE0AzPqhIDs+09vewWz6ZthPlIQNDjPw9jUcM7POfw0eWuTPJ9I/
         M+1A6E4AVz0WSwJ747JN2du3bdnaFlPmV0BTEZ6OEch2mf1aEUgguUo/rGluu9jQce
         tKlKvS2VpWWyw==
Message-ID: <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
Subject: Re: nfs client strange behavior with cpuwait and memory writeback
From:   Jeff Layton <jlayton@kernel.org>
To:     Isak <netamego@gmail.com>, linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 06:40:35 -0400
In-Reply-To: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
References: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-09-11 at 20:58 +0200, Isak wrote:
> Hi everybody!!!
>=20
> I am very happy writing my first email to one of the Linux mailing list.
>=20
> I have read the faq and i know this mailing list is not a user help
> desk but i have strange behaviour with memory write back and NFS.
> Maybe someone can help me. I am so sorry if this is not the right
> "forum".
>=20
> I did three simple tests writing to the same NFS filesystem and the
> behavior of the cpu and memory is extruding my brain.
>=20
> The Environment:
>=20
> - Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same behavior
> with Red Hat 7.9)
>=20
> - One nfs filesystem mounted with sync and without sync
>=20
> 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
> (rw,relatime,sync,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,h=
ard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1xx=
,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=3D1=
x.1x.2xx.1xx)
>=20
> 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
> (rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,p=
roto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1xx,moun=
tvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=3D1x.1x.=
2xx.1xx:)
>=20
> - Link between nfs client and nfs server is a 10Gb (Fiber) and iperf3
> data show the link works at maximum speed. No problems here. I know
> there are nfs options like nconnect to improve performance but I am
> interested in linux kernel internals.
>=20
> The test:
>=20
> 1.- dd in /mnt/test_fs_without_sync
>=20
> dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> 5000+0 records in
> 5000+0 records out
> 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s
>=20
> * High cpuwait
> * High nfs latency
> * Writeback in use
>=20
> Evidences:
> https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhntQ0NQzeF=
F51d9qI0=3D
>=20
> https://i.stack.imgur.com/pTong.png
>=20
>=20
>=20
> 2.- dd in /mnt/test_fs_with_sync
>=20
> dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> 5000+0 records in
> 5000+0 records out
> 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s
>=20
> * High cpuwait
> * Low nfs latency
> * No writeback
>=20
> Evidences
> https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq9rCidAKL=
8RpKpDJ8=3D
>=20
> https://i.stack.imgur.com/Pf1xS.png
>=20
>=20
>=20
> 3.- dd in /mnt/test_fs_with_sync and oflag=3Ddirect
>=20
> dd if=3D/dev/zero of=3Dtest.out bs=3D1M oflag=3Ddirect count=3D5000
> 5000+0 records in
> 5000+0 records out
> 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s
>=20
> * Low cpuwait
> * Low nfs latency
> * No writeback
>=20
> Evidences:
> https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/qFt/O+qFy=
Nj5FUs8k=3D
>=20
> https://i.stack.imgur.com/Qs6y5.png
>=20
>=20
>=20
>=20
> The questions:
>=20
> I know write back is an old issue in linux and seems is the problem
> here.I played with vm.dirty_background_bytes/vm.dirty_background_ratio
> and vm.dirty_background_ratio/vm.dirty_background_ratio (i know only
> one is valid) but whatever value put in this tunables I always have
> iowait (except from dd with oflag=3Ddirect)
>=20
> - In test number 2. How is it possible that it has no nfs latency but
> has a high cpu wait?
>=20
> - In test number 2. How is it possible that have almost the same code
> path than test number 1? Test number 2 use a nfs filesystem mounted
> with sync option but seems to use pagecache codepath (see flame graph)
>=20

"sync" just means that the write codepaths do an implicit fsync of the
written range after every write. The data still goes through the
pagecache in that case. It just does a (synchronous) flush of the data
to the server and a commit after every 1M (in your case).

>=20
> - In test number 1. Why isn't there a change in cpuwait behavior when
> vm.dirty tunables are changed? (i have tested a lot of combinations)
>=20
>=20

Depends on which tunables you're twiddling, but you have 8G of RAM and
are writing a 5G file. All of that should fit in the pagecache without
needing to flush anything before all the writes are done. I imagine the
vm.dirty tunables don't really come into play in these tests, other than
maybe the background ones, and those shouldn't really affect your
buffered write throughput.
--=20
Jeff Layton <jlayton@kernel.org>
