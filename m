Return-Path: <linux-nfs+bounces-20573-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ/+BQQ5zGn7RQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20573-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814237178C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B09C3008C0E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813B3D7D70;
	Tue, 31 Mar 2026 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XAWEpHn4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EA3A5437
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991440; cv=pass; b=CAWJydT6DFQnjpXT8o0VxCiP6rfBcHH2C6eeGDDPOC5m4fPZ17O37SjYLCYVzMxZLwcF+v9PAQxtYpNOC66LjiKcQSUtA4qs9m/9YSjZaAs261i53JgopKfTAwf1cafJ5JsPcEFlKgz1zlx5KSE+KvIBtZK90qAE8BweuqmbvZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991440; c=relaxed/simple;
	bh=rbPJqRMfIklzkRQ8dl43Fy7iMdvYXHulBI7gdfcpS+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE/OeePZ1xUnw0jHaVwlG8KggRrbS87llVsGEqsyIwSiq9H5FLLD7MyA59VnlXtDKVgvOsnUX+tHZzUqtOSmQ/o1j8KXraEpuESzco2kLBY8KHMeXwEXkr6oh8NF0zIu7PHOgSBtYW63G6UAgcF0SurhqXBJQpXCkguZeGL0VOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XAWEpHn4; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38bd3c6c502so50736361fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 14:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774991435; cv=none;
        d=google.com; s=arc-20240605;
        b=d4oGFTwT55rbjNWYBk+Yx32AxMAA/NlTn3C8PdSu3HLTLkpbxNgFQfG+KatHBkioRR
         nNLOgmAr+VRqsmntVNfVFty6lyyIgNNEh950Oecj+bcVthbcu/NVvpX1hnA4wuWGFqMd
         2AveRZfPnyaONJWoRBOXJ3481Yj/i6+mqHrDose9TYoYxbZwVNmX0u4dE1wlsU/vTPky
         UVo5dj/ATn0ke7f21R1sUeGy9zDSMYopCBCpxUU2rNs93PDVK0O/VBC6SmKC0LubFUst
         IjjSuhQYl8zyt+YvAngCaf65msZRgcnKWZxfywnwEKROLNLpXJ1E0ylXfEhhAtRvlaqh
         wGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yNe82YdpH/LroaNoicg5rAzfuF+w2ppNZ6mwH2vHefE=;
        fh=nA6LQtbJ8ZweoBErm8EXoEAcp0IKuSaOTy5V80O/0Lw=;
        b=IoqzqcjXbN5hnnbA6CIiWNiSydPCfKhgZUz/D2GITght/tmekS3Wzjm/yRlTiHKRnv
         n16VPKfrmk5T2QxzXI1zaEDRFLiSZPxxGf10TnavT49hofA5T7gnqM+B9BvTDlxwZBxH
         iDsWE7clJqh4c4y6I7zXdxuadXpgrX0ATLcf1DF+EoEOjL4lfueX2cHzy/hnzCs62e8j
         P801X/vE82O/pqwKmX9qt3uZxxfC27veYnlqeidtU2exvkgmLPofZWxPsC/sZYQDcdA6
         1iPfbgYy93bsszfy/f1LE2bmQ3eCMZ4tKMK0bn0E60C1AALBIa4heeKbmacWK7pjC5Fn
         9HgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774991435; x=1775596235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNe82YdpH/LroaNoicg5rAzfuF+w2ppNZ6mwH2vHefE=;
        b=XAWEpHn4bWnK/bhS+MjLucl4CDmsCBRv/f4AsBRee1cGH7ae1tw3B/thsTuq+Gcc/b
         xvcaDHiH9xJHOxCIa2EYw96VH7pfORNYhrrMGF3u0c+RRtm1jxnX/g7XI7NQwE7owmgG
         mdZHVtpSB7j09kEslBLeO+67x48OVrVVGuD7Gj3tIoobfAagWChr+1HYkDhqfo9qte3w
         zPkjBjruxkAe9Ykc1zUNRg6V9SMglo/uHsVDkqVOltPkvaNu3LR3x4ocAU9ErNHcwBFi
         XipWFJYhM8P0xTR8DzqYu13yNDVy+0L7auabuGiwAfVbWfsXd8nzEOSWTXJKiREDByYt
         5Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991435; x=1775596235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNe82YdpH/LroaNoicg5rAzfuF+w2ppNZ6mwH2vHefE=;
        b=brqCaWtD2i3fdKgZ/UFxFHOy+1sDu8mo4j0IMRXZToIz1tn45H0Dr9mDmgbJ4Crf5Q
         zMW9PagCZBGEXg2btf7ZIfNlGEmmRDgRdOY326kP6vKatFXbDoeMAhmWYhV1MmHNAoyi
         4jfrvvLe+WLIw12e0MAlS+TtRauZJ83gF+lTiPm/qUViM22wZQreCrZNJROFRkyZ5+w+
         ZTuA+NwpMAIjnm2gcSMsx0muTPZuLjHOa7Eb7mv3aeM6zt6GsCEp/N1vmOIoLvr212Yl
         Th+f8PIGp13zCbeBaN/+/01MUiar8uW0THSICv9EFOk+m1w4aWZn6SMd7I8UDLmZOX1u
         uPOw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5vMoU6GkpnDPlPvHCjC+jvNWN4T1JhXyIS0btvsRQu8HDzzTe6v5QXwjAiwtmniKtFG03KL7W1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG04OafHk6FyEoxYqDkCIxamBU3J/+mkVgYSclh+60+B4hK2j
	UxCFcUn8MuDsgChXQOuc/x9mSaqZSd9F2GGV71Oz8J/HkAYCoacAjIC7Tdnzvb5FbUjsDCsUeUc
	X5xC8CoN66qjJcBpDCwXLL7k25qaXlyY=
