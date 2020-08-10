Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4D24116A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJUKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHJUKD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 16:10:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23733C061756
        for <linux-nfs@vger.kernel.org>; Mon, 10 Aug 2020 13:10:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6DB4C3C20; Mon, 10 Aug 2020 16:10:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6DB4C3C20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597090201;
        bh=BqD9WGK9PCOHEu1GAC1aMnPmz2OkBVttHt2uvXMj5RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPpE0ZI6/4YvHMAmYZnXrFU1wePsSowyBrZ/eEG9AyXyqG3kgjBkRgk/Q6Bg54IGA
         PCS8BJkFJ3smk06gXu7rCH84uOgl4Qcb+M9Q9WQj2kEPw4j9fpOr9HM0AlU13bmCEB
         qD4sPkL6UIMqUoCI8AR9FgxrfEdmTfSPpNH2aTz4=
Date:   Mon, 10 Aug 2020 16:10:01 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200810201001.GC13266@fieldses.org>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org>
 <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 10, 2020 at 04:01:00PM -0400, Chuck Lever wrote:
> Roughly the same result with this patch as with the first one. The
> first one is a little better. Plus, I think the Solaris NFS server
> hands out write delegations on v4.0, and I haven't heard of a
> significant issue there. It's heuristics may be different, though.
> 
> So, it might be that NFSv4.0 has always run significantly slower. I
> will have to try a v5.4 or older server to see.

Oh, OK, I was assuming this was a regression.

> Also, instead of timing, I should count forward channel RPCs and
> callbacks, or perhaps the number of DELAY responses.

Thanks for looking into this!

--b.
