Return-Path: <linux-nfs+bounces-22527-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ajykFQ1LLGrDOwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22527-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:08:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2967B888
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:08:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EHUVx5E0;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22527-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22527-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED7A931A169E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5A362133;
	Fri, 12 Jun 2026 18:03:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A41D61B7;
	Fri, 12 Jun 2026 18:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287424; cv=none; b=ic5TdquvNKxWoTsFTgPvz9ZOQ9AAfjowDkromFUAA7KrdY6VTusKjqhvpr3OupzqdIEvKzeutlsJLVXkviCUpPeWTnEok4NBt1TeB82C3Qnh0tP7GUqm8NY3sCaIi3Rv1gEKGGg1qK9qulHaxZ1jcB+F3e3PAEh1P3Rhx/3FLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287424; c=relaxed/simple;
	bh=2f17SHX6NAomMZlyXQn5Y9slIzbf96vhas6eii0goXM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SSwD4dnpJ4+ekQ5dX6VJGPLnQ0JjhW/pw52YVH7UP5/lvsOYWl8vAFrrd9hjg/2te7CPK9sIEOjfVswz5zLrPE/KxnSS+d44ubxftoFaAwPcB3CLWgZkmFcOXPy5GHvMPEJTlM+Uv37BHOhEIcq7Y766PMe5zoHtxT6cOcv10Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHUVx5E0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D306F1F000E9;
	Fri, 12 Jun 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287423;
	bh=ubJNljXoaD+EMRYJ6LQZrr1LXv2R35DdH/gBfE+2Ln0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EHUVx5E0fQx3XQl/ilSf3MKElTflGeawosZSOp+5sY/NP2Ua1eFvqPqapBA/rXUbZ
	 6CFuMsL7xTOwpvziNSfOkOIaAfK0iKiZNqZY0Njw7cZYNWcJUxOIu6UuPwm4fb1yH/
	 EbZMguElqEfN3M0Y5uea2Tb4DYjz372VFqMAhxDkUgUwIGwKVeWW+qKRiKdrbTCSSO
	 ma635MyTM8qxYf/F/sqkYsyQ+s4oR1PEcvBBwaPEj+8v5a+F541Ibz9IVJjKFtZma/
	 jcn0UyIf5TGvWZR8ijGfm1X2fXUOPeF0ePCn/yZJPi1tbi9+77pEsSubsXdDySeZH2
	 VbfdBitT8PZFA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 14E55F4007F;
	Fri, 12 Jun 2026 14:03:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 14:03:42 -0400
X-ME-Sender: <xms:_UksalW_b2mAJsNLuYHhiq3yzXh0gjxK50T7zte3Y7bcSgOaCBv6pQ>
    <xme:_UksagapZT4xW4JlvHLy90TopTVGJi-m3DJaolp__Dt-QgYAiPsimZKXCMRrNBWk8
    hhfVWPcazgBRBzMzu3X48GIQbZD1bcf2OeB-2ipwTakqygWBhCcFsrE>
X-ME-Proxy-Cause: dmFkZTGhX0yz96hz/JBgUOJHCWiTUfcu3ktynrVQ0qb0TuzVWiLM8pnfh1o0SwLftn8amr
    fH9K3T7rbWRl8khM2J2EHtj6t4nw7Egv9nBeJwpRMkuGJo9A6w8QVZJzHu6Z/k79OhvJKi
    qNNSEVQ/WsYTc8dGDmxp12uInWxBSFkH4EjxUgOd6DXTdiISv7tajkR4LdpXfMirmftawj
    IWuRFN+ZKpk/1QLaZMi/Wvm80QEL8Vk43VPEA3l8ZUFVD+/U6gxg3qYACkK7VXzHWydPWv
    +HLPca82dz3OA/H0tLRDxj5DQ4RZjExeOFn7edhFM41/Qon/Aq6W27hdLVgkiFVY0e6+s6
    Xa6K4LEdzzzq8KZs87kWwTXFQpK/U/VEB0UOlYVwXyU5w2DA2KSgNif45kptXeozdNadx9
    CuooB0uvkEmSupMbxp0lBYrVeQqlKk359E6NZF3SAnWvsfbefKXlyTc6UF4lsZP8CNLzK2
    RbFPcBamfMiTTi01dFfDWKLEFQ8r93Qbq0lGJX79NwT53urhfG195JjKD9pLYfBBVADI9l
    W0upaGgDMmoMvP7W5wFO2u+SpdcZZJ19SHsn04+nt8qchRhbpZ39z1zVmjKSTHCU+WoETF
    r7Qk6Ztc4/Cz9LoiOr8LIq28zKFNp7pKoiF8kedYexEY4uJMDXFIk+aPCsXA
