Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92D610A98
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEAQHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 12:07:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfEAQHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 May 2019 12:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BmsOCWOL+giQZS37PMaeMlSUUcjDPMjoPtCe2tkT52w=; b=lhopa3nnuzOqrafzg9Kkz+1vj
        zRcrs1JNVduVklckswJUOJDeGXueBDJQqfe1bSXKFFYz+EsgYkSK7QTDiq3dyTN5Zu8rRkrb/ofe5
        iy9J+NYQ3/g3/e7Zat5sBySIWPF6fPyuj2jZ6mPvZrOwkVDcX0us/ysxTVD3wQzLoAtP/7/+Ys2/w
        pPThqLdy0UCS/EfbjlATohXf8BTo98B+eFvbYkSIsp0MfV8tc20cD0hvWpavUXG2l7N44tjLh3AQv
        JF2JvKvOFoXfDZCheLkQDFGqx0qyb9unfIa7+drB+xOUy2K53E4eWNNsYhLcV5F7gFtvRxhMTTIhR
        NT/oC7BdA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrlJ-0008Km-QG; Wed, 01 May 2019 16:07:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: fix filler_t callback type mismatches
Date:   Wed,  1 May 2019 12:06:32 -0400
Message-Id: <20190501160636.30841-1-hch@lst.de>
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

