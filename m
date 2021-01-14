Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A212F6C0F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 21:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhANUaG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbhANUaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jan 2021 15:30:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DACC061757
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 12:29:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so7803434ejc.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psm8LOzTxeRY4O/X52Qxalsd2cew8lUVE9CZc5wWlg0=;
        b=q+kcMVEH3+wbiBlCfkFoQ/bzcJWDOqx3ZP/5f40iX85RPgKLxkiLxfUvBa1wCpiGQT
         ZNxChvlTakvlsYH8vs+tBYaMmIUgJztFA6NOed0wY31W/XEmfAEtFwTDas33bBYsYbf7
         dnEokNoAeeJkJC8niasutQlu9Q7HcBCYHV6L/PC7d8s9scIvj/+r+XnBkePh7lBaOJaF
         +P5zKsfJ1LevYoh/Ebpj2x7BwJeenxOG2Aq4DxicH+inxyNg3FVmUYDhXh+2BESfcRTi
         ud2wZNolcfHN28J4ChtvvF5rNOy7+XpYco0IVfphf5C4imcCtLu4D4gcBtOfCLqwSqV8
         YNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psm8LOzTxeRY4O/X52Qxalsd2cew8lUVE9CZc5wWlg0=;
        b=Z0X68o3yjBwwNbxVE+ZPIv3cdHLOIzDd2e6qmCPWVIMGXZ+m2FfWccOtUbUeruWHeL
         UAH3KwsAhJOecTNksxIDW0QbiB2qcAvE6HgbAzT4vRt+rBcl7p4UyDrNND9h87Z3dgpe
         NUMGfIUGZxFZnf0qBNdYh/MsWiaHss+gkvR7HPvmzvYUqjc3MtJ6i5zZOj7Gc3HQ+abz
         pFzNK1bGr1Dix37IjmXaBVaVrr5awfEJPq7ITnlhT+nJyux/iQwW6PciJxE62M6s1tss
         YAQ+/FgJmM3bPZ/Yf6d33YlF+oYJWFp0ZoG88+ErdCNGmpdxofZ6EA9Bh46eRRdlFP/9
         cOyg==
X-Gm-Message-State: AOAM530W61PQBCpHfmnLjtfPO2LES+xpQ5yncStoMelgZxX9Yg0tIMKk
        BkapCRKkrNK77NkWqqJDwGIRKD7OfYecZSRk77Q=
X-Google-Smtp-Source: ABdhPJxV3vwmGIvGAY64ERBLAXcJx0dz60LD9x4fuDw7PVdfXn6jxQAMnZoCeRXCfDI38OnjpLdIaN+SVA62WeXu/7U=
X-Received: by 2002:a17:906:a445:: with SMTP id cb5mr2313491ejb.0.1610656164415;
 Thu, 14 Jan 2021 12:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com> <20210112165911.GH9248@fieldses.org>
 <CAFX2JfmYrCSYfCCGgQ0eghU3WSqk=T38wxkJ7Q42ORw-NFeFQg@mail.gmail.com>
 <7003D8A9-3B95-4B36-84EC-99D4D1806366@oracle.com> <5EBDAA40-4F55-4EF2-956D-9877C4F4A9A7@oracle.com>
In-Reply-To: <5EBDAA40-4F55-4EF2-956D-9877C4F4A9A7@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 14 Jan 2021 15:29:13 -0500
Message-ID: <CAN-5tyF=qQbmBPXY7HDAEReidYYqFsV-dFrtkqqJfRAsxtyu8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 13, 2021 at 9:18 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
> > On Jan 13, 2021, at 2:48 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >> On Jan 13, 2021, at 2:23 PM, Anna Schumaker <schumaker.anna@gmail.com> wrote:
> >>
> >> On Tue, Jan 12, 2021 at 11:59 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >>>
> >>> On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
> >>>> Hi Anna-
> >>>>
> >>>>> On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
> >>>>>
> >>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>>
> >>>>> It's possible for an NFS server to go down but come back up with a
> >>>>> different IP address. These patches provide a way for administrators to
> >>>>> handle this issue by providing a new IP address for xprt sockets to
> >>>>> connect to.
> >>>>>
> >>>>> This is a first draft of the code, so any thoughts or suggestions would
> >>>>> be greatly appreciated!
> >>>>
> >>>> One implementation question, one future question.
> >>>>
> >>>> Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?
> >>
> >> Possibly! I was trying to match /sys/fs/nfs, but I can definitely
> >> change this if another location is better.
> >
> > Ah... since this is a supplement to the mount() interface, maybe
> > placing this new API under /sys/fs/nfs/ might make some sense.
>
> Or you could implement it with "-o remount,addr=new-address".

A change of address is currently not allowed by the NFS because
multiple mounts might be sharing a superblock and change of one
mount's option would not be correct. The way things work from this new
mechanism is system wide and all mounts are affected.


>
>
> --
> Chuck Lever
>
>
>
