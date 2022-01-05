Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07840485680
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbiAEQLO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 11:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbiAEQLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 11:11:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282AC061245
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jan 2022 08:11:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f5so164077465edq.6
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jan 2022 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxN2+RBbm1mVVj7aq4hzcYauVP65vZUJhyBFTLYSt8k=;
        b=KKIdTJjoudCSQ4h3XsHeO6vIKqEgefxRxZX7GX6ng+ShJIajy9DkYBLzYoTka3fpEI
         KrLkEVIYI+l5H4VCAZ4z1RBVc0GiFPcjrLHUwc1hiGOYo0i/gmtzDOMehZL946fdw2pj
         LmkMM3UhIpLswlZMAr2LmHpOYO8X9bQbekVerW2+kIOjS3qatQeqtIjldxM8r/XAypur
         hRpMqy9tgSeVQOmqiLGuvT+dldlSQiGUHIBb9RLyljcAWXXHtOLm0jPl//aHgqXA9yre
         xPPdFkZ77lZi6SqxKSPTwc42zo27aGh0A78m4GFSyMGGdlUK7cY/6t0Iu2I46pBxRWTX
         mmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxN2+RBbm1mVVj7aq4hzcYauVP65vZUJhyBFTLYSt8k=;
        b=RnOtW5a+cVtqQ2an5g/EZvaY1q1rRW9zXoWAS9clsnQIgbW+ToRxDsAisyjDih9WIR
         e+I/a1+AeCfpHejkTYLqLoTJlMSp1BJ/xe7GjPHuJGYZre2F9DtnreDEOZTPjwKgEJU9
         TzwegB3B42+ifKCWSv4aokjSZsKIcjiDOhRfBpFk8eGSJnwSEmZ6mAk6WSeIvuJ27P8E
         EeLuwEhwapnRUAzLIo06p6SOMFYIyS3xcjuc3GgNmOwEIOuOqmi66BlokKevH5nZQJ5f
         XBaCtE5sUYQCt1a+E7+yBtgc8Sm5lYkWCIABG3qPMg4vj51NTbejKvcc9UVhfFOz40fZ
         l26w==
X-Gm-Message-State: AOAM531SoS3MCJPYVpuvuu2DqsWdtasT/Wro++ahI+DMMnHHmkiXuON3
        LXs7U1jyaHtIZyfX0YgtEVaI3P1YRVi1+zwRlJthfA==
X-Google-Smtp-Source: ABdhPJxTpSA4UoRD2Q0+WzwOqtq6RKoo9T+EHug4TOK4THrnGXzrP3TwfR166Q697UvkUTFev2HK383PakvSkAAKykY=
X-Received: by 2002:a05:6402:254e:: with SMTP id l14mr54261650edb.241.1641399072528;
 Wed, 05 Jan 2022 08:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20211219013803.324724-1-trondmy@kernel.org> <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org> <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org> <20211219013803.324724-6-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-6-trondmy@kernel.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 5 Jan 2022 16:10:36 +0000
Message-ID: <CAPt2mGPO1z3+Cr1FmQfwsKCa4hdT=2eczTqDxCjryt-y5Rm6yw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] nfs: Add export support for weak cache
 consistency attributes
To:     trondmy@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I was interested in testing these patches with our re-export
workloads. However, it looks like this specific patch and the previous
one (nfsd: Distinguish between required and optional NFSv3 post-op
attributes) are breaking re-exports in such a way as to cause
applications to randomly crash out with sigbus errors.

At a guess, loading applications and memory mapping data files are
particularly good at triggering this. I can see no errors logged on
either the re-export server or the eventual client (e.g. stale
filehandles). We mostly re-export NFSv4.2 servers to NFSv3 clients but
we do also have a few NFSv3 servers re-exported as NFSv3  too
(Netapps).

This only happens with patches 4 + 5 and vanilla 5.16-rc6 does not
have any issues. I haven't had a chance to dig much deeper yet, but
thought I'd flag it anyway.

Daire

On Sun, 19 Dec 2021 at 01:44, <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>
> Allow knfsd to request weak cache consistency attributes on files that
> have delegations and/or have up to date attribute caches by propagating
> the information to NFS that the attributes being requested are optional.
