Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF73251B77
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHYOzY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Aug 2020 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYOzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Aug 2020 10:55:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DBC061756;
        Tue, 25 Aug 2020 07:55:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62D2B133F9EED;
        Tue, 25 Aug 2020 07:38:33 -0700 (PDT)
Date:   Tue, 25 Aug 2020 07:55:18 -0700 (PDT)
Message-Id: <20200825.075518.2274392566164051801.davem@davemloft.net>
To:     joe@perches.com
Cc:     trivial@kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, bfields@fieldses.org,
        chuck.lever@oracle.com, kuba@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/29] sunrpc: Avoid comma separated statements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <6adb266d5efe8e1ab95adfcdc1ff8240e99e2c37.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
        <6adb266d5efe8e1ab95adfcdc1ff8240e99e2c37.1598331149.git.joe@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Aug 2020 07:38:33 -0700 (PDT)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 24 Aug 2020 21:56:25 -0700

> Use semicolons and braces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
