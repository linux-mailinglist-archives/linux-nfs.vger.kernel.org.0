Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9247D8E56
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjJ0GBM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GBL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:01:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66F1A7;
        Thu, 26 Oct 2023 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ai1+7Uz0+LGDpG22DLPpYAJJQcbhiFiYJ0vBabfPxc=; b=dE/L2GksZxwa809PvcQO9zwA8q
        9fCkKN95CUCR+Pm7WZX1/3LOJD14kCXPmETe9Xb6mgxS1U8lMwYejyQYX897SfB8nWDrJDFGXmH52
        8RiBgFGY5WJ+b3HZIUZ66+uYNC03ft4r7twSHTQa/7fdNjz8y7wYmCTFMVqj4JF72vlT5yHsOTIBm
        x29yvi6baBTNN70q2eXG2jOmT3iTN2fABboqzIoI44XTv/2te1fE1btx7qu51VEtkR7xY4jvV6DQg
        NP7Tp5StduVzFzfjJe1W9FES+duue0Y3lO/sLPuTnif9UTyP6TMUsuKci91Gp/Oa2An1r7hYscPDU
        DPRCw6RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFu9-00Fdmr-0o;
        Fri, 27 Oct 2023 06:01:09 +0000
Date:   Thu, 26 Oct 2023 23:01:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
Message-ID: <ZTtSJYVmZ/l3d9wD@infradead.org>
References: <20231026192830.21288-1-rdunlap@infradead.org>
 <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 26, 2023 at 10:46:06PM +0300, Amir Goldstein wrote:
> I would much rather turn EXPORTFS into a bool config
> and avoid the unneeded build test matrix.

Yes.  Especially given that the defaul on open by handle syscalls
require it anyway.
