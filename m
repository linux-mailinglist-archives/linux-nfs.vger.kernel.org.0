Return-Path: <linux-nfs+bounces-19839-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDM6G6kcq2mPaAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19839-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:27:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16C226A90
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05F27300C345
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C673141323D;
	Fri,  6 Mar 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aY+ApmNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6233EBF37
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821667; cv=none; b=qtNJtUV5nsx0Ez8fi3pSn5wE3VUu29Sz0vwe8bw/U4Ihpp08qkHZRsanfRJ2z3hVhLzosHGDf3TCwWB/ssSDCl83r9KOXS8+umGrxyt0ksvH+idVSSypJFIiESlN+tyhKzHFtZtD7IXe+06b4t/4D1mfVu9n17VpsYLvD2sSzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821667; c=relaxed/simple;
	bh=C0FpvF+Eai8YIFcFjlslWeL22N9NQEVFyXAeA99g07Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEW+VoNDHW9TO74dwuCuQwxXkaP5YtgEXm7WkiAUuCcf/paMpM0uXMVsvBWF3jTS3cIeEgqBHYXWxwkgReTQmPjXWu7SevHnd66asWX55SWiuhD984HKvW12/rboMpMdXUnaRjTF4Qs+5FSvAbZGWYTrtgkUCtx9pAGd/XuumOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aY+ApmNy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93695f7cdcso1279633066b.3
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772821664; x=1773426464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=aY+ApmNyKm9xvh/ldm/7CX4G0uheBAr9ytnYa1gFUVWsrOJWQzUxcMl0pm5CawzKrf
         ZcVyz4LhdFLC5HxVJiMDzaissd07gjJrC6Qg+9gjUNPli7JGPdQV+FHOXBcDyQ8k1cOL
         35roxOUBQ8CZ18hWHiK0pXwK3N05rRQz/eD8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821664; x=1773426464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=t5oP3DQNFhzOuFE1tONjZDAMQ9h/sogpFJBX063CnIoCkyXK+VXDMFZM9kM07h7XtH
         OA6ShXD1jn008JW3PMiV5h/NoIibEBaheunclwAg473qt98JUJIp/lohyw7pzzO2/J7y
         P3b+IzruWFRPGw8Nex3H95AshUqMWL93JuGalGG8ZaOmJSrtjsfw+mNbU2W/ukjfoeIQ
         XHmOlVCRE/YwAMrVOvKdZBjZBW0HYl3LSk4eyNs5r1rGDwCRXtxLxu1XtcpUNSUHlRVm
         1xnjK2uCqYak72eRt+xLX0nboZ/s6pDIT3PSp7GHv3x9TWAfOmgmqrx7sapTUjGB7bgj
         5b+A==
X-Forwarded-Encrypted: i=1; AJvYcCVD+YHeFJTdEh1eNofSyDaNh1knAMb93XvX2xFlFlXyYdTu56k+9NC86LOXVCWfgOhgymdf7vOzp/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAasGrgx3P7BMHzY0Zn2iKtOy6xhdK+lnSPub7AD0Fxv22FMOk
	i6Ap/bkPjNFKESE5lFyI/RpDnhjrgp8mVpCeJOsnsSsMsmnOnagSegt9jw7i3oTQWPeT+N3VyUT
	8xj/2VmA=
X-Gm-Gg: ATEYQzzEtvUdjmBn7Jmn8/sKY1qoy1xUY+vus9lagcfHZuop+uS6HxU/t6Nmupw+TRx
	5JICXHDp/crSWnHKRQ8EczVohl/jSSOBBHkZCMwHPoCPRPmapiWXqURcCQTJtW164878iwpcWq5
	6KGbkqoVCz894LsoZLTv7ylRpP9PclnxZTgMLRsZ9I16zIKd6+2WEX2Oagf8QVFkWSxCmXa+S5r
	q4wIOYeNl/FOoVvg0fNmZscbDzNw2oV77uqlzYOcxZgzkh0bej7Bktk/p70JJxIWPkajIC3pd8c
	DUBFenzudOwW8dZ2xyxhLqNRDxEVkWoh3U4g1c+25iVVBSFsUmxyetcxfzTFJVC4y6TAaDucY2S
	8KNjAqh/M3AmfLWlfUb5hrr7ZLPpiPUuzlap9Fj8SAjLIoAb/KhtsgqlHc+GoWA1rrYW1/RIdOM
	PZW7Bx0H3/RPTl05nN7AcefSbBT26r/0zJQZSRRlPglx5Q+2go0GD7UX7r74iWsgQ9SkwkUreH
X-Received: by 2002:a17:907:a07:b0:b93:db67:1a2c with SMTP id a640c23a62f3a-b942e01e0afmr189043066b.48.1772821664251;
        Fri, 06 Mar 2026 10:27:44 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f189de1sm78350766b.63.2026.03.06.10.27.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:27:43 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9434f706a2so88820566b.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 10:27:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbLW41BuNnRzs/5nv0rcCBYnYqTkazQ0KuvCaIZAejr7ROTCLhBMfRJWuovtOV8iTSKYYrbf+IHWM=@vger.kernel.org
X-Received: by 2002:a17:907:72d3:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b942dbae36emr189809666b.10.1772821663491; Fri, 06 Mar 2026
 10:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org>
In-Reply-To: <aaroReSCj1qXUeQb@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Mar 2026 10:27:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
X-Gm-Features: AaiRm50t8TjmDHmMBt5Sh-GyOL4xotHpUKagWUMEUHoG2sdTM--QAxb3FwfabmE
Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6F16C226A90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19839-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,googlegroups.com,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-foundation.org:dkim]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 06:44, Christoph Hellwig <hch@infradead.org> wrote:
>
> More a comment on the previous patch, but I think exporting do_exit
> which can work on any task is a really bad idea.

What is the advantage of a module only being able to do
kthread_exit(), and not able to do a regular do_exit()?

I think the only real advantage of having a "kthread_exit()" is that
it's a nicer name.

Because if that's the main issue, then I agree that "do_exit()" is
really not a great name, and it matches a very traditional "this is an
internal function" naming convention, and not typically a "this is
what random modules should use".

So kthread_exit() is a much better name, but it basically *has* to act
exactly like do_exit(), and adding a limitation to only work on
kthreads doesn't actually seem like an improvement.

Why make a function that is intentionally limited with no real
technical upside? It's not like there's any real reason why a module
couldn't call exit - we may not have exported it before, but we do
have code that looks like it *could* be a module that calls do_exit()
today.

For example, I'm looking at kernel/vhost_task.c, and the only users
are things that *are* modules, and it's not hugely obvious that
there's a big advantage to saying "that task handling has to be
built-in for those modules".

So my reaction is that "no, do_exit() is not a great name, but there's
no real technical upside to havign a separate kthread_exit()"
function.

If it's just about naming, maybe we could just unify it all and call
it "task_exit()" or something?

           Linus

