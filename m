Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A776280A6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiKNNHw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 08:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiKNNHo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 08:07:44 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195E2B245
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:07:40 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id x15so7714732qvp.1
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 05:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IxfHGWeOepepf9SRiT+kmCo4Y/C08VmbWuHHohorApk=;
        b=ps7kiYc7EIok89R0ZQHXyfM4FAVdLTB2kf1F38OHzykZdvdLk1/vim8OHlxMCRSW/1
         eA1dw0i37QKEKVG7JIAP3m/f2BUVCWWDvMOCQe5V4Xxfce6SgxSz40FmTg7qlPmTIYPe
         aEcsO8kMeZMCSRUfD6koUxxXdd7YN/dcplQM6zfd1yvzpzZW8B7LsYlg0hdJfBWwqO1b
         7lW6iFz75v3L58b0PEdeKRjGpXnPD57GlY4/lz1y+xTz5Jstac2ZAzC7q62Ti2Ee02q9
         woqsjGAgO7BkRAhdu18mQR272gqlqD8HF5xX5yR75cR8a6c8+G201w2c+UVA22x6aOSr
         Vn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxfHGWeOepepf9SRiT+kmCo4Y/C08VmbWuHHohorApk=;
        b=IPabm5TT5KyWLzDhedFk1nm4jLsrL8twwlNamBx0rZsrTTmRPpWtTQtb71jzSBM+KF
         WsL0PHdhpnZVRbDWNDwMaPj9BStR/2PPEidnnBRVyIYCjOJdAasdsWevbMAqGEC5WIqB
         sEBCefkyIC91cc90ib9C9NWByFHhUVDZytnmAQ03wDDmJBCQtcCh/l7XNMeyCVgy3e1R
         9w/5y8m0Dl/dSOY8jnJSL0Z3Hy685NzUyFry3gyenWBGoO4+lu7w2NsJnDcrIfyznVU9
         1czYvcKRVKLSIUbtv+4d6Zjrggt8FJHbNv4iJ87KscleOlGmyEzM79vH+GeWPgf3Qv8k
         DjAw==
X-Gm-Message-State: ANoB5pkjw14Sl0YeTheu489+4T7N3w3kDfqbT8A8dbsxgxZc2wUFmQAN
        obVyElMk4qGaoG08SrBy3dm+ag==
X-Google-Smtp-Source: AA0mqf6CV6ZokbEW0y4qwrmuXLRUgoGXrJB0wAlyzcY5Vc85kyofoKKIfZaaXCeZ9pXopabM8p5pjw==
X-Received: by 2002:ad4:53ac:0:b0:4af:9543:2eee with SMTP id j12-20020ad453ac000000b004af95432eeemr12353568qvv.2.1668431258986;
        Mon, 14 Nov 2022 05:07:38 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006fa4cac54a4sm6400990qko.133.2022.11.14.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:07:38 -0800 (PST)
Message-ID: <c9f099950de1b52c1eeb7df62425b9affbd64102.camel@poochiereds.net>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Benjamin Maynard <benmaynard@google.com>,
        David Wysochanski <dwysocha@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>,
        Brennan Doyle <brennandoyle@google.com>
Date:   Mon, 14 Nov 2022 08:07:37 -0500
In-Reply-To: <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
         <20221017105212.77588-4-dwysocha@redhat.com>
         <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
         <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
         <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
         <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
         <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
         <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com>
         <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
         <CALF+zOkxbLV4qzkaydBThmKfQKOP07jyq8o10YMfP2TgvAdZMQ@mail.gmail.com>
         <CA+QRt4v2qP5gAxiwYbyHEQHOCG4=fVDBwSBsXJrXb=GaFCKtYg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-14 at 12:42 +0000, Benjamin Maynard wrote:
> Thanks Dave for getting back to me so quickly.
>=20
> > Due to use of "drop_caches" this is almost certainly the known issue #1
> > I mentioned in the opening post of this series:
> > https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.co=
m/
>=20
> Apologies, I completely missed the known issues in the original
> opening message of the series. Just to clarify, I was only ever
> dropping the caches on the "NFS Client" in the below relationship:
>=20
> Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client.
>=20

What sort of server is the Source NFS server here? If it's also Linux,
then what sort of filesystem is being exported?

