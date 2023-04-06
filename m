Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC46D9C74
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDFPdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 11:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjDFPdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 11:33:18 -0400
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4910C4
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 08:33:15 -0700 (PDT)
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
        by phd-imap.ethz.ch (Postfix) with ESMTP id 4PslrT3j81z30;
        Thu,  6 Apr 2023 17:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
        s=2023; t=1680795193;
        bh=irUNyor4Vu3vTfZes8C6R31gvUaeyykJeiWbWxtLoLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eR1hDRejBH4jnInZq/kxdWVa4OPCfKY+qVnjsQCS6R1wvynz0fIYmuvZvkkKPDukZ
         XYQ/7EOfhszeMkaFiOgnk9POsHWKHAa9DhO09uiOjqANnIbctVi3IkLpeMxPOkKNte
         8qHdi4i+liIjXhtQ66Ozb5y55gubqNOPDAGHYbNpWdxxzC8CfeuFLXuZYtSI6ydgwe
         +s6Hv2YgHLv/Bm7LlPKMpbG4cC/DnlBVFxZTun3xizdrj3OxJSX7bVr1PV3bOtBVB2
         BQGippXjg3xj8VDvhKOP2NhuSW5PhB0givVhHcdVK7sQf4PX38EQqEdx5Q2P8LiGeU
         DS4snS5cN5H9A==
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
        by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
        with LMTP id vRramUPYqrHA; Thu,  6 Apr 2023 17:33:13 +0200 (CEST)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daduke@phd-mxin.ethz.ch)
        by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4PslrT2qvsz9r;
        Thu,  6 Apr 2023 17:33:13 +0200 (CEST)
Date:   Thu, 6 Apr 2023 17:33:12 +0200
From:   Christian Herzog <herzog@phys.ethz.ch>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Message-ID: <ZC7mOH4I3roIM4xr@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
References: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
 <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Chuck,

> > for our researchers we are running file servers in the hundreds-of-TiB to
> > low-PiB range that export via NFS and SMB. Storage is iSCSI-over-Infiniband
> > LUNs LVM'ed into individual XFS file systems. With Ubuntu 18.04 nearing EOL,
> > we prepared an upgrade to Debian bookworm and tests went well. About a week
> > after one of the upgrades, we ran into the first occurence of our problem: all
> > of a sudden, all nfsds enter the D state and are not recoverable. However, the
> > underlying file systems seem fine and can be read and written to. The only way
> > out appears to be to reboot the server. The only clues are the frozen nfsds
> > and strack traces like
> > 
> > [<0>] rq_qos_wait+0xbc/0x130
> > [<0>] wbt_wait+0xa2/0x110
> 
> Hi Christian, you have a pretty deep storage stack!
> rq_qos_wait is a few layers below NFSD. Jens Axboe
> and linux-block are the folks who maintain that.
are you saying the root cause isn't nfs*, but the file system? That was our
first idea too, but we haven't found any indication that this is the case. The
xfs file systems seem perfectly fine when all nfsds are in D state, and we can
read from them and write to them. If xfs were to block nfs IO, this should
affect other processes too, right?

thanks and Happy Easter,
-Christian

