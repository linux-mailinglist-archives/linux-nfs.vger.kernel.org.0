Return-Path: <linux-nfs+bounces-9594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9EA1BB9F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 18:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084C33AEFF8
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19889474;
	Fri, 24 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETN83OMm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC34288B1
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740741; cv=none; b=eHOpMJzSEFOy7yNkztAfTsQOC057HiLVBznfd2Mu0Kyiz4HzjIYeWVA4EGtIfdn9DFrakLLkeOBXvGfI+4u/jKKbqGwygknvIz/GqG87XmQ6CifqbuWHqLs4NwPQmV3DiITo//QPrXCzhrg799VpKsXi9txK+m+0LNSCSxzLMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740741; c=relaxed/simple;
	bh=3aj9rlgE9Q9nBIHpjrW/nronhsL1vcUV+ZyN0/hN5S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R99N1ew7NuME3MDHAzzN1RA6rlqgkOVUrto9uULXT/KzHrO5evJrp9cCrqrPYD3+PdLA+5eyZU72YuhVZcsc63KTfVojOuDee7kEU56XrpGuVWaps7a/+hxpMhonb9dg98iJg82sxvWRzBJHTZhZXo9ASk2E53/hHnO/MMiYjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETN83OMm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737740738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=145ThqO6V6qSgYUwyPYyVldLSQPpAZreGKb1L+P7TGs=;
	b=ETN83OMmjG8nU6IOROh+XueHFsjN5AdpKr28FItogYOqTMpq/41zzaw9XJKer+2u6BoLVA
	2L9WvZSAmQsZEKaYGblnSFRVEolU2DyXImf427n4dEu2xHvzhxmOpBgpt5VTMD9LFb2G/h
	/mO6Bg3VEchL9pSpjrcNmhfHdwYtJ40=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-gDKDkkfAOXO4sb1YAQizWA-1; Fri, 24 Jan 2025 12:45:36 -0500
X-MC-Unique: gDKDkkfAOXO4sb1YAQizWA-1
X-Mimecast-MFC-AGG-ID: gDKDkkfAOXO4sb1YAQizWA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab2e44dc9b8so369229066b.1
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 09:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740735; x=1738345535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=145ThqO6V6qSgYUwyPYyVldLSQPpAZreGKb1L+P7TGs=;
        b=Cr6AVng06FedHerLKphKqQuC89bfgFQ1HihQ7yf4Qr6K5NVk84eD8WC5//fDLUTuCQ
         lGliCoAWdFcl17jeXgsMayc0FAN5ELI4gs+Gi7CxV9RxcF5XjTFtdADm6BskLgT/O7pX
         1FDuvviA8GWi82G8HRtX913KMNJl9Zy2afpalgLKdht8rQJFh/Z8KGc73OKKxgUv0Tz3
         DkYm6+eGAT4w75Pqa5UDeY1milavtZ1prGQIdkLvJadZYYNZ6lMpcNjW+HKckZsBWL0x
         gqg3yA5W6aiW0SVzdmgRYlngfdw+BVECOfA3dkczEkZ9G69PXWc1S5G/fgddqo5IeSb/
         dHUA==
X-Forwarded-Encrypted: i=1; AJvYcCX57kxD4YoJ7yesNj0BTfPJ617Iwnw9JwjMg4x+uCku+1TRApipKdN9nI1id+dvNty11uoPTY54f4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlCEJi8fScdg67fk5zcb1ELUzp7eKmVK5jUd/cCgNpYHW9sY8
	+Xf4EyfB5pmoQRCQaKzfvMjL+ufyTvTgOllG4oa509cLN/SEAECRp2435tCNyIMXydfS07c82PG
	hJTUFF1SJsQUp/lW3SZnIHWrTaDNUlo9r3cmyoIyVcfAATfL3AUNqV3PH0vRgcrajyjsjyZybkB
	CmS8BnemeG+MPZuvhOmhtEFkP/Ds2m31Bi
X-Gm-Gg: ASbGncuGtRUYBHUsvu0iXbLQGopw3lLbYGqzgJ2iaHHFuhhPH+MB9CvvPqn+doU955u
	chQvVOSh4yYfwYqo5EmuIOQD15m/bi9B1GODnGt/L2iJsSvxiDTRvhv+To4r2i3Lc87B399CpWq
	S4ypWuDrx/OQ==
