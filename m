Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8629483ACE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 04:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiADDHJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 22:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiADDHJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 22:07:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBEC061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 19:07:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 356475FFF; Mon,  3 Jan 2022 22:07:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 356475FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641265628;
        bh=Ljr74Mpy6047k/ssN9PrzYH7/OGimGYeCn3g3N4VyrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVx8ptMFHgjZSLWIZvp0MSVaiNojmqTda+I2CQY4HqV3tm/ouHd9BLxk5dJyA+jka
         Oo66XCdGWtIm4E0x568HgONX9CMxVpZkkifnG320iwSILFOV//aNxxIyLPH8h/+DqM
         TtGCzN8+AjfUc5IvvgvE+aQE62AzpY6b0U8AGxfs=
Date:   Mon, 3 Jan 2022 22:07:08 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix zero-length NFSv3 WRITEs
Message-ID: <20220104030708.GC27642@fieldses.org>
References: <164010014140.6448.18108343631467243001.stgit@klimt.1015granger.net>
 <20220103210013.GK21514@fieldses.org>
 <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAA88CD4-C692-4AEE-9A8D-F62F8CBEA2F5@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 04, 2022 at 01:12:40AM +0000, Chuck Lever III wrote:
> > but still may be worth posting
> > somewhere and making it the start of a collection of protocol-level v3
> > tests.
> 
> ... I question whether it's worth posting anything until there
> is a framework for collecting and maintaining such things. I
> do agree that the community should be working up a set of NFSv3
> specific tests like this. I like Frank's idea of making them a
> part of pynfs, fwiw.

Somebody did actually do a v3 pynfs that I never got around to merging,
it'd be worth revisiting:

	https://github.com/sthaber/pynfs

--b.
