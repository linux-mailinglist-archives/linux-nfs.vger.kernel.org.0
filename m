Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2829CFB
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2019 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEXRbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 May 2019 13:31:00 -0400
Received: from mail.prgmr.com ([71.19.149.6]:43120 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfEXRa7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 May 2019 13:30:59 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 7F5E528C001
        for <linux-nfs@vger.kernel.org>; Fri, 24 May 2019 18:28:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 7F5E528C001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1558736930;
        bh=B8NWOCzJlm1HRZkKHmpCbWhdPAatcPClz7Z7+IniQvY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Aymnu9JU+3N3reG/eRj4KERsOeQItiaMQODA7uRjCGjnBtPSxZU9aeYDZyCJUiH3l
         Cq+fTQ+1XOj6HEiPaNXG7Y+LF05JdNqgQFUulMdgCpi26eZq26FldNrceJzCULPgQT
         s5l0l6q6U2B1HazIQs0/sPlPcFzZLD0NCs4EbxVQ=
Received: (qmail 12494 invoked by uid 1353); 24 May 2019 17:31:55 -0000
Date:   Fri, 24 May 2019 11:31:55 -0600
From:   Alan Post <adp@prgmr.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190524173155.GQ4158@turtle.email>
References: <20190520223324.GL4158@turtle.email>
 <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 21, 2019 at 03:46:03PM +0000, Trond Myklebust wrote:
> Have you tried upgrading to 4.19.44? There is a fix that went in not
> too long ago that deals with a request leak that can cause stack traces
> like the above that wait forever.
> 

Following up on this.  I have set aside a rack of machines and put
Linux 4.19.44 on them.  They ran jobs overnight and will do the
same over the long weekend (Memorial day in the US).  Given the
error rate (both over time and over submitted jobs) we see across
the cluster this well be enough time to draw a conclusion as to
whether 4.19.44 exhibits this hang.

Other than stack traces, what kind of information could I collect
that would be helpful for debugging or describing more precisely
what is happening to these hosts?  I'd like to exit from the condition
of trying different kernels (as you no doubt saw in my initial message
I've done a lot of it) and enter the condition of debugging or
reproducing the problem.

I'll report back early next week and appreciate your feedback,

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
