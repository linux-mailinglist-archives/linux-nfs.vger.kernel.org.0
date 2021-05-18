Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99A1387E90
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbhERRhK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbhERRhJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:37:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD727C061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:35:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 31DB46482; Tue, 18 May 2021 13:35:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 31DB46482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621359351;
        bh=4vi7TGcSWHc36ouP2jLojiKPOiXNeeV1MpskNXM7weI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDLjdpaxo4nsSZZckaBJSZPbYM1KSG15d/rpkrYMVh8ObEGHO7mxKPidwT8wunw3F
         ZanC5b/8gQ7n9218AgIEx/alyVIwxZUrpVOVpX+7iZqJ76N2nQp+QbgzlBZ2b8tnYd
         2aFo2CLGZdUXWaGSKnNjpD7CiQdaQNnD0iFbqAQQ=
Date:   Tue, 18 May 2021 13:35:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Message-ID: <20210518173551.GA26957@fieldses.org>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
 <20210518172334.GC25205@fieldses.org>
 <CAN-5tyG2pcduQAWJDaP83VgqK7QfsnoDZJe-JG=Oqdgj4PjSUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyG2pcduQAWJDaP83VgqK7QfsnoDZJe-JG=Oqdgj4PjSUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 01:31:11PM -0400, Olga Kornievskaia wrote:
> On Tue, May 18, 2021 at 1:23 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Tue, May 18, 2021 at 01:16:56PM -0400, Olga Kornievskaia wrote:
> > > General question to maybe Bruce: can nfsd_net go away while a compound
> > > is using it ?
> >
> > No.  Any server threads for that container should be shut down before
> > nfsd_net goes away.
> 
> Right, sorry but the async copy is a task that works after the
> compound of copy.

OK, I thought you were talking about normal compound processing from
server threads.

> You say "threads .. should be shut down", who makes
> sure of that (meaning should async copy code make sure of it)?

Just looking at the code... nfsd4_shutdown_copy() is called when a
client is destroyed to stop any in-progress copies.

--b.
