Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CD32A939
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbhCBSN1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378616AbhCBBHN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 20:07:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F5C061756
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 17:06:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9010E25FE; Mon,  1 Mar 2021 20:06:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9010E25FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614647189;
        bh=/a/Fsdva98dfgoVUiX949CYD9/BNslNwa1VoKd2nZdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUO0X8XXHlioVd20HlDk3JzmtHjnYO0T7jkixOjXc/TeaqOfESD8lSV3FTMBoDhiB
         jddqj3IlwAhaJtO3SOUZiw6wasKH55NnEmmXl6dSB3LBRtTILBDDWmDBOGNbfwhB6j
         rMDa/LyYVIsPZ51N0ijjopRh0+ufoyMcIOzhc/gA=
Date:   Mon, 1 Mar 2021 20:06:29 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD Regression: client observing a file while other client
 writes to it leads to stale local cache
Message-ID: <20210302010629.GB16303@fieldses.org>
References: <c3efd7e8-dc08-ac1f-9bee-7a7b0d8ac5fb@rothenpieler.org>
 <20210301184633.GA14881@fieldses.org>
 <86ef3b71-bcb4-767c-40a0-461d082f5d44@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ef3b71-bcb4-767c-40a0-461d082f5d44@rothenpieler.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 02:03:58AM +0100, Timo Rothenpieler wrote:
> On 01.03.2021 19:46, J. Bruce Fields wrote:
> >Thanks for the bisecting this and reporting the results.
> >
> >The behavior you describe is probably not a bug: NFS close-to-open
> >caching semantics don't guarantee you'll see updates on the reading
> >client in this case.
> >
> >Nevertheless, I don't understand why the behavior changed with that
> >commit, and I'd like to.
> >
> >The only change in behavior I'd expect would be that the writing client
> >would be granted a read delegation.  But I wouldn't expect that to
> >change how it writes back data, or how the reading client checks for
> 
> The writing side of things does not seem to be affected.
> At any point during testing, the file on the servers filesystem is
> in the state I'd expect it to be, growing by one line per second.
> 
> What's also a bit odd about this is that after both clients have
> closed the file, the reading client still sees an older version of
> the file, the one state it was in when it was first opened on the
> client.
> The file size in stat()/ls -l mismatches between the reading client
> and the server.
> It stays in that state for some seemingly arbitrary amount of time.
> Observing the file in any way(cat/tail, or even just ls) appears to
> extend the wait time.
> After leaving the file alone for long enough on the reading client,
> it snaps back to reality.

Hm, I wonder if we're (incorrectly) giving out a delegation to the
reading client.  Is this 100% reproduceable?

--b.

> This change in behavior, while clearly an edge case, is quite
> devastating for our use case. And also somewhat counter-intuitive.
> 
> It's the log output of cluster jobs sent off to compute nodes by the users.
> They then observe what the job is doing via tail -f on the log file
> on the login node.
> 


