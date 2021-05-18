Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8623387E53
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351107AbhERRYy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbhERRYy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:24:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23AC061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 10:23:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4B4D6482; Tue, 18 May 2021 13:23:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4B4D6482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621358614;
        bh=xw3zkfTmJSq06+BKPK2yIBllLVpzHnFcO1l6/tZtCGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN7UP9/q/NOVWEz1FGSFW38LMEFJZePOk3Rm7lKphYovEJaqWJeGmJDwd4B3smgHm
         6sGDyFvmuzwlAvW074ZV5V8tBn6y4ydGgw20aLCF07wrqy4I3ioMOPMXeO7u3CAwZa
         Zuo6MHgsmTtoBpltkzx1BT8CiVh0DsmgxoFTdXjQ=
Date:   Tue, 18 May 2021 13:23:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
Message-ID: <20210518172334.GC25205@fieldses.org>
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGYhmy_dgKV_7xuPFJjyY_wsjDcun_TrDK_vidmVG1ZXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 01:16:56PM -0400, Olga Kornievskaia wrote:
> General question to maybe Bruce: can nfsd_net go away while a compound
> is using it ?

No.  Any server threads for that container should be shut down before
nfsd_net goes away.

--b.
