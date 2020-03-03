Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDB176942
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 01:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCCAWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Mar 2020 19:22:54 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35732 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCAWx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Mar 2020 19:22:53 -0500
Received: by mail-yw1-f67.google.com with SMTP id a132so1771910ywb.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2020 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b7OTDmpEcOt76LhEIzgR7RoxYjYjGGORJ6xrrJNv4B8=;
        b=nCGhFRWT9tWbyUxLM5sq0SLkt/AcfkNAHOu1HdwbM1yZN5d9HDr/1XwlMTBXLnHZxM
         V18NUYcxoABJruOc42nUFr1J1UuJVjAHZ69LtPKQm91KEYLElmlCCMX6Ww1yNFYpFm2d
         VpicXnpD8/M+K+aWrLX0HSWqnDZGCyuA97EKn5eSKyA5U6fZ1+vdVfU0gak2w2Ta+jH5
         5z0eKPHUAK3BMD+vo//0mLk3y+xmnfWv1BmCG+PEQxCtoE7PNLbQVsFpL6XNIAI8AjCM
         heMGNNZgs2ifHTD+8W9DVVb6OX3Qi8R3ylbyrnp9IIUEvm4kHGs8O9rjYQokhmBYTPJR
         iY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b7OTDmpEcOt76LhEIzgR7RoxYjYjGGORJ6xrrJNv4B8=;
        b=NZaszbFvgf8mFAzu4PAyXuYguiL3ygK36SsDPi7An1kmiQF5bAsi4yvHa+umQzJRZO
         9xdh2TaCLkpom1rw03OWFl8i9mOOWLikt8syYk5R4zH56dNYwEU5m8lmL/vfZtEjNDNN
         vS+AUJK6P1136dRjA5yh7ZP8yrEjn3E1wPepV6iXDp466BzEPfZBYt+kVQo2T7wdarqT
         lA5nNanuyOxeCQFlZVadEqjlPoQXjU5o7aVov1s9LnhGxVT3AEIH7iT+zAIWtBEQg6No
         B8/jc2zq0Czdfz+mTQeW/Ch11snePoA3cfNLQblW9jfK1jCQGTEto6IQChlBnZfDRaA3
         H7xg==
X-Gm-Message-State: ANhLgQ1nRei3cai7QsoBF7sYWfvbhRpKhH80ukH7XcA2EJYX6rwmvQP2
        YgWoXvZvk7G80VpHgf/3ivQ=
X-Google-Smtp-Source: ADFU+vtGFthOTwIrkKijMnjqsTRy0zPV9rGdEz16LynlJPYFPf9pu+gMAwP577EPY0ruqKLiBFHiUw==
X-Received: by 2002:a25:3b50:: with SMTP id i77mr1592064yba.523.1583194972832;
        Mon, 02 Mar 2020 16:22:52 -0800 (PST)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l12sm4028941ywh.50.2020.03.02.16.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 16:22:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/8] nfsd: Add tracing to nfsd_set_fh_dentry()
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
Date:   Mon, 2 Mar 2020 19:22:51 -0500
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08ED0A31-365E-4F40-B041-4E30326FD8B1@gmail.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 1, 2020, at 6:21 PM, Trond Myklebust <trondmy@gmail.com> wrote:
>=20
> Add tracing to allow us to figure out where any stale filehandle =
issues
> may be originating from.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfsfh.c | 13 ++++++++++---
> fs/nfsd/trace.h | 30 ++++++++++++++++++++++++++++++
> 2 files changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index b319080288c3..37bc8f5f4514 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -14,6 +14,7 @@
> #include "nfsd.h"
> #include "vfs.h"
> #include "auth.h"
> +#include "trace.h"
>=20
> #define NFSDDBG_FACILITY		NFSDDBG_FH
>=20
> @@ -209,11 +210,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct svc_fh *fhp)
> 	}
>=20
> 	error =3D nfserr_stale;
> -	if (PTR_ERR(exp) =3D=3D -ENOENT)
> -		return error;
> +	if (IS_ERR(exp)) {
> +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, =
PTR_ERR(exp));
> +
> +		if (PTR_ERR(exp) =3D=3D -ENOENT)
> +			return error;
>=20
> -	if (IS_ERR(exp))
> 		return nfserrno(PTR_ERR(exp));
> +	}
>=20
> 	if (exp->ex_flags & NFSEXP_NOSUBTREECHECK) {
> 		/* Elevate privileges so that the lack of 'r' or 'x'
> @@ -267,6 +271,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst =
*rqstp, struct svc_fh *fhp)
> 		dentry =3D exportfs_decode_fh(exp->ex_path.mnt, fid,
> 				data_left, fileid_type,
> 				nfsd_acceptable, exp);
> +		if (IS_ERR_OR_NULL(dentry))
> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> +					dentry ?  PTR_ERR(dentry) : =
-ESTALE);

If you'll be respinning this series, a handful of nits:

- the line above has a double space
- the trace point names here are a little long, will result in
  hard-to-read formatting in the trace log
- checkpatch.pl complains about a couple of the later patches,
  where one arm of an "if" statement has braces but the other
  does not


> 	}
> 	if (dentry =3D=3D NULL)
> 		goto out;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 06dd0d337049..9abd1591a841 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -50,6 +50,36 @@ TRACE_EVENT(nfsd_compound_status,
> 		__get_str(name), __entry->status)
> )
>=20
> +DECLARE_EVENT_CLASS(nfsd_fh_err_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh	*fhp,
> +		 int		status),
> +	TP_ARGS(rqstp, fhp, status),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +		__field(int, status)
> +	),
> +	TP_fast_assign(
> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->status =3D status;
> +	),
> +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x status=3D%d",
> +		  __entry->xid, __entry->fh_hash,
> +		  __entry->status)
> +)
> +
> +#define DEFINE_NFSD_FH_ERR_EVENT(name)		\
> +DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
> +	TP_PROTO(struct svc_rqst *rqstp,	\
> +		 struct svc_fh	*fhp,		\
> +		 int		status),	\
> +	TP_ARGS(rqstp, fhp, status))
> +
> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
> +
> DECLARE_EVENT_CLASS(nfsd_io_class,
> 	TP_PROTO(struct svc_rqst *rqstp,
> 		 struct svc_fh	*fhp,
> --=20
> 2.24.1
>=20

--
Chuck Lever
chucklever@gmail.com