X-ME-Proxy: <xmx:_kksavM5nuTDSm-BNoprlq0ouzlYlwBNbL6wNkn7FdVYnD4XUX0l2w>
    <xmx:_kksau3VRCKBeY8e84InzaBfeqJf0wu0p2pp4tYk6m82-4ZtCL_FTw>
    <xmx:_kksam1MSl8ZxQD4sOeARcRfL9HKd0B69HoMXuuYHkg9zSgE7Gz7ig>
    <xmx:_kksak_HyylxxhbfHG7qenNJgipmupaMSSJ-tgUtCq2QbH4UqOUaKQ>
    <xmx:_kksaqa9vCgYK87qN1eUG_xHAqgssWzkwo45OTUrWM3SJpSKXhoy2XAu>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E53D6780070; Fri, 12 Jun 2026 14:03:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW7sfqClVshs
Date: Fri, 12 Jun 2026 14:03:21 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <84a3d934-a0ca-4b8c-b36f-8a29ee425d02@app.fastmail.com>
In-Reply-To: <20260611-dir-deleg-v6-15-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
 <20260611-dir-deleg-v6-15-4c45080e5f3f@kernel.org>
Subject: Re: [PATCH v6 15/20] nfsd: allow encoding a filehandle into fattr4 without a
 svc_fh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22527-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0B2967B888



On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
> The current fattr4 encoder requires a svc_fh in order to encode the
> filehandle. This is not available in a CB_NOTIFY callback. Add a a new
> "fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
> there from the svc_fh. CB_NOTIFY will populate it via other means.
>
> A filehandle composed this way may still need a MAC appended on signed
> exports, so generalize fh_append_mac() to operate on a bare knfsd_fh
> (plus its maximum size and net) rather than a svc_fh.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4xdr.c | 36 +++++++++++++++++++++---------------
>  fs/nfsd/nfsfh.c   | 10 +++++-----
>  fs/nfsd/nfsfh.h   |  1 +
>  3 files changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 4fb61d05a4a7..7b19248b1503 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c

> @@ -4015,19 +4016,24 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, 
> struct xdr_stream *xdr,
>  		if (err)
>  			goto out_nfserr;
>  	}
> -	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
> -	    !fhp) {
> -		tempfh = kmalloc_obj(struct svc_fh);
> -		status = nfserr_jukebox;
> -		if (!tempfh)
> -			goto out;
> -		fh_init(tempfh, NFS4_FHSIZE);
> -		status = fh_compose(tempfh, exp, dentry, NULL);
> -		if (status)
> -			goto out;
> -		args.fhp = tempfh;
> -	} else
> -		args.fhp = fhp;
> +
> +	args.fhp = fhp;
> +	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
> +		if (!args.fhp) {
> +			tempfh = kmalloc_obj(struct svc_fh);
> +			status = nfserr_jukebox;
> +			if (!tempfh)
> +				goto out;
> +			fh_init(tempfh, NFS4_FHSIZE);
> +			status = fh_compose(tempfh, exp, dentry, NULL);
> +			if (status)
> +				goto out;
> +			args.fhp = tempfh;
> +		}
> +		if (args.fhp)

Nit: here, "args.fhp" is never false.

Note that nfsd4_encode_fattr4_fsid() calls fsid_source(args->fhp)
without a NULL check. After this patch is applied, filehandle
encoding is svc_fh-free but FSID encoding is not, and the two
share the same attrmask gate:

   (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID).

No current caller trips it: the CB_NOTIFY path does not request
FSID. But a future CB_NOTIFY attrset that adds FSID would
dereference a NULL fhp.


> +			fh_copy_shallow(&args.fhandle, &args.fhp->fh_handle);
> +	}
> +
>  	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
>  			   FATTR4_WORD0_CASE_PRESERVING)) {
>  		/*


-- 
Chuck Lever

