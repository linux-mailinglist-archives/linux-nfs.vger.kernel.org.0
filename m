Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C636286BA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiKNRLo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 12:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbiKNRLn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 12:11:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B9831DFD
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 09:11:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89404612F3
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 17:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0093EC433D7;
        Mon, 14 Nov 2022 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668445900;
        bh=Y8dYOt06femJalrdoe4uObPXHvyv8cENiy9ZImwvhi8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Dsy8dzPdXSeFrnDBaVfWhJ0pKZrdnS1BtijEe6+NFL317edb2afvfbpiif5qcpi8S
         sesXx0zSq+hyy2wnsa9QeYmoMYXecGVrvracIIipzHCR0TKZuqIn/JV6z9VloCizmi
         5aS2I4jMJ6py9hVrVo9sqxSCp0Y4B6kx41a1xfK6Y3/QZsHZjVKhTqTAm2oxTjP/y0
         FnCVhw3FN2nys5jYvCMFDyID7XaIurTMisqzin6BOoI6qRDtHmiQEC81A8A1MdQaIZ
         HwwdKg+vCsBYYLZgRSSC/bhSLRaXv6DglBjcKmFXcTY6ZUDLEJrpuQUuKRa6g1umwZ
         tnwIb8kXL40IA==
Message-ID: <8123f88e938ba7b186a23f65ee58c61c0af00a2f.camel@kernel.org>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
From:   Jeff Layton <jlayton@kernel.org>
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
Date:   Mon, 14 Nov 2022 12:11:37 -0500
In-Reply-To: <CA+QRt4s4+pF+C3Bk-wgoPjGNZwDbBGFPAQ=-Fbrgt6ejrfqsTA@mail.gmail.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
         <20221017105212.77588-4-dwysocha@redhat.com>
         <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
         <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
         <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
         <CALF+zOnRH_GiZooiNm1=J+gOpLMEncO72SA4jAmL+agG9RjbYg@mail.gmail.com>
         <CALF+zOmDzp-UhLC0Dk4fmsjEzWgM75m5uOMBjv6TjTFYtbWPAQ@mail.gmail.com>
         <1B2E1442-EB0A-43E3-96BB-15C717E966E5@hammerspace.com>
         <CA+QRt4vM3NncgCWjKncorHmiWpCrJ7FsLC=y+v7gnEwYpM3PSw@mail.gmail.com>
         <CALF+zOk3Q_UO9KG3Lxm-22e=nC338DGLndbHAfk1wkPaADOvkg@mail.gmail.com>
         <CA+QRt4s4+pF+C3Bk-wgoPjGNZwDbBGFPAQ=-Fbrgt6ejrfqsTA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-14 at 16:03 +0000, Benjamin Maynard wrote:
> Hi Dave,
>=20
> I've added responses to your questions inline below.
>=20
> I also tried adding the noatime option to the mount on the source
> filer as Jeff suggested, but this has not made any difference and the
> issue is still persisting for me.
>=20

My mistake. I didn't realize you were using v3 exclusively. The change
attr doesn't exist there, so this shouldn't be a factor.

