Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A47637E2
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjGZNo1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjGZNoZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 09:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34926AC
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690379008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vgu13nEy44fnYsza5CLtItP7F9KLHENaJWfQp22OtOA=;
        b=JQS2bI9yDRm64+j7AiGf3OxS7DlOyaTC5eW5r2iTTMa4djUWR5QR90TB4ENW/nToRDNTWe
        qYFoCOvmue3WC+wBk87varrTAhW5Ha3xDddM3ay7om9oKKyW9deaLqgUbVtRJjU3bD4Pt9
        vqRcAdY9kdmY22tu0gT4deHw90LhFsc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-kYISSdN4Oj2ivR92Fy6-bg-1; Wed, 26 Jul 2023 09:43:24 -0400
X-MC-Unique: kYISSdN4Oj2ivR92Fy6-bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE8188D707;
        Wed, 26 Jul 2023 13:43:24 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.8.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4779BC2C7D3;
        Wed, 26 Jul 2023 13:43:24 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
        id AD0EF63E7F; Wed, 26 Jul 2023 09:43:23 -0400 (EDT)
Date:   Wed, 26 Jul 2023 09:43:23 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Message-ID: <ZMEi+/3cmz3Vl7lq@aion>
References: <20230725150807.8770-1-smayhew@redhat.com>
 <20230725150807.8770-2-smayhew@redhat.com>
 <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
 <ZL/3MZDNGqwlOgPW@aion>
 <1a2ee0602cd169a96db29565449e2e6cc7a31912.camel@hammerspace.com>
 <7b8e81b3ab44b5bc788a024dec6465adcc01d7a3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b8e81b3ab44b5bc788a024dec6465adcc01d7a3.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jul 2023, Jeff Layton wrote:

> On Tue, 2023-07-25 at 17:41 +0000, Trond Myklebust wrote:
> > On Tue, 2023-07-25 at 12:24 -0400, Scott Mayhew wrote:
> > > On Tue, 25 Jul 2023, Trond Myklebust wrote:
> > >=20
> > > > On Tue, 2023-07-25 at 11:08 -0400, Scott Mayhew wrote:
> > > > > Once a folio's private data has been cleared, it's possible for
> > > > > another
> > > > > process to clear the folio->mapping (e.g. via
> > > > > invalidate_complete_folio2
> > > > > or evict_mapping_folio), so it wouldn't be safe to call
> > > > > nfs_page_to_inode() after that.
> > > > >=20
> > > > > Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use
> > > > > folios")
> > > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > > ---
> > > > > =A0fs/nfs/write.c | 4 +++-
> > > > > =A01 file changed, 3 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > > index f4cca8f00c0c..489c3f9dae23 100644
> > > > > --- a/fs/nfs/write.c
> > > > > +++ b/fs/nfs/write.c
> > > > > @@ -785,6 +785,8 @@ static void nfs_inode_add_request(struct
> > > > > nfs_page
> > > > > *req)
> > > > > =A0 */
> > > > > =A0static void nfs_inode_remove_request(struct nfs_page *req)
> > > > > =A0{
> > > > > +=A0=A0=A0=A0=A0=A0=A0struct nfs_inode *nfsi =3D NFS_I(nfs_page_t=
o_inode(req));
> > > > > +
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0if (nfs_page_group_sync_on_bit(req, PG_RE=
MOVE)) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct folio *fol=
io =3D nfs_page_to_folio(req-
> > > > > > wb_head);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct address_sp=
ace *mapping =3D
> > > > > folio_file_mapping(folio);
> > > > > @@ -800,7 +802,7 @@ static void nfs_inode_remove_request(struct
> > > > > nfs_page *req)
> > > > > =A0
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0if (test_and_clear_bit(PG_INODE_REF, &req=
->wb_flags)) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs_release_reque=
st(req);
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&NF=
S_I(nfs_page_to_inode(req))-
> > > > > > nrequests);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&nf=
si->nrequests);
> > > >=20
> > > > Why not just invert the order of the atomic_long_dec() and the
> > > > nfs_release_request()? That way you are also ensuring that the
> > > > inode is
> > > > still pinned in memory by the open context.
> > >=20
> > > I'm not following.=A0 How does inverting the order prevent the
> > > folio->mapping from getting clobbered?
> > >=20
> >=20
> > The open/lock context is refcounted by the nfs_page until the latter is
> > released. That's why the inode is guaranteed to remain around at least
> > until the  call to nfs_release_request().
> >=20
>=20
> The problem is not that the inode is going away, but rather that we
> can't guarantee that the page is still part of the mapping at this
> point, and so we can't safely dereference page->mapping there. I do see
> that nfs_release_request releases a reference to the page, but I don't
> think that's sufficient to ensure that it remains part of the mapping.
>=20
> AFAICT, once we clear page->private, the page is subject to be removed
> from the mapping. So, I *think* it's safe to just move the call to
> nfs_page_to_inode prior to the call to nfs_page_group_sync_on_bit.

Yeah, the inode hasn't gone away.  I can pick the nfs_commit_data
address off the stack in nfs_commit_release_pages:

crash> nfs_commit_data.inode c0000006774cae00
  inode =3D 0xc00000006c1b05f8,
=20
The nfs_inode is still allocated:

crash> kmem 0xc00000006c1b05f8
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
c000000030332600     1088        128      5959    101    64k  nfs_inode_cac=
he
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  c00c0000001b06c0  c00000006c1b0000     0     59          1    58
  FREE / [ALLOCATED]
  [c00000006c1b0448]

      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
