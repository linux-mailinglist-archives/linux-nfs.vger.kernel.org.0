Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2541C1DC5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEATVA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEATVA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 15:21:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC74C061A0C;
        Fri,  1 May 2020 12:21:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v18so5229665qvx.9;
        Fri, 01 May 2020 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nIIK1K2iXdxODttszcTBcKN7K+PfigDaaJguqmSXmcc=;
        b=mdKJ6+1nJapUDsjDuUidOOgO6uMkjigIGXjSxqMa6K5GikTVEi3CO5okvRmupRNh3t
         DFExrKgVa9tTh26mVQI9QxUKw3zz6wu/Fp/FVPG9jRz9m8aF6FHvCmwCTt7OioMFBxxT
         pPhrQxA9jfYh/pUXd5XPlUuAHVJhqyvdKAp6e/olP6cGH7W2QtE4olrlgKnd7CR+nWR1
         jNFssvZPZ7zrYEt/H16TdQimm1QIzFLZrkR6T+YttKpz1zHPolqf4DRskSl1gWNNd3Af
         fxQ+QBm6LSgkNMcdns/q5kR9xvjud+HoT5lGtJVANlMl4QswKdvuz+qhN59V+e1BjxGX
         G2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nIIK1K2iXdxODttszcTBcKN7K+PfigDaaJguqmSXmcc=;
        b=DQhal4KMeSL+j8YQw+GQzAzYxmTdAmjqjLcUbJ2Mvjbp5jGkOAoprltsJtYin96HQx
         qUfEGldYk4iga+7Px68rgzjenlnfcfp3cMLfQv+mmOsd9Ww+Dyo4KhqJBy5ISGwwDkfO
         aX7rb3fw38dtSdXADQDkgw8BelzLomhcNawcyoYye12M8FeCFY3l1QFafwODAonEuMob
         lz6CsVlmT2dVFuRP1crAipDVy6+fvBAbF4j3qQk4xNcMVnigc0wv7Ml4Ia0uuhaRu8YK
         sQhGLvGUVszNsILalW4i/3PgGiEvY6RwppZEl0MspWeAhuWipsKKt6PBmRxx+f2BR/SF
         DUuA==
X-Gm-Message-State: AGi0PuYb+010aOB5H6SANN0nfc+v0PyCT9YCLny/ywN2atSNT/yMmTOS
        NAcO1TW4sj3vDh9KvDBxRs0=
X-Google-Smtp-Source: APiQypIJ1sRtqQoX+F0xIOpResdc3RCRaE0bnFzpxYeOz3IGOGrc6RCuzJLn7HSG8oNkLdJ1WmznMw==
X-Received: by 2002:a0c:da87:: with SMTP id z7mr5478109qvj.141.1588360859041;
        Fri, 01 May 2020 12:20:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6fd])
        by smtp.gmail.com with ESMTPSA id d26sm3338957qkk.69.2020.05.01.12.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 12:20:58 -0700 (PDT)
Date:   Fri, 1 May 2020 15:20:57 -0400
From:   "tj@kernel.org" <tj@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@redhat.com" <bfields@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "shli@fb.com" <shli@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200501192057.GH5462@mtj.thefacebook.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200501184935.GD9191@pick.fieldses.org>
 <d937c9956c0edb0d6fefb9f7dc826367015db4aa.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d937c9956c0edb0d6fefb9f7dc826367015db4aa.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On Fri, May 01, 2020 at 07:05:46PM +0000, Trond Myklebust wrote:
> Wen running an instance of knfsd from inside a container, you want to
> be able to have the knfsd kthreads be parented to the container init
> process so that they get killed off when the container is killed.
> 
> Right now, we can easily leak those kernel threads simply by killing
> the container.

Hmm... I'm not sure that'd be a lot easier because they're in their own
thread group. It's not like you can queue signal to the group leader cause
the other kthreads to automatically die. Each would have to handle the exit
explicitly. As long as there is a way to iterate the member kthreads (e.g.
list going through kthread_data or sth else hanging off there), just using
existing kthread interface might not be much different, or maybe even easier
given how hairy signal handling in kthreads can get.

Thanks.

-- 
tejun
