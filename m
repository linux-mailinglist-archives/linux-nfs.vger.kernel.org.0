Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E34D0B11
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 23:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiCGWaU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Mar 2022 17:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiCGWaU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Mar 2022 17:30:20 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CF13E1D
        for <linux-nfs@vger.kernel.org>; Mon,  7 Mar 2022 14:29:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4A8BB7114; Mon,  7 Mar 2022 17:29:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4A8BB7114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646692164;
        bh=oQMAlekP2pW+EauB9I6PHYcrXMH2IC+9ECRciXDYrzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=An0bQGLRRkKsGiuq4QxW8ZhDi7le8vtPD4L6DafExcHL9I6XSHclDZ5qeSt9nPdPJ
         7iNQ5YtgNaAh7T5gHEdBF4BBkkqGg43HyaoVCxnYWtybCGS1HEEgje99QSiKO5BGiu
         7jcLpFdr8GkK/xXlc4sh17gbZG5aH2Izprz4eV/Q=
Date:   Mon, 7 Mar 2022 17:29:24 -0500
From:   bfields <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
Message-ID: <20220307222924.GD24816@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217163332.GA16497@fieldses.org>
 <1645735662.120362.1646645152190.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645735662.120362.1646645152190.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 07, 2022 at 10:25:52AM +0100, Richard Weinberger wrote:
> Did you find some cycles to think about which approach you prefer?

I haven't.  I'll try to take a look in the next couple days.  Thanks for
the reminder.

--b.
