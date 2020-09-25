Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64E2790D2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgIYShS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbgIYShS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 14:37:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC7C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 11:37:18 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C2843C53; Fri, 25 Sep 2020 14:37:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C2843C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601059037;
        bh=4ypnk2L9GtQCRjz8oQoCH50OnazdloD5k9cMitwrBD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geeXbAJ8HptHP//PLVyv/zdIF7GGtOgqfU9WRbQ9Lest8rGbaNDB9r9aKt7N3T7ML
         d0tHgdlGBDZQ4sd2rQpPGQ0WPjMHB/4K6dKVeFaayGKeWs6LNayqa/rNZfaYA7g4Y+
         Wx/cZbkdWEdoKK9UwbBBRq/k883XknZDNtwjFE/k=
Date:   Fri, 25 Sep 2020 14:37:17 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
Message-ID: <20200925183717.GG1096@fieldses.org>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
 <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
 <20200925143218.GD1096@fieldses.org>
 <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
 <20200925150038.GF1096@fieldses.org>
 <BEF0E50C-A658-4AAA-BCBD-49F442A338B5@oracle.com>
 <551339D6-2109-487D-8279-746BCA106893@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551339D6-2109-487D-8279-746BCA106893@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 25, 2020 at 01:04:55PM -0400, Chuck Lever wrote:
> > On Sep 25, 2020, at 11:05 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >> On Sep 25, 2020, at 11:00 AM, Bruce Fields <bfields@fieldses.org> wrote:
> >> On Fri, Sep 25, 2020 at 10:36:42AM -0400, Chuck Lever wrote:
> >>>> One thing I was wondering about: how would you limit tracing to a single
> >>>> client, say if you wanted to see all DELEGRETURNs from a single client?
> >>>> I guess you'd probably turn on a tracepoint in the receive code, look
> >>>> for your client's IP address, then mask the task id to match later
> >>>> nfs-level tracepoints.  Is there enough information in those tracepoints
> >>>> (including network namespace) to uniquely identify a client?
> >>> 
> >>> Client IP address information is in the RPC layer trace data. The
> >>> DELEGRETURN trace record includes client ID. So maybe not as
> >>> straightforward as it could be.
> >> 
> >> I guess what I meant was "limit tracing to a single network endpoint",
> >> not exactly limt to a single NFSv4 client....  So, we can do that as
> >> long as all the relevant information is in rpc-layer tracepoints, and as
> >> long as task id is a reliable way to match up trace points.
> >> 
> >> Is the network namespace in there anywhere?  It looks like there'd be no
> >> way to distinguish clients in different namespaces if they had the same
> >> address.
> > 
> > The client ID has the boot verifier for the net namespace.
> > 
> > None of this helps NFSv3, though.
> 
> It probably wouldn't be difficult to stuff the client IP address
> and the boot verifier in the trace record for each procedure.
> 
> Do you think that would be sufficient?

Despite using 64 bits the boot verifier isn't even guaranteed to
uniquely identify a network namespace.  There should be something
better.  Digging around....  ns->inum, I think?

I don't know if it (or ports or addresses) needs to be in every trace
record.  Maybe just once somewhere in one of the rpc layer tracepoints,
and then we can use the nfsd task id to connect it with other
tracepoints if necessary.  Does that make sense?

--b.
