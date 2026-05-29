Return-Path: <linux-nfs+bounces-22066-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOu2DwVCGWqOuAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22066-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 09:36:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE35FE9C0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 09:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20D9F31039C6
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFC347FE1;
	Fri, 29 May 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djUmP6FX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0C3A9631
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040080; cv=pass; b=fJVPzlh/yvARjMpVZrm7OpPHQgwN88cCLpvyBlsJZPXveJkc9vpOPxUOzL7VMlUPiJ5xGN23iWuqKjK0myFIh58bzCAPay3fnhIm8j/laY4ad0iNpEY7a8y176feiING0BKPdugJNR6sBitpgO7iAxrZTm7I8GcTpT06ELPvLT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040080; c=relaxed/simple;
	bh=iqbERD1qDn701fP14U0gg097P11Npl6sbKfJB8dvdVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYJXSmK+TyUZkdvMXrpWZ960PVractqYo+IrgJx+O8oDS3gCIrUy/864R5rB6fZQrkskGoL0hVOQ4wRpvg4Hwm4Q9aY8M2UZw3zFkpFxLpkXpoHjjo4G5oombqGbbPZguIgfclTx2SAof+GntZhzIm0ILmsWPPOzWHfj9OmAm88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djUmP6FX; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7df05fc49e5so13238458a34.3
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 00:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780040078; cv=none;
        d=google.com; s=arc-20240605;
        b=NCKMQWtTYR7+q6a+T8LGw6nLO86UrBbzpd1Yr79Y31hpkaj2QA7R9nphgSGohytICw
         pG/TQr7IT4xgnn/fTVDxD/M1NMKy1mZN6DkQn+23LoPhS54duBLIHN6VFjuFTHE4xwLS
         ZXhpGXEYMhNzy4zqADO+EWq54EdUkSWbOMMVmQmcPyjiRh6Ah+dVH30bBGw39U/hsZmo
         /uOEhH8RTkW9FCcxroP+EtXFoi57iK1XIZhhMpSqxP6/AzBmMHc4mASg+94Nmlo/skGG
         wfi3SmRKW93hShKS4pnM4PbmpZy5w0eUJu8xlt0NkN9sy6yG6T8Xv9c1MrfYAARYhEBp
         zc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QUUKoKrhIsHsdL0gbnVbgoS5mWDMy1KMdICVnaii6zI=;
        fh=it34fDbur8wVw3xhs3dzDa6YSSx8Rrr6D+eUYquv5W0=;
        b=B9jv2zdqjtl8By6EuqvrCphouozkXhg0e6c+zDzwDXAxw94TYEo4GVeY+TjOS4vmgP
         uBU5KcnvSVnu+9732IzGVpR7PAzjHJvcLL1J6FPq6gfH6wJgqFSGUvZBqGAyrTwG9MNK
         5lEOLDWi/MbsY0i4wnnuyVu60iMXr9xLVb5HaiBZhO+EK8Sy1KyUcAW1oRUrYN2UPY8n
         jHs8l3PHvh7bWfvZkFbAMCMLVUeGc1bKNEjhmZqpG3uj0mHi5J9PPTzOWc8Xm3Lj747b
         Kaqk7CZDQvx1vsDhBhaoPV9AOkGbKdelEn/TP472cZrWE/WfZm46fpo0QCBh35vpdU1N
         mKKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780040078; x=1780644878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QUUKoKrhIsHsdL0gbnVbgoS5mWDMy1KMdICVnaii6zI=;
        b=djUmP6FX4fR+6iUCyebKWR1zI2U+PPIwrb7Ptfb7p5YgP7jMSEjfu6eUVdEHaLqQVs
         Wms0UZGGQIDjtr2PhwnXnoMveCmfVhAl9bWUEyOEyuZDgnFYrHs8TKNYzVyrwIs9dJiw
         MuRs9kWpaNG4o2Ssd4qSKAD4uvhw/UPwetIDwKBSA6/LXR90czggxcRkvohIbAXAR82g
         kRBQRimI3Ie4F++EM7K2+tQdtWhvtCcgYu3lyQotMjiNTVPE6SRIRXiacF9Tkk3/EhZ9
         /tr5JU3xTVW3HHGqYcMjjrAA8RCga5avInn+U1EFI/PowJCNey9zWtbo5erXWSwFkMEt
         rYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040078; x=1780644878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUUKoKrhIsHsdL0gbnVbgoS5mWDMy1KMdICVnaii6zI=;
        b=q1XlX1toPm4M6b6oJq5YLeTUVAAqOA33Nn+c8zbqnf4D30v77DXGJTD8qrDRLkYjiD
         tmMj7w778s/VQMj56nBmFexfOVEV80rCcqWDfQ8/EmOElVB01fO5oqTXbSeUumW97Vc3
         zeMvuweCAW1wx9ZROtRWwK6CKFqIlIKX7/D7u0kXbhM23kgfvjGqywggnI/mj2u0j/oY
         UmRG4NKopVv/7FcbyVt1ulD4qmF3ReR68kgf9me4J7gsZ4ICjNC1EsE+q2EzpzsCCf2q
         +o6V2pVRYaMJ4q0DAcxh40g+4O204cYevz4UoMQr/5wwjEBmu5YUSSTjCigBx9Qficb+
         rlqA==
