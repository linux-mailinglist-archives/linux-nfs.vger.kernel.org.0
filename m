Return-Path: <linux-nfs+bounces-19892-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFcmChr6rmnZKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19892-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:49:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B323D0EE
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E988302DE31
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA623BE14A;
	Mon,  9 Mar 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="crSC34LX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638143BD628
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074578; cv=none; b=hqfpi3bIgTdd4SY3+TCLoVewMTnC0t/mo5GGYZ72zGyqscFC8hBspCZ9grRMMBtsTCwIgVQwa7uyvmNvR0yRChFMnNHmeqC1jrQXBsck1MMnCl4ifIsYSc6d3Bq9akWSRQ2PcUcCnR2Z09pCdl+uOAP6U/LD9KDsYD8RaZkrtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074578; c=relaxed/simple;
	bh=zAR72wDXdxq5C9PjPsyeD4QQxyEK/1hXtEl2Xpss9d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmT9lXukjmEGSMThN9YXaRISTMnIwMvrIs7wfBOTBldBsxf5Lc4n8OlMOQnY8NKY3FKJFXlB1ddoioZRBhBhH9UXM4HrspgfVukUlV8k7LH6mdU+e8d+kmPhQ13zz0lwZOHM0U5iMW+zm70Kdtz1dteu0/IKqLtO0L3yxNXTUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=crSC34LX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96dc65b886so268946966b.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773074575; x=1773679375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=crSC34LXtaBK9ul+FmfEeJmY4Ag9UdXTaVgvhmW5XS/lqEDB5enohTy6dzWb0wzS54
         BTQ5f0B5I3OExv44X4WsUox01W1dp9lkn08wB3iFy4bh0/Wv3cddweiYdCRYtLfJrVAg
         WwtqmZ1gYYI6Tba2NYX4d6tt6alQXdR3Hg+v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074575; x=1773679375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=D3JnOUIakjTLYFbE0pskuq7Mc2bklrXGPUj4ugb8hF1hkkGiKkFNxYI9Wvyal4kduf
         rxcl3LdUm4GshI3ELSfvjZ/fSZGv0yo2aKBmwPtCbsK5uvGEoKyQi4rpXsDeVwfc+ndL
         ZWI4/dha9s8UXrWNOWtBwO4qnCnt5ir8JXnrFrJ7bYBDCreH0gq2/DI7czUNXDseAoiy
         h+WN9YSf7jWnuY55YnXuphQqicxFamHE+5QuL1loitvJY1jnY/DH5zN3ujMCG6yw6hhs
         bxmnaXMlXjoAXCDQ+3u4d3f5m4+DY1qQuxbIrwWWGC13EcEhAzm2Cp0aZsvB2qRX4XM/
         yZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVPrsBhWkyR8BVwiQEjMWUDANMjWvF+nIQC7/fkOlOkF+UGGTZ9hz3IuujXbq+Y4ZIV9fx4grxa9Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqovFGLVtxrR5bjcYglA8rt8O3akeQjzOXPTh0y7JDOcPRiRjH
	23q96ykbqC1ThvucWbZsl8ndEVqpSlQBMOc9ltiOMPb0XVwaIZY/wHMMne3/icX5PmNbm+MwZDZ
	l6ZIBvsw=
X-Gm-Gg: ATEYQzyqTQHen6X6j7zapb2e+fyDzkogDdQa5NMwUes5QhQDAcEvs4226c7zmxmNRVY
	eeIj8wmlzPttw0muMz4pGkE6CN2tW9icUfV/QoHkjQtp6Y9j/TG7jxrWy1gx+4aPpu7Cukz7XZQ
	IVRvfC1V5ABxwkrjTczzT2aQ69cmxAoyGextsULE+FKjfumkyBNUjbu4teeg8XkkcoKhpH+kWY9
	3ZCP07HfBb8EVp69raz1K60nH70f2LhhPvFDBfTe/4kfhmPcc4NiGj6xNnpMvfgKECmrVqDfuVo
	CF5NmCxSuvJQba6pMfsTmPdPwpiOPKgKDFdD87VEvRzacFutXiJJcZYOS5s+VGh3jNmbv1l7rP8
	Vq6A/eHjgMRF9aEf8xVsflkknxACZK51IUlDwgqnoWzUfdmE4y9zMiIQyHX2iRccBzlHVgIvhf8
	Fyr77cl+T5/Mfcfh4cONcPZ8mqVB18jJTQ+k82Z2tGJHCa5mmJp++uW6tlvtNv/SEBcZ5QGdMEJ
	21uQN+gOqc=