X-Gm-Gg: ATEYQzxOhoE+2w19kXefdFigTpNGhcGob1koyxsGDhFbhk5gc7NFgHPiv9tT3I0vtYr
	t++hdhxcHNEwZITDHPqDXy9XrGJfTL4smJK/w67X1wrFH/oCfkgRhRZh/m87Wf7/5oELYzfRWeO
	UAejHlfpCSeBZpAG/LIFCE3nJMTi6/fdGPennqLVWudZg8QCSBivZlphnMJC/KOZfNTTaFmF9wI
	fvKy36NMa/ein084w8NffwgXbgNrMM5tKrCPsbHO9LTRzdmxMhaNWcIiT73/Wv/dE0/+cqYdOfu
	yXn0rk3dWRlURNTBSivotnXHrg2chfzC055BHw==
X-Received: by 2002:a05:651c:438e:20b0:38a:4de2:8807 with SMTP id
 38308e7fff4ca-38cc305253bmr2084641fa.18.1774991434887; Tue, 31 Mar 2026
 14:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org> <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana> <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
 <acbfV0C-fAy4nZ-i@mana> <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
 <acwWuf5VMKHOfSUU@mana>
In-Reply-To: <acwWuf5VMKHOfSUU@mana>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 31 Mar 2026 17:10:23 -0400
X-Gm-Features: AQROBzB7E5i95K2SaGIJNSwVQ5TF9c2YQgTqzVRzP0NwVMrLIMUF6lHdjSGnK8s
Message-ID: <CAN-5tyFyOeo92zfCPVeJxJ-BokkvjxP384mXk8rEN0YXjftK3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
To: Thomas Haynes <loghyr@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20573-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3814237178C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 2:51=E2=80=AFPM Thomas Haynes <loghyr@gmail.com> wr=
ote:
>
> On Tue, Mar 31, 2026 at 02:17:54PM -0800, Olga Kornievskaia wrote:
> > On Fri, Mar 27, 2026 at 4:02=E2=80=AFPM Thomas Haynes <loghyr@gmail.com=
> wrote:
> > >
> > > On Fri, Mar 27, 2026 at 03:36:12PM -0800, Olga Kornievskaia wrote:
> > > > On Fri, Mar 27, 2026 at 2:22=E2=80=AFPM Thomas Haynes <loghyr@gmail=
.com> wrote:
> > > > >
> > > > > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > > > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > > > > On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton=
@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > > > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlay=
ton@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > xfstest generic/728 fails with delegated timestamps. Th=
e client does a
> > > > > > > > > > removexattr and then a stat to test the ctime, which do=
esn't change. The
> > > > > > > > > > stat() doesn't trigger a GETATTR because of the delegat=
ed timestamps, so
> > > > > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > > > >
> > > > > > > > > > The setxattr compound has a trailing GETATTR, which ens=
ures that its
> > > > > > > > > > ctime gets updated. Follow the same strategy with remov=
exattr.
> > > > > > > > >
> > > > > > > > > This approach relies on the fact that the server the serv=
es delegated
> > > > > > > > > attributes would update change_attr on operations which m=
ight now
> > > > > > > > > necessarily happen (ie, linux server does not update chan=
ge_attribute
> > > > > > > > > on writes or clone). I propose an alternative fix for the=
 failing
