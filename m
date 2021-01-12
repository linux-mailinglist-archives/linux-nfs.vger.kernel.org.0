Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73A2F3654
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405446AbhALQ7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 11:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALQ7w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 11:59:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15EC061575
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jan 2021 08:59:12 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 486B41C79; Tue, 12 Jan 2021 11:59:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 486B41C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610470751;
        bh=HR82j2W2ueVZ6ZjPLxUB1jr/QyYoHoPI/tiRC5gXXTU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ovI/qHS3/sPwX6OLaw8C3LL27EmR84a4j6yiNvu/615dYX8q4G5ZhIgZDKQHLMGpN
         vaXeSDRo463PJBJNm2axXPLLnUIXdWpVJO2+fKnQOVCFoW4/PN5hlajyLluFp8dyjE
         1TF93wYH/lTg83T+DPyaOjQhb+tUfhEQd35dodjc=
Date:   Tue, 12 Jan 2021 11:59:11 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: Re: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
Message-ID: <20210112165911.GH9248@fieldses.org>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
 <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE510EA5-1E3F-4516-A948-10A0FF31C94F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 12, 2021 at 08:09:09AM -0500, Chuck Lever wrote:
> Hi Anna-
> 
> > On Jan 11, 2021, at 4:41 PM, schumaker.anna@gmail.com wrote:
> > 
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > It's possible for an NFS server to go down but come back up with a
> > different IP address. These patches provide a way for administrators to
> > handle this issue by providing a new IP address for xprt sockets to
> > connect to.
> > 
> > This is a first draft of the code, so any thoughts or suggestions would
> > be greatly appreciated!
> 
> One implementation question, one future question.
> 
> Would /sys/kernel/net be a little better? or /sys/kernel/sunrpc ?
> 
> Do you have a plan to integrate support for fs_locations to probe
> servers for alternate IP addresses? Would that be a userspace
> utility that would plug values into this new /sys API?

We already have dns resolution for fs_locations, right?  Why can't we
use that here?  Is it that the mount call doesn't give us a host name?
Or we don't trust dns to have the updated IP address for some reason?

--b.

> 
> 
> > Anna
> > 
> > 
> > Anna Schumaker (7):
> >  net: Add a /sys/net directory to sysfs
> >  sunrpc: Create a sunrpc directory under /sys/net/
> >  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
> >  sunrpc: Create per-rpc_clnt sysfs kobjects
> >  sunrpc: Create a per-rpc_clnt file for managing the IP address
> >  sunrpc: Prepare xs_connect() for taking NULL tasks
> >  sunrpc: Connect to a new IP address provided by the user
> > 
> > include/linux/sunrpc/clnt.h |   1 +
> > include/net/sock.h          |   4 +
> > net/socket.c                |   8 ++
> > net/sunrpc/Makefile         |   2 +-
> > net/sunrpc/clnt.c           |   5 ++
> > net/sunrpc/sunrpc_syms.c    |   8 ++
> > net/sunrpc/sysfs.c          | 160 ++++++++++++++++++++++++++++++++++++
> > net/sunrpc/sysfs.h          |  22 +++++
> > net/sunrpc/xprtsock.c       |   3 +-
> > 9 files changed, 211 insertions(+), 2 deletions(-)
> > create mode 100644 net/sunrpc/sysfs.c
> > create mode 100644 net/sunrpc/sysfs.h
> > 
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 
