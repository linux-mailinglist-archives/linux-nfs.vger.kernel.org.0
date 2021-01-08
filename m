Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF22EF706
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbhAHSIw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 13:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAHSIv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jan 2021 13:08:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53FC061380
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jan 2021 10:08:11 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D06D26EEC; Fri,  8 Jan 2021 13:08:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D06D26EEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610129290;
        bh=5Im3bgmhSNF5hjc4+3bwmlqosV1VSJQfvJ8j6NPzti8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdO/VYR0MWTK0tpc/tP3qYq04GJJtt5WdxDHnlf/PdiUKJDfrd6HKCmCUJEBANxNf
         1USWyrCST3hfHvd77dnlcXvnMmrTZEmZVP9QCVWRMzVfHR09a9eZyu49i4bIyVyVEE
         ibdYTMgYLVAzeas6um5pxHlt71AGeRtdgW/CtEhU=
Date:   Fri, 8 Jan 2021 13:08:10 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Message-ID: <20210108180810.GA10654@fieldses.org>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
 <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
 <20210108155209.GC4183@fieldses.org>
 <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
 <20210108160145.GD4183@fieldses.org>
 <cf8329455c84c2efb76e3824b1639889ea22d716.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8329455c84c2efb76e3824b1639889ea22d716.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 08, 2021 at 04:35:50PM +0000, Trond Myklebust wrote:
> Just ignore generic/465. As far as NFS is concerned, the test has
> utterly borked assumptions about O_DIRECT ordering.

Thanks, adding to my list of tests to skip.  Should we report it as an
xfstests bug?

(Is the test just wrong, or is this some non-standard but documented NFS
behavior, or something else?)

--b.
