Return-Path: <linux-nfs+bounces-18883-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mh7NheJjGmHqgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18883-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 14:50:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55132124F24
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE03B3015850
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC9315D3F;
	Wed, 11 Feb 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR/238IG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up8uyZ8p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BC2D0C7A
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817811; cv=pass; b=inYZlWUKsEPQmxrVi6AYpyz50CQthDl9nJFXbRxIKTJgXHBFe3P0KgbgYPJeEkm0JFd4LsmSoM4ieF7E7jfcEC93mY2ljJC5Z0hf2VBUWWw81b1AlujeBBdo5sn9i/CaBBS5xuAOcuAoz1+iZjj058a+nCJilBMkstO+r5gOWLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817811; c=relaxed/simple;
	bh=9sZWJXMrsvFSIpM2gpX8H/TzEeebXEBNrwxUqhUTzq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GL+8C4J1YFEB+S21At2t6xTexIvPVFv+TYxSAL3wGXh+LJynNlT7ONXs7EJVL+0QpSvT2EqV/YA1KdvZKbzNrnTr1Y4G5wRi61BjSE0Cd+YHAtd7fyPyhQm5cqHe1r7gja7p0ruEp/GyQRh+GfSaeYeuY6OxNTJR7TCfuSOKSsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR/238IG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Up8uyZ8p; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770817808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
	b=eR/238IGT8jTn4sdPWxALomPmhLJ9TURIwDpwULelgISUfh6cqH8X1crohw0mHWW/lNjvl
	T1qFo/+ac+nIyVJ4EaHIKdxRCXFctPOW6tf0VbfW/4LtHituayTA16vcBVhzk6Tt6cczt7
	kDDhKE9484QaK8E8UGqkQRw7oqre8JI=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-KHHr-TQQN_qIWwSjAn1hWg-1; Wed, 11 Feb 2026 08:50:07 -0500
X-MC-Unique: KHHr-TQQN_qIWwSjAn1hWg-1
X-Mimecast-MFC-AGG-ID: KHHr-TQQN_qIWwSjAn1hWg_1770817807
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-649f0d26e5eso6956030d50.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 05:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770817807; cv=none;
        d=google.com; s=arc-20240605;
        b=UR0+Jx6RkjOVcby8DzobE7SkHN1FfccRzRIp4v5FA8MLGD3lk7tmS1GBx6zIZwM8P5
         ZDz7J4JLiVU+A37cEuLlzLTDoVCvSrVFOGnDIJ7mRFbi7I9j8lwAxax2BqjCJ+xygBy6
         NLFFpAM7jmMnsYxld/VEtCgAd0x6Tg9Z9H+QnTi6d7yddr1BaCnoo5iC79Haa8Dogdqs
         tZm9ONf5Z6f+ZP0VJbm/PSZvLL8gTX0pug/gO8BsioM3t/vu4vQVoAhf0mbPMcXouc7y
         Y/vWMgjY9KvsFOTdgGYiJb9bXIyBl7s8E6yIn2NGTD6JdU73SgjFEF4U/q2aDD+KH8Af
         VLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
        fh=ySyllMYeJ9xtFyYTtxTpiaAopgjAC9ZIZLbcHClCjXE=;
        b=KGVpw50qBE+84GQXxiSLtOc0hgxm4HCi4Hos7QkC1HbX4vEDMSSTOXbnfGSi+KzRvS
         b3HRMEcX5hGTKY8ZQNopjIv2BjsSzM+0CKZU72bnopoBfgJaFdNKXwZg9eWd+YK3k+at
         zV4PGBBpGzbiJVw2poVMS0SsAK/+1ihnR1Vh/qDPEoJGA6Hzy1Rwy2+AYwR+LtJ8qT2t
         fpfwjgA4Mv2brrwutcY1w9Ct2+/QIZqsOwrkJeoU58LM64A2cLRI3I1FUuIJQL+jeoH/
         bsSzHlYKCDZdDu4llb22K+dpLIFeFRLpjOCbpIyB6egxapmsC9U1ngAI7wGI6h5gmFlp
         P0qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770817807; x=1771422607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
        b=Up8uyZ8ppUWl6aBt6Jl960luNUXobnReYdrQHNdnqiCIGfnfxO9aQ9K7nZNP8koeeI
         Xega/NqaYK07Yz6v5f3ctcmZ3LUu02jCXLVVwafXPqkrf/b4rlGCs4ns103Dd8I+swAN
         D8+9cByOq6g7Tler8hoShPmTEo5FxLUgvCgqJu4M/oH5JhQg3L+eXGbOeWtqzqfJWykT
         YBpWYUgmS9Mj/p5UB8167o28yc33uUFU3BRzwMAfKiYp8wlnB6uQ3yalXxPFN9t0bAiM
         pLk1NGIdVwQcFsINq26jlOeT4qVQJUy5Trvf4aZLkku2Qrrv+4z7viB2E9ayU8F2GgZn
         g1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770817807; x=1771422607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
        b=U0Fg5M/+nnad1siV+aP62meEB96LRWmKYV487yfIzCxdACtJgMhGdNkNXA6sF6IjeP
         C2GhOjm40qo0fA6Wcu7rR8qFli9aK0F4lS7vPrJLt3gAuzEAo+liFDhaNXiiFkMOSHHJ
         dbGPDrVNWasdncAvRmLhC9JOH4hTHWxCFWk9Ev0SmXHfy6lHmB+9O+frE8EJ5Q8Mcq46
         1RLSovMFvpu+/ydnGc4m8AQzPcQE3fK3dhDA80VTT425hPVazSVmp4FZK3PsqCS2n+rd
         vTCGXvPkq/xAn2bJcyeivQqGj4eOkuS5jT9ix8zQ2lGfIq/pBLoVhRpS0McAz5UCcR8+
         FQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWh4ot74VhQ1oaL3ME443w+CfRL3rH1tMvmgeBbqsA+/puxNDY1SoDBK6b2RNAkSNDkZw8e5JfdQJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEKqVM2U7H3Tcjs0BJ6RH3RaX8Bj0odUmjJie5gLX9xlxd9d1
	AZ3xhzrTJozpHRgTIcMO0kNdTKujB6U6rflWkSagDc3uwdQbAl/MrqBHCtS4qDHU+HNu+PFY7uG
	XSCkGN1JkVi1HTjFhHdCcSrbWVct5N28dyTp7y+iK0zbtD2Kd2Sv7L8FuDoHsonCH6stxxKmmDy
	AF/cTVYaiGe8LkDbRVBxzDyZ35uMF+mM+QXTpd
