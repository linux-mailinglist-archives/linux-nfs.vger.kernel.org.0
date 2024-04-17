Return-Path: <linux-nfs+bounces-2880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DC8A8711
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F22282121
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AD146A73;
	Wed, 17 Apr 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXqg2PJ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02B13959C
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366530; cv=none; b=GmCoDJsaLLdjK8CvV5+uTdMXVLwYyK8bgG1LBND4RC8OdJ3oTtA2UzScsr6NBkw6Z6PfPWpY1IJaaikuerU2RdIF3k+niYahmDIrjZ6K3EO5L0xhYJig9QP7W8jnDlMLSZS8dHYMkrABH3Xy/jQfkubV6bmsUtm6cUWjxxgmmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366530; c=relaxed/simple;
	bh=RQeHqheZvT65k4jqcZVmdjfXbwxwuYmOto5IrYzm8d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxVAl4yJ5VTNiDK8lNsPfPqVY2NiYhBOMWLOQZoZO0MQJeOKovjLntXGRt3SgupQq+rT9RiWuv5jojmyuq8jYjpjXwlipC7p+vCPTpN3cNJMiOtAwSZBHGwGWyhW+LkTkGInXJk1IHNt72+J3nbFX7S7nz0eebq7uX7mlnlql0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXqg2PJ7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a526a200879so482432566b.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713366526; x=1713971326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5+OKrUCM+OoRfNzn77TNMdHzGIbRv0gT+t84eLkWMg=;
        b=BXqg2PJ7Al9ApefiBM6cApCUbxOFqpI1Bu6EknP1ScgkQzC9E+yeZgE5Zf4CRG41kN
         hnDd1muEnngYzZCG+8NYhhvl1YFFVoxyuZyHkSK2vw3hAOxdy9MIZTFyXnjvHhAAgoDd
         8RaQomOXAVxWa6INflb3NTkBi/4Za91bOX2KH5I8M1dl2neIvENxzFhDJ4WrTXOSeQip
         CYtTTxZ3mKVUjgZ1Eg7q82EV6Xc9gES+rmC2/Q3VlzKB3yda2jSCtZPoO/gBJUuVG+GP
         Q9OpZffpkAP/P5u/+pOAwQ1R6uU49zwp3pkMJ8Px/rWIYYB8gwY1E6dYYIfOYpeiAPKd
         4DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366526; x=1713971326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5+OKrUCM+OoRfNzn77TNMdHzGIbRv0gT+t84eLkWMg=;
        b=NNZ0HtXRX6bRq+V/F4ZDiowegNl1VaJvm/q5Z0JqSKM+TRARbWB/mdYN8jXrCjMBYD
         8eyEDh91GS7EAW3JzpJ4g3wGDIQKIr0KIKrxTsnzTyAkpx5RyAwSEXxWE3Nr0ngtsjLM
         ulHBYZpHtCdRH4vz0P8dZ+Ph2RHnr213worGUfxVDcpUQTE1aFpOoxXHi766UWWS6+MP
         jzXz8MQFixtWJow281zj53/K5IYFzGt3532WxNZg+rK32f2ED/pK/NWRijdQwimF6VNJ
         zVr1Jc6kYUCha7sDs3nxhdNzgrlSr0qDmh27DId9QNEJRiau2XzQ6zC+jmbbMTO+Z5Gr
         6WlA==
X-Gm-Message-State: AOJu0YzfxGxp++MPxm3tGvUYkfSkFFwXodNBs3zue00wBwr6xZQqGHjU
	RdkXJ1g9XfG+h+TJN+hpRKisCSudzSCrZB3c6NnGoGg9mkJDqf7TBws0fyhBVrU=
X-Google-Smtp-Source: AGHT+IFeVub/2gl4V6r16nq/tmiMnc2J+n8PSywNPnbdZHPjdueaExwTWMFPae1aDIUUFj72HjtdSA==
X-Received: by 2002:a17:907:7895:b0:a55:3707:781d with SMTP id ku21-20020a170907789500b00a553707781dmr4007271ejc.73.1713366526286;
        Wed, 17 Apr 2024 08:08:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b00a51bbee7e55sm8143738ejf.53.2024.04.17.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:08:45 -0700 (PDT)
