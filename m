Return-Path: <linux-nfs+bounces-22062-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGKNCjW+GGoumwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22062-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:14:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780955FAD7C
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A50309E970
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E314A98;
	Thu, 28 May 2026 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k54iZCOI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B1367297
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006311; cv=pass; b=mIU/1p6ULG9Rolb7x9T8P7LkvHKbrSsgMwL3eKdte/kns6Dg0sMmqhPvx91ztTbi+SZNEl0IUA8mIoJchjVR4ub11qmHeDzaiFYgIIFVPkJzUsxMXJrJxXoxHdO3TFUEXviHHvs82/kI7b4/m1bQCahnBjXXxbEn6Hrq7E/6urw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006311; c=relaxed/simple;
	bh=Waq/q4WAgK2b1by/Ix28SSG66qgLx5KHlzodzTitIEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jww+LcWWz0nh4vijElUbTbQZePK3/LJbQ607caTZDwVI++uSuiOL3NbH2VBg8CFmdVJnvVmUapblNoQlX0t1QwL0OwhfC0mcYUT4xYROciCltM/dPJNSb0b8bNxwXG1PoVCQGBi2bpN2sW/2KEgWh23m4uvobhcUhDZt8KVt5yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k54iZCOI; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68b2229b48eso1755285a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 15:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780006308; cv=none;
        d=google.com; s=arc-20240605;
        b=glGzK0VB5CP04b4MJgV2DhtxZLxKz8JqAv9CPbSUi/+ceAMgX3Lw3OKZPJhC6Vtfg/
         7KpfuSDowg6kowawm6kM7oDe97lo+NsEdm1fDYoLmCk3rZ3te0EVqBElbzOrtxVNmOfE
         SqVnkYWVd44skYu1xwS7IqdOmFMDmNGCkYlf/2slVPx5T1sD2S/P7mBNKXuUHUjeRe2s
         ZVpzUxHqTBv1Jd6g72OwXfXKJGvz10KMgaQ485Ld2LqKdxZpzQRj5kwpaUzAPcvIhhSY
         k6DcEO2Q6FD3/cajspRKUy1fC+r6BFS8uycLyvHzZvHIC92vv+2Uv7bwmHEY37yYDnzW
         Kg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y64b9TPU+pG6hfyReL5O787YeVg5CpxfvXEJQobDNBM=;
        fh=I4Yni95N5DvWxDiFvUVchrQjkXPP1UYgO/JhK/tX8GM=;
        b=J2wPP6xtNoIJH3Rf82xEDa9Lg6WuZw3BAvQms47ukVVENMv0QWoaesIHZ2EL3PTbr0
         ERfjuOynuP2eP71VsRa+GPHvTXU1ipkp8gjgNkJUp/anKXcAE5M6wVAw0qXa26W520AD
         pMBVMirYMNerfnzmLbFrr2MuhMNaJE8MRp1FHpCtD5g+1hsWM3ks7mvkowQV1DOVNjkR
         aXDCzJ6xxKFZ0LpVBoW/vCcQMVJ2uI8Tg07rQrs5NvY5iRY24TBFwURxlrkak3SfjuRR
         +H/AwRf8TmDAQzxsbUbeJ1u3FNLforUeS87vKpp1kMynw7GKp891CMZMbmfVvTNmbx+m
         1jrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780006308; x=1780611108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y64b9TPU+pG6hfyReL5O787YeVg5CpxfvXEJQobDNBM=;
        b=k54iZCOI+dlbYH2OyHFSbxg/ItUudVT0R2uNXNnTIujRIxTs97nX6I04qt1HS4Gxvq
         3xwp9VXTiXQyFxeaToTDa4/B/v+KsJR+hBBqKYK4LQBzMmO8fq0W0iED6SsLD7UsIO5x
         HgFGvYTrPupvglcaozXpsOIkzz70TudPWCkyXexDY5buPPVKp3lYhtDtsaedqoMhHM8t
         xdgi+u5N4G1pXLlQWk04uyhnF8P8lN2lKHyv488E2Y6lDd3VW2GGL2bH4IliMazOzmd6
         Zl+Dc8m85dkpZT7NFxQZXeFHEj/n6z7tqKJ2YJMNxzmVUCr8Q9sW7znLAUN+bZBoyYaP
         U+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780006308; x=1780611108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y64b9TPU+pG6hfyReL5O787YeVg5CpxfvXEJQobDNBM=;
        b=pP3BUYWmyaFrrDw5blT3O8QZIi5VgBcz/3lRBTZUHvdWZ9V/IZfettLLz8H3aedJmp
         e4UAH1SuzC4DOzUW7/peXU/eFapOyldAcBschVcFMXiD9DJlzE42cZ3EuOU2nnvi7BsY
         z+b0cLC8XN/2XSKTMhV6DMelnsy1QkWu8h/rjjHOe8Yu71o11WGmCzPCGsgsnM1tULZC
         Ge8hh4EF9ax1qSY7qnj79A3Ww3XdMJmtI2e4v2/NlGJi5RrKkIzD+mGAPkgMzPpgwW/e
         Wy5h2CelZaoIHcfb+fGKvJci7Vyj/TXdUHgaINX9svBovl6AVtcZsxxKQ9Dk6kM9IJBS
         t0uA==
