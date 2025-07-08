Return-Path: <linux-nfs+bounces-12946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF8AFD4E3
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4133BECBD
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F12E5B12;
	Tue,  8 Jul 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5HmhFu+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5372E540C
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994554; cv=none; b=Ldoz8xOo3YVk6pWqMzEbab5Pk1NCWZf4QlisGCF+LCZmgeSrKMyAgSsctFy5zT7WL0Rax+XjTJGhqvRf90uznoD3hAdoDnJc5c8T2xSnDTbYsubp5M2vuLEEwQCuCQZk2I/KsAWvUb28DFrS1t4VvBQC+XWtl5P5hPzJyi0MiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994554; c=relaxed/simple;
	bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHd4g17Fd5usrE1T9TYigi4sVwzidDDaGH0Ze2X8pd5evZDwo7jjPGxBopmqTRx6BdC3BPcY42PVkhsnqk04M9bQPiyFheQTgs6zZSKqqfz8KARDO1JVwx7ZMKKD9Yj7IUbKkOoXCghgE1xn4IV8LK0OeF6Q8/l0P4N2wtHhGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5HmhFu+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751994551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
	b=A5HmhFu+5Q67a+L1SCpnwNT3eHjPqcQGkwjRp/d3cx3eqjlHoTOfJcf9FWEK/eotf4E7Ku
	DitamewhEILeZp+FJMhK7FF+psDNv5FQJA8/rzdg7y1Erqqg6O3uUXp/JZUsPiO9HgfteT
	sXdKbdZEVTKsXA8/5c9YAoFZt4meC3U=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-NMNDWGVaP0qI4Klbk_u06Q-1; Tue, 08 Jul 2025 13:09:10 -0400
X-MC-Unique: NMNDWGVaP0qI4Klbk_u06Q-1
X-Mimecast-MFC-AGG-ID: NMNDWGVaP0qI4Klbk_u06Q_1751994549
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e81285a0958so4556984276.0
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jul 2025 10:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994549; x=1752599349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
        b=TmV1nZYbjDE3mbo+OGfwxJo5cMQvkhy24Y+aC/fmPmx7Fd8gDgUAJUzsb+t1opGDFy
         RBeB66kiAKcypIB9PTnKTUS+pDJzQK90ZCmIR8NqpFrSOfENhYK5uAwK6CBVQRGqmSCz
         zdVmk31Ewp1gcuwpZe3aFTNViLX0DqkNu+MoNerTzxrExI1qYLragTOulhXwBytPlWDz
         GkxTzzvuQ52amIjbhu02C+LGknk8Ytra6d4Oc+6tDwaqRHXD+AFcLSZs/IoyT0jZbCn+
         V7jCP4xTnhs3PkQR7sqq9Trg0cRwNmnnO25skgwRmtfWyTtgjhjfHHivNoJ1D2/nDJM1
         fTCw==
X-Forwarded-Encrypted: i=1; AJvYcCXq4p05I+6uYOLZbRKcr4wLJR1/MRLpUg+nA8KlBG0s+2BDp0iJgme+wxcHzj3jBxwRvl03NHivX5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIhxCDdVwm5bK6yhJ74puVaKUMaTigqjDMUMgUh43ihd4FVP1
	myqOmWKp9Hk+Qa2rhae5x06tEP1yTQ8LhhU2X4G2FvsNOPTnXACLvyD34wWv29AZ3kcRbSZYbD5
	58KmJ7nX507m6Z6ADMuxmrN4M12CieVYSfTpJUY9rzxJbPPr1g+CHfuROzWKUUA==
X-Gm-Gg: ASbGncvCenJ33Ew0X/FuZXpfSETUQRlW6+6scKmKW1xLYEMyNiRM6JtAZJFmcaJGlhu
	euG+tqQsjwP4rXCu+CJJckvn8bERsI7gIy5yQgg6vxOOAyQoGbtTblfAfKC1k6cAd4/ZRkmWPrV
	tjbiQARcw1qlQBMeTAcgHbRMi1+cs4QWxBrHk2Iv9qbyO4/D+/26qULDOafiyFtbRwF77aJSm/8
	xu/WzW/us5gRSuhhNFirjX/vnRere4OKOAQyCDnAxPhfH14ygtRGmeM9TzvRRQLQg5ei+PRQshu
	uW9CZVfcSIxiNvlBKpZDD0qsEV4VM7d3o460Gw8OMDbMuUArbTn8WR/niNvqvglzNZzDWOmR
X-Received: by 2002:a05:6902:18c2:b0:e87:a1fa:3247 with SMTP id 3f1490d57ef6-e899e19ce85mr18420311276.36.1751994548655;
        Tue, 08 Jul 2025 10:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs2nIqlA/XjsJ9BBEjIAiIfZc6drHzP66CbQlGWFLPD0PMyd3cSjQCFW3gOdhgAzsRrexePw==
X-Received: by 2002:a05:6902:18c2:b0:e87:a1fa:3247 with SMTP id 3f1490d57ef6-e899e19ce85mr18420256276.36.1751994548235;
        Tue, 08 Jul 2025 10:09:08 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c44066asm3408792276.28.2025.07.08.10.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:09:07 -0700 (PDT)
Message-ID: <e5afbff5d8a0bb6448305a3f85a51e3772852ef8.camel@redhat.com>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Laurence Oberman <loberman@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 djeffery@redhat.com
Date: Tue, 08 Jul 2025 13:09:06 -0400
In-Reply-To: <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
	 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
	 <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
	 <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
	 <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 13:03 -0400, Benjamin Coddington wrote:
> On 8 Jul 2025, at 12:50, Laurence Oberman wrote:
>=20
> > Both Ben's patch and Trond's fix the failing write issue so I guess
> > we
> > need to decide what the final fix will be.
> >=20
> > For both solutions
> > Tested-by: Laurence Oberman <loberman@redhat.com>
>=20
> Thanks Laurence! I think we'll leave these two patches behind.
>=20
> I'm persuaded by Trond's arguments, and along with not needing to add
> the
> workqueue helper, I've properly posted that approach here after some
> minimal
> testing:
>=20
> https://lore.kernel.org/linux-nfs/6892807b15cb401f3015e2acdaf1c2ba2bcae13=
0.1751975813.git.bcodding@redhat.com/T/#u
>=20
> There's only a difference of a comment, so it should be safe to reply
> with
> your Tested-by there.
>=20
> Ben
>=20

Thank you Ben and Trond.
Confirming that this patch works to correct this issue.
Looks good.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>


