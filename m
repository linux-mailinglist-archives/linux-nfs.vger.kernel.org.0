Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163C31C2E5
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBOUSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 15:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBOUSK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 15:18:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0FC061574
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 12:17:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 58A69410D; Mon, 15 Feb 2021 15:17:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 58A69410D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1613420248;
        bh=+//eqeYnV+BYPGZTR06GW1sy7gZd1IShTiYlW6ZsgTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsEoH0OlTN+aNR2BYaVDmNiOmLHx9bNNvsnCa8MuUkT0JWNlRaDBqvkxSgkXlBXcg
         Bkn4fV+CuekubpZEbTDqmpq3W8OeVj/YY+kiMWUFvvpr38C3W3BMAAyyD3MI+8H917
         KoA9ljlAeHhYG3Diuai2J3sP1yV9Epx7icJ8UlNg=
Date:   Mon, 15 Feb 2021 15:17:28 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Subject: Re: pynfs breakage
Message-ID: <20210215201728.GC30742@fieldses.org>
References: <804830ba7fdd91cbf9348050b07f9922801d20f0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804830ba7fdd91cbf9348050b07f9922801d20f0.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 15, 2021 at 03:15:08PM -0500, Jeff Layton wrote:
> Hi Bruce!
> 
> The latest HEAD in pynfs doesn't run for me:
> 
> $ ./nfs4.1/testserver.py --help
> Traceback (most recent call last):
>   File "/home/jlayton/git/pynfs/nfs4.1/./testserver.py", line 38, in <module>
>     import server41tests.environment as environment
>   File "/home/jlayton/git/pynfs/nfs4.1/server41tests/environment.py", line 593
>     def write_file(sess, file, data, offset=0 stateid=stateid4(0, b''),
>                                               ^
> SyntaxError: invalid syntax
> 
> If I revert this commit, then it works:

Yeah, sorry about that, I pushed out quickly thinking I'd tested it, but
in fact it has a bunch of mistakes.  Fixing....

--b.

> 
> commit 49ae5ba83dd98936b3f5c24431a166866b70f34a (HEAD -> master, origin/master, origin/HEAD)
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Thu Feb 11 16:22:58 2021 -0500
> 
>     nfs41: read_file and write_file helpers
>     
>     A couple simple helpers copied from 4.0.
>     
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> 
> Cheers,
> -- 
> Jeff Layton <jlayton@kernel.org>