X-Forwarded-Encrypted: i=1; AFNElJ9Y3bk/lSGyCRqIl64w0CI3y815RHhqKLPXe8Flgee4ucGOmhlvPlmlcmSyIQ+PRTiRfK8vWJmbuZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz660WesPECb//wS7Wr6MaGXlepBgy8ll/zCnIGH6rRRz3aKrrZ
	1VE9ZlAkZaJelzcBlpAJo6iwJ+5Hv51jqRz2a4ykOQMMnMP92qLqyFlQ8V9qP7Wt1dDJt5oYddZ
	PJNDFn6A/dFUBlqhvO+xFL3c+KsdLsA==
X-Gm-Gg: Acq92OGkBjkmRmyDxIo4HwFp0fvTziIbQg+jM2P5OsUetsyXA9Xmtkh3s5vYK6ojxTO
	is5/qGJTepkfpIlJw2QtUoHKn9V2qxr02mwaS45wBAE/eNbdF+aKBRSgHLFY2V5vRNFJ8ZwvOev
	sSCdOnOBUUw97SH7GrRzJKJD6JEP+VTRlZQZ0WRQidQ1nuwVSGKvupSCA1D0rNwl0Q9NOEtZrEH
	OlOqnWwrU635Poh4Ks0uZqzyp5FfyMsCKUqhbPK+tY25JKCGtNTmViqp41ibXLOD2fklbNz5DAO
	1+pMAQZd89rakpeNOEQDCeJvcMaUARcA2nfw/ZNp8lEhjQo3OA==
X-Received: by 2002:a05:6402:40c5:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-68c11067377mr33691a12.4.1780006308002; Thu, 28 May 2026
 15:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org> <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 28 May 2026 15:11:35 -0700
X-Gm-Features: AVHnY4Lbwdzqwlt08lzqkvusST2UOxk56g2nR4DTwa0MUqGV4xq3-56ZUni36Vs
Message-ID: <CAM5tNy7sSXFUWFVkKEYVt9nLPOCT_-+7KfgZeoZ2UCv_eLMvrQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>, 
	Trond Myklebust <Trond.Myklebust@netapp.com>, Andreas Gruenbacher <agruen@suse.de>, 
	Mike Snitzer <snitzer@kernel.org>, Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22062-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,uoguelph.ca:email,meta.com:email]
X-Rspamd-Queue-Id: 780955FAD7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If you are unsure, forward the message to ITHelp@=
uoguelph.ca for review.
>
>
> From: Chris Mason <clm@meta.com>
>
> nfsd4_decode_posixacl() reads a u32 entry count off the wire and passes
> it straight to posix_acl_alloc() and sort_pacl_range(). The latter is
> an O(n^2) bubble sort, so a client-chosen count drives unbounded CPU in
> the server's compound processing path.
>
>     nfsd4_decode_posixacl()
>       xdr_stream_decode_u32(&count)       /* uncapped u32 */
>       posix_acl_alloc(count, GFP_KERNEL)
>       sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */
>
> The encoder side in the same file already rejects ACLs whose a_count
> exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
> 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
> omitted the symmetric check.
My recollection is that Chuck didn't like this limit. He argued that it was
specific to the NFSv3 ACL protocol and that the limit on the size of a NFSv=
4
RPC message was sufficient.  I, personally, think that 1024 is a reasonable
limit for # of ACEs, but Chuck can jump in here if he doesn't agree.
(Note that, if user/groups are configured as "#s in the string", a lot of A=
CEs
fits in a 4Mbyte RPC message and the server file system will also set a lim=
it
although, as you note, that happens after the sort.)

The good news w.r.t. the sort is that they are normally already sorted,
so the bubble sort is normally just a single pass, I think?

rick

>
> Fix by rejecting a wire count greater than NFS_ACL_MAX_ENTRIES with
> nfserr_resource, before any allocation, so the sort is bounded by
> NFS_ACL_MAX_ENTRIES^2 comparisons.
>
> Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs=
")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c6c50c376b23..5469c6c207ba 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp=
, struct posix_acl **acl)
>
>         if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
>                 return nfserr_bad_xdr;
> +       if (count > NFS_ACL_MAX_ENTRIES)
> +               return nfserr_resource;
>
>         *acl =3D posix_acl_alloc(count, GFP_KERNEL);
>         if (*acl =3D=3D NULL)
>
> --
> 2.54.0
>