X-Received: by 2002:a17:906:846b:b0:b8e:a126:66be with SMTP id a640c23a62f3a-b971192df25mr11652366b.18.1773074574534;
        Mon, 09 Mar 2026 09:42:54 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b96dbd03678sm270817066b.13.2026.03.09.09.42.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:42:54 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9423d62cbbso455980266b.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 09:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ4IUfdEiGSUlZ/VSht/YD8wEQ+Y4WDvMM2uxukmWSmS6jcKogKubyfUhd+Fpr851sCRWABhkSyQ4=@vger.kernel.org
X-Received: by 2002:a17:907:3e10:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b9711a1fe33mr14904266b.18.1773074262570; Mon, 09 Mar 2026
 09:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org>
In-Reply-To: <aa7qson15uJpL-BL@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 09:37:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
X-Gm-Features: AaiRm52k8FmvIAxaWFSwelL44z7-IyhgZowK3grBWDh2zbSjeLnGfYwalrLVlLs
Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 866B323D0EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19892-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:dkim]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 at 08:43, Christoph Hellwig <hch@infradead.org> wrote:
>
> Because it can't f&*^ up the state of random tasks.

Christoph, you make no sense.

"do_exit()" cannot mess up random tasks. It can only exit the
*current* task. The task that is running right now in that module.

And exiting a task is about the least effed up you can do to a task
when you are in kernel mode.

Compared to everything else you can do by mistake - like just
corrupting task state randomly - it's a very benign operation, *and*
it is obvious both in source code and in behavior. It's not like it is
some subtle operation.

I'd be *much* more worried about actual subtle bugs, not somebody
explicitly calling exit.

So what is the actual problem? No more random rants. Explain yourself
without making wild handwaving gestures.

Now, there are real exports in this area that are actually strange and
should be removed: for some historical reason we export 'free_task()'
which makes no sense to me at all (but probably did at some point).

Now *that* is a strange export that can mess up another task in major ways.

[ Ok, I was intrigued and I went and dug into history: we used to do
it in the oprofile driver many many moons ago. ]

And since I looked at the history of this all due to that odd export,
that also made it clear that historically we used to export
complete_and_exit(), which was this beauty:

    NORET_TYPE void complete_and_exit(struct completion *comp, long code)
    {
        if (comp)
                complete(comp);

        do_exit(code);
    }

so you could always do "do_exit()" by just doing
"complete_and_exit(NULL, code)".

And yes, that function was exported since at least 2003 (it was
exported even before that, under the name 'up_and_exit()', and that's
the point where I couldn't be bothered any more because it predates
even the old BK history).

Yes, it was indeed renamed to kthread_complete_and_exit() back in
2021, but that wasn't due to any fundamental "it has to work only on
kthreads". It was simply because nothing but kthreads used it - and
because that was also the time when kthread_exit() started doing
*extra* things over and beyond just the regular do_exit().

So it was a practical thing brought on by kthread changes, not some
kind of "exit is evil" thing.

And that "ktrhead_exit() does extra things" was the actual bug that
needed fixing and caused nasty memory corruption due to subtle lack of
cleanup when it was bypassed.

End result: we've never historically felt that exit() was somehow bad,
and when we limited it to kthreads and made it special, it caused
actual bugs.

            Linus

