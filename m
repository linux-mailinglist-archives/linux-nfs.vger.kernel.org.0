Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E422489B98
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiAJOwM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiAJOwM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 09:52:12 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE66C06173F
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 06:52:11 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E7C1D2045; Mon, 10 Jan 2022 09:52:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E7C1D2045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641826330;
        bh=xYWancYGZmlh30s5dJM/sH2+mIqmi33TcKbXN1qyPY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXZHc5hLy94YHsgZETyHzJjPTC5Q5KZYTlt9l4bRUR1NfmYXL1HmkoTmURo/GFl5o
         US+mjFEr4EVtJ8hpadTbWdHzf6RYI+BNhNCFClNM+NU1xPORQapC5XqENfhgOfRMaY
         k0LlduC9EpvPBkK5R+Ox0Kxy0b/5KGP+A/3LFk8Q=
Date:   Mon, 10 Jan 2022 09:52:10 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220110145210.GA18213@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 09:21:44AM +0000, Daire Byrne wrote:
> On Fri, 7 Jan 2022 at 17:17, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > Hm, doesn't each of these use up a reserved port on the client by
> > default?  I forget the details of that.  Does "noresvport" help?
> 
> Yes, I think this might be the issue. It seems like only 13/16
> connections actually initially get setup at mount time and then it
> tries to connect the full 16 once some activity to the mountpoint
> starts. My guess is that we run out of reserved ports at that point
> and continually trigger the BIND_CONN_TO_SESSION.
> 
> I can use noresvport with an NFSv3 client mount and it seems to do the
> right thing (with the server exporting "insecure), but it doesn't seem
> to have any effect on a NFSv4.2 mount (still uses ports <1024). Is
> that expected?

No.  Sounds like something's going wrong.

--b.

> Perhaps NFSv4.2 doesn't allow "insecure" mounts?
> 
> Daire
