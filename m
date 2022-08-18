Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1634598C62
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHRTKy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbiHRTKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 15:10:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA4C6530
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QkhVZr+aO+Dh1ZHYIdodYhck3k3ceJcnMSWrF6yHBF8=; b=LENFJKEaIMK5vQevRKgttpLMia
        40CDGwN8IxzVGAE+aip2sRiY8vr2gz5UP/BuivHi7VrigQNd1UbbWWUYhGqjCV125KkdFDKDZCeV5
        4QDvGAKKW1onZWJvkOuZauAJ//wAzewNH4bGYu5t5Kso9IBCfOoOLoiRVPUUBrAKenClyeYq22BpN
        0WmOPwD4Wzq3M+Sv6LpBdBLnDqzESEC7fEvMfry5TQx3OC93fv1D4LxYm8FgXGVpRUPDE8R49tNLk
        CNyD09TTvHTIVv7DyZRBjEktn57IpxnmAzORMTL9pbWQ8IITJm8QIIex5KJ74dDbtu9A0hvs3CP8O
        ild9xe+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOkuh-005nhV-AD;
        Thu, 18 Aug 2022 19:10:43 +0000
Date:   Thu, 18 Aug 2022 20:10:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.2 fix problems with __nfs42_ssc_open
Message-ID: <Yv6Os+7Me0NhooWe@ZenIV>
References: <20220818190705.47722-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818190705.47722-1-olga.kornievskaia@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 18, 2022 at 03:07:05PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> A destination server while doing a COPY shouldn't accept using the
> passed in filehandle if its not a regular filehandle.
> 
> If alloc_file_pseudo() has failed, we need to decrement a reference
> on the newly created inode, otherwise it leaks.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: ec4b092508982 ("NFS: inter ssc open")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Looks sane from the VFS interactions POV...