c00c0000001b06c0  6c1b0000 c000000030332600 c00000006c1b4480  1 23ffff80000=
0200 slab

The vfs_inode:

crash> px &((struct nfs_inode *)0xc00000006c1b0448)->vfs_inode
$7 =3D (struct inode *) 0xc00000006c1b05f8

Matches the inodes open by both nfs_flock programs from the test:

crash> foreach nfs_flock files
PID: 4006780  TASK: c00000009d436600  CPU: 43   COMMAND: "nfs_flock"
ROOT: /    CWD: /tmp/ltp-aFr4AJt3R9/LTP_nfslock01.9hyHNgoKqq/3/0/
 FD       FILE            DENTRY           INODE       TYPE PATH
  0 c000000196e9a000 c000000004090840 c00000000ae13bf0 CHR  /dev/null
  1 c0000000bfd1ff00 c0000000963e0e40 c00000006c573900 REG  /opt/ltp/output=
/nfslock01.sh_20230610112802
  2 c0000000bfd1ff00 c0000000963e0e40 c00000006c573900 REG  /opt/ltp/output=
/nfslock01.sh_20230610112802
  3 c000000196e97700 c000000419ccb040 c00000006c1b05f8 REG  /tmp/ltp-aFr4AJ=
t3R9/LTP_nfslock01.9hyHNgoKqq/3/0/flock_idata
                                      ^^^^^^^^^^^^^^^^

PID: 4006781  TASK: c00000009d42d500  CPU: 42   COMMAND: "nfs_flock"
ROOT: /    CWD: /tmp/ltp-aFr4AJt3R9/LTP_nfslock01.9hyHNgoKqq/3/0/
 FD       FILE            DENTRY           INODE       TYPE PATH
  0 c0000000f0812200 c000000004090840 c00000000ae13bf0 CHR  /dev/null
  1 c0000000bfd1ff00 c0000000963e0e40 c00000006c573900 REG  /opt/ltp/output=
/nfslock01.sh_20230610112802
  2 c0000000bfd1ff00 c0000000963e0e40 c00000006c573900 REG  /opt/ltp/output=
/nfslock01.sh_20230610112802
  3 c0000000f0813c00 c000000419ccb040 c00000006c1b05f8 REG  /tmp/ltp-aFr4AJ=
t3R9/LTP_nfslock01.9hyHNgoKqq/3/0/flock_idata
                                      ^^^^^^^^^^^^^^^^

The file->f_mapping for both struct files matches the inode->i_data:

crash> file.f_mapping c000000196e97700
  f_mapping =3D 0xc00000006c1b0770,
crash> file.f_mapping c0000000f0813c00
  f_mapping =3D 0xc00000006c1b0770,
crash> px &((struct inode *)0xc00000006c1b05f8)->i_data
$8 =3D (struct address_space *) 0xc00000006c1b0770

and if I look at one of those nfs_flock tasks, the folio
passed in to nfs_read_folio has the same mapping:

crash> bt 4006781
PID: 4006781  TASK: c00000009d42d500  CPU: 42   COMMAND: "nfs_flock"
 #0 [c000000177053710] __schedule at c000000000f61d9c
 #1 [c0000001770537d0] schedule at c000000000f621f4
 #2 [c000000177053840] io_schedule at c000000000f62354
 #3 [c000000177053870] folio_wait_bit_common at c00000000042dc60
 #4 [c000000177053970] nfs_read_folio at c0080000050108a8 [nfs]
 #5 [c000000177053a60] nfs_write_begin at c008000004fff06c [nfs]
 #6 [c000000177053b10] generic_perform_write at c00000000042b044
 #7 [c000000177053bc0] nfs_file_write at c008000004ffda08 [nfs]
 #8 [c000000177053c60] new_sync_write at c00000000057fdd8
 #9 [c000000177053d10] vfs_write at c000000000582fd4
#10 [c000000177053d60] ksys_write at c0000000005833a4
#11 [c000000177053db0] system_call_exception at c00000000002f434
#12 [c000000177053e10] system_call_vectored_common at c00000000000bfe8

crash> folio.mapping c00c000000564400
      mapping =3D 0xc00000006c1b0770,

It's just that if we go back to the nfs_page being released by our panic
task, the folio->mapping has been cleared, so we panic when we try to go
folio->mapping->host.

crash> nfs_page c00000016fb2a600
struct nfs_page {
  wb_list =3D {
    next =3D 0xc00000016fb2a600,
    prev =3D 0xc00000016fb2a600
  },
  {
    wb_page =3D 0xc00c000001d49580,
    wb_folio =3D 0xc00c000001d49580
  },
  wb_lock_context =3D 0xc00000010518b2c0,
  wb_index =3D 0x1,
  wb_offset =3D 0x6940,
  wb_pgbase =3D 0x6940,
  wb_bytes =3D 0x40,
  wb_kref =3D {
    refcount =3D {
      refs =3D {
        counter =3D 0x1
      }
    }
  },
  wb_flags =3D 0x5,
  wb_verf =3D {
    data =3D "\214\205_d\214\210W\036"
  },
  wb_this_page =3D 0xc00000016fb2a600,
  wb_head =3D 0xc00000016fb2a600,
  wb_nio =3D 0x0
}
crash> folio.mapping 0xc00c000001d49580
      mapping =3D 0x0,

-Scott

> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

