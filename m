Return-Path: <linux-nfs+bounces-21244-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHY5IY938GlgTwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21244-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:02:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF41480D07
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45550306704F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C023CFF53;
	Tue, 28 Apr 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slQJt4uK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374732580F2
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365738; cv=pass; b=dnuijUEfjb/qHECS7Z0Tn2A+rU9+ncGJvLSfSZWcT5f51PClmxd/J4mS0SsKxIPAseDT8jPEFvO6Ihe8HUJRa0Et68O7kMwBmQdMlku61ekeMmAMVgFvSbKsaE8Rz8llyV2v88VsnskzaCvE6CJbwtZbX/o/B4ubwOjvqqgY6ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365738; c=relaxed/simple;
	bh=r4jadazlBFvDwLcmnJGW62NBtGRbnAEUuBnmXckHh/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aBOWJPbUtQglgcs8YoDjii1qBjyLhI31uVVyAo+E70fyvaRKxMHv8z/HToYDhcYA3X4gktcmnlmH3+3j+j2pD3Fc+C2xLGxWsVhw2pDkBWkWfgI/PtTLD4LFMiYPEnZSPChp2Cw0UGuGyPo8OQgA0nFmm8Thlvq6md9xmFlHuO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slQJt4uK; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so16865143a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777365735; cv=none;
        d=google.com; s=arc-20240605;
        b=PZGNqm9kvJVcG0bklwGTBMYrHnxeUVGoSOhJaLvoTe/9PCoTjF53rQn2j9it7KC11G
         ImwpD7Sgnrw0p8AspFjKk8JZsnLdqZpGpL5w6PEN0WLk2r6AYhRVxwQjH+MWb4X3T1I2
         hnLCXsJYquXxSlxQebuG21b3p5wos6XwGxu68MG/fXM4yiPPiDDs8oAOWVVUyDg09AlS
         BAO694EGlca6qFG/2I2BMuwo3C39mlVosKjJRrkFO58QAs6EDJ0Yo4huy81mT/yTcBeT
         /H7VS/Kne2ODKIt6MejbYKPMOYPDSmtXszxXnKsP1Jyl41yQ4N8GmctwvjELMK1KynrS
         di2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4jadazlBFvDwLcmnJGW62NBtGRbnAEUuBnmXckHh/c=;
        fh=Kn+NjTyO3mUjkEi4WAC1QzCAopeWl7zUG4dYgNp1xd4=;
        b=XYEuR5luIF8KNDdXhe4UsqfIITbTwVUDeuPiqH3h0IpTW9MXpcXY/D1ISHmpCI0c0u
         EvekAlxk4fahfC+RR6nM4cqQZconkmUEIVvqiBqVBAdUGi5ygdCEZU+mibxOGeclAroJ
         rDIyZv068Pqy0SqAYl3PiRQ47sOj1Z263H/KP5BRWmCOzGun0pMJ5MK2WGMLwauJ6mEr
         heTyU5HfJckJl0nbu3+4GiAaucMMNLPOQBpKDn90M+0uGdABMkx+Dv8vFlB9dzgpdlUj
         eh5+1Qfo2hn9FdPw/EQD4sEekk56H8sueO81fpRX6Vh02GlhqyeqmNyNmtWYvQ5hXSHl
         FVEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365735; x=1777970535; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4jadazlBFvDwLcmnJGW62NBtGRbnAEUuBnmXckHh/c=;
        b=slQJt4uK5AAfT8AXL8SQyo1AuUpU2Y5HQKU51U4qhYN1CWK6hLAX50SQ7fPqc96mSi
         tTH3Sz2mfEQkn7gyr3Cy2yyYcnonF7T1zENftEwUUWe0dipJ5SxuMfk78NGKuCqJRUWK
         IOaFp+Ysjk+lHx4/NGciQ8P0EFmPo8e2dbtfo+IAWy9AZbBcw58qjAqYDJz/h2g5gynB
         jZRy07pODe6EQW0yDE1qd0xPIkM+rL7s+izjwbz9woDFm+ateuPaNezOL3lQPRK5abJT
         a1wTBjZQEc+N3FvZnzjVSrD6qufswuAi3GQ8MAngALw0SXfMMMEPLcBHOntLmEt4XWPl
         RGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365735; x=1777970535;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4jadazlBFvDwLcmnJGW62NBtGRbnAEUuBnmXckHh/c=;
        b=O73/DqCq7aPpVIc8MTp7WMhEud25DKQ6FOP+IF37md62lLBBhMrGttOGuC28AfOaHV
         jW3CkX2Uf/KQfw+c22oTmHY0OIjffagEY+OUJgP+2oCttK4v6jX51kQzIeXNGegb/buS
         p7KCLBngoekfuafGMZcuHYGFqt/LVyavHvdaCePR2ZekD/UMvcJh1aInYb8Qad9xIEgs
         St7H5a+vP8236cTqVPhN2+xgut8pbOCLXO1kyp7KUMQ6X7LUV6mHXR5QpihBvUK0VL8j
         1tvHl4T1SCcyAV0X4Pc9mKIfI2o7GIzsvpHW6xKLvylL59P7Guczypy7d9BrVMsjV4iT
         14ZQ==