> I never dropped the caches on the Re-Export Server (the server running
> FS-Cache) at any point.
>=20
> However my rsize was lower than my readahead value. I've since corrected =
that:
>=20
> benmaynard@demo-cluster-1-26hm:~$ cat /proc/mounts | grep nfs
> 10.0.0.49:/files /srv/nfs/files nfs
> rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmin=
=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3Dtcp,=
nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.49,mount=
vers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,addr=3D10=
.0.0.49
> 0 0
>=20
> benmaynard@demo-cluster-1-26hm:~$ findmnt -rnu -t nfs,nfs4 -o MAJ:MIN,TAR=
GET
> 0:52 /srv/nfs/files
> benmaynard@demo-cluster-1-26hm:~$ cat /sys/class/bdi/0\:52/read_ahead_kb
> 512
>=20
> With this configuration I see the same issue, FS-Cache never reads
> from /var/cache/fscache, and copying the same file always leads to
> heavy writes to /var/cache/fscache (the cache is overwriting itself).
>=20
> I have also tried this copy without clearing the caches on any server
> in the chain, and the same happens.
>=20
> Would you expect this behaviour even though rsize > read ahead? Would
> you expect the referenced patch to fix this?
>=20
> I tried to apply the patch you suggested
> (https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html)
> but it did not apply cleanly, and I ran out of time to troubleshoot. I
> should get some more time on Wednesday and I can re-try.
>=20
>=20
> Kind Regards
> Benjamin Maynard
>=20
>=20
> Kind Regards
>=20
> Benjamin Maynard
>=20
> Customer Engineer
>=20
> benmaynard@google.com
>=20
> Google, Inc.
>=20
>=20
>=20
>=20
> On Mon, 14 Nov 2022 at 10:41, David Wysochanski <dwysocha@redhat.com> wro=
te:
> >=20
> > Hi Ben,
> >=20
> > Thanks for testing these patches.  More below.
> >=20
> > On Sat, Nov 12, 2022 at 7:47 AM Benjamin Maynard <benmaynard@google.com=
> wrote:
> > >=20
> > > Hi all,
> > >=20
> > > I've been doing some more testing with these patches, I applied all o=
f
> > > the patches (v10 from
> > > https://patchwork.kernel.org/project/linux-nfs/list/?series=3D691729)
> > > apart from Patch 6 (the RFC patch) to version 6.0.8 of the kernel.
> > >=20
> > > I have the following setup:
> > >=20
> > > Source NFS Server <-- Re-Export Server (with FS-Cache) <-- NFS Client=
.
> > >=20
> > > I have a 500Gb file on the Source NFS Server, which I am then copying
> > > to the NFS Client via the Re-Export Server.
> > >=20
> > > On the first copy, I see heavy writes to /var/cache/fscache on the
> > > re-export server, and once the file copy completes I see that
> > > /var/cache/fscache is approximately 500Gb in size. All good so far.
> > >=20
> > > I then deleted that file from the NFS Client, and dropped the caches
> > > just to be safe (echo 3 > /proc/sys/vm/drop_caches on the NFS Client)=
.
> > >=20
> > > I then performed another copy of the 500Gb file on the NFS Client,
> > > again via the Re-Export Server. What I expected would happen is that =
I
> > > would see heavy reads from the /var/cache/fscache volume as the file
> > > should be served from FS-Cache.
> > >=20
> > > However what I actually saw was no reads whatsoever, FS-Cache seems t=
o
> > > be ignored and the file is pulled from the Source NFS Filer again. I
> > > also see heavy writes to /var/cache/fscache, so it appears that
> > > FS-Cache is overwriting its existing cache, and never using it.
> > >=20
> > Due to use of "drop_caches" this is almost certainly the known issue #1
> > I mentioned in the opening post of this series:
> > https://lore.kernel.org/all/20221103161637.1725471-1-dwysocha@redhat.co=
m/
> >=20
> > The above issue will be fixed with the following patch which has not
> > been merged yet:
> > https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
> >=20
> > Do you have time to do another test to verify that is the case?
> > If so, I can re-post that patch on top of the first 5 patches in this s=
eries,
> > as well as a second patch that allows NFS to use it.
> >=20
> >=20
> > > I only have 104Gb of memory on the Re-Export Server (with FS-Cache) s=
o
> > > it is not possible that the file is being served from the page cache.
> > >=20
> > > We saw this behaviour before on an older set of the patches when our
> > > mount between the Re-Export Server and the Source NFS Filer was using
> > > the "sync" option, but we are now using the "async" option and the
> > > same is happening.
> > >=20
> > > Mount options:
> > >=20
> > > Source NFS Server <-- Re-Export Server (with FS-Cache):
> > >=20
> > > 10.0.0.49:/files /srv/nfs/files nfs
> > > rw,noatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acre=
gmin=3D600,acregmax=3D600,acdirmin=3D600,acdirmax=3D600,hard,nocto,proto=3D=
tcp,nconnect=3D16,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.49,m=
ountvers=3D3,mountport=3D37485,mountproto=3Dtcp,fsc,local_lock=3Dnone,addr=
=3D10.0.0.49
> > >=20
> > > Re-Export Server (with FS-Cache) <-- NFS Client:
> > >=20
> > > 10.0.0.3:/files /mnt/nfs nfs
> > > rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,har=
d,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D10.0.0.3,mountv=
ers=3D3,mountport=3D20048,mountproto=3Dtcp,local_lock=3Dnone,addr=3D10.0.0.=
3
> > >=20
> > > It is also worth noting this behaviour is not unique to the re-export
> > > use case. I see FS-Cache not being used with the following setup:
> > >=20
> > > Source NFS Server <-- Client (with FS-Cache).
> > >=20
> > > Thanks,
> > > Ben
> > >=20
> > >=20
> > > Kind Regards
> > >=20
> > > Benjamin Maynard
> > >=20
> > > Customer Engineer
> > >=20
> > > benmaynard@google.com
> > >=20
> > > Google, Inc.
> > >=20
> > >=20
> > >=20
> > >=20
> > > On Mon, 31 Oct 2022 at 22:22, Trond Myklebust <trondmy@hammerspace.co=
m> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > > On Oct 30, 2022, at 19:25, David Wysochanski <dwysocha@redhat.com=
> wrote:
> > > > >=20
> > > > > On Sat, Oct 29, 2022 at 12:46 PM David Wysochanski <dwysocha@redh=
at.com> wrote:
> > > > > >=20
> > > > > > On Fri, Oct 28, 2022 at 12:59 PM Trond Myklebust <trondmy@kerne=
l.org> wrote:
> > > > > > >=20
> > > > > > > On Fri, 2022-10-28 at 07:50 -0400, David Wysochanski wrote:
> > > > > > > > On Thu, Oct 27, 2022 at 3:16 PM Trond Myklebust <trondmy@ke=
rnel.org>
> > > > > > > > wrote:
> > > > > > > > >=20
> > > > > > > > > On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote=
:
> > > > > > > > > > Convert the NFS buffered read code paths to correspondi=
ng netfs
> > > > > > > > > > APIs,
> > > > > > > > > > but only when fscache is configured and enabled.
> > > > > > > > > >=20
> > > > > > > > > > The netfs API defines struct netfs_request_ops which mu=
st be
> > > > > > > > > > filled
> > > > > > > > > > in by the network filesystem.  For NFS, we only need to=
 define 5
> > > > > > > > > > of
> > > > > > > > > > the functions, the main one being the issue_read() func=
tion.
> > > > > > > > > > The issue_read() function is called by the netfs layer =
when a
> > > > > > > > > > read
> > > > > > > > > > cannot be fulfilled locally, and must be sent to the se=
rver
> > > > > > > > > > (either
> > > > > > > > > > the cache is not active, or it is active but the data i=
s not
> > > > > > > > > > available).
> > > > > > > > > > Once the read from the server is complete, netfs requir=
es a call
> > > > > > > > > > to
> > > > > > > > > > netfs_subreq_terminated() which conveys either how many=
 bytes
> > > > > > > > > > were
> > > > > > > > > > read
> > > > > > > > > > successfully, or an error.  Note that issue_read() is c=
alled with
> > > > > > > > > > a
> > > > > > > > > > structure, netfs_io_subrequest, which defines the IO re=
quested,
> > > > > > > > > > and
> > > > > > > > > > contains a start and a length (both in bytes), and assu=
mes the
> > > > > > > > > > underlying
> > > > > > > > > > netfs will return a either an error on the whole region=
, or the
> > > > > > > > > > number
> > > > > > > > > > of bytes successfully read.
> > > > > > > > > >=20
> > > > > > > > > > The NFS IO path is page based and the main APIs are the=
 pgio APIs
> > > > > > > > > > defined
> > > > > > > > > > in pagelist.c.  For the pgio APIs, there is no way for =
the caller
> > > > > > > > > > to
> > > > > > > > > > know how many RPCs will be sent and how the pages will =
be broken
> > > > > > > > > > up
> > > > > > > > > > into underlying RPCs, each of which will have their own
> > > > > > > > > > completion
> > > > > > > > > > and
> > > > > > > > > > return code.  In contrast, netfs is subrequest based, a=
 single
> > > > > > > > > > subrequest may contain multiple pages, and a single sub=
request is
> > > > > > > > > > initiated with issue_read() and terminated with
> > > > > > > > > > netfs_subreq_terminated().
> > > > > > > > > > Thus, to utilze the netfs APIs, NFS needs some way to a=
ccommodate
> > > > > > > > > > the netfs API requirement on the single response to the=
 whole
> > > > > > > > > > subrequest, while also minimizing disruptive changes to=
 the NFS
> > > > > > > > > > pgio layer.
> > > > > > > > > >=20
> > > > > > > > > > The approach taken with this patch is to allocate a sma=
ll
> > > > > > > > > > structure
> > > > > > > > > > for each nfs_netfs_issue_read() call, store the final e=
rror and
> > > > > > > > > > number
> > > > > > > > > > of bytes successfully transferred in the structure, and=
 update
> > > > > > > > > > these
> > > > > > > > > > values
> > > > > > > > > > as each RPC completes.  The refcount on the structure i=
s used as
> > > > > > > > > > a
> > > > > > > > > > marker
> > > > > > > > > > for the last RPC completion, is incremented in
> > > > > > > > > > nfs_netfs_read_initiate(),
> > > > > > > > > > and decremented inside nfs_netfs_read_completion(), whe=
n a
> > > > > > > > > > nfs_pgio_header
> > > > > > > > > > contains a valid pointer to the data.  On the final put=
 (which
> > > > > > > > > > signals
> > > > > > > > > > the final outstanding RPC is complete) in
> > > > > > > > > > nfs_netfs_read_completion(),
> > > > > > > > > > call netfs_subreq_terminated() with either the final er=
ror value
> > > > > > > > > > (if
> > > > > > > > > > one or more READs complete with an error) or the number=
 of bytes
> > > > > > > > > > successfully transferred (if all RPCs complete successf=
ully).
> > > > > > > > > > Note
> > > > > > > > > > that when all RPCs complete successfully, the number of=
 bytes
> > > > > > > > > > transferred
> > > > > > > > > > is capped to the length of the subrequest.  Capping the
> > > > > > > > > > transferred
> > > > > > > > > > length
> > > > > > > > > > to the subrequest length prevents "Subreq overread" war=
nings from
> > > > > > > > > > netfs.
> > > > > > > > > > This is due to the "aligned_len" in nfs_pageio_add_page=
(), and
> > > > > > > > > > the
> > > > > > > > > > corner case where NFS requests a full page at the end o=
f the
> > > > > > > > > > file,
> > > > > > > > > > even when i_size reflects only a partial page (NFS over=
read).
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > This is not doing what I asked for, which was to separate=
 out the
> > > > > > > > > fscache functionality, so that we can call that if and wh=
en it is
> > > > > > > > > available.
> > > > > > > > >=20
> > > > > > > > I must have misunderstood then.
> > > > > > > >=20
> > > > > > > > The last feedback I have from you was that you wanted it to=
 be
> > > > > > > > an opt-in feature, and it was a comment on a previous patch
> > > > > > > > to Kconfig.  I was proceeding the best I knew how, but
> > > > > > > > let me try to get back on track.
> > > > > > > >=20
> > > > > > > > > Instead, it is just wrapping the NFS requests inside netf=
s
> > > > > > > > > requests. As
> > > > > > > > > it stands, that means it is just duplicating information,=
 and
> > > > > > > > > adding
> > > > > > > > > unnecessary overhead to the standard I/O path (extra allo=
cations,
> > > > > > > > > extra
> > > > > > > > > indirect calls, and extra bloat to the inode).
> > > > > > > > >=20
> > > > > > > > I think I understand what you're saying but I'm not sure.  =
Let me
> > > > > > > > ask some clarifying questions.
> > > > > > > >=20
> > > > > > > > Are you objecting to the code when CONFIG_NFS_FSCACHE is
> > > > > > > > configured?  Or when it is not?  Or both?  I think you're o=
bjecting
> > > > > > > > when it's configured, but not enabled (we mount without 'fs=
c').
> > > > > > > > Am I right?
> > > > > > > >=20
> > > > > > > > Also, are you objecting to the design that to use fcache we=
 now
> > > > > > > > have to use netfs, specifically:
> > > > > > > > - call into netfs via either netfs_read_folio or netfs_read=
ahead
> > > > > > > > - if fscache is enabled, then the IO can be satisfied from =
fscache
> > > > > > > > - if fscache is not enabled, or some of the IO cannot be sa=
tisfied
> > > > > > > > from the cache, then NFS is called back via netfs_issue_rea=
d
> > > > > > > > and we use the normal NFS read pageio interface.  This requ=
ires
> > > > > > > > we call netfs_subreq_terminated() when all the RPCs complet=
e,
> > > > > > > > which is the reason for the small changes to pagelist.c
> > > > > > >=20
> > > > > > > I'm objecting to any middle layer "solution" that adds overhe=
ad to the
> > > > > > > NFS I/O paths.
> > > > > > >=20
> > > > > > Got it.
> > > > > >=20
> > > > > > > I'm willing to consider solutions that are specific only to t=
he fscache
> > > > > > > use case (i.e. when the 'fsc' mount option is specified). How=
ever when
> > > > > > > I perform a normal NFS mount, and do I/O, then I don't want t=
o see
> > > > > > > extra memory allocations, extra indirect calls and larger ino=
de
> > > > > > > footprints.
> > > > > > >=20
> > > > > > > IOW: I want the code to optimise for the case of standard NFS=
, not for
> > > > > > > the case of 'NFS with cachefs additions'.
> > > > > > >=20
> > > > > > I agree completely.  Are you seeing extra memory allocations
> > > > > > happen on mounts without 'fsc' or is it more a concern or how
> > > > > > some of the patches look?  We should not be calling any netfs o=
r
> > > > > > fscache code if 'fsc' is not on the mount and I don't see any i=
n my
> > > > > > testing. So either there's a misunderstanding here, or there's =
a
> > > > > > bug I'm missing.
> > > > > >=20
> > > > > > If fscache is not configured, then nfs_netfs_read_folio() and
> > > > > > nfs_netfs_readahead() is a wrapper that returns -ENOBUFS.
> > > > > > If it's configured but not enabled, then the checks for
> > > > > > netfs_inode(inode)->cache should skip over any netfs code.
> > > > > > But maybe there's a non-obvious bug you're seeing and
> > > > > > somehow netfs is still getting called?  Because I cannot
> > > > > > see netfs getting called if 'fsc' is not on the mount in my
> > > > > > tests.
> > > > > >=20
> > > > > > int nfs_netfs_read_folio(struct file *file, struct folio *folio=
)
> > > > > > {
> > > > > >       if (!netfs_inode(folio_inode(folio))->cache)
> > > > > >               return -ENOBUFS;
> > > > > >=20
> > > > > >       return netfs_read_folio(file, folio);
> > > > > > }
> > > > > >=20
> > > > > > int nfs_netfs_readahead(struct readahead_control *ractl)
> > > > > > {
> > > > > >       struct inode *inode =3D ractl->mapping->host;
> > > > > >=20
> > > > > >       if (!netfs_inode(inode)->cache)
> > > > > >               return -ENOBUFS;
> > > > > >=20
> > > > > >       netfs_readahead(ractl);
> > > > > >       return 0;
> > > > > > }
> > > > > >=20
> > > > > >=20
> > > > > > > >=20
> > > > > > > > Can you be more specific as to the portions of the patch yo=
u don't
> > > > > > > > like
> > > > > > > > so I can move it in the right direction?
> > > > > > > >=20
> > > > > > > > This is from patch #2 which you didn't comment on.  I'm not=
 sure
> > > > > > > > you're
> > > > > > > > ok with it though, since you mention "extra bloat to the in=
ode".
> > > > > > > > Do you object to this even though it's wrapped in an
> > > > > > > > #ifdef CONFIG_NFS_FSCACHE?  If so, do you require no
> > > > > > > > extra size be added to nfs_inode?
> > > > > > > >=20
> > > > > > > > @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > > > >       __u64 write_io;
> > > > > > > >       __u64 read_io;
> > > > > > > > #ifdef CONFIG_NFS_FSCACHE
> > > > > > > > -       struct fscache_cookie   *fscache;
> > > > > > > > -#endif
> > > > > > > > +       struct netfs_inode      netfs; /* netfs context and=
 VFS inode
> > > > > > > > */
> > > > > > > > +#else
> > > > > > > >       struct inode            vfs_inode;
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > >=20
> > > > > > > Ideally, I'd prefer no extra size. I can live with it up to a=
 certain
> > > > > > > point, however for now NFS is not unconditionally opting into=
 the netfs
> > > > > > > project. If we're to ever do that, then I want to see streaml=
ined code
> > > > > > > for the standard I/O case.
> > > > > > >=20
> > > > > > Ok and understood about standard I/O case.
> > > > > >=20
> > > > > > I was thinking how we might not increase the size, but I don't =
think
> > > > > > I can make it work.
> > > > > >=20
> > > > > > I thought we could change to something like the below, without =
an
> > > > > > embedded struct inode:
> > > > > >=20
> > > > > > @@ -204,9 +208,11 @@ struct nfs_inode {
> > > > > >       __u64 write_io;
> > > > > >       __u64 read_io;
> > > > > > #ifdef CONFIG_NFS_FSCACHE
> > > > > > -       struct fscache_cookie   *fscache;
> > > > > > -#endif
> > > > > > +       struct netfs_inode      *netfs; /* netfs context and VF=
S inode */
> > > > > > +#else
> > > > > >       struct inode            vfs_inode;
> > > > > > +#endif
> > > > > > +
> > > > > >=20
> > > > > > Then I would need to alloc/free a netfs_inode at the time of
> > > > > > nfs_inode initiation.  Unfortunately this has the issue that th=
e NFS_I()
> > > > > > macro cannot work, because it requires an embedded "struct inod=
e"
> > > > > > due to "container_of" use:
> > > > > >=20
> > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > +{
> > > > > > +       return &nfsi->netfs.inode;
> > > > > > +}
> > > > > > +static inline struct nfs_inode *NFS_I(const struct inode *inod=
e)
> > > > > > +{
> > > > > > +       return container_of(inode, struct nfs_inode, netfs.inod=
e);
> > > > > > +}
> > > > > > +#else
> > > > > > +static inline struct inode *VFS_I(struct nfs_inode *nfsi)
> > > > > > +{
> > > > > > +       return &nfsi->vfs_inode;
> > > > > > +}
> > > > > > static inline struct nfs_inode *NFS_I(const struct inode *inode=
)
> > > > > > {
> > > > > >       return container_of(inode, struct nfs_inode, vfs_inode);
> > > > > > }
> > > > > > +#endif
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Actually Trond maybe we can achieve a "0 length increase" of
> > > > > nfs_inode if dhowells would take a patch to modify the definition
> > > > > of struct netfs_inode and netfs_inode_init(), something like the =
WIP
> > > > > patch below.  What do you think?
> > > >=20
> > > > That works for me.
> > > >=20
> > > > >=20
> > > > > I think maybe this could be a follow-on patch and if you/dhowells
> > > > > think it's an ok idea I can try to work out what is needed across
> > > > > the tree.  I thought about it more and I kinda agree that in the
> > > > > case for NFS where fscache is "configured but not enabled",
> > > > > then even though we're only adding 24 bytes to the nfs_inode
> > > > > each time, it will add up so it is worth at least a discussion.
> > > > >=20
> > > > > diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> > > > > index f2402ddeafbf..195714f1c355 100644
> > > > > --- a/include/linux/netfs.h
> > > > > +++ b/include/linux/netfs.h
> > > > > @@ -118,11 +118,7 @@ enum netfs_io_source {
> > > > > typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transfe=
rred_or_error,
> > > > >                                     bool was_async);
> > > > >=20
> > > > > -/*
> > > > > - * Per-inode context.  This wraps the VFS inode.
> > > > > - */
> > > > > -struct netfs_inode {
> > > > > -       struct inode            inode;          /* The VFS inode =
*/
> > > > > +struct netfs_info {
> > > > >       const struct netfs_request_ops *ops;
> > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > >       struct fscache_cookie   *cache;
> > > > > @@ -130,6 +126,14 @@ struct netfs_inode {
> > > > >       loff_t                  remote_i_size;  /* Size of the remo=
te file */
> > > > > };
> > > > >=20
> > > > > +/*
> > > > > + * Per-inode context.  This wraps the VFS inode.
> > > > > + */
> > > > > +struct netfs_inode {
> > > > > +       struct inode            inode;          /* The VFS inode =
*/
> > > > > +       struct netfs_info       *netfs;         /* Rest of netfs =
data */
> > > > > +};
> > > > > +
> > > > > /*
> > > > > * Resources required to do operations on a cache.
> > > > > */
> > > > > @@ -312,10 +316,12 @@ static inline struct netfs_inode
> > > > > *netfs_inode(struct inode *inode)
> > > > > static inline void netfs_inode_init(struct netfs_inode *ctx,
> > > > >                                   const struct netfs_request_ops =
*ops)
> > > > > {
> > > > > -       ctx->ops =3D ops;
> > > > > -       ctx->remote_i_size =3D i_size_read(&ctx->inode);
> > > > > +       ctx->netfs =3D kzalloc(sizeof(struct netfs_info)), GFP_KE=
RNEL);
> > > > > +       /* FIXME: Check for NULL */
> > > > > +       ctx->netfs->ops =3D ops;
> > > > > +       ctx->netfs->remote_i_size =3D i_size_read(&ctx->inode);
> > > > > #if IS_ENABLED(CONFIG_FSCACHE)
> > > > > -       ctx->cache =3D NULL;
> > > > > +       ctx->netfs->cache =3D NULL;
> > > > > #endif
> > > > > }
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Are you ok with the stub functions which are placed in fsca=
che.h, and
> > > > > > > > when CONFIG_NFS_FSCACHE is not set, become either a no-op
> > > > > > > > or a 1-liner (nfs_netfs_readpage_release)?
> > > > > > > >=20
> > > > > > > > #else /* CONFIG_NFS_FSCACHE */
> > > > > > > > +static inline void nfs_netfs_inode_init(struct nfs_inode *=
nfsi) {}
> > > > > > > > +static inline void nfs_netfs_initiate_read(struct nfs_pgio=
_header
> > > > > > > > *hdr) {}
> > > > > > > > +static inline void nfs_netfs_read_completion(struct nfs_pg=
io_header
> > > > > > > > *hdr) {}
> > > > > > > > +static inline void nfs_netfs_readpage_release(struct nfs_p=
age *req)
> > > > > > > > +{
> > > > > > > > +       unlock_page(req->wb_page);
> > > > > > > > +}
> > > > > > > > static inline void nfs_fscache_release_super_cookie(struct
> > > > > > > > super_block *sb) {}
> > > > > > > > static inline void nfs_fscache_init_inode(struct inode *ino=
de) {}
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Do you object to the below?  If so, then do you want
> > > > > > > > #ifdef CONFIG_NFS_FSCACHE here?
> > > > > > > >=20
> > > > > > > > -- a/fs/nfs/inode.c
> > > > > > > > +++ b/fs/nfs/inode.c
> > > > > > > > @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struct
> > > > > > > > super_block *sb)
> > > > > > > > #ifdef CONFIG_NFS_V4_2
> > > > > > > >       nfsi->xattr_cache =3D NULL;
> > > > > > > > #endif
> > > > > > > > +       nfs_netfs_inode_init(nfsi);
> > > > > > > > +
> > > > > > > >       return VFS_I(nfsi);
> > > > > > > > }
> > > > > > > > EXPORT_SYMBOL_GPL(nfs_alloc_i
> > > > > > > > node);
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Do you object to the changes in fs/nfs/read.c?  Specificall=
y,
> > > > > > > > how about the below calls to netfs from nfs_read_folio and
> > > > > > > > nfs_readahead into equivalent netfs calls?  So when
> > > > > > > > NFS_CONFIG_FSCACHE is set, but fscache is not enabled
> > > > > > > > ('fsc' not on mount), these netfs functions do immediately =
call
> > > > > > > > netfs_alloc_request().  But I wonder if we could simply add=
 a
> > > > > > > > check to see if fscache is enabled on the mount, and skip
> > > > > > > > over to satisfy what you want.  Am I understanding what you
> > > > > > > > want?
> > > > > > >=20
> > > > > > > Quite frankly, I'd prefer that we just split out the function=
ality that
> > > > > > > is needed from the netfs code so that it can be optimised. Ho=
wever I'm
> > > > > > > not interested enough in the cachefs functionality to work on=
 that
> > > > > > > myself. ...and as I indicated above, I might be OK with optin=
g into the
> > > > > > > netfs project, once the overhead can be made to disappear.
> > > > > > >=20
> > > > > > Understood.
> > > > > >=20
> > > > > > If you think it makes more sense, I can move some of the nfs_ne=
tfs_*
> > > > > > functions into a netfs.c file as a starting point.  Or that can=
 maybe
> > > > > > be done in a future patchset?
> > > > > >=20
> > > > > > For now I was equating netfs and fscache together so we can
> > > > > > move on from the much older and single-page limiting fscache
> > > > > > interface that is likely to go away soon.
> > > > > >=20
> > > > > > > >=20
> > > > > > > > @@ -355,6 +343,10 @@ int nfs_read_folio(struct file *file, =
struct
> > > > > > > > folio *folio)
> > > > > > > >       if (NFS_STALE(inode))
> > > > > > > >               goto out_unlock;
> > > > > > > >=20
> > > > > > > > +       ret =3D nfs_netfs_read_folio(file, folio);
> > > > > > > > +       if (!ret)
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > >=20
> > > > > > > > @@ -405,6 +399,10 @@ void nfs_readahead(struct readahead_co=
ntrol
> > > > > > > > *ractl)
> > > > > > > >       if (NFS_STALE(inode))
> > > > > > > >               goto out;
> > > > > > > >=20
> > > > > > > > +       ret =3D nfs_netfs_readahead(ractl);
> > > > > > > > +       if (!ret)
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > >=20
> > > > > > The above wrappers should prevent any additional overhead when =
fscache
> > > > > > is not enabled.  As far as I know these work to avoid calling n=
etfs
> > > > > > when 'fsc' is not on the mount.
> > > > > >=20
> > > > > > > >=20
> > > > > > > > And how about these calls from different points in the read
> > > > > > > > path to the earlier mentioned stub functions?
> > > > > > > >=20
> > > > > > > > @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_re=
ad_mds);
> > > > > > > >=20
> > > > > > > > static void nfs_readpage_release(struct nfs_page *req, int =
error)
> > > > > > > > {
> > > > > > > > -       struct inode *inode =3D d_inode(nfs_req_openctx(req=
)->dentry);
> > > > > > > >       struct page *page =3D req->wb_page;
> > > > > > > >=20
> > > > > > > > -       dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode=
->i_sb-
> > > > > > > > > s_id,
> > > > > > > > -               (unsigned long long)NFS_FILEID(inode), req-=
>wb_bytes,
> > > > > > > > -               (long long)req_offset(req));
> > > > > > > > -
> > > > > > > >       if (nfs_error_is_fatal_on_server(error) && error !=3D=
 -
> > > > > > > > ETIMEDOUT)
> > > > > > > >               SetPageError(page);
> > > > > > > > -       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))=
 {
> > > > > > > > -               if (PageUptodate(page))
> > > > > > > > -                       nfs_fscache_write_page(inode, page)=
;
> > > > > > > > -               unlock_page(page);
> > > > > > > > -       }
> > > > > > > > +       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > > > > > > +               nfs_netfs_readpage_release(req);
> > > > > > > > +
> > > > > > >=20
> > > > > > > I'm not seeing the value of wrapping unlock_page(), no... Tha=
t code is
> > > > > > > going to need to change when we move it to use folios nativel=
y anyway.
> > > > > > >=20
> > > > > > Ok, how about I make it conditional on whether fscache is confi=
gured
> > > > > > and enabled then, similar to the nfs_netfs_read_folio() and
> > > > > > nfs_netfs_readahead()?  Below is what that would look like.
> > > > > > I could inline the code in nfs_netfs_readpage_release() if you
> > > > > > think it would be clearer.
> > > > > >=20
> > > > > > static void nfs_readpage_release(struct nfs_page *req, int erro=
r)
> > > > > > {
> > > > > >       struct page *page =3D req->wb_page;
> > > > > >=20
> > > > > >       if (nfs_error_is_fatal_on_server(error) && error !=3D -ET=
IMEDOUT)
> > > > > >               SetPageError(page);
> > > > > >       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> > > > > > #ifndef CONFIG_NFS_FSCACHE
> > > > > >               unlock_page(req->wb_page);
> > > > > > #else
> > > > > >               nfs_netfs_readpage_release(req);
> > > > > > #endif
> > > > > >       nfs_release_request(req);
> > > > > > }
> > > > > >=20
> > > > > >=20
> > > > > > void nfs_netfs_readpage_release(struct nfs_page *req)
> > > > > > {
> > > > > >   struct inode *inode =3D d_inode(nfs_req_openctx(req)->dentry)=
;
> > > > > >=20
> > > > > >   /*
> > > > > >    * If fscache is enabled, netfs will unlock pages.
> > > > > >    */
> > > > > >   if (netfs_inode(inode)->cache)
> > > > > >       return;
> > > > > >=20
> > > > > >   unlock_page(req->wb_page);
> > > > > > }
> > > > > >=20
> > > > > >=20
> > > > > > > >       nfs_release_request(req);
> > > > > > > > }
> > > > > > > >=20
> > > > > > > > @@ -177,6 +170,8 @@ static void nfs_read_completion(struct
> > > > > > > > nfs_pgio_header *hdr)
> > > > > > > >               nfs_list_remove_request(req);
> > > > > > > >               nfs_readpage_release(req, error);
> > > > > > > >       }
> > > > > > > > +       nfs_netfs_read_completion(hdr);
> > > > > > > > +
> > > > > > > > out:
> > > > > > > >       hdr->release(hdr);
> > > > > > > > }
> > > > > > > > @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct
> > > > > > > > nfs_pgio_header *hdr,
> > > > > > > >                             struct rpc_task_setup *task_set=
up_data,
> > > > > > > > int how)
> > > > > > > > {
> > > > > > > >       rpc_ops->read_setup(hdr, msg);
> > > > > > > > +       nfs_netfs_initiate_read(hdr);
> > > > > > > >       trace_nfs_initiate_read(hdr);
> > > > > > > > }
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Are you ok with these additions?  Something like this would
> > > > > > > > be required in the case of fscache configured and enabled,
> > > > > > > > because we could have some of the data in a read in
> > > > > > > > fscache, and some not.  That is the reason for the netfs
> > > > > > > > design, and why we need to be able to call the normal
> > > > > > > > NFS read IO path (netfs calls into issue_read, and we call
> > > > > > > > back via netfs_subreq_terminated)?
> > > > > > > >=20
> > > > > > > > @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
> > > > > > > >       struct pnfs_layout_segment *pg_lseg;
> > > > > > > >       struct nfs_io_completion *pg_io_completion;
> > > > > > > >       struct nfs_direct_req   *pg_dreq;
> > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > +       void                    *pg_netfs;
> > > > > > > > +#endif
> > > > > > > >=20
> > > > > > > > @@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
> > > > > > > >       const struct nfs_rw_ops *rw_ops;
> > > > > > > >       struct nfs_io_completion *io_completion;
> > > > > > > >       struct nfs_direct_req   *dreq;
> > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > +       void                    *netfs;
> > > > > > > > +#endif
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > And these additions to pagelist.c?
> > > > > > > >=20
> > > > > > > > @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct
> > > > > > > > nfs_pageio_descriptor *desc,
> > > > > > > >       hdr->good_bytes =3D mirror->pg_count;
> > > > > > > >       hdr->io_completion =3D desc->pg_io_completion;
> > > > > > > >       hdr->dreq =3D desc->pg_dreq;
> > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > +       if (desc->pg_netfs)
> > > > > > > > +               hdr->netfs =3D desc->pg_netfs;
> > > > > > > > +#endif
> > > > > > >=20
> > > > > > > Why the conditional?
> > > > > > >=20
> > > > > > Not really needed and I was thinking of removing it, so I'll do=
 that.
> > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pageio_=
descriptor
> > > > > > > > *desc,
> > > > > > > >       desc->pg_lseg =3D NULL;
> > > > > > > >       desc->pg_io_completion =3D NULL;
> > > > > > > >       desc->pg_dreq =3D NULL;
> > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > +       desc->pg_netfs =3D NULL;
> > > > > > > > +#endif
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct
> > > > > > > > nfs_pageio_descriptor *desc,
> > > > > > > >=20
> > > > > > > >       desc->pg_io_completion =3D hdr->io_completion;
> > > > > > > >       desc->pg_dreq =3D hdr->dreq;
> > > > > > > > +#ifdef CONFIG_NFS_FSCACHE
> > > > > > > > +       desc->pg_netfs =3D hdr->netfs;
> > > > > > > > +#endif
> > > > > > >=20
> > > > > > > Those all need wrapper functions instead of embedding #ifdefs=
.
> > > > > > >=20
> > > > > > Ok.
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > My expectation is that the standard I/O path should have =
minimal
> > > > > > > > > overhead, and should certainly not increase the overhead =
that we
> > > > > > > > > already have. Will this be addressed in future iterations=
 of these
> > > > > > > > > patches?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I will do what I can to satisfy what you want, either by fi=
xing up
> > > > > > > > this patch or follow-on patches.  Hopefully the above quest=
ions
> > > > > > > > will clarify the next steps.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > --
> > > > > > > Trond Myklebust
> > > > > > > Linux NFS client maintainer, Hammerspace
> > > > > > > trond.myklebust@hammerspace.com
> > > >=20
> > > >=20
> > > >=20
> > > > Trond Myklebust
> > > > CTO, Hammerspace Inc
> > > > 1900 S Norfolk St, Suite 350 - #45
> > > > San Mateo, CA 94403
> > > >=20
> > > > www.hammer.space
> > > >=20
> > > >=20
> > >=20
> >=20

--=20
Jeff Layton <jlayton@poochiereds.net>
