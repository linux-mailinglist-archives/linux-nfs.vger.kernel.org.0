Return-Path: <linux-nfs+bounces-19450-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULRAFaZSo2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19450-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:40:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D11C87BF
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD3A3008E3D
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED162273D9F;
	Sat, 28 Feb 2026 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvSfCxsI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99913430B8C
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311203; cv=pass; b=C5yyVfAvFBe+I6aiUyf1MGneYcX6vvLeAlNhPyAY2OppF2NArEuNl9T4c99ASlB5zY2cGUs7/8MjP9dpsxu2GomhA/7QNjyR1kG5ssh8INFxMMEzqiQ8eRxS6unP9w5SVHGMbaos9D0WWivV5EgGe/IqmzQog1cdRRPh16QwuKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311203; c=relaxed/simple;
	bh=i1jQJopV3noCaBJ9N6I2/6YPG1NeOFrbZa6EOpsyAhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lyd3NQ3ksPLJ+v/H6eCD9DcIRdRdFLcMC4gXzssN0sOfpSKr1j3Bo/hzVM6gG0XfMejqRvDwnmJ/5ksJg+dbL8GYx+PmJqSbLCA4q/JISu8MzrfKu4VZJauJsanMSvW945XFud6fHvKJt7PQnJNeqMtNIy5MBnLMoQNOCrIGvto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvSfCxsI; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso3905750c88.0
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 12:40:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772311202; cv=none;
        d=google.com; s=arc-20240605;
        b=PMwpp5L5XOzP6CA7jeRJKP8G1bufTVh1bT36vOeB7cYWMysg7dXL4g5YrafauPRWpe
         MFmmw5RHSz67wEUcCDgI1fhLYGmOUS8Phkj5sEZIdm8pfScCp0LYrzIPkjkZnQvxc/Ps
         ZSE4wMhc8sHVNDHckF0nkdvV1ys4jdtqdMWpU1q0m5Xbvvt/FScF2CW+zqzM3Zq+0i2y
         CeDQ2QGMe/mkcJPJ32B9RFLpXMFvm0Wjjp/cvnxv+QShUbjfG4WBI6pHxRpubnmP9Imm
         BjiOXTZerpbuNLWEflnJac7u1cJkmv0O7JsYruQYrKHtrcg8P31jbDDKy0Z4rmV0psiW
         0Mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/isczO0MdgE3sVRkjz1Us77BMCG7yVJRgy2sCVXW2I=;
        fh=exOEECrwiYHpNt2M9MkY9SvNfrgIm6AnN8mw41Ul7is=;
        b=HQxaXJt3zqjWHvNl4Z5meJwRbivshtrmDUXJ7mZmMpNHzEsZI+1QSPpIk2+u3LtEUS
         6Iwj2Pg4PoB73PjJf94JD4UBbqO/hmnMH5Vr8RhbTNls5xJzh1v8kjHolbOysL0Ip4A1
         WG2B27G2jTCZwcl8K2opjFhlV4yelhFNinsNFkswTUZ9FVcYItwzpZ41DmMjsCOVfQes
         WHNTZEREqUbiYew0od7m2S7PySwU6/id8DtOGfaFpc1c7x6wwV/mdvl32kU67ym/DAtu
         QZ9QdtdFQb/+siJQD5ZMYatQ+sWR8/OL2RiiVt+c4vffQRiJGyqSN8OATQb/tZ7R9djz
         bZPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772311202; x=1772916002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/isczO0MdgE3sVRkjz1Us77BMCG7yVJRgy2sCVXW2I=;
        b=DvSfCxsIQ+FtKLXVxkuwJOeucK0ThUaj2HRaXYUKYO41b3YRE+v0yA3665R+Oxwmf6
         0K6Rv1zIsaiaZQSRNRZPWHDR5GcClgFvfqMxNGDcK22bTmem0DAnpLouWIR7KVCiD3L3
         SGpHoHVc1njERMaP15OMaheAQnomxsgzROWMflg8HI57X056G5ljgjZjwq8y7VfvCJmo
         0QvZC7XPvL04FazMbXbm1gJp1JzbApZ0Id2EePWNHDKZLMvFiFFU8AgPARyOtfPyEhiZ
         9HBWqah0LtzUlbTa1LWXEYr1VNxvOocStzmqzPxvjAa3T1oQwE+Y3EecQju481SQCekc
         tKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772311202; x=1772916002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/isczO0MdgE3sVRkjz1Us77BMCG7yVJRgy2sCVXW2I=;
        b=b9OgHHBvsuP8SFaZwAYsPcX7C7L1UVdZCfOGI9bRiNB0sb+ZwVqrJGBfGK39A/c23f
         SB8NgbB1CG9kfHsIpKBWNmL6ZYyLao9uZnXlZN2b1EyCg6o+YMbQ3m54HCjjfwdAVazB
         GMLxGKvLbovgE2q6udPfOoyFjmulu83ShGB1sHwOXQMclUEeeiwsVnKpj7rbs9BHfVcm
         9SjnzheVHzhHfSOYMD6IlX+gulB+fp+X9FL9ZhvqbLKLtu8TX9TK1TmJjmzQPh9ZxS00
         YN9mrg56zOh+wUmz6Fm4ZC5OYGpkSQf/tlH7tRo0PruEj065j3GgnEP7g1296ncTUEKu
         /5vg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ThgUf52WylHKV+KYDidj6UvkXc6d1a4AQaWDywma+j6XHT/ZjvbgRgnw1B3Gm0bfMhiyIjQttC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd5i/FK3fID3f2MA5VpfbwonQ9CAJ6V8ahPViwKzbPg9bb7KE
	6GmW3rj94tL7do1YY7P1WS2QAhU+tF+tlNdSmSBivLQ5bY4WpzQ7sAirGAr3w2NmZsa17y/ODVn
	fMEmpsx0IF+X6yrh2MPDkhfPCNGnBppZoe8dcSzgJ
