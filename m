Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C578A8E3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjH1JZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjH1JZG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 05:25:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A0118
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 02:25:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 771796732D; Mon, 28 Aug 2023 11:24:56 +0200 (CEST)
Date:   Mon, 28 Aug 2023 11:24:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tom Haynes <loghyr@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSD: da_addr_body missing in some GETDEVICEINFO
 replies
Message-ID: <20230828092456.GA31142@lst.de>
References: <169219563023.7562.16862946984900949137.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169219563023.7562.16862946984900949137.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
