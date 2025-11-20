Return-Path: <linux-nfs+bounces-16632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECAC75EC7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4460E3567B3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943C364EBE;
	Thu, 20 Nov 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="ZZ3aYKum"
X-Original-To: linux-nfs@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5E368DE3
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663525; cv=pass; b=I/6pfh3Qmb5qMFpek9DXc9vALFtdR+RWZ3H5PUodlx0+pp/ua1DJLs5DDjyWhYX6gwiCe9ihbESCisqTL7D8rKN+albLMTg8NGZwTZ9CivzyF8yC2+7l4hbypcsSWXySkOmJDQBNUP+G7sqc+00G5W2pWungGE2xtthcZ8V9tbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663525; c=relaxed/simple;
	bh=7Smpw7PMJAoPpB5OfuMOQbzyN6LfNqOS0BBRMvnXIl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HaPEL4xlbd4riBrpyMHgIdPDtlfEMfH6lPdCwiPXj0tXMpFee0F7i3FGHH4CPYR6ymlYj6xX626FPeMXb1EIUEHVbOihy1lN/idO5a+CFGr2nOQFuZxZRQxdsRbtDGW3I/qbom0ahtUBC3nc7N+uCv3vhvmUwGKHjPBIMpcsE6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=fail smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=ZZ3aYKum; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8376616335B
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 18:31:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.98.42.205])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3976516065C
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 18:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763663517;
	b=ajLFJU52Q5Od8K+R6/iDUqZFLzFlSucnTUYQc9o+ZIWVquoi4Isj4SFygXrrD+KEuTRObr
	BIvWS52IFNKqtv/wBGYPmFXRP4BWlerCSV0PFLWzSObrJyyLCeaZ3Ho7j837pjL09K6tjw
	s0FGSR8n52qQ0BBauGtWermz+zMSS+LtBtjWRTrpC3PoxVnTv4zZe/k+IDnM/ibQPxsTs9
	ifoQZBK0VCa5Mjv0Mwqm1vT6Cz6TWP3cbccO5hKFSVvofT18EYIe0wd0TnT59KplpgyUQE
	bB/iW8g13Qn8mHqQxkc6jhzhttxixTeEkKw/+MvQICG25BgoRsAuZH3mkd7EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763663517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7T3GcxmR31+hAGdLDelyMIQjqL9/G60SU2JlYZhyVc8=;
	b=SZ3Ticmc8N8kDqqkSztq4oK0VGZ/97fW/7VYjWkGw8E+UobDphiYZosYX+KxOAPLRegkeH
	Ex7mvnPDiYK9+k6x5AK+oI962RLpQpIWQ4lEeHI9hduKNtEUpi2z7/GA+5tnjrtCkM26c8
	FKg4GDtd271vsDJw4ep/68Ael2SIkx3Z8feLFOPDMKHsUE4uTmboa4GzYPtrMdeM6rBKsQ
	qJHoHAEIPg7VnX/B0TJ9OrOHqkTDeNjpqWvtPPtkF4KkjJPL0bGAqLfqzfGTnCi4wWEQSW
	X32mqCxplZ5AmbKG9uBDOhsCjglCPBgfDSKgvXVkq7BwyLm8wfp4q+J4x/e7NQ==
ARC-Authentication-Results: i=1;
	rspamd-5ffd6989c9-58p4n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Company-Reaction: 0cfe76c66aea7cbb_1763663517423_2254633795
X-MC-Loop-Signature: 1763663517423:3298016753
X-MC-Ingress-Time: 1763663517423
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.42.205 (trex/7.1.3);
	Thu, 20 Nov 2025 18:31:57 +0000
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4dC6Q45m7Vz107d
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 10:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1763663516;
	bh=7T3GcxmR31+hAGdLDelyMIQjqL9/G60SU2JlYZhyVc8=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=ZZ3aYKumKPEM3LhFzpe0AdH/O2eMhhS+0I8lk1lhzWJ+m44F3PT2PqD4uZZ/Slf2j
	 vYa1NPOM0SZdOi9TtIPZJa6Omq8HULpd82CHr5DvWFf2CLDPl1gJjt9vuHSXF7+mq8
	 Luv8MnxIUi3Qye+SjdNuSFvWIycHpW5MYSh4Re4EWrx2GKe+YIwsnRtnsKdC/8l65r
	 2xQIt+55PCR/rqRVf0+YmZoGK0mEjPMFkxfxrbB77sxq/RFNsnygkpa4rqG9ONMwYW
	 CoDVK+LPli/Pt8Jeo5Vdse9euntLBJJSIW/1BH5rGzHPSccodmWqdm/F6XNhIEUx6E
	 SwANur5K8HGgQ==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3c965df5so707145f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 10:31:56 -0800 (PST)
X-Gm-Message-State: AOJu0YzDDYHBwFO70OojLk7QWU2ol/hXvVfmsws3EZPNOSfZMat3pZk4
	9f0T6c6lc049Pt8symhfA5SI2dPoCioKC5Aj849X4njKnldvyQhlNZeNwiN/NoNy42Fcr6iWjsc
	PXd6JNFm8lIqvm/BH2J8kQ8FfMHVewVA=
X-Google-Smtp-Source: AGHT+IEiiNmMT43SbXOgnUPHMqw/CB24GaPCz25V0jUekce7tr7w/5E39btrHzm49dFST9cekBbuGukZvTR6Hap+Iug=
X-Received: by 2002:a5d:64e3:0:b0:42b:3bfc:d5b4 with SMTP id
 ffacd0b85a97d-42cb9a70875mr4293885f8f.51.1763663515193; Thu, 20 Nov 2025
 10:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org>
In-Reply-To: <20251119005119.5147-1-cel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 20 Nov 2025 19:31:15 +0100
X-Gmail-Original-Message-ID: <CAKAoaQmr4=FzfyjfWd+FYVM+p-AWzu0OB5V2O69EWcxyLPTmhQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkuezvbD60E0kTKIEpCKBVGWdPDtNeF19kULlCEalvLr0rmUULqIcDVYq0
Message-ID: <CAKAoaQmr4=FzfyjfWd+FYVM+p-AWzu0OB5V2O69EWcxyLPTmhQ@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> An NFSv4 client that sets an ACL with a named principal during file
> creation retrieves the ACL afterwards, and finds that it is only a
> default ACL (based on the mode bits) and not the ACL that was
> requested during file creation. This violates RFC 8881 section
> 6.4.1.3: "the ACL attribute is set as given".
>
> The issue occurs in nfsd_create_setattr(), which calls
> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> However, nfsd_attrs_valid() checks only for iattr changes and
> security labels, but not POSIX ACLs. When only an ACL is present,
> the function returns false, nfsd_setattr() is skipped, and the
> POSIX ACL is never applied to the inode.
>
> Subsequently, when the client retrieves the ACL, the server finds
> no POSIX ACL on the inode and returns one generated from the file's
> mode bits rather than returning the originally-specified ACL.

The patch works, now ACLs are working at file creation time for both
|EXCLUSIVE4_1| and |UNCHECKED4| (previously it only worked for
|EXCLUSIVE4_1| but not for |UNCHECKED4|).

Reviewed-By: Roland Mainz <roland.mainz@rovema,de>

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

