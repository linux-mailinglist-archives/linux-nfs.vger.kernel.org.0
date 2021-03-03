Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401132C6BC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhCDA34 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390256AbhCCWCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 17:02:00 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6EC0613DB
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 14:01:16 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 96E1135DC; Wed,  3 Mar 2021 17:01:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 96E1135DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614808875;
        bh=YxY7BWjFzN6yGXi44CnJ6vfTbdcgVfhuu8G5kKVZmac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEaT0NvZOSDsTdYXf0ZQ9VHBSpJiEk60aOHae7V5bhVCx5mp2eTa16kw2a7JK/FOV
         FRfy+EPPFqzqCI4EkMvv6bkGV5Ib++fX3U+s/HQDo528lpviYHAaD1/uVkTfEkgX+v
         p2m1ZGK6u4KlGUM+8MbHVKuKjiXgwg7I2WvtQmRI=
Date:   Wed, 3 Mar 2021 17:01:15 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: helper for laundromat expiry calculations
Message-ID: <20210303220115.GG3949@fieldses.org>
References: <20210302154623.GA2263@fieldses.org>
 <AC0F5679-8B32-4D75-B28B-67171027B70D@oracle.com>
 <20210303215515.GF3949@fieldses.org>
 <63E16B3E-2524-4257-BB70-F685330554F3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63E16B3E-2524-4257-BB70-F685330554F3@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 03, 2021 at 09:59:48PM +0000, Chuck Lever wrote:
> 
> 
> > On Mar 3, 2021, at 4:55 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Mar 03, 2021 at 09:35:18PM +0000, Chuck Lever wrote:
> >> 
> >> 
> >>> On Mar 2, 2021, at 10:46 AM, Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> From: "J. Bruce Fields" <bfields@redhat.com>
> >>> 
> >>> We do this same logic repeatedly, and it's easy to get the sense of the
> >>> comparison wrong.
> >>> 
> >>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >>> ---
> >>> fs/nfsd/nfs4state.c | 49 +++++++++++++++++++++++++--------------------
> >>> 1 file changed, 27 insertions(+), 22 deletions(-)
> >>> 
> >>> My original version of this patch... actually got the sense of the
> >>> comparison wrong!
> >>> 
> >>> Now actually tested.
> >>> 
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index 61552e89bd89..8e6938902b49 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
> >>> 	return true;
> >>> }
> >>> 
> >>> +struct laundry_time {
> >>> +	time64_t cutoff;
> >>> +	time64_t new_timeo;
> >>> +};
> >>> +
> >>> +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
> >>> +{
> >>> +	time64_t time_remaining;
> >>> +
> >>> +	if (last_refresh < lt->cutoff)
> >>> +		return true;
> >>> +	time_remaining = last_refresh - lt->cutoff;
> >>> +	lt->new_timeo = min(lt->new_timeo, time_remaining);
> >>> +	return false;
> >>> +}
> >>> +
> >> 
> >> /home/cel/src/linux/linux/fs/nfsd/nfs4state.c:5371:6: warning: no previous prototype for ‘state_expired’ [-Wmissing-prototypes]
> >> 5371 | bool state_expired(struct laundry_time *lt, time64_t last_refresh)
> >>      |      ^~~~~~~~~~~~~
> >> 
> >> Should this new helper be static, or instead perhaps these items
> >> should be defined in a header file.
> > 
> > Whoops, should have been static, yes, do you want to fix it up or should
> > I resend?
> 
> I've corrected it in the for-next topic branch in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Thank you!

--b.
