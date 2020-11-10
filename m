Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617FF2AE15C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKJVHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJVHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 16:07:54 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6DC0613D1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 13:07:54 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k9so14330626edo.5
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 13:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvsG09SlAiQJ1erIvAof2EyiLj8wJoOLpmzeFbsexq8=;
        b=qMALGOKueX7osuie08C1jiLsr461nhJW2/z6qgTacmwVLE8Svq2gRp3fngG9hzr3Jn
         sU1w4226jPld2o1N4yz7JZhZ6Uh7QC+zzI+UXthOfnSHclevCTo5mzpCW86tCkLKOXYW
         n+pj4afPz1/pkff1Kl96zy0ojyxAiHfCMfS+1dRjbi3xwFCZJnz6Gjp+WlpK7CcfDrj5
         VywKHtxvZFy2arEkY7QQYnLnXN+X9Eu3QLNH9+dqhusok/Hx6cL2i+l2gJRJm5nnLmO7
         p7ak4aySqNF6vWlks1PrO8fu0rKdj1NyJy5saPPM36ZTFRb6EoYXsZNInOK/SrpQIa6+
         7oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvsG09SlAiQJ1erIvAof2EyiLj8wJoOLpmzeFbsexq8=;
        b=gqEcWjZ7ZtnPAqjQOKbpEycZuI9VpzT4GV2N94cHSZKGm/RD5JBKTjxWoIL29HTJgh
         rLiL18Y+LjteONc3vnwHZyozTMN91df1al29NTr+Zgaroen2NrqTUmFbuscWkxSGkybq
         tUH0bkUzgVTwaWK2lnGJTw9nm5Gpa9hAZXxXQy6DJdTbY+YkPzRHa1E6FCMQaOrV9cNT
         EjkM9Zi2CWQEKzeMUSstkIabIC270DOwHvCc47sRCks5o/1A99Jcug+2qqb29M05fbhH
         wK2fsKLWPVR9DL0U3PoG3894RSW1D/OQhT5aSSwggeGO1IwGKj0VM1uDLeUMK+z0krOi
         FVeQ==
X-Gm-Message-State: AOAM532HQqD1iBlF9uyEoaTYKTMv8VHhHvBitfU3H/sQkb491bjvRHGO
        +Jmek590257aN9EsRZlC2yPYPV/iDJJIskVfOCU=
X-Google-Smtp-Source: ABdhPJywG79RVIxeHiSV72yCHawJDM/3nPmdBNUGSrZI3Ys5LWW1287KiK53sEqgb2VAVCd6FGjvHVV66eY4317iBio=
X-Received: by 2002:a50:c058:: with SMTP id u24mr23284763edd.28.1605042472636;
 Tue, 10 Nov 2020 13:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20201019034249.27990-1-dai.ngo@oracle.com> <20201020170114.GF1133@fieldses.org>
 <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com> <20201109183054.GD11144@fieldses.org>
 <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com> <20201109204206.GA20261@fieldses.org>
 <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com> <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
 <20201110201239.GA17755@fieldses.org>
In-Reply-To: <20201110201239.GA17755@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Nov 2020 16:07:41 -0500
Message-ID: <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 10, 2020 at 3:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Nov 09, 2020 at 10:46:12PM -0800, Dai Ngo wrote:
> >
> > On 11/9/20 2:26 PM, Dai Ngo wrote:
> > >
> > >On 11/9/20 12:42 PM, J. Bruce Fields wrote:
> > >>On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
> > >>>On 11/9/20 10:30 AM, J. Bruce Fields wrote:
> > >>>>On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
> > >>>>>On 10/20/20 10:01 AM, J. Bruce Fields wrote:
> > >>>>>>On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
> > >>>>>>>NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
> > >>>>>>>build errors and some configs with NFSD=m to get NFS4ERR_STALE
> > >>>>>>>error when doing inter server copy.
> > >>>>>>>
> > >>>>>>>Added ops table in nfs_common for knfsd to access NFS
> > >>>>>>>client modules.
> > >>>>>>OK, looks reasonable to me, applying.  Does this resolve all the
> > >>>>>>problems you've seen, or is there any bad case left?
> > >>>>>Thanks Bruce.
> > >>>>>
> > >>>>>With this patch, I no longer see the NFS4ERR_STALE in any config.
> > >>>>>
> > >>>>>The problem with NFS4ERR_STALE was because of a bug in
> > >>>>>nfs42_ssc_open.
> > >>>>>When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
> > >>>>>returns NULL which is incorrect allowing the operation to continue
> > >>>>>until nfsd4_putfh which does not have the code to handle
> > >>>>>nfserr_stale.
> > >>>>>
> > >>>>>With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
> > >>>>>new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
> > >>>>>to switch over to the split copying (read src and write to dst).
> > >>>>That sounds reasonable, but I don't see any of the patches you've sent
> > >>>>changing that error return.  Did I overlook something, or did you mean
> > >>>>to append a patch to this message?
> > >>>Since with the patch, I did not run into the condition where
> > >>>NFS4ERR_STALE
> > >>>is returned so I did not fix this return error code. Do you want me to
> > >>>submit another patch to change the returned error code from
> > >>>NFS4ERR_STALE
> > >>>to NFS4ERR_NOTSUPP if it ever runs into that condition?
> > >>That would be great, thanks.  (I mean, it is still possible to hit that
> > >>case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)
> > >
> > >will do. I did tested with (!CONFIG_NFSD_V4_2_INTER_SSC) but did not hit
> > >this case.
> >
> > I need to qualify this, the copy_file_range syscall did not return
> > ESTALE in the test.
> >
> > >Because with this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not
> > >defined the new nfs42_ssc_open returns ERR_PTR(-EIO), instead of NULL in
> > >the old code, which causes the NFS client to switch over to the split
> > >copying (read src and write to dst).
> >
> > This is not the reason why the client switches to generic_copy_file_range.
> >
> > >Returning NULL in the old nfs42_ssc_open is not correct, it allows
> > >the copy
> > >operation to proceed and hits the NFS4ERR_STALE case in the COPY
> > >operation.
> >
> > I retested with (!CONFIG_NFSD_V4_2_INTER_SSC) and saw NFS4ERR_STALE
> > returned for the PUTFH of the SRC in the COPY compound. However on the
> > client nfs42_proc_copy (with commit 7e350197a1c10) replaced the ESTALE
> > with EOPNOTSUPP causing nfs4_copy_file_range to use generic_copy_file_range
> > to do the copy.
> >
> > The ESTALE error is only returned by copy_file_range if the client
> > does not have commit 7e350197a1c10. So I think there is no need to
> > make any change on the source server for the NFS4ERR_STALE error.
>
> I don't believe NFS4ERR_STALE is the correct error for the server to
> return.  It's nice that the client is able to do the right thing despite
> the server returning the wrong error, but we should still try to get
> this right on the server.

Hi Bruce,

ERR_STALE is the appropriate error to be returned by the server that
gets a COPY compound when it doesn't support COPY. Since server can't
understand the filehandle so it can't process it so we can't get to
processing COPY opcode where the server could have returned
EOPNOTSUPP. Thus a client side patch is needed and the server is doing
everything it can in the situation.

I'm confused about the title of this patch. I thought what it does is
removes NFSD dependency on the NFS and instead loads the needed
function dynamically.

Honestly, I don't understand why that allows removal of the NFS_FS
from the dependencies I don't understand. nfs4_ssc_open calls nfs
client functions that are built when NFS_FS is compiled but I'm
assuming will not be otherwise.

>
> --b.
