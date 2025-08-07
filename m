Return-Path: <linux-nfs+bounces-13471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0FB1CFB9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 02:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87DC18A2EC3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DE611E;
	Thu,  7 Aug 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw2m80ER"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D284A0C;
	Thu,  7 Aug 2025 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525668; cv=none; b=GUdY6p789hz3oo80ogIlQsi2CdCvfxK7Kxrf6KOiIDGlj7kxJvPtQah13KINQfiPPiyHxhA+c0OXdqiRMVoUepbhgvTUyvX6/vwMGLRlPsa0QE0tGbpTfcjikebWNPDqt0hs2u7830OqAlEQL7qeHH5oJ9890Lf/OPiV9fu4WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525668; c=relaxed/simple;
	bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVH7BG+RtyMUi8WxKZZp8pTTNIy14nVN3JLPuPEPo6+gV1l8j3UHFtd40/69Ugg7KwhghkJrSqApOnssOV2zv5Of6ARidILAvCGc/m+07+mI3BhDlUWDzaaSGN9gI5qXJQ/nk8A7jZlnVMMq/pFJ95YEisfEp+KuQuuLhECXrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw2m80ER; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bd041c431so481352b3a.2;
        Wed, 06 Aug 2025 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754525666; x=1755130466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=;
        b=kw2m80ERfv6TptsH71KaE9tpJek7th3oL9DJaMUT3vj0tc6FP0H4zsP9D3DWB4D+/N
         xmj+AKjqo6tUnDluzT3CQBMHnKVL/9h/6tQw4Qv+5yslU+W4SMpFi2VUVnB8Xv5Dp8NR
         +h89MXFgdVD0/Oc5UzwZ96JnbEVobclDp4HHOtz+Kzoc2BCDOLGdgYMCN+RGeplEVFY8
         g88l8vEjzqw2pvDPvtqiwk9tNqu1koYmjvIt69vGSEniITyIhF7GtPW6FvPU9C2Lqhej
         BwgnHybMFdvQIbdDHz3hED1QN83a8XUE8Y2jpEzDNFBVRZ7yqljatPk1e2hAM+qnSFJ9
         3H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525666; x=1755130466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wn7+MLg+mx7R+loSOdJwKVEpmHzJFAcSmm3zYQYHZK0=;
        b=QKa0Ag7wEnUGgZVRohV7sseF2H0BPb3uaTtM2w4JOEGak9l/tEtC1yESSwLMgJi+kR
         lQxK3EekpX7KZY5P+jy0NNsWG7JbZ2DSYxeIe9QQh9ZcnX7KAsjb5Ath+wd3G7r4Z4fA
         v8SDYZQ060w1Rs3SfDLOcrAUtEKuYHqluYNioVJ6/tLYCx6fMQlKnBf2pS46wAbdR7lv
         EJeM2ihWE4ueQrXt+bLeLOvGUnitjzfsA+N2eaQP3LIoslChF+hyFLoXxAChGPuEj3EY
         5Zh5ktTa849LjAmCCNB2NV3+sLBT7M/hcVoGCiYQALq7isd28akzLeHWDAFE+sb2t80l
         ytKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/7pA5Qy0K7Yn+s2yy7FG1LtvZnxYF2KCv5ZiGXipfyuasAi8CB0pOTG53QNk3BJrQzSEVac4uhJBN@vger.kernel.org, AJvYcCVMXh/FsPziy3ZNbXsX4SvcmfEuJpWvvN8Subh2FungrNLCehqvhej7zU7gPC//ymZDFAkGFkan@vger.kernel.org, AJvYcCXAJ7tqnX6jCYIJH7u35arMNtsfakJqon80M6mJIbyRnnyYBPzUVkZyfcnxmKAFBOrauILAVqEuQIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsvh7KD8TqS5qcCe8ZX5RpKIkBYa7Xp/SOCQLQqDwerd/aoqx
	yh0/KlW2bEpGeMq796I7AHEF8ZcHlC0geJNcsDDB63Rv6DWQ+/NDKpz5