X-Gm-Gg: AZuq6aL+uI3p5L+asmuYKB+2Er2dyMqYX68eb9na5IW52cM+y1LcQtN1VjUtISCD7ep
	ZJjbYxlg66JMYawlmKRYbeao/HG3LqaWi0/W2keASx1ogU5JK31tai3/DEKdEk15KvtfBKi/2J7
	hbbyK54bspNgEJUlt55fMKZGWfCQsDGLPtB2Bgm0II0Pvtdyl6ONedgiw6XQ59I85Pu2RQW3LUt
	4f2+kaxCsY4oWMjNEh4TXYdDL0safExn41MT/3Lc0kOsPUb6ndSSb0KCdCSxV1aPg==
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id 956f58d0204a3-64afe30abbcmr1311178d50.25.1770817806886;
        Wed, 11 Feb 2026 05:50:06 -0800 (PST)
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id
 956f58d0204a3-64afe30abbcmr1311156d50.25.1770817806461; Wed, 11 Feb 2026
 05:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260211070533epcas5p32f50f317b20250bb61b1b5a0b3a2a5d9@epcas5p3.samsung.com>
 <20260211070057.22001-1-kundan.kumar@samsung.com>
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 11 Feb 2026 14:49:55 +0100
X-Gm-Features: AZwV_QjumAFlbk9ZsPEeDmvoG4FkvqsDNDq1VBbfmeKSRae7isamuXkM1GDbV04
Message-ID: <CAHc6FU4O4YTm-0cU+kpqY2L3BRaA_Jsyh20tTk2KjmGN7-kKCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Avoid filesystem references to writeback internals
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, trondmy@kernel.org, anna@kernel.org, 
	hch@lst.de, brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	djwong@kernel.org, pankaj.raghav@linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com, 
	mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,linux-nfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18883-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 55132124F24
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 8:13=E2=80=AFAM Kundan Kumar <kundan.kumar@samsung.=
com> wrote:
> The series introduces writeback helper APIs and converts f2fs, gfs2
> and nfs to stop accessing writeback internals directly.
>
> As suggested by Christoph [1], filesystem code that directly accesses
> writeback internals is split out:
> [1] https://lore.kernel.org/all/20251015072912.GA11294@lst.de/
>
> No functional changes intended
>
> Kundan Kumar (4):
>   writeback: prep helpers for dirty-limit and writeback accounting
>   f2fs: stop using writeback internals for dirty_exceeded checks
>   gfs2: stop using writeback internals for dirty_exceeded check
>   nfs: stop using writeback internals for WB_WRITEBACK accounting
>
>  fs/f2fs/node.c              |  4 ++--
>  fs/f2fs/segment.h           |  2 +-
>  fs/gfs2/super.c             |  2 +-
>  fs/nfs/internal.h           |  2 +-
>  fs/nfs/write.c              |  4 ++--
>  include/linux/backing-dev.h | 11 +++++++++++
>  6 files changed, 18 insertions(+), 7 deletions(-)
>
>
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b

Sure, that won't hurt.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>


