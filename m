Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4792F62D8C4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 12:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKQLFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 06:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiKQLFM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 06:05:12 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D583697FF
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 03:04:05 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e68so1451951ybh.2
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8BsnU81fhfTDfTucjla4FkpxVPiE9sYSZq35jQOb3w=;
        b=bmLXyfRL+q4m4Gwz1XcioXGP6oC6pm+HaNtz4RWCGZvwQT1H/SMgTYAwXEiMx494aN
         8FqRxdx2MhOCSTkzB5xVqxYUb6yinv3jaVtifOF2f/JZZQil/oXb+yG24xRPzKUQU7H4
         W0WhevqWUq3Bxu0XrcbvYmdPpF4gqr33Hd3JTcm9eNXMoDcYRS7oGY26gr/x70cZadCS
         YsalX1TQoxFm2LIaWC2BOn95oUnd52YYrlxaahcdpv9mSpfESvNcNOz9TnH9PLrS8JoP
         f4/AhdZDmORgcMP3CFY4fymyhFkLkSSv3GQNAvj2Xpw2bFM/itfTGYvivM57zTeDrk8T
         vWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8BsnU81fhfTDfTucjla4FkpxVPiE9sYSZq35jQOb3w=;
        b=2z07SqFVhK/QVbVlkBjxPbYE92Heq28gtIotO9yG6RHxYtlaIhqmcmHmDFShIglMpR
         YYqQjqBndF6uFFzYkq1pbJaLwiVZAYANJnAXjS1g4VlXvRueOfvBCx3zrUROPXiFbS1J
         nlWXv2mWOcWVy7Q4r+bR3MdoSg0xgy4iaYK4ozxjPHGqoMxKhAyE6qlGx3jLbPGr533n
         pvjoMq+fs0wRfxNovYcH/9WR/pPN4PUhPP0petS7ne2xv/6R2Sd9IkhXt27kIunix1mu
         MLzBMKJvKhXbx/GtHBaaPe6gKzk7wjl+dHj9Xl640+Ne7OJhJUT3TKHqKqXiupTIEEng
         2Hew==
X-Gm-Message-State: ANoB5pno0wP9/l+fzEFA0MmBvuRi4HEkVbHosgXzWjuaLKgtO/lkFs5O
        jqof2Igg5NuBLGbfNVAPa8n3eOk1dlSd0vPpydn8tQ==
X-Google-Smtp-Source: AA0mqf6TV5J/48X8U1fBJvUwg1UER3jzHIJO1+pdF4thFKgDNORHvyE35qFbgIoev/G0RDtTsz5r3Lk/VCccVKxXALg=
X-Received: by 2002:a05:6902:1346:b0:6be:d455:afc9 with SMTP id
 g6-20020a056902134600b006bed455afc9mr1463858ybu.625.1668683044373; Thu, 17
 Nov 2022 03:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20221017105212.77588-1-dwysocha@redhat.com> <20221017105212.77588-4-dwysocha@redhat.com>
 <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
 <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
 <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
 <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
 <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
 <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com> <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
 <CALF+zOk3Q_UO9KG3Lxm-22e=nC338DGLndbHAfk1wkPaADOvkg@mail.gmail.com>
 <CA+QRt4s4+pF+C3Bk-wgoPjGNZwDbBGFPAQ=-Fbrgt6ejrfqsTA@mail.gmail.com>
 <CALF+zOnd+7YsofF3K7r8hdki8H-B5jWYnZfFpyO=nGzfxi=B2A@mail.gmail.com> <CA+QRt4tvc7RT2VuUB+h6kmWnjMC6a3+=qDwH1C+ye50CM36u6A@mail.gmail.com>
In-Reply-To: <CA+QRt4tvc7RT2VuUB+h6kmWnjMC6a3+=qDwH1C+ye50CM36u6A@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 17 Nov 2022 11:03:27 +0000
Message-ID: <CAPt2mGPMn7C31NgTvR-DNUMsqCCtSSZTfkkFSp0iMd6G8nifdA@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs when
 fscache is enabled
To:     Benjamin Maynard <benmaynard@google.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Brennan Doyle <brennandoyle@google.com>,
        Jeff Layton <jlayton@poochiereds.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I just wanted to take the opportunity to reiterate why these patches
are important to me (and others like Benjamin).

The "new" fscache that is now in mainline has a major NFS performance
regression from the previous fscache code in pre 5.17 kernels - single
file reads from cache.

Even if you have the fastest local disk (nvme/ssd) for your fscache,
reading back a cached file (via NFS) now tops out at around 40MB/s
whereas before (old fscache) the local fscache disk speed was the only
limit (e.g. 5000MB/s for NVMe).

So, in many cases, depending on what you are using fscache for, it can
be faster to read the file over the (gigabit) network than from the
local disk cache which somewhat negates its usefulness. As such, we
mostly use pre-5.17 kernels in production and the old fscache code
which maintains high cache read performance (but has other annoying
issues).

Now this performance regression might not be noticed too much by
desktop users looking to use fscache on their systems, but it sure
does affect servers (e.g. re-export servers) that want to use fscache
to achieve very high performance.

I can't really comment on these patches or the approach taken, but I
do hope that we can restore/improve the fscache read performance for
NFS in the mainline kernel as soon as possible (like these patches
do).

Daire


