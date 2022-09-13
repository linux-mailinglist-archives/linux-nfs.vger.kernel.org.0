Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89E5B6C93
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIMLvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIMLvc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 07:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E312ABD
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 04:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B4061444
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 11:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F327C433C1;
        Tue, 13 Sep 2022 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663069888;
        bh=ML7TpIodki0Hevb1WhLDvU4h96LLB9DZhmv02tVnW3k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BzcTbxPyNYLMY3XMDMj//rehRun5Lw3Q4a7I2KIOA9o04n6PUpfbEh2dWw/Y2c4+i
         +qqDLK6CEjLJEVfsWmmkrCYxSJco9AYThly293BUlNr7L+w+ACw9L4xqNCdkJNz9MF
         FmPs13aGsavl6BJuGW0xOdaDmzysioJj60eHz8HVv+vS3GVUzDnRVHVjnIXAXDM2Ff
         QgPWzG7nh2qGl5EixsTri0j5d1t1sKzAV5/Rtxo10wO/0FY16POW+DWDdPsjDEyfLD
         O6iHeKgj3JPFcl9X+Ff+KvV/O8j1a/vUbW94DY+quRM6tTo9br7lnXE/j9GvtnNYvA
         DR4f0A0/EYqgA==
Message-ID: <f85356b31470779736f60500b0a89561db9cf8de.camel@kernel.org>
Subject: Re: nfs client strange behavior with cpuwait and memory writeback
From:   Jeff Layton <jlayton@kernel.org>
To:     Isak <netamego@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 13 Sep 2022 07:51:27 -0400
In-Reply-To: <CAALSs0bxqODBzN0V67ExMCnOJFi_+9vZ0_zK1DTGOomb+H-D7Q@mail.gmail.com>
References: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
         <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
         <CAALSs0bxqODBzN0V67ExMCnOJFi_+9vZ0_zK1DTGOomb+H-D7Q@mail.gmail.com>
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

