Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2373E5E80
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhHJO7X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 10:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbhHJO7W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 10:59:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A56C0613C1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 07:59:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C28747C63; Tue, 10 Aug 2021 10:58:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C28747C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628607539;
        bh=+pS25G21UB7Ww7npuAdbqszL6fR8eOJKWjAdrR+Xt44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bltrgq3qOkPR5/+bxdYQA4TkypDQY0mwgWgHMgHhv+jv28VrpynTSr162QaWtwCvW
         WKk/beNqQphG70tsRbMaUQbuez0hb7kAFaLkdFMa+FprooCiru72BU0hsRwCA/0fLI
         9Y6m5t3cFbz5zLVwCO31PHaNUpEpBiggXI1CqQ4Q=
Date:   Tue, 10 Aug 2021 10:58:59 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     hedrick@rutgers.edu
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Message-ID: <20210810145859.GB31222@fieldses.org>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <20210809183029.GC8394@fieldses.org>
 <413163A6-8484-4170-9877-C0C2D50B13C0@rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <413163A6-8484-4170-9877-C0C2D50B13C0@rutgers.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 10, 2021 at 10:57:10AM -0400, hedrick@rutgers.edu wrote:
> No. NFS 4.2 has a new feature that sends the umask. That means that
> ACLs specifying default permissions actually work. They don’t work in
> 4.0. Since that’s what I want to use ACLs for, effectively they don’t
> work in 4.0 Nothing you can do about that: it’s in the protocol
> definition. But it’s a reason we really want to use 4.2.

D'oh, I forgot the umask change.  Got it, makes sense.

--b.
