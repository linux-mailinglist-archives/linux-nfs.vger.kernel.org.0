Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877449B59C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385744AbiAYODL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 09:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377618AbiAYOAI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 09:00:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601ECC06175F
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 06:00:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 887AFAA2; Tue, 25 Jan 2022 08:59:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 887AFAA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643119199;
        bh=wJYCTI1cNAvb6V/2HzymzKxCbRQvolrwzqNItLNYiKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ijxh+/FHh0pWJCA7g+sMtK0VQZqYKVDMVOGdl1OPCViipaqrr3yxx6zlXBlbbr5Te
         q456YussCnQe6+rBhZ+u+T5R0VYfA4oRn9BFCVwJBHf9fNVbQRgKvVHI04ttjkv6q2
         5Zpo43+CWY7+KPQscfC8HSWfjQITrCAWJvygsC+8=
Date:   Tue, 25 Jan 2022 08:59:59 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220125135959.GA15537@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
> Yea, it does seem like the server is the ultimate arbitrar and the
> fact that multiple clients can achieve much higher rates of
> parallelism does suggest that the VFS locking per client is somewhat
> redundant and limiting (in this super niche case).

It doesn't seem *so* weird to have a server with fast storage a long
round-trip time away, in which case the client-side operation could take
several orders of magnitude longer than the server.

Though even if the client locking wasn't a factor, you might still have
to do some work to take advantage of that.  (E.g. if your workload is
just a single "untar"--it still waits for one create before doing the
next one).

--b.
