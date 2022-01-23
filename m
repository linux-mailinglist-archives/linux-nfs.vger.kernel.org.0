Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8B4975D8
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jan 2022 22:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiAWV45 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 16:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWV45 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 16:56:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97555C06173B
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 13:56:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so52971120edj.7
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8Qlx2Y0Gj828eOtscq+aDqTjpEitB+dOoh6J81FcOQ=;
        b=BZ7aSMqb/R0txDCelS4BmXZmApr/cmHxUspxIvp/xAru19rs8NupUUYtXkpiP7Rt7l
         TdX9jRS4guYEQrmJAYg/VxmOHdCFvy5avXkXIeJZxfzI0HZftYtz+8qnbKTG8ai/3mU1
         wnm5cPu8u4+ObdJ2Xb9G9QZW6cilaXljAugb6t7dQA86M9CkervjDdSL5nyQ7qkuNI8z
         efKupGxgDAoF1VleWnvbMH8q9kt3dkal6tKRy6+9OhQ3BfyAyIBI9oadzER3dOLtk1oR
         8OiARez5tzrxr6zyIshcfAgAxZmSmyFx4WRPduJV76Lba/C5kYTbtokVFkLJHZjohCWH
         2tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8Qlx2Y0Gj828eOtscq+aDqTjpEitB+dOoh6J81FcOQ=;
        b=3zXEjM/LAfqR+jrhcEVj95s58DgCBlIoC3mbqzWSYXifRvgp+Eio3MgYEno16aqaAk
         LbU8s+tBdwUmjlj8VX4q/Db+tfudZPrZWl99fhWYwB0r6wQXhfTZQQlIAy+ATf1/O/Ir
         BXmC7FFetojQhtM0xwoZTsaSd1WodIpCyvmFcaSsn+9Wuj3IQZKAKG1A2OFrWSRbrcvH
         Ckv1ZjSRbQYFPtFQqbzgFLvRyuNXunZlPwhCvXy9/ep2OvCfok4il01wdLBp2Flskc9y
         NPdWLbd4qZHIVTRdHDHAZfp/Qzd8JKpBriUj6EmKfVbJfSUaI8Yp8z5O7bMSQZ5pOF81
         HN2A==
X-Gm-Message-State: AOAM532QxI+qF0vRoOjcd02S63paH5kg7LAM4oUmNWGoqfC32vK1nQDX
        StyycgWlSghESjqXA3kjgnjFRbv4XvI7QPw+gw4x1q70vER0OttJ
X-Google-Smtp-Source: ABdhPJz1H9nw7/Vwuac8Tyfe7OxZpeuSr5MrSfZ97ixKhnW6ljnzR7opPyoefNTAforbnuUmqn82Sv+EA4I1FVxzjG4=
X-Received: by 2002:a50:d709:: with SMTP id t9mr4535839edi.50.1642975015198;
 Sun, 23 Jan 2022 13:56:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org> <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org> <20220110172106.GC18213@fieldses.org>
In-Reply-To: <20220110172106.GC18213@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Sun, 23 Jan 2022 21:56:19 +0000
Message-ID: <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 10 Jan 2022 at 17:21, J. Bruce Fields <bfields@fieldses.org> wrote:
> Looks to me like the mount option may just be getting lost on the way
> down to the rpc client somehow, but I'm not quite sure how it's supposed
> to work, and a naive attempt to copy what v3 is doing (below) wasn't
> sufficient.
>
> --b.

Should I just open a bugzilla? It would be nice to mount more than 7
remote v4 servers with nconnect=16.

I did a very quick test of RHEL7 and RHEL8 client kernels and it seems
like they are doing the right thing with vers=4.2,noresvport.

I suspect it's just more recent kernels that has lost the ability to
use v4+noresvport (or newer nfs-utils?).

Daire
