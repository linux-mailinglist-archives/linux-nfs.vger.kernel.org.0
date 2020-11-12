Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4802B0FBB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKLVDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 16:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgKLVDO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 16:03:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE93C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 13:03:14 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E203340B5; Thu, 12 Nov 2020 16:03:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E203340B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605214993;
        bh=vew5C54r2V3nD9Cm82ete+aMY6I8MUuj5u6lKtVHedA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sK5hzTjXO4lx6DGdUqPuDvbnbaJEzaFyE0FkuDRjDOevUAFS3oRPeQuasrc7sYWfo
         dsEDWUZ/5nS3x+JqddrscVNIecE2F16N5PvVZfJ/qSD5P84OnhFcmlUw0fLE8KbH6J
         DKGLQZKXjkG0TrhZINdvFGFqh4VSADCazgkQxR+Y=
Date:   Thu, 12 Nov 2020 16:03:13 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Subject: Re: [PATCH] SUNRPC: Fix oops in the rpc_xdr_buf event class
Message-ID: <20201112210313.GJ9243@fieldses.org>
References: <20201112201732.1689680-1-smayhew@redhat.com>
 <7F720342-6027-44B3-BAF2-F1F43721C407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F720342-6027-44B3-BAF2-F1F43721C407@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 03:39:07PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 12, 2020, at 3:17 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> > 
> > Backchannel rpc tasks don't have task->tk_client set, so it's necessary
> > to check it for NULL before dereferencing.
> > 
> > Fixes: c509f15a5801 ("SUNRPC: Split the xdr_buf event class")
> > 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> > include/trace/events/sunrpc.h | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> > index 2477014e3fa6..2a03263b5f9d 100644
> > --- a/include/trace/events/sunrpc.h
> > +++ b/include/trace/events/sunrpc.h
> > @@ -68,7 +68,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
> > 
> > 	TP_fast_assign(
> > 		__entry->task_id = task->tk_pid;
> > -		__entry->client_id = task->tk_client->cl_clid;
> > +		__entry->client_id = task->tk_client ?
> > +				     task->tk_client->cl_clid : -1;
> > 		__entry->head_base = xdr->head[0].iov_base;
> > 		__entry->head_len = xdr->head[0].iov_len;
> > 		__entry->tail_base = xdr->tail[0].iov_base;
> > -- 
> > 2.25.4
> > 
> 
> Bruce, can you take this one for v5.10-rc ?

Yep, thanks, I'll send another pull request in a few days.

--b.
