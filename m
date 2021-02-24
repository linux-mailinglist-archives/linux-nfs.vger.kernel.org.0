Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14F3246F1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 23:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhBXWgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 17:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbhBXWgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 17:36:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CFC061574
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 14:35:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v22so4487547edx.13
        for <linux-nfs@vger.kernel.org>; Wed, 24 Feb 2021 14:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMWjHQWY/HQm6szCDew+AP9/PfoMPcQCLYvu32uFHyk=;
        b=Vdx5AbGFbrCFy5UqT5YH2qHDmnaBMSBL6o1/tfYQGwUa7ZHOfa+BUcmf9ZFbE7D03O
         d3nxLSPMKMluHI53viqqwhkX9MVL1MtWFHJYJxVKiVnbmi6qlu+0DDJXghdqMdkg8nF0
         D+HZKWNBsQAJtUpnbQpf86N+1IhJ6urrJNaiTBjFFzOJsgh85WvtYFRkP4+nBKz9EtFZ
         anb9dPbPMJVHKjiAY0quoIjE0LaDg35WrR/BhkP+NpI8zWJqOQayl56CHBK/jmJ7c8eM
         RUcaNNFKI4vk7enPnGCaX8L3ZyWoBrhAJ9p9APxUW+e/d9L2m/gpOw35FzdFOaL0mC6c
         O3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMWjHQWY/HQm6szCDew+AP9/PfoMPcQCLYvu32uFHyk=;
        b=JlAXya3STh9JyQWbkCLVWtIT/Vwb9Q5C5rE0VnEF8AJY7qBuoCZzjdLc8gJbLaYOCz
         UFJ/B3mKG8U1PbpSDO1qI0xouR5uBcBXjFcT2jvAmvbaP87bI6top7lx4HOIh1xNn8Nb
         329J+9MjSePXZCWwYDNHCxpAIJ+CoYRM0sfDbNsKzAtTjLfRyvAbY+Zj/CV+sO1KRKn3
         hmC8LrqZ3sid7PkPa/NoJF6OggAuoXxmdW5pjZ9AkbynKu1qOq+2WPenTER3srhiDYoK
         iwl5FA+QurL/Gb+9LIB0jMnxQuVr49ZxnMGifpUepl6BUPjlIM8I9AYI5f6gJgvDPVby
         niWg==
X-Gm-Message-State: AOAM531R7SZPaqYxj5LtH4sIQqQAqNgiPYRwKrnqUVQh7Tcqs8l7/pSv
        O7pl4P/r3PgnXQyl5V1B2mwdZmR5BlFKPiwxoDw=
X-Google-Smtp-Source: ABdhPJz46cyVm2fF+Qkr9TCLJV8dN0FHU8HOvYQoKrYNnqXi2OH7WqG93Pzb6gkV/wLcG+XRn0TfUr2ambaTm0BUKzI=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr66249edb.128.1614206154364;
 Wed, 24 Feb 2021 14:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20201029190716.70481-1-dai.ngo@oracle.com> <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org> <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org> <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
 <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com> <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
 <517d8f58-4a00-8fe1-ad5a-b19ed50a8fe3@oracle.com> <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
 <a5cc3d04-06bc-6f3b-3ac2-c96a8efb1194@oracle.com>
