Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B362F25835D
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgHaVRP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgHaVRP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 17:17:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7346C061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 14:17:14 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 75DF01BE4; Mon, 31 Aug 2020 17:17:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 75DF01BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598908633;
        bh=7/mOKabO92JwpysyXAQb87zpDDGkDmIAYaXf5vpe8wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMOPtdb3Y+p23NHOjDEw8cDTipMim17yzmYEx5DnkRB8m9dhg5GYn+b2lSulMQcTn
         9xJot37nzhJOgE+CTFhELz9nMUETvyEKR9Eiotjrkx1akj+uLMrdaodXURA6tpg/Gd
         ROo1REplTYf9p9DvZ2Ngg7rUkeRRMqEKOomM1db0=
Date:   Mon, 31 Aug 2020 17:17:13 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [bfields@home.fieldses.org: all 6970bc51 SUNRPC/NFSD: Implement
 xdr_reserve_space_vec() results]
Message-ID: <20200831211713.GD19571@fieldses.org>
References: <20200831190218.GA19571@fieldses.org>
 <20200831193109.GA9497@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200831204027.GB19571@fieldses.org>
 <20200831205206.GA18488@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831205206.GA18488@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 08:52:06PM +0000, Frank van der Linden wrote:
> Yep - I think I've fixed the issues in xfstests I listed there. I just
> need to re-run the tests, and not just for NFS. I'll do runs for xfs, ext4
> and NFS. If everything looks ok, I'll send the changes in, they're pretty
> simple.

Great, thanks.--b.
