Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFB61316F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJaICv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaICu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 04:02:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690ABA1B0;
        Mon, 31 Oct 2022 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KHpozk00ae95W7faIG0R8YQUTtJdirx+flYqdWXgudg=; b=4TeBhds2oGTkvujiHdQ/tqOV+m
        pH6xtECEtMBvvGgdTRg8gBH/sA7WmrJo9drTELjFm6BOpt2d8jnhz9u3zxwtAdc1FRzA1hulAtTp6
        RM7kVqQeGONeP6wQjwgJQW8SZiFOIii3pA/lHUuDVPgH1p1qqS3mOj03h1uUxPTNVCGOwZiZNuQHh
        uI8Cd35u/AH1VPP1xalvbmnOvXmUVRjl77u29wHCBJQ3mcompxL+8IAHOhJmZ9l6RErOXKrbbVOEO
        ESVLUXmmBm09TGCFw8MoRDWsiuD3yU3ACEoCKg8/VbL/dF76u71tIm8RL3Fvx8kZnRzTqAi5Z50k5
        nLK04axg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opPkv-009Oyc-LI; Mon, 31 Oct 2022 08:02:49 +0000
Date:   Mon, 31 Oct 2022 01:02:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] nfs: Move ACL xattr definitions to linux/xattr.h
Message-ID: <Y1+BKY/nrDtTqkEZ@infradead.org>
References: <TYXPR01MB1854FB85D24BDED2B490B8E6D9339@TYXPR01MB1854.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYXPR01MB1854FB85D24BDED2B490B8E6D9339@TYXPR01MB1854.jpnprd01.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 27, 2022 at 07:43:58AM +0000, Ondrej Valousek wrote:
> Hi kernel maintainers,
> 
> Please help to submit the following patch into kernel

Well, for that a proper formatted mail really helps.

And these identifiers do not belong into xattr.h.  They are a
non-sanctioned NFS side API, not a VFS API.
