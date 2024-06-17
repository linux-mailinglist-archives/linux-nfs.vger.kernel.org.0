Return-Path: <linux-nfs+bounces-3923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA690B674
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23101F23BE1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3815F308;
	Mon, 17 Jun 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqmD0K57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5F20B3E;
	Mon, 17 Jun 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642020; cv=none; b=PqPuxX6TC6b+R/nD31G6vcCnS374tBkRHWqvXeUkGKqkpAXMs87keBUQIjHQ12R3n81ZLxP0U7ZiHyVJ2fq5kme2esE7p/W1x+t5POqAzr2layOpDdHv2wt5a2eQU63J3JxCsBLhHkIShU71huPrRWFBJXg4ZbD4moGtqkZgQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642020; c=relaxed/simple;
	bh=AqajSV0X4jhG6ZZwm0pL6IyE58bEqZ6C1lsJRn/cy6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBjydcqjDd25qMMDri01TXjw7CdjncKTnMb1+G/m+DrmToz/afTi22fJitUpR3LAYOxJn/VI7MT2gu8YiwonKW9lCGb3bdTEp1iyvCx/gxtHSdKiA3Oom8moOeULZGFR4fmAJT0CG1VuOhOUKp9n9LQNgFJC3EFaLcMpduE0ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lqmD0K57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39163C4AF48;
	Mon, 17 Jun 2024 16:33:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqmD0K57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718642017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUjKSm9UM4O1aKGbEZjvZRgCeGJk15TE1+l7iyYY+0E=;
	b=lqmD0K57cnaPOftHh2pOum828X1k5uUv0Vyx2HD1+u8cZfhtcNcmaJO3Jde0keMY78Ap/O
	TP1hCGHPmLCeXxG7ZdUXs/CPJ7wNLwf1Rwwgjd5I+wJyed+uUTgzNPiCteakfasG+gGmeX
	AZiaHQP3EqVbkxlqL/iUR3o0NHjrlw4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17900858 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Jun 2024 16:33:37 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f73ccaaso2639015fac.1;
        Mon, 17 Jun 2024 09:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUknrKrjOdOG7XPcDZjYfP6lcQeB0Q9gHxZdtLN7BRKd3Ek2pFK5VWuDQaj0rgX37F/iIuCbXv12qpgBUE2JX6kptFeU4blWxoqw0HKZsZqHgWiKogQMj+jkLQKK4qtLkylut6B12yxJyGIBUaTKpGyrRJMxG+GRpmvl7rJDYLsyHizMAY3yzj+23+C5EYyu5rpahDlZXE+nWwysNdQfGmPscQm7fes3hLY7PMClU374rvRv5vHkqmXw1latoR3rBA1IBYc3X0eCZrL0xTAI8SPV6NjXRoybcEHmbnALazXEz7+A0NBJ1nrune5QPsjw+57e+9Iz+WvxgOHAP7iF1/bbRkBYtpuWaXW+d9zhsHwr9pXRVAaJUFTHLhFOnYOhzpU7e3IpysjkmtjzjUBmPG6Ji2pxkMk4zoL8PCwjKCbtoQIB2alpaxFSLc2kQ==
X-Gm-Message-State: AOJu0YzaE0FTtrdP3CuOVp1XJdhfltEwufehgSXE1G8yAMSJwZuFqX6E
	qf39MDm2D0jf7lbcoiWnTdQVIrpwlApchJKS1b8gn2obII2bKO/MCbtfzYTrUxXehbcBHaae6jL
	YBo7Vex95MLqdXdADlRekZNd8sqk=
X-Google-Smtp-Source: AGHT+IH73cxa8bEaSx0br+R63lisN9Zy21+jpj61L5jMj9rENcrv4EuyB2mn51tWhnn9axbMUQaQmVNUc4nOeGH0JmU=
X-Received: by 2002:a05:6870:9725:b0:254:9ba7:488b with SMTP id
 586e51a60fabf-25842ba524dmr11130088fac.40.1718642015158; Mon, 17 Jun 2024
 09:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmru7hhz8kPDPsyz@pc636> <7efde25f-6af5-4a67-abea-b26732a8aca1@paulmck-laptop>
 <Zmsuswo8OPIhY5KJ@pc636> <cb51bc57-47b8-456a-9ac0-f8aa0931b144@paulmck-laptop>
 <ZmszOd5idhf2Cb-v@pc636> <b03b007f-3afa-4ad4-b76b-dea7b3aa2bc3@paulmck-laptop>
 <Zmw5FTX752g0vtlD@pc638.lan> <ZmybGZDbXkw7JTjc@zx2c4.com> <ZnA_QFvuyABnD3ZA@pc636>
 <ZnBOkZClsvAUa_5X@zx2c4.com> <ZnBkvYdbAWILs7qx@pc636>
In-Reply-To: <ZnBkvYdbAWILs7qx@pc636>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 17 Jun 2024 18:33:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
Message-ID: <CAHmME9r4q8erE3E-Xn61ZkSOdDDrgx6jhTAywx3ca4=G0z=wAA@mail.gmail.com>
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, bridge@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org, 
	wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-can@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:30=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
> Here if an "err" is less then "0" means there are still objects
> whereas "is_destroyed" is set to "true" which is not correlated
> with a comment:
>
> "Destruction happens when no objects"

The comment is just poorly written. But the logic of the code is right.

>
> >  out_unlock:
> >       mutex_unlock(&slab_mutex);
> >       cpus_read_unlock();
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1373ac365a46..7db8fe90a323 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4510,6 +4510,8 @@ void kmem_cache_free(struct kmem_cache *s, void *=
x)
> >               return;
> >       trace_kmem_cache_free(_RET_IP_, x, s);
> >       slab_free(s, virt_to_slab(x), x, _RET_IP_);
> > +     if (s->is_destroyed)
> > +             kmem_cache_destroy(s);
> >  }
> >  EXPORT_SYMBOL(kmem_cache_free);
> >
> > @@ -5342,9 +5344,6 @@ static void free_partial(struct kmem_cache *s, st=
ruct kmem_cache_node *n)
> >               if (!slab->inuse) {
> >                       remove_partial(n, slab);
> >                       list_add(&slab->slab_list, &discard);
> > -             } else {
> > -                     list_slab_objects(s, slab,
> > -                       "Objects remaining in %s on __kmem_cache_shutdo=
wn()");
> >               }
> >       }
> >       spin_unlock_irq(&n->list_lock);
> >
> Anyway it looks like it was not welcome to do it in the kmem_cache_free()
> function due to performance reason.

"was not welcome" - Vlastimil mentioned *potential* performance
concerns before I posted this. I suspect he might have a different
view now, maybe?

Vlastimil, this is just checking a boolean (which could be
unlikely()'d), which should have pretty minimal overhead. Is that
alright with you?

Jason

