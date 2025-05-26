Return-Path: <linux-nfs+bounces-11901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0620AC37D6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 03:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9114C7A832C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AA3595E;
	Mon, 26 May 2025 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLfMKjxg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13720ED
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748224383; cv=none; b=V4EinvOGV6XZ4rmZ3Q81QbpOMmmq80SeDOrsFeY0d3eI3zKSQU5ZGtn42iw4iwrWFNlty9ImLP/2znsSPObTyngyNGIyRoqYAhkT6Ux/ak5uAnQXE83ZaJyKiwcnovzbiIMq51AH9axwgwXwz7AK0QiLr1h0XcLKT1h8NiF1uDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748224383; c=relaxed/simple;
	bh=JCD6U7OhjA9reJQ/cpul3ZwxqiSZzF11h/zSjeBI1/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIyja1BOEJFmbvYmR5a+/yqic6y1L+NXHSDTRGdrPlEcrPg2HXYhLsYj8DuO0EsAX+gekNIqJSCihiw2z8eUrXyydyFceTsDGjQF558C6RF7P/bSF9Tsb3SO6lRH6TIMkhdS3pNGM6JkP/9yuIP0yFTQrp4xHpMNyeVH2utvLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLfMKjxg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso2866323a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 25 May 2025 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748224380; x=1748829180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEPMPOOxrqETTMo7cX/7CXAp2ZlHxPxxgQqMQ2qkUr8=;
        b=gLfMKjxgxUxnrhZKOo6jcMZtAvUX1XXLsaZZoqiUYmQi3eWSf5443WnP2a3nweLAjC
         laD6y0yeYyaTe9R4WneaqGRkUpq9n6SrHQ1/s8UhY/uGgUQ8jLR2hn9RzUTJFzlvJN7Y
         II+7c8fb/wUG0uchmJyVrmMfxrnObUzR0jJSQAG3dedJl74zA0n4rdqPFP+FrXJMwAMc
         +z4JtyZl1zdoFj97Bp9soG2fnoPEilAf3b9sR63m1n5eNgPD3uo3CAKy6Hl/c98H1l0a
         drCWdrMeZsMBIuhcifG6/IYtBL2hC/fB/x0hKXCk64AtC4e3RcC42vVRpjr4IYdsUcrj
         Qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748224380; x=1748829180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEPMPOOxrqETTMo7cX/7CXAp2ZlHxPxxgQqMQ2qkUr8=;
        b=bqBgI8o7r5Cgq7VVRT59Iu9YVTYU8VEveaxGH3dh939mr/2Aze5ZiLTq4r/0eWNRJ7
         udINEfyT9XkVHInAjIyDX3nd3T42DCqCmjbVQgfRijbIsCsm/ocpVbMrZd8sR2dh1n7j
         as67/BMPAv8WfI85qLfYZ5YTKj/dU+2kw7CF+WARl6e3pHatBb18OdRiX4SKhMoI2UUc
         X7XAcDAztqTQJJCly8SNa7BiSbbsIq1qzaTQaZi0lZnWhT01mE6Z3gdszLwh/gA6zVMx
         cID0TZ84MMc8bKl+H8u0XTrWYUCFH814sHkwg6HAc9BO+uALjq8IX4L+9aRHxE0cCXIL
         /tJg==
X-Forwarded-Encrypted: i=1; AJvYcCUGtpxod78gGOH/odJN9b4y/5vTrSNxzfLiPrw82wwYjUAGsYOVoOerbmnU+AkPmhOSr1D8GGVie9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8GeEQGNSNbwTaS60GtT968D+ge3TS5Oic8GuceqX5aLnmB+K
	QlmaB0lKhlM6oAbcylGn/2hOBnL8GyngxIEXmB9HRQnaJjhiYxnhFdvQ1nTkRhRfAPf4UGY4ZAO
	YYDLemsNGW26j1NXA1hAFeS74eTebYpSKDcqlKA==
X-Gm-Gg: ASbGncuSx26+EBUNmJjRb0RCPmhDOBtSRBuXdevE2xXL5C/KdpheRlqwUdj6YY6g7QP
	Fn65yhaRxH8Yltsyl3Jjk5CHoafxQSzOgMIoxM+InnjR2qQMTKBSQg8tdzLP+MW9KxeoYdrk2SX
	Dhj9vf7vrS3TKJ/Phf1pvbgyC4PXretl3ij12JLcrcxUQYGzq/kPH5cnGj7Rb3e1o=
X-Google-Smtp-Source: AGHT+IF3sa80vIIW5j683VnAnqY/1koJxcZMS1XXlTLHDvkq+D1VnjKipWg+qk0ZuSsJU/h4Of2b6Q6CUTMNRbBWbm0=
X-Received: by 2002:a05:6402:51d0:b0:602:225e:1d46 with SMTP id
 4fb4d7f45d1cf-602d9069d58mr5305771a12.3.1748224379556; Sun, 25 May 2025
 18:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name> <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
