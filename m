Return-Path: <linux-nfs+bounces-21377-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMnhFhFa+GlStQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21377-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 10:34:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCF4BA47C
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 10:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC6D830041F4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F033FE0F;
	Mon,  4 May 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V3c+ECGM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61033F5B9
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883662; cv=pass; b=pOgRPh1uC2HkSgkkj7+t37YZCe8v4i5Fo/a1lWBB35aN2M+BdqIh+WgBEyTrBrpNGdr1moFVNAQzXBV05UkvlIhBttQ4nALqmXCWejze+7aPJCNfYs4ZlmJOamFhL3pf3V+MLcPDt53uG6Mz4P7nB2QGCdtGjbu1kUUgut0jY1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883662; c=relaxed/simple;
	bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijx6RLP2eb6bRCvW9XGFcJbVMnj00sOjvF5f0mhBaY3RdeiEUYxbMiFzKqSXjnSi2ApaT28zyw2uSTfQqDLjnFfAJ2wauY6U6fBK3ZpW+EJH90RdkUjUfhpw4Y9/ubz4/L8OJnm0CoAQCu8WTp8P/NXCoS6DmCZxSLAHpI1qux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V3c+ECGM; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8738c178dso305822e87.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 May 2026 01:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777883660; cv=none;
        d=google.com; s=arc-20240605;
        b=hBj6QEBROzC9/mhAJKNt8GwKwZJi4R5ilCRVJgxZ/x6PHVwpEfT6AxKNsJ6x/xvKZj
         OMKxRxZcmJ2FD6XDTrvG/mvayMh8C4uU+jqLMc5BvCN7UrY8jjXI9vPQyU14zF+NWzBh
         zwHQbBIgj2P+Nc0VfFPlzJNKG+brjWawq/QNniF6G78pc0SeV9Bm6LBiLX/cbLOOj1Bj
         U3xUapp3mq/+DAoqF7VyDErFV2ERxwCA2bIWEWXsEW19V28Wyd1ft+qOOLo85ENizyD2
         opPANGJbWYCKv/1lMn29oZikzYcc8N92kW06sq+QZgjf9vcEooR2W8MgNUPk2iBVpRlL
         GVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        fh=Er5PErZExkm+siDec/tBG9VSlp+QoF3ZJXW9fOVL9ew=;
        b=MInMgwlP3J9Qj42QM+lMSTblDSQhPVNCgZNKOZpgDp4C8ZyxsJ7xx5+oAS9Tumvksr
         p2g4ZoCYiGZNQVsBS6yEbnfHiyEGheJ1LCO1YqapqKxuVOCakbUF4wNUpcbgu/NR3aFr
         THC1i0y+tRhtLFiAcOQ5+YkgrT0DJaYlc7GdrAMXu/OZl3iqCfLLVoAoS5tnk0isUOLJ
         BnSuEWKtbXoT+pSp3oWI5ENR4ulvEmV8yaeUhbpie7Jnvr48G5b73H08ql0XYWqpLehH
         L71av+6hqpxwhLHc9cn6WdoxAnqQyw87NrO4p7SIYl3V4/6onKxcZcyLa6S7iIvoDFKr
         9ptg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777883660; x=1778488460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        b=V3c+ECGMNeNws7cpRZL7mGxuMxzpqUICgNa68nwlge+e5OpJlw++ZUWQwxjEITCT1S
         rege2EqldZOc6voAjo+6QSEVweay7NPemKA9Ewhbyxn10RuIqYgy1iBgJvds1nFHHu4Z
         MM4mjMbYXEhi41C69hjpO4/jHWT4XHp/4rgI+jpF/cjyyIvFIhwsgQqWpREyhbbkA0Il
         9Gi6yx1UVvXQlD/Al/Srhd4lKMrOTtk0ynHo8QwKhDffKCCMDcVYUIzxl1kSKeB3QlIL
         iZZZpWWVx08KDN+zAb8GVDsmCkCsATrXEd3kYeX/paBtAUcUOeDtZgyC4ScKygem0aKY
         dthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883660; x=1778488460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        b=pUkFzyK7ZMYJ4mAyexLJgKbR5eBtKMkatEG7QhkvbgcmY9UPEtw+z6z+bdkOl+J/sG
         RUiCEuFJKy49Zw7QRMyvxiWV5guuKj+4lLywpxHe8CeOPFlq3n0Bdftm7/lxVrnoY6QH
         tYs34DEPw/pXCGDVRXOXOO3lvbCHO1o4gT+W33W97SQpMHwvx0VqrGPZbQxhcGCmeqjJ
         jeYpAauEq6uUgmj7N4pswfSkiyCiyKMhsPqct8U02K/n9OEY8w747krW9Yvr7YSgjoM+
         IrkTvlsLBkKW2n0XavkBEM/HoTuAkyD20VeLo4W4uO2z4rg8b51pRs8SSap9ySy0EWM9
         nFvg==
