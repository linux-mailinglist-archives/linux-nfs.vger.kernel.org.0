Return-Path: <linux-nfs+bounces-21316-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFR4BXyf82ly5QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21316-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 20:29:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EF4A6F5B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 20:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7688D3003733
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 18:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875CA47B425;
	Thu, 30 Apr 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QFqE9h7v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFF478E59
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573749; cv=pass; b=q39XTLEvmSxtCBmbPAF37CSLdCaN1Teh0r4n3Eq97pCBZDFDRXq/8iomEje2d03Mh8HmH7U62LYJZDR2H0aNApBQ6Lu1GQzCAcrh1Uvhhu9zWxO1LS8eJPPF/FxV69EdikuSJMdeNvi1nRY/QEt4/OiwxuAghiH2N7h/OQPjJpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573749; c=relaxed/simple;
	bh=QtjbpTul/q+YDhUT1I2dbqEH5sqLyyKh7xBDnFDQL2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjW62GxOJ46V2gVQMywTzHgAjv1KvbDzjftBWPggVD1OiB/ycWpIcMM5Di4erfS94RzTfRGsxSYM9xl+1DWKKCIjI135EyMxFnfkI4ggSrs4bmJFbh/gMr9LGmHTWYUeNzHXR7HS671b3L45TU5RmQuBlbxbotLV5R+ExN3VqVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QFqE9h7v; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dcdf60427so1112993e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 11:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573746; cv=none;
        d=google.com; s=arc-20240605;
        b=Ne3iezmT+cNhmybCKl6dYko92l9ReoWMLLP5FUuR2ZWEBzvhWfe9MvMHwKI3XGgEiW
         DgxZvLR+EkjN1YTitGPobjq4UZ/9HkNPlMnqpcBA7vkUcEMCXCf1y42Wb7um1JAn0bte
         BfJfDGHiUkQK0GUMFYZYtUTT1IvU01CDkg6vU4j9Kl4/dync1HNmnZuoV3bMm6zhMLlf
         GLJI67YtrpHq94JH7DuXZeBMArk3RCC25iB9qEEA1M+SFXNYdnV2OITHNFIa9Efi04kB
         r5lmzZLSvMIf+lt92EO20Kbo2nvXJcCR55uN6rMI7Gw7Cyo3NSSXiNyadfTQQJpH++vE
         cbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C8hnA1YdJv0IexhIz5FkW9x95hRNHDhihJuAeNnHUIY=;
        fh=EDOU3vQtlA2K0jVf+p1i9U6XmNOMBnIM2A6SBApZkr4=;
        b=FlOw7W44lGsNpj2cKURXWkyaDmxpvFa2c3P5RUSoGnSGlctJGLXSrq7fkBbWZ2ix1m
         YA7BQV0HqFPylqIjTahjAPyw1qd+1PmRkrVHmZS6yN6qYBc7JRFXvUyZklHuFf8buc0n
         Rmh5SBu+o+275csvqto1irZlRu1eZdmEnDGba3Pa34I4WAvspKRDtt/+kKe5ztLw4gLo
         p33enQbL5P84Ksi2Cyu4JI5lBAxoWFdTS17lvu1/xO5BwoopnhrJjOvniCLyYZ1m6zND
         NJ2tjJOGmQXMwwxLWFKJZEUfKpGGFVQHTgh2ghzIneM+EhRtWtAiNHPxWcoOsMW0rdfg
         fkSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1777573746; x=1778178546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8hnA1YdJv0IexhIz5FkW9x95hRNHDhihJuAeNnHUIY=;
        b=QFqE9h7vQd858TToVGkPHgmLICW51+/WHspWSPmUmLx9uDrqa27AD0Pkho6WCvBjin
         lrZj4Sw6ZeXCzOO94v+hSVELmKxGzQd4ukyhPgy24oNjoiiD/6pg+Hy4Ex5JvYo61tlz
         mHM5AdOZ9J5bPAT2omDfX3/5YufOQQU2W/50ptRD7OP3iGu9OXVysIwUpy99ErnShKG5
         8JjlCM8gpXEcqcnYzoatuiGHNTtGYxuP8sAOCK0TI9vIPfWeFtp4U5uBtNqdv0Go9IyG
         39Xu40AfvGdedIzI1/0a+6EEMsGy4gcdw2YnuVq+BQPGK7FqWDOfkVIqe/G9Ac3S3Y57
         vY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573746; x=1778178546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8hnA1YdJv0IexhIz5FkW9x95hRNHDhihJuAeNnHUIY=;
        b=VzlsZJfEU8ICTn6nKhaj/IdBOJV7k/7ojAZoc+toDtzbqMt35vFJqqjKZpNfxN4msK
         aUHOIdbqbTHHFaHyVSVwB9dJIcTqOmlWu4BxIkhNY3tXAqlOqB1mWkbvfFqgfvIjiJSd
         5vmsRr9XHOLspcbgy+20ZLhnxlC3rgILfmvO/gUo8fUr++Okz86OwOSRJRO7pKZHOOts
         zaGuai/3j6hNW0vlXdLKZmu/i09UlYKg7sUzhzVhMl3hBMzUbG+IdT9vf+7HV3ZwWYyN
         cByqjGbeEm+OccRGxDcHfPzH3xTS9RQGyUa9CExyefdKkKG8P7xqaI/IIOEvZ/mDzgwE
         /GhA==
