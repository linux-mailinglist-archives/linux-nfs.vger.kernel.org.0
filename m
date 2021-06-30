Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3C3B882D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhF3SKz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhF3SKy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 14:10:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD20BC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 11:08:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 44CB56C07; Wed, 30 Jun 2021 14:08:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 44CB56C07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625076504;
        bh=ENwBHGTlXFV/KwOpGJpiR4dA/TpaBbXgtvlFSGBFyrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DK9O+6zHZH5jh3H0xJDAEFRIFTqIV1d5jGXE6y0bw6thQSDdsk2xRMLpTcvHHX+LZ
         REuQ8x1LDH0fFuR4b7eXK8iTPXnm7tJIwlFDzZQRo+vanBRK4E+lROCyuBrJyR1Wh6
         yzBeRP5KAqnA+gzsC92uvsqE6s7kPsYDxp7a/fDM=
Date:   Wed, 30 Jun 2021 14:08:24 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: 5.13 NFSD: completely broken?
Message-ID: <20210630180824.GF20229@fieldses.org>
References: <20210630155325.GD22278@shell.armlinux.org.uk>
 <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
 <20210630160542.GD20229@fieldses.org>
 <EEA82A83-433C-49C2-BD70-BBAE98961705@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEA82A83-433C-49C2-BD70-BBAE98961705@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 04:28:47PM +0000, Chuck Lever III wrote:
> The problem was discovered by static analysis, not a
> crash report. IMO the fix should have waited for testing
> and review by the NFS community. This close to a final
> release, the fixes for the array overrun and page leak
> could have gone into v5.13.1. I hope automation will
> take care of all of this very soon.

Years ago I had a cron job that fetched a few trees and ran cron jobs on
them nightly.  "Automatic" testing always ends up requiring more manual
intervention than I expect, but maybe I should give that another
shot....

--b.
