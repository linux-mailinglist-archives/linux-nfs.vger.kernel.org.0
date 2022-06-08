Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7B543913
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiFHQcT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jun 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiFHQcG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jun 2022 12:32:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ACF2C2783
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jun 2022 09:31:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 64770712B; Wed,  8 Jun 2022 12:31:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 64770712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1654705890;
        bh=8S3HTXBWO3QW//HmwJ7oUwEBQgX4Pv2PumuMSl+vvbA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=LbrbvurTIa+tmT7Yo6bpj112Dcxuu+tI9QFLfbPuX/hX+98tzC8kMfkL69z6s6X9L
         /6ctAZyeaPKrbAmJsNJA1ZPLy+x/xY37ACd9M/SNbcKIeTlvgjZP/LDOaNCpx+XhWw
         Pa+MfYCd43s0iMqB/sC2m0Ghg6XKARUWxMYPPTaY=
Date:   Wed, 8 Jun 2022 12:31:30 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        anna.schumaker@netapp.com
Subject: Re: [PATCH v2 0/5] Fix NFSv3 READDIRPLUS failures
Message-ID: <20220608163130.GB16378@fieldses.org>
References: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good.  Feel free to add my reviewed-by:.

Do we have a test that reads a large enough directory?  Seems like that
plus the right kernel debugging options should have caught the original
bug.

--b.

On Tue, Jun 07, 2022 at 04:47:45PM -0400, Chuck Lever wrote:
> NFSD's new READDIRPLUS dirent encoder blows past the end of the
> directory payload xdr_stream when the client requests more than a
> page worth of directory entries. I tracked this down to how
> xdr_get_next_encode_buffer() computes xdr->end. First patch in this
> series is the fix. The remaining patches are clean-ups and
> optimizations.
> 
> I want to get this series into 5.19-rc quickly. I would appreciate
> getting one more R-b for this series, preferrably from one of the
> NFS client maintainers.
> 
> 
> Changes since v1:
> - Adjusted patch 2/5 per Neil Brown's suggestion
> - Series applied to my NFS client and tested there
> 
> ---
> 
> Chuck Lever (5):
>       SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()
>       SUNRPC: Optimize xdr_reserve_space()
>       SUNRPC: Clean up xdr_commit_encode()
>       SUNRPC: Clean up xdr_get_next_encode_buffer()
>       SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer()
> 
> 
>  include/linux/sunrpc/xdr.h | 16 +++++++++++++++-
>  net/sunrpc/xdr.c           | 37 +++++++++++++++++++++++--------------
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> --
> Chuck Lever
