Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A4571A9B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiGLM5i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGLM5h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 08:57:37 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CCA5E73;
        Tue, 12 Jul 2022 05:57:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4013064EB; Tue, 12 Jul 2022 08:57:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4013064EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657630654;
        bh=M6WdCyriOloN+RDs822UlkL0MGgMRmbew1eUogj1s4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b35z0NnOnJpv2pjF9bAwqiPqMYaJ5gR70Q8s5xFIGo8Uuz8fWAwYo5KHeUL1MHKi1
         m1lrAD68WK6qJSX1D6y+9TlcJsQhmJaoeZDVcDsyoWuBYn3CxY24cmN2YDJhJoEErL
         a1uWk/kPPwQO79jNxtfMa9diyMMe4Ff72dM6Xyo4=
Date:   Tue, 12 Jul 2022 08:57:34 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220712125734.GB29976@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
 <20220710124344.36dfd857@redhat.com>
 <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
 <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
 <20220711181941.GC14184@fieldses.org>
 <7CD95BBD-3552-47BD-ACF6-EC51F62787E1@oracle.com>
 <20220711183603.GD14184@fieldses.org>
 <f5d20f4e1aeb5d478e10a39c17ed003616c7872c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d20f4e1aeb5d478e10a39c17ed003616c7872c.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 11, 2022 at 02:56:40PM -0400, Jeff Layton wrote:
> On Mon, 2022-07-11 at 14:36 -0400, Bruce Fields wrote:
> > On Mon, Jul 11, 2022 at 06:24:01PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Jul 11, 2022, at 2:19 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > > > 
> > > > On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> > > > > On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
> > > > > > > This patch regressed clients that support TIME_CREATE attribute.
> > > > > > > Starting with this patch client might think that server supports
> > > > > > > TIME_CREATE and start sending this attribute in its requests.
> > > > > > 
> > > > > > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > > > > > attribute") does not include a change to nfsd4_decode_fattr4()
> > > > > > that decodes the birth time attribute.
> > > > > > 
> > > > > > I don't immediately see another storage protocol stack in our
> > > > > > kernel that supports a client setting the birth time, so NFSD
> > > > > > might have to ignore the client-provided value.
> > > > > > 
> > > > > 
> > > > > Cephfs allows this. My thinking at the time that I implemented it was
> > > > > that it should be settable for backup purposes, but this was possibly a
> > > > > mistake. On most filesystems, the btime seems to be equivalent to inode
> > > > > creation time and is read-only.
> > > > 
> > > > So supporting it as read-only seems reasonable.
> > > > 
> > > > Clearly, failing to decode the setattr attempt isn't the right way to do
> > > > that.  I'm not sure what exactly it should be doing--some kind of
> > > > permission error on any setattr containing TIME_CREATE?
> > > 
> > > I don't think that will work.
> > > 
> > > NFSD now asserts FATTR4_WORD1_TIME_CREATE when clients ask for
> > > the mask of attributes it supports. That means the server has
> > > to process GETATTR and SETATTR (and OPEN) operations that
> > > contain FATTR4_WORD1_TIME_CREATE as not an error.
> > 
> > Well, permissions or bad attribute values or other stuff may prevent
> > setting one of the attributes.
> > 
> > And setattr isn't guaranteed to be atomic, so I don't think you can
> > eliminate the possibility that part of it might succeed and part might
> > not.
> > 
> > But it might be more helpful to fail the whole thing up front if you
> > know part of it's going to fail?
> > 
> 
> RFC5661 says:
> 
>    On either success or failure of the operation, the server will return
>    the attrsset bitmask to represent what (if any) attributes were
>    successfully set.  The attrsset in the response is a subset of the
>    attrmask field of the obj_attributes field in the argument.
> 
> ...and then later:
> 
>    A mask of the attributes actually set is returned by SETATTR in all
>    cases.  That mask MUST NOT include attribute bits not requested to be
>    set by the client.  If the attribute masks in the request and reply
>    are equal, the status field in the reply MUST be NFS4_OK.

For some reason I thought the converse was true too (if the masks
differ, then the server should return an error).  But you're right, I
don't see that in the spec.

> So, I think just clearing the bit and returning NFS4_OK should be fine.

I suppose.

Nevertheless, the spec gives the option of returning both an error and a
bitmap, and to me it seems more helpful to take advantage of the
opportunity to tell the client both which attribute(s) failed and (to
the extent possible) why.  ??

> If the mask ends up being 0 after clearing the bit though, it might be
> reasonable to return something like NFS4ERR_ATTRNOTSUPP. That would be a
> bit weird though since we do support it for GETATTR, hence my suggestion
> for a NFS4ERR_ATTR_RO.

That might be useful.

--b.
