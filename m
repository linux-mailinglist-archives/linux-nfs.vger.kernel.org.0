Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49EA6A56
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfICNtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 09:49:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37100 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfICNtB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Sep 2019 09:49:01 -0400
Received: by mail-io1-f67.google.com with SMTP id r4so20773151iop.4
        for <linux-nfs@vger.kernel.org>; Tue, 03 Sep 2019 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWe9jVJa4kYCCwwbagBDrCd4LAkXd+dsWayfT9jW62k=;
        b=MX/r0m82vvaq5bEMqxi0mQqjOgniIrub6W1frIfpcdtEtU2k5sR/cXv3+XOhUB5cSn
         qb0SzqEnKb+vnaPYqMh4m8WKhI4K+SsJvbmhXRv/uepSU2mzf8c9oUcLNdbJi+8kyi9B
         UOY+/d6NXJCg3O7S8ZhrGGAYp46WnW9UTT8VTwv5fTHYFlaKNvh2Gogy+hmDKhbxPXdH
         +mEe5+svSO+QHEvYFGMA4s4o3Eog9g1sJGLjLyxeCBtmCTbzrwiK+5Hq52Wj4Kr52K8g
         8RtPhKKDkxIP8wlbWJ34WbEo7UEVEksVIpihrDLSgLXjxVVTX2CTyQ1K24hzGeaJKQQv
         QTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWe9jVJa4kYCCwwbagBDrCd4LAkXd+dsWayfT9jW62k=;
        b=LP0+8PwKiN7e7T5xUqftDclfQi06K2Vd9yEYAF27TyWVlx5ez1xK8bRSc8UJ56jxw1
         NljokgnGGXPys9opUDpZHJOtSgQIvH56cVloVuwxHDd1nFa/xoV8NFQSovq7xXNE+5y9
         W2LgzJMQKDyCTX/6F7Nw3kkkyrAIaP1Vo3QOD3njhNgqpg4yOhww/0xDhYluprTb6JkL
         qLetn64qqsqyQIeoIMc65vT7MM3ZgfT6hDO/XRFPzCz8mBv8r8DsiTO7FTGPfqxbIUnc
         SIUQDBNtFNPwC3PHblT7YWSdEdOWyr057bwMOu4+h7ayC+Nk+YNILSPwsGTtRkjePoMT
         vAZw==
X-Gm-Message-State: APjAAAXyBIVyop/gXjQSOUZtErjR/CFh3bw57AqjfFP7xsf0PrmCCIBm
        RL6zI5FMitSLSeTMdPMlxcsUarPdGXMeDDHGNEDA4w==
X-Google-Smtp-Source: APXvYqzqYpSYQnclga2JADOfhNAEHEsVWdwnqt7032Dm6Yozcamhzsd/8O6Ve+OXfgoLUyTMS3CNb4tTvGqc8YudQ+g=
X-Received: by 2002:a5d:8788:: with SMTP id f8mr4829794ion.20.1567518540174;
 Tue, 03 Sep 2019 06:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
 <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
 <20190826133951.GC22759@fieldses.org> <CAOcd+r059fh7J8T=6MdjPSCP39K5fpOZTsXZDUKq5TrPv_RcVQ@mail.gmail.com>
 <20190827205158.GB13198@fieldses.org> <CAOcd+r0Ybfr1WszjYc1K19Cf7JmKowy=Go6nc8Fexf5KxNyf=A@mail.gmail.com>
 <20190828165429.GC26284@fieldses.org> <CAOcd+r3e52q_ds3zjya98whYarqoXf5C2umNEX-AGp4-R6=Cuw@mail.gmail.com>
 <20190830195443.GC5053@fieldses.org>
In-Reply-To: <20190830195443.GC5053@fieldses.org>
From:   Alex Lyakas <alex@zadara.com>
Date:   Tue, 3 Sep 2019 16:48:48 +0300
Message-ID: <CAOcd+r0XkLxLPnjBQ_R1pRyreJXkOZ27gJSqVn9c2bs=b792Eg@mail.gmail.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Fri, Aug 30, 2019 at 10:54 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Aug 29, 2019 at 09:12:49PM +0300, Alex Lyakas wrote:
> > Would moving this code into the "unlock_filesystem" infrastructure be
> > acceptable? Since the "share_id" approach is very custom for our
> > usage, what criteria would you suggest for selecting the openowners to
> > be "forgotten"?
>
> Have you looked at what unlock_filesystem()?  It's just translating the
> given path to a superblock, then matching that against inodes in
> nlmsvc_match_sb().
>
> It's a little more complicated for nfs4_files since they don't have a
> pointer to the inode. (Maybe it should.)  You can see how I get around
> this in e.g.  fs/nfsd/nfs4state.c:nfs4_show_lock().
>
> A superblock isn't the same thing as an export, thanks to bind mounts
> and subdirectory exports.  But if the goal is to be able to unmount,
> then a superblock is probably what you want.
Thanks for your suggestion.The superblock approach works very well for
us. Initial patch is on its way.

Thanks,
Alex.

>
> --b.
