Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA949FC62
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348160AbiA1PDh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 10:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbiA1PDf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 10:03:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E54EC061714
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jan 2022 07:03:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5B43C6801; Fri, 28 Jan 2022 10:03:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5B43C6801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643382214;
        bh=nNg02Uu/Q9xr+yqv0U4aSVILKOdLFyDzWORM+NfLER8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rwucTQIpeFtYJbv8ppUXcIILZ5A0jp3HzeSk7ce4yvH3A8faqTNgX+04N28wzJ/pK
         cfsvSbqpz7fFjDuYbaAchTny6hvAOkHsWol1dVFI4EPtil/Los6O7KuaZtLUZv30Ew
         CBa0UKxHqR+J1G5HQxzQgyoxrgBNU2Oq1DQ0aO8A=
Date:   Fri, 28 Jan 2022 10:03:34 -0500
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Message-ID: <20220128150334.GD14908@fieldses.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
 <A933D67A-0C1B-4700-97E7-0DBEF4458A77@oracle.com>
 <164334386787.5493.637178363398104896@noble.neil.brown.name>
 <C462D2BB-BD5B-4372-B644-FD4D6D877072@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C462D2BB-BD5B-4372-B644-FD4D6D877072@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 28, 2022 at 01:46:45PM +0000, Chuck Lever III wrote:
> My initial impulse is to better understand what is preventing
> the unexported filesystem from being unmounted. Better
> observability there could potentially be of value.

In theory that information's in /proc/fs/nfsd/clients/.  Somebody could
write a tool to scan that for state referencing a given filesystem.

--b.
