Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904453729A
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiE2UsB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2UsA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 16:48:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8CF633B0
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 13:47:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 03852713C; Sun, 29 May 2022 16:47:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 03852713C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653857276;
        bh=Hx4YhOU3ypFOX2eJkkOoslfpH6BCjgnI7Wy75+JQCWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdSMu9BEdqxxvQjnQyudH/cy51tYPt9+zMB45gj9NwOSFxKfWfp/WPAYCyr+fkSpZ
         9O4d7gzYCBruSGlqopQm9psocudS2Vhh6zK2+yMujDFr0k9Phb5kyjJ4CKMU8MsNML
         IXh/rrd7tjwBJYfyp73OWUXsysjoQVsWMZ07F8/g=
Date:   Sun, 29 May 2022 16:47:55 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsv4.0/release-lockowner: Check for proper LOCKS_HELD
 response
Message-ID: <20220529204755.GC32262@fieldses.org>
References: <165384405174.3290283.7508180988614656582.stgit@morisot.1015granger.net>
 <20220529204451.GB32262@fieldses.org>
 <C3E727CC-A2F7-413E-BF5E-14DF326AC8E4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3E727CC-A2F7-413E-BF5E-14DF326AC8E4@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, May 29, 2022 at 08:46:37PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 29, 2022, at 4:44 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > Thanks, applied.
> > 
> > (Though I'd prefer new tests go under nfs4.1/server41tests/ where
> > possible.)
> 
> Even tests for NFSv4.0-only operations like RELEASE_LOCKOWNER?

D'oh!  Never mind.

--b.
