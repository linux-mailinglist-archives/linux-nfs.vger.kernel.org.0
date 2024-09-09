Return-Path: <linux-nfs+bounces-6337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5359716F8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 13:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984121C217CE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6A1B3725;
	Mon,  9 Sep 2024 11:34:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB11B1D7A
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881643; cv=none; b=OpT71oLATS4pe3+c2gkZIbYelHouJQaSSxj7TYtZ3jntr+7I3GjjVYWbrcIAJwPpRT7LYFkcRW1Anv0e8m1En27UaN0zh2sMgn0mho8n7fe5marzXPPpN7t61FOaulScesuYy+0dWXreFTIJWuTEufuLAwxTQpcm5+d9Ga3Gex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881643; c=relaxed/simple;
	bh=R1nya6Eo+iPzdodCYDnS0daVSwPndrpQ5/s2bM2RmuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dQAhxRunuC37DWpfGGrpkK8ZoKxludrtzEqS1jw5yn7oLgspwCI+aJetZO7QCjPEtyH1WzLIzAAF1Tpjrcgx9cXnp9jwoVQXjRjLFbB40Nx6jestNlSHOONN08icAwXTJ7PQVnpS9a2/ah0iNhKuNbksLWDQDhMArogzba+asJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-277-H4Bn3nZzNZ6V0rqbRnoiOA-1; Mon, 09 Sep 2024 12:33:58 +0100
X-MC-Unique: H4Bn3nZzNZ6V0rqbRnoiOA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 9 Sep
 2024 12:33:04 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 9 Sep 2024 12:33:04 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Mayhew' <smayhew@redhat.com>
CC: Li Lingfeng <lilingfeng3@huawei.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"neilb@suse.de" <neilb@suse.de>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "tom@talpey.com" <tom@talpey.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>, "houtao1@huawei.com"
	<houtao1@huawei.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, "lilingfeng@huaweicloud.com"
	<lilingfeng@huaweicloud.com>
Subject: RE: [PATCH] nfsd: return -EINVAL when namelen is 0
Thread-Topic: [PATCH] nfsd: return -EINVAL when namelen is 0
Thread-Index: AQHa/tltH5fpypZKDEqICq9omYVD5rJOXHzAgADqoYCAABJ2gA==
Date: Mon, 9 Sep 2024 11:33:04 +0000
Message-ID: <674f0d570dc241bf86294a9c8141a0b4@AcuMS.aculab.com>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ZthzJiKF6TY0Nv32@aion> <cccdc13066204448af7f0fd550f34586@AcuMS.aculab.com>
 <Zt7a2XO-ze1aAM-d@aion>
In-Reply-To: <Zt7a2XO-ze1aAM-d@aion>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Scott Mayhew
> Sent: 09 September 2024 12:24
...
> > > > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > > > index 67d8673a9391..69a3a84e159e 100644
> > > > --- a/fs/nfsd/nfs4recover.c
> > > > +++ b/fs/nfsd/nfs4recover.c
> > > > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cl=
d_msg_v2 __user *cmsg,
> > > >  =09=09=09ci =3D &cmsg->cm_u.cm_clntinfo;
> > > >  =09=09=09if (get_user(namelen, &ci->cc_name.cn_len))
> > > >  =09=09=09=09return -EFAULT;
> > > > +=09=09=09if (!namelen) {
> > > > +=09=09=09=09dprintk("%s: namelen should not be zero", __func__);
> > > > +=09=09=09=09return -EINVAL;
> > > > +=09=09=09}
> > > >  =09=09=09name.data =3D memdup_user(&ci->cc_name.cn_id, namelen);
> >
> > Don't you also want an upper bound sanity check?
> > (or is cn_len only 8 bit?)
>=20
> Yeah, actually it should probably be checking for namelen >
> NFS4_OPAQUE_LIMIT.

I suspect memdup_user() itself should have a third 'maxlen' argument.
And probably one that is required to be a compile-time constant.

Oh, and is dprintk() rate-limited?
Not that the message looks very helpful.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


