Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89B228350
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jul 2020 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgGUPOU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jul 2020 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgGUPOT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jul 2020 11:14:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA8C061794
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jul 2020 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3zmi5bZC7KrJcoI9j/XuatFI8VhMfbgZYpubyNYqZP8=; b=tRaTWoQinQH1O2pREmbQu9Svn
        I+XlS9i1vL3UizYE9PSGEFiQJHSe6o6KWQVRl1TAPsChseO1lv/57SoZ13Rv5Hoa7vt6DEPx4XWdL
        YF+c8s3Ss8MHPlbhgRrAVz82nUMDh0auOBtE+wv3GlLG9AbYTeSaZ/7Dsa9q8BQIV5/fPvvBrhctw
        8e9vF5FBudlJSebsaDAndm/jqfBaoHWjr+RzqAIz68cYcODOSx+c17d+sgUE0Ov/RnUHV7F3I+mva
        w+wWgcOl3UIFLKfiUC9NIFwaZ8y/P3NxZZSUDIRnKOGVn8NrdptLJsmp7QmmFnLCrcViHkJ8dbHER
        pZ3+W/bhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42360)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jxtyE-0004Tb-Am; Tue, 21 Jul 2020 16:14:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jxtyE-00066B-0b; Tue, 21 Jul 2020 16:14:18 +0100
Date:   Tue, 21 Jul 2020 16:14:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: rmk build: 54 warnings 0 failures
 (rmk/v5.8-rc3-11-g48b8eed3a337d)
Message-ID: <20200721151417.GU1605@shell.armlinux.org.uk>
References: <5f16fd81.1c69fb81.6bf0b.4e31@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f16fd81.1c69fb81.6bf0b.4e31@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A build of my tree by Olof's autobuilder revealed a problem concerning
a couple of platforms - this is based on v5.8-rc3:

On Tue, Jul 21, 2020 at 07:36:48AM -0700, Olof's autobuilder wrote:
> 	arm.mps2_defconfig:
> net/sunrpc/svcsock.c:226:5: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Wundef]
> 
> 	arm.xcep_defconfig:
> net/sunrpc/svcsock.c:226:5: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Wundef]
> net/sunrpc/svcsock.c:226:5: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Wundef]

The issue is that as the #if concerned is used to determine whether
code that calls flush_dcache_page() (and therefore ensures data
integrity) is omitted - and in the above cases it will be omitted.

On ARM, we define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE to 1 in
asm/cacheflush.h, but for some reason, it seems that
net/sunrpc/svcsock.c is not seeing that.

Maybe net/sunrpc/svcsock.c needs to include asm/cacheflush.h to
ensure it picks up the definition of this preprocessor symbol?

It looks like this was introduced by:

commit ca07eda33e01eafa7a26ec06974f7eacee6a89c8
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Wed May 20 17:30:12 2020 -0400

    SUNRPC: Refactor svc_recvfrom()

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
