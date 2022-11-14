Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E8628102
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 14:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiKNNPN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiKNNPL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 08:15:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37871AD8F
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:15:08 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d123so8070413iof.7
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAtuIKUWVWvGcCBybQBH2IH8Rr7ymPTvj/I0PCFRFdQ=;
        b=XH75wrlL1mhr7A6tvJhHbTnnkEDsaibqCW6bd1RPfI1/z6SiP0ReuHCH3ZJGN77vJ2
         1aXgGD7Mvqhwf2YLuVb293xc+zDhgAPVQbH9152DdFSrRTVAzJKPxPrkpnr4wgSpAZk9
         UN8MifB5H42Z4FUrpTqCimf940Lmazog++4bYpcY/g8ge9Z1G/9D8fAicqBGWPMsOp4y
         VF5UKmtti1CY25PLuImM4WB5GnikrHx3XFkUwoViM/BIUsiBxx1ijbU7BCfOfJCApAib
         E49oyWjDYkuTmTJVgNLqTZ9FrvgeYu6oAbIMpdGq9eLDHPkwtHkdPpubijQRElW7onz3
         Q5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAtuIKUWVWvGcCBybQBH2IH8Rr7ymPTvj/I0PCFRFdQ=;
        b=vm7o/XOBA7GcSqQ+iyA8Ay2qrm/ccv54Ahphpd+2zhgSqAGA3H9XJTSoKVQrR9GFhD
         wwbJ8pvHwVjkpuzUpjKjxxaFpR88a0dT3LN1PRxpvEtXjxMmE60z45NtBK0mmiEgTw/V
         Tn9npuKkpIDg0tq+9XLOkjhqnkZUUJjBtyQcA1sv9MOOfInnLDhgcoC/0x8yfYaaHS9n
         WOl0wGbI3Xiruw0RornnJb3SRe91Ced56h4i1wYgFs4LrtqGE6YkYAdDI/CrYjmZc99A
         ++xBztTiOu+9C+RY4mLgMrwQGWlsVG32yA94aZVIYz7QDQ1rtZYRb3/bPFXjLcL7HzUv
         p6qQ==
X-Gm-Message-State: ANoB5pmp7+bEWVR/4DzsobQzTnNkefz5aeFNXMGMovdEZ455Ax1qc6qA
        6CViA3iHG+id9/WXfx0lf646R1yKRkBL0IknSre7N6BoeD77redm
X-Google-Smtp-Source: AA0mqf4N0nORvOO4/jqkRWEuS9oQl31oYTx6gqSt4BgfWKgPOry2uLthqWiXPdJTDEhMiA4F0pFemd3DYh7C12pPCFo=
X-Received: by 2002:a02:862d:0:b0:363:9dc9:116a with SMTP id
 e42-20020a02862d000000b003639dc9116amr5568554jai.119.1668431707526; Mon, 14
 Nov 2022 05:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20221017105212.77588-1-dwysocha@redhat.com> <20221017105212.77588-4-dwysocha@redhat.com>
 <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
 <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
 <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
 <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
 <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
 <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com> <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
 <CALF+zOkxbLV4qzkaydBThmKfQKOP07jyq8o10YMfP2TgvAdZMQ@mail.gmail.com>
 <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com> <c9f099950de1b52c1eeb7df62425b9affbd64102.camel@poochiereds.net>
In-Reply-To: <c9f099950de1b52c1eeb7df62425b9affbd64102.camel@poochiereds.net>
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Mon, 14 Nov 2022 13:14:31 +0000
Message-ID: <CA+QRt4vBPRRd+2QPhBoBC_jWsxJfJfZwX6wNXZbFu+-x87ff-A@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs when
 fscache is enabled
To:     Jeff Layton <jlayton@poochiereds.net>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
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

The source server is Linux, exporting an ext4 filesystem.

benmaynard@bjmtesting-source:~$ cat /etc/lsb-release
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D20.04
DISTRIB_CODENAME=3Dfocal
DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.5 LTS"

benmaynard@bjmtesting-source:~$ uname -r
5.15.0-1021-gcp

benmaynard@bjmtesting-source:~$ df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/root      ext4      194G  2.5G  192G   2% /
/dev/sdb1      ext4      2.0T  501G  1.4T  27% /files

benmaynard@bjmtesting-source:~$ cat /etc/exports
/files 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_ch=
eck,sec=3Dsys,secure,nohide)


Kind Regards
Benjamin Maynard


Kind Regards

Benjamin Maynard

Customer Engineer

benmaynard@google.com

Google, Inc.




