Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0F1445E3
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUU0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 15:26:08 -0500
Received: from fieldses.org ([173.255.197.46]:37712 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUU0I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Jan 2020 15:26:08 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id B65C71C15; Tue, 21 Jan 2020 15:26:07 -0500 (EST)
Date:   Tue, 21 Jan 2020 15:26:07 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locked: remove nlmsvc_decode_norep/grantedres
Message-ID: <20200121202607.GB25691@fieldses.org>
References: <1579595682-251483-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579595682-251483-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 21, 2020 at 04:34:42PM +0800, Alex Shi wrote:
> These 2 macros are never used after first git commit Linux-2.6.12-rc2.
> So guess better to remove them.

I'm not fond of these macros.  If we're going to doing anything to them,
I'd rather just get rid of the entirely (including the PROC macro) and
write out the initialization of nlmsvc_procedures.  Yes, it'd probably
add another 80 or so lines to the file, but it'd be readable without
referring to the macro definitions.  And it would be less confusing to
people who grep for the users of the various proc/encode/decode methods
and can't find them.

--b.

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org> 
> Cc: Chuck Lever <chuck.lever@oracle.com> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
> Cc: Anna Schumaker <anna.schumaker@netapp.com> 
> Cc: linux-nfs@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  fs/lockd/svcproc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index d0bb7a6bf005..8b7565c71863 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -534,12 +534,10 @@ static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
>   */
>  
>  #define nlmsvc_encode_norep	nlmsvc_encode_void
> -#define nlmsvc_decode_norep	nlmsvc_decode_void
>  #define nlmsvc_decode_testres	nlmsvc_decode_void
>  #define nlmsvc_decode_lockres	nlmsvc_decode_void
>  #define nlmsvc_decode_unlockres	nlmsvc_decode_void
>  #define nlmsvc_decode_cancelres	nlmsvc_decode_void
> -#define nlmsvc_decode_grantedres	nlmsvc_decode_void
>  
>  #define nlmsvc_proc_none	nlmsvc_proc_null
>  #define nlmsvc_proc_test_res	nlmsvc_proc_null
> -- 
> 1.8.3.1
