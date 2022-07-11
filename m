Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948FF5709CB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGKSTr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGKSTq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:19:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128F2A72A;
        Mon, 11 Jul 2022 11:19:42 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A37A0612F; Mon, 11 Jul 2022 14:19:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A37A0612F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657563581;
        bh=yTN1iMuS7W4RZG3D9DAoI8ysBN7jOP71+Dr669dLx6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=whT6OMpOCB9/xvdcePS2enz3qvMMzSekD13C49qtEy9SLe9loGnS6Sxd4xRhU6kQE
         zI2YUiYDZjBXQWZsJdjgV/ppATgx8ZFV1f5+PMRJPAJEjP/P9wxwZNEo14lDlUHqR5
         cieZNu8Zyls4rCyVgLhl3pPNWGancK8jibGMNWOo=
Date:   Mon, 11 Jul 2022 14:19:41 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220711181941.GC14184@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
 <20220710124344.36dfd857@redhat.com>
 <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
 <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
> > > This patch regressed clients that support TIME_CREATE attribute.
> > > Starting with this patch client might think that server supports
> > > TIME_CREATE and start sending this attribute in its requests.
> > 
> > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > attribute") does not include a change to nfsd4_decode_fattr4()
> > that decodes the birth time attribute.
> > 
> > I don't immediately see another storage protocol stack in our
> > kernel that supports a client setting the birth time, so NFSD
> > might have to ignore the client-provided value.
> > 
> 
> Cephfs allows this. My thinking at the time that I implemented it was
> that it should be settable for backup purposes, but this was possibly a
> mistake. On most filesystems, the btime seems to be equivalent to inode
> creation time and is read-only.

So supporting it as read-only seems reasonable.

Clearly, failing to decode the setattr attempt isn't the right way to do
that.  I'm not sure what exactly it should be doing--some kind of
permission error on any setattr containing TIME_CREATE?

--b.