On Mon, 14 Nov 2022 at 13:07, Jeff Layton <jlayton@poochiereds.net> wrote:
>
> On Mon, 2022-11-14 at 12:42 +0000, Benjamin Maynard wrote:
> > Thanks Dave for getting back to me so quickly.
> >
> > > Due to use of "drop_caches" this is almost certainly the known issue =
#1
> > > I mentioned in the opening post of this series:
> > > https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.=
com/
> >
> > Apologies, I completely missed the known issues in the original
> > opening message of the series. Just to clarify, I was only ever
> > dropping the caches on the "NFS Client" in the below relationship:
> >
> > Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client.
> >
>
> What sort of server is the Source NFS server here? If it's also Linux,
> then what sort of filesystem is being exported?
>
> > I never dropped the caches on the Re-Export Server (the server running
> > FS-Cache) at any point.
> >
> > However my rsize was lower than my readahead value. I've since correcte=
d that:
> >
> > benmaynard@demo-cluster-1-26hm:~$ cat /proc/mounts | grep nfs
> > 10.0.0.49:/files /srv/nfs/files nfs
> > rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregm=
in=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3Dtc=
p,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.49,mou=
ntvers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,addr=3D=
10.0.0.49
> > 0 0
> >
> > benmaynard@demo-cluster-1-26hm:~$ findmnt -rnu -t nfs,nfs4 -o MAJ:MIN,T=
ARGET
> > 0:52 /srv/nfs/files
> > benmaynard@demo-cluster-1-26hm:~$ cat /sys/class/bdi/0\:52/read_ahead_k=
b
> > 512
> >
> > With this configuration I see the same issue, FS-Cache never reads
> > from /var/cache/fscache, and copying the same file always leads to
> > heavy writes to /var/cache/fscache (the cache is overwriting itself).
> >
> > I have also tried this copy without clearing the caches on any server
> > in the chain, and the same happens.
> >
> > Would you expect this behaviour even though rsize > read ahead? Would
> > you expect the referenced patch to fix this?
> >
> > I tried to apply the patch you suggested
> > (https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html)
> > but it did not apply cleanly, and I ran out of time to troubleshoot. I
> > should get some more time on Wednesday and I can re-try.
> >
> >
> > Kind Regards
> > Benjamin Maynard
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
> > On Mon, 14 Nov 2022 at 10:41, David Wysochanski <dwysocha@redhat.com> w=
rote:
> > >
> > > Hi Ben,
> > >
> > > Thanks for testing these patches.  More below.
> > >
> > > On Sat, Nov 12, 2022 at 7:47 AM Benjamin Maynard <benmaynard@google.c=
om> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I've been doing some more testing with these patches, I applied all=
 of
> > > > the patches (v10 from
> > > > https://patchwork.kernel.org/project/linux-nfs/list/?series=3D69172=
9)
> > > > apart from Patch 6 (the RFC patch) to version 6.0.8 of the kernel.
> > > >
> > > > I have the following setup:
> > > >
> > > > Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Clie=
nt.
> > > >
> > > > I have a 500Gb file on the Source NFS Server, which I am then copyi=
ng
> > > > to the NFS Client via the Re-Export Server.
> > > >
> > > > On the first copy, I see heavy writes to /var/cache/fscache on the
> > > > re-export server, and once the file copy completes I see that
> > > > /var/cache/fscache is approximately 500Gb in size. All good so far.
> > > >
> > > > I then deleted that file from the NFS Client, and dropped the cache=
s
> > > > just to be safe (echo 3 > /proc/sys/vm/drop_caches on the NFS Clien=
t).
> > > >
> > > > I then performed another copy of the 500Gb file on the NFS Client,
> > > > again via the Re-Export Server. What I expected would happen is tha=
t I
> > > > would see heavy reads from the /var/cache/fscache volume as the fil=
e
> > > > should be served from FS-Cache.
> > > >
> > > > However what I actually saw was no reads whatsoever, FS-Cache seems=
 to
> > > > be ignored and the file is pulled from the Source NFS Filer again. =
I
> > > > also see heavy writes to /var/cache/fscache, so it appears that
> > > > FS-Cache is overwriting its existing cache, and never using it.
> > > >
> > > Due to use of "drop_caches" this is almost certainly the known issue =
#1
> > > I mentioned in the opening post of this series:
> > > https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.=
com/
> > >
> > > The above issue will be fixed with the following patch which has not
> > > been merged yet:
> > > https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
> > >
> > > Do you have time to do another test to verify that is the case?
> > > If so, I can re-post that patch on top of the first 5 patches in this=
 series,
> > > as well as a second patch that allows NFS to use it.
> > >
> > >
> > > > I only have 104Gb of memory on the Re-Export Server (with FS-Cache)=
 so
