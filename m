Return-Path: <linux-nfs+bounces-22067-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EgUGtJvGWqNwggAu9opvQ
	(envelope-from <linux-nfs+bounces-22067-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 12:52:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432760124A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 12:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0277630343A4
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965A38D419;
	Fri, 29 May 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO8pLHmu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDB368D73;
	Fri, 29 May 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051737; cv=none; b=dI6It/hAPdQJlJMYrHyvLrgZcLem3cQYc5LQAWDqR7MjmwbEnferlORBZHOH3IsoDWTCD9gvLyE6/ViA8Bjdqfv1T8RGgzkcONbQtqdufrhuSO8Lhpk/b3NLiKn9sT4BYctlYQEk7sTNub4O74kJ6BSZX0XHuJrNQuP8vg73tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051737; c=relaxed/simple;
	bh=RmkBqZlu4zNY+YYMrfb1783b9PAuugPUjj0Fe6IQndg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFJGwOzYS55QEjE2YayVzbUjjwtSc4ulhKj/1t3v+GixfqW0Slm2vyD/S+/amcyeyUjqMh4yP3BOZS8J0Om3fbAmBPjHi3F5Lq/FTvC80oB8SQhiK8Aihcme/taj5Ljc5sSbFj3Rd4DR9uBKKmeNVrwx7jXXHLOKWVIrNaJnnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO8pLHmu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F3F1F00893;
	Fri, 29 May 2026 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780051735;
	bh=sjLcQVpA4qQvyyNA9Tp3iQXS/SqZ9LXAb9ArX5f6/MY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bO8pLHmusFzI+LKJ2EiyiNavEkaLXqTZLOkPE6Kc2aHOdY3aCr3EHKuCE8lnhQSxd
	 6xL+dKOgj4epOsGMI+sigsJSPleraPe+k8oqDTgRqlZrim8n3r+AMPHtVOy60XZHHq
	 LniCy7MCa9TbdhW2IoQ6KueCwHs7Gm+ZTcUJyDY5Wu8kfGx2I/NJuU3riXo6sBA6Xs
	 HNHWcUXsANSiIIzc/MCuLDeRbqlODxao5uNYxJIW01X5OzLhD7Y9MIfoka9ZZjQT1i
	 8WZitP64lqrxE0PsUYKp2GYN9jxwxxGlgCvP8nkrtoe1v+s9hDiONTjxs7o8igdil8
	 VkQx/aHpy16tg==
Message-ID: <4a35675f5627c2e1e3464cb893ff6e619e41e74b.camel@kernel.org>
Subject: Re: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort
 cost
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, Scott
 Mayhew <smayhew@redhat.com>, Trond Myklebust	 <Trond.Myklebust@netapp.com>,
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>,
 Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 06:48:52 -0400
In-Reply-To: <71e5e6b6-f2d6-48ca-bc66-32064a2e0798@app.fastmail.com>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
	 <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
	 <CAM5tNy7sSXFUWFVkKEYVt9nLPOCT_-+7KfgZeoZ2UCv_eLMvrQ@mail.gmail.com>
	 <bffd1333-a65e-40d9-9553-7de4401a55bd@app.fastmail.com>
	 <71e5e6b6-f2d6-48ca-bc66-32064a2e0798@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22067-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6432760124A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-28 at 20:07 -0400, Chuck Lever wrote:
>=20
> On Thu, May 28, 2026, at 7:11 PM, Chuck Lever wrote:
> > On Thu, May 28, 2026, at 6:11 PM, Rick Macklem wrote:
> > > On Thu, May 28, 2026 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >=20
> > > > CAUTION: This email originated from outside of the University of Gu=
elph. Do not click links or open attachments unless you recognize the sende=
r and know the content is safe. If you are unsure, forward the message to I=
THelp@uoguelph.ca for review.
> > > >=20
> > > >=20
> > > > From: Chris Mason <clm@meta.com>
> > > >=20
> > > > nfsd4_decode_posixacl() reads a u32 entry count off the wire and pa=
sses
> > > > it straight to posix_acl_alloc() and sort_pacl_range(). The latter =
is
> > > > an O(n^2) bubble sort, so a client-chosen count drives unbounded CP=
U in
> > > > the server's compound processing path.
> > > >=20
> > > >     nfsd4_decode_posixacl()
> > > >       xdr_stream_decode_u32(&count)       /* uncapped u32 */
> > > >       posix_acl_alloc(count, GFP_KERNEL)
> > > >       sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */
> > > >=20
> > > > The encoder side in the same file already rejects ACLs whose a_coun=
t
> > > > exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
> > > > 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs"=
)
> > > > omitted the symmetric check.
> > > My recollection is that Chuck didn't like this limit. He argued that =
it was
> > > specific to the NFSv3 ACL protocol and that the limit on the size of =
a NFSv4
> > > RPC message was sufficient.  I, personally, think that 1024 is a reas=
onable
> > > limit for # of ACEs, but Chuck can jump in here if he doesn't agree.
> >=20
> > The NFSACL protocol limits the number of ACEs in an ACL to NFS_ACL_MAX_=
ENTRIES
> > (1024). It=E2=80=99s a limit that is defined in the protocol itself.
> >=20
> > The NFSv4 protocol sets no similar limit. In particular, NFS_ACL_MAX_EN=
TRIES
> > is not a constant defined or used by the NFSv4.x family of protocols II=
RC.
> >=20
> > Using NFS_ACL_MAX_ENTRIES to cap the number of ACEs in NFSv4 ACLs is a
> > convenience, but it adds technical debt (slight though it may be).
> >=20
> > So=E2=80=A6 We can define an implementation limit for NFSv4 ACL support=
 in NFSD.
> > But it shouldn=E2=80=99t be called NFS_ACL_MAX_ENTRIES, IMHO. For clari=
ty of
> > documentation, pick a number (could be 1024) and state in a comment tha=
t
> > it is an NFSD implementation constraint, not a protocol limit. Name the
> > constant something like NFSD4_MAX_yada to make it clear it is an
> > implementation limit, not a protocol limit.
>=20
> A different take on this might be that we want to ensure that ACLs set
> via the NFSv4 POSIX ACL extension can always be retrieved via NFSACL.
> In that case, capping the ACE count at the same number makes sense.
> As long as the reason for this is clearly mentioned.
>=20

First, I'll note that the encoder already has this limit in place:

static __be32
nfsd4_encode_posixacl(struct xdr_stream *xdr, struct svc_rqst *rqstp,
                      struct posix_acl *acl)
{
[...]
        if (acl->a_count > NFS_ACL_MAX_ENTRIES)
                return nfserr_resource;
[...]
}

...so if you set an ACL that is longer than NFS_ACL_MAX_ENTRIES you
already can't retrieve it with NFSv4. Given that, I went with the above
suggestion, and added a comment to the patch. Seem ok?

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c6c50c376b23..eaf71c65d665 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -448,6 +448,14 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp,=
 struct posix_acl **acl)
=20
        if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
                return nfserr_bad_xdr;
+       /*
+        * RFC8881 doesn't define a max number of ACE's, but the NFSACL spe=
c
+        * does. For NFSv4, cap the number of entries to the v3 limit, as w=
e
+        * want to ensure that ACLs set via NFSv4 POSIX ACL extensions are
+        * retrievable via NFSv3.
+        */
+       if (count > NFS_ACL_MAX_ENTRIES)
+               return nfserr_resource;
=20
        *acl =3D posix_acl_alloc(count, GFP_KERNEL);
        if (*acl =3D=3D NULL)