On Mon, 14 Nov 2022 at 21:26, Benjamin Maynard <benmaynard@google.com> wrot=
e:
>
> Thanks Dave, that did the trick!
>
> Building the kernel from
> https://github.com/DaveWysochanskiRH/kernel/commit/42f58f3d36d83839022dc2=
617bb6c2d1b09db65f
> and re-running the exact same tests yielded the expected results. Data
> is now being served from /var/cache/fscache.
>
> I also reverted my change to the read ahead, so that read ahead is now
> greater than the rsize. Still works as expected.
>
> I am also seeing much better single file read speeds, and culling is
> working perfectly (not running into the issue we were seeing pre
> 5.17).
>
> Thanks a lot Dave, Jeff and Daire for your help.
>
> Kind Regards
> Benjamin Maynard
>
>
>
> Kind Regards
>
> Benjamin Maynard
>
> Customer Engineer
>
> benmaynard@google.com
>
> Google, Inc.
>
>
>
>
> On Mon, 14 Nov 2022 at 17:35, David Wysochanski <dwysocha@redhat.com> wro=
te:
> >
> > On Mon, Nov 14, 2022 at 11:04 AM Benjamin Maynard <benmaynard@google.co=
m> wrote:
> > >
> > > Hi Dave,
> > >
> > > I've added responses to your questions inline below.
> > >
> > > I also tried adding the noatime option to the mount on the source
> > > filer as Jeff suggested, but this has not made any difference and the
> > > issue is still persisting for me.
> > >
> > > I created the following diagram that explains my setup, and the exact
> > > tests I am performing:
> > > https://drive.google.com/file/d/12Xf-9yHCKM4eMr2YGqdSAVfGcximW4OG/vie=
w?usp=3Dsharing.
> > >
> > > Hopefully this is clearer than my explanations below (let me know if
> > > you'd prefer me to share an alternative way).
> > >
> > Yes, that's very helpful.  Let me think about this one as I'm not sure.
> > As Jeff says we may need tracepoints to track it down if I cannot repro
> > it and/or nothing comes to mind.
> >
> > > In order to remove the re-exporting layer of complexity, I also
> > > performed the tests without the re-export server (architecture:
> > > https://drive.google.com/file/d/1DQKhqo_UnQ8ul-z5Iram5LpisDmkKziQ/vie=
w?usp=3Dshare_link):
> > >
> > > Source NFS Server <-- Client (with FS-Cache)
> > >
> > > The same is happening, I cannot get FS-Cache to serve from cache.
> > > Heavy writes, but no reads, even when the same file is copied many
> > > times.
> > >
> > I'm pretty sure the above you're hitting the drop_caches /
> > "fscache read optimisation" issue #1 I mentioned.
> >
> > I see dhowells just posted a v2 version of his previous patch:
> > https://lore.kernel.org/linux-mm/166844174069.1124521.10890506360974169=
994.stgit@warthog.procyon.org.uk/
> >
> > I started with 6.1-rc5, added the above dhowells latest patch for that =
issue,
> > and then my 5 patches on top.  Then I added a small patch to utilize
> > dhowells patch to ensure the read optimisation is removed.  I ran my
> > unit test that has been failing all along and as expected it passes wit=
h
> > these patches.  I pushed the series to github:
> > https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> > https://github.com/DaveWysochanskiRH/kernel/commit/42f58f3d36d83839022d=
c2617bb6c2d1b09db65f
> >
> > I will also email you the series of patches on top of 6.1-rc5 so you
> > can just apply from your mailbox if you want.
> >
> >
> >
> > > Hopefully something I am doing wrong on my end, but I can't figure ou=
t what.
> > >
> > > Kind Regards
> > > Benjamin Maynard
> > >
> > >
> > > On Mon, 14 Nov 2022 at 13:47, David Wysochanski <dwysocha@redhat.com>=
 wrote:
> > > >
> > > > I apologize I did not read carefully enough and I missed some detai=
ls
> > > > in your original post.
> > > > More below.
> > > >
> > > > On Sat, Nov 12, 2022 at 7:47 AM Benjamin Maynard <benmaynard@google=
.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > I've been doing some more testing with these patches, I applied a=
ll of
> > > > > the patches (v10 from
> > > > > https://patchwork.kernel.org/project/linux-nfs/list/?series=3D691=
729)
> > > > > apart from Patch 6 (the RFC patch) to version 6.0.8 of the kernel=
.
> > > > >
> > > > > I have the following setup:
> > > > >
> > > > > Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Cl=
ient.
> > > > >
> > > > > I have a 500Gb file on the Source NFS Server, which I am then cop=
ying
> > > > > to the NFS Client via the Re-Export Server.
> > > > >
> > > > > On the first copy, I see heavy writes to /var/cache/fscache on th=
e
> > > > > re-export server, and once the file copy completes I see that
> > > > > /var/cache/fscache is approximately 500Gb in size. All good so fa=
r.
> > > > >
> > > > > I then deleted that file from the NFS Client, and dropped the cac=
hes
> > > > > just to be safe (echo 3 > /proc/sys/vm/drop_caches on the NFS Cli=
ent).
> > > > >
> > > > If you delete the file from the NFS client, how does that not delet=
e the
> > > > file from the original NFS server?
> > >
> > > Sorry - to be clear, I never deleted the file from the NFS mount
> > > (which I know would in turn delete it from the re-export server and
> > > the source filer).
> > >
> > > In order to perform the performance test, I copied the file from the
> > > NFS mount on the NFS Client, to a local directory (cp
> > > /mnt/nfs/500gb.img /tmp).
> > >
> > > When I said "I then deleted that file from the NFS Client", I meant I
> > > deleted the local copy of that file. Not the file on the mount (rm
> > > /tmp/500gb.img).
> > >
> > > Just to also stress, I have never dropped the caches on the Re-Export
> > > Server (the one with FS-Cache) at any point in any of these tests, so
> > > I don't think this is the problem. I have only ever dropped the cache=
s
> > > on the NFS client that is mounting the Re-Export Server.
> > >
> > > > > I then performed another copy of the 500Gb file on the NFS Client=
,
> > > > > again via the Re-Export Server. What I expected would happen is t=
hat I
> > > > > would see heavy reads from the /var/cache/fscache volume as the f=
ile
> > > > > should be served from FS-Cache.
> > > > >
> > > > I don't understand this.  When you say you "performed another copy"
> > > > of what file?  Wasn't the file deleted in the above step?
> > >
> > > As above, only the local copy was deleted.
> > >
> > > > > However what I actually saw was no reads whatsoever, FS-Cache see=
ms to
> > > > > be ignored and the file is pulled from the Source NFS Filer again=
. I
> > > > > also see heavy writes to /var/cache/fscache, so it appears that
> > > > > FS-Cache is overwriting its existing cache, and never using it.
> > > >
> > > > That would happen if the file was changed or re-created.
> > > >
> > > > > I only have 104Gb of memory on the Re-Export Server (with FS-Cach=
e) so
> > > > > it is not possible that the file is being served from the page ca=
che.
> > > > >
> > > > > We saw this behaviour before on an older set of the patches when =
our
> > > > > mount between the Re-Export Server and the Source NFS Filer was u=
sing
> > > > > the "sync" option, but we are now using the "async" option and th=
e
> > > > > same is happening.
> > > > >
> > > > > Mount options:
> > > > >
> > > > > Source NFS Server <-- Re-Export Server (with FS-Cache):
> > > > >
> > > > > 10.0.0.49:/files /srv/nfs/files nfs
> > > > > rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
acregmin=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,prot=
o=3Dtcp,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.=
49,mountvers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,a=
ddr=3D10.0.0.49
> > > > >
> > > > > Re-Export Server (with FS-Cache) <-- NFS Client:
> > > > >
> > > > > 10.0.0.3:/files /mnt/nfs nfs
> > > > > rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255=
,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.3,mo=
untvers=3D3,mountport=3D20048,mountproto=3Dtcp,local_lock=3Dnone,addr=3D10.=
0.0.3
> > > > >
> > > > > It is also worth noting this behaviour is not unique to the re-ex=
port
> > > > > use case. I see FS-Cache not being used with the following setup:
> > > > >
> > > > > Source NFS Server <-- Client (with FS-Cache).
> > > > >
> > > >
> > > > This points at something more fundamental like something missed
> > > > in the test or maybe a mount option.  Can you explain what test
> > > > you're doing here when you say "this behavior is not unique"?
> > >
> > > I've created the following diagram which explains the test I am
> > > performing. I think it is a little easier to follow than explaining i=
n
> > > text. This should be viewable without any authentication:
> > > https://drive.google.com/file/d/12Xf-9yHCKM4eMr2YGqdSAVfGcximW4OG/vie=
w?usp=3Dsharing.
> > >
> > > By "this behaviour is not unique to the re-export use case" I mean
> > > that the same happens if I remove the re-export server completely, an=
d
> > > just have the following setup:
> > >
> > > Source NFS Server <-- Client (with FS-Cache).
> > >
> > > > Can you show the mount options for both:
> > > > - fscache filesystem on the re-export server (/var/cache/fscache)
> > >
> > > root@reexport:~$ mount | grep /var/cache/fscache
> > > /dev/md127 on /var/cache/fscache type ext4
> > > (rw,relatime,discard,nobarrier,stripe=3D1024)
> > >
> > > > - exported filesystem on the NFS server (filesystem in /etc/exports=
)
> > >
> > > I have tried both:
> > >
> > > root@source:~$ mount | grep files
> > > /dev/sdb1 on /files type ext4 (rw)
> > >
> > > root@source:~$ cat /etc/exports
> > > /files 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subt=
ree_check,sec=3Dsys,secure,nohide)
> > >
> > > and (at Jeff's suggestion):
> > >
> > > root@source:~$ mount | grep files
> > > /dev/sdb1 on /files type ext4 (rw,noatime)
> > >
> > > root@source:~$ cat /etc/exports
> > > /files 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subt=
ree_check,sec=3Dsys,secure,nohide)
> > >
> > >
> > > > Unfortunately the problem with drop_caches makes it more difficult
> > > > to know when fscache is truly working.  But some other unit test
> > > > I have shows fscache does work with this patchset so I'm puzzled wh=
y
> > > > you're not seeing it work at all.
> > > >
> > > > I pinged dhowells on the drop_caches issue so maybe we can get
> > > > that one sorted out soon but I'm not sure since it's part of a seri=
es
> > > > and proposes changes in mm.
> > >
> > > Just to be clear, I have never used drop_caches on the re-export
> > > server in any of these tests. I have only ever done this on the NFS
> > > Client.
> > >
> > > >
> > > > > Thanks,
> > > > > Ben
> > > > >
> > > > >
> > > > > Kind Regards
> > > > >
> > > > > Benjamin Maynard
> > > > >
> > > > > Customer Engineer
> > > > >
> > > > > benmaynard@google.com
> > > > >
> > > > > Google, Inc.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > On Mon, 31 Oct 2022 at 22:22, Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > On Oct 30, 2022, at 19:25, David Wysochanski <dwysocha@redhat=
.com> wrote:
> > > > > > >
> > > > > > > On Sat, Oct 29, 2022 at 12:46 PM David Wysochanski <dwysocha@=
redhat.com> wrote:
> > > > > > >>
> > > > > > >> On Fri, Oct 28, 2022 at 12:59 PM Trond Myklebust <trondmy@ke=
rnel.org> wrote:
> > > > > > >>>
> > > > > > >>> On Fri, 2022-10-28 at 07:50 -0400, David Wysochanski wrote:
> > > > > > >>>> On Thu, Oct 27, 2022 at 3:16 PM Trond Myklebust <trondmy@k=
ernel.org>
> > > > > > >>>> wrote:
> > > > > > >>>>>
> > > > > > >>>>> On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote=
:
> > > > > > >>>>>> Convert the NFS buffered read code paths to correspondin=
g netfs
> > > > > > >>>>>> APIs,
> > > > > > >>>>>> but only when fscache is configured and enabled.
> > > > > > >>>>>>
> > > > > > >>>>>> The netfs API defines struct netfs_request_ops which mus=
t be
> > > > > > >>>>>> filled
> > > > > > >>>>>> in by the network filesystem.  For NFS, we only need to =
define 5
> > > > > > >>>>>> of
> > > > > > >>>>>> the functions, the main one being the issue_read() funct=
ion.
> > > > > > >>>>>> The issue_read() function is called by the netfs layer w=
hen a
> > > > > > >>>>>> read
> > > > > > >>>>>> cannot be fulfilled locally, and must be sent to the ser=
ver
> > > > > > >>>>>> (either
> > > > > > >>>>>> the cache is not active, or it is active but the data is=
 not
> > > > > > >>>>>> available).
> > > > > > >>>>>> Once the read from the server is complete, netfs require=
s a call
> > > > > > >>>>>> to
> > > > > > >>>>>> netfs_subreq_terminated() which conveys either how many =
bytes
> > > > > > >>>>>> were
> > > > > > >>>>>> read
> > > > > > >>>>>> successfully, or an error.  Note that issue_read() is ca=
lled with
> > > > > > >>>>>> a
> > > > > > >>>>>> structure, netfs_io_subrequest, which defines the IO req=
uested,
> > > > > > >>>>>> and
> > > > > > >>>>>> contains a start and a length (both in bytes), and assum=
es the
> > > > > > >>>>>> underlying
> > > > > > >>>>>> netfs will return a either an error on the whole region,=
 or the
> > > > > > >>>>>> number
> > > > > > >>>>>> of bytes successfully read.
> > > > > > >>>>>>
> > > > > > >>>>>> The NFS IO path is page based and the main APIs are the =
pgio APIs
> > > > > > >>>>>> defined
> > > > > > >>>>>> in pagelist.c.  For the pgio APIs, there is no way for t=
he caller
> > > > > > >>>>>> to
> > > > > > >>>>>> know how many RPCs will be sent and how the pages will b=
e broken
> > > > > > >>>>>> up
> > > > > > >>>>>> into underlying RPCs, each of which will have their own
> > > > > > >>>>>> completion
> > > > > > >>>>>> and
> > > > > > >>>>>> return code.  In contrast, netfs is subrequest based, a =
single
> > > > > > >>>>>> subrequest may contain multiple pages, and a single subr=
equest is
> > > > > > >>>>>> initiated with issue_read() and terminated with
> > > > > > >>>>>> netfs_subreq_terminated().
> > > > > > >>>>>> Thus, to utilze the netfs APIs, NFS needs some way to ac=
commodate
> > > > > > >>>>>> the netfs API requirement on the single response to the =
whole
> > > > > > >>>>>> subrequest, while also minimizing disruptive changes to =
the NFS
> > > > > > >>>>>> pgio layer.
> > > > > > >>>>>>
> > > > > > >>>>>> The approach taken with this patch is to allocate a smal=
l
> > > > > > >>>>>> structure
> > > > > > >>>>>> for each nfs_netfs_issue_read() call, store the final er=
ror and
> > > > > > >>>>>> number
> > > > > > >>>>>> of bytes successfully transferred in the structure, and =
update
> > > > > > >>>>>> these
> > > > > > >>>>>> values
> > > > > > >>>>>> as each RPC completes.  The refcount on the structure is=
 used as
