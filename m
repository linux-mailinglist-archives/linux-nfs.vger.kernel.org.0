Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC042C369
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhJMOhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbhJMOhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 10:37:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A7EC061570
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 07:35:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 362656C87; Wed, 13 Oct 2021 10:35:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 362656C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634135701;
        bh=yR/SCGkuPnJSyXxvtiRHgdGFB//yGxEhhNca1KNyyCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JurlbnXr0z22aw4L6BcYTobV6Ea3gQx7XEfJ9qc3WDRZK8jvq8mDvnm4A8y60PVrh
         RuwBqxWSxumYa621dik3bclHDXON2wNyZDcZolhS11u1UJ4YevZ86liOtZsEvsMXPH
         7ORyEQkkjngbzjcRWn5u0AyEbcDsT1/PN/dtTs9Q=
Date:   Wed, 13 Oct 2021 10:35:01 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] Update synopsis of .pc_decode callback
Message-ID: <20211013143501.GB6260@fieldses.org>
References: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
 <20211013143125.GA6260@fieldses.org>
 <4F65A128-3DCC-4E8A-A7EE-5143152095C5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F65A128-3DCC-4E8A-A7EE-5143152095C5@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 02:33:46PM +0000, Chuck Lever III wrote:
> 
> 
> > On Oct 13, 2021, at 10:31 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Tue, Oct 12, 2021 at 11:57:15AM -0400, Chuck Lever wrote:
> >> As we discussed many moons ago, here are clean-up patches that
> >> modernize the .pc_decode callback's synopsis, based on the
> >> recent XDR overhaul work.
> > 
> > Looks sensible to me.
> > 
> > Applying pending some testing.
> 
> Thanks, Bruce.
> 
> I have similar patches for .pc_encode. Do you want to test those
> at the same time?

Sure, up to you.

(Not doing anything fancy, just my routine chton/xfstests/pynfs run).

--b.
