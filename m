Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCE2D59D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2Gk4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 02:40:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2Gk4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q8I3wEiJkDHORPoj1XM3CzoUhFotzPx7/2KxT0Xa20s=; b=B/i85hh+8AbNSg+0/l4EmxUV0
        sYNPihwnxx3zPoqLvK2N4IIgBRtt/XWolgP7vJoe8Ifxocx/wlRWhxQHUkYpH+fVPP2K8mxpigLKl
        T1SrDL7lKV1AMR17KjWVri+sIAUVslggyMP+LrIY1djH7+hz8aErWPfqbGYWafxpE/KwRnvZ6yk2M
        gkHyLVZHEFpNoPY4D7xxrQjXWNQZN75dqLvRVkP69hc9hJoqndPryoRYDvCbFxdQRLcaXRve0zbQw
        3JDU3MdencZ7PbmPANyo4uXlghN8/gvgZ+3r04Q7wQLppuAnD45PR4yyS8/1KMg7PrPiPdXyq/6jD
        Osox+UNUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVsGd-0007H3-JK; Wed, 29 May 2019 06:40:55 +0000
Date:   Tue, 28 May 2019 23:40:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 00/12] for-5.3 NFS/RDMA patches for review
Message-ID: <20190529064055.GA10492@infradead.org>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 28, 2019 at 02:20:50PM -0400, Chuck Lever wrote:
> This is a series of fixes and architectural changes that should
> improve robustness and result in better scalability of NFS/RDMA.
> I'm sure one or two of these could be broken down a little more,
> comments welcome.

Just curious, do you have any performance numbers.
