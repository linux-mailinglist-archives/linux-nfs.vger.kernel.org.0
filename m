Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F115B4436FB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 21:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBUOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 16:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbhKBUOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 16:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635883885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMAM7WDordbN+0T5nufZPCivA9NoTZWTAZlUQRCBfEM=;
        b=FbH/zFQKMVboyXZTQM9tNazcMxyEWhpSRmdnzH0hr1Adyb+x37wbdt/lG6q4TPV2ZlcUNr
        tl9Ys6kPol+u+7Kjv+0gkUaPuuQeprX3CF+594LsJgweEQsDCpV+oqGziMzpIkwtGvIwgp
        GYLLrnQ55dOezLM3q/qdvu88i5MNOco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-d_DgYXMFOomVTgeiTQUsRA-1; Tue, 02 Nov 2021 16:11:22 -0400
X-MC-Unique: d_DgYXMFOomVTgeiTQUsRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D9AC100CCC1;
        Tue,  2 Nov 2021 20:11:21 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.9.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA8A5C232;
        Tue,  2 Nov 2021 20:11:21 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 9E3B11A0024; Tue,  2 Nov 2021 16:11:20 -0400 (EDT)
Date:   Tue, 2 Nov 2021 16:11:20 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfs4: take a reference on the nfs_client when
 running FREE_STATEID
Message-ID: <YYGbaPX3DbQf7FXi@aion.usersys.redhat.com>
References: <20211101200623.2635785-1-smayhew@redhat.com>
 <20211101200623.2635785-2-smayhew@redhat.com>
 <9c677842d46b95e1ac7011afd44e29229d9efaa9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9c677842d46b95e1ac7011afd44e29229d9efaa9.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 02 Nov 2021, Trond Myklebust wrote:

> Hi Scott,
>=20
> Thanks. This mostly looks good, but I do have 1 comment below.
>=20
> On Mon, 2021-11-01 at 16:06 -0400, Scott Mayhew wrote:
> > During umount, the session slot tables are freed.=A0 If there are
> > outstanding FREE_STATEID tasks, a use-after-free and slab corruption
> > can
> > occur when rpc_exit_task calls rpc_call_done -> nfs41_sequence_done -
> > >
> > nfs4_sequence_process/nfs41_sequence_free_slot.
> >=20
> > Prevent that from happening by taking a reference on the nfs_client
> > in
> > nfs41_free_stateid and putting it in nfs41_free_stateid_release.
> >=20
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> > =A0fs/nfs/nfs4proc.c | 12 +++++++++++-
> > =A01 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index e1214bb6b7ee..76e6786b797e 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -10145,18 +10145,24 @@ static void
> > nfs41_free_stateid_prepare(struct rpc_task *task, void *calldata)
> > =A0static void nfs41_free_stateid_done(struct rpc_task *task, void
> > *calldata)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0struct nfs_free_stateid_data *data =3D calldata;
> > +=A0=A0=A0=A0=A0=A0=A0struct nfs_client *clp =3D data->server->nfs_clie=
nt;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0nfs41_sequence_done(task, &data->res.seq_res);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0switch (task->tk_status) {
> > =A0=A0=A0=A0=A0=A0=A0=A0case -NFS4ERR_DELAY:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (nfs4_async_handle_e=
rror(task, data->server, NULL,
> > NULL) =3D=3D -EAGAIN)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
pc_restart_call_prepare(task);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
f (refcount_read(&clp->cl_count) > 1)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0rpc_restart_call_prepare(task);
>=20
> Do we really need to make the rpc restart call conditional here? Most
> servers prefer that you finish freeing state before calling
> DESTROY_CLIENTID.

Good point.  No, it's not necessary.  Do you want me to send a v2, or
can you apply the patch without this hunk?

-Scott
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > =A0static void nfs41_free_stateid_release(void *calldata)
> > =A0{
> > +=A0=A0=A0=A0=A0=A0=A0struct nfs_free_stateid_data *data =3D calldata;
> > +=A0=A0=A0=A0=A0=A0=A0struct nfs_client *clp =3D data->server->nfs_clie=
nt;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0nfs_put_client(clp);
> > =A0=A0=A0=A0=A0=A0=A0=A0kfree(calldata);
> > =A0}
> > =A0
> > @@ -10193,6 +10199,10 @@ static int nfs41_free_stateid(struct
> > nfs_server *server,
> > =A0=A0=A0=A0=A0=A0=A0=A0};
> > =A0=A0=A0=A0=A0=A0=A0=A0struct nfs_free_stateid_data *data;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct rpc_task *task;
> > +=A0=A0=A0=A0=A0=A0=A0struct nfs_client *clp =3D server->nfs_client;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!refcount_inc_not_zero(&clp->cl_count))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EIO;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0nfs4_state_protect(server->nfs_client,
> > NFS_SP4_MACH_CRED_STATEID,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&task_setup.rpc_client,=
 &msg);
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