> > > > > > > > > generic/728.
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr=
(struct inode
> > > > > > > > > *inode, const char *name)
> > > > > > > > >             &res.seq_res, 1);
> > > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > >         if (!ret)
> > > > > > > > > -               nfs4_update_changeattr(inode, &res.cinfo,=
 timestamp, 0);
> > > > > > > > > +               if (nfs_have_delegated_attributes(inode))=
 {
> > > > > > > > > +                       nfs_update_delegated_mtime(inode)=
;
> > > > > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > > > > +                       nfs_set_cache_invalid(inode, NFS_=
INO_INVALID_BLOCKS);
> > > > > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > > > > +               } else
> > > > > > > > > +                       nfs4_update_changeattr(inode, &re=
s.cinfo, timestamp, 0);
> > > > > > > > >
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > >
> > > > > > > > What's the advantage of doing it this way?
> > > > > > > >
> > > > > > > > You just sent a REMOVEXATTR operation to the server that wi=
ll change
> > > > > > > > the mtime there. The server has the most up-to-date version=
 of the
> > > > > > > > mtime and ctime at that point.
> > > > > > >
> > > > > > > In presence of delegated attributes, Is the server required t=
o update
> > > > > > > its mtime/ctime on an operation? As I mentioned, the linux se=
rver does
> > > > > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > > > >
> > > > > > > Is possible that
> > > > > > > some implementations might be different and also do not updat=
e the
> > > > > > > ctime/mtime on REMOVEXATTR?
> > > > > > >
> > > > > > > Therefore I was suggesting that the patch
> > > > > > > relies on the fact that it would receive an updated value. Of=
 course
