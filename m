Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B695F41F376
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhJARqP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJARqO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 13:46:14 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A3C061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 10:44:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id AAAF025FE; Fri,  1 Oct 2021 13:44:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AAAF025FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633110269;
        bh=tdALyq3Tow+7WVyPTknRplVuJQaoNXhs2uW+a9Z+CPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOf0A4QMCg8Mq8M39oCUvPnQ/q/e7A+jsgo1O0LEUdSW/8Enq2gzsOeijWlaiVw5+
         f8W0ZlTTmZu+XDRjHZTxyohs9ng22NA1YaCAQ7J3VCAMP0YDjzHn4oYcPrwedwfR0P
         b+ZcNVr8njDZQV/kOeaBg2do8j7ORUEybsomiY1c=
Date:   Fri, 1 Oct 2021 13:44:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daniel Kobras <kobras@puzzle-itc.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Volodymyr Khomenko <volodymyr@vastdata.com>
Subject: Re: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Message-ID: <20211001174429.GH959@fieldses.org>
References: <20211001135921.GC959@fieldses.org>
 <31738001-8f5b-61c9-67b6-810e6f188318@puzzle-itc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31738001-8f5b-61c9-67b6-810e6f188318@puzzle-itc.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 01, 2021 at 06:50:12PM +0200, Daniel Kobras wrote:
> Hi Bruce!
> 
> Am 01.10.21 um 15:59 schrieb J. Bruce Fields:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > If sd_max is unsigned, then sd_max - GSS_SEQ_WIN is a very large number
> > whenever sd_max is less than GSS_SEQ_WIN, and the comparison:
> > 
> > 	seq_num <= sd->sd_max - GSS_SEQ_WIN
> > 
> > in gss_check_seq_num is pretty much always true, even when that's
> > clearly not what was intended.
> > 
> > This was causing pynfs to hang when using krb5, because pynfs uses zero
> > as the initial gss sequence number.  That's perfectly legal, but this
> > logic error causes knfsd to drop the rpc in that case.  Out-of-order
> > sequence IDs in the first GSS_SEQ_WIN (128) calls will also cause this.
> > 
> > Fixes: 10b9d99a3dbb ("SUNRPC: Augment server-side rpcgss tracepoints")
> 
> I wonder about the Fixes tag: That changeset added tracepoints to the
> exit path, but the buggy logic seems to have been present since the
> pre-git ages. Or am I missing something about 10b9d99a3dbb?

The relevant parts of 10b9d99a3dbb were:

 struct gss_svc_seq_data {
        /* highest seq number seen so far: */
-       int                     sd_max;
+       u32                     sd_max;

and

-gss_check_seq_num(struct rsc *rsci, int seq_num)
+static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
+                             u32 seq_num)

Together, they mean the comparison

	seq_num <= sd->sd_max - GSS_SEQ_WIN

in the case sd_max is zero, effectively ends up being

	seq_num <= 4294967168

instead of what was intended,

	seq_num <= -128

.

> (This might explain some reports of--as you stated elsewhere--"once in
> a blue moon my krb5 mounts hang" we've investigated, albeit on kernels
> that predate 10b9d99a3dbb.)

Sounds like it was something else, I'm afraid!

--b.
