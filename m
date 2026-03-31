Return-Path: <linux-nfs+bounces-20555-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yORpL5sSzGkvOAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20555-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:29:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC736FF82
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CCC30699A8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49AF31714C;
	Tue, 31 Mar 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jAYaZpTo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5543002DF
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981092; cv=pass; b=RgS+khpK8TrgEsElZzXsqwKLBPP7rU+MmEZesHQU2pzl8zMm3BH9ukZ94WGtzIuESIbQ5HBwpbPxiGigVf10JiGk5MowKsQWpFa8emGHb+AaaPP6lLtUEYGDkHPrgvqfY01uEqW9oGWTTiG4/NUYZ/c9I/i57680+4zEfBfi+kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981092; c=relaxed/simple;
	bh=+xp+zNwP8xGM9y3OgU+HlWFPnX+aDMI4ozK7NFmN/NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4LeJ+kmq5S3mddTkCjUW4NUV55dBZNxlsWldb0JSTl18Ej4VhVL6vNt3PRyOWafEdsdAkZ1jNI+6bYWlW3KlAjASyhRZzKi9dDEs+nQTBu4Hg9HPfjmrYSpK1Nq2p2vohioPvEyuWEdvS5tAHA5Cy55d/3sTDYdZhkkpx8KZoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jAYaZpTo; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so7430816e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 11:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774981087; cv=none;
        d=google.com; s=arc-20240605;
        b=eOI18c7KrLdiIrB3II6o9EQGuiw2Cyxcayw7vFpqCDtXoIsVGoSiGhntfIVBppGSwe
         Kj2TCt5gwNNIDtfu7jraMhEoYVzI18/N80ObnJmCRzE7EPder8ozRB7HRTktv22u1TEu
         roXfRSUlYTkBdNp4P2tIyBO7duxktwq/Ayf/4IJEcnJ2TXTHULx9ZUSyX5eh8fSljKRZ
         3eRkPzKCx8a/ElOLWPCTB+JUDTvHSvRtducdhEVEEiqW6ZDsaIziWN0P/Y9wqN+9FEdl
         qgLpcmuaAntugKm2J6I865C3Kji42OBlDOxaA4BJH0psPCcV4mk2Mww5X5JWzVSrir54
         cbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m+QSUejHFfQOW3kp4gf/E8vJGlQv7jENXoZT2rEVNhU=;
        fh=ta9Ta+GUkIKo0nx6K/WL0T1HrooX0z4NhKWbC/8RuSs=;
        b=f70LzNcqf7icz0XXRqz16cqIuCAHzldtbslVdNGKB13dGWr1ia0SKUt3nfMc85C3Yb
         lHJJ1AoGTYwUsFqV5qQt7WbQiuj2YT4JJygJHNkkISDULDqm+MvaHDCxAzb+1LdykWC4
         9x2aAV6T9vdA1hLyDpdecFD61HxbTJWgKxEi9sivzvxczX7XjDSirV2LTOG7fjKEuluQ
         SkZWmbWeIHiEStzSOfwOUEDsZCjggkCvXUHxrhBscNaNm992EfTbGh3lv+rxOpM5N365
         gf+mSeWpZEIFMHTYX7L/aXaRcjs7JOId56wU1sNjBD2/E8DaQ1UeDW0DccxnCpNqhZzL
         26ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774981087; x=1775585887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+QSUejHFfQOW3kp4gf/E8vJGlQv7jENXoZT2rEVNhU=;
        b=jAYaZpToYY7bbEKMLGPdm2tKbXaDvnfg/7zF54ZnbknEe363dpicmvkV4IKx417K7C
         CiHu2wD2FmXbM7F4y3al1XzX5qP051KVSks9h6ULOnDdRaqfmCbeVGWAKLL2NCC9b3G2
         MPS/TfIMEz+u1b1CC/AKdMxdjAxbN53L0j3IVItfDIO99w/TZOC3m+0N8+GPYEL7kxqB
         B1tzqXi9bxQu9Bz04N5CJcZSpsn1GmHWbzS3u38B0EgkeDS1DX/nsfAFKYdILW2mTb8U
         9BFUY1zj3K3SfK6Hy5VlmAZWBU6Jubf3h8Qg+X7cM96DfyeeJx0aaeKv56A6H2VrBdZ6
         Fjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981087; x=1775585887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+QSUejHFfQOW3kp4gf/E8vJGlQv7jENXoZT2rEVNhU=;
        b=sDdUENG54fXTFVYKf+yVkwONGGpqu+WdiHGlmqBWfCVELfzKzomUQYJii91Or8QCsT
         EGTsdoBob70dczvhIu4uTzRhPEgilCf/C+AAdMkpLGanKiFYfX3cJwm7BE5apMyIab2p
         uMsL6EABPKB830upGzUQ9y3JNohQgdAqHPgygMQIdzuxsq/eD9JwG9uU9coVsOrnic8I
         qfXRqGITMdy0LlGH/1Iipnq46DwhW4p/5IQRz1arOP6zsdC1VVAUqIXaj2+b+4XmTyQ6
         L4yA2VYf8wcL02R47EzsOjz80cjjEytpGOmX6lMMayYb4aObFLrcUFRNHpHFuJpCvC42
         mv9w==
