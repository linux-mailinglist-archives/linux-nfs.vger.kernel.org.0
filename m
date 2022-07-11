Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285D6570A04
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGKSgO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGKSgO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:36:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D96052C;
        Mon, 11 Jul 2022 11:36:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4D3361B1; Mon, 11 Jul 2022 14:36:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4D3361B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657564563;
        bh=j+yT2TuhJrn+qHfjW7qzOCro6104VZsWDgFPUWWeUF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onOxntxL3mJcRG6IpDUG5+KX6x3o6CterYjIVHM6zQV8QCsbssGoMjxaRxr6ZhV6D
         EyP1Uqx9n4ESTIWAr+PPFazkX2bTuUDMS11DgaXz7NJMU33tWoPQgpf1OiIydfHSHi
         uUEjNMWCTzwFBmVOZhGcYKWIisp/cXlOecdA0m+o=
Date:   Mon, 11 Jul 2022 14:36:03 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220711183603.GD14184@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
 <20220710124344.36dfd857@redhat.com>
 <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
 <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
 <20220711181941.GC14184@fieldses.org>
 <7CD95BBD-3552-47BD-ACF6-EC51F62787E1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CD95BBD-3552-47BD-ACF6-EC51F62787E1@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 11, 2022 at 06:24:01PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 11, 2022, at 2:19 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> >> On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
> >>>> This patch regressed clients that support TIME_CREATE attribute.
> >>>> Starting with this patch client might think that server supports
> >>>> TIME_CREATE and start sending this attribute in its requests.
> >>> 
> >>> Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> >>> attribute") does not include a change to nfsd4_decode_fattr4()
> >>> that decodes the birth time attribute.
> >>> 
> >>> I don't immediately see another storage protocol stack in our
> >>> kernel that supports a client setting the birth time, so NFSD
> >>> might have to ignore the client-provided value.
> >>> 
> >> 
> >> Cephfs allows this. My thinking at the time that I implemented it was
> >> that it should be settable for backup purposes, but this was possibly a
> >> mistake. On most filesystems, the btime seems to be equivalent to inode
> >> creation time and is read-only.
> > 
> > So supporting it as read-only seems reasonable.
> > 
> > Clearly, failing to decode the setattr attempt isn't the right way to do
> > that.  I'm not sure what exactly it should be doing--some kind of
> > permission error on any setattr containing TIME_CREATE?
> 
> I don't think that will work.
> 
> NFSD now asserts FATTR4_WORD1_TIME_CREATE when clients ask for
> the mask of attributes it supports. That means the server has
> to process GETATTR and SETATTR (and OPEN) operations that
> contain FATTR4_WORD1_TIME_CREATE as not an error.

Well, permissions or bad attribute values or other stuff may prevent
setting one of the attributes.

And setattr isn't guaranteed to be atomic, so I don't think you can
eliminate the possibility that part of it might succeed and part might
not.

But it might be more helpful to fail the whole thing up front if you
know part of it's going to fail?

> The protocol
> allows the server to indicate it ignored the time_create value
> by clearing the FATTR4_WORD1_TIME_CREATE bit in the attribute
> bitmask it returns in the reply.

Yes, I think you also return an error in that case, though.

--b.
