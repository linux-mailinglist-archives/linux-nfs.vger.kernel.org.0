Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FA248E6A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRTEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRTEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 15:04:52 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81129C061389
        for <linux-nfs@vger.kernel.org>; Tue, 18 Aug 2020 12:04:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 515B9ABC; Tue, 18 Aug 2020 15:04:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 515B9ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597777491;
        bh=ZFtCQZlHoXmAnqDDOiC8FvvxKRV/AZ7aIXSI/ewiG7Y=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=BdVbp1436/A6MMyzJKIqklZnOdjoR+h17SooaAgmBX/Vk56ytddfI60gKCiH0aqSz
         w+aVZc0so+7SISIWBoQcSThPPPV2LgVd7rjkcBJwPs0/9lju9ovIxq+p2GTOsaBo4W
         EfF5+KccRPexIv9Z2R7aDjPDLT7qQ2Ndrxu8TW5s=
Date:   Tue, 18 Aug 2020 15:04:51 -0400
To:     NFS Traumatized Linux User <nfstrauma@busy-byte.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: CentOS 8 + Kerberized NFS homes / AutoFS -> can't get this to
 run properly, many actions heavily delayed, freq. mouse/kbd freezes -> NFS
 issue?
Message-ID: <20200818190451.GA6766@fieldses.org>
References: <f68660cb18742f7dfdd8a796a610329d@webmail.busy-byte.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68660cb18742f7dfdd8a796a610329d@webmail.busy-byte.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 12, 2020 at 10:05:08PM +0200, NFS Traumatized Linux User wrote:
> I export the home directories on the NFS server to the local network
> (rw,sec=krb5p,root_squash,async,subtree_check) and configured autofs

Unrelated to your problem, but I wouldn't recommend "async".

Like Ben I'd start by watching the traffic in wireshark.

--b.
