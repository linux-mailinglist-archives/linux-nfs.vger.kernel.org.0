Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1D521C98
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiEJOn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 10 May 2022 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbiEJOmR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 10:42:17 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20552DFF73
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 06:59:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5AC6E614E2FD;
        Tue, 10 May 2022 15:59:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aEJNozZixWx1; Tue, 10 May 2022 15:59:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 774EF616B590;
        Tue, 10 May 2022 15:59:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id unvB_OUHAWhb; Tue, 10 May 2022 15:59:35 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4AA37611C99E;
        Tue, 10 May 2022 15:59:35 +0200 (CEST)
Date:   Tue, 10 May 2022 15:59:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chuck lever <chuck.lever@oracle.com>
Cc:     Steve Dickson <steved@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>, bfields <bfields@fieldses.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <688492887.48288.1652191175099.JavaMail.zimbra@nod.at>
In-Reply-To: <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
References: <20220502085045.13038-1-richard@nod.at> <20220502085045.13038-2-richard@nod.at> <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com> <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
Subject: Re: [PATCH 1/5] Implement reexport helper library
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Implement reexport helper library
Thread-Index: AQHYXgHgoneWG2g3iEC82B/y61YHaq0YKM4AgAAEiIAmRXdifQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chuck lever" <chuck.lever@oracle.com>
> An: "Steve Dickson" <steved@redhat.com>
> CC: "richard" <richard@nod.at>, "linux-nfs" <linux-nfs@vger.kernel.org>, "david" <david@sigma-star.at>, "bfields"
> <bfields@fieldses.org>, "luis turcitu" <luis.turcitu@appsbroker.com>, "david young" <david.young@appsbroker.com>,
> "david oberhollenzer" <david.oberhollenzer@sigma-star.at>, "trond myklebust" <trond.myklebust@hammerspace.com>, "anna
> schumaker" <anna.schumaker@netapp.com>, "chris chilvers" <chris.chilvers@appsbroker.com>
> Gesendet: Dienstag, 10. Mai 2022 15:48:49
> Betreff: Re: [PATCH 1/5] Implement reexport helper library

>> On May 10, 2022, at 9:32 AM, Steve Dickson <steved@redhat.com> wrote:
>> 
>> Hello,
>> 
>> On 5/2/22 4:50 AM, Richard Weinberger wrote:
>>> This internal library contains code that will be used by various
>>> tools within the nfs-utils package to deal better with NFS re-export,
>>> especially cross mounts.
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  configure.ac                 |  12 ++
>>>  support/Makefile.am          |   4 +
>>>  support/reexport/Makefile.am |   6 +
>>>  support/reexport/reexport.c  | 285 +++++++++++++++++++++++++++++++++++
>>>  support/reexport/reexport.h  |  39 +++++
>>>  5 files changed, 346 insertions(+)
>>>  create mode 100644 support/reexport/Makefile.am
>>>  create mode 100644 support/reexport/reexport.c
>>>  create mode 100644 support/reexport/reexport.h
>>> diff --git a/configure.ac b/configure.ac
>>> index 93626d62..86bf8ba9 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
>>>  	fi
>>>  	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" = "yes" ])
>>>  +AC_ARG_ENABLE(reexport,
>>> +	[AC_HELP_STRING([--enable-reexport],
>>> +			[enable support for re-exporting NFS mounts  @<:@default=no@:>@])],
>>> +	enable_reexport=$enableval,
>>> +	enable_reexport="no")
>>> +	if test "$enable_reexport" = yes; then
>>> +		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>>> +                          [Define this if you want NFS re-export support
>>> compiled in])
>>> +	fi
>>> +	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" = "yes" ])
>>> +
>> To get this moving I'm going to add a --disable-reexport flag
> 
> Hi Steve, no-one has given a reason why disabling support
> for re-exports would be necessary. Therefore, can't this
> switch just be removed?

Sure can we remove it. My idea was that new/experimental features should be opt-in.

Thanks,
//richard