X-Gm-Gg: ASbGnctg3vd8vecyzPGvB6ey4XxDY9cIywkY9SjiVrR6e34+GLSHPw2Y5yG8iyBrj/X
	5YUYtev6/UWztIZ9PjOe6oTAEOqKOgT+93gRK31wyTUuqqHGoaqaFeaKfssep+6ZSZLEGS55Gzg
	KmGMCa2w812nr25ml0WXfBZePl7+EWF5DlHKCxWCpI02ABq5EB+lqTPPLGmeybqdWJB9pqwvonH
	4y3COlwTVBdBIhfblWLg4JUeAnslYnddvrEb7NGAjC/HgwxmE0kB1ZJhgxrwr67wC9Rz6bTXP9I
	Mm5zxUcbQOcv192G/5VizHFE/3RWN9DnSNeUVLnjppvJaxACQMUm4QBWgioJtaXT6uCXUNlpOE7
	Q2fgVp6gB4+k/6guZYqmt4uYBcGygCz7FrQ5H9/Q7SpBGSew=
X-Google-Smtp-Source: AGHT+IFv3fICeSVNB66r1CGZa9K57JTbAU/G+cw8lORmFzP1zvxfL+ysyO4WBfOOvQ2rCC3Vekbzqg==
X-Received: by 2002:a05:6a00:2d26:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76c387f6269mr1193271b3a.5.1754525665892;
        Wed, 06 Aug 2025 17:14:25 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm16602234b3a.47.2025.08.06.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:14:25 -0700 (PDT)
Message-ID: <7af292c6bb2c42cead77202a9034fcb6111b898c.camel@gmail.com>
Subject: Re: [RFC 0/4] net/tls: add support for the record size limit
 extension
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>, alistair.francis@wdc.com, 
	dlemoal@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, 	kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	borisp@nvidia.com, john.fastabend@gmail.com, jlayton@kernel.org,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, 	anna@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Thu, 07 Aug 2025 10:14:14 +1000
In-Reply-To: <96ca4de7-d647-47ac-b42f-d76284394526@oracle.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
	 <96ca4de7-d647-47ac-b42f-d76284394526@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Chuck,

On Tue, 2025-07-29 at 09:37 -0400, Chuck Lever wrote:
> Hi Wilfred -
>=20
> On 7/28/25 10:41 PM, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > During a tls handshake, an endpoint may specify a maximum record
> > size limit. As
> > specified by [1]. which allows peers to negotiate a maximum
> > plaintext record
> > size during the TLS handshake. If a TLS endpoint receives a record
> > larger
> > than its advertised limit, it must send a fatal "record_overflow"
> > alert [1].
> > Currently, this limit is not visble to the kernel, particularly in
> > the case
> > where userspace handles the handshake (tlshd/gnutls).
>=20
> This paragraph essentially says "The spec says we can, so I'm
> implementing it". Generally we don't implement spec features just
> because they are there.
>=20
> What we reviewers need instead is a problem statement. What is not
> working for you, and why is this the best way to solve it?
Thanks for the feedback.

Essentially, this is to support upcoming WD NVMe-TCP controller that
implements TLS support. These devices require record size negotiation
as they support a maximum record size less than the current kernel
default. I will add this to my V2 series in more detail.
>=20
>=20
> > This series in conjunction with the respective userspace changes
> > for tlshd [2]
> > and gnutls [3], adds support for the kernel the receive the
> > negotiated record
> > size limit through the existing netlink communication layer, and
> > use this
> > value to limit outgoing records to the size specified.
>=20
> As Hannes asked elsewhere, why is it up to the TLS consumer to be
> aware of this limit? Given the description here, it sounds to me
> like something that should be handled for all consumers by the TLS
> layer.
Yeah great point, I didn't think it through too well. I will address
this in V2 and have the record size limit implemented in the TLS layer
without involving ULPs.

Regards,
Wilfred