X-Gm-Message-State: AOJu0Yxmu4mLGuUMbjeRj1ZzLaIFnYEXqpepWeN6ZJg7Ko0u6cZJenZD
	n9lpwLommqMaQ38paCLKtrTIjPvFlQP9p9yxA6Q2dyBgF3vrTpUDfByKyTrb9AUVXNDKHXDOHk+
	A4qcQaJ7iHzQMQhtakNhiZqIXpzxDv2n3jw==
X-Gm-Gg: AeBDietuD2S2WacMPM7gh11Ef9+r5xJ1O6xKB3OsD50N71Ch2y88CgZMVCHENl01JnX
	ZzOsHz0+YNtOvDU+krl28u+Z3jzWj6JfvJWrX9kth08kGDOaSa1tNwvzBhZ8J/1sZAL/DSPFyJf
	CiS7mBPDp0TodMElQ9rq2KqRgxGemF8NfKE1Mm8Xr9zuZQfUPsjM4EYuBaSXIyNx1XYVddahXMZ
	xDWnA3YVqlFdRhuzTomtk3CZw4A7Uj/sg8fJ5RqQ+HoT6IQev/NY02a1GsfC4rChBJXkaezqYoi
	WEx9oGOSFYnF/5Ay
X-Received: by 2002:a05:6512:b14:b0:5a1:3437:84ac with SMTP id
 2adb3069b0e04-5a8522db2a3mr1747229e87.31.1777573745327; Thu, 30 Apr 2026
 11:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com> <baa0afef-f004-4ee4-945c-8992c05e7d2a@esat.kuleuven.be>
In-Reply-To: <baa0afef-f004-4ee4-945c-8992c05e7d2a@esat.kuleuven.be>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 30 Apr 2026 14:28:53 -0400
X-Gm-Features: AVHnY4JM6kGTjtfHTgV61WiD7o0K4Z39Cy6kkdk_G9SMVp5CdfovDN3RqL7FC64
Message-ID: <CAN-5tyEec5qG7uC0UOHKY0WSsRRE30VtOjDoOX87z89X7UAiWw@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8B1EF4A6F5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21316-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid,kuleuven.be:email]

