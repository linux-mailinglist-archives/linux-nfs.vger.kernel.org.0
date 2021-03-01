Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202BC328C5B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhCASuX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 13:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbhCASrP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 13:47:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92DC061788
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 10:46:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D8BA835DC; Mon,  1 Mar 2021 13:46:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D8BA835DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614624393;
        bh=tR9FV74TG7aboiff8kX9ITnog8YKtirnO6H1axkeC/M=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=UaZVdh2Rtc7Wgntlr/jzcUpTvXDOMUbEQlT2akHSPMDMYYlhKEi6ku/XKXQutZfqI
         yivxI5bUZIgUG+X9uWZPQvV9HUPI3CUvLfR11SCJ5gGqb2q5qk+chYFHX74iqmANwP
         HuW1/KKdPbk31MjZY4WOLmMH/+POddowXWmhCTrk=
Date:   Mon, 1 Mar 2021 13:46:33 -0500
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: NFSD Regression: client observing a file while other client
 writes to it leads to stale local cache
Message-ID: <20210301184633.GA14881@fieldses.org>
References: <c3efd7e8-dc08-ac1f-9bee-7a7b0d8ac5fb@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3efd7e8-dc08-ac1f-9bee-7a7b0d8ac5fb@rothenpieler.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the bisecting this and reporting the results.

The behavior you describe is probably not a bug: NFS close-to-open
caching semantics don't guarantee you'll see updates on the reading
client in this case.

Nevertheless, I don't understand why the behavior changed with that
commit, and I'd like to.

The only change in behavior I'd expect would be that the writing client
would be granted a read delegation.  But I wouldn't expect that to
change how it writes back data, or how the reading client checks for
file changes.  (The reading client still shouldn't be granted a
delegation.)

I'll take a look.

--b.

On Sun, Feb 28, 2021 at 11:27:53PM +0100, Timo Rothenpieler wrote:
> I've been observing an issue where an NFS client reading(tail -f to
> be precise) a file to which another NFS client is writing(or rather,
> appending. It's a log file of a cluster job), the reading client
> gets stuck, and does not update its view of the file anymore.
> 
> On the server, the file still gets new lines of log added as expected.
> On the reading client, the file gets stuck in the state of the
> moment it's being read.
> And stays that way until the writing site closes it, and some time
> passes after that.
> 
> So, with the NFS Server being on 5.4, the issue did not appear.
> On 5.10, it does. So I bisected the server it with the following setup:
> 
> One Client opening and appending to a file:
> 
> > ( for i in $(seq 1 60); do date; sleep 1; done ) > testfile
> 
> The other just does "fail -f" on the selfsame file.
> 
> On the good side of the bisect, the file updates as expected, and
> tail -f shows new lines as they are added. On the bad side, it just
> gets stuck and never updates. The file size in "ls -l" also gets
> stuck.
> 
> At the end of that bisect, git pointed me at commit
> 94415b06eb8aed13481646026dc995f04a3a534a.
> 
> > nfsd4: a client's own opens needn't prevent delegations
> 
> And indeed, reverting that commit on top of a current 5.10 kernel
> makes the issue go away.
> 


