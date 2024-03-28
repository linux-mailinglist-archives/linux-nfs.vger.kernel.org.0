Return-Path: <linux-nfs+bounces-2547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D999890980
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DFA1F213EB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26712F38B;
	Thu, 28 Mar 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5df2u2t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B23130A54
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654944; cv=none; b=ifH3P8nh6l3wwFq2Eg5iC9Uy1rQlRpiaeoE6OXi4E2mGTzOI137Qdd+X7a7Pd/Hr72XeeJmrDLVGOG77oxiDmRU3vjQwATZkxFewAuCNAhASW+ayGS/87dMrlaW0erPPqja03FKHu71Ad5XMh6bZKU2WG1MRUx1PsuZSY55OtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654944; c=relaxed/simple;
	bh=G54bg5q8nSHx+bWgKyzuXCJMK6dG285yA0AuuEKhQKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/s72FxDcZ+cbmoxxjQnHuQJE3DgdtjwuUDwd9JeSlnFk1T5nLJyeG91U0XpwyYfLn6o1FaXA9ybhb8ISDnzEhjNYqVbktUtvYTuUIa2n4XzJSDFaCUUtDGUl19uPX/6u6659Dbb26o2+ic5Ult8V+Y4mq+8z7zc9dBIss+GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5df2u2t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711654941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9rFKgdnjl1+qP2ulkGzbGF6DQvxAxPK/GjEf2hMSac=;
	b=F5df2u2ttAPAcMRAylxaI75/GGm/jIZufXMTJ98gfxEUHosSLc1yNcj+tCFyO7nIzFXO1C
	BUIlrN2dlyMkTp5I4DfuN7IKcL+Cewh+ADUcvl0gl8FbzNnFB6j2R/siKdlDTf5bCFt9IB
	/LE7bpb5hJedD0IQ1zy45WznJViS/CI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-0pJKG3AIMS6c6E2O9qbhYg-1; Thu,
 28 Mar 2024 15:42:16 -0400
X-MC-Unique: 0pJKG3AIMS6c6E2O9qbhYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76DF729AC03F;
	Thu, 28 Mar 2024 19:42:16 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 61E11C53361;
	Thu, 28 Mar 2024 19:42:16 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id DED8812E8CC; Thu, 28 Mar 2024 15:42:15 -0400 (EDT)
Date: Thu, 28 Mar 2024 15:42:15 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: jaganmohan kanakala <jaganmohan.kanakala@gmail.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [External] : Re: LINUX NFS support for SHA256 hash types
Message-ID: <ZgXIF1IzGn8dZGAB@aion>
References: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
 <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
 <CAK6vGw=50xecARE1MHmB73VrQS_OFzSqA5c1JF9AuOmjusUDNg@mail.gmail.com>
 <DEC63E8F-A254-4A2C-B0CD-74E2256D0990@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DEC63E8F-A254-4A2C-B0CD-74E2256D0990@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, 25 Mar 2024, Chuck Lever III wrote:

>=20
>=20
> > On Mar 25, 2024, at 2:34=E2=80=AFAM, jaganmohan kanakala <jaganmohan.ka=
nakala@gmail.com> wrote:
> >=20
> > Hi Chuck,
> >=20
> > Following up with my earlier email, I've noted from the following commi=
t that the support for SHA 256/384 has now been added to Linux NFS.
> > https://github.com/torvalds/linux/commit/a40cf7530d3104793f9361e69e84ad=
a7960724f2
> >=20
> > The commit message says that the implementation was in 'beta' at the ti=
me of the commit. Is the implementation still in the 'beta' stage?
>=20
> "Beta" was used simply to mean that the code did not have
> significant test or deployment experience. So far there
> have been only a few bugs, all known to be fixed at the
> moment.
>=20
>=20
> > I have an NFS client where I'm trying to support SHA 256 for Krb5. How =
can I verify my implementation with the Linux NFS server?
>=20
> You will need a Linux distribution whose user space
> Kerberos libraries support AES_SHA2 enctypes, and of
> course a recent kernel. Scott, anything else? Does the
> KDC need to handle these enctypes too?

It depends on whether both the NFS client and the NFS server support the
enctype negotiation extension (RFC 4537).  If they do, then the KDC
doesn't need to be able to handle those enctypes.

-Scott

>=20
> -- Chuck Lever
>=20
>=20


