Return-Path: <linux-nfs+bounces-18625-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGU0AbMzfmmTWQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18625-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 17:54:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BAC3183
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF31C3014973
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5C3148A6;
	Sat, 31 Jan 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHgKnw+U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382B3033CA;
	Sat, 31 Jan 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878448; cv=none; b=fgoYhH0uSsff/5ttIzLRdj1Vg3o9qw5NVeIlgfyG5x1RK6I1WZKgLkvpVyGF/sQmqmOnIcW3Pp6p7U239bF3bbsaYQlqCmRahyyZdadSmsLWhmBAwvAnIysDehkf3FEBI853X4Z/4YVl/zZ+5bfXMSDM3TAkYhAhxDvZYP5yemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878448; c=relaxed/simple;
	bh=L/h0dWQ/ETs9jph2UAJnePpqz8jLDJqILLP1qN4w2GA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKLKFKRR2ne5UioHP1M9z1ezMAU9NNYK8cSrsri80NRwiJTAesA6BdMoL2o90DbRBbDzjg4iivKmJvPGae1mDysJGi8q3XntV7eRKn/ckDyX5yoEtPcUAQJRUEms1wRBj7tiFlRXaZDQLRg1Y2lxlfUg4X/6TloYODgP/agyW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHgKnw+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C61C16AAE;
	Sat, 31 Jan 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769878447;
	bh=L/h0dWQ/ETs9jph2UAJnePpqz8jLDJqILLP1qN4w2GA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iHgKnw+UsEdNPjxAWuF4PQhtqokFO8YsVxh6BsCJ/RmpFM16FGlkr1NfDZjyQF8rz
	 iUEnT9bjb+0E9YHmzYN8sfA+98XXdWqPSXj+tNnaPHL9X4l4Yn/cTQLIjZGlffMELS
	 /pYT0vQMm9w3M4VQ0CT02sIFflEKu5t0a/eLJj59zLxln4pNz/Y7HElR0M62QltR1w
	 SItqO77o9P9wljD8g7tgfQOqrnRdo1jOhXBofu4fm/yM42X9wGV680/in37I2uF7gv
	 7gYI0DEPSBSMBsIdxU+BP7R/ERykE0yAHZrjwBdfVH1et/vpcbZyYdoV1iPPn/Xdt5
	 QTBSlKGe5MT7w==
Message-ID: <6d56e691114294ed3187e7a6f281c98293393a1a.camel@kernel.org>
Subject: Re: [PATCH] nfs: fix memory leak in nfs_sysfs_init if kset_register
 fails
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>, Salah Triki
	 <salah.triki@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 31 Jan 2026 11:54:06 -0500
In-Reply-To: <9EF0F792-3B22-4A20-8A37-9C4B2236740C@hammerspace.com>
References: <20260131000937.229276-1-salah.triki@gmail.com>
	 <9EF0F792-3B22-4A20-8A37-9C4B2236740C@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18625-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email,kobj.name:url]
X-Rspamd-Queue-Id: 529BAC3183
X-Rspamd-Action: no action

On Sat, 2026-01-31 at 07:21 -0500, Benjamin Coddington wrote:
> On 30 Jan 2026, at 19:09, Salah Triki wrote:
>=20
> > When `kset_register()` fails, it does not clean up the underlying
> > kobject. Calling `kfree()` directly is incorrect because the
> > kobject
> > within the kset has already been initialized, and its internal
> > resources or reference counting must be handled properly.
> >=20
> > As stated in the kobject documentation, once a kobject is
> > registered
> > (or even just initialized), you must use `kobject_put()` instead of
> > `kfree()` to let the reference counting mechanism perform the
> > cleanup
> > via the ktype's release callback.
>=20
> I don't think this patch is correct - the kobj is not initialized
> yet, and
> on error return from kset_register() you'll likely get the WARN from
> lib/kobject.c:734 kobject_put() when calling kset_put().
>=20
> That said it does look like that path might leak kobj->name, you
> might
> look at doing kfree_const() on it.
>=20
> Did you test this - how did you determine this was a problem?
>=20
> Ben

If you take a look at kset_register(), you'll see that it does free the
kobj.name pointer if there is an error when adding the kobject.

IOW: there is no bug in the current code.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

