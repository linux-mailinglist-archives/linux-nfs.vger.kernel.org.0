Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18A3E2FEF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbhHFTxs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhHFTxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 15:53:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF85C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 12:53:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hs10so16952821ejc.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJDq2ID9kCT3+YUR399sOMxSIhNNDGZE4HwI3Oa4c7U=;
        b=VyuVkm1JxRxFBjbte2PamVHal/Y31Ntl1DUTFZ7WFYD8/XVjSjL3TRreFxe9T732hM
         9FBppZWISSHlrQppVlWSg6jgDP/tT5Rodd1IqDknzwiZxm2GreVtUiQ9vEFGDvTTgwxw
         CH2zb+FV6kdOI9kP/hI50rzx7s61WOUyb1e6R97BKRQ62xp2FqTbSRtcmfeqyjue8M0Z
         Lmsv1ffigQwzaqArpZAL1xjQRNkCarceOARpWJXwOC+R1Z76tNhdYUPsloHSYma5SmmI
         s/aZvPJmP9MimX+8CXJUzA4pndlA+vX7Mho11uQ3uNay//6J9VAo6xR0+ZyPIVPHf5yx
         z1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJDq2ID9kCT3+YUR399sOMxSIhNNDGZE4HwI3Oa4c7U=;
        b=pJEUO1JPLZXbu8vuidD+tWU6EQVcO7VdouZWnffEy9hkI+X4EU5PvKvVhBLXXPb10G
         X++VfHtlsb05aWWNtbmdxKOvk2E6XOtJzlICoYXmXYsWY/fT9Ic7qRnYeDAGuxpHi/SD
         rBvhS9jeiWQ/1bFmstWNXyv6xC0DWC0CPkFWW1xOiWoajCkabN2qgU7XeJI3O6SzJqcK
         mTbO8Uyl+Kp5SE8lK2tk4bfe09kf/8xqJLrhK/qz4VGadl2P4Te83n4s43vAQ7YHcGFU
         XsNKuAAhNvoKiEyhlJ/EGCfCRWUtzX4ZfZ7HQX1+X9EaO3H4gawg8ZDlWvVJ+v8GzuBd
         x79A==
X-Gm-Message-State: AOAM532cqxGivOmiVrIwFPulrja9+4+Cg2vVIRVRjgOwTjpi9sn52kIM
        0ED2JntGdVUkPpDuJ8+bFyOmByPCBEd5sQvUbWETUAVZLVk=
X-Google-Smtp-Source: ABdhPJzdt/60STI36XlFdqMFP5XT6cs2K4AucO7voRSndnyfcVMYHURc2wC3lawZr9j3dIESQIjcXWuqS8WvPBOVMCo=
X-Received: by 2002:a17:906:b7d2:: with SMTP id fy18mr11622508ejb.0.1628279610098;
 Fri, 06 Aug 2021 12:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com>
 <1851673341.49012.1628121856011.JavaMail.zimbra@raptorengineeringinc.com> <361337129.54635.1628123839436.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <361337129.54635.1628123839436.JavaMail.zimbra@raptorengineeringinc.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Aug 2021 15:53:19 -0400
Message-ID: <CAN-5tyHmiEE-vw=s6t_7UmWgHo2_U7zJOSwTPESY_NQA27ZsPQ@mail.gmail.com>
Subject: Re: Callback slot table overflowed
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 5, 2021 at 12:15 AM Timothy Pearson
<tpearson@raptorengineering.com> wrote:
>
> On further investigation, the working server had already been rolled back to 4.19.0.  Apparently the issue was insurmountable in 5.x.
>
> It should be simple enough to set up a test environment out of production for 5.x, if you have any debug tips / would like to see any debug options compiled in.
>
> Thanks!
>
> ----- Original Message -----
> > From: "Timothy Pearson" <tpearson@raptorengineering.com>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Wednesday, August 4, 2021 7:04:16 PM
> > Subject: Re: Callback slot table overflowed
>
> > Other information that may be helpful:
> >
> > All clients are using TCP
> > arm64 clients are unaffected by the bug
> > The armel clients use very small (4k) rsize/wsize buffers
> > Prior to the upgrade from Debian Stretch, everything was working perfectly
> >
> > ----- Original Message -----
> >> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> >> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> >> Sent: Wednesday, August 4, 2021 7:00:20 PM
> >> Subject: Callback slot table overflowed
> >
> >> All,
> >>
> >> We've hit an odd issue after upgrading a main NFS server from Debian Stretch to
> >> Debian Buster.  In both cases the 5.13.4 kernel was used, however after the
> >> upgrade none of our ARM thin clients can mount their root filesystems -- early
> >> in the boot process I/O errors are returned immediately following "Callback
> >> slot table overflowed" in the client dmesg.
> >>
> >> I am unable to find any useful information on this "Callback slot table
> >> overflowed" message, and have no idea why it is only impacting our ARM (armel)
> >> clients.  Both 4.14 and 5.3 on the client side show the issue, other client
> >> kernel versions were not tested.
> >>
> >> Curiously, increasing the rsize/wsize values to 65536 or higher reduces (but
> >> does not eliminate) the number of callback overflow messages.
> >>
> >> The server is a ppc64el 64k page host, and none of our pcc64el or amd64 thin
> >> clients are experiencing any problems.  Nothing of interest appears in the
> >> server message log.
> >>
> >> Any troubleshooting hints would be most welcome.

A network trace would be useful.

5.3 should have this patch "SUNRPC: Fix up backchannel slot table
accounting". I believe "callback slot table overflowed" is hit when
the server sent more reqs than client can handle (ie doesn't have a
free slot to handle the request). A network trace would show that.
However you said this happens when the client is trying to mount and
besides cb_null requests I'm not sure what could be happening.

> >>
> > > Thank you!
