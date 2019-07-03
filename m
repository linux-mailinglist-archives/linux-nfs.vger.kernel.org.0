Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471035EE88
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGCVaa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 17:30:30 -0400
Received: from mail.prgmr.com ([71.19.149.6]:57062 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCVaa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 17:30:30 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 1C29872008D
        for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2019 22:27:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 1C29872008D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1562207249;
        bh=xtvcBkhZQMHtrCmE/920LkbkfaUDBJvo8ELcMPK895M=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=lYJSnzK5uQOlPGXfKfDgQMN6wEP9dNZ60GS//8lz0lus9u1OtHSt1uhLJmbtBPi9i
         McuT8vdi7HTlJ4oKTeHlPIVJHcLxxBmGNugV9RV2DRV39DK7TM4fp4v7jNITaXeuZ9
         Vv83t58uwBehUM38zSgVdebmT8kHsALD59pLfCnI=
Received: (qmail 22989 invoked by uid 1353); 3 Jul 2019 21:32:21 -0000
Date:   Wed, 3 Jul 2019 15:32:21 -0600
From:   Alan Post <adp@prgmr.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Message-ID: <20190703213221.GB4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
 <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
 <20190621204723.GU4158@turtle.email>
 <20190628183324.GJ4158@turtle.email>
 <35045385-2C77-4BA0-8641-2AE4E73E04A4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35045385-2C77-4BA0-8641-2AE4E73E04A4@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 02, 2019 at 05:55:10AM -0400, Benjamin Coddington wrote:
> > As far as I understand it, for a particular xid, there should be a
> > call and a reply.  The approach I took then was to pull out these
> > fields from my capture and ignore RPC calls where both are present
> > in my capture.  It seems this is simplistic, as the number of RPC
> > calls I have without an attendant reply isn't lining up with my
> > incident window.
> 
> Does your capture report dropped packets?  If so, maybe you need to increase
> the capture buffer.
> 

I'm not certain, but I do have a capture on both the NFS server and
the NFS client--comparing them would show me if I was under most
circumstances.  Good catch.

> > In one example, I have a series of READ calls which cease
> > generating RPC reply messages as the offset for the file continues
> > to increases.  After a couple/few dozen messages, the RPC replies
> > continue as they were.  Is there a normal or routine explanation
> > for this?
> >
> > RFC 5531 and the NetworkTracing page on wiki.linux-nfs.org have
> > been quite helpful bringing me up to speed.  If any of you have
> > advice or guidance or can clarify my understanding of how the
> > call/reply RPC mechanism works I appreciate it.
> 
> Seems like you understand it.  Do you have specific questions?
> 

Is it true that for each RPC call there is an RPC reply with the
same xid?  Is it a-priori an error if an otherwise correct RPC
call is not eventually paired with an RPC reply?

Thank you,

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
