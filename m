Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAEA3A9E3E
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhFPOz6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhFPOz5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 10:55:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE715C061574
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jun 2021 07:53:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C13CD6814; Wed, 16 Jun 2021 10:53:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C13CD6814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623855228;
        bh=4yuCj6PqcGWub0LIdpVYEWQFtC8bouMQmuO50h43pDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcOWfNPdutE18ssq76agd0uWMzJWB2GU7UA7Hpk0cqS+iGboRX5UMzm5JczJbG5gE
         0HNduZMvF5+oQhnFf1s+V3iAhwh5dxMgElpT8Nbqfyuy77E4O9BqX6WTJ9Cz1oVBUw
         zZYi4OZe8NqxZB2zubb+Cwx8IGOzX7q+RNo2/kRU=
Date:   Wed, 16 Jun 2021 10:53:48 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/29] XDR overhaul for server-side lockd
Message-ID: <20210616145348.GB4943@fieldses.org>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This all looks pretty routine, and I'm not seeing any test failure, so,
applying for 5.14.--b.

On Thu, Jun 03, 2021 at 04:50:33PM -0400, Chuck Lever wrote:
> Continuing on with updating the server's XDR infrastructure to use
> struct xdr_stream. This time is lockd's turn.
> 
> ---
> 
> Chuck Lever (29):
>       lockd: Remove stale comments
>       lockd: Create a simplified .vs_dispatch method for NLM requests
>       lockd: Common NLM XDR helpers
>       lockd: Update the NLMv1 void argument decoder to use struct xdr_stream
>       lockd: Update the NLMv1 TEST arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 LOCK arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 CANCEL arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 UNLOCK arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 nlm_res arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 SM_NOTIFY arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 SHARE arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 FREE_ALL arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv1 void results encoder to use struct xdr_stream
>       lockd: Update the NLMv1 TEST results encoder to use struct xdr_stream
>       lockd: Update the NLMv1 nlm_res results encoder to use struct xdr_stream
>       lockd: Update the NLMv1 SHARE results encoder to use struct xdr_stream
>       lockd: Update the NLMv4 void arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 TEST arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 LOCK arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 CANCEL arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 UNLOCK arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 nlm_res arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 SM_NOTIFY arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 SHARE arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 FREE_ALL arguments decoder to use struct xdr_stream
>       lockd: Update the NLMv4 void results encoder to use struct xdr_stream
>       lockd: Update the NLMv4 TEST results encoder to use struct xdr_stream
>       lockd: Update the NLMv4 nlm_res results encoder to use struct xdr_stream
>       lockd: Update the NLMv4 SHARE results encoder to use struct xdr_stream
> 
> 
>  fs/lockd/svc.c             |  43 ++++
>  fs/lockd/svcxdr.h          | 151 ++++++++++++++
>  fs/lockd/xdr.c             | 402 ++++++++++++++++++------------------
>  fs/lockd/xdr4.c            | 403 +++++++++++++++++++------------------
>  include/linux/lockd/xdr.h  |   6 -
>  include/linux/lockd/xdr4.h |   7 +-
>  6 files changed, 610 insertions(+), 402 deletions(-)
>  create mode 100644 fs/lockd/svcxdr.h
> 
> --
> Chuck Lever
