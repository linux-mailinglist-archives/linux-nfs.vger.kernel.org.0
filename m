Return-Path: <linux-nfs+bounces-10887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E0A70E3F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AE7189B456
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAEBE567;
	Wed, 26 Mar 2025 00:38:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289510E4
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949484; cv=none; b=N/2E3PHTXvtap0wlhHJwPaAE/XAxmqaFsDhKnXvS7xaLT6Z39fq3I40qfIwZaBno8Q21UOKvoQouoDyWeWEOMl7hM56EW3+TJ86rRrfoIpn2ZtZXIqkj/kDgKbrPLkTT7cUIj4eeLBayJ35wVNsBHK/acZK3Z4Ri3MLdCraiIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949484; c=relaxed/simple;
	bh=uJuDyyc+2wlIBGJLOkBAfgfff9fmfpzG+4J31EsJ9ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G89X7nK8OoUd8pjwNf9ZU3OUneEkUBvWGCAdtU9fXJAoVaZ5cfh6NY45abZAKEk4YcHZc9UA+9BYlCFBHBA/sxHLvkEqfahR7VOYvacYiWKFBF+N+EKvHKz2vzCgO2RI42ZczJCviUp3qP28yt6p1Lv+5467sP6CKlh1Rcy8hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d57143ee39so52315355ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 17:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742949482; x=1743554282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPW5PB+SzkP1HifoU9fFKLTgYjqXCLnXaYEGqOO9xFU=;
        b=fFcY+0E/l3f+4p1DqYrPNYbntFFm60ySS2GbhTJOAuJ8wDIOcB6yMqWjJJPRvilUHk
         zCFAGneBCdXC18VLVdp1eimmf9P6aBkUkk51UdCEu9tLxv02xH4U7dd4bAodpeuW0JH8
         5b1mAq2BDkKDmCUzhx6JzPDp4zEphFMtihBQIk/gxLdpi4i9N/i0WaYyS60s3Vvy0K5g
         6UOsYwfYa9XfRNQbnuUktp0AZON239xeguZob0ct9DXc92X0K/6hM99C9ef9PtzyuQ2O
         zrVyLkK7m/OdMoBdJv7/V3m2N9GXlegZ0RdgWS9T/8kqRaWzjh49w6768GgGa/9JwwVS
         grPA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8Ko0nLnlyemRmU+UxN7cxqGOWwY4HmaKCRhYbVkyWYJG65cbqT5IY4KUw0FivB+z227vcz73CCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PVZb+3cgCy+O1vzJsykzyTr3JDl7wMJuBMKTFIOdJC+nfDH1
	LnKPNFMdk0wLatbw8a+MVhJCWZTpIDez9MD6AfsPS36LUsLZiPY=
X-Gm-Gg: ASbGncvIOvAmBQdGJyMZa8ce4gFVJoIYHfwl2eWx1Qb/Fj4XninWr8hWgpOUWh3z1nQ
	DfDn0CUg6YzEAPmSH7dTcwqms3yYe+ImHD4QzCnnQ/k6P2O4TISSY/W4l0XQ+/iZr6GxJja5MLq
	5njXrnrNrPki34BOa7vfNkf8yapsXItp20foXuUCGZpHv2cRLfdJrtV0VmaRiOKw0xISC1imHZS
	7XlotyS67ydWESyB5jbSViDPRzMgK0LM4f/oU7NNkmB0jrZWVfr/C652gseO//mpxaVQ14mS05x
	3jbZvFrJWCkWyhnq5v32fFLpMx4It2fo0fKPsmoD6Lp8DpEz83dNVsIm782DSQjsbYLu5r/JYOH
	ryJsQa9T9HvNoPeJDgtPPr+DPbXvd3Qhe1n9fdnmUQa2sOpHK9kbv6Q==
X-Google-Smtp-Source: AGHT+IGvsvCHO/4oAXTboF5VgqLCc04G2HY/oRgtjkvYuygFRsZjpa1JwFiy9CDhy+fXz9PpkVd+Vg==
X-Received: by 2002:a92:ca45:0:b0:3d4:35d3:87d3 with SMTP id e9e14a558f8ab-3d59612aa2fmr209898175ab.4.1742949481732;
        Tue, 25 Mar 2025 17:38:01 -0700 (PDT)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbec4a8esm2595859173.133.2025.03.25.17.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:38:01 -0700 (PDT)
