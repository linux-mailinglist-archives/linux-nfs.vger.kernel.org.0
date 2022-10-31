Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476A61316E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 09:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJaIBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaIBy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 04:01:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287EA1B0
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EPwYnae6CoSvP1lGvYJshZzju/M1JURZ1ENoAHWd2sE=; b=Cq3oBhhyq8lFV2zh/q58UKvuGZ
        M5sd6KrxBt8mcaqqw9CESewfMDuRZJzhZvexUXwKYUNjs+mom8/PV2YGTMrrThQrmc20DhBq3V5Pb
        i0CmVOJJiWQ13b+7bgaZBN4hf2ZDbR2aNxi1dBXw1MgM1M8hKJvkCyxYYXbGWKQehI9jLCgJu2XAJ
        Dvt0DDycepsAQCCu35D8g80e23Whb3WU+1kOXX+3Qi4J0Dhl6lkjgDBOhpavDPS6HBivCtRXzOnLE
        JGEwPkxtxvGdvwrUVEFTphDAPwsHIw8mQc4ohp+M+cmB9v+a1gshehiFyhP4LTNtLzmqV+41915/1
        13VcTszg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opPjx-009OKz-Kq; Mon, 31 Oct 2022 08:01:49 +0000
Date:   Mon, 31 Oct 2022 01:01:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
Message-ID: <Y1+A7XzxKbRCCH4z@infradead.org>
References: <20221026143518.250122-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026143518.250122-1-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 26, 2022 at 10:35:18AM -0400, Jeff Layton wrote:
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Open file cache.
> - *
> - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + * The NFSD open file cache.

ЅPDX identifiers do not replace copyright statements.  So while adding
one is agood idea, dropping the copyright notice (if that counts as one)
is not.
