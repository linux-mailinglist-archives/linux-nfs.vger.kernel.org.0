Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F01285405
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 23:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJFVqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 17:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVqY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 17:46:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBDC061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 14:46:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id md26so2963ejb.10
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QbHxbVzAL/FCa7e8ofbvFTyOhXAwRBnh9tG8sTahv8I=;
        b=Y706aE2iFRo2rRSOYiz4DRYZkkAZCKTutxnLs7PsmqAbPw5pAPhPEV5Nh4FjKC9XAK
         VIa7O6DCzrJALDfYjsDjJv2qaKAGxEGLbfygHdQGIM+qPuczPUTuhjIUnFKBKtNFvzE4
         tIRS3GOKXU/aKJVqogzMTOCx2ptJkeFzcZJ2A895ngn30Jrw93cCBFycNsUvjhZ80toa
         DgchKjX0QjKHvEEQIbDK7/20aMDaWLNr4ETpZMDhy5/AkJiPgEEzNK8KHM4tFlaTeYH0
         yaQvDA+XZjix+eGMFy7ji1fbyJJWXqvZ/VWjgcc/8dAh5LU5s4ezHbguaXqwXDZPA9Um
         B7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbHxbVzAL/FCa7e8ofbvFTyOhXAwRBnh9tG8sTahv8I=;
        b=TVdZGPwGI2OLsFx61gfAL9+ljsJr0AgjuMJiaJnsp6acutICuYEiruKqAciQhJj4Lg
         oDP2z5Ebr0+YJxnOpmvynokFFxS9giVwnpQYmYBi//NWrlL/b7/K6izvMtHGauwxtMCf
         ApvVFJKIxX2+PSH94Dki+Z+IBnU81KNIo54VS6Ov96rTL/cF+lFvqQoKYIFbHcu3Sm8B
         gtf0r+LGzNAjnUKjQdu9AkrvhU9oPqgAgi82M/NHrUpchPWwXU7hZp5K7+tyY7uV+lK8
         ZD+lB4taMmuVQu1NTFmPSrgY8HkgdZn8GRPmUU/B0IPdf2ouPNWTTltvOPy2oEODd7N4
         iCNg==
X-Gm-Message-State: AOAM533MyY7qaQwCzY9kZ/GpUhJj+iT6G5+1KSJTBmqKki1gELLRLlhB
        DeuBXL+i4HxDlrF4MMpDXQCeDFy2sC4we1ECEPKNW3f4qMo=
X-Google-Smtp-Source: ABdhPJz1JLicRFEfkEJxxYl6kfo2851v4Wqgnzy9xAyOUZahJIk0kcRB8yU9mEHuFC3IjX5FbjMJdmwjays057Q5oe8=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr96242ejb.248.1602020782409;
 Tue, 06 Oct 2020 14:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201006151335.GB28306@fieldses.org> <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
In-Reply-To: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 6 Oct 2020 17:46:11 -0400
Message-ID: <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
Subject: Re: unsharing tcp connections from different NFS mounts
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
>
> > NFSv4.1+ differs from earlier versions in that it always performs
> > trunking discovery that results in mounts to the same server sharing a
> > TCP connection.
> >
> > It turns out this results in performance regressions for some users;
> > apparently the workload on one mount interferes with performance of
> > another mount, and they were previously able to work around the
> > problem
> > by using different server IP addresses for the different mounts.
> >
> > Am I overlooking some hack that would reenable the previous behavior?
> > Or would people be averse to an "-o noshareconn" option?
>
> I suppose you could just toggle the nfs4_unique_id parameter.  This
> seems to
> work:
>
> flock /sys/module/nfs/parameters/nfs4_unique_id bash -c "OLD_ID=\$(cat
> /sys/module/nfs/parameters/nfs4_unique_id); echo imalittleteapot >
> /sys/module/nfs/parameters/nfs4_unique_id; mount -ov4,sec=sys
> 10.0.1.200:/exports /mnt/fedora2; echo \$OLD_ID >
> /sys/module/nfs/parameters/nfs4_unique_id"
>
> I'm trying to think of a reason why this is a bad idea, and not coming
> up
> with any.  Can we support users that have already found this solution?
>

What about reboot recovery? How will each mount recover its own state
(and present the same identifier it used before). Client only keeps
track of one?

> Ben
>
