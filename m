Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC849CBE0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiAZOKz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiAZOKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 09:10:55 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DFC06161C
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 06:10:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 73F9B70C2; Wed, 26 Jan 2022 09:10:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 73F9B70C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643206253;
        bh=2k3q5iQaiNYoh/n31aPakWLz8sUifTxpCo3fyZpyiHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vakr0p6y0wv71vEdIRjh1y7ARZC6NddV0yNVl7/WuCLBn9AZ+C9eVFc2x6wd6q43w
         HV7XZpmlF5lgeumsDG06igEw/l3ILetYhvMgEyd9N8ZjHN2RsOhusl+olqyz2pspwB
         Vmnz+AI91jW+7/zUAoEEoAzznMCQsKQeL0+jjsAw=
Date:   Wed, 26 Jan 2022 09:10:53 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pynfs minor: fixed Environment._maketree to use proper
 stateid during file write
Message-ID: <20220126141053.GA29832@fieldses.org>
References: <CANkgwes_79iE9MGvzGu_tLjNVZprTjTMNzohADRU6pw4Z3xC_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgwes_79iE9MGvzGu_tLjNVZprTjTMNzohADRU6pw4Z3xC_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 21, 2022 at 03:06:57PM +0200, Volodymyr Khomenko wrote:
> 

> From 63c0711f9cd8f8c0aaff7d0116a42b5001bddcd2 Mon Sep 17 00:00:00 2001
> From: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> Date: Fri, 21 Jan 2022 14:52:28 +0200
> Subject: [PATCH] Minor: fixed Environment._maketree (used by init) to use
>  proper stateid during file write
> 
> _maketree is a part of generic init sequence for server41tests so the code should be generic.
> Using zero stateid (when "other" and "seqid" are both zero, the stateid is treated
> as a special anonymous stateid) is a special use-case of anonymous access
> so it must not be used during generic initialization.

OK, applying, but I'm a little wary.  If a server isn't accepting the
zero stateid here then I think that's a server bug.

--b.

> 
> Signed-off-by: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> ---
>  nfs4.1/server41tests/environment.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
> index 14b0902..0b7c976 100644
> --- a/nfs4.1/server41tests/environment.py
> +++ b/nfs4.1/server41tests/environment.py
> @@ -198,7 +198,7 @@ class Environment(testmod.Environment):
>                  log.warning("could not create /%s" % b'/'.join(path))
>          # Make file-object in /tree
>          fh, stateid = create_confirm(sess, b'maketree', tree + [b'file'])
> -        res = write_file(sess, fh, self.filedata)
> +        res = write_file(sess, fh, self.filedata, stateid=stateid)
>          check(res, msg="Writing data to /%s/file" % b'/'.join(tree))
>          res = close_file(sess, fh, stateid)
>          check(res)
> -- 
> 2.25.1
> 