Date: Wed, 17 Apr 2024 18:08:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Message-ID: <ae7bbc2e-49c6-46df-8876-06b11dd551e5@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
 <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
 <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
 <F0002E44-B2E9-4DE3-BF3B-771F814A8EE1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0002E44-B2E9-4DE3-BF3B-771F814A8EE1@redhat.com>

On Wed, Apr 17, 2024 at 09:51:48AM -0400, Benjamin Coddington wrote:
> On 17 Apr 2024, at 8:40, Dan Carpenter wrote:
> 
> > On Wed, Apr 17, 2024 at 08:00:04AM -0400, Benjamin Coddington wrote:
> >> On 15 Apr 2024, at 4:08, Dan Carpenter wrote:
> >>
> >>> [ Why is Smatch only complaining now, 2 years later??? It is a mystery.
> >>>   -dan ]
> >>>
> >>> Hello Benjamin Coddington,
> >>
> >> Hi Dan!
> >>
> >>> Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
> >>> referral lookup.") from May 14, 2022 (linux-next), leads to the
> >>> following Smatch static checker warning:
> >>>
> >>> 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
> >>> 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' = '0'
> >>>
> >>> fs/nfs/nfs4state.c
> >>>     2115 static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
> >>>     2116 {
> >>>     2117         struct nfs_client *clp = server->nfs_client;
> >>>     2118         struct nfs4_fs_locations *locations = NULL;
> >>>     2119         struct inode *inode;
> >>>     2120         struct page *page;
> >>>     2121         int status, result;
> >>>     2122
> >>>     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func__,
> >>>     2124                         (unsigned long long)server->fsid.major,
> >>>     2125                         (unsigned long long)server->fsid.minor,
> >>>     2126                         clp->cl_hostname);
> >>>     2127
> >>>     2128         result = 0;
> >>>                  ^^^^^^^^^^^
> >>>
> >>>     2129         page = alloc_page(GFP_KERNEL);
> >>>     2130         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
> >>>     2131         if (page == NULL || locations == NULL) {
> >>>     2132                 dprintk("<-- %s: no memory\n", __func__);
> >>>     2133                 goto out;
> >>>                          ^^^^^^^^
> >>> Success.
> >>>
> >>>     2134         }
> >>>     2135         locations->fattr = nfs_alloc_fattr();
> >>>     2136         if (locations->fattr == NULL) {
> >>>     2137                 dprintk("<-- %s: no memory\n", __func__);
> >>> --> 2138                 goto out;
> >>>                          ^^^^^^^^^
> >>> Here too.
> >>
> >> My patch was following the precedent set by c9fdeb280b8cc.  I believe the
> >> idea is that the function can fail without an error and the client will
> >> retry the next time the server says -NFS4ERR_MOVED.
> >>
> >> Is there a way to appease smatch here?  I don't have a lot of smatch
> >> smarts.
> >
> > Generally, I tell people to just ignore it.  Anyone with questions can
> > look up this email thread.
> >
> > But if you really wanted to silence it, Smatch counts it as intentional
> > if the "result = 0;" is within five lines of the goto out.
> 
> Good to know!  In this case, I think the maintainers would show annoyance
> with that sort of patch.  A comment here about the successful return code on
> an allocation failure would have avoided this, and I probably should have
> recognized this patch might create an issue and inserted one.  Thanks for
> the report.

To me ignoring it is fine or adding a comment is even better, but I also
think adding a bunch of "ret = 0;" assignments should not be as
controversial as people make it out to be.

It's just a style debate, right?  The compiler knows that ret is already
zero and it's going to optimize them away.  So it doesn't affect the
compiled code.

You could add a comment /* ret is zero intentionally */ or you could
just add a "ret = 0;".  Neither affects the compile code.  But to me, I
would prefer the code, because when I see the comment, then I
immediately start scrolling back to see if ret is really zero.  I like
when the code looks deliberate.  When you see a "ret = 0;" there isn't
any question about the author's intent.

But again, I don't feel strongly about this.

regards,
dan carpenter


