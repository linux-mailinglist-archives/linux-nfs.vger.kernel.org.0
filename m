Return-Path: <linux-nfs+bounces-20718-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLFTHAZ31WlC6gcAu9opvQ
	(envelope-from <linux-nfs+bounces-20718-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 23:28:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124D3B50B2
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 23:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9353092908
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF737C922;
	Tue,  7 Apr 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Eex865SX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067E2C0307
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597096; cv=pass; b=HEEzfNfRmGmMSkS+LubOeqwO5xmw0MXxPTiId/dhmrL6Je0oQRJNsfLNIZH2g8qAyfef08OT703k8win80YHTTfh7i8S1T1Jk7Xg/Ip53mSc84bLEIItCwi6J8VWMLsGuUjdOJoWQCf703mbBY/ANF866/ZSbw+AhkjSyxh5PvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597096; c=relaxed/simple;
	bh=BD23OrScXZjz5BUAigowU+gghhYzusQo8IzGCUDUeLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAehKR9wDdhX8y72uq7Lybl4bEiPYt7p8iAWBIZy2n6wcjmJnb+lizUL6LhOIm/93SmJV4PT0eNWpcO6tnUxbpOD7nqzTtnl4HNjiC+deyjWplD9RBCKIukGPqEL3yrtVJLMX65uTTGki0WIj+2Ii0IGKm1B5MwLsDN+CKZj5kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Eex865SX; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59de8155501so6342618e87.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Apr 2026 14:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775597091; cv=none;
        d=google.com; s=arc-20240605;
        b=RRw+HXPjy/0Tbpxg78S6hsWxr0S8nbQTw9oUOR8LMx4/pZdYOg3qAk+xiCxiUEajeU
         IpCFpev3ycybo4CWsKcZ+u8bXjG+6yjIk+wBvD/K+yBXg3/0mOfCneHl+ImJmZGmmOsp
         TBYUVofQ+vgWZ6zQh3ermzcbAShOBwC0z8V+hiuVDWngBN+dYo/K6LtsF/yOhkV5S4W+
         Ib5wrPZzJyv3a1clMJVO8aah0JiKNnZINdoVuY+mz4Dw4IwO5HHPuTEz4gjl4xnCQTQB
         s9cUNqv4hX+H7sFCDN3eYu39/C/gfYin+U3yVprNn6PYi1i3hut6ZvnqIpQYasbMv2l3
         NH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KyQ60MvXwRQ1hA/X0j0xYmXbiBBa7x3kBLjA/zxjte0=;
        fh=gfkFBbf9P7xrY/HGP0WPoHERdpboW9d8Xwi7mWJX4rU=;
        b=ddFuAoPYXmfFOY/lS4uDwvnjvC+3yICq2TpA7zP68c3mmywqa9n+5KTy2/JParKmCm
         ekyHGtxzpp07BQaZDif4ayW8fLjTPvlYRs1eC281Vk8OBmu0FMauwtqrgtqODW9FnoI3
         45abuxsbKz4V8nqKB3TeyygkI2x+74zzABOErNhiBJJPXjWu88rddW3rI32puMEfOd3j
         rMqe2OFjZghDnKnu22h47VD93+EKyXi3qRrda7wKEDZ2yl/ca0csWpOXyfzrCT3fxOQ0
         aofE4pV2LNF+jxvq3zv3NWRX1t13Br66Hqoiyzsb3FBTgkeCc1zPKqNZAJZflMjZMHAw
         OgiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775597091; x=1776201891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyQ60MvXwRQ1hA/X0j0xYmXbiBBa7x3kBLjA/zxjte0=;
        b=Eex865SXWdQQnSGkMfrh1cWzT5xiFDD3tJjBsVVUnT2Ji8EE14+Vo/azrfqSZJXnQ6
         rHvjROi1qFVxYCiK9xHsBByoOQa/cYM4cREj2oTqUOvrnHyD39cp3+OAIxtWgDnsMK4h
         5Y4oF9n/q/SqY1XCZXTlMSR4ges6jl1NrMqo577r5P10NAKcixvMD2QUowW7VyqIdxju
         R/Yxs1MEXIlS6ItnkYz1kL2gbSsw2/dBa270eIyBSICFkrrLJ2h9vgYRvimeIbh++EgW
         2jcQDb9EmkXOrljfWmNeiAdCklL2/gblrtXZh2l2ODfhw/KbVNIydspvWUY3dQhop9I2
         YwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775597091; x=1776201891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyQ60MvXwRQ1hA/X0j0xYmXbiBBa7x3kBLjA/zxjte0=;
        b=NEWmnhLwNc1MChrenOmfZay6MUG+mpH2IjGd8M97RRjojW0NEPdeerrAcuIDA9UYot
         0f1Nm7ZWz9QyY26npEjXX10Rylv4g3dE+8kU0ibuUbjZFWd0CngvGGxXc68LwuiSrfgC
         WoYUhhbY0Ou87k9se8KXU+vyfjIlGkMGJ4tb2djugFGt8Ux/OPhW4lGBIL51v96AV+lG
         5leDOPUO+8XtqdPmTA7EGYH+qssjBU9BaO/jROmmVEv0n5OuNSk5L0qHzuc5cCqowrHu
         7WcNeZZQ96LCpRvZ34sI8wh99cbpSRWHWo/XEh/EmJHHM2sFqmC9cnFgFuVdK5Agrosg
         ZdSg==
X-Forwarded-Encrypted: i=1; AJvYcCX7tRqrFQILIzixiyUUTEiifcqLfolSHTNt/xg82Yt9B115o4P74kWKVIsFDleiMWnzjpQsaBdUW08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CpsIRCSC6PlSQwRJUYs4zd4rOzwP0w+fNISUlFvLekhlwh2N
	uWEeSziTD+xZ7cVliVOZtq+omvNAP+X8YeTIzILED6ddo+XgjBX8KeKSynO9/BSb9amxFAItzhr
	9kRDe60JJtA4jx3Bzi084ggsh3D3HMHVxUg==
X-Gm-Gg: AeBDietdKVIaJYimexhYYcNlvtCfT4sDvLV0D7goIhy0+yPpQL/N5jN6ejSd3pvmpf+
	qeYTlIu9s3cUUc9hRE++xMynbhJBD1euyumJi0Mlx1Hz2gSKSDqL/8gLIqzxw2wWUVXsfDuR7ME
	aBdv61kAHyXtcYbRJuV4nThp0vbe1f6m1+hEPPhVCyf2LWxEfzxZLuyVKLw9F5Wme4HH9gL6SOW
	YbjgXSA8/0QbJgs+AuUF8Twbs0sy6dWJB6v5JX2zSDhFYAMiUdcvHFlZ7QVnwLORFn5EKURzNTf
	/qGIoy3FlGye8ABN7shH8EE+yodVgpZ4AAZcS5eV
X-Received: by 2002:a05:6512:3b9d:b0:5a1:3400:f937 with SMTP id
 2adb3069b0e04-5a33755254bmr5425589e87.7.1775597090624; Tue, 07 Apr 2026
 14:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-1-d110da3c0036@kernel.org> <c36648f66b6e66f8aa555528c8969b1350c3a36f.camel@kernel.org>
 <CAN-5tyF2nxMaGsQS1B3oAMizGoCGvnTBYNgS9kMOfNoKKcwHxA@mail.gmail.com>
In-Reply-To: <CAN-5tyF2nxMaGsQS1B3oAMizGoCGvnTBYNgS9kMOfNoKKcwHxA@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 7 Apr 2026 17:24:38 -0400
X-Gm-Features: AQROBzAUxB7IAbK9jUSEw1XP3OuFG2LjChwkH8LpUN7EXCLmZau2Kx2WhNukGoo
Message-ID: <CAN-5tyEgO2rk=nveNigFLroVGbExC=Ok3UYFGUrcBUGQ5f-i+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfs: fix utimensat() for atime with delegated timestamps
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20718-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:dkim,umich.edu:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1124D3B50B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 9:28=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> w=
rote:
>
> Hi Jeff and all,
>
> With this patch and running against a server that would update the
> c/mtime of a GETATTR in a compound with CLONE(COPY),  the timestamps
> is (might be) going "backwards"? I see that SETATTR+DELEGRETURN (after
> the CLONE) is setting a timestamp which is earlier than what's
> returned by the server in the GETATTR. Though I haven't figured out
> how to "show" it via test (I observe it on a network trace).
>
> This is seen testing either against Hammerspace which already updates
> the values or the linux server with the patch I'm working on to update
> timestamp for CLONE/COPY.
>
> I have to say I haven't figured out if this patch needs to modify such
> that it fixes 221 but doesn't break 407 or we are fundamentally
> dealing with a problem of including a GETATTR in a compound while
> holding an attribute delegation that needs to be solved differently.
> Like I said before, if the server were to update the value upon
> receiving the GETATTR in the compound (regardless of the origin),
> should it then do a CB_GETATTR first (which I already grumbled seems
> like a poor choice)? Or, should the client be changed to not send a
> GETATTR in CLONE of the compounds if it's holding an attribute
> delegation and somehow figure out attributes differently then it does
> now.

Apologies. Please excuse the noise about the mtime going backwards.
There are 2 SETATTRs going on and I was looking at the src file
SETATTR. I believe I was also confused by the difference between
time_access value from time_modify in the SETATTR (for the dest file).
It's unclear why the access time wasn't modified (and the value
returned by the OPEN's GETATTR is used) but the mtime was modified
based on what's received in the CLONE's GETATTR.

> On Wed, Mar 25, 2026 at 8:30=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Tue, 2026-03-24 at 13:32 -0400, Jeff Layton wrote:
> > > xfstest generic/221 is failing with delegated timestamps enabled.  Wh=
en
> > > the client holds a WRITE_ATTRS_DELEG delegation, and a userland proce=
ss
> > > does a utimensat() for only the atime, the ctime is not properly
> > > updated. The problem is that the client tries to cache the atime upda=
te,
> > > but there is no mtime update, so the delegated attribute update never
> > > updates the ctime.
> > >
> > > Delegated timestamps don't have a mechanism to update the ctime in
> > > accordance with atime-only changes due to utimensat() and the like.
> > > Change the client to issue an RPC in this case, so that the ctime get=
s
> > > properly updated alongside the atime.
> > >
> > > Fixes: 40f45ab3814f ("NFS: Further fixes to attribute delegation a/mt=
ime changes")
> > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfs/inode.c | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > index 4786343eeee0f874aa1f31ace2f35fdcb83fc7a6..3a5bba7e3c92d4d4fcd65=
234cd2f10e56f78dee0 100644
> > > --- a/fs/nfs/inode.c
> > > +++ b/fs/nfs/inode.c
> > > @@ -757,14 +757,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dent=
ry *dentry,
> > >       } else if (nfs_have_delegated_atime(inode) &&
> > >                  attr->ia_valid & ATTR_ATIME &&
> > >                  !(attr->ia_valid & ATTR_MTIME)) {
> > > -             if (attr->ia_valid & ATTR_ATIME_SET) {
> > > -                     if (uid_eq(task_uid, owner_uid)) {
> > > -                             spin_lock(&inode->i_lock);
> > > -                             nfs_set_timestamps_to_ts(inode, attr);
> > > -                             spin_unlock(&inode->i_lock);
> > > -                             attr->ia_valid &=3D ~(ATTR_ATIME|ATTR_A=
TIME_SET);
> > > -                     }
> > > -             } else {
> >
> > This probably deserves a comment. How about something like:
> >
> >                 /*
> >                  * An atime-only update via an explicit setattr (e.g.: =
utimensat() and
> >                  * the like) requires updating the ctime as well. Deleg=
ated timestamps
> >                  * don't have a mechanism for updating the ctime with a=
 delegated
> >                  * atime-only update, so an RPC must be issued.
> >                  */
> >
> > > +             if (!(attr->ia_valid & ATTR_ATIME_SET)) {
> > >                       nfs_update_delegated_atime(inode);
> > >                       attr->ia_valid &=3D ~ATTR_ATIME;
> > >               }
> >
> > --
> > Jeff Layton <jlayton@kernel.org>

