Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4D23C159
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHDVVc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgHDVVc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 17:21:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07829C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  4 Aug 2020 14:21:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2DFB19238; Tue,  4 Aug 2020 17:21:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2DFB19238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1596576088;
        bh=wxupdSrHcU6qkYlO1fDUVOVEHsL3xf/8Nki//4HSvn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIr28ctZUaMUY/YRyOQugzP1UDnuZGaPnrdE1M4ig5ljPe0slOOm1FNIUXfGOmyaI
         m0Qq0pUwuhIRgbqUCAijK0clVIXdzAAd3m3gdjD6jJ+DSGL7v5qz9JA2vwX6Xis64J
         wkyq+gXpMrqiN/yZBW8bJJYSga+p7S42MJQDZMN4=
Date:   Tue, 4 Aug 2020 17:21:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: Fw: [Bug 208807] New: Problem with NFS kernel server code
Message-ID: <20200804212128.GC25981@fieldses.org>
References: <20200804140744.35ce4bdd@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804140744.35ce4bdd@hermes.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commented, but I guess it should really be reassigned to nfsd, I'm not
sure how.

--b.

On Tue, Aug 04, 2020 at 02:07:44PM -0700, Stephen Hemminger wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Tue, 04 Aug 2020 11:33:23 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 208807] New: Problem with NFS kernel server code
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208807
> 
>             Bug ID: 208807
>            Summary: Problem with NFS kernel server code
>            Product: Networking
>            Version: 2.5
>     Kernel Version: 5.8.0
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: nanook@eskimo.com
>         Regression: No
> 
> Created attachment 290759
>   --> https://bugzilla.kernel.org/attachment.cgi?id=290759&action=edit  
> Output of dmesg while machine was dying
> 
> After about an hour and a half of operating on 5.8.0, one of our NFS servers
> began to slow and basically ground to a halt.  Looks like a spinlock issue in
> the NFS kernel server code.  I'll attach the output of dmesg while the machine
> was dying in a file called "spinlock".  A shame because while it was running,
> the performance of 5.8 was astounding.  Only the NFS servers seem to get ill,
> the
> client machines seem to run fine on 5.8 so far at least.
> 
> -- 
> You are receiving this mail because:
> You are the assignee for the bug.