X-Gm-Gg: ATEYQzxYEiP8cYmmDJUYqrHsIAPD1mERshh0Cwu2th3BwG9LUwyZO9cwLxijEaK/MHN
	Vp7Nt3NBdsB0iluMNRag5oyKVROduoWvKA7rAj1R43nd91fECwCsvIA9etF/C7ihlTIuLt87N52
	Rw05CVBC+Dhp2e2mEzI+dCpuS2lVfhmwK38j4dp7LWiPKGpG41QdoHaUy/bvlXu7JTJdmQD3cMX
	CQnZio5TaBe7VX5F0fY4dN9S5y/eBowsIVpbmsuE1k05+kF+tFfrJPRBJUo23SHjS85fKoLAGUg
	eqTAd4QBIb1tQjx0llRiNdGTlRWU4lc8fGoil8d+j2T2mxul0LzexdslFwb1koIcxYIwrBEA
X-Received: by 2002:a05:7022:622:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-1278fa8bd97mr3515115c88.0.1772311200691; Sat, 28 Feb 2026
 12:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176931125800.30355.7451399373487878151.b4-ty@oracle.com>
 <20260228200214.964918-1-kuniyu@google.com> <de6fb992-9f1c-4c82-b51f-7eda327d55d2@app.fastmail.com>
In-Reply-To: <de6fb992-9f1c-4c82-b51f-7eda327d55d2@app.fastmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 12:39:49 -0800
X-Gm-Features: AaiRm52fnka1PFeDsV_5ktLupoe9dmqbcg0G3sX6zwxr1agJaba56YAXf9oFLmY
Message-ID: <CAAVpQUDTKQqWxMPMBop3PT2E0QQbmMUzB3VyTGB+quFkzV2ztg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] nfsd: Fix cred refcount leak.
To: Chuck Lever <cel@kernel.org>
Cc: Dai Ngo <Dai.Ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, lorenzo@kernel.org, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19450-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: E13D11C87BF
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:37=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote=
:
>
> On Sat, Feb 28, 2026, at 3:01 PM, Kuniyuki Iwashima wrote:
> > Hi Chuck,
> >
> > From: Chuck Lever <cel@kernel.org>
> > Date: Sat, 24 Jan 2026 22:21:05 -0500
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> On Sat, 24 Jan 2026 04:18:39 +0000, Kuniyuki Iwashima wrote:
> >> > get_current_cred() is misused in nfsd_nl_listener_set_doit()
> >> > and nfsd_nl_threads_set_doit(), leaking the cred refcount.
> >> >
> >> > Patch 1 & 2 fixes the leak in each function.
> >> >
> >> >
> >> > Kuniyuki Iwashima (2):
> >> >   nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
> >> >   nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
> >> >
> >> > [...]
> >>
> >> Applied to nfsd-testing, thanks!
> >>
> >> [1/2] nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
> >>       commit: c14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0
> >> [2/2] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
> >>       commit: 687b9b69fcda9de606e998fd2edccb8a14406e19
> >
> > While rebasing my local branch, I just noticed both patches
> > are not in the mainline and I couldn't find both SHA1 in your
> > tree.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?i=
d=3Dc14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0
> >
> > Could you double check ?
>
> The patches are in my nfsd-fixes branch. I'm planning to submit them
> soon for 7.0-rc .

Sounds good, sorry for bothering you, and thank you for checking !