Message-ID: <0a100472e4413afe3de584ee384591c5dabe56bb.camel@kernel.org>
Subject: Re: [PATCH v3 3/6] NFS: Shut down the nfs_client only after all the
 superblocks
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Benjamin Coddington
	 <bcodding@redhat.com>
Date: Tue, 25 Mar 2025 20:37:59 -0400
In-Reply-To: <ecccbc8fca9b057d018bb68acedfb47a6cf76550.camel@kernel.org>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
		 <1cefd7cbadf0eaec5bae66e0870cdb89c7120070.1742941932.git.trond.myklebust@hammerspace.com>
	 <ecccbc8fca9b057d018bb68acedfb47a6cf76550.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-25 at 20:15 -0400, Jeff Layton wrote:
> On Tue, 2025-03-25 at 18:35 -0400, trondmy@kernel.org=C2=A0wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > The nfs_client manages state for all the superblocks in the
> > "cl_superblocks" list, so it must not be shut down until all of
> > them are
> > gone.
> >=20
> > Fixes: 7d3e26a054c8 ("NFS: Cancel all existing RPC tasks when
> > shutdown")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/sysfs.c | 22 +++++++++++++++++++++-
> > =C2=A01 file changed, 21 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > index b30401b2c939..37cb2b776435 100644
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -14,6 +14,7 @@
> > =C2=A0#include <linux/rcupdate.h>
> > =C2=A0#include <linux/lockd/lockd.h>
> > =C2=A0
> > +#include "internal.h"
> > =C2=A0#include "nfs4_fs.h"
> > =C2=A0#include "netns.h"
> > =C2=A0#include "sysfs.h"
> > @@ -228,6 +229,25 @@ static void shutdown_client(struct rpc_clnt
> > *clnt)
> > =C2=A0	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * Shut down the nfs_client only once all the superblocks
> > + * have been shut down.
> > + */
> > +static void shutdown_nfs_client(struct nfs_client *clp)
> > +{
> > +	struct nfs_server *server;
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(server, &clp->cl_superblocks,
> > client_link) {
> > +		if (!(server->flags & NFS_MOUNT_SHUTDOWN)) {
> > +			rcu_read_unlock();
> > +			return;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +	nfs_mark_client_ready(clp, -EIO);
> > +	shutdown_client(clp->cl_rpcclient);
> > +}
> > +
>=20
> Isn't the upshot of this that a mount won't actually get shutdown
> until
> you shutdown all of the mounts to the same server? Personally, I find
> that acceptable, but we should note that it is a change in behavior.

It means that the other mounts to the same server won't inevitably and
irrevocably lock up. I'm unhappy that I missed this bug when I applied
the patch, but that's not a reason to not fix it.

As I said in the above changelog, the nfs_client's RPC client is there
to manage state for all mounts to the same server in the same network
namespace. If you shut down that client while there are still mounts
that depend on it, then not only have you shot yourself in the foot,
but you're going to spend a lot of electrons to just loop madly when
those other mounts need to recover state but can't because you've
permanently shut down the only way for recovery threads to communicate
with the server.

>=20
>=20
> > =C2=A0static ssize_t
> > =C2=A0shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
> > =C2=A0				char *buf)
> > @@ -259,7 +279,6 @@ shutdown_store(struct kobject *kobj, struct
> > kobj_attribute *attr,
> > =C2=A0
> > =C2=A0	server->flags |=3D NFS_MOUNT_SHUTDOWN;
> > =C2=A0	shutdown_client(server->client);
> > -	shutdown_client(server->nfs_client->cl_rpcclient);
> > =C2=A0
> > =C2=A0	if (!IS_ERR(server->client_acl))
> > =C2=A0		shutdown_client(server->client_acl);
> > @@ -267,6 +286,7 @@ shutdown_store(struct kobject *kobj, struct
> > kobj_attribute *attr,
> > =C2=A0	if (server->nlm_host)
> > =C2=A0		shutdown_client(server->nlm_host->h_rpcclnt);
> > =C2=A0out:
> > +	shutdown_nfs_client(server->nfs_client);
> > =C2=A0	return count;
> > =C2=A0}
> > =C2=A0
>=20


