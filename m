Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9843E4C60
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhHIStd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHIStd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 14:49:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14EC0613D3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Aug 2021 11:49:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 47B984F7D; Mon,  9 Aug 2021 14:49:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 47B984F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628534951;
        bh=AWHnyw0ogBh07je9QDr/1f1crbyPFWAGCBldI39G0lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8VMCVTS0cuZyXae9kN3XI+ixS0rtdt7soH/WuWVdIPzZ3VaSr9GX+3Wx5v8X7DP3
         amj1MBrA3pBCxnznEEnjstBrQZ6kgZLRGcJglvlcUwD/bZckumQnyHIZ0nEDBO4Nls
         +RN2puO1N8hJSF+67GmhE4BqD7zziB3hXrAiudIc=
Date:   Mon, 9 Aug 2021 14:49:11 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     hedrick@rutgers.edu
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Message-ID: <20210809184911.GD8394@fieldses.org>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com>
 <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
 <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
 <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 09, 2021 at 02:38:33PM -0400, hedrick@rutgers.edu wrote:
> Does setting /proc/sys/fs/leases-enable to 0 work while the system is
> up? I was expecting to see lslocks | grep DELE | wc go down. It’s not.
> It’s staying around 1850.

All it should do is prevent giving out *new* delegations.

Best is to set that sysctl on system startup before nfsd starts.

> > On Aug 9, 2021, at 2:30 PM, Timothy Pearson
> > <tpearson@raptorengineering.com> wrote:
> > 
> > FWIW that's *exactly* what we see.  Eventually, if the server is
> > left alone for enough time, even the login system stops responding
> > -- it's as if the I/O subsystem degrades and eventually blocks
> > entirely.

That's pretty common behavior across a variety of kernel bugs.  So on
its own it doesn't mean the root cause is the same.

--b.