> > > > > > > perhaps all implementations are done the same as the linux se=
rver and
> > > > > > > my point is moot. I didn't see anything in the spec that clar=
ifies
> > > > > > > what the server supposed to do (and client rely on).
> > > > > > >
> > > > > >
> > > > > > (cc'ing Tom)
> > > > > >
> > > > > > That is a very good point.
> > > > > >
> > > > > > My interpretation was that delegated timestamps generally cover=
ed
> > > > > > writes, but SETATTR style operations that do anything beyond on=
ly
> > > > > > changing the mtime can't be cached.
> > > > > >
> > > > > > We probably need some delstid spec clarification: for what oper=
ations
> > > > > > is the server required to disable timestamp updates when a writ=
e
> > > > > > delegation is outstanding?
> > > > > >
> > > > > > In the case of nfsd, we disable timestamp updates for WRITE/COP=
Y/CLONE
> > > > > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > > > >
> > > > > > How does the Hammerspace anvil behave? Does it disable c/mtime =
updates
> > > > > > for writes when there is an outstanding timestamp delegation li=
ke we're
> > > > > > doing in nfsd? If so, does it do the same for
> > > > > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > > > >
> > > > > Jeff,
> > > > >
> > > > > I think the right way to look at this is closer to how size is
> > > > > handled under delegation in RFC8881, rather than as a per-op rule=
.
> > > > >
> > > > > In our implementation, because we are acting as an MDS and data I=
/O
> > > > > goes to DSes, we already treat size as effectively delegated when
> > > > > a write layout is outstanding. The MDS does not maintain authorit=
ative
> > > > > size locally in that case. We may refresh size/timestamps interna=
lly
> > > > > (e.g., on GETATTR by querying DSes), but we don=E2=80=99t treat t=
hat as
> > > > > overriding the delegated authority.
> > > > >
> > > > > For timestamps, our behavior is effectively the same model. When
> > > > > the client holds the relevant delegation, the server does not
> > > > > consider itself authoritative for ctime/mtime. If current values
> > > > > are needed, we can obtain them from the client (e.g., via CB_GETA=
TTR),
> > > > > and the client must present the delegation stateid to demonstrate
> > > > > that authority. So the authority follows the delegation, not the
> > > > > specific operation.
> > > >
> > > > What happens when the client holding the attribute delegation (it's
> > > > the authority) is doing the query? Is it the server's responsibilit=
y
> > > > to query the client before replying.
> > >
> > > The Hammerspace server on a getattr checks to see if there is
> > > a delegated stateid (and whether it is the client making the request
> > > or not). If it is and the GETATTR asks for FATTR4_SIZE, FATTR4_TIME_M=
ODIFY,
> > > or FATTR4_TIME_METADATA, then it will send a CB_GETATTR before
> > > responding to the client.
> >
> > So... while I might not be running the latest Hammerspace bits and
> > something has changed but I do not see Hammerspace server sending a
> > CB_GETATTR when the "client is making a getattr request with a
> > delegated stateid".
>
> Or the process is broken on the server side.
>
>
> > Example is the CLONE operation with an accompanied
> > GETATTR. The server in this case updates the change attribute and
> > mtime and returns different from what the client had previously in the
> > OPEN back to the client (this is what the test expect but I think
> > that's contradictory to what is said above). (To contrast nfsd server
> > does not update the change attribute or mtime and returns the same
> > value and thus making xfstest fail). So if the spec mandates that
> > before answering the GETATTR a CB_GETATTR needs to be sent then
> > neither of the server (Hammerspace nor linux) do that. But then again
> > I'm not sure the client is not at fault for sending a GETATTR in the
> > CLONE compound in the first place. For instance client does not have a
> > GETATTR in the COPY compound (and then fails to pass xfstest that
> > checks for modifies ctime/mtime). But the solution isn't clear to is
> > it like Jeff's REMOVEXATTR approach to add the GETATTR to the COPY
> > compound but that then should trigger a CB_GETATTR back to the client.
> > Again probably none of the servers do that...
> >
> > Another point I would like to raise is: doesn't it seem
> > counter-intuitive to be in a situation where we have a
> > delegation-holding client sending a GETATTR and then a server needing
> > to do a CB_GETTATTR to the said client to fulfill the request.
> > Delegations were supposed to reduce traffic and now we are introducing
> > additional traffic instead. I guess I'm arguing that the client is
> > broken to ever query for change_attr, mtime if it's holding the
> > delegation. Yet the linux client (I could be wrong here) is written
> > such that change_attr or mtime has to always come from the server. Say
> > the application did a write() followed by a stat(). Client can't
> > satisfy stat() without reaching out to the server. Yet the server is
> > not the authority and before it can generate the reply for
> > change_attr, mtime, it needs to callback to the client (CB_GETATTR).
> > It seems it would have been better to never get a delegated attribute
> > delegation in the first place?
>
> Or the client needs to change its behaviour in this scenario? Why ask
> as question to a source which is not the authority?

well i think it's because it's not able to generate the values needed
(ie the server is the only one that can generate the change_attr value
and mtime is also supposed to come from the server clock too)?

> Or, I agree with your analysis...
>
> >
> > > While it does not do so, if the client sent in a SETATTR in the
> > > same compound we could short circuit that. Think a sort of WCC.
> > >
> > > > Example, client sends a CLONE
> > > > operation which has a GETATTR attached. (1) is the server supposed =
to
> > > > issue a CB_GETATTR before replying to the compound? (2) is the clie=
nt
> > > > not supposed to send any GETATTRs while holding an attribute
> > > > delegation? CLONE is a modifying operation but client hasn't done a=
ny
> > > > actual modifications to the opened file so a CB_GETATTR would retur=
n
> > > > that file hasn't been modified. Is the server then not going to
> > > > express that the file has indeed been modified when replying to
> > > > GETATTR?
> > >
> > > The server could argue that the client wants to know what it thinks.
> > > But that isn't the argeement. The server has to query those values
> > > before sending them on.
> > >
> > > >
> > > > > That said, I don=E2=80=99t think we=E2=80=99ve fully resolved the=
 semantics for all
> > > > > metadata-style ops either. WRITE and SETATTR are clear in our mod=
el,
> > > > > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we=E2=80=99v=
e likely
> > > > > been relying on assumptions rather than a fully consistent rule.
> > > > > I.e., CLONE and COPY we just pass through to the DS and we don't
> > > > > implement SETXATTR/REMOVEXATTR.
> > > > >
> > > > > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > > > > any particular op) should update ctime/mtime, but whether delegat=
ed
> > > > > timestamps are meant to follow the same attribute-authority model
> > > > > as delegated size in RFC8881. If so, then we expect that the serv=
er
> > > > > should query the client via CB_GETATTR to return updated ctime/mt=
ime
> > > > > after such operations while the delegation is outstanding.
> > > > >
> > > > > Thanks,
> > > > > Tom
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > > It's certainly possible that the REMOVEXATTR is the only ch=
ange that
> > > > > > > > occurred. With what I'm proposing, we don't even need to do=
 a SETATTR
