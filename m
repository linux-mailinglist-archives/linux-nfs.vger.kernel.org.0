Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4332D4EA
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCDOHP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 09:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhCDOG6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 09:06:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F84C061574
        for <linux-nfs@vger.kernel.org>; Thu,  4 Mar 2021 06:06:17 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 679FB2501; Thu,  4 Mar 2021 09:06:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 679FB2501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614866777;
        bh=AHcKltRMjiboF0SoVx/4lrog17KGSq7xUS6DJ7b4Hrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJDwgKRnM1Mvdb1XwLkSxcsJfOCo4vmcqSi9AKKbO9eyhzHfHKZ+AogfHhQm9xxms
         bMJZbe2TFvsTK83Uxp+nqJcVDlitCp5XUxrE/WpwgKgIqrd46fczqTaOLIE6a99fnM
         KDft64DjfQpbo0rkac4pdN+RFcQJxTyd8S+p/0b0=
Date:   Thu, 4 Mar 2021 09:06:17 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Message-ID: <20210304140617.GB17512@fieldses.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
 <20210303221730.GH3949@fieldses.org>
 <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 04, 2021 at 08:57:28AM -0500, Steve Dickson wrote:
> Personally I see this is the first step away from V3... 
> 
> So what we don't need is all that RPC code, all the different mounting
> versions... no RPC code at all,  which also means no need for libtirpc... 
> That is a lot of code that goes away, which I think is a good thing.

libtirpc is a shared library, it'll still be loaded as long as anyone
needs it, and I'm not convinced we'll be able to get rid of all users.

> I never thought it was a good idea to have mountd process
> the v4 upcalls... I always thought it should be a different
> deamon... and now we have one.
> 
> A simple daemon that only processes v4 upcalls.

I really do get the appeal, I've always liked the idea too.

I'm not sure it's bringing us a real practical advantage at this point,
compared to rpc.mountd, which can act either as a daemon that only
processes v4 upcalls or can do both, depending on how you start it.

--b.