In-Reply-To: <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 25 May 2025 18:52:48 -0700
X-Gm-Features: AX0GCFscR9OjdjQ-QGtRmMHW38xbwZU-ynXZunBI8RCfEpXd2sdM1LWKg6RblkY
Message-ID: <CAM5tNy6M96LQKSj6Pp3csQ6kETC7-cPaSByoSASH-+eGji-WoQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 6:47=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, May 25, 2025 at 5:09=E2=80=AFPM NeilBrown <neil@brown.name> wrote=
:
> >
> > On Mon, 26 May 2025, Chuck Lever wrote:
> > > On 5/20/25 9:20 AM, Chuck Lever wrote:
> > > > Hiya Rick -
> > > >
> > > > On 5/19/25 9:44 PM, Rick Macklem wrote:
> > > >
> > > >> Do you also have some configurable settings for if/how the DNS
> > > >> field in the client's X.509 cert is checked?
> > > >> The range is, imho:
> > > >> - Don't check it at all, so the client can have any IP/DNS name (a=
 mobile
> > > >>   device). The least secure, but still pretty good, since the ert.=
 verified.
> > > >> - DNS matches a wildcard like *.umich.edu for the reverse DNS name=
 for
> > > >>    the client's IP host address.
> > > >> - DNS matches exactly what reverse DNS gets for the client's IP ho=
st address.
> > > >
> > > > I've been told repeatedly that certificate verification must not de=
pend
> > > > on DNS because DNS can be easily spoofed. To date, the Linux
> > > > implementation of RPC-with-TLS depends on having the peer's IP addr=
ess
> > > > in the certificate's SAN.
> > > >
> > > > I recognize that tlshd will need to bend a little for clients that =
use
> > > > a dynamically allocated IP address, but I haven't looked into it ye=
t.
> > > > Perhaps client certificates do not need to contain their peer IP
> > > > address, but server certificates do, in order to enable mounting by=
 IP
> > > > instead of by hostname.
> > > >
> > > >
> > > >> Wildcards are discouraged by some RFC, but are still supported by =
OpenSSL.
> > > >
> > > > I would prefer that we follow the guidance of RFCs where possible,
> > > > rather than a particular implementation that might have historical
> > > > reasons to permit a lack of security.
> > >
> > > Let me follow up on this.
> > >
> > > We have an open issue against tlshd that has suggested that, rather
> > > than looking at DNS query results, the NFS server should authorize
> > > access by looking at the client certificate's CN. The server's
> > > administrator should be able to specify a list of one or more CN
> > > wildcards that can be used to authorize access, much in the same way
> > > that NFSD currently uses netgroups and hostnames per export.
> > >
> > > So, after validating the client's CA trust chain, an NFS server can
> > > match the client certificate's CN against its list of authorized CNs,
> > > and if the client's CN fails to match, fail the handshake (or whateve=
r
> > > we need to do).
> > >
> > > I favor this approach over using DNS labels, which are often
> > > untrustworthy, and IP addresses, which can be dynamically reassigned.
> > >
> > > What do you think?
> >
> > I completely agree with this.  IP address and DNS identity of the clien=
t
> > is irrelevant when mTLS is used.  What matters is whether the client ha=
s
> > authority to act as one of the the names given when the filesystem was
> > exported (e.g. in /etc/exports).  His is exacly what you said.
> Well, what happens when someone naughty copies the cert. to a different
> system?
> --> It is true that verification will show that the cert. is valid, but i=
s it
>       valid for that client system?
>      (Not checking the reverse DNS name makes the check somewhat weaker,
>        imho.
I should have said "reverse name lookup" and not reverse DNS. Important fqd=
n
names can be put in /etc/hosts and the system configured to look there befo=
re
DNS. If that is done on the NFS server end, a problem with DNS spoofing sho=
uld
be avoided, I think?

rick

>        Now, is having the IP address in the cert. and checking
>        that stronger.
>        Well, maybe. The hassle is that the certs. all have to be replaced=
 when
>        some network type decides to reconfigure the LANs or move the syst=
em
>        onto a different subnet for some reason.)
>
> Another way a cert. can be protected from being moved to a different clie=
nt
> by someone naughty is adding a passphrase to it (the -aes256 option on
> the openssl command line when creating the CSR). The hassle is that
> someone has to type the passphrase in when the system is started/rebooted=
.
>
> There is no perfect solution (or security is not a binary value, if
> you prefer), so
> I chose to provide as many options as I could, so that sysadmins could ch=
oose
> what works for them. (Of course, they need to understand what is going on=
 and
> documenting that can be a challenge.)
>
> rick
>
> >
> > Ideally it would be more than just the CN.  We want to know both the
> > domain in which the peer has authority (e.g.  example.com) and the type
> > of authority (e.g.  serve-web-pages or proxy-file-access or
> > act-as-neilb).
> > I don't know internal details of certificates so I don't know if there
> > is some other field that can say "This peer is authorised to proxy file
> > access requests for all users in the given domain" or if we need a hack
> > like exporting to nfs-client.example.com.
> >
> > But if the admin has full control of what names to export to, it is
> > possible that the distinction doesn't matter.  I wouldn't want the
> > certificate used to authenticate my web server to have authority to
> > access all files on my NFS server just because the same domain name
> > applies to both.
> >
> > Thanks,
> > NeilBrown

