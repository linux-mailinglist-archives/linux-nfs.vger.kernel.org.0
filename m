Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369BB32D59F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhCDOnc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 09:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhCDOnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 09:43:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB5C061574
        for <linux-nfs@vger.kernel.org>; Thu,  4 Mar 2021 06:42:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8E6E323D8; Thu,  4 Mar 2021 09:42:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8E6E323D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614868948;
        bh=mRxOAPLsTIUmXy9BQCOqKTdEATY9DYLVX8QMRC3aRiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4fxdGfkfJ1vy76UNTHgfTEcs63mcJxsv9yNVP/LfL7032eqbZU3uwURC6ZLj8zf+
         e7ILPtCRjk9kuFsaRKUbf950qN/0yvXcsomRJ+lTSCaWXw5UwdKJdkmNd2Lc/R04sW
         3+XitCDc5YY3q6BmBNz35OA/SuzidE8iUiFHAUXE=
Date:   Thu, 4 Mar 2021 09:42:28 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD Regression: client observing a file while other client
 writes to it leads to stale local cache
Message-ID: <20210304144228.GD17512@fieldses.org>
References: <c3efd7e8-dc08-ac1f-9bee-7a7b0d8ac5fb@rothenpieler.org>
 <20210301184633.GA14881@fieldses.org>
 <86ef3b71-bcb4-767c-40a0-461d082f5d44@rothenpieler.org>
 <20210302010629.GB16303@fieldses.org>
 <2d4e7965-903f-2319-d2d2-65116f50400c@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4e7965-903f-2319-d2d2-65116f50400c@rothenpieler.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 02:23:05AM +0100, Timo Rothenpieler wrote:
> Server and reading client disagreeing about the files size and
> contents is 100% reproducible, even after the writing client has
> long and definitely closed the file.

OK, I reproduced this myself and watched the network traffic in
Wireshark.

The server is *not* giving out a read delegation to the writer (which is
what the commit you bisected to should have allowed).  It *is* giving
out a delegation to the reader.  Which is a truly awful bug.
Investigating....

--b.