X-Forwarded-Encrypted: i=1; AJvYcCVmna28WYxjYiAcMNeMWjABxNcVnEdbqWcgod+OXCzl+qk1hrD7OIkJZKQOxVnm5vAmIJWqL3PLxtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7XcfA+xt8T8z/JLGObc6pfm/792NwcPFP5SRSKK5eN/2MTYu
	KYmOM8R3G3L8JE4SVv6bA+vuEnjZqP+Sm4XSaQOAXz0GOC4KPX4E6h0Y08aFi2iWdPXhQ6xFGVo
	JriMjoTpUCzHb9EojYxYRzxelOCT1ZT0=
X-Gm-Gg: ATEYQzwtNIniKRK+kA4GBTBP7foyY3p2DZQLAxG76Ml+seiIcz8evPe/6nZo97uvOBX
	OwqoeoB3qosO7L/iYhKdCaUDePEU5H1o7xVesrc++aPLgo2yvB59ODJu/hSR0KtR9blRata4hgj
	ObSnvwXn+gxoiF9Ws5vjQt6Bg1QiJm7L1Khq5CHaO6we9M2Ln1V68W2wxTDmSy+fRcNxxKZZVJ1
	fGaaswGbcqy/APRzEsdK5dPDzmRXz89Hdsp+hZUrhyNg487FbXY46f3/e0Kqz78Lh0OuK6F0/9r
	IeePSK4G+kVAaNri8lrhY2X3QHRJU0uqVAzvxJL5fA==
X-Received: by 2002:a05:6512:10c9:b0:5a2:b3f9:a874 with SMTP id
 2adb3069b0e04-5a2c1f1bd7emr145397e87.27.1774981086955; Tue, 31 Mar 2026
 11:18:06 -0700 (PDT)
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
 <acbfV0C-fAy4nZ-i@mana>
In-Reply-To: <acbfV0C-fAy4nZ-i@mana>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 31 Mar 2026 14:17:54 -0400
X-Gm-Features: AQROBzCPNNDwewLbK8bLwAsRQyLB-9e4VjQ6_n6uNcIW02SaRj26BR2IaoCAL1g
Message-ID: <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20555-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 16DC736FF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:02=E2=80=AFPM Thomas Haynes <loghyr@gmail.com> wr=
ote:
>
> On Fri, Mar 27, 2026 at 03:36:12PM -0800, Olga Kornievskaia wrote:
> > On Fri, Mar 27, 2026 at 2:22=E2=80=AFPM Thomas Haynes <loghyr@gmail.com=
> wrote:
> > >
> > > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > > On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton@ker=
nel.org> wrote:
> > > > > >
> > > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayton@=
kernel.org> wrote:
> > > > > > > >
> > > > > > > > xfstest generic/728 fails with delegated timestamps. The cl=
ient does a
> > > > > > > > removexattr and then a stat to test the ctime, which doesn'=
t change. The
> > > > > > > > stat() doesn't trigger a GETATTR because of the delegated t=
imestamps, so
> > > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > >
> > > > > > > > The setxattr compound has a trailing GETATTR, which ensures=
 that its
