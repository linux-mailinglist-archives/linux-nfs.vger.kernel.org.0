Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43922B85
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 07:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfETF60 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 01:58:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfETF60 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 May 2019 01:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jGTww2FTm6wjbIUY6D49ZjWpoiq21E9raY62orB2tKA=; b=E++Ia8pj+gBgCi43NyPE2MPeh
        Zq6NmIBTQmvgWzeS0EQ9KqMUsZ17eo2vwCRLCF64hVZVZIWIuHx4GAO0Ryyc8fDevPlfliA4WFobz
        HQp44q1A3PVRJQgqwnbhKm6SFVi8lSBmolbpXhfGc8LSEOIW92QWh1KL4WtepfxJDfKTHNJMBUz6j
        Q7nom0JqHFMTN4CWQwPAA7FfP3BNdzfoVp+ORN8f+36EMh9ySRdEjtstN4Kv767jJ69OW2XBmaSDk
        bVZkcPvLylFeecs/qBgxPAfmAQBCDBqEKXN9igzWleFMqyjSFgsNg1JSOZiSwS66URY44LHm9jWal
        RR3LBF7LQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbJY-0006DS-7G; Mon, 20 May 2019 05:58:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: fix filler_t callback type mismatches v2
Date:   Mon, 20 May 2019 07:57:27 +0200
Message-Id: <20190520055731.24538-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Casting mapping->a_ops->readpage to filler_t causes an indirect call
type mismatch with Control-Flow Integrity checking. This change fixes
the mismatch in read_cache_page_gfp and read_mapping_page by adding
using a NULL filler argument as an indication to call ->readpage
directly, and by passing the right parameter callbacks in nfs and jffs2.

Changes since v1:
 - add the 9p patch to the series
 - drop the nfs patch that has been merged