X-Forwarded-Encrypted: i=1; AFNElJ+0SJuSg+Y/CazcyuHsnRuH0fZADU5heVxW1y6zd9bUm30TgceZNbY46ESaP1fiP4GnDTbbPLxKwO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuqSBNzDr7g+rrtk9X62lmNrLFXE/t2Ot1dqYYSthZG8hFRqh
	0wQJ0QzcyNXKJ81+liT19qXv/9fkaJTu/aYcQcDTbq2i6tXBiFL1rKOUGAK+pzWA0RMpM0fVbVo
	0ZopAkNO16NOSp9OhVl8H8nwF7eQ6KQysT1iTJUQAjw==
X-Gm-Gg: AeBDietrgspsXdA8yGTXGnhLOofDEB5L9aQDi6RQaIs0rag5UaKw/VKyV6AqoQZrgCM
	rXVnPb8/UqlxkiC4//VGnnmoleG5IBDti3ZglP4+rKS8OzZZd91TNt4gwBwEsAo4NV17cmbTFwb
	HCYIgT/R7+EZ8mSly5TE6NPMhpx0Lkp9DClerx3RSNKaw7G4XuwvNDFkjwtB1WAxLtpAA9svj/A
	qWxeXnTLEgPswH2Yu5SMuVH1N3imY0qlrHaYpfkwD30cF+kjTySB6wwVcPaQgvG3r0Hjq2Nl9Wj
	ym4o8ijd5GIoox04KcrI0zyWB2hxw/FCaKQJTf9oLvzd1iULpks=
X-Received: by 2002:a05:6512:220c:b0:5a8:73c3:f27b with SMTP id
 2adb3069b0e04-5a873c3f374mr608834e87.15.1777883659699; Mon, 04 May 2026
 01:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com> <afNguCraI6AvmZrR@localhost.localdomain>
 <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com> <afNvZKtiQPLbi-3F@localhost.localdomain>
 <4edf7abf-8f48-4433-98f0-2ed2d97a32f5@app.fastmail.com>
In-Reply-To: <4edf7abf-8f48-4433-98f0-2ed2d97a32f5@app.fastmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 4 May 2026 10:34:07 +0200
X-Gm-Features: AVHnY4J16ygGjVvEIBbe2vlcSe4Mr-lVUzQBWrZHQB6R7WSpDdVqMuTZa6g545w
Message-ID: <CAAofZF4HSbzEAvHj9--TP7QuogE03GXAhY=qecU4BnXBebemZA@mail.gmail.com>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
To: Chuck Lever <cel@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E8FCF4BA47C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21377-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 5:09=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
> [...]
> The light dawns (for me). That's what I'd like to see in the commit messa=
ge.
>
> I don't have any technical objections to the code change.

Hello Chuck,

Thanks for all your feedback.
I will improve the commit log with your suggestion and then send v2.

Thanks.

--=20

Marco Crivellari

SUSE Labs

