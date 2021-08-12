Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA83EA7B2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhHLPk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhHLPk1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 11:40:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7862C061756
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 08:40:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7DA6C7C76; Thu, 12 Aug 2021 11:40:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7DA6C7C76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628782801;
        bh=FIzx6+0WQLG4+uWXMyGLp76L9xEc6wRLsTXvyCKdfuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgoGYvkMaiEu0qLuQFTNNql0bmyWlhw5Nf3i3YjvK9fILrdHX5PbMq/XRc083q7qn
         bjom1z+3o+5X4bFrLkG0fIMIJtivaG6OpSMARzpgBU8+VyjVnjHZyZHOTmaN3kAsut
         u70kdNk0+iUHzVPektLBJ2ceFhdpi+tiAmGzPCLk=
Date:   Thu, 12 Aug 2021 11:40:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@redhat.com>,
        Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Message-ID: <20210812154001.GB9536@fieldses.org>
References: <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
 <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
 <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
 <D417C606-9E27-431E-B80E-EE927E62A316@oracle.com>
 <20210811201435.GA31574@fieldses.org>
 <CAN-5tyGq=EE4PjSbKVyKLtmhhFF_o6D9uG1QNQ-ByVMp9q8LOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGq=EE4PjSbKVyKLtmhhFF_o6D9uG1QNQ-ByVMp9q8LOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 11, 2021 at 04:40:04PM -0400, Olga Kornievskaia wrote:
> On Wed, Aug 11, 2021 at 4:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Aug 11, 2021 at 08:01:30PM +0000, Chuck Lever III wrote:
> > > Probably not just CB_RECALL, but agreed, there doesn't seem to
> > > be any mechanism that can re-drive callback operations when the
> > > backchannel is replaced.
> >
> > The nfsd4_queue_cb() in nfsd4_cb_release() should queue a work item
> > to run nfsd4_run_cb_work, which should set up another callback client if
> > necessary.

But I think the result is it'll look to see if there's another
connection available for callbacks, and give up immediately if not.

There's no logic to wait for the client to fix the problem.

> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 7325592b456e..ed0e76f7185c 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1191,6 +1191,7 @@ static void nfsd4_cb_done(struct rpc_task *task,
> void *calldata)
>                 case -ETIMEDOUT:
>                 case -EACCES:
>                         nfsd4_mark_cb_down(clp, task->tk_status);
> +                       cb->cb_need_restart = true;
>                 }
>                 break;
>         default:
> 
> Something like this should requeue and retry the callback?

I think we'd need more than just that.

--b.