> > > > > > > > at all if nothing else changed. With your version, you woul=
d.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR hand=
ling for extended attributes")
> > > > > > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c117=
2fc11c9d5a55b3621977ac83bb98f7c20 100644
> > > > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct fil=
e *src_f, struct file *dst_f,
> > > > > > > > > >  static int _nfs42_proc_removexattr(struct inode *inode=
, const char *name)
> > > > > > > > > >  {
> > > > > > > > > >         struct nfs_server *server =3D NFS_SERVER(inode)=
;
> > > > > > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > > > > > >         struct nfs42_removexattrargs args =3D {
> > > > > > > > > >                 .fh =3D NFS_FH(inode),
> > > > > > > > > > +               .bitmask =3D bitmask,
> > > > > > > > > >                 .xattr_name =3D name,
> > > > > > > > > >         };
> > > > > > > > > > -       struct nfs42_removexattrres res;
> > > > > > > > > > +       struct nfs42_removexattrres res =3D {
> > > > > > > > > > +               .server =3D server,
> > > > > > > > > > +       };
> > > > > > > > > >         struct rpc_message msg =3D {
> > > > > > > > > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4=
_CLNT_REMOVEXATTR],
> > > > > > > > > >                 .rpc_argp =3D &args,
> > > > > > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexa=
ttr(struct inode *inode, const char *name)
> > > > > > > > > >         int ret;
> > > > > > > > > >         unsigned long timestamp =3D jiffies;
> > > > > > > > > >
> > > > > > > > > > +       res.fattr =3D nfs_alloc_fattr();
> > > > > > > > > > +       if (!res.fattr)
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consist=
ency_bitmask,
> > > > > > > > > > +                        inode, NFS_INO_INVALID_CHANGE)=
;
> > > > > > > > > > +
> > > > > > > > > >         ret =3D nfs4_call_sync(server->client, server, =
&msg, &args.seq_args,
> > > > > > > > > >             &res.seq_res, 1);
> > > > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > > > -       if (!ret)
> > > > > > > > > > +       if (!ret) {
> > > > > > > > > >                 nfs4_update_changeattr(inode, &res.cinf=
o, timestamp, 0);
> > > > > > > > > > +               ret =3D nfs_post_op_update_inode(inode,=
 res.fattr);
> > > > > > > > > > +       }
> > > > > > > > > >
> > > > > > > > > > +       kfree(res.fattr);
> > > > > > > > > >         return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c6=
2f721cfe01bfc60f5981396958084d627 100644
> > > > > > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > > > > > @@ -263,11 +263,13 @@
> > > > > > > > > >  #define NFS4_enc_removexattr_sz                (compou=
nd_encode_hdr_maxsz + \
> > > > > > > > > >                                          encode_sequenc=
e_maxsz + \
> > > > > > > > > >                                          encode_putfh_m=
axsz + \
> > > > > > > > > > -                                        encode_removex=
attr_maxsz)
> > > > > > > > > > +                                        encode_removex=
attr_maxsz + \
> > > > > > > > > > +                                        encode_getattr=
_maxsz)
> > > > > > > > > >  #define NFS4_dec_removexattr_sz                (compou=
nd_decode_hdr_maxsz + \
> > > > > > > > > >                                          decode_sequenc=
e_maxsz + \
> > > > > > > > > >                                          decode_putfh_m=
axsz + \
> > > > > > > > > > -                                        decode_removex=
attr_maxsz)
> > > > > > > > > > +                                        decode_removex=
attr_maxsz + \
> > > > > > > > > > +                                        decode_getattr=
_maxsz)
> > > > > > > > > >
> > > > > > > > > >  /*
> > > > > > > > > >   * These values specify the maximum amount of data tha=
t is not
> > > > > > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexatt=
r(struct rpc_rqst *req,
> > > > > > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr)=
;
> > > > > > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > > > > > >         encode_nops(&hdr);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexat=
tr(struct rpc_rqst *req,
> > > > > > > > > >                 goto out;
> > > > > > > > > >
> > > > > > > > > >         status =3D decode_removexattr(xdr, &res->cinfo)=
;
> > > > > > > > > > +       if (status)
> > > > > > > > > > +               goto out;
> > > > > > > > > > +       status =3D decode_getfattr(xdr, res->fattr, res=
->server);
> > > > > > > > > >  out:
> > > > > > > > > >         return status;
> > > > > > > > > >  }
> > > > > > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nf=
s_xdr.h
> > > > > > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b=
5685f46136a210c8e11c20a54d6ed9dad 100644
> > > > > > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > > > > > >  struct nfs42_removexattrargs {
> > > > > > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > > > > > >         struct nfs_fh                   *fh;
> > > > > > > > > > +       const u32                       *bitmask;
> > > > > > > > > >         const char                      *xattr_name;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  struct nfs42_removexattrres {
> > > > > > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > > > > > >         struct nfs4_change_info         cinfo;
> > > > > > > > > > +       struct nfs_fattr                *fattr;
> > > > > > > > > > +       const struct nfs_server         *server;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.53.0
> > > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > > >
> > > > > > --
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > > >

