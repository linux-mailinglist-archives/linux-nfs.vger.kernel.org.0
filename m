Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603334420CD
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhKAT1z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhKAT1y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:27:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B7C061764
        for <linux-nfs@vger.kernel.org>; Mon,  1 Nov 2021 12:25:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 517AF7034; Mon,  1 Nov 2021 15:25:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 517AF7034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1635794719;
        bh=+aUUnDONUpZHyrrHziH3Cxgrd6i6LDdPTe3OO0XxN00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1rPUqnysgNyZ+4vZQ5KFgMQJ2ug+xEd0/oLnC/Y9zLGnzttX1ZIQWsuElrsKdaic
         9hqzRp7reVArogXwIQYI7DjChmSiaw9NCB9oL122LTVptjgtvrL8H/W6ulkjpT4gSi
         XgtbgaAXPpGCr9NM46n7Z8IeO/2ig/kQ8PA0ByKk=
Date:   Mon, 1 Nov 2021 15:25:19 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Message-ID: <20211101192519.GB14427@fieldses.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <badaecc5-2936-4ab7-53e9-fabee0b51493@redhat.com>
 <93c09b22-9439-3404-ed07-e99cbbc12052@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c09b22-9439-3404-ed07-e99cbbc12052@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 01, 2021 at 12:22:15PM -0700, dai.ngo@oracle.com wrote:
> 
> On 11/1/21 12:02 PM, Steve Dickson wrote:
> >
> >
> >On 11/1/21 11:40, J. Bruce Fields wrote:
> >>On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
> >>>Now that cp will use copy_file_range() when available,
> >>>what are the steps needed to enable these fast copies?
> >>
> >>1) Make sure client and both servers support NFSv4.2 and
> >>server-to-server copy.
> >Something is already figuring this out... The only time
> >the client sends a COPY_NOTIFY and COPY is when both
> >mounts are 4.2. I have not looked into but that is what
> >the network traces are showing.

Right.  I was thinking what I'd tell an admin who wanted to set up
server-to-server copy.  The first thing they'd need to do was check that
their clients and servers were new enough.

> >>2) Make sure destination server can access (at least for read) any
> >>exports on the source that you want to be able to copy from.
> >How can one server know what the other server has exported
> >or access to??

And the second is to make sure that the destination server is able to
read from the source.

> >>3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
> >>destination server.
> >Who would be doing this? Plus this would not survive over a reboot.
> >An export would as well a /etc/modprobe.d/ file.
> 
> You can add a line in /etc/modprobe.d/nfsd.conf:
> 
> options nfsd inter_copy_offload_enable=Y
> 
> to enable the option.

Yep, it would be better to document it that way, thanks.

--b.
