Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7285314D7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiEWObf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiEWObc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 10:31:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BE19C2E
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 07:31:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2B7B77031; Mon, 23 May 2022 10:31:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2B7B77031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653316290;
        bh=1KJU4+fgdQ6BXXQww+YoAsKJ+mMhMqSPtrcIuvr+OPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJxmJ2YPrHvpOvCo+b2Ur+k3h6ScZNlwoW1fS9f+ThXTc+0HmVnS2APxD/vgPQ3HQ
         ko9+kKtY4TLkloF8mn2MYALQGT5xOuSqSnHN0hit8/Em6URU2stSMId+HBxGy0tGap
         EmJ/Q25QqWIhNdFTHm9VW1jUn8igwP5mA+9FNxA4=
Date:   Mon, 23 May 2022 10:31:30 -0400
From:   bfields <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Message-ID: <20220523143130.GC24163@fieldses.org>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502161713.GI30550@fieldses.org>
 <1149772405.87856.1653292425664.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149772405.87856.1653292425664.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 23, 2022 at 09:53:45AM +0200, Richard Weinberger wrote:
> > Von: "bfields" <bfields@fieldses.org>
> > Anyway, basically sounds reasonable to me.  I'll try to give it a proper
> > review sometime, feel free to bug me if I don't get to it in a week or
> > so.
> 
> *kind ping* :-)

Anyway, yeah, still planning to, but I have a few other things I wanted
to get out of the way first.

--b.
