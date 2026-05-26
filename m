Return-Path: <linux-nfs+bounces-21934-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFpZIX4tFWpmTQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21934-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:19:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A605D0CCE
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C37302AD22
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 05:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3E3B9D86;
	Tue, 26 May 2026 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aBB/Q88m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RaoF4Lkf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBD17745;
	Tue, 26 May 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779772768; cv=none; b=BOVY+05JOOCOiP5k5+eOJt78tb+4vMAzVXJJssWid7/LInXj87PmeXIbCaZvKyVF3cNzkWung8E4rhiRuN5OZHPe/C0KyJy8AysX1kCaNoTDrHVBn7ibBT4wqaZS/MxyTCf0mzQf4z54EUW8OJbP4SMkqFJ6NeK86V2s6zXUOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779772768; c=relaxed/simple;
	bh=QjUv+HzolMXKljm0GRDOxOKgqTTSYCxMbkwAQkhauYg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AEWLLtUPlbuvIvJGIFoDwePfcjWIvYxGnHWcBKmdN3p1zty+OC23YwBqcXSXHqpWwK66UzDvLYtcMS1XHExggctowiRZlvqaNkknpM34Nh0VtmaCR9gObYuBkfZUKsJlXM84oSzo1ymxMqcNxAEBRladgwMA16HQbNe3fFN60e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aBB/Q88m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RaoF4Lkf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B44514000A4;
	Tue, 26 May 2026 01:19:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 26 May 2026 01:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779772765; x=1779859165; bh=BJiHFKAFrF0Y8ns3Td/pbX3OSPmQsn2+eSY
	ZVXfmBxQ=; b=aBB/Q88mS+xvhmG/cfdjuZ2AoofXfvfupJ60ygbrEakZKwDNtzk
	mnm+Ajf0+CfM2Vo3KXTESL7C9ORCd8veYVBI5bTSOkndPPC/dZHQWR6S2lyoOBKD
	VUS44RocBTHK9sjTRLSs9WlsrD6rZAieq94ByeZtecZvlcS9s3pUxk4v/XFFVEBV
	OwRqUI9dcJWP6NMLqGna9y8juqQ0dZ7XZs8i01tn3KtcZHKcc1PtKmA66fU7qiUz
	gxv/qHh4DiDbj2O1GKQYnI5750Lm6m9qpZLLyszNKd0icGn0w4swYybtLstzc5kJ
	M0m2FNE7gR5x24cT0E/13QZkiyX5vxBUaKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779772765; x=
	1779859165; bh=BJiHFKAFrF0Y8ns3Td/pbX3OSPmQsn2+eSYZVXfmBxQ=; b=R
	aoF4Lkflz4LgV80WWpYc6Z9AHq1XEI+wad+6qMgTO/0ZmlvK5uBowbhJaLoX5Vbw
	2z3o33lppDgweMNMhytzfhHmZls8UV5//jbjlsR8tNCiylUQ1wdCa7u+Mdyx8cAS
	FkEI7cVzdZ7ojgWE1MRJib2iml9AKWedAJ80bSyub/k3l56DYIEQCCpa3VyiFqAo
	QmhQWgMdszIDFyP0B+YzsnoyGoJV8uIksAIzFTq/s4QFa8HUolGG9YmoO+A9yx9e
	osIz2xxQGVXjeZUD1dyQxBy8QrerbFkWIddSy6RXNCyOOY6hv+2YYSQS7CNQkc4S
	mZRfO9sLGgnOYAgKmQ92g==
X-ME-Sender: <xms:XC0Vakf55VNum050PRvcWSO1tCrTQ4JuRxqDLbtuJwFk71OK0s22WQ>
    <xme:XC0VaozNCOlqD_5GcyVXijAZpeILEj-vctmJMUqTdmwoBzN2Y7oqeaFhM_pUTinwF
    VnGFYc3LlpIXY-RbCzsz-mKZGxgtpbnjsx91-6MOCmZmDE0>
X-ME-Received: <xmr:XC0VapIhmY1G-JzL1_a4b03-uINH2rUcQ34dGkCOMB0AN3dzg4aDEtBjPBKnMpHnlI6E7HIi4sox6pxu39kfT53m2BZd0QY>
X-ME-Proxy-Cause: dmFkZTE/Cyo9wS+jgMyDuurJqwCnXrYFSqFIoZsch3B5BS1YEY6uphbhG0EZlc7qXf/vpS
    mf3hPu6H5aD1KV10d8e3KdC285H2EyC7a7qZ4B9fiawZh7diSR0rJiKFGYSSBxq20GCy71
    d3yulhZjlXzu48ejBf/QsBBADIeZMNYuYKr7UByCakxQdMuVdPo6Uycz1fjx7L4lbg7M0y
    Px8FqKFIt+bxdne/gMkx1Q2TQCrigdqSOvSu4WNJEyyC27jm0b/+jdEznc4eTlqYZZzjvm
    AYi4lncnZCh8zwKhSXhOGw4dQO5NTfdVK151TgLnWVOFKQmS6POhCCUxIdh3uL555LSjfG
    xzdOJwh2O5j/Qq0YVVg8++q3lfcbcKJVb6sjFfIFd6suVABOAXnIkEk1j/iWZXrqzSbHdl
    dylyUia4mTRAVsZgWfjqXi8nHhY/J/p2L7Ud0ctfvMR3VFL2gZdPjRPVDrwmdOg3Mklzkw
    uNZhv8eTLJPKTQjNj/M7yYBs7PhMgEtanPL5TwQ0yO0rVerzaOCZRE1P2SVKyvq03klTwm
    CUXSZ/pdRgiVNlI2FzF3s5krq2vF+Kzz6DlIZcXZQBxty6faMsiGKpyT9NycsoD3+AsXzD
    fjTVcieNgNkTZbNIw14zlf3h0qDb4BM8Gc337rs/szF4HQq+qXNIQFbhAzUg
