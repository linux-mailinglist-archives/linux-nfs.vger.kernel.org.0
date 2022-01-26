Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC949D4AA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 22:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiAZVm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 16:42:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39174 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiAZVm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 16:42:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8054218E8;
        Wed, 26 Jan 2022 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643233375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8D3/iSgudTfOpodQ4uNAeH04etbukj0qfZT65VmtRY=;
        b=O77jZ50FJkC7iNzTXGMDV2hNmUTIPLrSyjOFTujn+j9nacM71F+7k27HTvyaeMEKkwzru+
        2Mbd4AF5ug1FWf9/Vx/2VBe49pXR9L+CVG86KHUcw7kIEUsfCudpe5UgY4o/DinWN4/tZb
        pYsAHN+VjSqUL6htxeDYd5g9NSlfX9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643233375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8D3/iSgudTfOpodQ4uNAeH04etbukj0qfZT65VmtRY=;
        b=dqNYRcFwnQNpOkMjkxCrgrcqfv6bp+DnkNy/sKad0ob00MRP4UtF3/ApM09Uktzou9AKH2
        URcoL9hBtUB7e6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0089B13E3C;
        Wed, 26 Jan 2022 21:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hRo/LFzA8WFDQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Jan 2022 21:42:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "mgorman@suse.de" <mgorman@suse.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/23] NFS: swap-out must always use STABLE writes.
In-reply-to: <e50bf6286a89d60ee0879e55a30b15d84e97d9a4.camel@hammerspace.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611287.26253.13462969110743208198.stgit@noble.brown>,
 <e50bf6286a89d60ee0879e55a30b15d84e97d9a4.camel@hammerspace.com>
Date:   Thu, 27 Jan 2022 08:42:49 +1100
Message-id: <164323336953.5493.18342144609889647048@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, Trond Myklebust wrote:
> On Mon, 2022-01-24 at 14:48 +1100, NeilBrown wrote:
> > The commit handling code is not safe against memory-pressure
> > deadlocks
> > when writing to swap.=C2=A0 In particular, nfs_commitdata_alloc() blocks
> > indefinitely waiting for memory, and this can consume all available
> > workqueue threads.
> >=20
> > swap-out most likely uses STABLE writes anyway as COND_STABLE
> > indicates
> > that a stable write should be used if the write fits in a single
> > request, and it normally does.=C2=A0 However if we ever swap with a small
> > wsize, or gather unusually large numbers of pages for a single write,
> > this might change.
> >=20
> > For safety, make it explicit in the code that direct writes used for
> > swap
> > must always use FLUSH_COND_STABLE.
>=20
> OK. Your explanation above has me extremely confused.
>=20
> If you want to avoid commit, then you should be using FLUSH_STABLE,
> since that forces the writes to be synchronous. FLUSH_COND_STABLE can
> and will use unstable writes if it sees that there are more writes to
> come.
>=20
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0fs/nfs/direct.c |=C2=A0=C2=A0=C2=A0 7 ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> > index 43a956d7fd62..29c007b2a17a 100644
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c
> > @@ -791,7 +791,7 @@ static const struct nfs_pgio_completion_ops
> > nfs_direct_write_completion_ops =3D {
> > =C2=A0 */
> > =C2=A0static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req
> > *dreq,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iov_iter *iter,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t pos)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t pos, int
> > ioflags)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_pageio_descrip=
tor desc;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode =3D d=
req->inode;
> > @@ -799,7 +799,7 @@ static ssize_t
> > nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t requested_bytes =
=3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t wsize =3D max_t(si=
ze_t, NFS_SERVER(inode)->wsize,
> > PAGE_SIZE);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_pageio_init_write(&desc, i=
node, FLUSH_COND_STABLE, false,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_pageio_init_write(&desc, i=
node, ioflags, false,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nfs_direct_write_completion_ops);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc.pg_dreq =3D dreq;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0get_dreq(dreq);
> > @@ -905,6 +905,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb,
> > struct iov_iter *iter,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_direct_req *dr=
eq;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_lock_context *=
l_ctx;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loff_t pos, end;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ioflags =3D swap ? FLUSH_C=
OND_STABLE : FLUSH_STABLE;
>=20
> This is an unacceptable change in behaviour for the non-swap case, so
> NACK.
>=20

Hi Trond,
 thanks for the review.
 You are right - I had that test exactly backwards.  I've fixed for the
 next version.

Thanks,
NeilBrown
