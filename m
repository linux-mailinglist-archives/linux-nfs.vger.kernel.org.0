Return-Path: <linux-nfs+bounces-13369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A5B17B05
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 03:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFF67A2F44
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F03398A;
	Fri,  1 Aug 2025 01:53:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7E1C683
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754013217; cv=none; b=FlEUfzH9XwrpIx+XHMSIZ9ADIFSuoIcWjCGtW9atyWk4N5hiJsXc1KuWhlwln+xsdrCIrv9ISY6sZB3WLWIEO/i8HA4jUQavXGVz1FKve39Umw4Pvra/V4I++hfTYa+kvLHSL2PwJthUZfe3MmxMFZIv9EIcl5wZUCnZAIO8pDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754013217; c=relaxed/simple;
	bh=A9GvQ5AhRinE8Gnq4Q3sKunYZV9bMwCyTflINl6MqO4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=J0Yq6t7hjbIQ8tyUYvx35PAa9v15AhQQTJ3a0T4g582pepLoxK8GM51V6J+yHEzBRFHqekA8GmCoHyA7VsKpiM07V9M82DQ0FtXz2R5sJC1/WrXyQHzxDFTBw1W4jCjibJPi0PRnwKVFmGWRspOcgGe8dYx7Gd4cJkm6bX/JrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uhexe-0047aC-81;
	Fri, 01 Aug 2025 01:53:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: decouple the xprtsec policy check from check_nfsd_access()
In-reply-to: <20250731211441.1908508-1-smayhew@redhat.com>
References: <20250731211441.1908508-1-smayhew@redhat.com>
Date: Fri, 01 Aug 2025 11:53:30 +1000
Message-id: <175401321100.2234665.13415689481244211003@noble.neil.brown.name>

On Fri, 01 Aug 2025, Scott Mayhew wrote:
> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=3Dnone' an export that had been exported with
> 'xprtsec=3Dtls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mounts.  Attempting
> to do anything futher with the mount would be met with NFS3ERR_ACCES.
>=20
> This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> NLM under XPRTSEC policies").
>=20
> Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> so they shouldn't be conflated when determining whether the access
> checks can be bypassed.

Clearly delineating the two makes a lot of sense - thanks for doing this.

>=20
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/export.c   | 60 ++++++++++++++++++++++++++++++++++++----------
>  fs/nfsd/export.h   |  1 +
>  fs/nfsd/nfs4proc.c |  6 ++++-
>  fs/nfsd/nfs4xdr.c  |  3 +++
>  fs/nfsd/nfsfh.c    |  8 +++++++
>  fs/nfsd/vfs.c      |  3 +++
>  6 files changed, 67 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..bc54b01bb516 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1082,19 +1082,27 @@ static struct svc_export *exp_find(struct cache_det=
ail *cd,
>  }
> =20
>  /**
> - * check_nfsd_access - check if access to export is allowed.
> + * check_xprtsec_policy - check if access to export is permitted by the
> + * 			  xprtsec policy
>   * @exp: svc_export that is being accessed.
>   * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> - * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * This logic should not be combined with check_nfsd_access, as the rules
> + * for bypassing GSS are not the same as for bypassing the xprtsec policy
> + * check:
> + * 	- NFSv3 FSINFO and GETATTR can bypass the GSS for the root dentry,
> + * 	  but that doesn't mean they can bypass the xprtsec poolicy check
> + * 	- NLM can bypass the GSS check on exports exported with the
> + * 	  NFSEXP_NOAUTHNLM flag
> + * 	- NLM can always bypass the xprtsec policy check since TLS isn't
> + * 	  implemented for the sidecar protocols

Despite this detailed difference, of the 4 times that
check_xprtsec_policy() and check_nfsd_access() are called, three times
they are simply called one after the other and the other time you got
the logic wrong :-) (as you subsequently noted).

So I wonder if, having pulled them apart, they could be recombined to
maintain the simplicity but add clarity.
It would be good if the code made it abundantly clear how and why that
fourth case (in __fh_verify) is different from the other three.

Looking forward to v2
Thanks,
NeilBrown

