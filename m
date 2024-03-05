Return-Path: <linux-nfs+bounces-2210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F487202C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02461C21666
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401485920;
	Tue,  5 Mar 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBRVun+i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D685C55
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645436; cv=none; b=I3fbcEn3k3qh5DS/Gb50RUhohMIxcK5AVM1Der7f/NMg2n3reDB8CcWNX8PorY/WHY0Iz788U73/P8agZLNdARHsxqrvqpgeIc/O/VWhMJAZ02GUeU96mb2RMt8KkR3ojJkwdWeh+K6pspcGT9XvxWE/kzekvxxoGpqngQigLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645436; c=relaxed/simple;
	bh=g1vXvcZHsPvo2lhxzmoLBp4lQXfLj1t9Gc9F6q2CruM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWZAtEXvpk3ZOMMJe9OIYE4koh7No0iDO3PGWiCRDWnLcO33mv4MYQzueJztf8iNU77IZF3Fu37Y2GMhkjGp9x2BqZXde1yGp0QFUUawz/5ytS5kR5LYvJ5rTVdBY1nakz8cSxpUtbol2F3TI4od3+kRKu/0jPf/cFyGJok/hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBRVun+i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQsbm1zyIdzMX2iiHieluJPXv2Cj8lci1/3IaQk/awQ=;
	b=YBRVun+iXK8uLatnR+v16KMpzCI3FqfOxEjddGYoRIDqXhkDu+f6MXHpioJHbxLxcq9tyl
	lHIKI2Oh6sqlkJTrlPZEV/em4ZQd02DgOSJvDGjoDe64zUut+h4Mc4xDwkJd9AyQzDtAFr
	kORWH5v6xc7inzot9/gvKKw7ZswJgIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Iqc_9VihOaOblZUeiA-Bgg-1; Tue, 05 Mar 2024 08:30:32 -0500
X-MC-Unique: Iqc_9VihOaOblZUeiA-Bgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DC2C80026A;
	Tue,  5 Mar 2024 13:30:32 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E0D6C04220;
	Tue,  5 Mar 2024 13:30:32 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 074D612C438; Tue,  5 Mar 2024 08:30:32 -0500 (EST)
Date: Tue, 5 Mar 2024 08:30:31 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH 0/2] gssd: improve interoperability with NFS
 servers that don't have support for the newest encryption types
Message-ID: <Zeced5frADc9oA0G@aion>
References: <20240228222253.1080880-1-smayhew@redhat.com>
 <CAN-5tyFUXLrRLXiFmiN0X3fOAS4UBR+5Uo1XrN1sApD5K3W3wg@mail.gmail.com>
 <ZeYHMYoVglzPreL1@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZeYHMYoVglzPreL1@aion>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Re-adding the list.

On Mon, 04 Mar 2024, Scott Mayhew wrote:

> On Mon, 04 Mar 2024, Olga Kornievskaia wrote:
>=20
> > On Wed, Feb 28, 2024 at 5:23=E2=80=AFPM Scott Mayhew <smayhew@redhat.co=
m> wrote:
> > >
> > > In order for an NFS client with support for the newer encryption types
> > > (AES with SHA2 and Camellia) in its RPCSEC GSS kernel code to connect=
 to
> > > an NFS server without support for those encryption types in its RPCSEC
> > > GSS kernel code, it is sometimes necessary for configuration changes =
on
> > > the NFS server... particularly if the NFS server's userspace krb5 code
> > > does have support for the newer encryption types and/or the NFS serve=
r's
> > > keytab has "nfs" keys using the newer encryption types.
> >=20
> > I'm stuck on "the NFs server's keytab has nfs keys" with newer
> > encryption types. That sounds like a misconfigured server. The
> > administrator shouldn't have issued a keytab knowingly that those
> > encryption types are not supported.
>=20
> I think it's probably pretty common for administrators to omit the -e
> option when they use 'kadmin ktadd' or 'ipa-getkeytab', so they get keys
> for whatever's enabled in their krb5 configuration.
>=20
> But It turns out that part is not even necessary for the problem to occur=
=2E=20
> As long as the krb5 configuration has those encryption types enabled, the
> problem can occur.  See the thread posted by Orion Poplawski on 2/29:
> https://lore.kernel.org/linux-nfs/181e6547-a0ec-4c02-844b-bf1eda464acd@nw=
ra.com/T/#t
>=20
> -Scott
> >=20
> > > Rather than
> > > rehashing the whole discussion here in the cover letter, see the
> > > description in the first patch for the gory details.
> > >
> > > These patches make it easier for a "newer" NFS client to work with an
> > > "older" NFS server.
> > >
> > > The first patch adds support for an "allowed-enctypes" option in
> > > nfs.conf, allowing the the client to restrict the permitted encryption
> > > types to a subset of what is otherwise supported in its krb5 environm=
ent
> > > so that it doesn't use an encryption type that the NFS server doesn't
> > > support when negotiating a GSS context.
> > >
> > > The second patch builds on this by adding an automatic backoff featur=
e,
> > > where if the NFS client fails to negotiate a GSS context with the NFS
> > > server using the newer encryption types, it will try again without us=
ing
> > > the newer encryption types.
> > >
> > > With these patches in place on the NFS client, the "newer" NFS client
> > > will work with an "older" NFS server without requiring any configurat=
ion
> > > changes.
> > >
> > > Scott Mayhew (2):
> > >   gssd: add support for an "allowed-enctypes" option in nfs.conf
> > >   gssd: add a "backoff" feature to limit_krb5_enctypes()
> > >
> > >  nfs.conf               |   1 +
> > >  utils/gssd/gssd.c      |   6 ++
> > >  utils/gssd/gssd.man    |   9 +++
> > >  utils/gssd/gssd_proc.c |  15 ++++-
> > >  utils/gssd/krb5_util.c | 135 ++++++++++++++++++++++++++++++++++++++-=
--
> > >  utils/gssd/krb5_util.h |   3 +-
> > >  6 files changed, 159 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >=20


