Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8E4CF587
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 10:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiCGJaB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 7 Mar 2022 04:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiCGJ23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Mar 2022 04:28:29 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38D58E7B
        for <linux-nfs@vger.kernel.org>; Mon,  7 Mar 2022 01:26:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D36456081110;
        Mon,  7 Mar 2022 10:25:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ePxsfqZD5BWW; Mon,  7 Mar 2022 10:25:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62F806081130;
        Mon,  7 Mar 2022 10:25:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u05cgcss8tR2; Mon,  7 Mar 2022 10:25:52 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3E2A46081110;
        Mon,  7 Mar 2022 10:25:52 +0100 (CET)
Date:   Mon, 7 Mar 2022 10:25:52 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1645735662.120362.1646645152190.JavaMail.zimbra@nod.at>
In-Reply-To: <20220217163332.GA16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217163332.GA16497@fieldses.org>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: VFS0/kQdQX7YG8wybHl+abIhZXURCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>

> On Thu, Feb 17, 2022 at 02:15:25PM +0100, Richard Weinberger wrote:
>> This is the second iteration of the NFS re-export improvement series for
>> nfs-utils.
>> While the kernel side didn't change at all and is still small,
>> the userspace side saw much more changes.
>> Please note that this is still an RFC, there is room for improvement.
>> 
>> The core idea is adding new export option: reeport=
>> Using reexport= it is possible to mark an export entry in the exports file
>> explicitly as NFS re-export and select a strategy how unique identifiers
>> should be provided.
>> "remote-devfsid" is the strategy I have proposed in my first patch,
>> I understand that this one is dangerous. But I still find it useful in some
>> situations.
>> "auto-fsidnum" and "predefined-fsidnum" are new and use a SQLite database as
>> backend to keep track of generated ids.
>> For a more detailed description see patch "exports: Implement new export option
>> reexport=".
> 
> Thanks, I'll try to take a look.

Did you find some cycles to think about which approach you prefer?

Thanks,
//richard
