Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7182C15BE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKWUIB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:01 -0500
Received: from natter.dneg.com ([193.203.89.68]:51954 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgKWUIA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id D9AAE1D992F6;
        Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ia1mRjTacRYp; Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id BDDF31D992F4;
        Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id ACA5882132F5;
        Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8GuFKPXSpPoc; Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 9063282132ED;
        Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1m4ohGwS5LnW; Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 6DDAB82132E8;
        Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
Date:   Mon, 23 Nov 2020 20:07:58 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <279437663.92157874.1606162078305.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201122030339.GF3476@fieldses.org>
References: <20201117031601.GB10526@fieldses.org> <20201120223831.GB7705@fieldses.org> <20201120224438.GC7705@fieldses.org> <5f8e9e0cb53c89a7d1c156a6799c6dbc6db96dae.camel@kernel.org> <1758069641.91412432.1605995069116.JavaMail.zimbra@dneg.com> <20201122000216.GE3476@fieldses.org> <1480128642.91427046.1606010150674.JavaMail.zimbra@dneg.com> <20201122030339.GF3476@fieldses.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: nfsd: pre/post attr is using wrong change attribute
Thread-Index: 7Dz02UZgM2RrjuJC1N5frq3V8NVryg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- On 22 Nov, 2020, at 03:03, bfields bfields@fieldses.org wrote:
>> The workload I have been looking at recently is a NFSv3 re-export of a NFSv4.2
>> mount. I can also say that it is generally when new files are being written to
>> a directory. So yes, the files and dir are changing at the time but I still
>> didn't expect to see so many repeated getattr neatly bundled together in short
>> bursts, e.g. (re-export server = 10.156.12.1, originating server 10.21.22.117).
> 
> Well, I guess the pre/post-op attributes could contribute to the
> problem, in that they could unnecessarily turn a COMMIT into
> 
>	GETATTR
>	COMMIT
>	GETATTR
> 
> And ditto for anything that modifies file or directory contents.  But
> I'd've thought some of those could have been cached.  Also it looks like
> you've got more GETATTRs than that.  Hm.

Yea, I definitely see those COMMITs surrounded by GETTATTRs with NFSv4.2... But as you say, I get way more repeat GETATTRs for the same filehandles.

I switched to a NFSv4.2 re-export of a NFSv3 server and saw the kind of thing - sometimes the wire would see 4-5 GETTATRs for the same FH in tight sequence with nothing in between. So then I started thinking.... how does nconnect work again? Because my re-export server is mounting the originating server with nconnect=16 and the flurries of repeat GETATTRs often contain a count in that ballpark.

I need to re-test without nconnect... Maybe that's how it's supposed to work and I'm just being over sensitive after this iversion issue.

Daire
