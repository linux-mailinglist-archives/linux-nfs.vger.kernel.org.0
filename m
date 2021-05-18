Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB4387E65
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346293AbhERRco (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351129AbhERRco (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:32:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C8C061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:31:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o5so3206936edc.5
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zprYpp0afBYFsxCS3I6Sv0904OugRDfkwMEN7L3D4/w=;
        b=cr0vfXsaGySVIPAaLzXAsSOeRtUq3Cu4cFjYhvxj2qV2Gb3FkTOjRxQ/Pq5pH6vwKc
         nqKy9fOYcQplFZh6YBzydpeN+sf6a0NJ+CjcVWXRWBgO5dV3e7uYhG7wRDqfSEIW9qC3
         /ZPZ/GWKfaOOYKjz+BeVY9WUo4TgFujcF346tNejFYIXKtUbwjqkWmN98BUwLaIHCrpy
         /NgX0BO2jdxzERZ0iGfCJPKRspRM2TC65e/VAF8ryZ7b+cYgpp6sAhyUtdDonlFemYo0
         Dj0PLaX7clbvQP3LV8+aYFaCE5Cx0HRVBCAO2TqcGbOkCGKDa9MeDNI6BZvCPBMsBNGy
         Ioow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zprYpp0afBYFsxCS3I6Sv0904OugRDfkwMEN7L3D4/w=;
        b=I3fk+rRzF0p/3kSCmjtdx3vv16uStmBNYaD9fru+D6TDTWZbWsuvVTVJJkh5BHmFfG
         KuuZweD1I8ci+sT/WLRK4k6+b+OOstmce1jtfsBD9IQt+xeoH2Uqh7xW7R4m9Z8bbtqX
         UbMrrtsCXVVgzZbBQJI0EeJ13ECohWFeHHicAEUn+Q8KS3b1ZcnhmGQsjQAgvGxbfC+d
         ygHwEONC8rlyI4vn3TF1eL0Mzp7CEXOk4LhmLueHqkx4V8DJViDldyXOY+pFGQFdb5XG
         dzYXs1qH8u+rjjTDQaRTaEV7T1rPpW8wvAzUAdfXPl6vIl+99PvhlK+kTFHwaWuP6j33
         qRfg==
X-Gm-Message-State: AOAM5305xPcvP8mBsFXloSxEPTTEVGgFUisJUOPDeVOS+bhvsrEZEybv
        UbGD6hwXHVI1sbd8WyIevuS/sMBjTvBAU8TMk4Z+9Inpfyo=
X-Google-Smtp-Source: ABdhPJxJO7kruLpqLnmTlI8/3D1Da7Pi0PiGTjWIscXTomYsXN+fipmfTCVIHKE7vpYtn7YIVLm5PqLzNljzi1gX0Zc=
X-Received: by 2002:a05:6402:3546:: with SMTP id f6mr8391486edd.267.1621359083420;
 Tue, 18 May 2021 10:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210517224330.9201-1-dai.ngo@oracle.com> <20210517224330.9201-2-dai.ngo@oracle.com>
 <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com> <20210518172334.GC25205@fieldses.org>
In-Reply-To: <20210518172334.GC25205@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 18 May 2021 13:31:11 -0400
Message-ID: <CAN-5tyG2pcduQAWJDaP83VgqK7QfsnoDZJe-JG=Oqdgj4PjSUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 1:23 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, May 18, 2021 at 01:16:56PM -0400, Olga Kornievskaia wrote:
> > General question to maybe Bruce: can nfsd_net go away while a compound
> > is using it ?
>
> No.  Any server threads for that container should be shut down before
> nfsd_net goes away.

Right, sorry but the async copy is a task that works after the
compound of copy.  You say "threads .. should be shut down", who makes
sure of that (meaning should async copy code make sure of it)?

>
> --b.