> > > > it is not possible that the file is being served from the page cach=
e.
> > > >
> > > > We saw this behaviour before on an older set of the patches when ou=
r
> > > > mount between the Re-Export Server and the Source NFS Filer was usi=
ng
> > > > the "sync" option, but we are now using the "async" option and the
> > > > same is happening.
> > > >
> > > > Mount options:
> > > >
> > > > Source NFS Server <-- Re-Export Server (with FS-Cache):
> > > >
> > > > 10.0.0.49:/files /srv/nfs/files nfs
> > > > rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,ac=
regmin=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=
=3Dtcp,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.4=
9,mountvers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,ad=
dr=3D10.0.0.49
> > > >
> > > > Re-Export Server (with FS-Cache) <-- NFS Client:
> > > >
> > > > 10.0.0.3:/files /mnt/nfs nfs
> > > > rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,h=
ard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.3,moun=
tvers=3D3,mountport=3D20048,mountproto=3Dtcp,local_lock=3Dnone,addr=3D10.0.=
0.3
> > > >
> > > > It is also worth noting this behaviour is not unique to the re-expo=
rt
> > > > use case. I see FS-Cache not being used with the following setup:
> > > >
> > > > Source NFS Server <-- Client (with FS-Cache).
> > > >
> > > > Thanks,
> > > > Ben
> > > >
> > > >
> > > > Kind Regards
> > > >
> > > > Benjamin Maynard
> > > >
> > > > Customer Engineer
> > > >
> > > > benmaynard@google.com
> > > >
> > > > Google, Inc.
> > > >
> > > >
> > > >
> > > >
> > > > On Mon, 31 Oct 2022 at 22:22, Trond Myklebust <trondmy@hammerspace.=
com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On Oct 30, 2022, at 19:25, David Wysochanski <dwysocha@redhat.c=
om> wrote:
> > > > > >
> > > > > > On Sat, Oct 29, 2022 at 12:46 PM David Wysochanski <dwysocha@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 28, 2022 at 12:59 PM Trond Myklebust <trondmy@ker=
nel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 2022-10-28 at 07:50 -0400, David Wysochanski wrote:
> > > > > > > > > On Thu, Oct 27, 2022 at 3:16 PM Trond Myklebust <trondmy@=
kernel.org>
> > > > > > > > > wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wro=
te:
> > > > > > > > > > > Convert the NFS buffered read code paths to correspon=
ding netfs
> > > > > > > > > > > APIs,
> > > > > > > > > > > but only when fscache is configured and enabled.
> > > > > > > > > > >
> > > > > > > > > > > The netfs API defines struct netfs_request_ops which =
must be
> > > > > > > > > > > filled
> > > > > > > > > > > in by the network filesystem.  For NFS, we only need =
to define 5
> > > > > > > > > > > of
> > > > > > > > > > > the functions, the main one being the issue_read() fu=
nction.
> > > > > > > > > > > The issue_read() function is called by the netfs laye=
r when a
> > > > > > > > > > > read
> > > > > > > > > > > cannot be fulfilled locally, and must be sent to the =
server
> > > > > > > > > > > (either
> > > > > > > > > > > the cache is not active, or it is active but the data=
 is not
> > > > > > > > > > > available).
> > > > > > > > > > > Once the read from the server is complete, netfs requ=
ires a call
> > > > > > > > > > > to
> > > > > > > > > > > netfs_subreq_terminated() which conveys either how ma=
ny bytes
> > > > > > > > > > > were
> > > > > > > > > > > read
> > > > > > > > > > > successfully, or an error.  Note that issue_read() is=
 called with
> > > > > > > > > > > a
> > > > > > > > > > > structure, netfs_io_subrequest, which defines the IO =
requested,
> > > > > > > > > > > and
> > > > > > > > > > > contains a start and a length (both in bytes), and as=
sumes the
> > > > > > > > > > > underlying
> > > > > > > > > > > netfs will return a either an error on the whole regi=
on, or the
> > > > > > > > > > > number
> > > > > > > > > > > of bytes successfully read.
> > > > > > > > > > >
> > > > > > > > > > > The NFS IO path is page based and the main APIs are t=
he pgio APIs
> > > > > > > > > > > defined
> > > > > > > > > > > in pagelist.c.  For the pgio APIs, there is no way fo=
r the caller
> > > > > > > > > > > to
> > > > > > > > > > > know how many RPCs will be sent and how the pages wil=
l be broken
> > > > > > > > > > > up
> > > > > > > > > > > into underlying RPCs, each of which will have their o=
wn
> > > > > > > > > > > completion
> > > > > > > > > > > and
> > > > > > > > > > > return code.  In contrast, netfs is subrequest based,=
 a single
> > > > > > > > > > > subrequest may contain multiple pages, and a single s=
ubrequest is
> > > > > > > > > > > initiated with issue_read() and terminated with
> > > > > > > > > > > netfs_subreq_terminated().
> > > > > > > > > > > Thus, to utilze the netfs APIs, NFS needs some way to=
 accommodate
> > > > > > > > > > > the netfs API requirement on the single response to t=
he whole
> > > > > > > > > > > subrequest, while also minimizing disruptive changes =
to the NFS
> > > > > > > > > > > pgio layer.
> > > > > > > > > > >
> > > > > > > > > > > The approach taken with this patch is to allocate a s=
mall
> > > > > > > > > > > structure
> > > > > > > > > > > for each nfs_netfs_issue_read() call, store the final=
 error and
> > > > > > > > > > > number
> > > > > > > > > > > of bytes successfully transferred in the structure, a=
nd update
> > > > > > > > > > > these
> > > > > > > > > > > values
> > > > > > > > > > > as each RPC completes.  The refcount on the structure=
 is used as
