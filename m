Return-Path: <linux-nfs+bounces-22091-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIIPFd/hGWpmzggAu9opvQ
	(envelope-from <linux-nfs+bounces-22091-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 20:58:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A831B607967
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 20:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C968300AB2E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2490332EC5;
	Fri, 29 May 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVHFQShw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E4348C46
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080973; cv=none; b=hTEYRXGZ9rh/wwuDXF4G94SGVlLoDgRpuqbtBVi5A/zeroABX31Qj5ZyVNcN0BX2wHIqqCd5A4i3GJaA00UFYs+ejytCZmE+VmRHL7rCiGmeIFtE6oELXSSiYW7Svr6h4ewHMnAjYSm67u9HrO7lUaes1wWqqplwfZHETxN6GcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080973; c=relaxed/simple;
	bh=Eq8v9BDnMGtidgHHv2Zp08P0CNMdC2PQSzOHxPXhKc8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B8BAqW8bdUqcRC3pUt98rqgSm1yCUgsB7ri+2d1hDxFK+eOKWBeyWarOa/xmqAN6J/MjSCNzgyJYjynkUYpR8+FooBFgOgmNmm2VWy7UuRA4uRY/jO/9WO1cbEOJVKT/3neWQF8KCIaVhUSw95D55o1Tu+aNpZSyNWHlVPjPGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVHFQShw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245C41F00893;
	Fri, 29 May 2026 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780080972;
	bh=b/kHUiS6zeUE21ZmSwB4Q/Ldq/1CI77vJ/9Gui7oWgs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mVHFQShwSy1Dbn6kR/P83SjXIDffrUvu7o809MAGK+lIYSF5gN+g9PMvctFV8JtQb
	 l7v5aAHu+hm1zFOKWXDM8CoKXhKL+mGrRdLtDp0gLTE4VWluRY8YcKAPrg90P9v8An
	 ZpwzWR5X950ezhLXarM5ZK1jtMWK6eve1/HfiIP56TaXvK1MFb8LzZ5IB6kdS8DPaI
	 U1oviPBBYNB+4MM3Zy9FJj+uOTd+szfzMzrBOQICJUR0LjytS7Kaih4UqwePsermlp
	 xqi+V4A1egq61Wk1lpIn7gs1FcfTvfFhHdDG9bLnJ8owAgSFYZ0boXXeIafo2yNKOD
	 rxD8OXvpqYhDw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68140F4007D;
	Fri, 29 May 2026 14:56:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 14:56:11 -0400
X-ME-Sender: <xms:S-EZagi9e8s63_xdVuqYfD-wIZIq7-5r8vxsHEfHvHbdgorBYLjZAg>
    <xme:S-EZaj2Ac94MIhfUUa33yfVTQAxV1JSRFpdCv-MQ3sqUt7SaAif91-496EfXGrYr8
    BPvQSiRN2UEQTjgz0gdYbRqP1xSuA24bg4C3NcE4lGt4PA5V7kkLXeT>
X-ME-Proxy-Cause: dmFkZTEngVlcI/gU8TDsF8mY2Ph/TO+eQ1kh12hdK/sy0yMtz5mzuu2s2u43n4Bl8ar5Vs
    CzrUvlegFbVqHbDYUWZUKOWnVGxl7PmkVW/6fteqsdVhVMu4HEWjy47lrdQbUTQe12hHpr
    64yO3tAdrDoPw1yFEadxVbElsDUc8QvKpTTK7kHBSq5FYD8kfgk3OxTdjS4R2593np9nL1
    PAmU5K/UYC37/cYL0EwoiDbOectNa8olFEeCIQHbEu7K02Q7F8DVT1u51bnVew4vSSI/61
    HvVgIcZQTjJ+YdmyQkPKe79LTBz6yEtJxG1iTZclwsMzSto07K0x5Yx6knXRp9ARy0qsb1
    WNKWuolac/z/qZzQhM6MzrC7iwfFEYSeaR2Yt0LaKeoderSQfv2rYlbbT1ZnnLEQ2/WEVF
    2nuSih8CyBDpf1ebJRZJEB7Yh75iMkyl12/7RJ5RP+rPMH/BJql5CRr88I8g+lwvY6hLKK
    naH5h2Cfp+YWszxBBHAYrLB8ofhpa9ajTIktPT3vcscaRfWnzEiibMqHDPqnQJo7awbTfn
    9/TQ7ppXHkn4jwQUVR4l8e1GAZ0oNvw/acr/UwmoXK4MMvMkOxT2qu+1iy01cUdjsowmoy
    kfSlzqIhDh+VDmrcN1+L99/j+yViruR11axdRo3Z/aQyDSCezQFuubqZjsyw
X-ME-Proxy: <xmx:S-EZasfDeg6sUizadvEAd9fwA-ghW1KdnpAJUzCkFRo1P_qDn8dLBw>
    <xmx:S-EZatpJBZ9wtoVr7l0ATtF-nPm4kQl4L6dKXHLhr5p3nEkjb6KVnw>
    <xmx:S-EZaulSvSpu-CrrCB4w-peHT81YaTFVrae9UYJh01y4MisLCpDFRQ>
    <xmx:S-EZamQWkPufjD16XuL0IZ_OkLnwfBs27iqaNNN7fPKiXSPQ-vcdTA>
    <xmx:S-EZasbQik0R3U01SJEJDQouLt-llK_gFYsPJxjatGEE7akfG1kZ632e>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D59678008F; Fri, 29 May 2026 14:56:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-9Yz8QMcdKk
Date: Fri, 29 May 2026 14:55:51 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <bce151c1-2575-4ab2-be20-9f022c7a2be0@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-10-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-10-e78708eff77d@kernel.org>
Subject: Re: [PATCH 10/10] nfsd: validate symlink target length in NFSv4 CREATE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22091-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A831B607967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> nfsd4_decode_create() accepts an unbounded cr_datalen from the wire for
> NF4LNK symlink targets, allowing a client to force a kmalloc of up to
> the RPC-max size (~1 MiB) per COMPOUND op that persists until compound
> teardown.  The VFS rejects oversized targets with ENAMETOOLONG, but the
> allocation has already occurred.
>
> Reject cr_datalen == 0 or cr_datalen >= PATH_MAX early with
> nfserr_nametoolong to bound the allocation.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4xdr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5469c6c207ba..1f5e49f50f3a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -957,6 +957,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs 
> *argp, union nfsd4_op_u *u)
>  	case NF4LNK:
>  		if (xdr_stream_decode_u32(argp->xdr, &create->cr_datalen) < 0)
>  			return nfserr_bad_xdr;
> +		if (create->cr_datalen == 0)
> +			return nfserr_inval;
> +		if (create->cr_datalen >= PATH_MAX)
> +			return nfserr_nametoolong;

Nit: The protocol already has NFS4_MAXPATHLEN defined to PATH_MAX.
The v3 decoder uses its analog NFS3_MAXPATHLEN. Using
NFS4_MAXPATHLEN here expresses the protocol-layer intent and
matches the cross-version idiom.

The new boundary condition differs from v2/v3. v3 uses
"tlen > NFS3_MAXPATHLEN", accepting a target of exactly PATH_MAX
bytes; this uses ">= PATH_MAX", rejecting it. Switching to 
"> NFS4_MAXPATHLEN" both adopts the named constant and realigns
the maximum accepted length with v2/v3.


>  		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
>  		if (!p)
>  			return nfserr_bad_xdr;
>
> -- 
> 2.54.0

-- 
Chuck Lever

