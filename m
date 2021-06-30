Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073BC3B8825
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhF3SH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhF3SH5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 14:07:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6958C061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 11:05:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CA88F64B9; Wed, 30 Jun 2021 14:05:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CA88F64B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625076327;
        bh=JV37aYLjdiGF0X3NcLNpWV+LuSe1ibpIWSUtUYP3u6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8XkW9hBePv75gj7nzAzeNzSmzprI8DH+u7IIiTFV0dahoTK2rueltYouxKBaqDHE
         DDbE6mGUaxlBo3KThHynrpdgRe+IyC2SSq9AP6gwn0KhsCkygPeYJlnBB8zntmqLF0
         03OM8IL0vdzhXdbp1yWhCXRMQPCpE10YRb4kWKfM=
Date:   Wed, 30 Jun 2021 14:05:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210630180527.GE20229@fieldses.org>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210628202331.GC6776@fieldses.org>
 <dc71d572-d108-bcfc-e264-d96ef0de1b36@oracle.com>
 <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9628be9d-2bfd-d036-2308-847cb4f1a14d@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 10:51:27AM -0700, dai.ngo@oracle.com wrote:
> >On 6/28/21 1:23 PM, J. Bruce Fields wrote:
> >>
> >>where ->fl_expire_lock is a new lock callback with second
> >>argument "check"
> >>where:
> >>
> >>    check = 1 means: just check whether this lock could be freed
> 
> Why do we need this, is there a use case for it? can we just always try
> to expire the lock and return success/fail?

We can't expire the client while holding the flc_lock.  And once we drop
that lock we need to restart the loop.  Clearly we can't do that every
time.

(So, my code was wrong, it should have been:


	if (fl->fl_lops->fl_expire_lock(fl, 1)) {
		spin_unlock(&ct->flc_lock);
		fl->fl_lops->fl_expire_locks(fl, 0);
		goto retry;
	}

)

But the 1 and 0 cases are starting to look pretty different; maybe they
should be two different callbacks.

--b.
