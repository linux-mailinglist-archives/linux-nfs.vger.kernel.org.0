Return-Path: <linux-nfs+bounces-2209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84B287202B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 14:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F177284947
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA985C7F;
	Tue,  5 Mar 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEcnPlUQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39485C51
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645411; cv=none; b=NKDk9eTxX7Hw7ZtppmO2jWp6XPZT1stW5xko8CsHbiM3QKtMKfiO68pGR6MbwCGxs6/ot5m/DuFd3jKverbAIwSbNIBa8jw3UGkD9zpX2zC3YA6WUcUzi7dpYGI+zlQxTR5r8nf8dXpq4Vn8cB8x+z7RluIDjEC8vf1N84anL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645411; c=relaxed/simple;
	bh=YrjSyeQUXYkRk8XxWKXli9TKvNCZ/U51RxeVgiM98Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6Y6xBZzG5JTWbtirvWZLfUZDOzyXxJn3RfeW8sn/ylMMTt6KiWIQ/YapcDwNzs2PkQ+dkm8lubWs6EeQIcXPIep+dq/bdmNYBr833Gjwb8FZmQGGoT8DiPt7gsmc0krO0xkjiq5vQbgx7001ug4fEwHGncf+zRixIpFmNKYkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEcnPlUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGJqFn+toj4aT/J/blQH5Jo+sL9ZtY9Erk2oyouRZ/I=;
	b=fEcnPlUQknaqbW/+hWAnlacWTQzQKJQOUEiF1wqxIMkn5hc7KUjRau+1C5k8bciq5mkfZ3
	tda4/ppS7QggAMmggq+a0VCFJ+RqMGEeypVbrWn6KM90Lf6ZU/YGi/7w+SNP3UUzaNebqH
	4NoE7TFwXE4jCipSFWGWsBPbialS934=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-bcZtt7hbOGKmkkCWuoUM8Q-1; Tue, 05 Mar 2024 08:30:04 -0500
X-MC-Unique: bcZtt7hbOGKmkkCWuoUM8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75CC980F7EA;
	Tue,  5 Mar 2024 13:30:04 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60212C04224;
	Tue,  5 Mar 2024 13:30:04 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id E03A112C436; Tue,  5 Mar 2024 08:30:03 -0500 (EST)
Date: Tue, 5 Mar 2024 08:30:03 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH 2/2] gssd: add a "backoff" feature to
 limit_krb5_enctypes()
Message-ID: <ZeceW1uO1s_GtZHj@aion>
References: <20240228222253.1080880-1-smayhew@redhat.com>
 <20240228222253.1080880-3-smayhew@redhat.com>
 <CAN-5tyHaP9OXNPJ2ZX=M7ktqLgfXZttk+zym5-DYzi6+vv_B5g@mail.gmail.com>
 <ZeYHp8BygJQDkrv1@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZeYHp8BygJQDkrv1@aion>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Re-adding the list.

On Mon, 04 Mar 2024, Scott Mayhew wrote:

