Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814D522590
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiEJUeW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 10 May 2022 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiEJUdG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 16:33:06 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0B2555A4
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 13:32:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 233DF60CEF20;
        Tue, 10 May 2022 22:32:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FcMWAzoFNEp8; Tue, 10 May 2022 22:32:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AA1F560F6B8F;
        Tue, 10 May 2022 22:32:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IuobuAVBEIGf; Tue, 10 May 2022 22:32:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7F6AA60CEF20;
        Tue, 10 May 2022 22:32:54 +0200 (CEST)
Date:   Tue, 10 May 2022 22:32:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Steve Dickson <steved@redhat.com>
Cc:     chuck lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>, bfields <bfields@fieldses.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1222338034.49423.1652214774308.JavaMail.zimbra@nod.at>
In-Reply-To: <8d8c0e43-5607-ca9b-d21e-b7599c5d7186@redhat.com>
References: <20220502085045.13038-1-richard@nod.at> <20220502085045.13038-2-richard@nod.at> <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com> <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com> <fe2ecc50-4036-2922-28d6-e2f139408961@redhat.com> <650BB9E2-7CBD-4A38-92AD-C2AC82DDBD8C@oracle.com> <8d8c0e43-5607-ca9b-d21e-b7599c5d7186@redhat.com>
Subject: Re: [PATCH 1/5] Implement reexport helper library
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Implement reexport helper library
Thread-Index: X95OfenBN+5jgp1bR5YnZfZeIc/8ew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Steve Dickson" <steved@redhat.com>
>> I'll bite. What is the added footprint of this patch
>> series? I didn't think there was a new library dependency
>> or anything like that...
> Well mountd is now using an database and there
> is a static reexport lib that a number daemons
> and command like with...
> 
> In the I would like to bring (or be able) bring the
> foot print of nfs-utils down so it will be more container
> friendly... IDK if is possible... but that is the idea.

Getting rid of the SQLite dependency shouldn't be a big deal.
I'm already working on a plugin interface for reexport such that
a sysadmin can easily use other databases than SQLite.

E.g. in nfs.conf you point to a shared library which hides all the
database stuff from you.

Thanks,
//richard
