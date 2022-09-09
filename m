Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841285B38F6
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiIIN2N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiIIN2L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 09:28:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092561398A0
        for <linux-nfs@vger.kernel.org>; Fri,  9 Sep 2022 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IEnyzP6QTHsSqExzVUdTq57V2BNxCpUBqDnnf0HInY4=; b=1oJXTIETXtfNCKfGGbg+V7CpUg
        SQARvrvbmOwOuKAmdj2VqQ9Wdo3VNTuToDm7tnjAZVySSfiVxn9xKUhlIlhgZ1E0MG40IVk7ZZses
        XKCuqfzxOEERqEhVVp0fX1tGwjwayj7qkdp2JXJ8ellfh5gIdR8gclpfWbkP+vBSnvBrpIiBQJQZH
        HMIQU/PA3bCofjcKV+6xsBhIUxd1ICWOK1vhOD7orcTgxx8DbdAlaE5i+9FX5lfFJSDvAjBcTEdfG
        rFO7qPKViE4FGDDEJy9ZfTGxHK9sKTRK5+40yeQsL0ojfv8wXydcNOoKWeROMisdmKhkeZOVxd12I
        Mq1W/wnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWe34-00GK84-AP; Fri, 09 Sep 2022 13:27:58 +0000
Date:   Fri, 9 Sep 2022 06:27:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] nfs-blkmapd: Fix the error status when nfs-blkmapd stops
Message-ID: <Yxs/Xh015+ADSo1/@infradead.org>
References: <ae07856f-ef34-270e-91b2-9364fdcd6563@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae07856f-ef34-270e-91b2-9364fdcd6563@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 01, 2022 at 09:44:08PM +0800, zhanchengbin wrote:
> The systemctl stop nfs-blkmap.service will sends the SIGTERM signal
> to the nfs-blkmap.service first.If the process fails to be stopped,
> it sends the SIGKILL signal again to kill the process.
> However, exit(1) is executed in the SIGTERM processing function of
> nfs-blkmap.service. As a result, systemd receives an error message
> indicating that nfs-blkmap.service failed.
> "Active: failed" is displayed when the systemctl status
> nfs-blkmap.service command is executed.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
