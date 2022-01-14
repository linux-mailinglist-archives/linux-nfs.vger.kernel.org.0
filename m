Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EDF48ED7C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiANP5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANP5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 10:57:15 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FDFC061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 07:57:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m1so31673520lfq.4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJBeykaq3tN6IiLxKLJ3GIe7Db+Bivq9jsPCh6JO9xQ=;
        b=I5hXTG7rrKQxwZY6i4Sc+Fizc+Ar8NMgdHHLYq5f42WI3Xx1VapQRKHNBmNnUmY3Ci
         quSxTVdyXTF/WR9RfiaH8AfhseEvST7O8yh+hryK7pv7DgAr2/qv0dDhkf/Re5Auqpf+
         lIKyeR0YM+NfdDvWHq1BnujOB1W1OPmJNW4UTZD2zu1A9vCZAvD4GyhzveqPUHeeWhgn
         P4107DzthXYGbHEkQVO/hNT8r8LjDIoVMTX16jfuhRyLKAPPMv+pJn7ObN4DiyOgmlWM
         v7TrfqmdFoinFPUq/V3Q0e1YUqToDrZfSPC34uiAPRyUHNoO+qNbnd3SjSsznYH9qELN
         HcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJBeykaq3tN6IiLxKLJ3GIe7Db+Bivq9jsPCh6JO9xQ=;
        b=Ej6cto4KBUCsR4Tk41M3jF14QoyyPlr5vtjDRNT8FOoG5mJwqWo6Ee3vFkxjg4SDL/
         6nu7eimuRre6aU6uZHeoyhTL/Aiuu1n7JGwcOgpB0OFzfIOx/P9j3ApLZIh/0uL1Gs0V
         nyxrT/MoFWflIxsKJX2DG6Fb2O5arotBCrFc2R2YIe15zOJuVH2CoQN/qAjLrO/I5d9+
         9lkbM2aIPSWMDXPCLsViGAPAXCn9LYa26IcNAVV1SwdPNJgaSxYutiGPbhhqqQwa8xL/
         37dGwe2Zcep9XtYX8c/D6eCcrslGq3I6o87+nqefyzhPlrTvJEOPGTlSmxuv3OJUyLvg
         bAPA==
X-Gm-Message-State: AOAM531mMecd5RbAeRZ/jH2lFfzjQ8UksYu5kQqC1VaYsuh46oX6GQBZ
        xPWLyjmQ1jiLdOpU2d4kqPOUaJ74PCTH9M09GDbM+yUxdS8=
X-Google-Smtp-Source: ABdhPJy4OxAA2fgIP12QU2vzojYUlOD+BdHN6ZDvONEchG0cA8O/BUWEvVe/M2eSWqvFCYIbJm0nCEk8rYgevizBdNo=
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr7446462lfg.43.1642175833447;
 Fri, 14 Jan 2022 07:57:13 -0800 (PST)
MIME-Version: 1.0
References: <CAAmbk-f7B4jfmhe-aH26E0eRQnOxGGFPr3yHZMv0F4KQc6FVdg@mail.gmail.com>
 <20220114151022.GA17563@fieldses.org>
In-Reply-To: <20220114151022.GA17563@fieldses.org>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Fri, 14 Jan 2022 15:57:03 +0000
Message-ID: <CAAmbk-e1Pd0JaAVM8PFbeepj=tdL8qcyS-DaSA1u42=S_EySSQ@mail.gmail.com>
Subject: Re: [bug report] Resolving symlinks ignores rootdir setting
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> I'm probably just reading too quickly, but I'm not seeing how this
> explains the problems with your original configuration.
>
> Is it that /sr/nfs/bin on you system is a symlink?  (And what exactly is
> the content of that symlink?)

No, all the directories under /srv/nfs are ordinary directories. The symlinks
are in the root of the real file system.

So I have:
  /bin -> /usr/bin
  /software -> /usr/lib (created to test the hypothesis)
  /srv/nfs/
  /srv/nfs/assets
  /srv/nfs/bin
  /srv/nfs/software

Because exportfs is not taking into account the rootdir setting, when it tries
to resolve the path from /etc/exports, it sees the path /bin, and matches that
with the real /bin, and resolves it to /usr/bin.

Later exportfs errors when trying to resolve the real path (e_realpath) in the
exportent_mkrealpath function, as this function does prepend the rootdir. This
causes exportfs to look for /srv/nfs/usr/bin instead of the expected
/srv/nfs/bin.

At best this causes an error, but if that does happen to match an existing path
under /srv/nfs then it would export the wrong directory.

This will happen for any export that happens to match an existing symlink.

There are two issues though that I'm not sure how best to handle:
* Should the symlink be considered relative to the local system or relative to
  the rootdir?
* What happens if the symlink points to a directory outside the rootdir?

In my case I think the symlink would need to be resolved relative to the
rootdir. This is because we're re-exporting an existing NFS server, so if the
existing NFS server is exporting some kind of symlink tree, the symlinks would
be relative to the existing mounts.

One option that would be valid for my case would be an setting to disable
symlink resolution and just consider it an error if an export is a symlink.
Since I'm re-exporting an existing NFS server, they can't be symlinks anyway.

-- Chris
