Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F73E99CC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHKUkm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHKUkl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 16:40:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63939C061765
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 13:40:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x14so5692869edr.12
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvPNMWCv0dP3Zxb40ZKKhBpDjh1Ul9ZShoz3ndB4UfM=;
        b=djDWTZloNdjFK+dmv94ytaxuBY0Xf2jMAp/ygZmMaJ8draP/zJypopAU8EHC0JEklm
         HxlIktrsC2BqA490Bjvh+jS1F1iWbSCIWmSrD+7G0863zuGFLphpxsc7RtbwQzPrgu+3
         T34E3lDHF+dofSUPOSquYveAPd+vzu8HDnUrMIzjDn6l174lQ1tymM9e6254cuwEb8n4
         d/49vyZ2Ll6c2irsHWfr1RxeBFcYAUAO8XucBwoStdxJZeQj7eQnIHh5m3PQTX6BN+cc
         X8ceHeS8pH5LbE9ZxptkwArC9L1rSBoOoV22lw+ogdnevUWAn4cXbbhAKdYMrBbMdqGQ
         zYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvPNMWCv0dP3Zxb40ZKKhBpDjh1Ul9ZShoz3ndB4UfM=;
        b=PFYPMgV8ynr+UTat7n0l7CFKTkro36rlB4qegQwMUBR79QO+zv82Tl/gAQvCYxIYTh
         bmqq0mBAoU5ImMe+dd2ip4q3uR3f3X7NCeOaice0eA4Jis1bHa9E6MZCRlXUJg2WGnLL
         GW1ErqW5OEQAVvw77Y9PzlwPIvEjvPGromjK3VhUO9g6tmNSBwDDXkDDsFRi4UPGx+BA
         KBNmKM4/nVLmtAnrNRcWv9FtcOKk2ZNjXgHGPRNaP1fcw0bFJ5wg7fBYMlyaYAQRXfWy
         JT7sTscjXZzOzJskLW06QmeQNIbsOJQjs7g6f9eB002XXnS4szNIlZtxV9R+2WvZ5/XT
         xnPw==
X-Gm-Message-State: AOAM531ldfhUxmuCsDtAkv0CHAWCboj9qKi3gfj2RXK44/WWUOKqha0H
        Yo/pNwWRm2gCbhmmKQvTEy5DHrSq3d66b4caxQ4=
X-Google-Smtp-Source: ABdhPJxqTX+Wse0JPk4h+m7bSx/Am6j+m9oivYV5naAniXEmW0wACv5iuukkPIIkxOUvHqjbKpDKVsYURSlnXCT9pBs=
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr947731edc.67.1628714415897;
 Wed, 11 Aug 2021 13:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org> <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org> <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com> <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
 <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com> <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
 <D417C606-9E27-431E-B80E-EE927E62A316@oracle.com> <20210811201435.GA31574@fieldses.org>
In-Reply-To: <20210811201435.GA31574@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Aug 2021 16:40:04 -0400
Message-ID: <CAN-5tyGq=EE4PjSbKVyKLtmhhFF_o6D9uG1QNQ-ByVMp9q8LOw@mail.gmail.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@redhat.com>,
        Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 11, 2021 at 4:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Aug 11, 2021 at 08:01:30PM +0000, Chuck Lever III wrote:
> > Probably not just CB_RECALL, but agreed, there doesn't seem to
> > be any mechanism that can re-drive callback operations when the
> > backchannel is replaced.
>
> The nfsd4_queue_cb() in nfsd4_cb_release() should queue a work item
> to run nfsd4_run_cb_work, which should set up another callback client if
> necessary.

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7325592b456e..ed0e76f7185c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1191,6 +1191,7 @@ static void nfsd4_cb_done(struct rpc_task *task,
void *calldata)
                case -ETIMEDOUT:
                case -EACCES:
                        nfsd4_mark_cb_down(clp, task->tk_status);
+                       cb->cb_need_restart = true;
                }
                break;
        default:

Something like this should requeue and retry the callback?

>
> But I doubt this is well tested.
>
> --b.
