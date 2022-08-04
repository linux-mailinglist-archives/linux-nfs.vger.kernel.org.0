Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA558A052
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiHDSOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHDSOG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 14:14:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFFD6C100
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 11:14:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2BEBD5FFF; Thu,  4 Aug 2022 14:14:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2BEBD5FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1659636845;
        bh=Khl4jQ2+/6hLuoFEpYHgEgSHDMVmjNkT0+a4U8/ClCE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=YdT5unO2PIAAHiB2keM2JfmHuof6XLs4ZoDYsgiyqgyLV9eVvnqh65hNALjTgCqJq
         /OxP/lMVM5Od4BcEVhdrjcVsOD0TPhhm3Q2LT6lU2L4OgXF+fc2fJw3brYE3Q6XaiD
         76vcTQre6SWT3LHd+bDZnVDT65DWeTUAHkt3NFlU=
Date:   Thu, 4 Aug 2022 14:14:05 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs clean_init issue
Message-ID: <20220804181405.GC9019@fieldses.org>
References: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
 <20220804153816.GB9019@fieldses.org>
 <1C391A45-B2CC-4C90-86DD-1FB9C2000E7E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C391A45-B2CC-4C90-86DD-1FB9C2000E7E@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 04, 2022 at 03:43:56PM +0000, Chuck Lever III wrote:
> It passes, but leaves the test file so that clean_dir does not work
> again until the old lease expires.

Oh, right.

> > But possibly cleanup should also be better.
> 
> This bug might prevent running these tests in an automation harness.
> I'd say cleanup does need to be better about this.
> 
> > I'm not sure what the right fix is.
> 
> Brute force: keep trying to delete that file if clean_dir receives
> NFS4ERR_DELAY?

Delegations block unlinks too so that probably doesn't help.

> init_connection somewhere needs to set up a callback service and
> leave it running.

The callback isn't too important, I think, if we want to return the
delegation at the end of the test we can do that without waiting for the
server to remind us.

Or maybe destroy the client at the end.  We have no DESTROY_CLIENTID
(this is 4.0), but we could do a client-rebooting SETCLIENTID/CONFIRM to
wipe out its state.

There may be limits to the kind of cleanup pynfs can do.  A test harness
should probably reboot the server between test runs.

--b.