> I created the following diagram that explains my setup, and the exact
> tests I am performing:
> https://drive.google.com/file/d/12Xf-9yHCKM4eMr2YGqdSAVfGcximW4OG/view?us=
p=3Dsharing.
>=20
> Hopefully this is clearer than my explanations below (let me know if
> you'd prefer me to share an alternative way).
>=20
> In order to remove the re-exporting layer of complexity, I also
> performed the tests without the re-export server (architecture:
> https://drive.google.com/file/d/1DQKhqo_UnQ8ul-z5Iram5LpisDmkKziQ/view?us=
p=3Dshare_link):
>=20
> Source NFS Server <-- Client (with FS-Cache)
>=20
> The same is happening, I cannot get FS-Cache to serve from cache.
> Heavy writes, but no reads, even when the same file is copied many
> times.
>=20
> Hopefully something I am doing wrong on my end, but I can't figure out wh=
at.
>=20
>=20

I don't think you're doing anything wrong. We'll probably need to dig
into why netfs/fscache decided to go to the server instead of using the
cache.

It might be interesting to turn up the cachefiles_prep_read tracepoint
during this and see why it's not opting to read from cache. David and
David may have other tracepoints they recommend turning on too.

>=20
> On Mon, 14 Nov 2022 at 13:47, David Wysochanski <dwysocha@redhat.com> wro=
te:
> >=20
> > I apologize I did not read carefully enough and I missed some details
> > in your original post.
> > More below.
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
> > If you delete the file from the NFS client, how does that not delete th=
e
> > file from the original NFS server?
>=20
> Sorry - to be clear, I never deleted the file from the NFS mount
> (which I know would in turn delete it from the re-export server and
> the source filer).
>=20
> In order to perform the performance test, I copied the file from the
> NFS mount on the NFS Client, to a local directory (cp
> /mnt/nfs/500gb.img /tmp).
>=20
> When I said "I then deleted that file from the NFS Client", I meant I
> deleted the local copy of that file. Not the file on the mount (rm
> /tmp/500gb.img).
>=20
> Just to also stress, I have never dropped the caches on the Re-Export
> Server (the one with FS-Cache) at any point in any of these tests, so
> I don't think this is the problem. I have only ever dropped the caches
> on the NFS client that is mounting the Re-Export Server.
>=20
> > > I then performed another copy of the 500Gb file on the NFS Client,
> > > again via the Re-Export Server. What I expected would happen is that =
I
> > > would see heavy reads from the /var/cache/fscache volume as the file
> > > should be served from FS-Cache.
> > >=20
> > I don't understand this.  When you say you "performed another copy"
> > of what file?  Wasn't the file deleted in the above step?
>=20
> As above, only the local copy was deleted.
>=20
> > > However what I actually saw was no reads whatsoever, FS-Cache seems t=
o
> > > be ignored and the file is pulled from the Source NFS Filer again. I
> > > also see heavy writes to /var/cache/fscache, so it appears that
> > > FS-Cache is overwriting its existing cache, and never using it.
> >=20
> > That would happen if the file was changed or re-created.
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
> >=20
> > This points at something more fundamental like something missed
> > in the test or maybe a mount option.  Can you explain what test
> > you're doing here when you say "this behavior is not unique"?
>=20
> I've created the following diagram which explains the test I am
> performing. I think it is a little easier to follow than explaining in
> text. This should be viewable without any authentication:
> https://drive.google.com/file/d/12Xf-9yHCKM4eMr2YGqdSAVfGcximW4OG/view?us=
p=3Dsharing.
>=20
> By "this behaviour is not unique to the re-export use case" I mean
> that the same happens if I remove the re-export server completely, and
> just have the following setup:
>=20
> Source NFS Server <-- Client (with FS-Cache).
>=20
> > Can you show the mount options for both:
> > - fscache filesystem on the re-export server (/var/cache/fscache)
>=20
> root@reexport:~$ mount | grep /var/cache/fscache
> /dev/md127 on /var/cache/fscache type ext4
> (rw,relatime,discard,nobarrier,stripe=3D1024)
>=20
> > - exported filesystem on the NFS server (filesystem in /etc/exports)
>=20
> I have tried both:
>=20
> root@source:~$ mount | grep files
> /dev/sdb1 on /files type ext4 (rw)
>=20
> root@source:~$ cat /etc/exports
> /files 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_=
check,sec=3Dsys,secure,nohide)
>=20
> and (at Jeff's suggestion):
>=20
> root@source:~$ mount | grep files
> /dev/sdb1 on /files type ext4 (rw,noatime)
>=20
> root@source:~$ cat /etc/exports
> /files 10.0.0.0/8(rw,sync,wdelay,no_root_squash,no_all_squash,no_subtree_=
check,sec=3Dsys,secure,nohide)
>=20
>=20
> > Unfortunately the problem with drop_caches makes it more difficult
> > to know when fscache is truly working.  But some other unit test
> > I have shows fscache does work with this patchset so I'm puzzled why
> > you're not seeing it work at all.
> >=20
> > I pinged dhowells on the drop_caches issue so maybe we can get
> > that one sorted out soon but I'm not sure since it's part of a series
> > and proposes changes in mm.
>=20
> Just to be clear, I have never used drop_caches on the re-export
> server in any of these tests. I have only ever done this on the NFS
> Client.
>=20
> >=20
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
Jeff Layton <jlayton@kernel.org>