In-Reply-To: <a5cc3d04-06bc-6f3b-3ac2-c96a8efb1194@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 24 Feb 2021 17:35:43 -0500
Message-ID: <CAN-5tyEXPxb7SZv_qmCECPUSdUgWSrPigrWxTORC0ZrMAj08Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 22, 2021 at 5:09 PM <dai.ngo@oracle.com> wrote:
>
>
> On 2/22/21 2:01 PM, dai.ngo@oracle.com wrote:
> >
> > On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
> >>
> >> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
> >>>
> >>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
> >>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
> >>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields
> >>>>> <bfields@fieldses.org> wrote:
> >>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
> >>>>>>> If this is the cause why we don't drop the mount after the copy
> >>>>>>> then I can restore the patch and look into this problem.
> >>>>>>> Unfortunately,
> >>>>>>> all my test machines are down for maintenance until Sunday/Monday.
> >>>>>> I think we can take some time to figure out what's actually going on
> >>>>>> here before reverting anything.
> >>>>> Yes I agree. We need to fix the use-after-free and also make sure
> >>>>> that
> >>>>> reference will go away.
> >>>
> >>> I reverted the patch, verified the warning message is back:
> >>>
> >>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
> >>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
> >>>
> >>> then did a inter-server copy and waited for more than 20 mins and
> >>> the destination server still maintains the session with the source
> >>> server.  It must be some other references that prevent the mount
> >>> to go away.
> >>
> >> This change fixed the unmount after inter-server copy problem:
> >>
> >> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >> index 8d6d2678abad..87687cd18938 100644
> >> --- a/fs/nfsd/nfs4proc.c
> >> +++ b/fs/nfsd/nfs4proc.c
> >> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount
> >> *ss_mnt, struct nfsd_file *src,
> >>                         struct nfsd_file *dst)
> >>  {
> >>         nfs42_ssc_close(src->nf_file);
> >> -       /* 'src' is freed by nfsd4_do_async_copy */
> >> +       nfsd_file_put(src);
> >>         nfsd_file_put(dst);
> >>         mntput(ss_mnt);
> >>  }
>
> This change is not need. It's left over from my testing to
> reproduce the warning messages. Only the change in
> nfsd4_do_async_copy is needed for the unmount problem.
>
> -Dai
>
> >> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
> >>                 copy->nf_src = kzalloc(sizeof(struct nfsd_file),
> >> GFP_KERNEL);
> >>                 if (!copy->nf_src) {
> >>                         copy->nfserr = nfserr_serverfault;
> >> - nfsd4_interssc_disconnect(copy->ss_mnt);
> >>                         goto do_callback;
> >>                 }
> >>                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt,
> >> &copy->c_fh,
> >> &copy->stateid);
> >>                 if (IS_ERR(copy->nf_src->nf_file)) {
> >>                         copy->nfserr = nfserr_offload_denied;
> >> - nfsd4_interssc_disconnect(copy->ss_mnt);
> >>                         goto do_callback;
> >>                 }
> >>         }
> >> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
> >>                         &nfsd4_cb_offload_ops,
> >> NFSPROC4_CLNT_CB_OFFLOAD);
> >>         nfsd4_run_cb(&cb_copy->cp_cb);
> >>  out:
> >> +       nfsd4_interssc_disconnect(copy->ss_mnt);
> >>         if (!copy->cp_intra)
> >>                 kfree(copy->nf_src);
> >>         cleanup_async_copy(copy);
> >>
> >> But there is something new. I tried inter-server copy twice.
> >> First time I can verify from tshark capture that a session was
> >> created and destroy, along with all the NFS ops. On 2nd try,
> >> I can

Hi Dai/Bruce,

While I believe the fix works (as in the mount goes away), I'm not
comfortable with this fix as I believe we will be leaking resources.
Server calls nfs42_ssc_open() which creates a legit file pointer (yes
it takes a reference on superblock but it also allocates memory for
"file" structure). Normally a file structure requires doing an fput()
which if I look thru the code does a bunch of things before in the end
calling mntput(). While we free the copy->nf_src in
nfs4_do_asyn_copy(), the copy->nf_src->nf_file was allocated
separately and would have been freed from calling fput() on it.

So I guess it's not correct to do kfree(copy->nf_src) in teh
nfs4_do_async_copy() I think that's probably where use-after-free
comes in. We need to keep it until the cleanup. I'm thinking perhaps
call fput(copy->nf_src->nf_file) first and then free it? Just an idea
but I haven't tested it.