> > > > > > > > ctime gets updated. Follow the same strategy with removexat=
tr.
> > > > > > >
> > > > > > > This approach relies on the fact that the server the serves d=
elegated
> > > > > > > attributes would update change_attr on operations which might=
 now
> > > > > > > necessarily happen (ie, linux server does not update change_a=
ttribute
> > > > > > > on writes or clone). I propose an alternative fix for the fai=
ling
> > > > > > > generic/728.
> > > > > > >
> > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(str=
uct inode
> > > > > > > *inode, const char *name)
> > > > > > >             &res.seq_res, 1);
> > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > >         if (!ret)
> > > > > > > -               nfs4_update_changeattr(inode, &res.cinfo, tim=
estamp, 0);
> > > > > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > > > > +                       nfs_update_delegated_mtime(inode);
> > > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > > +                       nfs_set_cache_invalid(inode, NFS_INO_=
INVALID_BLOCKS);
> > > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > > +               } else
> > > > > > > +                       nfs4_update_changeattr(inode, &res.ci=
nfo, timestamp, 0);
> > > > > > >
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > >
> > > > > > What's the advantage of doing it this way?
> > > > > >
> > > > > > You just sent a REMOVEXATTR operation to the server that will c=
hange
> > > > > > the mtime there. The server has the most up-to-date version of =
the
> > > > > > mtime and ctime at that point.
> > > > >
> > > > > In presence of delegated attributes, Is the server required to up=
date
> > > > > its mtime/ctime on an operation? As I mentioned, the linux server=
 does
> > > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > >
> > > > > Is possible that
> > > > > some implementations might be different and also do not update th=
e
> > > > > ctime/mtime on REMOVEXATTR?
> > > > >
> > > > > Therefore I was suggesting that the patch
> > > > > relies on the fact that it would receive an updated value. Of cou=
rse
> > > > > perhaps all implementations are done the same as the linux server=
 and
