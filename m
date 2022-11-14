Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A00627E51
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 13:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiKNMok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 07:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKNMoP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 07:44:15 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00ED275F3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 04:43:03 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so5632250ilc.7
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr8jKcb5TtjvgIABPFXYn0b7xrI0Tbsth2ZN6lP7quE=;
        b=kIN6SXuabd5Z8Il3AEkHosT4GUuSgbM/5yP5O04gITYP8FuMC8CvrBL/uLlVVuceQy
         jNZAj1i/v6sYBDqZVA603jQjjo28Zn6CmVO2QbOofVkW0ces+cd0MHcdNaMLR0UVBD49
         +AeQP+d1Bz9+sgz9fhovdjSIThcmkwo4UHTSpxNjx5kFFhJUJUllwpj1SQPNNhU0K4va
         QLLT2dnhAW3rl/2tMrax4ERBnHabi6gCF6qxpgnnfU8+7JVcK3QOqKoMzJc0tSpWOidl
         ot1RUI+uxmXDB2C63bB6z8o5RFu18h3wPzX7YyPx8xOgZKEdIJ+gU37DSZjjK9lmDdX2
         v9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr8jKcb5TtjvgIABPFXYn0b7xrI0Tbsth2ZN6lP7quE=;
        b=h8ZcKCbLaFcZKtAyi6LWOFXoUNGiGDusVZ7IttOkuCzerJV32XxHqL81PqXQ1d36s8
         m1JHDJFg3mklLvnevXU3I65ehwMu52OALWfeQ51MQ19J9xuc1JGiuHlafTwgTPYOjrOJ
         s3RN72KR8c3l8saiBpXZEKDz1gnCGVuQI8yonv+C3HL+lpfaLJQo8qhF80qHT+Hu6LEu
         IolwHnVupn9f8P3xh8JkthDWpWmo2tOr34hlO1oFaVKA850d4fEFMIzXRtOLGCpudYmM
         0rVPwQUvUEUgpzXzNN3N9VfchMUy79RKWYEsJuPjoy6Vc+vOoFvkeHGgdvZd/b5QX0cQ
         OxwQ==
X-Gm-Message-State: ANoB5pne3LtB35QAGKW53THN7b6Z5MDlbh2oE6md7ewJqltl+m/2Lj8u
        PqvBPlHnBNJ11bghC6zsN2yyECUlMTv6M4ZYT0CUJA==
X-Google-Smtp-Source: AA0mqf7KwzLt957PE0YjJvtXTv4NRVv2HYdl5XAK+gusZ1n9O1uwnQYL01LhZkk7vfwiGPcvmByftAN6YVL7JEIBzro=
X-Received: by 2002:a05:6e02:e12:b0:300:bedf:9291 with SMTP id
 a18-20020a056e020e1200b00300bedf9291mr5950687ilk.242.1668429782656; Mon, 14
 Nov 2022 04:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20221017105212.77588-1-dwysocha@redhat.com> <20221017105212.77588-4-dwysocha@redhat.com>
 <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
 <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
 <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
 <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
 <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
 <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com> <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
 <CALF+zOkxbLV4qzkaydBThmKfQKOP07jyq8o10YMfP2TgvAdZMQ@mail.gmail.com>
In-Reply-To: <CALF+zOkxbLV4qzkaydBThmKfQKOP07jyq8o10YMfP2TgvAdZMQ@mail.gmail.com>
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Mon, 14 Nov 2022 12:42:26 +0000
Message-ID: <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs when
 fscache is enabled
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Brennan Doyle <brennandoyle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Dave for getting back to me so quickly.

> Due to use of "drop_caches" this is almost certainly the known issue #1
> I mentioned in the opening post of this series:
> https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.com/

Apologies, I completely missed the known issues in the original
opening message of the series. Just to clarify, I was only ever
dropping the caches on the "NFS Client" in the below relationship:

Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client.

I never dropped the caches on the Re-Export Server (the server running
FS-Cache) at any point.

However my rsize was lower than my readahead value. I've since corrected th=
at:

benmaynard@demo-cluster-1-26hm:~$ cat /proc/mounts | grep nfs
10.0.0.49:/files /srv/nfs/files nfs
rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmin=
=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3Dtcp,=
nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.49,mount=
vers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,addr=3D10=
.0.0.49
0 0

benmaynard@demo-cluster-1-26hm:~$ findmnt -rnu -t nfs,nfs4 -o MAJ:MIN,TARGE=
T
0:52 /srv/nfs/files
benmaynard@demo-cluster-1-26hm:~$ cat /sys/class/bdi/0\:52/read_ahead_kb
512

With this configuration I see the same issue, FS-Cache never reads
from /var/cache/fscache, and copying the same file always leads to
heavy writes to /var/cache/fscache (the cache is overwriting itself).

I have also tried this copy without clearing the caches on any server
in the chain, and the same happens.

Would you expect this behaviour even though rsize > read ahead? Would
you expect the referenced patch to fix this?

I tried to apply the patch you suggested
(https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html)
but it did not apply cleanly, and I ran out of time to troubleshoot. I
should get some more time on Wednesday and I can re-try.


Kind Regards
Benjamin Maynard


Kind Regards

Benjamin Maynard

Customer Engineer

benmaynard@google.com

Google, Inc.




On Mon, 14 Nov 2022 at 10:41, David Wysochanski <dwysocha@redhat.com> wrote=
:
>
> Hi Ben,
>
> Thanks for testing these patches.  More below.
>
> On Sat, Nov 12, 2022 at 7:47 AM Benjamin Maynard <benmaynard@google.com> =
wrote:
> >
> > Hi all,
> >
> > I've been doing some more testing with these patches, I applied all of
> > the patches (v10 from
> > https://patchwork.kernel.org/project/linux-nfs/list/?series=3D691729)
> > apart from Patch 6 (the RFC patch) to version 6.0.8 of the kernel.
> >
> > I have the following setup:
> >
> > Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client.
> >
> > I have a 500Gb file on the Source NFS Server, which I am then copying
> > to the NFS Client via the Re-Export Server.
> >
> > On the first copy, I see heavy writes to /var/cache/fscache on the
> > re-export server, and once the file copy completes I see that
> > /var/cache/fscache is approximately 500Gb in size. All good so far.
> >
> > I then deleted that file from the NFS Client, and dropped the caches
> > just to be safe (echo 3 > /proc/sys/vm/drop_caches on the NFS Client).
> >
> > I then performed another copy of the 500Gb file on the NFS Client,
> > again via the Re-Export Server. What I expected would happen is that I
> > would see heavy reads from the /var/cache/fscache volume as the file
> > should be served from FS-Cache.
> >
> > However what I actually saw was no reads whatsoever, FS-Cache seems to
> > be ignored and the file is pulled from the Source NFS Filer again. I
> > also see heavy writes to /var/cache/fscache, so it appears that
> > FS-Cache is overwriting its existing cache, and never using it.
> >
> Due to use of "drop_caches" this is almost certainly the known issue #1
> I mentioned in the opening post of this series:
> https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.com/
>
> The above issue will be fixed with the following patch which has not
> been merged yet:
> https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
>
> Do you have time to do another test to verify that is the case?
> If so, I can re-post that patch on top of the first 5 patches in this ser=
ies,
> as well as a second patch that allows NFS to use it.
>
>
> > I only have 104Gb of memory on the Re-Export Server (with FS-Cache) so
> > it is not possible that the file is being served from the page cache.
> >
> > We saw this behaviour before on an older set of the patches when our
> > mount between the Re-Export Server and the Source NFS Filer was using
> > the "sync" option, but we are now using the "async" option and the
> > same is happening.
> >
> > Mount options:
> >
> > Source NFS Server <-- Re-Export Server (with FS-Cache):
> >
> > 10.0.0.49:/files /srv/nfs/files nfs
> > rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregm=
in=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3Dtc=
p,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.49,mou=
ntvers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,addr=3D=
10.0.0.49
> >
> > Re-Export Server (with FS-Cache) <-- NFS Client:
> >
> > 10.0.0.3:/files /mnt/nfs nfs
> > rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,=
proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.3,mountver=
s=3D3,mountport=3D20048,mountproto=3Dtcp,local_lock=3Dnone,addr=3D10.0.0.3
> >
> > It is also worth noting this behaviour is not unique to the re-export
> > use case. I see FS-Cache not being used with the following setup:
> >
> > Source NFS Server <-- Client (with FS-Cache).
> >
> > Thanks,
> > Ben
> >
> >
> > Kind Regards
> >
> > Benjamin Maynard
> >
> > Customer Engineer
> >
> > benmaynard@google.com
> >
> > Google, Inc.
> >
> >
> >
> >
> > On Mon, 31 Oct 2022 at 22:22, Trond Myklebust <trondmy@hammerspace.com>=
 wrote:
> > >
> > >
> > >
> > > > On Oct 30, 2022, at 19:25, David Wysochanski <dwysocha@redhat.com> =
wrote:
> > > >
> > > > On Sat, Oct 29, 2022 at 12:46 PM David Wysochanski <dwysocha@redhat=
.com> wrote:
> > > >>
> > > >> On Fri, Oct 28, 2022 at 12:59 PM Trond Myklebust <trondmy@kernel.o=
rg> wrote:
> > > >>>
> > > >>> On Fri, 2022-10-28 at 07:50 -0400, David Wysochanski wrote:
> > > >>>> On Thu, Oct 27, 2022 at 3:16 PM Trond Myklebust <trondmy@kernel.=
org>
> > > >>>> wrote:
> > > >>>>>
> > > >>>>> On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote:
> > > >>>>>> Convert the NFS buffered read code paths to corresponding netf=
s
> > > >>>>>> APIs,
> > > >>>>>> but only when fscache is configured and enabled.
> > > >>>>>>
> > > >>>>>> The netfs API defines struct netfs_request_ops which must be
> > > >>>>>> filled
> > > >>>>>> in by the network filesystem.  For NFS, we only need to define=
 5
> > > >>>>>> of
> > > >>>>>> the functions, the main one being the issue_read() function.
> > > >>>>>> The issue_read() function is called by the netfs layer when a
> > > >>>>>> read
> > > >>>>>> cannot be fulfilled locally, and must be sent to the server
> > > >>>>>> (either
> > > >>>>>> the cache is not active, or it is active but the data is not
> > > >>>>>> available).
> > > >>>>>> Once the read from the server is complete, netfs requires a ca=
ll
> > > >>>>>> to
> > > >>>>>> netfs_subreq_terminated() which conveys either how many bytes
> > > >>>>>> were
> > > >>>>>> read
> > > >>>>>> successfully, or an error.  Note that issue_read() is called w=
ith
> > > >>>>>> a
> > > >>>>>> structure, netfs_io_subrequest, which defines the IO requested=
,
> > > >>>>>> and
> > > >>>>>> contains a start and a length (both in bytes), and assumes the
> > > >>>>>> underlying
> > > >>>>>> netfs will return a either an error on the whole region, or th=
e
> > > >>>>>> number
> > > >>>>>> of bytes successfully read.
> > > >>>>>>
> > > >>>>>> The NFS IO path is page based and the main APIs are the pgio A=
PIs
> > > >>>>>> defined
> > > >>>>>> in pagelist.c.  For the pgio APIs, there is no way for the cal=
ler
> > > >>>>>> to
> > > >>>>>> know how many RPCs will be sent and how the pages will be brok=
en
> > > >>>>>> up
> > > >>>>>> into underlying RPCs, each of which will have their own
> > > >>>>>> completion
> > > >>>>>> and
> > > >>>>>> return code.  In contrast, netfs is subrequest based, a single
> > > >>>>>> subrequest may contain multiple pages, and a single subrequest=
 is
> > > >>>>>> initiated with issue_read() and terminated with
> > > >>>>>> netfs_subreq_terminated().
> > > >>>>>> Thus, to utilze the netfs APIs, NFS needs some way to accommod=
ate
> > > >>>>>> the netfs API requirement on the single response to the whole
> > > >>>>>> subrequest, while also minimizing disruptive changes to the NF=
S
> > > >>>>>> pgio layer.
> > > >>>>>>
> > > >>>>>> The approach taken with this patch is to allocate a small
> > > >>>>>> structure
> > > >>>>>> for each nfs_netfs_issue_read() call, store the final error an=
d
> > > >>>>>> number
> > > >>>>>> of bytes successfully transferred in the structure, and update
> > > >>>>>> these
> > > >>>>>> values
> > > >>>>>> as each RPC completes.  The refcount on the structure is used =
as
> > > >>>>>> a
> > > >>>>>> marker
> > > >>>>>> for the last RPC completion, is incremented in
> > > >>>>>> nfs_netfs_read_initiate(),
> > > >>>>>> and decremented inside nfs_netfs_read_completion(), when a
> > > >>>>>> nfs_pgio_header
> > > >>>>>> contains a valid pointer to the data.  On the final put (which
> > > >>>>>> signals
> > > >>>>>> the final outstanding RPC is complete) in
> > > >>>>>> nfs_netfs_read_completion(),
> > > >>>>>> call netfs_subreq_terminated() with either the final error val=
ue
> > > >>>>>> (if
> > > >>>>>> one or more READs complete with an error) or the number of byt=
es
> > > >>>>>> successfully transferred (if all RPCs complete successfully).
> > > >>>>>> Note
> > > >>>>>> that when all RPCs complete successfully, the number of bytes
> > > >>>>>> transferred
> > > >>>>>> is capped to the length of the subrequest.  Capping the
> > > >>>>>> transferred
> > > >>>>>> length
> > > >>>>>> to the subrequest length prevents "Subreq overread" warnings f=
rom
> > > >>>>>> netfs.
> > > >>>>>> This is due to the "aligned_len" in nfs_pageio_add_page(), and
> > > >>>>>> the
> > > >>>>>> corner case where NFS requests a full page at the end of the
> > > >>>>>> file,
> > > >>>>>> even when i_size reflects only a partial page (NFS overread).
> > > >>>>>>
> > > >>>>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > >>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > >>>>>
> > > >>>>>
> > > >>>>> This is not doing what I asked for, which was to separate out t=
he
> > > >>>>> fscache functionality, so that we can call that if and when it =
is
> > > >>>>> available.
> > > >>>>>
> > > >>>> I must have misunderstood then.
> > > >>>>
> > > >>>> The last feedback I have from you was that you wanted it to be
> > > >>>> an opt-in feature, and it was a comment on a previous patch
> > > >>>> to Kconfig.  I was proceeding the best I knew how, but
> > > >>>> let me try to get back on track.
> > > >>>>
> > > >>>>> Instead, it is just wrapping the NFS requests inside netfs
> > > >>>>> requests. As
> > > >>>>> it stands, that means it is just duplicating information, and
> > > >>>>> adding
> > > >>>>> unnecessary overhead to the standard I/O path (extra allocation=
s,
> > > >>>>> extra
> > > >>>>> indirect calls, and extra bloat to the inode).
> > > >>>>>
> > > >>>> I think I understand what you're saying but I'm not sure.  Let m=
e
> > > >>>> ask some clarifying questions.
> > > >>>>
> > > >>>> Are you objecting to the code when CONFIG_NFS_FSCACHE is
> > > >>>> configured?  Or when it is not?  Or both?  I think you're object=
ing
> > > >>>> when it's configured, but not enabled (we mount without 'fsc').
> > > >>>> Am I right?
> > > >>>>
> > > >>>> Also, are you objecting to the design that to use fcache we now
> > > >>>> have to use netfs, specifically:
> > > >>>> - call into netfs via either netfs_read_folio or netfs_readahead
> > > >>>> - if fscache is enabled, then the IO can be satisfied from fscac=
he
> > > >>>> - if fscache is not enabled, or some of the IO cannot be satisfi=
ed
> > > >>>> from the cache, then NFS is called back via netfs_issue_read
> > > >>>> and we use the normal NFS read pageio interface.  This requires
> > > >>>> we call netfs_subreq_terminated() when all the RPCs complete,
> > > >>>> which is the reason for the small changes to pagelist.c
> > > >>>
> > > >>> I'm objecting to any middle layer "solution" that adds overhead t=
o the
> > > >>> NFS I/O paths.
> > > >>>
> > > >> Got it.
> > > >>
> > > >>> I'm willing to consider solutions that are specific only to the f=
scache
> > > >>> use case (i.e. when the 'fsc' mount option is specified). However=
 when
> > > >>> I perform a normal NFS mount, and do I/O, then I don't want to se=
e
> > > >>> extra memory allocations, extra indirect calls and larger inode
> > > >>> footprints.
> > > >>>
> > > >>> IOW: I want the code to optimise for the case of standard NFS, no=
t for
> > > >>> the case of 'NFS with cachefs additions'.
> > > >>>
> > > >> I agree completely.  Are you seeing extra memory allocations
> > > >> happen on mounts without 'fsc' or is it more a concern or how
> > > >> some of the patches look?  We should not be calling any netfs or
> > > >> fscache code if 'fsc' is not on the mount and I don't see any in m=
y
> > > >> testing. So either there's a misunderstanding here, or there's a
> > > >> bug I'm missing.
> > > >>
> > > >> If fscache is not configured, then nfs_netfs_read_folio() and
> > > >> nfs_netfs_readahead() is a wrapper that returns -ENOBUFS.
> > > >> If it's configured but not enabled, then the checks for
> > > >> netfs_inode(inode)->cache should skip over any netfs code.
> > > >> But maybe there's a non-obvious bug you're seeing and
> > > >> somehow netfs is still getting called?  Because I cannot
> > > >> see netfs getting called if 'fsc' is not on the mount in my
> > > >> tests.
> > > >>
> > > >> int nfs_netfs_read_folio(struct file *file, struct folio *folio)
> > > >> {
> > > >>       if (!netfs_inode(folio_inode(folio))->cache)
> > > >>               return -ENOBUFS;
> > > >>
> > > >>       return netfs_read_folio(file, folio);
> > > >> }
> > > >>
> > > >> int nfs_netfs_readahead(struct readahead_control *ractl)
> > > >> {
> > > >>       struct inode *inode =3D ractl->mapping->host;
> > > >>
> > > >>       if (!netfs_inode(inode)->cache)
> > > >>               return -ENOBUFS;
> > > >>
> > > >>       netfs_readahead(ractl);
> > > >>       return 0;
> > > >> }
> > > >>
> > > >>
> > > >>>>
> > > >>>> Can you be more specific as to the portions of the patch you don=
't
> > > >>>> like
> > > >>>> so I can move it in the right direction?
> > > >>>>
> > > >>>> This is from patch #2 which you didn't comment on.  I'm not sure
> > > >>>> you're
> > > >>>> ok with it though, since you mention "extra bloat to the inode".
> > > >>>> Do you object to this even though it's wrapped in an
> > > >>>> #ifdef CONFIG_NFS_FSCACHE?  If so, do you require no
> > > >>>> extra size be added to nfs_inode?
> > > >>>>
> > > >>>> @@ -204,9 +208,11 @@ struct nfs_inode {
> > > >>>>       __u64 write_io;
> > > >>>>       __u64 read_io;
> > > >>>> #ifdef CONFIG_NFS_FSCACHE
> > > >>>> -       struct fscache_cookie   *fscache;
> > > >>>> -#endif
> > > >>>> +       struct netfs_inode      netfs; /* netfs context and VFS =
inode
> > > >>>> */
> > > >>>> +#else
> > > >>>>       struct inode            vfs_inode;
> > > >>>> +#endif
> > > >>>> +
> > > >>>
> > > >>> Ideally, I'd prefer no extra size. I can live with it up to a cer=
tain
> > > >>> point, however for now NFS is not unconditionally opting into the=
 netfs
> > > >>> project. If we're to ever do that, then I want to see streamlined=
 code
> > > >>> for the standard I/O case.
> > > >>>
> > > >> Ok and understood about standard I/O case.
> > > >>
> > > >> I was thinking how we might not increase the size, but I don't thi=
nk
> > > >> I can make it work.
> > > >>
> > > >> I thought we could change to something like the below, without an
> > > >> embedded struct inode:
> > > >>
> > > >> @@ -204,9 +208,11 @@ struct nfs_inode {
> > > >>       __u64 write_io;
> > > >>       __u64 read_io;
> > > >> #ifdef CONFIG_NFS_FSCACHE
> > > >> -       struct fscache_cookie   *fscache;
> > > >> -#endif
> > > >> +       struct netfs_inode      *netfs; /* netfs context and VFS i=
node */
> > > >> +#else
> > > >>       struct inode            vfs_inode;
> > > >> +#endif
> > > >> +
> > > >>
> > > >> Then I would need to alloc/free a netfs_inode at the time of
> > > >> nfs_inode initiation.  Unfortunately this has the issue that the N=
FS_I()
> > > >> macro cannot work, because it requires an embedded "struct inode"
> > > >> due to "container_of" use:
> > > >>
> > > >> +#ifdef CONFIG_NFS_FSCACHE
> > > >> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > >> +{
> > > >> +       return &nfsi->netfs.inode;
> > > >> +}
> > > >> +static inline struct nfs_inode *NFS_I(const struct inode *inode)
> > > >> +{
> > > >> +       return container_of(inode, struct nfs_inode, netfs.inode);
> > > >> +}
> > > >> +#else
> > > >> +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > >> +{
> > > >> +       return &nfsi->vfs_inode;
> > > >> +}
> > > >> static inline struct nfs_inode *NFS_I(const struct inode *inode)
> > > >> {
> > > >>       return container_of(inode, struct nfs_inode, vfs_inode);
> > > >> }
> > > >> +#endif
> > > >>
> > > >>
> > > >
> > > > Actually Trond maybe we can achieve a "0 length increase" of
> > > > nfs_inode if dhowells would take a patch to modify the definition
> > > > of struct netfs_inode and netfs_inode_init(), something like the WI=
P
> > > > patch below.  What do you think?
> > >
> > > That works for me.
> > >
> > > >
> > > > I think maybe this could be a follow-on patch and if you/dhowells
> > > > think it's an ok idea I can try to work out what is needed across
> > > > the tree.  I thought about it more and I kinda agree that in the
> > > > case for NFS where fscache is "configured but not enabled",
> > > > then even though we're only adding 24 bytes to the nfs_inode
> > > > each time, it will add up so it is worth at least a discussion.
> > > >
> > > > diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> > > > index f2402ddeafbf..195714f1c355 100644
> > > > --- a/include/linux/netfs.h
> > > > +++ b/include/linux/netfs.h
> > > > @@ -118,11 +118,7 @@ enum netfs_io_source {
> > > > typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferr=
ed_or_error,
> > > >                                     bool was_async);
> > > >
> > > > -/*
> > > > - * Per-inode context.  This wraps the VFS inode.
> > > > - */
> > > > -struct netfs_inode {
> > > > -       struct inode            inode;          /* The VFS inode */
> > > > +struct netfs_info {
> > > >       const struct netfs_request_ops *ops;
> > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > >       struct fscache_cookie   *cache;
> > > > @@ -130,6 +126,14 @@ struct netfs_inode {
> > > >       loff_t                  remote_i_size;  /* Size of the remote=
 file */
> > > > };
> > > >
> > > > +/*
> > > > + * Per-inode context.  This wraps the VFS inode.
> > > > + */
> > > > +struct netfs_inode {
> > > > +       struct inode            inode;          /* The VFS inode */
> > > > +       struct netfs_info       *netfs;         /* Rest of netfs da=
ta */
> > > > +};
> > > > +
> > > > /*
> > > > * Resources required to do operations on a cache.
> > > > */
> > > > @@ -312,10 +316,12 @@ static inline struct netfs_inode
> > > > *netfs_inode(struct inode *inode)
> > > > static inline void netfs_inode_init(struct netfs_inode *ctx,
> > > >                                   const struct netfs_request_ops *o=
ps)
> > > > {
> > > > -       ctx->ops =3D ops;
> > > > -       ctx->remote_i_size =3D i_size_read(&ctx->inode);
> > > > +       ctx->netfs =3D kzalloc(sizeof(struct netfs_info)), GFP_KERN=
EL);
> > > > +       /* FIXME: Check for NULL */
> > > > +       ctx->netfs->ops =3D ops;
> > > > +       ctx->netfs->remote_i_size =3D i_size_read(&ctx->inode);
> > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > -       ctx->cache =3D NULL;
> > > > +       ctx->netfs->cache =3D NULL;
> > > > #endif
> > > > }
> > > >
> > > >
> > > >
> > > >>
> > > >>>>
> > > >>>>
> > > >>>> Are you ok with the stub functions which are placed in fscache.h=
, and
> > > >>>> when CONFIG_NFS_FSCACHE is not set, become either a no-op
> > > >>>> or a 1-liner (nfs_netfs_readpage_release)?
> > > >>>>
> > > >>>> #else /* CONFIG_NFS_FSCACHE */
> > > >>>> +static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)=
 {}
> > > >>>> +static inline void nfs_netfs_initiate_read(struct nfs_pgio_head=
er
> > > >>>> *hdr) {}
> > > >>>> +static inline void nfs_netfs_read_completion(struct nfs_pgio_he=
ader
> > > >>>> *hdr) {}
> > > >>>> +static inline void nfs_netfs_readpage_release(struct nfs_page *=
req)
> > > >>>> +{
> > > >>>> +       unlock_page(req->wb_page);
> > > >>>> +}
> > > >>>> static inline void nfs_fscache_release_super_cookie(struct
> > > >>>> super_block *sb) {}
> > > >>>> static inline void nfs_fscache_init_inode(struct inode *inode) {=
}
> > > >>>>
> > > >>>>
> > > >>>> Do you object to the below?  If so, then do you want
> > > >>>> #ifdef CONFIG_NFS_FSCACHE here?
> > > >>>>
> > > >>>> -- a/fs/nfs/inode.c
> > > >>>> +++ b/fs/nfs/inode.c
> > > >>>> @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struct
> > > >>>> super_block *sb)
> > > >>>> #ifdef CONFIG_NFS_V4_2
> > > >>>>       nfsi->xattr_cache =3D NULL;
> > > >>>> #endif
> > > >>>> +       nfs_netfs_inode_init(nfsi);
> > > >>>> +
> > > >>>>       return VFS_I(nfsi);
> > > >>>> }
> > > >>>> EXPORT_SYMBOL_GPL(nfs_alloc_i
> > > >>>> node);
> > > >>>>
> > > >>>>
> > > >>>> Do you object to the changes in fs/nfs/read.c?  Specifically,
> > > >>>> how about the below calls to netfs from nfs_read_folio and
> > > >>>> nfs_readahead into equivalent netfs calls?  So when
> > > >>>> NFS_CONFIG_FSCACHE is set, but fscache is not enabled
> > > >>>> ('fsc' not on mount), these netfs functions do immediately call
> > > >>>> netfs_alloc_request().  But I wonder if we could simply add a
> > > >>>> check to see if fscache is enabled on the mount, and skip
> > > >>>> over to satisfy what you want.  Am I understanding what you
> > > >>>> want?
> > > >>>
> > > >>> Quite frankly, I'd prefer that we just split out the functionalit=
y that
> > > >>> is needed from the netfs code so that it can be optimised. Howeve=
r I'm
> > > >>> not interested enough in the cachefs functionality to work on tha=
t
> > > >>> myself. ...and as I indicated above, I might be OK with opting in=
to the
> > > >>> netfs project, once the overhead can be made to disappear.
> > > >>>
> > > >> Understood.
> > > >>
> > > >> If you think it makes more sense, I can move some of the nfs_netfs=
_*
> > > >> functions into a netfs.c file as a starting point.  Or that can ma=
ybe
> > > >> be done in a future patchset?
> > > >>
> > > >> For now I was equating netfs and fscache together so we can
> > > >> move on from the much older and single-page limiting fscache
> > > >> interface that is likely to go away soon.
> > > >>
> > > >>>>
> > > >>>> @@ -355,6 +343,10 @@ int nfs_read_folio(struct file *file, struc=
t
> > > >>>> folio *folio)
> > > >>>>       if (NFS_STALE(inode))
> > > >>>>               goto out_unlock;
> > > >>>>
> > > >>>> +       ret =3D nfs_netfs_read_folio(file, folio);
> > > >>>> +       if (!ret)
> > > >>>> +               goto out;
> > > >>>> +
> > > >>>>
> > > >>>> @@ -405,6 +399,10 @@ void nfs_readahead(struct readahead_control
> > > >>>> *ractl)
> > > >>>>       if (NFS_STALE(inode))
> > > >>>>               goto out;
> > > >>>>
> > > >>>> +       ret =3D nfs_netfs_readahead(ractl);
> > > >>>> +       if (!ret)
> > > >>>> +               goto out;
> > > >>>> +
> > > >>>>
> > > >> The above wrappers should prevent any additional overhead when fsc=
ache
> > > >> is not enabled.  As far as I know these work to avoid calling netf=
s
> > > >> when 'fsc' is not on the mount.
> > > >>
> > > >>>>
> > > >>>> And how about these calls from different points in the read
> > > >>>> path to the earlier mentioned stub functions?
> > > >>>>
> > > >>>> @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_md=
s);
> > > >>>>
> > > >>>> static void nfs_readpage_release(struct nfs_page *req, int error=
)
> > > >>>> {
> > > >>>> -       struct inode *inode =3D d_inode(nfs_req_openctx(req)->de=
ntry);
> > > >>>>       struct page *page =3D req->wb_page;
> > > >>>>
> > > >>>> -       dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_s=
b-
> > > >>>>> s_id,
> > > >>>> -               (unsigned long long)NFS_FILEID(inode), req->wb_b=
ytes,
> > > >>>> -               (long long)req_offset(req));
> > > >>>> -
> > > >>>>       if (nfs_error_is_fatal_on_server(error) && error !=3D -
> > > >>>> ETIMEDOUT)
> > > >>>>               SetPageError(page);
> > > >>>> -       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
> > > >>>> -               if (PageUptodate(page))
> > > >>>> -                       nfs_fscache_write_page(inode, page);
> > > >>>> -               unlock_page(page);
> > > >>>> -       }
> > > >>>> +       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > >>>> +               nfs_netfs_readpage_release(req);
> > > >>>> +
> > > >>>
> > > >>> I'm not seeing the value of wrapping unlock_page(), no... That co=
de is
> > > >>> going to need to change when we move it to use folios natively an=
yway.
> > > >>>
> > > >> Ok, how about I make it conditional on whether fscache is configur=
ed
> > > >> and enabled then, similar to the nfs_netfs_read_folio() and
> > > >> nfs_netfs_readahead()?  Below is what that would look like.
> > > >> I could inline the code in nfs_netfs_readpage_release() if you
> > > >> think it would be clearer.
> > > >>
> > > >> static void nfs_readpage_release(struct nfs_page *req, int error)
> > > >> {
> > > >>       struct page *page =3D req->wb_page;
> > > >>
> > > >>       if (nfs_error_is_fatal_on_server(error) && error !=3D -ETIME=
DOUT)
> > > >>               SetPageError(page);
> > > >>       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > >> #ifndef CONFIG_NFS_FSCACHE
> > > >>               unlock_page(req->wb_page);
> > > >> #else
> > > >>               nfs_netfs_readpage_release(req);
> > > >> #endif
> > > >>       nfs_release_request(req);
> > > >> }
> > > >>
> > > >>
> > > >> void nfs_netfs_readpage_release(struct nfs_page *req)
> > > >> {
> > > >>   struct inode *inode =3D d_inode(nfs_req_openctx(req)->dentry);
> > > >>
> > > >>   /*
> > > >>    * If fscache is enabled, netfs will unlock pages.
> > > >>    */
> > > >>   if (netfs_inode(inode)->cache)
> > > >>       return;
> > > >>
> > > >>   unlock_page(req->wb_page);
> > > >> }
> > > >>
> > > >>
> > > >>>>       nfs_release_request(req);
> > > >>>> }
> > > >>>>
> > > >>>> @@ -177,6 +170,8 @@ static void nfs_read_completion(struct
> > > >>>> nfs_pgio_header *hdr)
> > > >>>>               nfs_list_remove_request(req);
> > > >>>>               nfs_readpage_release(req, error);
> > > >>>>       }
> > > >>>> +       nfs_netfs_read_completion(hdr);
> > > >>>> +
> > > >>>> out:
> > > >>>>       hdr->release(hdr);
> > > >>>> }
> > > >>>> @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct
> > > >>>> nfs_pgio_header *hdr,
> > > >>>>                             struct rpc_task_setup *task_setup_da=
ta,
> > > >>>> int how)
> > > >>>> {
> > > >>>>       rpc_ops->read_setup(hdr, msg);
> > > >>>> +       nfs_netfs_initiate_read(hdr);
> > > >>>>       trace_nfs_initiate_read(hdr);
> > > >>>> }
> > > >>>>
> > > >>>>
> > > >>>> Are you ok with these additions?  Something like this would
> > > >>>> be required in the case of fscache configured and enabled,
> > > >>>> because we could have some of the data in a read in
> > > >>>> fscache, and some not.  That is the reason for the netfs
> > > >>>> design, and why we need to be able to call the normal
> > > >>>> NFS read IO path (netfs calls into issue_read, and we call
> > > >>>> back via netfs_subreq_terminated)?
> > > >>>>
> > > >>>> @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
> > > >>>>       struct pnfs_layout_segment *pg_lseg;
> > > >>>>       struct nfs_io_completion *pg_io_completion;
> > > >>>>       struct nfs_direct_req   *pg_dreq;
> > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > >>>> +       void                    *pg_netfs;
> > > >>>> +#endif
> > > >>>>
> > > >>>> @@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
> > > >>>>       const struct nfs_rw_ops *rw_ops;
> > > >>>>       struct nfs_io_completion *io_completion;
> > > >>>>       struct nfs_direct_req   *dreq;
> > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > >>>> +       void                    *netfs;
> > > >>>> +#endif
> > > >>>>
> > > >>>>
> > > >>>> And these additions to pagelist.c?
> > > >>>>
> > > >>>> @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct
> > > >>>> nfs_pageio_descriptor *desc,
> > > >>>>       hdr->good_bytes =3D mirror->pg_count;
> > > >>>>       hdr->io_completion =3D desc->pg_io_completion;
> > > >>>>       hdr->dreq =3D desc->pg_dreq;
> > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > >>>> +       if (desc->pg_netfs)
> > > >>>> +               hdr->netfs =3D desc->pg_netfs;
> > > >>>> +#endif
> > > >>>
> > > >>> Why the conditional?
> > > >>>
> > > >> Not really needed and I was thinking of removing it, so I'll do th=
at.
> > > >>
> > > >>>>
> > > >>>>
> > > >>>> @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pageio_descr=
iptor
> > > >>>> *desc,
> > > >>>>       desc->pg_lseg =3D NULL;
> > > >>>>       desc->pg_io_completion =3D NULL;
> > > >>>>       desc->pg_dreq =3D NULL;
> > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > >>>> +       desc->pg_netfs =3D NULL;
> > > >>>> +#endif
> > > >>>>
> > > >>>>
> > > >>>> @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct
> > > >>>> nfs_pageio_descriptor *desc,
> > > >>>>
> > > >>>>       desc->pg_io_completion =3D hdr->io_completion;
> > > >>>>       desc->pg_dreq =3D hdr->dreq;
> > > >>>> +#ifdef CONFIG_NFS_FSCACHE
> > > >>>> +       desc->pg_netfs =3D hdr->netfs;
> > > >>>> +#endif
> > > >>>
> > > >>> Those all need wrapper functions instead of embedding #ifdefs.
> > > >>>
> > > >> Ok.
> > > >>
> > > >>
> > > >>
> > > >>>>
> > > >>>>
> > > >>>>> My expectation is that the standard I/O path should have minima=
l
> > > >>>>> overhead, and should certainly not increase the overhead that w=
e
> > > >>>>> already have. Will this be addressed in future iterations of th=
ese
> > > >>>>> patches?
> > > >>>>>
> > > >>>>
> > > >>>> I will do what I can to satisfy what you want, either by fixing =
up
> > > >>>> this patch or follow-on patches.  Hopefully the above questions
> > > >>>> will clarify the next steps.
> > > >>>>
> > > >>>
> > > >>> --
> > > >>> Trond Myklebust
> > > >>> Linux NFS client maintainer, Hammerspace
> > > >>> trond.myklebust@hammerspace.com
> > >
> > >
> > >
> > > Trond Myklebust
> > > CTO, Hammerspace Inc
> > > 1900 S Norfolk St, Suite 350 - #45
> > > San Mateo, CA 94403
> > >
> > > www.hammer.space
> > >
> > >
> >
>
