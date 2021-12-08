Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFA46DC9C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbhLHUIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbhLHUIx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 15:08:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01BC0617A1
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 12:05:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so12286675edu.4
        for <linux-nfs@vger.kernel.org>; Wed, 08 Dec 2021 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ft5I8nfLjeZ/UkJIKaimQmlaiHw8YvU1BOwkkaA2CU=;
        b=EmPFxcepJ5xGXXdhooOhOomYnq6mzAFIzdX9Os0Lv4fmZAc8bNPfIgTvGSDma1wZDM
         /0nC58OBnmMk9SL24E2Q18DwFVlAxlKE6US9Jd3tjuaU+0qq+e1J4OQ1tFZ3w+7AySmE
         xBGgRzVzOV/QSX+ovzGF6NMFyoU6mE/XviyHXe3n/46WuNoCVF6JHQrvWIg1BVdgTKyn
         r40/mgd4OyjS+Et19BkNGA/K8t7hQcqH9U/OBmpai1kkFN8E32C3Jn5ZYOenYGwXlhhV
         IPjauSMGU4L/s0QFo1HG9zRMtANfWhcn9PdOvE+doxgYi1wxPyGU+bzxBESSGBDfreZp
         MeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ft5I8nfLjeZ/UkJIKaimQmlaiHw8YvU1BOwkkaA2CU=;
        b=St0T7A+hiIfaYpYeX3ObVEhzjJJ0/AMBwbRsyQuN6HQKN3t1uszWkJTXzU2Z0Wfflr
         iyjmGLblXS8SoIvLMvrGE1LBgQcqdOMxBGjacPZ9eKdv0J7iaNRarzGDZMukVV4bu7VU
         AFf4iaYY9dzL6xvWFCIrtmWtQNfC1lk5w7hVzy3NYvbIDNIpYL/itWS5ShE0KRGcW1gA
         ZWQFJVNttjF+D22U7XGbGngmfpIosqDvj2Yr1YR/ro+mmP0SsGmB93aEINvA2qP+CnBD
         bO7GYuOIg38QNHF8HHSU3sukYhjL8HJab/G3bnYvPnkpGQEK+osB+QHQH5OuSKin2kSO
         xS4w==
X-Gm-Message-State: AOAM531MrwNv3O1F2IIwlVY+f2tVSj02dEGzzgNQwEB8aCA8Ay2kNQwR
        zgvcprWGiB59+gryPUYDlkX/TtTRQcQh+GNuxADN
X-Google-Smtp-Source: ABdhPJyAT5AcX24/vsaF4FuO3zmSI91sBLs+Bo7d3wsmD3mHwOXCNVYQbGhgfKwZE1LynLCP9HqwWfCtr/zzGD5cUOY=
X-Received: by 2002:aa7:cd5c:: with SMTP id v28mr22130323edw.6.1638993919043;
 Wed, 08 Dec 2021 12:05:19 -0800 (PST)
MIME-Version: 1.0
References: <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
 <CAHC9VhTP-HbRU1z66MOkSyw9w7vhK7Vq8p0FrxVfEX-+tSD43A@mail.gmail.com> <2846548.1638993312@warthog.procyon.org.uk>
In-Reply-To: <2846548.1638993312@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:05:08 -0500
Message-ID: <CAHC9VhS4ZOWHD4+NnJ4uPbrQv1nookPovw23XoZ+=xOSeMZtEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] security: Remove security_add_mnt_opt() as it's unused
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, anna.schumaker@netapp.com,
        kolga@netapp.com, casey@schaufler-ca.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 8, 2021 at 2:55 PM David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > There is already a patch in the selinux/next tree which does this.

It appears to be, yes.

> Looks pretty much identical to mine.  Feel free to add:
>
>         Reviewed-by: David Howells <dhowells@redhat.com>

Thanks.  I generally don't update patches for metadata (unless it is
really critical) so I don't have to do a force push, but if we have to
I'll be sure to add your tag (there is a tag from James Morris that
came in late too).

-- 
paul moore
www.paul-moore.com
