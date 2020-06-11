Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65F1F6CF4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgFKRmb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jun 2020 13:42:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82806C03E96F
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2020 10:42:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so7289200ioo.4
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2020 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrTC9326PPl3co55wZmjDZ0Xflo90DL5aVhBJxM2Yw4=;
        b=PplwCDNFff4ZY+3N0HCeaqG8ozC6c7VUFvKGDQspApmn30a609ZfK7167TjhdEG3Mb
         U4kFeXP4ZyqPdtkDBAMSZJ0NXPm3KaQ2/naup2Lsf8NK80zoo1u0y2GgvRZZF6J5+KRm
         /NND81Ub2LHtt+6dSRnroWqt3ZA6Irx1xC7jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrTC9326PPl3co55wZmjDZ0Xflo90DL5aVhBJxM2Yw4=;
        b=QX/ilerdR2a56Ar8ko1BO3xPn1iRjFzAqPaXS4k+olLTu+SQoM1LQl5PLjVSIk/W5N
         PMQhibcCMexwtOZ8/RwpUAWGTwjSdGkfvX4yiv+dWu/pLMy/vLIxGynPb76bM3rmR7MO
         +ZPF0gDDawL41VpaBXgi7NeqVBAbLbnBkTanvBEJwv+mjkTSdYYh2V4dxuSUxpK3dPmM
         T+JZlpgkUW/HuBffzdahs9ml/Kbn4IanCqGAMO5t369sxwRnuSipOl1I4yYBidVrEpHL
         MpmQQQF9QlNPoyCZ4zYsN1paj7h+I7R+v7w6V3cGjRqJhRvVgCxrjLbYz1NGmmRUSYEE
         gn5w==
X-Gm-Message-State: AOAM533ovztPXWlC7KkTUMmw7N2gPV+Hhyp2BwJyzqcxirINCrvbjXGS
        841AxGpC+BbO7oFPv5P1Ek7MIx2/IhPnVNu6kM8Ufg==
X-Google-Smtp-Source: ABdhPJzO/lkHiqncDn/LZVkUvynfG69hGKQ5ZFyoqkHX2ey6xr9CahKa0kBWPvDj+ZZ8kbSSjViKnx5Ynqib9K6Gn4I=
X-Received: by 2002:a5e:d507:: with SMTP id e7mr9630728iom.132.1591897350906;
 Thu, 11 Jun 2020 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200611155743.GC16376@fieldses.org>
In-Reply-To: <20200611155743.GC16376@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 10:42:19 -0700
Message-ID: <CAADWXX9tV_khCjrO5eUJQry+QV4VLatt21KEkJ8irEcuqTbBsQ@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 5.8
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 11, 2020 at 8:57 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Please pull nfsd changes for 5.8 from:

I'm not entirely sure why, but gmail hates you and marked this as spam.

I (obviously) caught it despite that, but thought I'd mention it. I
assume it's lack of DKIM for fieldses.org.

Or maybe you run some side MLM business peddling essential oils that
I'm not aware of but google dislikes? You do you.

               Linus
