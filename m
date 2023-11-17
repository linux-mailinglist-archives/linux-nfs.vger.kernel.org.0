Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC007EF347
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKQNEg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 08:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQNEf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 08:04:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057FE126
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qaw9r8iiBDC3WOyWJ5NrMM6F2x
        Aaq4TV0R8JVBh8D9nlAxjP/Gag4echSaTL2LbI/+3Zeplkz9Vdnqs539WAu71+V1Pi6zQEtCyLxKg
        Qu+KGA7Jx13zgiCFV54bjTJdad24rsPRlIfHCG5o/XdKcCFLqeNGxyT/GWOrCgX718kVO4QYRIGGH
        qrCMrkjS1ZT70f2IsfvKKJ8YGRcUmHOXPx0AH+CgnUEi1VwqxPdBAx7cvrv1EoAll6Nxvf3QLcOWU
        8zxRETOc2EHg8Eu8rPpTCrF349fzY6MLmrgfAi/diKxI2Nd/b6z0fwJNdX2pHWge4TzmEtnTu/zwm
        K5OVcH6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r3yWM-006bSE-1K;
        Fri, 17 Nov 2023 13:04:30 +0000
Date:   Fri, 17 Nov 2023 05:04:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] NFS: drop unused nfs_direct_req bytes_left
Message-ID: <ZVdk3hXdnmRaDfDN@infradead.org>
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
 <0bdf152bc69f7dcf91c9c70ffcbab92ac03682f0.1700220277.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bdf152bc69f7dcf91c9c70ffcbab92ac03682f0.1700220277.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