> > > > > > >>>>>> a
> > > > > > >>>>>> marker
> > > > > > >>>>>> for the last RPC completion, is incremented in
> > > > > > >>>>>> nfs_netfs_read_initiate(),
> > > > > > >>>>>> and decremented inside nfs_netfs_read_completion(), when=
 a
> > > > > > >>>>>> nfs_pgio_header
> > > > > > >>>>>> contains a valid pointer to the data.  On the final put =
(which
> > > > > > >>>>>> signals
> > > > > > >>>>>> the final outstanding RPC is complete) in
> > > > > > >>>>>> nfs_netfs_read_completion(),
> > > > > > >>>>>> call netfs_subreq_terminated() with either the final err=
or value
> > > > > > >>>>>> (if
> > > > > > >>>>>> one or more READs complete with an error) or the number =
of bytes
> > > > > > >>>>>> successfully transferred (if all RPCs complete successfu=
lly).
> > > > > > >>>>>> Note
> > > > > > >>>>>> that when all RPCs complete successfully, the number of =
bytes
> > > > > > >>>>>> transferred
> > > > > > >>>>>> is capped to the length of the subrequest.  Capping the
> > > > > > >>>>>> transferred
> > > > > > >>>>>> length
> > > > > > >>>>>> to the subrequest length prevents "Subreq overread" warn=
ings from
> > > > > > >>>>>> netfs.
> > > > > > >>>>>> This is due to the "aligned_len" in nfs_pageio_add_page(=
), and
> > > > > > >>>>>> the
> > > > > > >>>>>> corner case where NFS requests a full page at the end of=
 the
> > > > > > >>>>>> file,
> > > > > > >>>>>> even when i_size reflects only a partial page (NFS overr=
ead).
> > > > > > >>>>>>
> > > > > > >>>>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > >>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > >>>>>
> > > > > > >>>>>
> > > > > > >>>>> This is not doing what I asked for, which was to separate=
 out the
> > > > > > >>>>> fscache functionality, so that we can call that if and wh=
en it is
> > > > > > >>>>> available.
> > > > > > >>>>>
> > > > > > >>>> I must have misunderstood then.
> > > > > > >>>>
> > > > > > >>>> The last feedback I have from you was that you wanted it t=
o be
> > > > > > >>>> an opt-in feature, and it was a comment on a previous patc=
h
> > > > > > >>>> to Kconfig.  I was proceeding the best I knew how, but
> > > > > > >>>> let me try to get back on track.
> > > > > > >>>>
> > > > > > >>>>> Instead, it is just wrapping the NFS requests inside netf=
s
> > > > > > >>>>> requests. As
> > > > > > >>>>> it stands, that means it is just duplicating information,=
 and
> > > > > > >>>>> adding
> > > > > > >>>>> unnecessary overhead to the standard I/O path (extra allo=
cations,
> > > > > > >>>>> extra
> > > > > > >>>>> indirect calls, and extra bloat to the inode).
> > > > > > >>>>>
> > > > > > >>>> I think I understand what you're saying but I'm not sure. =
 Let me
> > > > > > >>>> ask some clarifying questions.
> > > > > > >>>>
> > > > > > >>>> Are you objecting to the code when CONFIG_NFS_FSCACHE is
> > > > > > >>>> configured?  Or when it is not?  Or both?  I think you're =
objecting
> > > > > > >>>> when it's configured, but not enabled (we mount without 'f=
sc').
> > > > > > >>>> Am I right?
> > > > > > >>>>
> > > > > > >>>> Also, are you objecting to the design that to use fcache w=
e now
> > > > > > >>>> have to use netfs, specifically:
> > > > > > >>>> - call into netfs via either netfs_read_folio or netfs_rea=
dahead
> > > > > > >>>> - if fscache is enabled, then the IO can be satisfied from=
 fscache
