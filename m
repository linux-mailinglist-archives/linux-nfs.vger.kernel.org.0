Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F720257E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgFTRDW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 13:03:22 -0400
Received: from fieldses.org ([173.255.197.46]:33014 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgFTRDW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 20 Jun 2020 13:03:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id DB2E59236; Sat, 20 Jun 2020 13:03:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DB2E59236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592672596;
        bh=UHoeTsyxG3LCrObRyerSUSvZXTADsRjTk02dnucLK6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppP3Ef4B1cd4mw4FHdcQrolHyn//SMUtebZalhuOpeahhPSUqQ3wlCWIOxCqWOBNP
         /tkfYRwiL1aFe+EjeQD4e27sRgLbyGHcxd03pWtJVC2vQuglfDENTnIDyCRTXchhbE
         JLsrMZBqtepjl1rmPao2J9wAjUKcp+tdgipj8MYg=
Date:   Sat, 20 Jun 2020 13:03:16 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: RPC Pipefs: Frequent parsing errors in client database
Message-ID: <20200620170316.GH1514@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 20, 2020 at 11:35:56AM +0000, Kraus, Sebastian wrote:
> In consequence, about a week ago, I decided to investigate the problem
> in a deep manner by stracing the rpc.gssd daemon while running.  Since
> then, the segementation violations were gone, but now lots of
> complaints of the following type appear in the system log:
> 
>  Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open
>  nfsd4_cb/clnt3bb/info: No such file or directory Jun 19 11:14:00 all
>  rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3bb/info
> 
> 
> This behaviour seems somehow strange to me.  But, one possible
> explanation could be: The execution speed of rpc.gssd slows down while
> being straced and the "true" reason for the segmentation violations
> pops up.  I would argue, rpc.gssd trying to parse non-existing files
> points anyway to an insane and defective behaviour of the RPC GSS user
> space daemon implementation.

Those files under rpc_pipefs come and go.  rpc.gssd monitors directories
under rpc_pipefs to learn about changes, and then tries to parse the
files under any new directories.

The thing is, if rpc.gssd is a little fast, I think it's possible that
it could get the notification about clnt3bb/ being created, and try to
look up "info", before "info" itself is actually created.

Or alternatively, if clnt3bb/ is short-lived, it might not look up
"info" until the directory's already been deleted again.

Neither problem should be fatal--rpc.gssd will get another update and
adjust to the new situation soon enough.

So it may be that the reall error here is an unconditional log message
in a case that's expected, not actually an error.

Or I could be wrong and maybe something else is happening.

But I think it'd be more useful to stay focused on the segfaults.

--b.
