Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99E03B6837
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhF1SVQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhF1SVN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 14:21:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B2C061574
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNNNgeDK9vrSkvO77tVgzXeNExzgN8gRgCBdSERbBU4=; b=sTrsocwSO1Mb71e3dDBdebKoDk
        7WmCRYe3gNqKQohNm4bRDhzyjXhujYsu0ONzppYo9Do4JV6yfsMuX9arn+KsEm3UgF7tX0WOEMjp9
        FBvbNfe7q+HdNd99KYqfLx00itJQ9kSKBfXsbBPKVnq8V9Owr41zIQxz02k3qjcqOv+AOCP8Fxqgg
        Iw+SBnY5+dQls2WoNWPcdcrRJ1DXYr6v1u/uARdMlBuJrRAVXgcxpotVt974aMWgV3V1tVwTnNHfD
        IOoLVlrF43uKngmbBog+e5jgG1OLI3lTS31j65rxUwTTylqEs6jR2jqGizbQ2ByA7DkGv5RgXDxG4
        MpExFxUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxvox-003KIY-Pb; Mon, 28 Jun 2021 18:17:43 +0000
Date:   Mon, 28 Jun 2021 19:17:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     mgorman@techsingularity.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page_alloc: Return nr_populated when the array is
 full
Message-ID: <YNoSM1A/tS4SEMHE@casper.infradead.org>
References: <162490397938.1485.7782934829743772831.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162490397938.1485.7782934829743772831.stgit@klimt.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 02:12:59PM -0400, Chuck Lever wrote:
> The SUNRPC consumer of __alloc_bulk_pages() legitimately calls it
> with a full array sometimes. In that case, the correct return code,
> according to the API contract, is to return the number of pages
> already in the array/list.
> 
> Let's clean up the return logic to make it clear that the returned
> value is always the total number of pages in the array/list, not the
> number of pages that were allocated during this call.

This is more complicated than either v1 or the version that Mel sent
earlier today.  Is it worth it?
