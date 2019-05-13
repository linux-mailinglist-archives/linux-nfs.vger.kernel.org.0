Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B61B71F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfEMNgY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 09:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfEMNgY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 May 2019 09:36:24 -0400
Received: from vulcan.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F183208C2;
        Mon, 13 May 2019 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557754583;
        bh=KvQDNwu3bULD+Ywks8ZVEWJR/s9gauUg+Iqux0u6+Nc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r8AIQNmm1hKdp3IMk/Do7SlsNWzd6EdiSIZWPezRYQZNGDoOOy/kkOcxwzHFR6jj2
         p8aTRCxU/xLif/TvDG/P9up5MRy3u1ytXpTeloaPNU6gO47vu97WEyvoi2orLwtrrb
         pj7znLXDqTcmRKPmkEHeUcUWq3CuaB2uxirDZdhY=
Message-ID: <0d422bbcce15e44a4608cced0a569585c75ccd9a.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix two bugs CB_NOTIFY_LOCK failing to wake a
 water
From:   Jeff Layton <jlayton@kernel.org>
To:     Yihao Wu <wuyihao@linux.alibaba.com>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, caspar@linux.alibaba.com
Date:   Mon, 13 May 2019 09:36:21 -0400
In-Reply-To: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
References: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-05-13 at 14:49 +0800, Yihao Wu wrote:
> This patch set fix bugs related to CB_NOTIFY_LOCK. These bugs cause
> poor performance in locking operation. And this patchset should also fix
> the failure when running xfstests generic/089 on a NFSv4.1 filesystem.
> 
> Yihao Wu (2):
>   NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails to wake a waiter
>   NFSv4.1: Fix bug only first CB_NOTIFY_LOCK is handled
> 
>  fs/nfs/nfs4proc.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 

Looks good to me. Nice catch, btw!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

