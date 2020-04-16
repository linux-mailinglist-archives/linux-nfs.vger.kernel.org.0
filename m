Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDF1AB8C9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 08:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437275AbgDPGyb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437468AbgDPGy1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 02:54:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536CDC061A0C;
        Wed, 15 Apr 2020 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PhktM7xkiFtBGJ6dx8UYLKoYK1Fp1IPWa9qQEpZldmY=; b=qUXYZs7ybgSXUPkdc9bshfC+TP
        YyTj+O9gfG0xSQUFcPVmDbSivTYGU6T8/JuO8e+CniEHH5g4brZ+JIjPGkHNQ1Qgd9FQuMnHRH9DA
        pYH8fUNhGvOZjF3ofrnhGaElg7f6EIZCxYZ7ErJZHnaKVw1IhmGBjHgHu9iYquVmRmQq3Z1R2CDwX
        8jyvhp/HLmJlwW8wPJnyfCNCsNlth/WA6d2FKQ0szNVS+hZYuffh7eyhNWbHofsN5HjZc+KXsnQj5
        hphNYzS+rYK+nICKfsydWgXQr87HpsubyYPPTg9E5LA0ddCCMxD5mqZ3UUxLFLm3cEFXcundK/gP2
        +gLPWsqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyPi-00010l-Cc; Thu, 16 Apr 2020 06:54:18 +0000
Date:   Wed, 15 Apr 2020 23:54:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with
 PF_LOCAL_THROTTLE
Message-ID: <20200416065418.GA1092@infradead.org>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87wo6gs26e.fsf@notabene.neil.brown.name>
 <87tv1ks24t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv1ks24t.fsf@notabene.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> +		if (current->flags & PF_LOCAL_THROTTLE)
> +			/* This task must only be throttled based on the bdi
> +			 * it is writing to - dirty pages for other bdis might
> +			 * be pages this task is trying to write out.  So it
> +			 * gets a free pass unless both global and local
> +			 * thresholds are exceeded.  i.e unless
> +			 * "dirty_exceeded".
> +			 */

This is not our normal multi-line comment style.  The first line should
be just a

			/*

Otherwise this looks good.
