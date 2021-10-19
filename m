Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070D243387B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSOjW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJSOjW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 10:39:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDA7C06161C;
        Tue, 19 Oct 2021 07:37:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 47D30647C; Tue, 19 Oct 2021 10:37:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 47D30647C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634654228;
        bh=LF2YBnf0gMU3KSyZolTJs3OjmgBekeR8pJ8o+xoMt+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZrEXCLK0L+nP4zOHxBa8rNkLzvmybS6I2IX6jvedG6dBGWymqQpv8fzJBtxdwBEn
         km1opDmnQiCdC5aieLp4D/gILDujbks/sOVAaE/pww6RCEcWO8oWqiIQmE15zed3eX
         Bs8py+svz9vXgxhxDcQtQOQa56EaLxo/Iqqk9egY=
Date:   Tue, 19 Oct 2021 10:37:08 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] NFSD:fix boolreturn.cocci warning
Message-ID: <20211019143708.GB15063@fieldses.org>
References: <20211019041422.975072-1-deng.changcheng@zte.com.cn>
 <B9D7D22B-EDFA-4144-AFCF-A66E12CB073B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9D7D22B-EDFA-4144-AFCF-A66E12CB073B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 19, 2021 at 02:33:36PM +0000, Chuck Lever III wrote:
> 
> 
> > On Oct 19, 2021, at 12:14 AM, cgel.zte@gmail.com wrote:
> > 
> > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> > 
> > ./fs/nfsd/nfssvc.c: 1072: 8-9: :WARNING return of 0/1 in function
> > 'nfssvc_decode_voidarg' with return type bool
> > 
> > Return statements in functions returning bool should use true/false
> > instead of 1/0.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> LGTM.

OK, applying for 5.16.--b.

> 
> 
> > ---
> > fs/nfsd/nfssvc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 362e819ff06a..80431921e5d7 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1069,7 +1069,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
> >  */
> > bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
> > {
> > -	return 1;
> > +	return true;
> > }
> > 
> > /**
> > -- 
> > 2.25.1
> > 
> 
> --
> Chuck Lever
> 
> 