X-Forwarded-Encrypted: i=1; AFNElJ/1UkQObLyu1W/G6TqrxCOMykSRXB/dXnT5h3s/gZkVntl3s/pQmDpLC7aPmmppjqkEuwuNEA06el4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlH1/bBFgEkMm31rtyyZBavuX163T1xKoK7+5twWtr1z7QjCb
	S7tX9tizH0JOBpf5QEZioKvoeK2bpCmnMV+mMVNyEnz0wPBXWjAu9McP8dZAMTsP1iPAPoD3Pfp
	sjDBDCgpk2MAMAceyj+WnddzRw/NwNvc=
X-Gm-Gg: Acq92OGdBJOvAftj5cfoZi5IH4FcWFMETYAiB6F0q08cisKgsG6cTO+gjdjF7D3895q
	wn+cnvQa5dFWGEWgPh3Oi9Yn9wzC0QhaJdWKMtBqtqckv1+g8FeLe7i+kzBGngXfJdJQoDIKKKq
	l32jY0ivaTlONpnq2Zp9j2ivmCT+rYkNahGFf40QJByJgUV/iPfIplyaNQV36aDDj1ZQK+EYZSb
	ujHCDitb210bluPs+KvG0JPNLXdI1jUIEp3/utxBMwMJb06akJauokaf+6eGRONLe1dZBlKSeRv
	Kmt2K3nvAl0s2djabPE=
X-Received: by 2002:a05:6820:f00d:b0:69b:408a:6abe with SMTP id
 006d021491bc7-69e03eb53e6mr940084eaf.2.1780040078124; Fri, 29 May 2026
 00:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org> <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 29 May 2026 09:34:01 +0200
X-Gm-Features: AVHnY4L9U-NE4Gay97HQ4O-4k1R3wcDlBEkBIBEe0xph8EFvZUH34wowDKCNLYo
Message-ID: <CALXu0Ud0WUrpGE-2JNNid7UUCA9N5m4zCakc7oEreF6UcAQKRQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>, 
	Trond Myklebust <Trond.Myklebust@netapp.com>, Andreas Gruenbacher <agruen@suse.de>, 
	Mike Snitzer <snitzer@kernel.org>, Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22066-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email]
X-Rspamd-Queue-Id: AFAE35FE9C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

What about (finally) getting rid of the bubble sort?

Ced

On Fri, 29 May 2026 at 00:02, Jeff Layton <jlayton@kernel.org> wrote:
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
>
> Fix by rejecting a wire count greater than NFS_ACL_MAX_ENTRIES with
> nfserr_resource, before any allocation, so the sort is bounded by
> NFS_ACL_MAX_ENTRIES^2 comparisons.
>
> Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
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
> @@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
>
>         if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
>                 return nfserr_bad_xdr;
> +       if (count > NFS_ACL_MAX_ENTRIES)
> +               return nfserr_resource;
>
>         *acl = posix_acl_alloc(count, GFP_KERNEL);
>         if (*acl == NULL)
>
> --
> 2.54.0
>
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

