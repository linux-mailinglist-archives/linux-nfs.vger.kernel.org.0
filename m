Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7933D31B0BA
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNOXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 09:23:44 -0500
Received: from natter.dneg.com ([193.203.89.68]:46336 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNOXo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Feb 2021 09:23:44 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2021 09:23:43 EST
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 6064D1FC4042;
        Sun, 14 Feb 2021 14:13:38 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ps7792vXtIcl; Sun, 14 Feb 2021 14:13:38 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 43FF91FC20B7;
        Sun, 14 Feb 2021 14:13:38 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 34D5581B36EE;
        Sun, 14 Feb 2021 14:13:38 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id arbstbi_Rv9c; Sun, 14 Feb 2021 14:13:37 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id D61F081B36F0;
        Sun, 14 Feb 2021 14:13:37 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zrozimbrai.dneg.com
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gb6ZiYKPSq-1; Sun, 14 Feb 2021 14:13:37 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 94F5B81B36EE;
        Sun, 14 Feb 2021 14:13:37 +0000 (GMT)
Date:   Sun, 14 Feb 2021 14:13:36 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Message-ID: <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com>
In-Reply-To: <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org> <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com> <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com> <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on
 the server
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - GC78 (Linux)/9.0.0_GA_3990)
Thread-Topic: SUNRPC: Use TCP_CORK to optimise send performance on the server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgMgY7/PB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 13 Feb, 2021, at 23:30, Chuck Lever chuck.lever@oracle.com wrote:

>> I don't have a performance system to measure the improvement
>> accurately.
> 
> Then let's have Daire try it out, if possible.

I'm happy to test it out on one of our 2 x 40G NFS servers with 100 x 1G clients (but it's trickier to patch the clients too atm).

Just so I'm clear, this is in addition to Chuck's "Handle TCP socket sends with kernel_sendpage() again" patch from bz #209439 (which I think is now in 5.11 rc)? Or you want to see what this patch looks like on it's own without that (e.g. v5.10)?

Daire
