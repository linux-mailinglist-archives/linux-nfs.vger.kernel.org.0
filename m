Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB25452937
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 05:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbhKPEu4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 23:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbhKPEuy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 23:50:54 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF2C27F600;
        Mon, 15 Nov 2021 17:53:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A0CC5AA2; Mon, 15 Nov 2021 20:53:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A0CC5AA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637027612;
        bh=0g47k9qD4oPexF9D23ijYzgICWp4ZLsTLeLSTEl2r9A=;
        h=Date:To:Cc:Subject:From:From;
        b=x1jiHvlzwkiSMlY9nu6lu2HyiNf7hEV321TZdF4rS2KmTOWsIK+4KWiwDrneH+9wk
         FZUdAkgpYD1BPkiuZ9u2vCJXNbyiCgCdiRwO68XH3cHQDd6gMStrBaM7wFbwYNNSTZ
         BHZV/X6oMSr5DRoN66zQAApBmNAdHBWD0a0WOX3s=
Date:   Mon, 15 Nov 2021 20:53:32 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd bugfix for 5.16
Message-ID: <20211116015332.GJ23884@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-1

This is just one bugfix for a buffer overflow in knfsd's xdr decoding.

--b.

Chuck Lever (1):
      NFSD: Fix exposure in nfsd4_decode_bitmap()

 fs/nfsd/nfs4xdr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