On Thu, Apr 30, 2026 at 2:08=E2=80=AFPM Rik Theys <Rik.Theys@esat.kuleuven.=
be> wrote:
>
> Hi,
>
> On 4/30/26 7:29 PM, Olga Kornievskaia wrote:
> > On Thu, Apr 30, 2026 at 2:54=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleu=
ven.be> wrote:
> >> Hi,
> >>
> >> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo)
> >> that is an NFS client to a RHEL10 server.
> >>
> >> Lately we've noticed that NFS performance is very poor for certain
> >> workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and
> >> now 7.0.2). For example cloning git repositories is extremely slow.
> >>
> >> Looking at the server side there don't seem to be any saturations of t=
he
> >> disk or network subsystems.
> >>
> >> I've taken a network dump between the client and server. In that dump =
I
> >> see that the server frequently responds to requests from the client wi=
th
> >> NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these
> >> mismatches? Is this always a client issue, or can this be caused by th=
e
> >> server?
> > This might have been fixed by mentioned patch below. This patch will
> > be included in RHEL10.2 release.
> >
> > If you have the ability to change the kernel on your NFS server I
> > would suggest trying some upstream version that has this patch
> > included to see if the problem goes away or wait until when RHEL10.2
> > comes out and test it.
>
> Thanks for the hint! Note that the client can still access (some) files
> on the server, but it can get really slow.
>
> If I read
> https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.=
com/
> correctly, I would expect the server to send this response for all reques=
ts?

If I recall correctly, slotid=3D0 was not affected but all other slots
were (the ones that were previously used but then went idle, then the
server (accidently) resets the client's session slot table by setting
the highest_slot_used so client resets) Then at some point when client
starts using slots other then slot 0 it ends in this SEQ_MISORDERED
state. Again, I'm not saying this is your problem but I'm aware of a
problem in RHEL10 which looks like what your network trace shows. If
you are able to get a larger network trace that captures the use of
non-zero slots that ended up getting SEQ_MISORDERED we might be able
to confirm or discover something else. But I understand that capturing
such trace isn't easy.

Fix is also in CentOs kernel anything at/after kernel-6.12.0-201. In
case that helps.

> Regards,
>
> Rik
>
> >
> > commit 1cff14b7fc7f31363c39d0269563ce75c714f7ae
> > Author: NeilBrown <neil@brown.name>
> > Date:   Thu Oct 16 09:49:57 2025 -0400
> >
> >      nfsd: ensure SEQUENCE replay sends a valid reply.
> >
> >      nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encod=
e a
> >      new SEQUENCE reply when replaying a request from the slot cache - =
only
> >      ops after the SEQUENCE are replayed from the cache in ->sl_data.
> >
> >      However it does this in nfsd4_replay_cache_entry() which is called
> >      *before* nfsd4_sequence() has filled in reply fields.
> >
> >      This means that in the replayed SEQUENCE reply:
> >       maxslots will be whatever the client sent
> >       target_maxslots will be -1 (assuming init to zero, and
> >            nfsd4_encode_sequence() subtracts 1)
> >       status_flags will be zero
> >
> >      The incorrect maxslots value, in particular, can cause the client =
to
> >      think the slot table has been reduced in size so it can discard it=
s
> >      knowledge of current sequence number of the later slots, though th=
e
> >      server has not discarded those slots.  When the client later wants=
 to
> >      use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the serve=
r.
> >
> >      This patch moves the setup of the reply into a new helper function=
 and
> >      call it *before* nfsd4_replay_cache_entry() is called.  Only one o=
f the
> >      updated fields was used after this point - maxslots.  So the
> >      nfsd4_sequence struct has been extended to have separate maxslots =
for
> >      the request and the response.
> >
> >      Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> >      Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-o=
korniev@redhat.com/
> >      Tested-by: Olga Kornievskaia <okorniev@redhat.com>
> >      Signed-off-by: NeilBrown <neil@brown.name>
> >      Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >      Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> >> Should the client not recover?
> >>
> >> Regards,
> >>
> >> Rik
> >>
> >> --
> >> Rik Theys
> >> System Engineer
> >> KU Leuven - Dept. Elektrotechniek (ESAT)
> >> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> >> +32(0)16/32.11.07
> >> ----------------------------------------------------------------
> >> <<Any errors in spelling, tact or fact are transmission errors>>
> >>
> >>
> --
> Rik Theys
> System Engineer
> KU Leuven - Dept. Elektrotechniek (ESAT)
> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> +32(0)16/32.11.07
> ----------------------------------------------------------------
> <<Any errors in spelling, tact or fact are transmission errors>>
>

