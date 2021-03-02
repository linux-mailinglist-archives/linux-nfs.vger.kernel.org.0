Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91232A94C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575176AbhCBSTj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhCBEHs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 23:07:48 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA08C061793
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 20:05:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DD27B35BD; Mon,  1 Mar 2021 23:05:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DD27B35BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614657904;
        bh=85RRx5mVG3elM+B+GkQHiiYDNyGquySwb/exq6Q9OFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj3eA4RsqRnO+hXOL1CwZQwj2CbE0fOfL70kIT0Tmxg0EA4nYGUg/Yd7OoAmCSzjF
         BPSGLypXv1mY7hl5M7okRwSGR4278Hl8F1m97wNdWvlXlszHGL3GxBvbgz6ol964BG
         sJtGmLxh1opREFFTSdCfFpR30u/RjLK8yDsJaANg=
Date:   Mon, 1 Mar 2021 23:05:04 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Message-ID: <20210302040504.GD16303@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <871rcyi5ae.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rcyi5ae.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 02:49:13PM +1100, NeilBrown wrote:
> I'll see how easy it is to add "client added" and "client removed" log
> messages to mountd before resending my series.

OK, thanks again for doing this!

Also if there's more information we could add to those "info" files to
make it easier to correlate with the authentication upcalls, that should
be easy to do....

--b.
