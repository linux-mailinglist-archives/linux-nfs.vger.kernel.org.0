Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51805536E55
	for <lists+linux-nfs@lfdr.de>; Sat, 28 May 2022 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiE1UTa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 May 2022 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiE1UTZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 May 2022 16:19:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD444D627
        for <linux-nfs@vger.kernel.org>; Sat, 28 May 2022 13:19:24 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 508EF7124; Sat, 28 May 2022 16:19:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 508EF7124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653769164;
        bh=x2jyS/ALZ67uRtgwuZHs1NSpWUQIZpWMYqc4/qu/6gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDLGZKcosluIkFVswdsp7ZdhRquN3MBvXndRFPwj5pp/4xh2XSX5q7duEzAljSbtB
         U/P/vxSlB1r8pkv1P+yIvud+ra0B8/L/QS4Id1K1aUcuMheYMuGAwE8DLJyuYWv+Am
         sgTzCaP4VzryyATSz7imLOyWpTXFB8h+YCn9k6S0=
Date:   Sat, 28 May 2022 16:19:24 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] Test renaming onto an open file
Message-ID: <20220528201924.GE9929@fieldses.org>
References: <165368065607.3280217.2106378952611449081.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165368065607.3280217.2106378952611449081.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applied, thanks.--b.

On Fri, May 27, 2022 at 03:44:55PM -0400, Chuck Lever wrote:
> There has been a recent report of RENAME onto an open file resulting
> in a bogus ESTALE when that open (and now deleted) file is closed.
> Build in some testing with and without SEQUENCE to ensure a server
> is handling this case as expected.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Changes since v1:
> - None. This is a just a repost.
> 
> ---
>  nfs4.0/servertests/st_rename.py   |   16 ++++++++++++++++
>  nfs4.1/server41tests/st_rename.py |   19 ++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs4.0/servertests/st_rename.py b/nfs4.0/servertests/st_rename.py
> index afe9a7fe0a58..3302608719e3 100644
> --- a/nfs4.0/servertests/st_rename.py
> +++ b/nfs4.0/servertests/st_rename.py
> @@ -524,6 +524,22 @@ def testLinkRename(t, env):
>          t.fail("RENAME of file into its hard link should do nothing, "
>                 "but cinfo was changed")
>  
> +def testStaleRename(t, env):
> +    """RENAME file over an open file should allow CLOSE
> +
> +    FLAGS: rename all
> +    CODE: RNM21
> +    """
> +    c = env.c1
> +    c.init_connection()
> +    basedir = c.homedir + [t.word()]
> +    c.maketree([t.word(), b'file'])
> +    fh, stateid = c.create_confirm(t.word(), path=basedir + [b'file2'])
> +    res = c.rename_obj(basedir + [b'file'], basedir + [b'file2'])
> +    check(res)
> +    res = c.close_file(t.word(), fh, stateid)
> +    check(res, msg="CLOSE after RENAME deletes target returns ESTALE")
> +
>  ###########################################
>  
>      def testNamingPolicy(t, env):
> diff --git a/nfs4.1/server41tests/st_rename.py b/nfs4.1/server41tests/st_rename.py
> index 066df749379f..26ed4d275067 100644
> --- a/nfs4.1/server41tests/st_rename.py
> +++ b/nfs4.1/server41tests/st_rename.py
> @@ -1,5 +1,5 @@
>  from xdrdef.nfs4_const import *
> -from .environment import check, fail, maketree, rename_obj, get_invalid_utf8strings, create_obj, create_confirm, link, use_obj, create_file
> +from .environment import check, fail, maketree, rename_obj, get_invalid_utf8strings, create_obj, create_confirm, link, use_obj, create_file, close_file
>  import nfs_ops
>  op = nfs_ops.NFS4ops()
>  from xdrdef.nfs4_type import *
> @@ -529,3 +529,20 @@ def testLinkRename(t, env):
>      if scinfo.before != scinfo.after or tcinfo.before != tcinfo.after:
>          t.fail("RENAME of file into its hard link should do nothing, "
>                 "but cinfo was changed")
> +
> +def testStaleRename(t, env):
> +    """RENAME file over an open file should allow CLOSE
> +
> +    FLAGS: rename all
> +    CODE: RNM21
> +    """
> +    name = env.testname(t)
> +    owner = b"owner_%s" % name
> +    sess = env.c1.new_client_session(name)
> +    maketree(sess, [name, b'file'])
> +    basedir = env.c1.homedir + [name]
> +    fh, stateid = create_confirm(sess, owner, path=basedir + [b'file2'])
> +    res = rename_obj(sess, basedir + [b'file'], basedir + [b'file2'])
> +    check(res)
> +    res = close_file(sess, fh, stateid)
> +    check(res, msg="CLOSE after RENAME deletes target returns ESTALE")
> 