On Mon, 2022-09-12 at 21:00 +0200, Isak wrote:
> El lun, 12 sept 2022 a las 12:40, Jeff Layton (<jlayton@kernel.org>) escr=
ibi=F3:
> >=20
> > On Sun, 2022-09-11 at 20:58 +0200, Isak wrote:
> > > Hi everybody!!!
> > >=20
> > > I am very happy writing my first email to one of the Linux mailing li=
st.
> > >=20
> > > I have read the faq and i know this mailing list is not a user help
> > > desk but i have strange behaviour with memory write back and NFS.
> > > Maybe someone can help me. I am so sorry if this is not the right
> > > "forum".
> > >=20
> > > I did three simple tests writing to the same NFS filesystem and the
> > > behavior of the cpu and memory is extruding my brain.
> > >=20
> > > The Environment:
> > >=20
> > > - Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same behavio=
r
> > > with Red Hat 7.9)
> > >=20
> > > - One nfs filesystem mounted with sync and without sync
> > >=20
> > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
> > > (rw,relatime,sync,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D2=
55,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx=
.1xx,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=
=3D1x.1x.2xx.1xx)
> > >=20
> > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
> > > (rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,ha=
rd,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1xx,=
mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=3D1x=
.1x.2xx.1xx:)
> > >=20
> > > - Link between nfs client and nfs server is a 10Gb (Fiber) and iperf3
> > > data show the link works at maximum speed. No problems here. I know
> > > there are nfs options like nconnect to improve performance but I am
> > > interested in linux kernel internals.
> > >=20
> > > The test:
> > >=20
> > > 1.- dd in /mnt/test_fs_without_sync
> > >=20
> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > > 5000+0 records in
> > > 5000+0 records out
> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s
> > >=20
> > > * High cpuwait
> > > * High nfs latency
> > > * Writeback in use
> > >=20
> > > Evidences:
> > > https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhntQ0N=
QzeFF51d9qI0=3D
> > >=20
> > > https://i.stack.imgur.com/pTong.png
> > >=20
> > >=20
> > >=20
> > > 2.- dd in /mnt/test_fs_with_sync
> > >=20
> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > > 5000+0 records in
> > > 5000+0 records out
> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s
> > >=20
> > > * High cpuwait
> > > * Low nfs latency
> > > * No writeback
> > >=20
> > > Evidences
> > > https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq9rCi=
dAKL8RpKpDJ8=3D
> > >=20
> > > https://i.stack.imgur.com/Pf1xS.png
> > >=20
> > >=20
> > >=20
> > > 3.- dd in /mnt/test_fs_with_sync and oflag=3Ddirect
> > >=20
> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M oflag=3Ddirect count=3D5000
> > > 5000+0 records in
> > > 5000+0 records out
> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s
> > >=20
> > > * Low cpuwait
> > > * Low nfs latency
> > > * No writeback
> > >=20
> > > Evidences:
> > > https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/qFt/O=
+qFyNj5FUs8k=3D
> > >=20
> > > https://i.stack.imgur.com/Qs6y5.png
> > >=20
> > >=20
> > >=20
> > >=20
> > > The questions:
> > >=20
> > > I know write back is an old issue in linux and seems is the problem
> > > here.I played with vm.dirty_background_bytes/vm.dirty_background_rati=
o
> > > and vm.dirty_background_ratio/vm.dirty_background_ratio (i know only
> > > one is valid) but whatever value put in this tunables I always have
> > > iowait (except from dd with oflag=3Ddirect)
> > >=20
> > > - In test number 2. How is it possible that it has no nfs latency but
> > > has a high cpu wait?
> > >=20
> > > - In test number 2. How is it possible that have almost the same code
> > > path than test number 1? Test number 2 use a nfs filesystem mounted
> > > with sync option but seems to use pagecache codepath (see flame graph=
)
> > >=20
> >=20
> > "sync" just means that the write codepaths do an implicit fsync of the
> > written range after every write. The data still goes through the
> > pagecache in that case. It just does a (synchronous) flush of the data
> > to the server and a commit after every 1M (in your case).
>=20
> Thank you very much Jeff. Understood. My mistake. I thought that, with
> the nfs sync option, page cache was actually not used. What about test
> 2 (with Sync) regarding to cpuwait? Seems like a CPU accounting
> "problem"? I have high cpuwait and low NFS latency (nfsiostat). If dd
> is launched with oflag=3Ddirect in the same NFS filesystem (mounted with
> Sync), page cache is not used and there isn't cpuwait.
>=20
> >=20
> > >=20
> > > - In test number 1. Why isn't there a change in cpuwait behavior when
> > > vm.dirty tunables are changed? (i have tested a lot of combinations)
> > >=20
> > >=20
> >=20
> > Depends on which tunables you're twiddling, but you have 8G of RAM and
> > are writing a 5G file. All of that should fit in the pagecache without
> > needing to flush anything before all the writes are done. I imagine the
> > vm.dirty tunables don't really come into play in these tests, other tha=
n
> > maybe the background ones, and those shouldn't really affect your
> > buffered write throughput.
>=20
> My understanding (surely wrong) about page cache in Linux is that we
> actually have two caches. One is "read cache" and the other is "write
> cache" aka dirty pages so write cache should not exceed the parameter
> vm.dirty_bytes or vm.dirty_ratio so I don't think 5gb file in 8gb RAM
> with low vm.dirty_ratio does much buffering.
>=20

Not exactly.

The VM has two sets of thresholds: dirty_bytes and dirty_ratio, along
with "background" versions of the same tunables. Most distros these days
don't work the "bytes" values, but work with the "ratio" ones, primarily
because memory sizes can vary wildly and that gives better results.

The dirty_ratio indicates the point where the client starts forcibly
flushing pages in order to satisfy new allocation requests. If you want
to do a write, you have to allocate pages to hold the data and that will
block until the ratio of dirty memory to clean is below the threshold.

The dirty_background_ratio indicates the point where the VM starts more
aggressively flushing data in the background, but that doesn't usually
affect userland activity. Your allocations won't block when you exceed
the background ratio, for instance so you can just keep writing and
filling memory.

Ideally, you never want to hit the dirty_ratio, and if things are tuned
well, you never will as long as background writeback is keeping up with
the rate of page dirtying.
--=20
Jeff Layton <jlayton@kernel.org>
