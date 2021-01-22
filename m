Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6692FFCFD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 07:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhAVGze (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 01:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAVGzd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 01:55:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18B2C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 22:54:52 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h11so9069163ioh.11
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 22:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owU0xL5sKZo1LardI/T2I9IRO+6HGILkUW6/eHcCe6o=;
        b=cCStzEnTB6jOsnMwESivl/55b0hP3ohAVeA2HSaf/K4TJ6Km+tl6atGcxBmrudv9+J
         8y7ib8fuu6rXEebJnrEp2g3sXNXsATEnXTwSXtxCVWWId5TWPlpCWeRgY/7Gpsbmy2W9
         zKU8PIVz5u2Dxx2K6S4eOoR3KzwNdTJJB8EFojik8a+gmduDnlJRXomQiikB9RxMQxgS
         EPXeQPrrBuVa53fu1u6lvOFKLBIYjzk3lyk6IGTMw5iWJwn+G5OitYEe6hPAhtKfbbqh
         3h+u8QDq72X7hNWfnoMOD/5HhfF2U9ULkCwWYwHN1WQf9kP+zxuE5n21uDcQz/380X+x
         C+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owU0xL5sKZo1LardI/T2I9IRO+6HGILkUW6/eHcCe6o=;
        b=VoonaBEtc0SAoNEPQ8hCp8LP659QwYWJKcolySrxCHgIgQmZcj3o23k9TnepwOfbZe
         7l9SeWgpykoXDqnmSwCMagafd1YEbsKZEL7X+7RstglarXC8E0kDMp/q7m2elftmC6fG
         N4q9hNeTgxRHCuHnRRraS2fpcygE2FLRL9+o5FUp+GOXATeb22ErH8d+LcBlEIL9dYt5
         DMSMPlWXjgAXQEkQE2lj+uCO+B3SEb/KQdgcls923csrbOH08ot9VGqGglUoFpWD8hVY
         0/bmauSG4jNga9swLbM8qOeMSB/HKxlMimDOjaSMrTbhhyEd1wO4H++TBnuodUcLNXr0
         HVrA==
X-Gm-Message-State: AOAM531toqtxdCq7iz6spKy07dH8O1oKtjrLshWsrYEhqOudWvEoZlmZ
        jbHna4YJlXNgZv572weRf+7q6XPjvwprlNZP8uI=
X-Google-Smtp-Source: ABdhPJy/RRm3QB8ZlZurDtHIE6kGnt/R6+9dcRxINsTQg//yAnXx12qssu1vIoN55lHeIYun5PEpV65tOpECHvE2x8k=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr2868470ilj.250.1611298491045;
 Thu, 21 Jan 2021 22:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20210106075236.4184-1-amir73il@gmail.com> <1FD02545-2449-4CA5-B408-957495138CE6@oracle.com>
In-Reply-To: <1FD02545-2449-4CA5-B408-957495138CE6@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Jan 2021 08:54:40 +0200
Message-ID: <CAOQ4uxi7LY8ynBb9zWy6JJSZNEOBjQR7R6+Tk_QvutDVJiFb+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improvements to nfsd stats
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 22, 2021 at 1:39 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hello Amir!
>
> > On Jan 6, 2021, at 2:52 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Hi Bruce,
> >
> > Per your request, I added a cleanup patch for unused counter.
> >
> > Replaced the hacky counters array "union" with proper array
> > and added helpers to update the counters to avoid human mistakes
> > related to counter indices.
>
> Thanks for your patches. v2 of your series has been committed
> to the for-next branch at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> in preparation for the v5.12 merge window.
>

Great!

Thanks for the notice,
Amir.
