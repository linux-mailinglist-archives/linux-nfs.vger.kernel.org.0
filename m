Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369C8474925
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLNRT5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 12:19:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLNRT4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 12:19:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE3961618
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 17:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C94C34601;
        Tue, 14 Dec 2021 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639502395;
        bh=wB79kmKoiqSz17wWR8cWZHRkz0iq00dC80r9BhtpRmw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LWTQAY8Seg+92OwIGeWmQQX8lz9RJUxiI3x4zHe00+wNRpuHbVGVfrQ3107dGPs5I
         3DDhsnfATAJqcx6AOhANbXzR12M9UONVa4RzbRXe2CYAUgvOs/53TOp0cN1WyTv0da
         afcVH5QQDxr1FaM+FRn2VrNBrwFq0fN0l6XfgCH7T2zJAYX0OpNcgjSsIfmbrlaaxT
         JdZSBtptBVPZz+7Ulz+iu6LMW7DY+Fouk/lCMhn0PvU+s3ocnLA37du/bLW0PIK14V
         Q3qDvbb+9f2P4RHPuFfTvo45g1njndNktM4dpE4kzB0Hls42G7Kr7tCExPBlNRA86i
         KrzaopNHm3CZw==
Message-ID: <03f509d6889856869058e1bfb4d480524489354b.camel@kernel.org>
Subject: Re: [bug report] nfs clients fail to get read delegations after
 file open with O_RDWR
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Date:   Tue, 14 Dec 2021 12:19:54 -0500
In-Reply-To: <20211214164507.GC12078@fieldses.org>
References: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
         <20211213215550.GA2230@fieldses.org>
         <OS3PR01MB770504D572DE88FD1E51BD3689759@OS3PR01MB7705.jpnprd01.prod.outlook.com>
         <20211214164507.GC12078@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-12-14 at 11:45 -0500, J. Bruce Fields wrote:
> On Tue, Dec 14, 2021 at 12:50:53AM +0000, suy.fnst@fujitsu.com wrote:
> > Thanks for your quick reply!
> > 
> > > > Without looking at this case in detail:
> > 
> > > > Delegations are granted at the server's discretion, so this certainly
> > > > isn't a bug.
> > 
> > Got it.
> > 
> > > > It might be suboptimal behavior.  If there's evidence that this causes
> > > > significant regressions on some important workload, then we'd want to
> > > > look into fixing it.
> > 
> > If I understand the case correctly, the most common workload it influences like:
> > 
> > One nfs client opens a file with flag O_WRONLY/O_RDWR, close it.
> > Then some nfs clients open the file with O_RDONLY right now then it will prevent
> > server to give any delegation to other clients.  It may cause many unnecessary
> > requests from clients because lack of delegations.
> 
> Right.
> 
> For the moment, this is something I'd accept patches for, but I'm not
> actively working on.
> 
> I think it's been suggested that we could even turn off the file cache
> completely in the v4 case, since in that case we don't have to re-open
> on every IO.
> 

Is that really desirable behavior? There is the bloom filter in
nfs4state.c too that prevents it from handing out a delegation too soon
after a delegrecall.

The situation above doesn't involve a recall, but it _could_ have if the
timing had been a little different. It's probably worth thinking about
how the rules for this ought to work in all cases.

Should we be treating inodes that experience real delegation recalls
differently from this case?
-- 
Jeff Layton <jlayton@kernel.org>
