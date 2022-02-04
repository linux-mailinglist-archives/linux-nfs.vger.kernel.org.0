Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636794AA19E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiBDVLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 16:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiBDVLl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 16:11:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B30C061714
        for <linux-nfs@vger.kernel.org>; Fri,  4 Feb 2022 13:11:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 08AB26801; Fri,  4 Feb 2022 16:11:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 08AB26801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1644009099;
        bh=xi9UdIaSGyTOw2JO9MMYkhKIWWAkTp62h5OF+jeOAL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mizfszh3sp/fyS94eZUKy6aGgl/BWVjAX7yrFHNiZDmX2vJ7T1oCFhx0DIGbYbFfu
         DMAFxO4lDmGAlYu6v9LGbIYyn0VVMBWVNfc+VIcuYr7oFtK9dogwF5Y8tUN9Gxh7Aq
         10Hyw5JKtNUWKltSNszOcEmzoFBfByudLVU7MIhM=
Date:   Fri, 4 Feb 2022 16:11:39 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Permit COMMIT operations to return NFS4_OK
Message-ID: <20220204211139.GE27958@fieldses.org>
References: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 04, 2022 at 02:42:24PM -0500, Chuck Lever wrote:
> RFC 7530 permits COMMIT to return NFS4ERR_INVAL, but RFC 5661 and
> later do not. Allow INVAL as a legacy behavior, but test for OK
> also.

Applied, thanks.

--b.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_commit.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs4.0/servertests/st_commit.py b/nfs4.0/servertests/st_commit.py
> index 12a0dffa061f..4ef87e69c5d7 100644
> --- a/nfs4.0/servertests/st_commit.py
> +++ b/nfs4.0/servertests/st_commit.py
> @@ -160,4 +160,4 @@ def testCommitOverflow(t, env):
>      res = c.write_file(fh, _text, 0, stateid, how=UNSTABLE4)
>      check(res, msg="WRITE with how=UNSTABLE4")
>      res = c.commit_file(fh, 0xfffffffffffffff0, 64)
> -    check(res, NFS4ERR_INVAL, "COMMIT with offset + count overflow")
> +    check(res, [NFS4_OK, NFS4ERR_INVAL], "COMMIT with offset + count overflow")
> 