X-Gm-Message-State: AOJu0YyvPUkocN51PsBtkYrd8/Vn7A58UCYMsaTVQFsw8RxatD4WSYyx
	V/7XaoLvWOo9BV7O6k7CcRUn3bDG6fd/q86MqacXtUGLpfCzj4BKbAU5Q+A/76n/T4GAfOzlOl1
	YFbqo3VI4KQ+ji8BPtWLbZAbRl59fwMV/mt19
X-Gm-Gg: AeBDiev1UuswWt5YeioQPZxu9Iu/hqlr/AfI9FCtUIfQ7QXccPpiNXrYjHnwRnhj7nL
	q32VZY6O1FtbH/Om3c3nIGxMWos0aXfw5M+l/Vrzl2czxl9Ylwll8sGf8aslclDVmmErxKsncZ6
	aC8ofz8Zty7BT9khKITU6lgnbGyv4UG7jxMEpfnImnRF0SGg+PCe8toe1bgzm9l6NJkUhoBsU7i
	vqqCveOfy3sBFEGqEffpZiR4c6mSk7sWRU29Ruv7EWLSrmW/UJS7O/jK09oKAlVAjHzoqZsIC5C
	BA0xFODVCN7Xs+jniaFwlfvvqMAE+FaPjL+mZZMtwwLA9JVb0A==
X-Received: by 2002:a05:6402:2404:b0:670:4445:c326 with SMTP id
 4fb4d7f45d1cf-679bb056675mr897445a12.7.1777365735000; Tue, 28 Apr 2026
 01:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkL_e0-5c8T1c6G7qQA_5vjf75MQffuy4J7x=AO90+ykA@mail.gmail.com>
 <CANH4o6PPZk3UwFBO+e2pF=5Z0-sZDNEJ9kReL9ZANH=VKpbw9w@mail.gmail.com>
In-Reply-To: <CANH4o6PPZk3UwFBO+e2pF=5Z0-sZDNEJ9kReL9ZANH=VKpbw9w@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 28 Apr 2026 10:41:39 +0200
X-Gm-Features: AVHnY4LlsmcbfXd9UpXgsN3rHLogk3dfBqh4_RgFy7B13kx5UwGOufZ3ueNWuSM
Message-ID: <CA+1jF5qEAR6GYf-_gnLQH1mwt4T6wECQD-CKB+S5MCMmUiQVCw@mail.gmail.com>
Subject: Linux script-driven idmapper, Linux idmapper for multi-site
 idmapping? Re: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-04-27 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BBF41480D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.32 / 15.00];
	LONG_SUBJ(1.84)[246];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21244-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	SUBJECT_HAS_QUESTION(0.00)[]

On Mon, Apr 27, 2026 at 8:46=E2=80=AFPM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> Hello,
>
> Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
> ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
> Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
> 6.6+ LTS and 6.19+/7.1 would be great.
>
> News:
> See announcement below; New idmapper which maps any NFS user/group to
> any Windows user/group,

IMO the interesting bit here is the (bash, perl, python) script-driven
idmapper. It has much more flexibility, and covers the multi-site use
case (one NFS client connecting to several different NFS sites with
different account management rules), which the Linux idmapper
currently covers very poorly.

How difficult would it be to port this to Linux?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

