Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F467A02DB
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjINLmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjINLmO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 07:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E16E9B
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694691683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJrmtIdyNgkWRQXMOwgX0SfKmYd1et+026FQ2JOXjug=;
        b=erdwFPabueE7RpV/z0Gd/VnA/QvSRV8dPQNs3i7qQwl0Q4yAhtMZE7y0MBqVghMJBP2OvC
        N/k9ADmVWn5wxOmoboyo4p/n53z3hjxnwx3pA7pOmgnAzw9oTf1/Buan9HzhBQGDghCMMN
        bCVlF5iM1QPnEWFQXEdfUxLkfEeJchk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aHcfpbdqO0y3MagNU3mQZA-1; Thu, 14 Sep 2023 07:41:21 -0400
X-MC-Unique: aHcfpbdqO0y3MagNU3mQZA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31ad607d383so512177f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 04:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691680; x=1695296480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJrmtIdyNgkWRQXMOwgX0SfKmYd1et+026FQ2JOXjug=;
        b=Tat033h+6c0QHbjChS9ZZDhhS/c3XweXkINw0IdQp4s1ulsOBfwwsSFRjl7/hzW3RD
         OvuVfWP/hKKSthr7oG603woGpM9ljdcYAv30MhQ+C7F/9QvobBNGmRSi4/52eawYe+ai
         SbqGQi0Z7kx3uNlRSNgZjdVDr9Yf261bWNp0i38n1ASCQlZsTKyu4s8ZBmq2Sfly0/eB
         xjhLzmKr0I4q8gYYMzT/oDaKvtv10ISK5Ie7XWAOFB2u2zwUuaW27uOQwxGYbjiQ86Pi
         2+rXY6+vyesauhcgh8LRfv8vxOSmH63z6PxbeSTwnq3E5SbsACcF9wmagFxGD67c09YO
         AUqg==
X-Gm-Message-State: AOJu0YwmP6gsCmrFPWDu61GhoD7yMRJMOdy7Jq5PpP+3hKMZIKw5Ak/9
        J8KFVUziDgUP9AB2luVy8brAiKSOTZveLEk0Wv8KUldJjAJ0YB/n7ITZGk4hBhzT9ZFAmZSxcan
        U7xDKBmatUwMvw5BRLuS5
X-Received: by 2002:adf:eb49:0:b0:319:867e:97cb with SMTP id u9-20020adfeb49000000b00319867e97cbmr3675545wrn.42.1694691680762;
        Thu, 14 Sep 2023 04:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaHKMq9aoOQqmOMxQMNoWGmNMavsseBP1aoCVtRAlGdHS/Vtcmut69buWcGxBAfD0lx6OwPQ==
X-Received: by 2002:adf:eb49:0:b0:319:867e:97cb with SMTP id u9-20020adfeb49000000b00319867e97cbmr3675532wrn.42.1694691680427;
        Thu, 14 Sep 2023 04:41:20 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0031c855d52efsm1537350wru.87.2023.09.14.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:41:19 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:41:17 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZQLxXaJN7Qh9PCpn@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20230912151340.GH401982@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4v+jESRyiFTaBAa"
Content-Disposition: inline
In-Reply-To: <20230912151340.GH401982@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--x4v+jESRyiFTaBAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> > +
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
>=20
> nit: compound

ack, I will fix it.

>=20
> > +				struct nfsd4_compoundargs *args;
> > +				int j;
> > +
> > +				args =3D rqstp->rq_argp;
> > +				genl_rqstp.opcnt =3D args->opcnt;
> > +				for (j =3D 0; j < genl_rqstp.opcnt; j++)
> > +					genl_rqstp.opnum[j] =3D
> > +						args->ops[j].opnum;
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before reporting the rqst
> > +			 * fields to the user.
> > +			 */
> > +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D
> > +			    status_counter)
> > +				continue;
> > +
> > +			ret =3D nfsd_genl_rpc_status_compose_msg(skb, cb,
> > +							       &genl_rqstp);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +	}
> > +
> > +	cb->args[0] =3D i;
> > +	cb->args[1] =3D rqstp_index;
>=20
> I'm unsure if this is possible, but if the for loop above iterates zero
> times, or for all iterations (i < cb->args[0]), then rqstp_index will
> be used uninitialised here.

ack, thx for spotting it, I will fix it.

Regards,
Lorenzo

>=20
> Flagged by Smatch.
>=20
> > +	ret =3D skb->len;
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
>=20
> ...
>=20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 11c14faa6c67..d787bd38c053 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -62,6 +62,22 @@ struct readdir_cd {
> >  	__be32			err;	/* 0, nfserr, or nfserr_eof */
> >  };
> > =20
> > +/* Maximum number of operations per session compound */
> > +#define NFSD_MAX_OPS_PER_COMPOUND	50
> > +
> > +struct nfsd_genl_rqstp {
> > +	struct sockaddr daddr;
> > +	struct sockaddr saddr;
> > +	unsigned long rq_flags;
> > +	ktime_t rq_stime;
> > +	__be32 rq_xid;
> > +	u32 rq_vers;
> > +	u32 rq_prog;
> > +	u32 rq_proc;
> > +	/* NFSv4 compund */
>=20
> nit: compound
>=20
> > +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> > +	u16 opcnt;
> > +};
> > =20
> >  extern struct svc_program	nfsd_program;
> >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_ver=
sion4;
>=20
> ...
>=20

--x4v+jESRyiFTaBAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQLxXQAKCRA6cBh0uS2t
rH4WAQCZ9aO76dxbPEDOT0LnbGtY44bJLs75LQpah1fXEtIVzwEAwdUezPCVhQf6
JlbKo+oF6sfUgv8XAV3aCME0dVJo5QQ=
=wjTQ
-----END PGP SIGNATURE-----

--x4v+jESRyiFTaBAa--

