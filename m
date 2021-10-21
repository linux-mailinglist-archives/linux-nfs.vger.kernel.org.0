Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA02436393
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUN6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUN6k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 09:58:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE824C0613B9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 06:56:24 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C0CA16EB3; Thu, 21 Oct 2021 09:56:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C0CA16EB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634824583;
        bh=0lOw+0sX3aFs44RULPeR1wPR9+VLxsT9TZYWGyYonMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWcniIS15JsnpHMnjEzJQgUp391gu/aa9mTQWDAZMNfng4imq5lOM3qPGewDmOcWZ
         gmzCDLIq3fGmJBgSR/7iFKhdSsg+fKbYGALfH6FLz71u0Sw3MY7fEPggXClwiw4eXj
         o7WsGrKqGbwdN2OK0RonCfdV/52GPb2/1oXytlUA=
Date:   Thu, 21 Oct 2021 09:56:23 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211021135623.GA25711@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
 <20211020181512.GE597@fieldses.org>
 <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 07:04:53PM +0000, Chuck Lever III wrote:
> Not if the s2sc policy setting is on each export.

I don't want anyone investing time in writing code to enable this
configuration for the kernel and mountd and exportfs, documenting it,
explaining it to users repeatedly, etc., all for a problem we're like to
eventually declare not a problem.

--b.