X-ME-Proxy: <xmx:XC0VaqEsgXquTugoW3IZmyDIlztIWBLogpd-gE5uPETM6v0Hex2trw>
    <xmx:XC0Val_WBHtsGtJxKhJaU9xv5fRLOkJYvTiLW39EYghoWYAC-KTNqw>
    <xmx:XC0VaqJW3sxLh4yFW797CMxtYn5rtYYdOQ3KAd1RQA-c3hiEolMMsw>
    <xmx:XC0Vajtr3x7nBbXS9rF-uUqkshwae911oCzoc_Mikn44iJLGyfRMQw>
    <xmx:XS0VaktzDuSckgUAqI-B29wgJYJpKa_udBmo4WiF5Iow66HV-11lOZae>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:19:21 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Benjamin Coddington" <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] VFS: fix possible failure to unlock in nfsd4_create_file()
In-reply-to: <0a9fd2bb1cb7b1190d177034832277169d8d1359.camel@kernel.org>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
  <0a9fd2bb1cb7b1190d177034832277169d8d1359.camel@kernel.org>
Date: Tue, 26 May 2026 15:19:17 +1000
Message-id: <177977275746.3379282.16167323157026052413@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21934-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: E1A605D0CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026, Jeff Layton wrote:
> On Mon, 2026-05-25 at 16:23 +1000, NeilBrown wrote:
> > atomic_create() in fs/namei.c drops the reference to the dentry
> > when it returns an error.
> > This behaviour was imported into dentry_create() so that it
> > will drop the reference if an error is returned from atomic_create(),
> > though not if vfs_create() returns an error (in the case where
> > ->atomic_create is not supported).
> >=20
> > The caller - nfsd4_create_file() - is made aware of this by checking
> > path->dentry, which will either be a counted reference to a dentry, or
> > an error pointer.
> >=20
> > However the change to use start_creating()/end_creating() (which landed
> > shortly before the dentry_create() change landed, though was likely
> > developed around the same time) means that nfsd4_create_file() *needs* a
> > valid dentry so that it can unlock the parent.
> >=20
> > The net result is that if NFSD exports a filesystem which uses
> > ->atomic_create, and if a call to ->atomic_create returns an error, then
> > nfsd4_create_file() will pass an error pointer to end_creating()
> > and the parent will not be unlocked.
> >=20
> > Fix this by changing dentry_create() to make sure path->dentry is always
> > a valid dentry, never an error-pointer.  The actual error is already
> > returned a different way.
> >=20
> > Note that if ->atomic_create() returns a different dentry (which may not
> > be possible in practice) we are guaranteed (because it is only ever
> > provided by d_spliace_alias()) that it will have the same d_parent and
> > so it will have the same effect when passed to end_creating().
> >=20
> > Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open=
()")
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index c7fac83c9a85..4787244ca4a7 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -5024,6 +5024,7 @@ struct file *dentry_create(struct path *path, int f=
lags, umode_t mode,
> >  {
> >  	struct file *file __free(fput) =3D NULL;
> >  	struct dentry *dentry =3D path->dentry;
> > +	struct dentry *orig_dentry =3D dentry;
> >  	struct dentry *dir =3D dentry->d_parent;
> >  	struct inode *dir_inode =3D d_inode(dir);
> >  	struct mnt_idmap *idmap;
> > @@ -5043,9 +5044,18 @@ struct file *dentry_create(struct path *path, int =
flags, umode_t mode,
> >  		if (create_error)
> >  			flags &=3D ~O_CREAT;
> > =20
> > +		/* atomic_open will dput(dentry) on error */
> > +		dget(orig_dentry);
> >  		dentry =3D atomic_open(path, dentry, file, flags, mode);
> >  		error =3D PTR_ERR_OR_ZERO(dentry);
> > =20
> > +		if (IS_ERR(dentry))
> > +			/* keep the original */
> > +			dentry =3D orig_dentry;
> > +		else
> > +			/* Drop the extra reference */
> > +			dput(orig_dentry);
> > +
> >  		if (unlikely(create_error) && error =3D=3D -ENOENT)
> >  			error =3D create_error;
> > =20
>=20
> Sashiko noticed a couple of problems in nearby code that you may want
> to take a look at:
>=20
>     https://sashiko.dev/#/patchset/177969022571.3379282.1644874462442832349=
6@noble.neil.brown.name?part=3D1
>=20
> ...but the patch itself looks correct.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20

Thanks for forwarding that review.
It identifies two possible problems.  Both of them are hypothetically
possible based on the APIs.  One (involving atomic_open returning a
different dentry) would, I think, require a remote server that is
seriously misbehaving.  When asked to OPEN a file it would need to
return a filehandle for a directory that is already in the dcache.
The other (atomic_open doesn't actually open the file) appears to be
impossible with in-kernel filesystems as they only do that when the
dentry is already positive, and as nfsd has done a lookup while holding
the parent lock, that shouldn't be possible.  I haven't done a thorough
audit though and I may have missed a case.

The fixes are quite straight forward so I'll post patches to fix these
issues in nfsd.

I'm working on a rewrite of nfsd4_create_file and lookup_open() so that
nfsd can use a better interface which will improve the code and fix some
minor edge-case behavioural issues.  So I'm just focusing on simple
fixes at this stage, not necessarily best fixes.

Thanks,
NeilBrown

