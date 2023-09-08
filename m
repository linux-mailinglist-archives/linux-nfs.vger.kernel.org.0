Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B78798815
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjIHNsA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Sep 2023 09:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbjIHNsA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Sep 2023 09:48:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06E1BC6;
        Fri,  8 Sep 2023 06:47:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD7C433C9;
        Fri,  8 Sep 2023 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694180876;
        bh=vo3LdEaDlbbC59r7f6ZMikgza/y5WzO7sH0rYXOKHuU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u8/EDwyPv/C4WgLGqU9E737Ip8RQJvkW0oiuvWQ0koQUjCfTgn/9npdJ6HlepcJBy
         0GZMUp+mms2rGrJjzOIrBQAQATXh8lpq9968CyKjIz6/O+BOo2IyZBa/5i1iwLLAw/
         G9teVOyxvcym4e+8Je0rx0Fj3kMz5eZpqwEgrRw5gzc4QDBdt603/Ql68fVoErDXfO
         m/XeF9QB12AI1vMTYECNLGTMQ/n1fYxqqlSZPjtAQvrvqvH4jmAol0FuXVaW9NKwYp
         dwC7xN2jd41OD4WJEYJ6kRiVTVCKkCK3U/eG3iSotjpeCf/KegrB8Huc3TtOMquNRH
         OjAvwSm/qJOVA==
Message-ID: <34f72d799493c03cf77b32c1761ab6cf5d368f53.camel@kernel.org>
Subject: Re: [PATCH RFC] nfs4: add a get_acl stub handler
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Date:   Fri, 08 Sep 2023 09:47:54 -0400
In-Reply-To: <20230908-bandbreite-orgel-065607d1b281@brauner>
References: <20230907-kdevops-v1-1-c2015c29d634@kernel.org>
         <20230908-bandbreite-orgel-065607d1b281@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-09-08 at 14:55 +0200, Christian Brauner wrote:
> On Thu, Sep 07, 2023 at 01:32:36PM -0400, Jeff Layton wrote:
> > In older kernels, attempting to fetch that system.posix_acl_access on
> > NFSv4 would return -EOPNOTSUPP, but in more recent kernels that returns
> > -ENODATA.
> >=20
> > Most filesystems that don't support POSIX ACLs leave the SB_POSIXACL
> > flag clear, which cues the VFS to return -EOPNOTSUPP in this situation.
> > We can't do that with NFSv4 since that flag also cues the VFS to avoid
> > applying the umask early.
> >=20
> > Fix this by adding a stub get_acl handler for NFSv4 that always returns
> > -EOPNOTSUPP.
> >=20
> > Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > I suspect that this problem popped in due to some VFS layer changes. I
> > haven't identified the patch that broke it, but I think this is probabl=
y
> > the least invasive way to fix it.
> >=20
> > Another alternative would be to return -EOPNOTSUPP on filesystems that
> > set SB_POSIXACL but that don't set get_acl or get_inode_acl.
> >=20
> > Thoughts?
>=20
> Yes: I hate POSIX ACLs. ;)

The API is quite weird, yes.

> Before the VFS rework to only rely on i_op->*acl* methods POSIX ACLs
> were set using sb->s_xattr handlers. So when a filesystem raised
> SB_POSIXACL but didn't set sb->s_xattr handlers for POSIX ACLs we would:
>=20
> __vfs_getxattr()
> -> xattr_resolve_name()
>   // no match so return EOPNOTSUPP
>=20
> No we have
>=20
> vfs_get_acl()
> -> __get_acl()
>    -> i_op->get_acl
>    // no get_acl inode method return ENODATA
>=20
> So as a bugfix to backport I think you should do exactly what you do
> here because I'm not sure if some fs relies on ENODATA to be returned if
> no get_acl inode method is set. There's a lot of quirkiness everywhere.
> But we should look through all callers and if nothing relies on EINVAL
> just start returning EOPNOTSUPP if no get_acl i_op is set.
>=20
> Looks good to me,
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks. I did some rudimentary git grepping, and I don't see any that
set SB_POSIXACL but don't set either get_acl or get_inode_acl. I'll spin
up a patch and we can get it into -next for a while and see if anything
shakes out.
--=20
Jeff Layton <jlayton@kernel.org>
