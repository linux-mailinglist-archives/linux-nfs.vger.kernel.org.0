Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168D86F19CF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjD1Njy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346344AbjD1Njv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 09:39:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164535B8
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 06:39:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75131c2997bso615611085a.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682689189; x=1685281189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksPuMd/nWB2WaYDgyVZZ1GQJEYq4kNKPng4+0nhoQHo=;
        b=ARo04kJqXnGihMAgnU4MvdX+xSPvjPoukj2cxkUEVvZkVz+vtDFtYJP9rDM9gMqijl
         UuqNCAaTnhQGsisFViPypaLjFCMukgSJIQPj/gVBZRxXzsc/hVAY1kEsn/lHMD9DX0eF
         +JG53QcNt90dlKsprzggZBg8mW3eTFUL57PgWWWguTAJ1QE0+BGfu0J2Cy3g0kmkVeY7
         VeFEm1R9NDscmFqug5G5hP67QtYl0uKI5BIUQq+YnoiH0Ag2/RqLJFnUo+iuw5Tb9KJs
         qvUtK9xsvbe+/oaVJERuphRFbVbGaHiFAvdXUWhD0mRJmfJLHgnJ8eB2ohMuPO4PKV5V
         9OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689189; x=1685281189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksPuMd/nWB2WaYDgyVZZ1GQJEYq4kNKPng4+0nhoQHo=;
        b=lbV9NyFCRwF72Grzxx3l5UHrDKkQ1O79nUkKQv0hfLILc3t2uQQAmmBSzitxs/5Yfu
         27N+bfsM08MicP/l3p0EFHi3DqPaTL6QUuWhRaxVDEomHGwCjzF+9RgsEotIc6rmvbUq
         vKfl3079PaI5KLkAfDJ7e/oFzq9AVXga7UU6wOyB2m7Ml9yeT/Ho+WfROgD2PT5zg5Sc
         OWZ2owEQAwgMRyokgmXfiWcYuJTE2slEmifSiEZ29uQn7Tkk62ueli2eJH11ud7RvDjI
         D3Kmq7rK2hHjJMFiNfog1I6ZZpYOkwT3s+mNxPz/bhhDfspv/QtPTRlepr2lSEEoG+Wn
         8N7g==
X-Gm-Message-State: AC+VfDxfr30ArTtdCPQ4nekn7WytIDoSZLBkv9AZTSLNymVS/X+MtXyO
        ZYyKH1nap48g47GYp4H0+egi/A==
X-Google-Smtp-Source: ACHHUZ6eLxhmU3noiqnW+gzNksajCNvjQhvISupgtPuJ+2Um8l2kLcGLakZYkt9FEj9LAf4eqerq6w==
X-Received: by 2002:a05:622a:1350:b0:3ef:34e1:d37d with SMTP id w16-20020a05622a135000b003ef34e1d37dmr8041765qtk.25.1682689189215;
        Fri, 28 Apr 2023 06:39:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f1-20020ac80681000000b003ef3eae106csm6957420qth.60.2023.04.28.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:39:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1psOKB-003CDC-U8;
        Fri, 28 Apr 2023 10:39:47 -0300
Date:   Fri, 28 Apr 2023 10:39:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <cel@kernel.org>
Cc:     BMT@zurich.ibm.com, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Message-ID: <ZEvMo4qkj9NSLXTA@ziepe.ca>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 27, 2023 at 01:14:43PM -0400, Chuck Lever wrote:
> From: Bernard Metzler <bmt@zurich.ibm.com>
> 
> Tunnel devices have zero GIDs, so skip the zero GID check when
> setting up soft iWARP over a tunnel device.

Huh? Why? How does that make any sense?

Jason
