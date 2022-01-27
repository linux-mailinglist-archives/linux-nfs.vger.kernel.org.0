Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8A49EDEC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiA0WGb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 17:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiA0WGa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 17:06:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB8C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 14:06:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 52BE664B9; Thu, 27 Jan 2022 17:06:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 52BE664B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643321189;
        bh=Td1rlbhtFtaWx9ohj0B2YVFsYWmEBTsaMOBaZnV0bhg=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rVELWprgo+qUWCSywFxxxmRYjoOnX4t7wB7dCDiwN1dKBRHg2DrTCfUkykRyJkrgM
         Inuc7+P8heTnw3cBImJr2FfZKiQnapAbiBRzptkW+tlDvgXzuSaG+xjwBqsvZMWXFu
         xZONwZI3hORDiCduUbKpGG13V6Jj0vwJHGMBbk2E=
Date:   Thu, 27 Jan 2022 17:06:29 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsv4.0/setattr: Check behavior of setting a large file
 size
Message-ID: <20220127220629.GD3459@fieldses.org>
References: <164330361583.2340756.18437536986986631991.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164330361583.2340756.18437536986986631991.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 27, 2022 at 12:19:24PM -0500, Chuck Lever wrote:
> Many POSIX systems internally use a signed file size. The NFS
> server has to correctly handle the conversion from a u64 size
> to the internal size value.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_setattr.py |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> Just something to consider... "It's my first ray gun" so I'm sure
> I got something wrong here.

Looks fine by me; applied.

--b.

> 
> diff --git a/nfs4.0/servertests/st_setattr.py b/nfs4.0/servertests/st_setattr.py
> index c3ecee3fbcfb..5d51054c29b4 100644
> --- a/nfs4.0/servertests/st_setattr.py
> +++ b/nfs4.0/servertests/st_setattr.py
> @@ -562,6 +562,25 @@ def testUnsupportedSocket(t, env):
>      check(res)
>      _try_unsupported(t, env, path)
>  
> +def testMaxSizeFile(t, env):
> +    """SETATTR(U64_MAX) of a file should return NFS4_OK or NFS4ERR_FBIG
> +
> +    FLAGS: setattr all
> +    DEPEND: INIT
> +    CODE: SATT12x
> +    """
> +    maxsize = 0xffffffffffffffff
> +    c = env.c1
> +    fh, stateid = c.create_confirm(t.word(), deny=OPEN4_SHARE_DENY_NONE)
> +    dict = {FATTR4_SIZE: maxsize}
> +    ops = c.use_obj(fh) + [c.setattr(dict, stateid)]
> +    res = c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_FBIG], "SETATTR(U64_MAX) of a file")
> +    newsize = c.do_getattr(FATTR4_SIZE, fh)
> +    if newsize != maxsize:
> +        check(res, [NFS4ERR_INVAL, NFS4ERR_FBIG],
> +                "File size is %i; SETATTR" % newsize)
> +
>  def testSizeDir(t, env):
>      """SETATTR(_SIZE) of a directory should return NFS4ERR_ISDIR or NFS4ERR_BAD_STATEID
>  
> 