> > > > > my point is moot. I didn't see anything in the spec that clarifie=
s
> > > > > what the server supposed to do (and client rely on).
> > > > >
> > > >
> > > > (cc'ing Tom)
> > > >
> > > > That is a very good point.
> > > >
> > > > My interpretation was that delegated timestamps generally covered
> > > > writes, but SETATTR style operations that do anything beyond only
> > > > changing the mtime can't be cached.
> > > >
> > > > We probably need some delstid spec clarification: for what operatio=
ns
> > > > is the server required to disable timestamp updates when a write
> > > > delegation is outstanding?
> > > >
> > > > In the case of nfsd, we disable timestamp updates for WRITE/COPY/CL=
ONE
> > > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > >
> > > > How does the Hammerspace anvil behave? Does it disable c/mtime upda=
tes
> > > > for writes when there is an outstanding timestamp delegation like w=
e're
> > > > doing in nfsd? If so, does it do the same for
> > > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > >
> > > Jeff,
> > >
> > > I think the right way to look at this is closer to how size is
> > > handled under delegation in RFC8881, rather than as a per-op rule.
> > >
> > > In our implementation, because we are acting as an MDS and data I/O
> > > goes to DSes, we already treat size as effectively delegated when
> > > a write layout is outstanding. The MDS does not maintain authoritativ=
e
> > > size locally in that case. We may refresh size/timestamps internally
> > > (e.g., on GETATTR by querying DSes), but we don=E2=80=99t treat that =
as
> > > overriding the delegated authority.
> > >
> > > For timestamps, our behavior is effectively the same model. When
> > > the client holds the relevant delegation, the server does not
> > > consider itself authoritative for ctime/mtime. If current values
> > > are needed, we can obtain them from the client (e.g., via CB_GETATTR)=
,
> > > and the client must present the delegation stateid to demonstrate
> > > that authority. So the authority follows the delegation, not the
> > > specific operation.
> >
> > What happens when the client holding the attribute delegation (it's
> > the authority) is doing the query? Is it the server's responsibility
> > to query the client before replying.
>
> The Hammerspace server on a getattr checks to see if there is
> a delegated stateid (and whether it is the client making the request
> or not). If it is and the GETATTR asks for FATTR4_SIZE, FATTR4_TIME_MODIF=
Y,
> or FATTR4_TIME_METADATA, then it will send a CB_GETATTR before
> responding to the client.

So... while I might not be running the latest Hammerspace bits and
something has changed but I do not see Hammerspace server sending a
CB_GETATTR when the "client is making a getattr request with a
delegated stateid". Example is the CLONE operation with an accompanied
GETATTR. The server in this case updates the change attribute and
mtime and returns different from what the client had previously in the
OPEN back to the client (this is what the test expect but I think
that's contradictory to what is said above). (To contrast nfsd server
does not update the change attribute or mtime and returns the same
value and thus making xfstest fail). So if the spec mandates that
before answering the GETATTR a CB_GETATTR needs to be sent then
neither of the server (Hammerspace nor linux) do that. But then again
I'm not sure the client is not at fault for sending a GETATTR in the
CLONE compound in the first place. For instance client does not have a
GETATTR in the COPY compound (and then fails to pass xfstest that
checks for modifies ctime/mtime). But the solution isn't clear to is
it like Jeff's REMOVEXATTR approach to add the GETATTR to the COPY
compound but that then should trigger a CB_GETATTR back to the client.
Again probably none of the servers do that...

Another point I would like to raise is: doesn't it seem
counter-intuitive to be in a situation where we have a
delegation-holding client sending a GETATTR and then a server needing
to do a CB_GETTATTR to the said client to fulfill the request.
Delegations were supposed to reduce traffic and now we are introducing
additional traffic instead. I guess I'm arguing that the client is
broken to ever query for change_attr, mtime if it's holding the
delegation. Yet the linux client (I could be wrong here) is written
such that change_attr or mtime has to always come from the server. Say
the application did a write() followed by a stat(). Client can't
satisfy stat() without reaching out to the server. Yet the server is
not the authority and before it can generate the reply for
change_attr, mtime, it needs to callback to the client (CB_GETATTR).
It seems it would have been better to never get a delegated attribute
delegation in the first place?

> While it does not do so, if the client sent in a SETATTR in the
> same compound we could short circuit that. Think a sort of WCC.
>
> > Example, client sends a CLONE
> > operation which has a GETATTR attached. (1) is the server supposed to
> > issue a CB_GETATTR before replying to the compound? (2) is the client
> > not supposed to send any GETATTRs while holding an attribute
> > delegation? CLONE is a modifying operation but client hasn't done any
> > actual modifications to the opened file so a CB_GETATTR would return
> > that file hasn't been modified. Is the server then not going to
> > express that the file has indeed been modified when replying to
> > GETATTR?
>
> The server could argue that the client wants to know what it thinks.
> But that isn't the argeement. The server has to query those values
> before sending them on.
>
> >
> > > That said, I don=E2=80=99t think we=E2=80=99ve fully resolved the sem=
antics for all
> > > metadata-style ops either. WRITE and SETATTR are clear in our model,
> > > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we=E2=80=99ve li=
kely
> > > been relying on assumptions rather than a fully consistent rule.
> > > I.e., CLONE and COPY we just pass through to the DS and we don't
> > > implement SETXATTR/REMOVEXATTR.
> > >
> > > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > > any particular op) should update ctime/mtime, but whether delegated
> > > timestamps are meant to follow the same attribute-authority model
> > > as delegated size in RFC8881. If so, then we expect that the server
> > > should query the client via CB_GETATTR to return updated ctime/mtime
> > > after such operations while the delegation is outstanding.
> > >
> > > Thanks,
> > > Tom
> > >
> > >
> > > >
> > > >
> > > >
> > > > > > It's certainly possible that the REMOVEXATTR is the only change=
 that
> > > > > > occurred. With what I'm proposing, we don't even need to do a S=
ETATTR
> > > > > > at all if nothing else changed. With your version, you would.
> > > > > >
> > > > > > > >
> > > > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling=
 for extended attributes")
> > > > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > ---
> > > > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc1=
1c9d5a55b3621977ac83bb98f7c20 100644
> > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *s=
rc_f, struct file *dst_f,
> > > > > > > >  static int _nfs42_proc_removexattr(struct inode *inode, co=
nst char *name)
> > > > > > > >  {
> > > > > > > >         struct nfs_server *server =3D NFS_SERVER(inode);
> > > > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > > > >         struct nfs42_removexattrargs args =3D {
> > > > > > > >                 .fh =3D NFS_FH(inode),
> > > > > > > > +               .bitmask =3D bitmask,
> > > > > > > >                 .xattr_name =3D name,
> > > > > > > >         };
> > > > > > > > -       struct nfs42_removexattrres res;
> > > > > > > > +       struct nfs42_removexattrres res =3D {
> > > > > > > > +               .server =3D server,
> > > > > > > > +       };
> > > > > > > >         struct rpc_message msg =3D {
> > > > > > > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLN=
T_REMOVEXATTR],
> > > > > > > >                 .rpc_argp =3D &args,
> > > > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(=
struct inode *inode, const char *name)
> > > > > > > >         int ret;
> > > > > > > >         unsigned long timestamp =3D jiffies;
> > > > > > > >
> > > > > > > > +       res.fattr =3D nfs_alloc_fattr();
> > > > > > > > +       if (!res.fattr)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency=
_bitmask,
> > > > > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > > > > +
> > > > > > > >         ret =3D nfs4_call_sync(server->client, server, &msg=
, &args.seq_args,
> > > > > > > >             &res.seq_res, 1);
> > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > -       if (!ret)
> > > > > > > > +       if (!ret) {
> > > > > > > >                 nfs4_update_changeattr(inode, &res.cinfo, t=
imestamp, 0);
> > > > > > > > +               ret =3D nfs_post_op_update_inode(inode, res=
.fattr);
> > > > > > > > +       }
> > > > > > > >
> > > > > > > > +       kfree(res.fattr);
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f72=
1cfe01bfc60f5981396958084d627 100644
> > > > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > > > @@ -263,11 +263,13 @@
> > > > > > > >  #define NFS4_enc_removexattr_sz                (compound_e=
ncode_hdr_maxsz + \
> > > > > > > >                                          encode_sequence_ma=
xsz + \
> > > > > > > >                                          encode_putfh_maxsz=
 + \
> > > > > > > > -                                        encode_removexattr=
_maxsz)
> > > > > > > > +                                        encode_removexattr=
_maxsz + \
> > > > > > > > +                                        encode_getattr_max=
sz)
> > > > > > > >  #define NFS4_dec_removexattr_sz                (compound_d=
ecode_hdr_maxsz + \
> > > > > > > >                                          decode_sequence_ma=
xsz + \
> > > > > > > >                                          decode_putfh_maxsz=
 + \
> > > > > > > > -                                        decode_removexattr=
_maxsz)
> > > > > > > > +                                        decode_removexattr=
_maxsz + \
> > > > > > > > +                                        decode_getattr_max=
sz)
> > > > > > > >
> > > > > > > >  /*
> > > > > > > >   * These values specify the maximum amount of data that is=
 not
> > > > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(st=
ruct rpc_rqst *req,
> > > > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > > > >         encode_nops(&hdr);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(s=
truct rpc_rqst *req,
> > > > > > > >                 goto out;
> > > > > > > >
> > > > > > > >         status =3D decode_removexattr(xdr, &res->cinfo);
> > > > > > > > +       if (status)
> > > > > > > > +               goto out;
> > > > > > > > +       status =3D decode_getfattr(xdr, res->fattr, res->se=
rver);
> > > > > > > >  out:
> > > > > > > >         return status;
> > > > > > > >  }
> > > > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xd=
r.h
> > > > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685=
f46136a210c8e11c20a54d6ed9dad 100644
> > > > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > > > >  struct nfs42_removexattrargs {
> > > > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > > > >         struct nfs_fh                   *fh;
> > > > > > > > +       const u32                       *bitmask;
> > > > > > > >         const char                      *xattr_name;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct nfs42_removexattrres {
> > > > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > > > >         struct nfs4_change_info         cinfo;
> > > > > > > > +       struct nfs_fattr                *fattr;
> > > > > > > > +       const struct nfs_server         *server;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.53.0
> > > > > > > >
> > > > > >
> > > > > > --
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > >
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > >

