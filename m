Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA16F5B8771
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINLqK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiINLqJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 07:46:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66127AC24
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 04:46:05 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c19so8667224qkm.7
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=mr2q6up8sRp0Iq/rjMUChN+ahUikauuKGydfHuSFITg=;
        b=0pBXUVWnXmV1NlWchCfg6dty2djPPKRRQrhj2+250EGPsG5dP9a3YMAiBP3QEeGDyx
         O5pJzsBEBHzrSfrSI8t2u/bT2jz+JDOxQbnvDYw3f7etJVhunSQtmleeFRrf/AI8pC3a
         TJf3vWnGveUEw4uJkl1hfN3vcl5a2vLCpcsmwKpxlVmN8SefGx62nucJnelDh0AT3OcK
         o6A1yBpsbUX0mjck7KZ5dFqtFAKISncjb1SLwkeE4DxWjeMpSJlIigfHreV6pSgOCBR4
         IQqdZ0g0TgDNc68c/qovpIgGdHbGbvZFpTFF/ClIu3R+HzCC5bjnxneHxANXAe5eLT0+
         sMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mr2q6up8sRp0Iq/rjMUChN+ahUikauuKGydfHuSFITg=;
        b=75TYhrpxsTKfieRB/Wul0RR3YosHcO7v1/KgzrsGG1Vr/rK9ra0r9dVPLx7TxRRgYR
         MPzl+V8vaIhHDhlpwOjcriBS6aZt3Q354YE27S3FroUF2sLBzrqgsV+RxndnZO8wMHnt
         wRDumx7wOv/iNz3RgyXUTPRS8WAX3NutfRuWbxmMkVKqDTWUJYiilvmIlTX8jMvbNKdI
         QA0x+SAk1QT4dG2sFnCmiz5sTEyV1H/0IVIYiX/+K45stptkzH7X8aXCOUOmvdtosoa3
         sij0jIqA0jd6k5Zy7kLxIcvWg1eTb96+zMkc91q0qn6C9AfXG1LS53rd+QnXr2phLfU3
         UvhQ==
X-Gm-Message-State: ACgBeo1HIOsr27TjQMeY6P/FSwDJ3d0+qPChutuiOzLP1/C3JFDWvZeL
        YXZv9hQikIBQbUyc4ue8aDMyNAaL/4L92Q==
X-Google-Smtp-Source: AA6agR4y02a86BDCmITDFgsB3raYctjz8gplidSkNFiSyQj6g4YikYyJuwht/lgIJLg0dv+gSXSuYA==
X-Received: by 2002:a37:6905:0:b0:6bb:5827:e658 with SMTP id e5-20020a376905000000b006bb5827e658mr26602477qkc.735.1663155964696;
        Wed, 14 Sep 2022 04:46:04 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a430800b006bb208bd889sm1605896qko.120.2022.09.14.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:46:03 -0700 (PDT)
Message-ID: <d58ad71b011adba97b7f1d24f01d416a92977eca.camel@poochiereds.net>
Subject: Re: nfs client strange behavior with cpuwait and memory writeback
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Isak <netamego@gmail.com>, linux-nfs@vger.kernel.org
Date:   Wed, 14 Sep 2022 07:46:02 -0400
In-Reply-To: <CAALSs0bq2hnU45XwXQxY07pxDAy=eSWCMGrAZgD9+9KQ8qyi3w@mail.gmail.com>
References: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
         <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
         <CAALSs0bxqODBzN0V67ExMCnOJFi_+9vZ0_zK1DTGOomb+H-D7Q@mail.gmail.com>
         <f85356b31470779736f60500b0a89561db9cf8de.camel@kernel.org>
         <CAALSs0bq2hnU45XwXQxY07pxDAy=eSWCMGrAZgD9+9KQ8qyi3w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-09-13 at 21:12 +0200, Isak wrote:
> Thank you very much Jeff. Understood. That explains why I have high cpu
> iowait and high latency (nfsiostat) when launching a dd to an NFS
> filesystem without the sync option. Surely my vm.dirty tunables are wrong
> for the workload. Maybe more RAM is needed.
>=20
> But what about dd to NFS filesystem mounted with Sync (Test 2)?. As I
> understood (from your free lessons) VM.dirty tunables don't have much sen=
se
> in that scenario because a fsync is done after 1MB write (in my case). I
> have high cpuwait and low NFS latency (nfsiostat).How is This posible?Thi=
s
> is extruding my brain. If dd is launched with oflag=3Ddirect in the same =
NFS
> filesystem (mounted with Sync), page cache is not used and there isn't
> cpuwait.
>=20
>=20
> Thank you very much.
>=20

I'm not familiar with the tool you used to collect this info, but
assuming that the "wa" column refers to the same thing as it would in
vmstat, then what you're talking about is iowait:

    wa: Time spent waiting for IO.  Prior to Linux 2.5.41, included in idle=
.

That just means that the CPU was waiting for I/O to complete, which is
basically what you'd expect with a sync mount. Each of those COMMIT
calls at the end of the writes is synchronous and the CPU has to wait
for it to complete.

> 2022-09-13 13:51 GMT+02:00, Jeff Layton <jlayton@kernel.org>:
> > On Mon, 2022-09-12 at 21:00 +0200, Isak wrote:
> > > El lun, 12 sept 2022 a las 12:40, Jeff Layton (<jlayton@kernel.org>)
> > > escribi=F3:
> > > >=20
> > > > On Sun, 2022-09-11 at 20:58 +0200, Isak wrote:
> > > > > Hi everybody!!!
> > > > >=20
> > > > > I am very happy writing my first email to one of the Linux mailin=
g
> > > > > list.
> > > > >=20
> > > > > I have read the faq and i know this mailing list is not a user he=
lp
> > > > > desk but i have strange behaviour with memory write back and NFS.
> > > > > Maybe someone can help me. I am so sorry if this is not the right
> > > > > "forum".
> > > > >=20
> > > > > I did three simple tests writing to the same NFS filesystem and t=
he
> > > > > behavior of the cpu and memory is extruding my brain.
> > > > >=20
> > > > > The Environment:
> > > > >=20
> > > > > - Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same
> > > > > behavior
> > > > > with Red Hat 7.9)
> > > > >=20
> > > > > - One nfs filesystem mounted with sync and without sync
> > > > >=20
> > > > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
> > > > > (rw,relatime,sync,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=
=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x=
.2xx.1xx,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,=
addr=3D1x.1x.2xx.1xx)
> > > > >=20
> > > > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
> > > > > (rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.=
1xx,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=
=3D1x.1x.2xx.1xx:)
> > > > >=20
> > > > > - Link between nfs client and nfs server is a 10Gb (Fiber) and ip=
erf3
> > > > > data show the link works at maximum speed. No problems here. I kn=
ow
> > > > > there are nfs options like nconnect to improve performance but I =
am
> > > > > interested in linux kernel internals.
> > > > >=20
> > > > > The test:
> > > > >=20
> > > > > 1.- dd in /mnt/test_fs_without_sync
> > > > >=20
> > > > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > > > > 5000+0 records in
> > > > > 5000+0 records out
> > > > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s
> > > > >=20
> > > > > * High cpuwait
> > > > > * High nfs latency
> > > > > * Writeback in use
> > > > >=20
> > > > > Evidences:
> > > > > https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhn=
tQ0NQzeFF51d9qI0=3D
> > > > >=20
> > > > > https://i.stack.imgur.com/pTong.png
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > 2.- dd in /mnt/test_fs_with_sync
> > > > >=20
> > > > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
> > > > > 5000+0 records in
> > > > > 5000+0 records out
> > > > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s
> > > > >=20
> > > > > * High cpuwait
> > > > > * Low nfs latency
> > > > > * No writeback
> > > > >=20
> > > > > Evidences
> > > > > https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq=
9rCidAKL8RpKpDJ8=3D
> > > > >=20
> > > > > https://i.stack.imgur.com/Pf1xS.png
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > 3.- dd in /mnt/test_fs_with_sync and oflag=3Ddirect
> > > > >=20
> > > > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M oflag=3Ddirect count=3D50=
00
> > > > > 5000+0 records in
> > > > > 5000+0 records out
> > > > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s
> > > > >=20
> > > > > * Low cpuwait
> > > > > * Low nfs latency
> > > > > * No writeback
> > > > >=20
> > > > > Evidences:
> > > > > https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/q=
Ft/O+qFyNj5FUs8k=3D
> > > > >=20
> > > > > https://i.stack.imgur.com/Qs6y5.png
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > The questions:
> > > > >=20
> > > > > I know write back is an old issue in linux and seems is the probl=
em
> > > > > here.I played with
> > > > > vm.dirty_background_bytes/vm.dirty_background_ratio
> > > > > and vm.dirty_background_ratio/vm.dirty_background_ratio (i know o=
nly
> > > > > one is valid) but whatever value put in this tunables I always ha=
ve
> > > > > iowait (except from dd with oflag=3Ddirect)
> > > > >=20
> > > > > - In test number 2. How is it possible that it has no nfs latency=
 but
> > > > > has a high cpu wait?
> > > > >=20
> > > > > - In test number 2. How is it possible that have almost the same =
code
> > > > > path than test number 1? Test number 2 use a nfs filesystem mount=
ed
> > > > > with sync option but seems to use pagecache codepath (see flame
> > > > > graph)
> > > > >=20
> > > >=20
> > > > "sync" just means that the write codepaths do an implicit fsync of =
the
> > > > written range after every write. The data still goes through the
> > > > pagecache in that case. It just does a (synchronous) flush of the d=
ata
> > > > to the server and a commit after every 1M (in your case).
> > >=20
> > > Thank you very much Jeff. Understood. My mistake. I thought that, wit=
h
> > > the nfs sync option, page cache was actually not used. What about tes=
t
> > > 2 (with Sync) regarding to cpuwait? Seems like a CPU accounting
> > > "problem"? I have high cpuwait and low NFS latency (nfsiostat). If dd
> > > is launched with oflag=3Ddirect in the same NFS filesystem (mounted w=
ith
> > > Sync), page cache is not used and there isn't cpuwait.
> > >=20
> > > >=20
> > > > >=20
> > > > > - In test number 1. Why isn't there a change in cpuwait behavior =
when
> > > > > vm.dirty tunables are changed? (i have tested a lot of combinatio=
ns)
> > > > >=20
> > > > >=20
> > > >=20
> > > > Depends on which tunables you're twiddling, but you have 8G of RAM =
and
> > > > are writing a 5G file. All of that should fit in the pagecache with=
out
> > > > needing to flush anything before all the writes are done. I imagine=
 the
> > > > vm.dirty tunables don't really come into play in these tests, other
> > > > than
> > > > maybe the background ones, and those shouldn't really affect your
> > > > buffered write throughput.
> > >=20
> > > My understanding (surely wrong) about page cache in Linux is that we
> > > actually have two caches. One is "read cache" and the other is "write
> > > cache" aka dirty pages so write cache should not exceed the parameter
> > > vm.dirty_bytes or vm.dirty_ratio so I don't think 5gb file in 8gb RAM
> > > with low vm.dirty_ratio does much buffering.
> > >=20
> >=20
> > Not exactly.
> >=20
> > The VM has two sets of thresholds: dirty_bytes and dirty_ratio, along
> > with "background" versions of the same tunables. Most distros these day=
s
> > don't work the "bytes" values, but work with the "ratio" ones, primaril=
y
> > because memory sizes can vary wildly and that gives better results.
> >=20
> > The dirty_ratio indicates the point where the client starts forcibly
> > flushing pages in order to satisfy new allocation requests. If you want
> > to do a write, you have to allocate pages to hold the data and that wil=
l
> > block until the ratio of dirty memory to clean is below the threshold.
> >=20
> > The dirty_background_ratio indicates the point where the VM starts more
> > aggressively flushing data in the background, but that doesn't usually
> > affect userland activity. Your allocations won't block when you exceed
> > the background ratio, for instance so you can just keep writing and
> > filling memory.
> >=20
> > Ideally, you never want to hit the dirty_ratio, and if things are tuned
> > well, you never will as long as background writeback is keeping up with
> > the rate of page dirtying.
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@poochiereds.net>
