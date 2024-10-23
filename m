Return-Path: <linux-nfs+bounces-7381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E09AC32C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EE3282059
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E07156F3A;
	Wed, 23 Oct 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lwhkPsZb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9ED4174A
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674723; cv=none; b=R6Dph2w9a5Vcm4UVyf5PLOhgArABVVsHZZkEnlidfeJdfHQhxk2XRfyKtpd9YA7fncMN46NdJBktjp4Vu1A2pVcBKlj137ulgYK9tbXc5w+6YE0+kbCmFvXEWsr5G1/NbhIfNZeH/5u1xO8d8yn6PPfnQ4yY1/kc1KCUdAyO+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674723; c=relaxed/simple;
	bh=C8sMvkt7udgzyq/M95QqIAUM0lQ2YfIMoc8i1xfXpCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfS+j4JVUzhPsIClJvxx8fQ6ixRrWHix3iZQeFrfztIZKjHBd+SFddZa595IlgTDjIaM7AKualGI7I/+Bemuj2e9raEX8hu8ZQmTZjYYao10x9w0efrwlAiGQbOBkVJ5qHQiflu2Wapi72sKWKEDb+YF1TEUh0Y/WzMLVRrz+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=lwhkPsZb; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3A18D240101
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 11:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1729674713; bh=C8sMvkt7udgzyq/M95QqIAUM0lQ2YfIMoc8i1xfXpCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=lwhkPsZbPANmdBvVmWbAQ+Gy+6zlyBEWNJq1sRwL+mU96AZPrTv1fMz9e1wLoQ8T6
	 wUUsu+sQfLkak1W8avTWfanB72jXchOYc8m/xKwyB/2n3GAcWaE/8UJY3548ZzAlhF
	 BWICn2clYFnF8XdBOuT2hbvJR2PPEeF0zeBTyWBSzdlVDxssIGcT8dx18SqBQZkrRA
	 8NoTDLFIwl3M9lLCkYwuepQajhf9NPcmNhdQjW9H/MHtHVh06I8kwjADg1zXKBcA9W
	 /Z9DEH+Iecg+L+2DZvbYTPXEWhQYsG+pkt0KU4PKF/ADosaP+AWCVu+qHefME5BsMf
	 +k2WtIfEBIv4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XYNbD3bG0z6txY;
	Wed, 23 Oct 2024 11:11:52 +0200 (CEST)
Date: Wed, 23 Oct 2024 09:11:51 +0000
From: "Patrick M." <patrick-muench@posteo.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs xprtsec conflicting with squashing
Message-ID: <20241023111146.3659e2e3@jen>
In-Reply-To: <20241022163621.29890b64@jen>
References: <20241022155047.0b73b6b3@jen>
	<1294ABC2-CFCB-4984-B286-A973627E70EB@oracle.com>
	<20241022163621.29890b64@jen>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nevermind this - did further testing today and it boiled down to a inconsis=
tency between updating exports, adapting fstab and exportfs -ra and restart=
ing nfs services.
Apparently i somehow made things consistent and inconsistent when switching=
 squashin on/off.

Now i can use mtls in all used combinations of squashing/mapping.

Sorry for the confusion and thanks again
Patrick

On Tue, 22 Oct 2024 16:36:21 +0200
"Patrick M." <s7mon@web.de> wrote:

> Hello,=20
>=20
> will give it a try on 6.11 server side and raise a bug if it does not - w=
ill most likely not happen before tomorrow.
> Thanks for the fast reply
>=20
>=20
> On Tue, 22 Oct 2024 14:17:18 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
> > > On Oct 22, 2024, at 9:50=E2=80=AFAM, Patrick M. <s7mon@web.de> wrote:
> > >=20
> > >=20
> > > Hi there,
> > >=20
> > > tried switching to nfs with kernel TLS (mTLS to be specific).
> > > Without xprtsec i was able to use the following options on exports
> > >=20
> > > "rw,async,all_squash,no_subtree_check,anonuid=3D1000,anongid=3D100,fs=
id=3D6,sec=3Dsys"
> > >=20
> > > but both the squashing/mapping-ids seems to conflict with TLS and i w=
anted to understand if this is by intention or a bug. =20
> >=20
> > I don't expect breakage like this, so at least some further
> > triage is needed. Can you open a bug on bugzilla.kernel.org
> > under the Filesystem/NFSD component?
> >=20
> > You can also verify that this behavior recurs with a 6.11 (or
> > later) kernel on your NFS server.
> >=20
> >=20
> > > And if it is by intention of course why - because in my understanding=
 auth and encryption of the mount itself would not contradict with the mapp=
ing functionality.
> > >=20
> > > I now use "rw,async,no_subtree_check,fsid=3D6,sec=3Dsys,xprtsec=3Dmtl=
s" and it is working. Using no_root_squash also seems to conflict.
> > >=20
> > > Keeping ID-Mapping i get this on client side
> > >=20
> > > mount.nfs: Operation not permitted for server:/mnt/target on /mnt/tar=
get
> > >=20
> > > And nothing i could relate as cause on server side (happy to provide =
specific logs if needed, even with nfsd or rpc flags with rpcdump i could n=
ot see a cause).
> > > Tlshd showed also succes in both scenarios (handshake successfull) an=
d i can use all options as well if i remove the xprtsec on server side.
> > >=20
> > > Client:
> > > Linux 6.11.
> > > nfs-utils-2.7.1
> > >=20
> > > Server:
> > > Linux 6.5.52
> > > nfs-utils-2.7.1
> > >=20
> > > Sorry if i missed this in documentation, if so i'd appreciate the hin=
t where i should look in detail
> > > and thanks for this feature!
> > >=20
> > >=20
> > > --
> > > best regards
> > > Patrick M.
> > >  =20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
>=20
>=20
>=20



--=20
Patrick M=C3=BCnch <patrick-muench@gmx.net>

