Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB211711
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 12:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBKUY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 06:20:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKUY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 May 2019 06:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BZ3UM29LlTMvKG0ZuhdqBuLexLkqyCTHtEkADaQBuXY=; b=NgebHSNwQgTcd2GkI6djqj9ph
        KvuJh3eTipixESblBd7Dedi7npgGxAXtWGg1jtIv0ND9AX1BNT5S/E/gaGelpZan04UJGJTOPYxMY
        Vm87HfW7NwRqmK67bzlth2PpbH4rNf4n3iY74cE0RSohIwQXbLYJkZTm1O7nia96VdK4Xz9ogiVBB
        TBYbYTGvgtrri4kVLQfd/HxU5K1PBpkzKMfrlleKxCN2/yFBffRgua2vE3O2BYkxcG3gmDU7FKjev
        tjBfLaDLbPtYludmF9v0L4P3r4H7SUY0YWLaiaoLTjj49x9Eq35Lh0OK8KXH5OTsgGBNrcUH6rhNm
        hAeVlE67w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hM8p6-0000QX-6a; Thu, 02 May 2019 10:20:16 +0000
Date:   Thu, 2 May 2019 03:20:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/4] 9p: pass the correct prototype to read_cache_page
Message-ID: <20190502102015.GC8099@bombadil.infradead.org>
References: <20190501160636.30841-1-hch@lst.de>
 <20190501173443.GA19969@lst.de>
 <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 02, 2019 at 12:08:29AM -0600, William Kucharski wrote:
> 3) Patch 5/4?

That's a relatively common notation when an extra patch is needed to fix
something after a series has been sent ;-)
