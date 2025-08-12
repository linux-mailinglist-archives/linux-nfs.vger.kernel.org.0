Return-Path: <linux-nfs+bounces-13587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDCB237AA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 21:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21790687A59
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668F283FE4;
	Tue, 12 Aug 2025 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="seexUk0F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D972F90F1
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026020; cv=none; b=jfw+QUBC99RpY1c8OG+im7gwnjBf9lBLsxYr1l0aFH0B0WHtIfilQdYcAi+ABXMSFAAk0jGYyr3azlcI8rLOu85FRfre6nwqTnfHg67umH1tbymT3tBJcmvPmNT+EtA/Caky+lIKhEhiRD7X6GCr7i+XGa7SiPfc3UROEgXTnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026020; c=relaxed/simple;
	bh=pJz1JeebDsYWxMzyAducqazi1+zDbSUO7UkHLnr6kGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhSpIgC4xV6T5xMmN+DMOp7VU/BVTwXoVGJlmU7mTrAVun9PIp8dlJCvnSuXyqOD3k05KQo3gBFNDgbYO1zk8MpQYlHxZucRChp2LMP68esise4YaET0ioxhjAi+/dnLsdlQz6Nsl82EwBRRQ/7UFJ/SNAOMh6+TToe2EqXBOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=seexUk0F; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333dde3fa8dso7051981fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755026016; x=1755630816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BUVUwPkoTjBqX3QeCe7O2WO4NfxEv8OWCEcV3ZPFog=;
        b=seexUk0FcGjHk/C38GcI015L+JYRLXV7xpQFoYTd9B1+panQorBdK0paJ+greFN7eY
         5oya6nKH8zZovT+Kp6BW/1qBjM+HCCCFB22rmsw6WU+PLW/qvpmvYrFfxPvniYEpaxFk
         oLdJwH18QfBu1u/2Gd11H7pCl9QurbuF0lVjLeK3KFpyajS8MH/Kf8ReFVrACDwpOSzf
         WkvhOjKhyK/sHKdi7bQvgDvBwzcL9A4EYfJOJuc4aIHHwVBWm4pNHJljFsLhu/Z9eg7Y
         THbJcNJICIzKp0omGm03jvIrcEmAHJG7P2Ehbk/EXQWXRXOdiyalVd+GL0Lt97X3cJ4E
         0M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026016; x=1755630816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BUVUwPkoTjBqX3QeCe7O2WO4NfxEv8OWCEcV3ZPFog=;
        b=RNZYzFU33S8g0mQBCV5z5YUoRo58SRiN/3WeRmvCfRt69mVKjGeyL5dWjb4NB5uh06
         514vP0Db1iIIIlLgOlCBHe8IgexhryEpfVnrX8TDm2n4ozJYRJ4XI0OMbsQ+v4GhaDDb
         FeCJoWFnN9UDtLxOAgsqfEX126qscQa68Y1JW/D1XmAPxYIp8/5UC6WogqLmnybDkpud
         Pa4iB4kLcT44TccwzHWHF1UtMIE+Vhm1MV1z4sSqu5ZX4G7WWGqGOTb3tSWiDalLPGiI
         KheT/g/MclCxdLylnKT7SQY54KjGT+GZLi22hNfK14i+tUod3gU2R+P0NENnk3ntHWEG
         Yx7g==
X-Forwarded-Encrypted: i=1; AJvYcCWVZ1lZZI4Ryun1ErS6YCdr+xbcQndadP0kyAMGe5e1c9sUY47II/lmV6V5TNrpSn01tY+c/Z71MUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZ9cI8fLVo7Y4TfqtOHOz5hyvEwi3TbIF8EsRacI0dRh1qzF6
	UeUW2ecsNiyoL81fQ5xU7/OA8vyx2t7FeHIHzDoT8uur2VqbTZVA/GNQtLGP45+5hQ0kpgky5QV
	pUpybodNgHh2dxHdzY+iY/z1yn5lT2rt1qEUx
X-Gm-Gg: ASbGncsG968ap8zCVLckLYuKOFEAfX8zFZQwwE5fecq3ZrZ+EbTZDGJiZ4TnjPTtbGH
	kOXokxCWu8phSh7ms8HAOvU8+YaaBSCdExj694oYnmM2nLuJzZqcc/XHT0Tzsgu4CyhuKasFjlQ
	deu7xj6VQoW8gO7AMe3J5LHe3lhoLbRjggcpBiv6yvUe+c0w9s9xu6nhNeusCwwUkqzOlTHdrr3
	4uwusXSdd4S3CrjNQVanzkcCsdFN06arRDOFNkd
X-Google-Smtp-Source: AGHT+IHB2TD3Du+KI6JKKWlTr/J2AngTq9Czn0k9PfIOnOEYvjADJQ4s+hpH0bVd8Bxk87CQN5/GG5KpkTLp5nzKhoc=
X-Received: by 2002:a2e:74f:0:b0:32a:6606:a58 with SMTP id 38308e7fff4ca-333e9b7b9c1mr165121fa.35.1755026015887;
 Tue, 12 Aug 2025 12:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812190244.30452-1-okorniev@redhat.com> <2a024899-6be0-4349-aed0-ee05e196fc1f@oracle.com>
In-Reply-To: <2a024899-6be0-4349-aed0-ee05e196fc1f@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 12 Aug 2025 15:13:23 -0400
X-Gm-Features: Ac12FXxMrjOYrgeDlbkx1ZkbnEloMdk78orTLSr3m36-CX4OgsGZY_L2Q3dh1cY
Message-ID: <CAN-5tyEpg=vZGXkGYqjq3RLC_h=rt3akXGvnqKzddtLJ8Q0O4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:08=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/12/25 3:02 PM, Olga Kornievskaia wrote:
> > When a listener is added, a part of creation of transport also register=
s
> > program/port with rpcbind. However, when the listener is removed,
> > while transport goes away, rpcbind still has the entry for that
> > port/type.
> >
> > Removal of listeners works by first removing all transports and then
> > re-adding the ones that were not removed. In addition to destroying
> > all transports, now also call the function that unregisters everything
> > with the rpcbind. But we also then need to call the rpcbind setup
> > function before adding back new transports.
>
> Removing all rpcbind registrations and then re-adding them might
> cause an outage for clients that attempt to mount the server right
> at that moment.

Ok I'll take a look at unregistering elsewhere. But to note, removing
a listener is only allowed when no threads are running. Thus no mounts
are possible.

> > Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfsctl.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 2909d70de559..99d06343117b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *sk=
b, struct genl_info *info)
> >        * Since we can't delete an arbitrary llist entry, destroy the
> >        * remaining listeners and recreate the list.
> >        */
> > -     if (delete)
> > +     if (delete) {
> >               svc_xprt_destroy_all(serv, net);
> > +             svc_rpcb_cleanup(serv, net);
> > +             svc_bind(serv, net);
> > +     }
> >
> >       /* walk list of addrs again, open any that still don't exist */
> >       nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>
>
> --
> Chuck Lever
>

