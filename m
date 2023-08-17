Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B528477EECE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 03:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbjHQBlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbjHQBld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 21:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D858272B
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692236442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGPGNEzA8Hg+gJfsuH3mJv5XgBkB6580SnI6Dwb6wrw=;
        b=Sfrk1IaGj3MRMi4z7oF4lbi2/uE1MJDSZ7BhXXCOwtBGdZgpRMSHnQj1nC4c7Dx/0PSdM5
        qnyookH4Y3GyzWM3SwlcjSQIBAHv6W/4wqe+faU/N2KYajl5bPxBAbbkPqF8upvD1pZL6M
        v0Nb/vd1kmb5iI3s7LfhJUGSXPPoJ/s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-A8AEdA6-NYC-pJzhHIufKQ-1; Wed, 16 Aug 2023 21:40:40 -0400
X-MC-Unique: A8AEdA6-NYC-pJzhHIufKQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe356c71d6so7074679e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 18:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692236439; x=1692841239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGPGNEzA8Hg+gJfsuH3mJv5XgBkB6580SnI6Dwb6wrw=;
        b=CN8qIwZ3UAHIz5vVPRT5lpzLoTdmCZj+73S3TWsxJ7Jmw69YjIoP6BAmueGhsjRWkK
         D6/a88ERIsIDxMYDypEOdvipN9OcGaYVsHxBDjnVGKsBUqKerdRKW8sHBVqBLV80IzfD
         Dk5ce62PZw1+8OiO6qqyIRYo7tL5fz+DA7576tqEnpSJrf8+2UIC2aH3+rglQMg2dKxe
         hO+yefAnIg2tq3XWjG6vNF3u+NymnalHIC0Qpgc6BG01pq+ROqNiHF4CvNtYxK0i29rP
         gmTV+1tTHMr11K+oyITWXpFswdYV2DYwE3XGExCsF8rWGiPZ5sZLfvsB7AsBh/hcoUrS
         9lNA==
X-Gm-Message-State: AOJu0YxMWVZ4HjWciZLXsUu8PAj2gmdA3bhk+lL6wEaKy4XBx2J+b/kN
        DN8ar6R7lcHDCOQOgRbnCy9171kU+ZcbD3+Vs9zMbfx4/L7vHbqeyqy6/w+mQaNvZXpmm4eg3AQ
        4Z1yn/PuDjpsKeo/fz02DyeBiLbYXz2ch96FW
X-Received: by 2002:ac2:484a:0:b0:4fe:5741:9eb9 with SMTP id 10-20020ac2484a000000b004fe57419eb9mr2727713lfy.49.1692236439458;
        Wed, 16 Aug 2023 18:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsSIql+75kR7a5m8JTNViEr2cmNnzGfqdvDezYuFdF9VjvJ+ASCYtLmcFjsXpowRAIWWGgSOCedDvWY+l9uUo=
X-Received: by 2002:ac2:484a:0:b0:4fe:5741:9eb9 with SMTP id
 10-20020ac2484a000000b004fe57419eb9mr2727704lfy.49.1692236439181; Wed, 16 Aug
 2023 18:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-3-aahringo@redhat.com>
 <88ec807d16a7eb2be252eea0c10e3374c01da1bf.camel@kernel.org>
In-Reply-To: <88ec807d16a7eb2be252eea0c10e3374c01da1bf.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 16 Aug 2023 21:40:27 -0400
Message-ID: <CAK-6q+iqQFXKXEbxy+k=NF5mOp7H+NTzo3_3uBCQszmufryJeQ@mail.gmail.com>
Subject: Re: [RFCv2 2/7] lockd: FILE_LOCK_DEFERRED only on FL_SLEEP
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Wed, Aug 16, 2023 at 7:37=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > This patch removes to handle non-blocking lock requests as asynchronous
> > lock request returning FILE_LOCK_DEFERRED. When fl_lmops and lm_grant()
> > is set and a non-blocking lock request returns FILE_LOCK_DEFERRED will
> > end in an WARNING to signal the user the misusage of the API.
> >
>
> Probably need to rephrase the word salad in the first sentence of the
> commit log. I had to go over it a few times to understand what was going
> on here.
>

ok. I will go over it again.

> In any case, I'm guessing that the idea here is that GFS2/DLM shouldn't
> ever return FILE_LOCK_DEFERRED if this is a non-wait request (i.e.
> someone called F_SETLK instead of F_SETLKW)?
>

Yes, non-wait requests (meaning trylock) does not return
FILE_LOCK_DEFERRED. I added in some patch a WARN_ON() if this would be
the case.

However I mentioned in other patches there is this mismatch between
F_SETLK from lockd and figure out if it's wait and non-wait if
FL_SLEEP is set, but somehow if it's not coming from lockd (lm_grant
is not set) it's going over the cmd if it's F_SETLKW. So far I
understand DLM should never make this decision over the F_SETLK vs
F_SETLKW it should always check on FL_SLEEP. I can change it to use
FL_SLEEP only.


> That may be ok, but again, lockd goes to great lengths to avoid blocking
> and I think it's generally a good idea. If an upcall to DLM can take a
> long time, it might be a good idea to continue to allow a !wait request
> to return FILE_LOCK_DEFERRED.
>

In the case of DLM there is no difference between upcall/downcall if
lockd does other operations like unlock/cancellation requests. We
don't do the optimization there, why are we doing it for !wait
requests... but okay I can change it.

> I guess this really depends on the current behavior today though. Does
> DLM ever return FILE_LOCK_DEFERRED on a non-blocking lock request?
>

I change it so that it doesn't do it, but I can change it !wait
requests will return FILE_LOCK_DEFERRED and be handled asynchronously.

- Alex