> > > > > > > > > > > a
> > > > > > > > > > > marker
> > > > > > > > > > > for the last RPC completion, is incremented in
> > > > > > > > > > > nfs_netfs_read_initiate(),
> > > > > > > > > > > and decremented inside nfs_netfs_read_completion(), w=
hen a
> > > > > > > > > > > nfs_pgio_header
> > > > > > > > > > > contains a valid pointer to the data.  On the final p=
ut (which
> > > > > > > > > > > signals
> > > > > > > > > > > the final outstanding RPC is complete) in
> > > > > > > > > > > nfs_netfs_read_completion(),
> > > > > > > > > > > call netfs_subreq_terminated() with either the final =
error value
> > > > > > > > > > > (if
> > > > > > > > > > > one or more READs complete with an error) or the numb=
er of bytes
> > > > > > > > > > > successfully transferred (if all RPCs complete succes=
sfully).
> > > > > > > > > > > Note
> > > > > > > > > > > that when all RPCs complete successfully, the number =
of bytes
> > > > > > > > > > > transferred
> > > > > > > > > > > is capped to the length of the subrequest.  Capping t=
he
> > > > > > > > > > > transferred
> > > > > > > > > > > length
> > > > > > > > > > > to the subrequest length prevents "Subreq overread" w=
arnings from
> > > > > > > > > > > netfs.
> > > > > > > > > > > This is due to the "aligned_len" in nfs_pageio_add_pa=
ge(), and
> > > > > > > > > > > the
> > > > > > > > > > > corner case where NFS requests a full page at the end=
 of the
> > > > > > > > > > > file,
> > > > > > > > > > > even when i_size reflects only a partial page (NFS ov=
erread).
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This is not doing what I asked for, which was to separa=
te out the
> > > > > > > > > > fscache functionality, so that we can call that if and =
when it is
> > > > > > > > > > available.
> > > > > > > > > >
> > > > > > > > > I must have misunderstood then.
> > > > > > > > >
> > > > > > > > > The last feedback I have from you was that you wanted it =
to be
> > > > > > > > > an opt-in feature, and it was a comment on a previous pat=
ch
> > > > > > > > > to Kconfig.  I was proceeding the best I knew how, but
> > > > > > > > > let me try to get back on track.
> > > > > > > > >
> > > > > > > > > > Instead, it is just wrapping the NFS requests inside ne=
tfs
> > > > > > > > > > requests. As
> > > > > > > > > > it stands, that means it is just duplicating informatio=
n, and
> > > > > > > > > > adding
> > > > > > > > > > unnecessary overhead to the standard I/O path (extra al=
locations,
> > > > > > > > > > extra
> > > > > > > > > > indirect calls, and extra bloat to the inode).
> > > > > > > > > >
> > > > > > > > > I think I understand what you're saying but I'm not sure.=
  Let me
> > > > > > > > > ask some clarifying questions.
> > > > > > > > >
> > > > > > > > > Are you objecting to the code when CONFIG_NFS_FSCACHE is
> > > > > > > > > configured?  Or when it is not?  Or both?  I think you're=
 objecting
> > > > > > > > > when it's configured, but not enabled (we mount without '=
fsc').
> > > > > > > > > Am I right?
> > > > > > > > >
> > > > > > > > > Also, are you objecting to the design that to use fcache =
we now
> > > > > > > > > have to use netfs, specifically:
> > > > > > > > > - call into netfs via either netfs_read_folio or netfs_re=
adahead
> > > > > > > > > - if fscache is enabled, then the IO can be satisfied fro=
m fscache
> > > > > > > > > - if fscache is not enabled, or some of the IO cannot be =
satisfied
> > > > > > > > > from the cache, then NFS is called back via netfs_issue_r=
ead
> > > > > > > > > and we use the normal NFS read pageio interface.  This re=
quires
> > > > > > > > > we call netfs_subreq_terminated() when all the RPCs compl=
ete,
> > > > > > > > > which is the reason for the small changes to pagelist.c
> > > > > > > >
> > > > > > > > I'm objecting to any middle layer "solution" that adds over=
head to the
> > > > > > > > NFS I/O paths.
> > > > > > > >
> > > > > > > Got it.
> > > > > > >
> > > > > > > > I'm willing to consider solutions that are specific only to=
 the fscache
> > > > > > > > use case (i.e. when the 'fsc' mount option is specified). H=
owever when
> > > > > > > > I perform a normal NFS mount, and do I/O, then I don't want=
 to see
> > > > > > > > extra memory allocations, extra indirect calls and larger i=
node
> > > > > > > > footprints.
> > > > > > > >
> > > > > > > > IOW: I want the code to optimise for the case of standard N=
FS, not for
> > > > > > > > the case of 'NFS with cachefs additions'.
> > > > > > > >
> > > > > > > I agree completely.  Are you seeing extra memory allocations
> > > > > > > happen on mounts without 'fsc' or is it more a concern or how
> > > > > > > some of the patches look?  We should not be calling any netfs=
 or
> > > > > > > fscache code if 'fsc' is not on the mount and I don't see any=
 in my
