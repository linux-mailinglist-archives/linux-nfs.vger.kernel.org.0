Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCFD4911A1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiAQWL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 17:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiAQWL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 17:11:57 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6450C061574
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 14:11:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 161D21C1D; Mon, 17 Jan 2022 17:11:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 161D21C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642457516;
        bh=ZfmNKHBF4ifnaa2ugr8mOF84iP79u7+/iz/zRzn2kNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+seuc+4o4IM+dRNomNOi+uGVmoBvestzlxlPYSn4LJWJgOae6YYU0Bulutv5DVke
         eW8MrN8iSorKpWroFQJesWPPDjSlzg5Ppz5swjjgTcwiRrcsULFPmxe9NuOfgD+quD
         1dV2Fi3sxtYnK2w8yA9u6ReOlLT8eIoYVrv3yzDk=
Date:   Mon, 17 Jan 2022 17:11:56 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220117221156.GB3090@fieldses.org>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117220851.GA8494@marvin.atrad.com.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 18, 2022 at 08:38:52AM +1030, Jonathan Woithe wrote:
> I am happy to run further tests if it will help.  Let me know if I can do
> anything else.

I think we're good.  Thanks for the reporting.  I can reproduce just by
doing a v3 mount, getting a lock, then power-cycling the client and
waiting for it to come back up; testing a fix now.

--b.