> > > > > > >>>> - if fscache is not enabled, or some of the IO cannot be s=
atisfied
> > > > > > >>>> from the cache, then NFS is called back via netfs_issue_re=
ad
> > > > > > >>>> and we use the normal NFS read pageio interface.  This req=
uires
> > > > > > >>>> we call netfs_subreq_terminated() when all the RPCs comple=
te,
> > > > > > >>>> which is the reason for the small changes to pagelist.c
> > > > > > >>>
> > > > > > >>> I'm objecting to any middle layer "solution" that adds over=
head to the
> > > > > > >>> NFS I/O paths.
> > > > > > >>>
> > > > > > >> Got it.
> > > > > > >>
> > > > > > >>> I'm willing to consider solutions that are specific only to=
 the fscache
> > > > > > >>> use case (i.e. when the 'fsc' mount option is specified). H=
owever when
> > > > > > >>> I perform a normal NFS mount, and do I/O, then I don't want=
 to see
> > > > > > >>> extra memory allocations, extra indirect calls and larger i=
node
> > > > > > >>> footprints.
> > > > > > >>>
> > > > > > >>> IOW: I want the code to optimise for the case of standard N=
FS, not for
> > > > > > >>> the case of 'NFS with cachefs additions'.
> > > > > > >>>
> > > > > > >> I agree completely.  Are you seeing extra memory allocations
> > > > > > >> happen on mounts without 'fsc' or is it more a concern or ho=
w
> > > > > > >> some of the patches look?  We should not be calling any netf=
s or
> > > > > > >> fscache code if 'fsc' is not on the mount and I don't see an=
y in my
> > > > > > >> testing. So either there's a misunderstanding here, or there=
's a
> > > > > > >> bug I'm missing.
> > > > > > >>
> > > > > > >> If fscache is not configured, then nfs_netfs_read_folio() an=
d
> > > > > > >> nfs_netfs_readahead() is a wrapper that returns -ENOBUFS.
> > > > > > >> If it's configured but not enabled, then the checks for
> > > > > > >> netfs_inode(inode)->cache should skip over any netfs code.
> > > > > > >> But maybe there's a non-obvious bug you're seeing and
> > > > > > >> somehow netfs is still getting called?  Because I cannot
> > > > > > >> see netfs getting called if 'fsc' is not on the mount in my
> > > > > > >> tests.
> > > > > > >>
> > > > > > >> int nfs_netfs_read_folio(struct file *file, struct folio *fo=
lio)
> > > > > > >> {
> > > > > > >>       if (!netfs_inode(folio_inode(folio))->cache)
> > > > > > >>               return -ENOBUFS;
> > > > > > >>
> > > > > > >>       return netfs_read_folio(file, folio);
> > > > > > >> }
> > > > > > >>
> > > > > > >> int nfs_netfs_readahead(struct readahead_control *ractl)
> > > > > > >> {
> > > > > > >>       struct inode *inode =3D ractl->mapping->host;
> > > > > > >>
> > > > > > >>       if (!netfs_inode(inode)->cache)
> > > > > > >>               return -ENOBUFS;
> > > > > > >>
> > > > > > >>       netfs_readahead(ractl);
> > > > > > >>       return 0;
> > > > > > >> }
> > > > > > >>
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>> Can you be more specific as to the portions of the patch y=
ou don't
> > > > > > >>>> like
> > > > > > >>>> so I can move it in the right direction?
> > > > > > >>>>
> > > > > > >>>> This is from patch #2 which you didn't comment on.  I'm no=
t sure
> > > > > > >>>> you're
> > > > > > >>>> ok with it though, since you mention "extra bloat to the i=
node".
> > > > > > >>>> Do you object to this even though it's wrapped in an
> > > > > > >>>> #ifdef CONFIG_NFS_FSCACHE?  If so, do you require no
> > > > > > >>>> extra size be added to nfs_inode?
> > > > > > >>>>
> > > > > > >>>> @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > > >>>>       __u64 write_io;
> > > > > > >>>>       __u64 read_io;
> > > > > > >>>> #ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> -       struct fscache_cookie   *fscache;
> > > > > > >>>> -#endif
> > > > > > >>>> +       struct netfs_inode      netfs; /* netfs context an=
d VFS inode
> > > > > > >>>> */
> > > > > > >>>> +#else
> > > > > > >>>>       struct inode            vfs_inode;
> > > > > > >>>> +#endif
> > > > > > >>>> +
> > > > > > >>>
> > > > > > >>> Ideally, I'd prefer no extra size. I can live with it up to=
 a certain
> > > > > > >>> point, however for now NFS is not unconditionally opting in=
to the netfs
> > > > > > >>> project. If we're to ever do that, then I want to see strea=
mlined code
> > > > > > >>> for the standard I/O case.
> > > > > > >>>
> > > > > > >> Ok and understood about standard I/O case.
> > > > > > >>
> > > > > > >> I was thinking how we might not increase the size, but I don=
't think
> > > > > > >> I can make it work.
> > > > > > >>
> > > > > > >> I thought we could change to something like the below, witho=
ut an
> > > > > > >> embedded struct inode:
> > > > > > >>
> > > > > > >> @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > > >>       __u64 write_io;
> > > > > > >>       __u64 read_io;
> > > > > > >> #ifdef CONFIG_NFS_FSCACHE
> > > > > > >> -       struct fscache_cookie   *fscache;
> > > > > > >> -#endif
> > > > > > >> +       struct netfs_inode      *netfs; /* netfs context and=
 VFS inode */
> > > > > > >> +#else
> > > > > > >>       struct inode            vfs_inode;
> > > > > > >> +#endif
> > > > > > >> +
> > > > > > >>
> > > > > > >> Then I would need to alloc/free a netfs_inode at the time of
> > > > > > >> nfs_inode initiation.  Unfortunately this has the issue that=
 the NFS_I()