> > > > > > > testing. So either there's a misunderstanding here, or there'=
s a
> > > > > > > bug I'm missing.
> > > > > > >
> > > > > > > If fscache is not configured, then nfs_netfs_read_folio() and
> > > > > > > nfs_netfs_readahead() is a wrapper that returns -ENOBUFS.
> > > > > > > If it's configured but not enabled, then the checks for
> > > > > > > netfs_inode(inode)->cache should skip over any netfs code.
> > > > > > > But maybe there's a non-obvious bug you're seeing and
> > > > > > > somehow netfs is still getting called?  Because I cannot
> > > > > > > see netfs getting called if 'fsc' is not on the mount in my
> > > > > > > tests.
> > > > > > >
> > > > > > > int nfs_netfs_read_folio(struct file *file, struct folio *fol=
io)
> > > > > > > {
> > > > > > >       if (!netfs_inode(folio_inode(folio))->cache)
> > > > > > >               return -ENOBUFS;
> > > > > > >
> > > > > > >       return netfs_read_folio(file, folio);
> > > > > > > }
> > > > > > >
> > > > > > > int nfs_netfs_readahead(struct readahead_control *ractl)
> > > > > > > {
> > > > > > >       struct inode *inode =3D ractl->mapping->host;
> > > > > > >
> > > > > > >       if (!netfs_inode(inode)->cache)
> > > > > > >               return -ENOBUFS;
> > > > > > >
> > > > > > >       netfs_readahead(ractl);
> > > > > > >       return 0;
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > Can you be more specific as to the portions of the patch =
you don't
> > > > > > > > > like
> > > > > > > > > so I can move it in the right direction?
> > > > > > > > >
> > > > > > > > > This is from patch #2 which you didn't comment on.  I'm n=
ot sure
> > > > > > > > > you're
> > > > > > > > > ok with it though, since you mention "extra bloat to the =
inode".
> > > > > > > > > Do you object to this even though it's wrapped in an
> > > > > > > > > #ifdef CONFIG_NFS_FSCACHE?  If so, do you require no
> > > > > > > > > extra size be added to nfs_inode?
> > > > > > > > >
> > > > > > > > > @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > > > > >       __u64 write_io;
> > > > > > > > >       __u64 read_io;
> > > > > > > > > #ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > -       struct fscache_cookie   *fscache;
> > > > > > > > > -#endif
> > > > > > > > > +       struct netfs_inode      netfs; /* netfs context a=
nd VFS inode
> > > > > > > > > */
> > > > > > > > > +#else
> > > > > > > > >       struct inode            vfs_inode;
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Ideally, I'd prefer no extra size. I can live with it up to=
 a certain
> > > > > > > > point, however for now NFS is not unconditionally opting in=
to the netfs
> > > > > > > > project. If we're to ever do that, then I want to see strea=
mlined code
> > > > > > > > for the standard I/O case.
> > > > > > > >
> > > > > > > Ok and understood about standard I/O case.
> > > > > > >
> > > > > > > I was thinking how we might not increase the size, but I don'=
t think
> > > > > > > I can make it work.
> > > > > > >
> > > > > > > I thought we could change to something like the below, withou=
t an
> > > > > > > embedded struct inode:
> > > > > > >
> > > > > > > @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > > >       __u64 write_io;
> > > > > > >       __u64 read_io;
> > > > > > > #ifdef CONFIG_NFS_FSCACHE
> > > > > > > -       struct fscache_cookie   *fscache;
> > > > > > > -#endif
> > > > > > > +       struct netfs_inode      *netfs; /* netfs context and =
VFS inode */
> > > > > > > +#else
> > > > > > >       struct inode            vfs_inode;
> > > > > > > +#endif
> > > > > > > +
> > > > > > >
> > > > > > > Then I would need to alloc/free a netfs_inode at the time of
> > > > > > > nfs_inode initiation.  Unfortunately this has the issue that =
the NFS_I()
> > > > > > > macro cannot work, because it requires an embedded "struct in=
ode"
> > > > > > > due to "container_of" use:
> > > > > > >
> > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > > +{
> > > > > > > +       return &nfsi->netfs.inode;
> > > > > > > +}
> > > > > > > +static inline struct nfs_inode *NFS_I(const struct inode *in=
ode)
> > > > > > > +{
> > > > > > > +       return container_of(inode, struct nfs_inode, netfs.in=
ode);
> > > > > > > +}
> > > > > > > +#else
> > > > > > > +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > > +{
> > > > > > > +       return &nfsi->vfs_inode;
> > > > > > > +}
> > > > > > > static inline struct nfs_inode *NFS_I(const struct inode *ino=
de)
> > > > > > > {
> > > > > > >       return container_of(inode, struct nfs_inode, vfs_inode)=
;
> > > > > > > }
> > > > > > > +#endif
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Actually Trond maybe we can achieve a "0 length increase" of
> > > > > > nfs_inode if dhowells would take a patch to modify the definiti=
on
> > > > > > of struct netfs_inode and netfs_inode_init(), something like th=
e WIP
> > > > > > patch below.  What do you think?
> > > > >
> > > > > That works for me.
> > > > >
> > > > > >
> > > > > > I think maybe this could be a follow-on patch and if you/dhowel=
ls
> > > > > > think it's an ok idea I can try to work out what is needed acro=
ss
> > > > > > the tree.  I thought about it more and I kinda agree that in th=
e
> > > > > > case for NFS where fscache is "configured but not enabled",
> > > > > > then even though we're only adding 24 bytes to the nfs_inode
> > > > > > each time, it will add up so it is worth at least a discussion.
> > > > > >
> > > > > > diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> > > > > > index f2402ddeafbf..195714f1c355 100644
> > > > > > --- a/include/linux/netfs.h
> > > > > > +++ b/include/linux/netfs.h
> > > > > > @@ -118,11 +118,7 @@ enum netfs_io_source {
> > > > > > typedef void (*netfs_io_terminated_t)(void *priv, ssize_t trans=
ferred_or_error,
> > > > > >                                     bool was_async);
> > > > > >
> > > > > > -/*
> > > > > > - * Per-inode context.  This wraps the VFS inode.
> > > > > > - */
> > > > > > -struct netfs_inode {
> > > > > > -       struct inode            inode;          /* The VFS inod=
e */
> > > > > > +struct netfs_info {
> > > > > >       const struct netfs_request_ops *ops;
> > > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > > >       struct fscache_cookie   *cache;
> > > > > > @@ -130,6 +126,14 @@ struct netfs_inode {
> > > > > >       loff_t                  remote_i_size;  /* Size of the re=
mote file */
> > > > > > };
> > > > > >
> > > > > > +/*
> > > > > > + * Per-inode context.  This wraps the VFS inode.
> > > > > > + */
> > > > > > +struct netfs_inode {
> > > > > > +       struct inode            inode;          /* The VFS inod=
e */
> > > > > > +       struct netfs_info       *netfs;         /* Rest of netf=
s data */
> > > > > > +};
> > > > > > +
> > > > > > /*
> > > > > > * Resources required to do operations on a cache.
> > > > > > */
> > > > > > @@ -312,10 +316,12 @@ static inline struct netfs_inode
> > > > > > *netfs_inode(struct inode *inode)
> > > > > > static inline void netfs_inode_init(struct netfs_inode *ctx,
> > > > > >                                   const struct netfs_request_op=
s *ops)
> > > > > > {
> > > > > > -       ctx->ops =3D ops;
> > > > > > -       ctx->remote_i_size =3D i_size_read(&ctx->inode);
> > > > > > +       ctx->netfs =3D kzalloc(sizeof(struct netfs_info)), GFP_=
KERNEL);
> > > > > > +       /* FIXME: Check for NULL */
> > > > > > +       ctx->netfs->ops =3D ops;
> > > > > > +       ctx->netfs->remote_i_size =3D i_size_read(&ctx->inode);
> > > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > > > -       ctx->cache =3D NULL;
> > > > > > +       ctx->netfs->cache =3D NULL;
> > > > > > #endif
> > > > > > }
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Are you ok with the stub functions which are placed in fs=
cache.h, and
> > > > > > > > > when CONFIG_NFS_FSCACHE is not set, become either a no-op
> > > > > > > > > or a 1-liner (nfs_netfs_readpage_release)?
> > > > > > > > >
> > > > > > > > > #else /* CONFIG_NFS_FSCACHE */
> > > > > > > > > +static inline void nfs_netfs_inode_init(struct nfs_inode=
 *nfsi) {}
> > > > > > > > > +static inline void nfs_netfs_initiate_read(struct nfs_pg=
io_header
> > > > > > > > > *hdr) {}
> > > > > > > > > +static inline void nfs_netfs_read_completion(struct nfs_=
pgio_header
> > > > > > > > > *hdr) {}
> > > > > > > > > +static inline void nfs_netfs_readpage_release(struct nfs=
_page *req)
> > > > > > > > > +{
> > > > > > > > > +       unlock_page(req->wb_page);
> > > > > > > > > +}
> > > > > > > > > static inline void nfs_fscache_release_super_cookie(struc=
t
> > > > > > > > > super_block *sb) {}
> > > > > > > > > static inline void nfs_fscache_init_inode(struct inode *i=
node) {}
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Do you object to the below?  If so, then do you want
> > > > > > > > > #ifdef CONFIG_NFS_FSCACHE here?
> > > > > > > > >
> > > > > > > > > -- a/fs/nfs/inode.c
> > > > > > > > > +++ b/fs/nfs/inode.c
> > > > > > > > > @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struc=
t
> > > > > > > > > super_block *sb)
> > > > > > > > > #ifdef CONFIG_NFS_V4_2
> > > > > > > > >       nfsi->xattr_cache =3D NULL;
> > > > > > > > > #endif
> > > > > > > > > +       nfs_netfs_inode_init(nfsi);
> > > > > > > > > +
> > > > > > > > >       return VFS_I(nfsi);
> > > > > > > > > }
> > > > > > > > > EXPORT_SYMBOL_GPL(nfs_alloc_i
> > > > > > > > > node);
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Do you object to the changes in fs/nfs/read.c?  Specifica=
lly,
> > > > > > > > > how about the below calls to netfs from nfs_read_folio an=
d
> > > > > > > > > nfs_readahead into equivalent netfs calls?  So when
> > > > > > > > > NFS_CONFIG_FSCACHE is set, but fscache is not enabled
> > > > > > > > > ('fsc' not on mount), these netfs functions do immediatel=
y call
> > > > > > > > > netfs_alloc_request().  But I wonder if we could simply a=
dd a
> > > > > > > > > check to see if fscache is enabled on the mount, and skip
> > > > > > > > > over to satisfy what you want.  Am I understanding what y=
ou
> > > > > > > > > want?
> > > > > > > >
> > > > > > > > Quite frankly, I'd prefer that we just split out the functi=
onality that
> > > > > > > > is needed from the netfs code so that it can be optimised. =
However I'm
> > > > > > > > not interested enough in the cachefs functionality to work =
on that
> > > > > > > > myself. ...and as I indicated above, I might be OK with opt=
ing into the
> > > > > > > > netfs project, once the overhead can be made to disappear.
> > > > > > > >
> > > > > > > Understood.
> > > > > > >
> > > > > > > If you think it makes more sense, I can move some of the nfs_=
netfs_*
> > > > > > > functions into a netfs.c file as a starting point.  Or that c=
an maybe
> > > > > > > be done in a future patchset?
> > > > > > >
> > > > > > > For now I was equating netfs and fscache together so we can
> > > > > > > move on from the much older and single-page limiting fscache
> > > > > > > interface that is likely to go away soon.
> > > > > > >
> > > > > > > > >
> > > > > > > > > @@ -355,6 +343,10 @@ int nfs_read_folio(struct file *file=
, struct
> > > > > > > > > folio *folio)
> > > > > > > > >       if (NFS_STALE(inode))
> > > > > > > > >               goto out_unlock;
> > > > > > > > >
> > > > > > > > > +       ret =3D nfs_netfs_read_folio(file, folio);
> > > > > > > > > +       if (!ret)
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > >
> > > > > > > > > @@ -405,6 +399,10 @@ void nfs_readahead(struct readahead_=
control
> > > > > > > > > *ractl)
> > > > > > > > >       if (NFS_STALE(inode))
> > > > > > > > >               goto out;
> > > > > > > > >
> > > > > > > > > +       ret =3D nfs_netfs_readahead(ractl);
> > > > > > > > > +       if (!ret)
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > >
> > > > > > > The above wrappers should prevent any additional overhead whe=
n fscache
> > > > > > > is not enabled.  As far as I know these work to avoid calling=
 netfs
> > > > > > > when 'fsc' is not on the mount.
> > > > > > >
> > > > > > > > >
> > > > > > > > > And how about these calls from different points in the re=
ad
> > > > > > > > > path to the earlier mentioned stub functions?
> > > > > > > > >
> > > > > > > > > @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_=
read_mds);
> > > > > > > > >
> > > > > > > > > static void nfs_readpage_release(struct nfs_page *req, in=
t error)
> > > > > > > > > {
> > > > > > > > > -       struct inode *inode =3D d_inode(nfs_req_openctx(r=
eq)->dentry);
> > > > > > > > >       struct page *page =3D req->wb_page;
> > > > > > > > >
> > > > > > > > > -       dprintk("NFS: read done (%s/%llu %d@%lld)\n", ino=
de->i_sb-
> > > > > > > > > > s_id,
> > > > > > > > > -               (unsigned long long)NFS_FILEID(inode), re=
q->wb_bytes,
> > > > > > > > > -               (long long)req_offset(req));
> > > > > > > > > -
> > > > > > > > >       if (nfs_error_is_fatal_on_server(error) && error !=
=3D -
> > > > > > > > > ETIMEDOUT)
> > > > > > > > >               SetPageError(page);
> > > > > > > > > -       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE=
)) {
> > > > > > > > > -               if (PageUptodate(page))
> > > > > > > > > -                       nfs_fscache_write_page(inode, pag=
e);
> > > > > > > > > -               unlock_page(page);
> > > > > > > > > -       }
> > > > > > > > > +       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE=
))
> > > > > > > > > +               nfs_netfs_readpage_release(req);
> > > > > > > > > +
> > > > > > > >
> > > > > > > > I'm not seeing the value of wrapping unlock_page(), no... T=
hat code is
> > > > > > > > going to need to change when we move it to use folios nativ=
ely anyway.
> > > > > > > >
> > > > > > > Ok, how about I make it conditional on whether fscache is con=
figured
> > > > > > > and enabled then, similar to the nfs_netfs_read_folio() and
> > > > > > > nfs_netfs_readahead()?  Below is what that would look like.
> > > > > > > I could inline the code in nfs_netfs_readpage_release() if yo=
u
> > > > > > > think it would be clearer.
> > > > > > >
> > > > > > > static void nfs_readpage_release(struct nfs_page *req, int er=
ror)
> > > > > > > {
> > > > > > >       struct page *page =3D req->wb_page;
> > > > > > >
> > > > > > >       if (nfs_error_is_fatal_on_server(error) && error !=3D -=
ETIMEDOUT)
> > > > > > >               SetPageError(page);
> > > > > > >       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > > > > > #ifndef CONFIG_NFS_FSCACHE
> > > > > > >               unlock_page(req->wb_page);
> > > > > > > #else
> > > > > > >               nfs_netfs_readpage_release(req);
> > > > > > > #endif
> > > > > > >       nfs_release_request(req);
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > void nfs_netfs_readpage_release(struct nfs_page *req)
> > > > > > > {
> > > > > > >   struct inode *inode =3D d_inode(nfs_req_openctx(req)->dentr=
y);
> > > > > > >
> > > > > > >   /*
> > > > > > >    * If fscache is enabled, netfs will unlock pages.
> > > > > > >    */
> > > > > > >   if (netfs_inode(inode)->cache)
> > > > > > >       return;
> > > > > > >
> > > > > > >   unlock_page(req->wb_page);
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > > >       nfs_release_request(req);
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > @@ -177,6 +170,8 @@ static void nfs_read_completion(struc=
t
> > > > > > > > > nfs_pgio_header *hdr)
> > > > > > > > >               nfs_list_remove_request(req);
> > > > > > > > >               nfs_readpage_release(req, error);
> > > > > > > > >       }
> > > > > > > > > +       nfs_netfs_read_completion(hdr);
> > > > > > > > > +
> > > > > > > > > out:
> > > > > > > > >       hdr->release(hdr);
> > > > > > > > > }
> > > > > > > > > @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct
> > > > > > > > > nfs_pgio_header *hdr,
> > > > > > > > >                             struct rpc_task_setup *task_s=
etup_data,
> > > > > > > > > int how)
> > > > > > > > > {
> > > > > > > > >       rpc_ops->read_setup(hdr, msg);
> > > > > > > > > +       nfs_netfs_initiate_read(hdr);
> > > > > > > > >       trace_nfs_initiate_read(hdr);
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Are you ok with these additions?  Something like this wou=
ld
> > > > > > > > > be required in the case of fscache configured and enabled=
,
> > > > > > > > > because we could have some of the data in a read in
> > > > > > > > > fscache, and some not.  That is the reason for the netfs
> > > > > > > > > design, and why we need to be able to call the normal
> > > > > > > > > NFS read IO path (netfs calls into issue_read, and we cal=
l
> > > > > > > > > back via netfs_subreq_terminated)?
> > > > > > > > >
> > > > > > > > > @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
> > > > > > > > >       struct pnfs_layout_segment *pg_lseg;
> > > > > > > > >       struct nfs_io_completion *pg_io_completion;
> > > > > > > > >       struct nfs_direct_req   *pg_dreq;
> > > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > +       void                    *pg_netfs;
> > > > > > > > > +#endif
> > > > > > > > >
> > > > > > > > > @@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
> > > > > > > > >       const struct nfs_rw_ops *rw_ops;
> > > > > > > > >       struct nfs_io_completion *io_completion;
> > > > > > > > >       struct nfs_direct_req   *dreq;
> > > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > +       void                    *netfs;
> > > > > > > > > +#endif
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > And these additions to pagelist.c?
> > > > > > > > >
> > > > > > > > > @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct
> > > > > > > > > nfs_pageio_descriptor *desc,
> > > > > > > > >       hdr->good_bytes =3D mirror->pg_count;
> > > > > > > > >       hdr->io_completion =3D desc->pg_io_completion;
> > > > > > > > >       hdr->dreq =3D desc->pg_dreq;
> > > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > +       if (desc->pg_netfs)
> > > > > > > > > +               hdr->netfs =3D desc->pg_netfs;
> > > > > > > > > +#endif
> > > > > > > >
> > > > > > > > Why the conditional?
> > > > > > > >
> > > > > > > Not really needed and I was thinking of removing it, so I'll =
do that.
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pagei=
o_descriptor
> > > > > > > > > *desc,
> > > > > > > > >       desc->pg_lseg =3D NULL;
> > > > > > > > >       desc->pg_io_completion =3D NULL;
> > > > > > > > >       desc->pg_dreq =3D NULL;
> > > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > +       desc->pg_netfs =3D NULL;
> > > > > > > > > +#endif
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct
> > > > > > > > > nfs_pageio_descriptor *desc,
> > > > > > > > >
> > > > > > > > >       desc->pg_io_completion =3D hdr->io_completion;
> > > > > > > > >       desc->pg_dreq =3D hdr->dreq;
> > > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > > +       desc->pg_netfs =3D hdr->netfs;
> > > > > > > > > +#endif
> > > > > > > >
> > > > > > > > Those all need wrapper functions instead of embedding #ifde=
fs.
> > > > > > > >
> > > > > > > Ok.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > My expectation is that the standard I/O path should hav=
e minimal
> > > > > > > > > > overhead, and should certainly not increase the overhea=
d that we
> > > > > > > > > > already have. Will this be addressed in future iteratio=
ns of these
> > > > > > > > > > patches?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I will do what I can to satisfy what you want, either by =
fixing up
> > > > > > > > > this patch or follow-on patches.  Hopefully the above que=
stions
> > > > > > > > > will clarify the next steps.
> > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Trond Myklebust
> > > > > > > > Linux NFS client maintainer, Hammerspace
> > > > > > > > trond.myklebust@hammerspace.com
> > > > >
> > > > >
> > > > >
> > > > > Trond Myklebust
> > > > > CTO, Hammerspace Inc
> > > > > 1900 S Norfolk St, Suite 350 - #45
> > > > > San Mateo, CA 94403
> > > > >
> > > > > www.hammer.space
> > > > >
> > > > >
> > > >
> > >
>
> --
> Jeff Layton <jlayton@poochiereds.net>
