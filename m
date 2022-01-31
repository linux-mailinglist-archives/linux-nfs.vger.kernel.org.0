Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8C4A523F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 23:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiAaWUq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 17:20:46 -0500
Received: from server.atrad.com.au ([150.101.241.2]:41388 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiAaWUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 17:20:46 -0500
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20VMKK2n031344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 1 Feb 2022 08:50:22 +1030
Date:   Tue, 1 Feb 2022 08:50:20 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Message-ID: <20220131222020.GB12905@marvin.atrad.com.au>
References: <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
 <20220118220016.GB16108@fieldses.org>
 <6349BB98-FB18-4ABC-A893-1CCB1E5CA3E5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6349BB98-FB18-4ABC-A893-1CCB1E5CA3E5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 19, 2022 at 04:18:10PM +0000, Chuck Lever III wrote:
> > On Jan 18, 2022, at 5:00 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > I thought I was iterating over the array when actually the iteration is
> > over the values contained in the array?
> > 
> > Ugh, keep it simple.
> > 
> > Symptoms were a null deference in vfs_lock_file() when an NFSv3 client
> > that previously held a lock came back up and sent a notify.
> > 
> > Reported-by: Jonathan Woithe <jwoithe@just42.net>
> > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > :
> Hi Bruce, thanks for the fixes. They've passed my basic smoke tests.
> I've applied both patches for the very next nfsd PR. See:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git for-next

OOI, is it expected that these fixes will appear in a 5.15.x stable branch
patch at some point?  I've looked at the 5.15.17 and 5.15.18 changelogs and
they don't appear to be mentioned yet.

Regards
  jonathan
