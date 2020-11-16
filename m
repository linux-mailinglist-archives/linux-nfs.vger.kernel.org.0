Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6A2B507D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 20:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKPTDh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 14:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgKPTDh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 14:03:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D025C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 11:03:37 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D627F1C15; Mon, 16 Nov 2020 14:03:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D627F1C15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605553416;
        bh=JfbSd2O1sEM3qwZk+UW2+IwjzZ7P9kE7lio2owRBezY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmPm1dg4ZehW/CXlPGsSFSTcNe/KSyDV27V8lHy73GwUlrag7/x12pQYchiC8ZRnV
         C0FH5jWKS0oNYDkTJi2uirMTaSeIBnbPRs47TX6a2w4JbHejpDZquICHSN65Ha3BLQ
         W3ZBrdJ8+obDHRqdvKhFXeVt4RdXJvDpRyk91BW4=
Date:   Mon, 16 Nov 2020 14:03:36 -0500
From:   bfields <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201116190336.GH898@fieldses.org>
References: <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
 <20201112205524.GI9243@fieldses.org>
 <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
 <20201113145050.GB1299@fieldses.org>
 <20201113222600.GC1299@fieldses.org>
 <b0d61b4053442ba46fd2c707ee7e0608704c2598.camel@kernel.org>
 <20201116155619.GF898@fieldses.org>
 <83ebb6dc68216ce3f3dfd2a2736b7a301550efc5.camel@kernel.org>
 <20201116161407.GG898@fieldses.org>
 <db55bab87b6fc9dd1594f8c2e853f07b1165ff5d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db55bab87b6fc9dd1594f8c2e853f07b1165ff5d.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 16, 2020 at 11:38:44AM -0500, Jeff Layton wrote:
> Hmm, ok... nfsd4_change_attribute() is called from nfs4 code but also
> nfs3 code as well. The v4 caller (encode_change) only calls it when
> IS_I_VERSION is set, but the v3 callers don't seem to pay attention to
> that.

Weird.  Looking back....  That goes back to the original patch adding
support for ext4's i_version, c654b8a9cba6 "nfsd: support ext4
i_version".

It's in nfs3xdr.c, but the fields it's filling in, fh_pre_change and
fh_post_change, are only used in nfs4xdr.c.  Maybe moving it someplace
else (vfs.c?) would save some confusion.

Anyway, yes, that should be checking SB_I_VERSION too.

> I think the basic issue here is that we're trying to use SB_I_VERSION
> for two different things. Its main purpose is to tell the kernel that
> when it's updating the file times that it should also (possibly)
> increment the i_version counter too. (Some of this is documented in
> include/linux/iversion.h too, fwiw)
> 
> nfsd needs a way to tell whether the field should be consulted at all.
> For that we probably do need a different flag of some sort. Doing it at
> the fstype level seems a bit wrong though -- v2/3 don't have a real
> change attribute and it probably shouldn't be trusted when exporting
> them.

Oops, good point.

I suppose simplest is just another SB_ flag.

--b.