> > > > > > >> macro cannot work, because it requires an embedded "struct i=
node"
> > > > > > >> due to "container_of" use:
> > > > > > >>
> > > > > > >> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > >> +{
> > > > > > >> +       return &nfsi->netfs.inode;
> > > > > > >> +}
> > > > > > >> +static inline struct nfs_inode *NFS_I(const struct inode *i=
node)
> > > > > > >> +{
> > > > > > >> +       return container_of(inode, struct nfs_inode, netfs.i=
node);
> > > > > > >> +}
> > > > > > >> +#else
> > > > > > >> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > >> +{
> > > > > > >> +       return &nfsi->vfs_inode;
> > > > > > >> +}
> > > > > > >> static inline struct nfs_inode *NFS_I(const struct inode *in=
ode)
> > > > > > >> {
> > > > > > >>       return container_of(inode, struct nfs_inode, vfs_inode=
);
> > > > > > >> }
> > > > > > >> +#endif
> > > > > > >>
> > > > > > >>
> > > > > > >
> > > > > > > Actually Trond maybe we can achieve a "0 length increase" of
> > > > > > > nfs_inode if dhowells would take a patch to modify the defini=
tion
> > > > > > > of struct netfs_inode and netfs_inode_init(), something like =
the WIP
> > > > > > > patch below.  What do you think?
> > > > > >
> > > > > > That works for me.
> > > > > >
> > > > > > >
> > > > > > > I think maybe this could be a follow-on patch and if you/dhow=
ells
> > > > > > > think it's an ok idea I can try to work out what is needed ac=
ross
> > > > > > > the tree.  I thought about it more and I kinda agree that in =
the
> > > > > > > case for NFS where fscache is "configured but not enabled",
> > > > > > > then even though we're only adding 24 bytes to the nfs_inode
> > > > > > > each time, it will add up so it is worth at least a discussio=
n.
> > > > > > >
> > > > > > > diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> > > > > > > index f2402ddeafbf..195714f1c355 100644
> > > > > > > --- a/include/linux/netfs.h
> > > > > > > +++ b/include/linux/netfs.h
> > > > > > > @@ -118,11 +118,7 @@ enum netfs_io_source {
> > > > > > > typedef void (*netfs_io_terminated_t)(void *priv, ssize_t tra=
nsferred_or_error,
> > > > > > >                                     bool was_async);
> > > > > > >
> > > > > > > -/*
> > > > > > > - * Per-inode context.  This wraps the VFS inode.
> > > > > > > - */
> > > > > > > -struct netfs_inode {
> > > > > > > -       struct inode            inode;          /* The VFS in=
ode */
> > > > > > > +struct netfs_info {
> > > > > > >       const struct netfs_request_ops *ops;
> > > > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > > > >       struct fscache_cookie   *cache;
> > > > > > > @@ -130,6 +126,14 @@ struct netfs_inode {
> > > > > > >       loff_t                  remote_i_size;  /* Size of the =
remote file */
> > > > > > > };
> > > > > > >
> > > > > > > +/*
> > > > > > > + * Per-inode context.  This wraps the VFS inode.
> > > > > > > + */
> > > > > > > +struct netfs_inode {
> > > > > > > +       struct inode            inode;          /* The VFS in=
ode */
> > > > > > > +       struct netfs_info       *netfs;         /* Rest of ne=
tfs data */
> > > > > > > +};
> > > > > > > +
> > > > > > > /*
> > > > > > > * Resources required to do operations on a cache.
> > > > > > > */
> > > > > > > @@ -312,10 +316,12 @@ static inline struct netfs_inode
> > > > > > > *netfs_inode(struct inode *inode)
> > > > > > > static inline void netfs_inode_init(struct netfs_inode *ctx,
> > > > > > >                                   const struct netfs_request_=
ops *ops)
> > > > > > > {
> > > > > > > -       ctx->ops =3D ops;
> > > > > > > -       ctx->remote_i_size =3D i_size_read(&ctx->inode);
> > > > > > > +       ctx->netfs =3D kzalloc(sizeof(struct netfs_info)), GF=
P_KERNEL);
> > > > > > > +       /* FIXME: Check for NULL */
> > > > > > > +       ctx->netfs->ops =3D ops;
> > > > > > > +       ctx->netfs->remote_i_size =3D i_size_read(&ctx->inode=
);
> > > > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > > > > -       ctx->cache =3D NULL;
> > > > > > > +       ctx->netfs->cache =3D NULL;
> > > > > > > #endif
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> Are you ok with the stub functions which are placed in fsc=
ache.h, and
> > > > > > >>>> when CONFIG_NFS_FSCACHE is not set, become either a no-op
> > > > > > >>>> or a 1-liner (nfs_netfs_readpage_release)?
> > > > > > >>>>
> > > > > > >>>> #else /* CONFIG_NFS_FSCACHE */
> > > > > > >>>> +static inline void nfs_netfs_inode_init(struct nfs_inode =
*nfsi) {}
> > > > > > >>>> +static inline void nfs_netfs_initiate_read(struct nfs_pgi=
o_header
> > > > > > >>>> *hdr) {}
> > > > > > >>>> +static inline void nfs_netfs_read_completion(struct nfs_p=
gio_header
> > > > > > >>>> *hdr) {}
> > > > > > >>>> +static inline void nfs_netfs_readpage_release(struct nfs_=
page *req)
> > > > > > >>>> +{
> > > > > > >>>> +       unlock_page(req->wb_page);
> > > > > > >>>> +}
> > > > > > >>>> static inline void nfs_fscache_release_super_cookie(struct
> > > > > > >>>> super_block *sb) {}
> > > > > > >>>> static inline void nfs_fscache_init_inode(struct inode *in=
ode) {}
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> Do you object to the below?  If so, then do you want
> > > > > > >>>> #ifdef CONFIG_NFS_FSCACHE here?
> > > > > > >>>>
> > > > > > >>>> -- a/fs/nfs/inode.c
> > > > > > >>>> +++ b/fs/nfs/inode.c
> > > > > > >>>> @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struct
> > > > > > >>>> super_block *sb)
> > > > > > >>>> #ifdef CONFIG_NFS_V4_2
> > > > > > >>>>       nfsi->xattr_cache =3D NULL;
> > > > > > >>>> #endif
> > > > > > >>>> +       nfs_netfs_inode_init(nfsi);
> > > > > > >>>> +
> > > > > > >>>>       return VFS_I(nfsi);
> > > > > > >>>> }
> > > > > > >>>> EXPORT_SYMBOL_GPL(nfs_alloc_i
> > > > > > >>>> node);
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> Do you object to the changes in fs/nfs/read.c?  Specifical=
ly,
> > > > > > >>>> how about the below calls to netfs from nfs_read_folio and
> > > > > > >>>> nfs_readahead into equivalent netfs calls?  So when
> > > > > > >>>> NFS_CONFIG_FSCACHE is set, but fscache is not enabled
> > > > > > >>>> ('fsc' not on mount), these netfs functions do immediately=
 call
> > > > > > >>>> netfs_alloc_request().  But I wonder if we could simply ad=
d a
> > > > > > >>>> check to see if fscache is enabled on the mount, and skip
> > > > > > >>>> over to satisfy what you want.  Am I understanding what yo=
u
> > > > > > >>>> want?
> > > > > > >>>
> > > > > > >>> Quite frankly, I'd prefer that we just split out the functi=
onality that
> > > > > > >>> is needed from the netfs code so that it can be optimised. =
However I'm
> > > > > > >>> not interested enough in the cachefs functionality to work =
on that
> > > > > > >>> myself. ...and as I indicated above, I might be OK with opt=
ing into the
> > > > > > >>> netfs project, once the overhead can be made to disappear.
> > > > > > >>>
> > > > > > >> Understood.
> > > > > > >>
> > > > > > >> If you think it makes more sense, I can move some of the nfs=
_netfs_*
> > > > > > >> functions into a netfs.c file as a starting point.  Or that =
can maybe
> > > > > > >> be done in a future patchset?
> > > > > > >>
> > > > > > >> For now I was equating netfs and fscache together so we can
> > > > > > >> move on from the much older and single-page limiting fscache
> > > > > > >> interface that is likely to go away soon.
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>> @@ -355,6 +343,10 @@ int nfs_read_folio(struct file *file,=
 struct
> > > > > > >>>> folio *folio)
> > > > > > >>>>       if (NFS_STALE(inode))
> > > > > > >>>>               goto out_unlock;
> > > > > > >>>>
> > > > > > >>>> +       ret =3D nfs_netfs_read_folio(file, folio);
> > > > > > >>>> +       if (!ret)
> > > > > > >>>> +               goto out;
> > > > > > >>>> +
> > > > > > >>>>
> > > > > > >>>> @@ -405,6 +399,10 @@ void nfs_readahead(struct readahead_c=
ontrol
> > > > > > >>>> *ractl)
> > > > > > >>>>       if (NFS_STALE(inode))
> > > > > > >>>>               goto out;
> > > > > > >>>>
> > > > > > >>>> +       ret =3D nfs_netfs_readahead(ractl);
> > > > > > >>>> +       if (!ret)
> > > > > > >>>> +               goto out;
> > > > > > >>>> +
> > > > > > >>>>
> > > > > > >> The above wrappers should prevent any additional overhead wh=
en fscache
> > > > > > >> is not enabled.  As far as I know these work to avoid callin=
g netfs
> > > > > > >> when 'fsc' is not on the mount.
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>> And how about these calls from different points in the rea=
d
> > > > > > >>>> path to the earlier mentioned stub functions?
> > > > > > >>>>
> > > > > > >>>> @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_r=
ead_mds);
> > > > > > >>>>
> > > > > > >>>> static void nfs_readpage_release(struct nfs_page *req, int=
 error)
