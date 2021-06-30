Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC023B8731
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhF3QnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3QnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 12:43:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85252C061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8kXPXG2xiR6ni4t5rnCrnkFi9LBp8OSUrx6cmxnUYPs=; b=jW1KbQyUNA9+ZyQF1SjIucxz0
        5GJIYucMwTAoReHvEfP6pNZGUvpCe58AOvVqHEJy8xkyplW+W7QVH3IEPeMgFLafN+urEAyMX78MR
        mr/GWxugAdFKViDNxxy8n1gPmk/yd4jqCcedw7b9AKmx5WXgYhcZXmj6cV4yKPzSWx3Hvmbe0zGKN
        Ae1nlT5bOVqC5MVd6qd1UXx6An5YGxpMTNaOjOgacl0d6AJuUGSwKyT8Le9vViUIGcJjr7Uh87DLH
        rXnpoo8BGvEaxDQyEB3XgOwZdfNsfKuMh/6dRHw5BdV8jEpMYaTV4ADnXbKuN9P7kSi1OXC4VXjq1
        Xel6Wqb9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45528)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lydGQ-0000QD-KZ; Wed, 30 Jun 2021 17:40:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lydGP-0003Gh-Sw; Wed, 30 Jun 2021 17:40:37 +0100
Date:   Wed, 30 Jun 2021 17:40:37 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: 5.13 NFSD: completely broken?
Message-ID: <20210630164037.GE22278@shell.armlinux.org.uk>
References: <20210630155325.GD22278@shell.armlinux.org.uk>
 <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 03:55:16PM +0000, Chuck Lever III wrote:
> > On Jun 30, 2021, at 11:53 AM, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > 
> > Hi,
> > 
> > I've just upgraded my ARM32 VMs to 5.13, and I'm seeing some really odd
> > behaviour with NFS exports that are mounted on a debian stable x86
> > machine.  Here's an example packet dump:
...
> > Has 5.13 been tested with nfsv3 ?
> > 
> > Any ideas what's going on?
> 
> Yes, fortunately!
> 
> Have a look at commit 66d9282523b for a one-liner fix, it should apply
> cleanly to v5.13.

Thanks Chuck, that resolves the issue for me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
