Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6B37AD4C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhEKRpg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKRpg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 13:45:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E5C061574
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 10:44:29 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 97976581C; Tue, 11 May 2021 13:44:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 97976581C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620755069;
        bh=SPiOC5smQRRYJW9Hiy6TyX0DoVSUoum5BBKsk4X36j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctSiyyN7HR6xyh+bIl92S/jGzrO3HrbFZY4eF8QNiWFnz7NhKxhm73UOxOjQZN04s
         C2q9/Lc/d14Em1q4G9QZpTJCUOA0dJq5OmXkLtUYh6e2JmUvXmY/bhegbGLz9m8MtP
         +6yP6TiK2D3D7nGpg+yM7YoBqT1f8MD6KafP+48E=
Date:   Tue, 11 May 2021 13:44:29 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 06/21] NFSD: Remove spurious cb_setup_err tracepoint
Message-ID: <20210511174429.GD5416@fieldses.org>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066193457.94415.10829735588517134118.stgit@klimt.1015granger.net>
 <20210510202719.GB11188@fieldses.org>
 <42BBD4E8-7254-4ADB-98C5-84DE7AE1C9DC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBD4E8-7254-4ADB-98C5-84DE7AE1C9DC@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 10, 2021 at 08:29:32PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 10, 2021, at 4:27 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Mon, May 10, 2021 at 11:52:14AM -0400, Chuck Lever wrote:
> >> This path is not really an error path,
> > 
> > What's the non-error case for this path?
> 
> >From what I can tell, it appears to be the default exit for when
> there is a session and backchannel. Feel free to straighten me
> out, but it just seemed to always fire for NFSv4.1 mounts.

I'd be curious to know why.  I'll see if I can find some time to
experiment.

--b.

> > On a quick look it seems like that'd mean a 4.1 client doesn't have a
> > connection available for the backchannel, which sounds bad.
> > 
> > But I'm probably overlooking something....
> > 
> > --b.
> > 
> >> so the tracepoint I added
> >> there is just noise.
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfsd/nfs4callback.c |    4 +---
> >> 1 file changed, 1 insertion(+), 3 deletions(-)
> >> 
> >> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> >> index ab1836381e22..15ba16c54793 100644
> >> --- a/fs/nfsd/nfs4callback.c
> >> +++ b/fs/nfsd/nfs4callback.c
> >> @@ -915,10 +915,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
> >> 		args.authflavor = clp->cl_cred.cr_flavor;
> >> 		clp->cl_cb_ident = conn->cb_ident;
> >> 	} else {
> >> -		if (!conn->cb_xprt) {
> >> -			trace_nfsd_cb_setup_err(clp, -EINVAL);
> >> +		if (!conn->cb_xprt)
> >> 			return -EINVAL;
> >> -		}
> >> 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
> >> 		clp->cl_cb_session = ses;
> >> 		args.bc_xprt = conn->cb_xprt;
> >> 
> 
> --
> Chuck Lever
> 
> 