> > > > > > >>>> {
> > > > > > >>>> -       struct inode *inode =3D d_inode(nfs_req_openctx(re=
q)->dentry);
> > > > > > >>>>       struct page *page =3D req->wb_page;
> > > > > > >>>>
> > > > > > >>>> -       dprintk("NFS: read done (%s/%llu %d@%lld)\n", inod=
e->i_sb-
> > > > > > >>>>> s_id,
> > > > > > >>>> -               (unsigned long long)NFS_FILEID(inode), req=
->wb_bytes,
> > > > > > >>>> -               (long long)req_offset(req));
> > > > > > >>>> -
> > > > > > >>>>       if (nfs_error_is_fatal_on_server(error) && error !=
=3D -
> > > > > > >>>> ETIMEDOUT)
> > > > > > >>>>               SetPageError(page);
> > > > > > >>>> -       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)=
) {
> > > > > > >>>> -               if (PageUptodate(page))
> > > > > > >>>> -                       nfs_fscache_write_page(inode, page=
);
> > > > > > >>>> -               unlock_page(page);
> > > > > > >>>> -       }
> > > > > > >>>> +       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)=
)
> > > > > > >>>> +               nfs_netfs_readpage_release(req);
> > > > > > >>>> +
> > > > > > >>>
> > > > > > >>> I'm not seeing the value of wrapping unlock_page(), no... T=
hat code is
> > > > > > >>> going to need to change when we move it to use folios nativ=
ely anyway.
> > > > > > >>>
> > > > > > >> Ok, how about I make it conditional on whether fscache is co=
nfigured
> > > > > > >> and enabled then, similar to the nfs_netfs_read_folio() and
> > > > > > >> nfs_netfs_readahead()?  Below is what that would look like.
> > > > > > >> I could inline the code in nfs_netfs_readpage_release() if y=
ou
> > > > > > >> think it would be clearer.
> > > > > > >>
> > > > > > >> static void nfs_readpage_release(struct nfs_page *req, int e=
rror)
> > > > > > >> {
> > > > > > >>       struct page *page =3D req->wb_page;
> > > > > > >>
> > > > > > >>       if (nfs_error_is_fatal_on_server(error) && error !=3D =
-ETIMEDOUT)
> > > > > > >>               SetPageError(page);
> > > > > > >>       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > > > > >> #ifndef CONFIG_NFS_FSCACHE
> > > > > > >>               unlock_page(req->wb_page);
> > > > > > >> #else
> > > > > > >>               nfs_netfs_readpage_release(req);
> > > > > > >> #endif
> > > > > > >>       nfs_release_request(req);
> > > > > > >> }
> > > > > > >>
> > > > > > >>
> > > > > > >> void nfs_netfs_readpage_release(struct nfs_page *req)
> > > > > > >> {
> > > > > > >>   struct inode *inode =3D d_inode(nfs_req_openctx(req)->dent=
ry);
> > > > > > >>
> > > > > > >>   /*
> > > > > > >>    * If fscache is enabled, netfs will unlock pages.
> > > > > > >>    */
> > > > > > >>   if (netfs_inode(inode)->cache)
> > > > > > >>       return;
> > > > > > >>
> > > > > > >>   unlock_page(req->wb_page);
> > > > > > >> }
> > > > > > >>
> > > > > > >>
> > > > > > >>>>       nfs_release_request(req);
> > > > > > >>>> }
> > > > > > >>>>
> > > > > > >>>> @@ -177,6 +170,8 @@ static void nfs_read_completion(struct
> > > > > > >>>> nfs_pgio_header *hdr)
> > > > > > >>>>               nfs_list_remove_request(req);
> > > > > > >>>>               nfs_readpage_release(req, error);
> > > > > > >>>>       }
> > > > > > >>>> +       nfs_netfs_read_completion(hdr);
> > > > > > >>>> +
> > > > > > >>>> out:
> > > > > > >>>>       hdr->release(hdr);
> > > > > > >>>> }
> > > > > > >>>> @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct
> > > > > > >>>> nfs_pgio_header *hdr,
> > > > > > >>>>                             struct rpc_task_setup *task_se=
tup_data,
> > > > > > >>>> int how)
> > > > > > >>>> {
> > > > > > >>>>       rpc_ops->read_setup(hdr, msg);
> > > > > > >>>> +       nfs_netfs_initiate_read(hdr);
> > > > > > >>>>       trace_nfs_initiate_read(hdr);
> > > > > > >>>> }
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> Are you ok with these additions?  Something like this woul=
d
> > > > > > >>>> be required in the case of fscache configured and enabled,
> > > > > > >>>> because we could have some of the data in a read in
> > > > > > >>>> fscache, and some not.  That is the reason for the netfs
> > > > > > >>>> design, and why we need to be able to call the normal
> > > > > > >>>> NFS read IO path (netfs calls into issue_read, and we call
> > > > > > >>>> back via netfs_subreq_terminated)?
> > > > > > >>>>
> > > > > > >>>> @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
> > > > > > >>>>       struct pnfs_layout_segment *pg_lseg;
> > > > > > >>>>       struct nfs_io_completion *pg_io_completion;
> > > > > > >>>>       struct nfs_direct_req   *pg_dreq;
> > > > > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> +       void                    *pg_netfs;
> > > > > > >>>> +#endif
> > > > > > >>>>
> > > > > > >>>> @@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
> > > > > > >>>>       const struct nfs_rw_ops *rw_ops;
> > > > > > >>>>       struct nfs_io_completion *io_completion;
> > > > > > >>>>       struct nfs_direct_req   *dreq;
> > > > > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> +       void                    *netfs;
> > > > > > >>>> +#endif
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> And these additions to pagelist.c?
> > > > > > >>>>
> > > > > > >>>> @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct
> > > > > > >>>> nfs_pageio_descriptor *desc,
> > > > > > >>>>       hdr->good_bytes =3D mirror->pg_count;
> > > > > > >>>>       hdr->io_completion =3D desc->pg_io_completion;
> > > > > > >>>>       hdr->dreq =3D desc->pg_dreq;
> > > > > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> +       if (desc->pg_netfs)
> > > > > > >>>> +               hdr->netfs =3D desc->pg_netfs;
> > > > > > >>>> +#endif
> > > > > > >>>
> > > > > > >>> Why the conditional?
> > > > > > >>>
> > > > > > >> Not really needed and I was thinking of removing it, so I'll=
 do that.
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pageio=
_descriptor
> > > > > > >>>> *desc,
> > > > > > >>>>       desc->pg_lseg =3D NULL;
> > > > > > >>>>       desc->pg_io_completion =3D NULL;
> > > > > > >>>>       desc->pg_dreq =3D NULL;
> > > > > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> +       desc->pg_netfs =3D NULL;
> > > > > > >>>> +#endif
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct
> > > > > > >>>> nfs_pageio_descriptor *desc,
> > > > > > >>>>
> > > > > > >>>>       desc->pg_io_completion =3D hdr->io_completion;
> > > > > > >>>>       desc->pg_dreq =3D hdr->dreq;
> > > > > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > > > > >>>> +       desc->pg_netfs =3D hdr->netfs;
> > > > > > >>>> +#endif
> > > > > > >>>
> > > > > > >>> Those all need wrapper functions instead of embedding #ifde=
fs.
> > > > > > >>>
> > > > > > >> Ok.
> > > > > > >>
> > > > > > >>
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>>> My expectation is that the standard I/O path should have =
minimal
> > > > > > >>>>> overhead, and should certainly not increase the overhead =
that we
> > > > > > >>>>> already have. Will this be addressed in future iterations=
 of these
> > > > > > >>>>> patches?
> > > > > > >>>>>
> > > > > > >>>>
> > > > > > >>>> I will do what I can to satisfy what you want, either by f=
ixing up
> > > > > > >>>> this patch or follow-on patches.  Hopefully the above ques=
tions
> > > > > > >>>> will clarify the next steps.
> > > > > > >>>>
> > > > > > >>>
> > > > > > >>> --
> > > > > > >>> Trond Myklebust
> > > > > > >>> Linux NFS client maintainer, Hammerspace
> > > > > > >>> trond.myklebust@hammerspace.com
> > > > > >
> > > > > >
> > > > > >
> > > > > > Trond Myklebust
> > > > > > CTO, Hammerspace Inc
> > > > > > 1900 S Norfolk St, Suite 350 - #45
> > > > > > San Mateo, CA 94403
> > > > > >
> > > > > > www.hammer.space
> > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
