Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD012FA45
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgACQXY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:23:24 -0500
Received: from fieldses.org ([173.255.197.46]:50534 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgACQXY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jan 2020 11:23:24 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D9EB01B90; Fri,  3 Jan 2020 11:23:23 -0500 (EST)
Date:   Fri, 3 Jan 2020 11:23:23 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] nfsd: use true,false for bool variable
Message-ID: <20200103162323.GA24306@fieldses.org>
References: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577243976-46389-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying for 5.6.--b.

On Wed, Dec 25, 2019 at 11:19:33AM +0800, zhengbin wrote:
> zhengbin (3):
>   nfsd: use true,false for bool variable in vfs.c
>   nfsd: use true,false for bool variable in nfs4proc.c
>   nfsd: use true,false for bool variable in nfssvc.c
> 
>  fs/nfsd/nfs4proc.c | 4 ++--
>  fs/nfsd/nfssvc.c   | 6 +++---
>  fs/nfsd/vfs.c      | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> --
> 2.7.4