X-Received: by 2002:a05:6402:2787:b0:5dc:545:409f with SMTP id 4fb4d7f45d1cf-5dc17fed649mr4688247a12.2.1737740735492;
        Fri, 24 Jan 2025 09:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk5OyIkGLcCdvkTB7EWKEF0Ng9Urtox4OSvtvCIJOvM8dlIUNoFtfOdb0RrQPLTg4+zwhooVDjdT01dNVi8Fw=
X-Received: by 2002:a05:6402:2787:b0:5dc:545:409f with SMTP id
 4fb4d7f45d1cf-5dc17fed649mr4688212a12.2.1737740735062; Fri, 24 Jan 2025
 09:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org> <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org> <Z5OdECjsie-MCFel@poldevia.fieldses.org>
In-Reply-To: <Z5OdECjsie-MCFel@poldevia.fieldses.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 24 Jan 2025 12:45:24 -0500
X-Gm-Features: AWEUYZlk0e3zRhoIFSwqe_8QW40j8dPKOXT8uO2uxe_QaW0veSU-j8Ou9ZdO_rw
Message-ID: <CACSpFtB9yjDpKc_0QrNS2sHN9qFsVQQLvL7ALmG1OE1W+Wivtg@mail.gmail.com>
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:08=E2=80=AFAM J. Bruce Fields <bfields@fieldses.o=
rg> wrote:
>
> On Thu, Jan 23, 2025 at 06:20:08PM -0500, Jeff Layton wrote:
> > On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
> > > On 1/23/25 3:25 PM, Jeff Layton wrote:
> > > > RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
> > > >
> > > > "For any of a number of reasons, the replier could not process this
> > > >   operation in what was deemed a reasonable time. The client should=
 wait
> > > >   and then try the request with a new slot and sequence value."
> > >
> > > A little farther down, Section 15.1.1.3 says this:
> > >
> > > "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
> > >   retried in full with the SEQUENCE operation containing the same slo=
t
> > >   and sequence values."
> > >
> > > And:
> > >
> > > "If NFS4ERR_DELAY is returned on an operation other than the first in
> > >   the request, the request when retried MUST contain a SEQUENCE opera=
tion
> > >   that is different than the original one, with either the slot ID or=
 the
> > >   sequence value different from that in the original request."
> > >
> > > My impression is that the slot needs to be held and used again only i=
f
> > > the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
> > > the NFS4ERR_DELAY was the status of the 2nd or later operation in the
> > > COMPOUND, then yes, a different slot, or the same slot with a bumped
> > > sequence number, must be used.
> > >
> > > The current code in nfsd4_cb_sequence_done() appears to be correct in
> > > this regard.
> > >
> >
> > Ok! I stand corrected. We should be able to just drop this patch, but
> > some of the later patches may need some trivial merge conflicts fixed
> > up.
> >
> > Any idea why SEQUENCE is different in this regard?
>
> Isn't DELAY on SEQUENCE an indication that the operation is still in
> progress?  The difference between retrying the same slot or not is
> whether you're asking the server again for the result of the previous
> operation, or whether you're asking it to perform a new one.
>
> If you get DELAY on a later op and then keep retrying with the same
> seqid/slot then I'd expect you to get stuck in an infinite loop getting
> a DELAY response out of the reply cache.

If the client would keep re-using the same seqid for the operation it
got a DELAY on then it would be a broken client. When the linux client
gets ERR_DELAY, it retries the operation but it increments the seqid.

>
> --b.
>
>
> > This rule seems a
> > bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
> > matter which slot you use when retransmitting? The responder is just
> > saying "go away and come back later".
> >
> > What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
> > it's under resource pressure), and also shrinks the slot table in the
> > meantime? It seems like that might put the requestor in an untenable
> > position.
> >
> > Maybe we should lobby to get this changed in the spec?
> >
> > >
> > > > This is CB_SEQUENCE, but I believe the same rule applies. Release t=
he
> > > > slot before submitting the delayed RPC.
> > > >
> > > > Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for=
 processing more cb errors")
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >   fs/nfsd/nfs4callback.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc9=
08833a384d741e966a8db 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > > >                   goto need_restart;
> > > >           case -NFS4ERR_DELAY:
> > > >                   cb->cb_seq_status =3D 1;
> > > > +         nfsd41_cb_release_slot(cb);
> > > >                   if (!rpc_restart_call(task))
> > > >                           goto out;
> > > >
> > > >
> > >
> > >
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
>


