Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E07826E9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Aug 2023 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjHUKSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 21 Aug 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHUKSe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Aug 2023 06:18:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF90C2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Aug 2023 03:18:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-wqiF68MgN6SF-J6xIfBlHw-1; Mon, 21 Aug 2023 11:18:26 +0100
X-MC-Unique: wqiF68MgN6SF-J6xIfBlHw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Aug
 2023 11:18:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Aug 2023 11:18:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Elena Reshetova" <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Alexey Gladkov" <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Yu Zhao" <yuzhao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2] creds: Convert cred.usage to refcount_t
Thread-Topic: [PATCH v2] creds: Convert cred.usage to refcount_t
Thread-Index: AQHZ0hIjCu0dtWFxxUKez0i3A14O7q/0jIjg
Date:   Mon, 21 Aug 2023 10:18:13 +0000
Message-ID: <d2bb7f4a8b214e1f8d50176e6d94b118@AcuMS.aculab.com>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
 <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
 <202308181317.66E6C9A5@keescook>
In-Reply-To: <202308181317.66E6C9A5@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Kees Cook
> Sent: Friday, August 18, 2023 9:25 PM
> 
> On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
> > [...]
> > extra checks (supposedly) compile down to nothing. It should be possible
> > to build alternate refcount_t handling functions that are just wrappers
> > around atomic_t with no extra checks, for folks who want to really run
> > "fast and loose".
> 
> No -- there's no benefit for this. We already did all this work years
> ago with the fast vs full break-down. All that got tossed out since it
> didn't matter. We did all the performance benchmarking and there was no
> meaningful difference -- refcount _is_ atomic with an added check that
> is branch-predicted away.

Hmmm IIRC recent Intel x86 cpu never do static branch prediction.
So you can't avoid mis-predicted branches in cold code.

	David

> Peter Zijlstra and Will Deacon spent a lot of
> time making it run smoothly. :)
> 
> -Kees
> 
> --
> Kees Cook

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

