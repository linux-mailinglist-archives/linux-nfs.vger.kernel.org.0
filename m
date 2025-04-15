Return-Path: <linux-nfs+bounces-11137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA56A897C4
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 11:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9EC17844E
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C4205AA3;
	Tue, 15 Apr 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgyVGKP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1171F37C3
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708950; cv=none; b=OVVAx8waLJNyafP0OogQTvU0ljgyW0XRzQxKbflkr1eGGJWTTo9cxj1NHJAADP+KcTacpcEyum9TW2w3krGz8H2444UNRClw2VZ/nqrKnlfStA7o3IWwTALfugQAd/2s8fS/g3WpCbHUCIKbxNTRtUEqTEyE4WHCo+ibml33kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708950; c=relaxed/simple;
	bh=L2nWfw2F0tLGeLqEgrlZKJT4ce2TPKIFWvGneYycIcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlKbGRvAhrFUco+QSV9XX3vtOFLgvkqHMoer3xUCu8DtDXkmf/dzYqvaMrgV9bycvZB2EBrRlbPr72lyyNdwfLYt2AD0ygE1pmY2Bo02vTPtr666Xega8SyNpc6lew+W8PVL8gHPSR92LoEg2Opzk0t0Y0EcA1Cl/50CUOYpeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgyVGKP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744708947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwNS1SE90wwYANhRaW3iTs78GQICoY6XUxQmxD7SYsA=;
	b=FgyVGKP3HUefaNwzdWw/UT0HHzJSuZnnhKQ9fV5r6sv6ivdf3YPxVbLXqYGbDh6uGphg9p
	eloIbX59zPGxjlEgIznjSYjjXDp810D0Qgbo954s+VmD9F2lSu9q0UFeUjUnOdaB7i85ea
	hxdF6ix5D+dqkG8XDgXP9UN5dY09eFI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-T41IqS2nPrWPZjd01gZwMQ-1; Tue, 15 Apr 2025 05:22:25 -0400
X-MC-Unique: T41IqS2nPrWPZjd01gZwMQ-1
X-Mimecast-MFC-AGG-ID: T41IqS2nPrWPZjd01gZwMQ_1744708944
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3054210ce06so6975334a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 02:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708944; x=1745313744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwNS1SE90wwYANhRaW3iTs78GQICoY6XUxQmxD7SYsA=;
        b=BxapikGtkmkVneX7Xo8S1BujyK7WkcrD/P7l1N4UftcgPlwdK7RNUSHNmEbK4Z4gpM
         RoC4vIP3IPee62TeIV67NO3FavpMpVOkOxLRIvYwwson5BRxf0V4B+gfbFcr3nfqUoRb
         WTVTCdKJm36h+45H4XLTrbQAZhyen/dfrVmw9xx7f06kVj7aRiA3InIdQcX/uJtNFbk0
         wv1Ncr1camc/nRcOYHrbF3RDnY7owtMc8823Iv32CbbBrRC4g44Afh9TEnCXjBAfSOOB
         JBH5qbXQ8hbjqRANU7iKbY60ktHSnB/SomzWSeF9TaDFTnsb9mffTp8dChdBpT7K1I/P
         2i2g==
X-Forwarded-Encrypted: i=1; AJvYcCXsmhK4FYPFmXTUSjeZ2R9YuakLs2OowNtmUJVIi01zOprGEYmD9zTvXY8LWGKDkzSdvMJytrrsceU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPpxWmf45EL8iZppLhPn0QWS30UaAoAPMNE0lPAVEohw4NiXU
	rtni8ORXdlNfErq6/qswaZ+SAFJDqwt1Ux8JXUQtVlEQAU01zXWHcNP1IBqWbdgrTYbrQ6tedP8
	6l3WGTo/baF+BkYOWr00PV7pogx98Hiq31WBpnq2f64mq+tbQGOjbrK7RanDzpwt8npQl9tNEQb
	cAR43IWEDzSxZfpt7BhhRqQLUyHwuGUyPo
