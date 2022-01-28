Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36F49FC65
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiA1PER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 10:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiA1PEP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 10:04:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503EC061714
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jan 2022 07:04:15 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 73B73720F; Fri, 28 Jan 2022 10:04:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 73B73720F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643382255;
        bh=QDjzUwFwKV9bFhUhJG4MpMVshZ0+rssvKJUM2bxa7A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh1n3Rl/KoHwbWp4n7LIeh3+gm9kg6RqTv2YOMb/ncltCJcbPgtzoGJP3DKoQd0FQ
         RGhKYqM7nHMpSNt0yJ4/LzmMzj3TNgqn88hYLz/G9iMLASklmFk+wBU0U6UTVV4GIQ
         UwE15TNpEgebsZKemHtYHMdMRhWKEctk/QAMljRQ=
Date:   Fri, 28 Jan 2022 10:04:15 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Message-ID: <20220128150415.GE14908@fieldses.org>
References: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
 <5D07AA4C-D6ED-4E53-AFFE-D0B91B11622C@oracle.com>
 <20220127194207.GA3459@fieldses.org>
 <B5EB68E1-E930-4EE0-8994-04674F7C8C30@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B5EB68E1-E930-4EE0-8994-04674F7C8C30@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 28, 2022 at 02:02:57PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 27, 2022, at 2:42 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Thu, Jan 27, 2022 at 03:51:54PM +0000, Chuck Lever III wrote:
> >> Hi Dai-
> >> 
> >>> On Jan 26, 2022, at 4:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>> 
> >>> From RFC 7530 Section 16.34.5:
> >>> 
> >>> o  The server has not recorded an unconfirmed { v, x, c, *, * } and
> >>>  has recorded a confirmed { v, x, c, *, s }.  If the principals of
> >>>  the record and of SETCLIENTID_CONFIRM do not match, the server
> >>>  returns NFS4ERR_CLID_INUSE without removing any relevant leased
> >>>  client state, and without changing recorded callback and
> >>>  callback_ident values for client { x }.
> >>> 
> >>> The current code intents to do what the spec describes above but
> >>> it forgot to set 'old' to NULL resulting to the confirmed client
> >>> to be expired.
> >>> 
> >>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >> 
> >> On it's face, this seems like the correct thing to do.
> >> 
> >> I believe the issue was introduced in commit 2b63482185e6 ("nfsd:
> >> fix clid_inuse on mount with security change") in 2015. I can
> >> add a Fixes: tag and apply this for 5.17-rc.
> > 
> > Looks right to me too--thanks, Dai.
> 
> May I add a Reviewed-by: Bruce ?

Sure.--b.
