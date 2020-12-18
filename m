Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0E2DE784
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Dec 2020 17:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLRQiE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Dec 2020 11:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLRQiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Dec 2020 11:38:03 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B500C0617B0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Dec 2020 08:37:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CB56E6E98; Fri, 18 Dec 2020 11:37:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CB56E6E98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608309441;
        bh=Kn36BF4BhKTEVb5LnxZ8/oOE6z48zjdBuu9HldRZyYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulCYtJP95nG0R8lCQmZtFIXqm2SRKMupEbwukpM9yLy7KklSN6gCyEtzSQSGMy/AI
         jmNw8PHEfLCT3mm5/9B2T17Y4MvMQvIw8DMEMkqbVTviY3vN3gG2Vi442PvYU5/D35
         34U9ag9IqtbJNYo0xKucE9D7/K8Y6vIJb0+LzTa0=
Date:   Fri, 18 Dec 2020 11:37:21 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     Tom Haynes <loghyr@gmail.com>, bfields <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
Message-ID: <20201218163721.GC1258@fieldses.org>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
 <20201218144605.GB1258@fieldses.org>
 <1510952492.5375434.1608308638350.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510952492.5375434.1608308638350.JavaMail.zimbra@desy.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 18, 2020 at 05:23:58PM +0100, Mkrtchyan, Tigran wrote:
> 
> I run the tests. They fail due to python3 incompatibility:

Thanks!  I can't reproduce these, I assume because they're failing too
early?:

FFLA1    st_flex.testFlexLayoutTestAccess                         : RUNNING
FFLA1    st_flex.testFlexLayoutTestAccess                         : FAILURE
           OP_LAYOUTGET should return NFS4_OK, instead got
	              NFS4ERR_LAYOUTUNAVAILABLE

They're probably easy fixes, but I'd rather leave them up to somebody
that can test the result.  Patches on top of these would be best.

--b.

> 
> FFST1    st_flex.testStateid1                                     : PASS
> FFLA1    st_flex.testFlexLayoutTestAccess                         : FAILURE
>            Expected uid_rd != b'17', got b'17'
> FFLG2    st_flex.testFlexLayoutStress                             : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> FFLS3    st_flex.testFlexLayoutStatsStraight                      : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> FFLS1    st_flex.testFlexLayoutStatsSmall                         : FAILURE
>            TypeError: can't concat str to bytes
> FFLS2    st_flex.testFlexLayoutStatsReset                         : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> FFLS4    st_flex.testFlexLayoutStatsOverflow                      : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> FFLORSTALEWRITE st_flex.testFlexLayoutReturnStaleWrite            : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_STALE, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORSTALEREAD st_flex.testFlexLayoutReturnStaleRead              : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLORSERVERFAULTWRITE st_flex.testFlexLayoutReturnServerFaultWrite : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_SERVERFAULT, instead got
>            NFS4ERR_LAYOUTUNAVAILABLE
> FFLORSERVERFAULTREAD st_flex.testFlexLayoutReturnServerFaultRead  : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLORNXIOWRITE st_flex.testFlexLayoutReturnNxioWrite              : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_NXIO, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORNXIOREAD st_flex.testFlexLayoutReturnNxioRead                : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLORNOSPCWRITE st_flex.testFlexLayoutReturnNospcWrite            : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_NOSPC, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORNOSPC st_flex.testFlexLayoutReturnNospcRead                  : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTUNAVAILABLE
> FFLORIOWRITE st_flex.testFlexLayoutReturnIoWrite                  : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_IO, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORIOREAD st_flex.testFlexLayoutReturnIoRead                    : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLORFBIGWRITE st_flex.testFlexLayoutReturnFbigWrite              : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_FBIG, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORFBIG st_flex.testFlexLayoutReturnFbigRead                    : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTUNAVAILABLE
> FFLORDELAYWRITE st_flex.testFlexLayoutReturnDelayWrite            : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY,
>            instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORDELAYREAD st_flex.testFlexLayoutReturnDelayRead              : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLORACCESSWRITE st_flex.testFlexLayoutReturnAccessWrite          : FAILURE
>            OP_LAYOUTGET should return NFS4_OK or NFS4ERR_DELAY or
>            NFS4ERR_ACCESS, instead got NFS4ERR_LAYOUTUNAVAILABLE
> FFLORACCESSREAD st_flex.testFlexLayoutReturnAccessRead            : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFLOR100 st_flex.testFlexLayoutReturn100                          : FAILURE
>            NameError: name 'xrange' is not defined
> FFLOOS   st_flex.testFlexLayoutOldSeqid                           : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> FFGLO1   st_flex.testFlexGetLayout                                : FAILURE
>            OP_LAYOUTGET should return NFS4_OK, instead got
>            NFS4ERR_LAYOUTTRYLATER
> FFGDI1   st_flex.testFlexGetDevInfo                               : FAILURE
>            TypeError: can only concatenate str (not "bytes") to
>            str
> 
> 
> Regards,
>    Tigran.
> 
> 
> 
> ----- Original Message -----
> > From: "J. Bruce Fields" <bfields@fieldses.org>
> > To: "Tom Haynes" <loghyr@gmail.com>
> > Cc: "bfields" <bfields@redhat.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Friday, 18 December, 2020 15:46:05
> > Subject: Re: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
> 
> > On Wed, Dec 16, 2020 at 04:35:06PM -0800, Tom Haynes wrote:
> >> Hi Bruce,
> >> 
> >> Here are a series of patches that Hamerspace has applied to the
> >> flex files testing.
> > 
> > Thanks, applying.
> > 
> > I'm pretty hands-off when it comes to pynfs tests I don't personally
> > run.  If they work for you then I'm probably fine with them....
> > 
> > --b.
> > 
> >> 
> >> Thanks,
> >> Tom
> >> 
> >> Jean Spector (2):
> >>   st_flex.py - Added tests for LAYOUTRETURN with errors
> >>   st_flex.py - Fixed flag names
> >> 
> >> Tom Haynes (7):
> >>   Close the file for SEQ10b
> >>   flexfiles: Fix up the layout error handling to reflect the previous
> >>     error
> >>   st_flex: Reduce the layoutstats period to make tests finish in a sane
> >>     time
> >>   st_flex: Fix up test names
> >>   st_flex: Only do 100 layoutget/return in loop
> >>   st_flex: We can't return the layout without a layout stateid
> >>   st_flex: Fixup check for error in layoutget_return()
> >> 
> >> Trond Myklebust (1):
> >>   Fix testFlexLayoutOldSeqid
> >> 
> >>  nfs4.1/server41tests/st_flex.py     | 651 +++++++++++++++++++++++++---
> >>  nfs4.1/server41tests/st_sequence.py |   5 +
> >>  2 files changed, 588 insertions(+), 68 deletions(-)
> >> 
> >> --
> > > 2.26.2