X-Gm-Gg: ASbGncsWjMnDUMy8vwxDM/rDTrF0BzhFai3H4TPEMm1wJPzJJny1rVaeg6QDG9LAich
	AQdS6rtcj0SuXRRMTmV5y9TV7jvGRqpS8IUpPP9azTWsb0LQWoIFTW+6UknEuvOYKzuA=
X-Received: by 2002:a17:90b:2704:b0:2f9:cf97:56a6 with SMTP id 98e67ed59e1d1-30823646dfdmr26106702a91.14.1744708944346;
        Tue, 15 Apr 2025 02:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1CAt76U8SavVKceq8kJnownH+pKS9Scm+WgQR62mshC+5trjXhyT/zpf1OeB3BzbjRRhoyhx28BBh1+FcoCE=
X-Received: by 2002:a17:90b:2704:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30823646dfdmr26106666a91.14.1744708943950; Tue, 15 Apr 2025
 02:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
In-Reply-To: <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 15 Apr 2025 11:22:12 +0200
X-Gm-Features: ATxdqUERFL4o6Oi2kLnJks5OQH5A0wbbTbsXqcyxtDAIb6yZQ1tnBZn6Pj1woq8
Message-ID: <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.co=
m> wrote:
>
> Hi,
> Thank you for reporting this issue and sharing the detailed reproducer.
> Apologies for the gap in my knowledge regarding security_label.
> Would need some time to study its implementation in the security subsyste=
m.
>
> To begin validating the problem, I attempted to run the reproducer on
> Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observe
> the reported mislabeling of the root directory.

Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
recommend using 41, which is the current latest stable release. Hard
to say if it affects the reproducibility of this bug, but it's always
possible that userspace is also somehow involved.

>
> The modifications introduced by commit fc2a169c56de specifically affect
> scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> invoked within a 1-second window. During the reproducer execution, I
> indeed observed repeated calls to this flush interface, though I'm
> currently uncertain about its precise impact on the security_label
> mechanism.
> [  124.108016][ T2754] call write_flush
> [  124.108878][ T2754] call write_flush
> [  124.147886][ T2757] call write_flush
> [  124.148604][ T2757] call write_flush
> [  124.149258][ T2757] call write_flush
> [  124.149911][ T2757] call write_flush
>
> Once I have a solid understanding of the security_label mechanism, I will
> conduct a more thorough analysis.

I'm not sure how the two affect each other either... It almost looks
like the last mount command somehow ends up mounting the "old" export
without security_label in some cases, even though the exportfs
commands that re-export the dir without security_label had completed
successfully by that time.

Thank you for looking into it!

>
> Best regards,
> Li Lingfeng
>
> =E5=9C=A8 2025/4/14 18:53, Ondrej Mosnacek =E5=86=99=E9=81=93:
> > Hello,
> >
> > I noticed that the selinux-testsuite
> > (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> > test recently started to spuriously fail on latest mainline-based
> > kernels (the root directory didn't have the expected SELinux label
> > after a specific sequence of exports/unexports + mounts/unmounts).
> >
> > I bisected (and revert-tested) the regression to:
> >
> >      commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
> >      Author: Li Lingfeng <lilingfeng3@huawei.com>
> >      Date:   Fri Dec 27 16:33:53 2024 +0800
> >
> >         sunrpc: clean cache_detail immediately when flush is written fr=
equently
> >
> > It's not immediately obvious to me what the bug is, so I'm posting
> > this to relevant people/lists in the hope they can debug and fix this
> > better than I could.
> >
> > I'm attaching a simplified reproducer. Note that it only tries 50
> > iterations, but sometimes that's not enough to trigger the bug. It
> > requires a system with SELinux enabled and probably a policy that is
> > close enough to Fedora's. I tested it on Fedora Rawhide, but it should
> > probably also work on other SELinux-enabled distros that use the
> > upstream refpolicy.
> >
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