> On Mon, 04 Mar 2024, Olga Kornievskaia wrote:
>=20
> > On Wed, Feb 28, 2024 at 5:23=E2=80=AFPM Scott Mayhew <smayhew@redhat.co=
m> wrote:
> > >
> > > If the NFS server reset the connection when we tried to create a GSS
> > > context with it, then there's a good chance that we used an encryption
> > > type that it didn't support.
> > >
> > > Add a one time backoff/retry mechanism, where we adjust the list of
> > > encryption types that we set via gss_set_allowable_enctypes().  We can
> > > do this easily because the list of encryption types should be ordered
> > > from highest preference to lowest.  We just need to find the first en=
try
> > > that's not one of the newer encryption types, and then use that as the
> > > start of the list.
> >=20
> > This doesn't seem like a good idea because it opens up a security
> > problem that a connection reset (by an attacker) during context
> > establishment would force the client to downgrade its security.
>=20
> I'm willing to drop this patch if that's the consensus.  Or we could
> still it behind yet another config option.
>=20
> I'd still like to see the first one get merged though.
>=20
> -Scott
> >=20
> > >
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  utils/gssd/gssd_proc.c | 15 +++++++++++++--
> > >  utils/gssd/krb5_util.c | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  utils/gssd/krb5_util.h |  2 +-
> > >  3 files changed, 53 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> > > index 7629de0b..0da54598 100644
> > > --- a/utils/gssd/gssd_proc.c
> > > +++ b/utils/gssd/gssd_proc.c
> > > @@ -337,6 +337,10 @@ create_auth_rpc_client(struct clnt_info *clp,
> > >         rpc_gss_options_req_t   req;
> > >         rpc_gss_options_ret_t   ret;
> > >         char                    mechanism[] =3D "kerberos_v5";
> > > +#endif
> > > +#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> > > +       bool                    backoff =3D false;
> > > +       struct rpc_err          err;
> > >  #endif
> > >         pthread_t tid =3D pthread_self();
> > >
> > > @@ -354,14 +358,14 @@ create_auth_rpc_client(struct clnt_info *clp,
> > >                 goto out_fail;
> > >         }
> > >
> > > -
> > >         if (authtype =3D=3D AUTHTYPE_KRB5) {
> > >  #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> > > +again:
> > >                 /*
> > >                  * Do this before creating rpc connection since we wo=
n't need
> > >                  * rpc connection if it fails!
> > >                  */
> > > -               if (limit_krb5_enctypes(&sec)) {
> > > +               if (limit_krb5_enctypes(&sec, backoff)) {
> > >                         printerr(1, "WARNING: Failed while limiting k=
rb5 "
> > >                                     "encryption types for user with u=
id %d\n",
> > >                                  uid);
> > > @@ -445,6 +449,13 @@ create_auth_rpc_client(struct clnt_info *clp,
> > >                                         goto success;
> > >                         }
> > >                 }
> > > +#endif
> > > +#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> > > +               clnt_geterr(rpc_clnt, &err);
> > > +               if (err.re_errno =3D=3D ECONNRESET && !backoff) {
> > > +                       backoff =3D true;
> > > +                       goto again;
> > > +               }
> > >  #endif
> > >                 /* Our caller should print appropriate message */
> > >                 printerr(2, "WARNING: Failed to create krb5 context f=
or "
> > > diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> > > index 57b3cf8a..5502e74e 100644
> > > --- a/utils/gssd/krb5_util.c
> > > +++ b/utils/gssd/krb5_util.c
> > > @@ -1675,7 +1675,7 @@ out:
> > >   */
> > >
> > >  int
> > > -limit_krb5_enctypes(struct rpc_gss_sec *sec)
> > > +limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff)
> > >  {
> > >         u_int maj_stat, min_stat;
> > >         krb5_enctype enctypes[] =3D { ENCTYPE_DES_CBC_CRC,
> > > @@ -1689,6 +1689,17 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
> > >         int num_set_enctypes;
> > >         krb5_enctype *set_enctypes;
> > >         int err =3D -1;
> > > +       int i, j;
> > > +       bool done =3D false;
> > > +
> > > +       if (backoff && sec->cred !=3D GSS_C_NO_CREDENTIAL) {
> > > +               printerr(2, "%s: backoff: releasing old cred\n", __fu=
nc__);
> > > +               maj_stat =3D gss_release_cred(&min_stat, &sec->cred);
> > > +               if (maj_stat !=3D GSS_S_COMPLETE) {
> > > +                       printerr(2, "%s: gss_release_cred() failed\n"=
, __func__);
> > > +                       return -1;
> > > +               }
> > > +       }
> > >
> > >         if (sec->cred =3D=3D GSS_C_NO_CREDENTIAL) {
> > >                 err =3D gssd_acquire_krb5_cred(&sec->cred);
> > > @@ -1718,6 +1729,33 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
> > >                 set_enctypes =3D krb5_enctypes;
> > >         }
> > >
> > > +       if (backoff) {
> > > +               j =3D num_set_enctypes;
> > > +               for (i =3D 0; i < j && !done; i++) {
> > > +                       switch (*set_enctypes) {
> > > +                       case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> > > +                       case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
> > > +                       case ENCTYPE_CAMELLIA128_CTS_CMAC:
> > > +                       case ENCTYPE_CAMELLIA256_CTS_CMAC:
> > > +                               printerr(2, "%s: backoff: removing en=
ctype %d\n",
> > > +                                        __func__, *set_enctypes);
> > > +                               set_enctypes++;
> > > +                               num_set_enctypes--;
> > > +                               break;
> > > +                       default:
> > > +                               done =3D true;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +               printerr(2, "%s: backoff: %d remaining enctypes\n",
> > > +                        __func__, num_set_enctypes);
> > > +               if (!num_set_enctypes) {
> > > +                       printerr(0, "%s: no remaining enctypes after =
backoff\n",
> > > +                                __func__);
> > > +                       return -1;
> > > +               }
> > > +       }
> > > +
> > >         maj_stat =3D gss_set_allowable_enctypes(&min_stat, sec->cred,
> > >                                 &krb5oid, num_set_enctypes, set_encty=
pes);
> > >
> > > diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
> > > index 40ad3233..0be0c500 100644
> > > --- a/utils/gssd/krb5_util.h
> > > +++ b/utils/gssd/krb5_util.h
> > > @@ -26,7 +26,7 @@ int gssd_k5_remove_bad_service_cred(char *srvname);
> > >
> > >  #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> > >  extern int limit_to_legacy_enctypes;
> > > -int limit_krb5_enctypes(struct rpc_gss_sec *sec);
> > > +int limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff);
> > >  int get_allowed_enctypes(void);
> > >  #endif
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >=20


